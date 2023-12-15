Return-Path: <linux-kernel+bounces-1282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AF2814CDA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB3B282495
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EBB3DB8B;
	Fri, 15 Dec 2023 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZdGiigm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273153DB81
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6BFC433C8;
	Fri, 15 Dec 2023 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702657223;
	bh=Cukggf5RuYjVp8uLz9Wr3r+uW+U+//IFSZh8tKw2rfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZdGiigm9hf8PGZmgjujy6TgqZShWc7sm9yEQ3b0Rz074zkJ4wsqA+iulU6FMlJjg
	 Nlayqgjgv/BzyS0xsJnfUFAspGZLMmZoVxVH+WRoCamW4YQtXw+HZRQKKvZpUXMmqr
	 7Rg4kssuffZvRvZsFv76vVY3BLwPvfsusjZYhBqs=
Date: Fri, 15 Dec 2023 17:20:21 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: greybus-dev@lists.linaro.org, johan@kernel.org, elder@kernel.org,
	linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
	yujie.liu@intel.com
Subject: Re: [PATCH V2 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Message-ID: <2023121559-overfed-kisser-3923@gregkh>
References: <20231211065420.213664-1-ayushdevel1325@gmail.com>
 <20231211065420.213664-2-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211065420.213664-2-ayushdevel1325@gmail.com>

On Mon, Dec 11, 2023 at 12:24:18PM +0530, Ayush Singh wrote:
> Make gb-beagleplay greybus spec compliant by moving cport information to
> transport layer instead of using `header->pad` bytes.
> 
> Greybus HDLC frame now has the following payload:
> 1. le16 cport
> 2. gb_operation_msg_hdr msg_header
> 3. u8 *msg_payload
> 
> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  drivers/greybus/gb-beagleplay.c | 55 ++++++++++++++++++++++++---------
>  1 file changed, 41 insertions(+), 14 deletions(-)

This doesn't apply against my char-misc-next branch at all, what did you
generate it against?

thanks,

greg k-h

