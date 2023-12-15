Return-Path: <linux-kernel+bounces-1089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00272814A2A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3303C1C23CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C2C2FE3F;
	Fri, 15 Dec 2023 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0MotMeYv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324272F50D;
	Fri, 15 Dec 2023 14:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D862C433C8;
	Fri, 15 Dec 2023 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702649577;
	bh=/pGqmw3qNACcmX+OGPYUWwmz/jwxkgn8vuBVL7PppPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0MotMeYv/FNRZNLr28gUy6rYyxXaF+f98p9Gz1L87tGawr1vTD0sXIDvHVDC0PSfq
	 PFU0kmV72RYO1GuhX49y6v4I8ReofiQ+t8bG8K9AJC//uY+fNVLKYrncGTqUk6VmWS
	 qjFWzNVzwitYhKOhau4DLGFh80KdKz0mMzxfdUSs=
Date: Fri, 15 Dec 2023 15:12:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: jirislaby@kernel.org, quic_qiancai@quicinc.com,
	quic_arandive@quicinc.com, quic_saipraka@quicinc.com,
	quic_vnivarth@quicinc.com, quic_eberman@quicinc.com,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tty: Add comments for tty-ldisc module loading logic
Message-ID: <2023121523-cadillac-prologue-a81d@gregkh>
References: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
 <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702647690-6787-1-git-send-email-quic_zijuhu@quicinc.com>

On Fri, Dec 15, 2023 at 09:41:30PM +0800, Zijun Hu wrote:
> Current tty-ldisc module loading logic within tty_ldisc_get()
> is prone to mislead beginner that the module is able to be loaded
> by a user without capability CAP_SYS_MODULE, add comments to make
> the logic easy to undertand.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Changes in v2:
> - Remove condition checking changes

As I asked for before, please get other, more experienced developers,
from your company, to review and sign-off on this patch before sending
it out again.  I can't take this as-is, sorry.

greg k-h

