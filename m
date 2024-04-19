Return-Path: <linux-kernel+bounces-151076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D9C8AA8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4710FB21675
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FD53B298;
	Fri, 19 Apr 2024 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tVH16264"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7619473;
	Fri, 19 Apr 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713509898; cv=none; b=CYLIA0jqDxF6/bxJxVyK7no9HC/GgxDlE6jDdjHetTUt3Du11+fwsD9BqLjUU/wSy2/kAolYPOCjcogLDAyXbDZdUklm9/RKwibuoUEYx6Bd8iNz0VaoUTq80HcEaXhHiLJxEURw3boZlpxBX4/FlKeN0yH/IfTYVMfCK7KjteE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713509898; c=relaxed/simple;
	bh=0NIKKtwHJUiZX9DB3EHMQHRDMQD6k9lrc9I+T6ozsKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on8xwbBR1T5DQKiDcVgML93puEpFXrjKvi0nKG4arQTvZ7O/+xxyvP79Vz52KWf1Y8CgvApFvn/4IeP50ang7fuGhzoAe6Qz8ex1R1u8VfDB3OvIWA17GNWXCWOsNK6AGMpSiyQPKpkbKgbVUvKkAsGEMNIKzoM4Qikne9P/iyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tVH16264; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3CF9C072AA;
	Fri, 19 Apr 2024 06:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713509897;
	bh=0NIKKtwHJUiZX9DB3EHMQHRDMQD6k9lrc9I+T6ozsKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVH16264yNGTv0vRo1kR3Qr6k+vGurChCerDUrJ0spg8Dw75tEMtfX2qwT5f+c7jS
	 XawanFcx9JxXznjOydgfULk/jM69Rxa1VG4xpSIgyB9ZcaajPZweiZ1lNdsUAOpPjq
	 KxW36SDn3o8oDJWvSVNIbcvU5Wcg/om+hsOXGAbU=
Date: Fri, 19 Apr 2024 08:58:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/4] serial: exar: remove unneeded parenthesis
Message-ID: <2024041951-paradox-stable-320e@gregkh>
References: <cover.1713452766.git.pnewman@connecttech.com>
 <1dbe1847d92dd34d223c6dc6b5cd0731b78e98e5.1713452766.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbe1847d92dd34d223c6dc6b5cd0731b78e98e5.1713452766.git.pnewman@connecttech.com>

On Thu, Apr 18, 2024 at 11:36:30AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Remove unneeded parenthesis from several locations.
> 
> Based on feedback from:
> Link: https://lore.kernel.org/linux-serial/f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 01748ddbf729..10725ad0f3ef 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -317,7 +317,7 @@ static inline u8 exar_ee_read_bit(struct exar8250 *priv)
> 
>  	regb = exar_read_reg(priv, UART_EXAR_REGB);
> 
> -	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);
> +	return regb & UART_EXAR_REGB_EEDO ? 1 : 0;

Again, spell out the ? : stuff here please.  Using () isn't the problem :)

thanks,

greg k-h

