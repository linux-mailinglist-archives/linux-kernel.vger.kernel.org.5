Return-Path: <linux-kernel+bounces-106072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E6387E89B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1D171C20CE7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88416374E9;
	Mon, 18 Mar 2024 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="h7AYbJfg"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4551364A5;
	Mon, 18 Mar 2024 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761326; cv=none; b=Kufb/uTtwRw3SawVAL/aHJ80osMht6TWotrn1k6kpSW2+4Zny67rf46Sp4ygFcloTL3bl29AyurJ8/3fvPc43AYJiYPnoSrMOXFrRjKEHGjvEbSdHewdleasHBP9NYtsTTw9x6UitZEa/AM28BtuNj00iF3/SLoOUjnQHcR4+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761326; c=relaxed/simple;
	bh=XP3eK5HcPs5i97lomC6HdBMoGbV9duL2dKQZymBXmsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ooWkhNn+FMn6Sn5Kv0KBK2wvqPQcBli1NaybQCFfOTkWknP0dnDUc0yxFYxphsPYef2iK9YMnQ8nvEe3R2xLQpojGlzHBQcJOxLHidWnQIizsq7WEhLyamwORHEti2gj1tyEPDyTRSgXEY43nBRArAzhX2tBkEWpQNBeRKrf7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=h7AYbJfg; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 71A92206BF;
	Mon, 18 Mar 2024 12:28:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1710761314;
	bh=FkOHD0pnGkKqXtObJnUFQNgDIavF2Al3e0sMsXfSMsI=; h=From:To:Subject;
	b=h7AYbJfg/BYwKxCY9VAvAKKHRSOZGVoO5Tqd3cE3ywBHvMNpVbyXrVNG9ZhpixfUT
	 xjkE8E8+mHiULVeunSO7Ev596qy7n0XevxJckGkqVI3ySmAioAZRfvmTs3NPoa0PlV
	 C6g4r4XTDOUkbEyeYYzaFSSy3y0IWlkP0pX2PFjFe0yIrskHgLkotzsVS2pMvRGjRW
	 NgetGz9VQMFusVVe/0UKgyUQOjed00aumaRWZBqvaFiwA1fuPJR9LjiZwa40AeOTGZ
	 qyhvesfjAzexl04vDnGwwyZTn2WJxvu5MVIMUKHDKEzCoiirhIaBkIZ07FJJHHI1rk
	 SjRg/jXOBumzA==
Date: Mon, 18 Mar 2024 12:28:30 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Brian Norris <briannorris@chromium.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, kvalo@kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lin <yu-hao.lin@nxp.com>, tsung-hsien.hsieh@nxp.com,
	rafael.beims@toradex.com,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host mlme
Message-ID: <20240318112830.GA9565@francesco-nb>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
 <20240315094927.GA6624@francesco-nb>
 <ZfTg1xKT-Mxmpf9w@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfTg1xKT-Mxmpf9w@google.com>

On Fri, Mar 15, 2024 at 04:59:19PM -0700, Brian Norris wrote:
> On Fri, Mar 15, 2024 at 10:49:27AM +0100, Francesco Dolcini wrote:
> > On Wed, Mar 06, 2024 at 10:00:51AM +0800, David Lin wrote:
> > > This series add host based MLME support to the mwifiex driver, this
> > > enables WPA3 support in both client and AP mode.
> > 
> > What's your plan for this series? I know you raised some concern when
> > this started months ago and I'd love to know if there is something that
> > would need to be addressed to move forward here.
> 
> My plan was (especially given the "Odd Fixes" status in MAINTAINERS) to
> wait until a 2nd party was happy with things here. From my cursory
> following of things, that has now occurred -- thanks for all the review
> Francesco.

Brian/Kalle, would be ok for you to add myself as reviewer for mwifiex?
The patch flow on the driver is pretty limited, but I care about it
and I am happy to help out if needed (and I have some hardware available
for testing).

If you agree I'll send a patch to the MAINTAINERS file.

Francesco

 

