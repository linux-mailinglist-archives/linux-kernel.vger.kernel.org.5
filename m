Return-Path: <linux-kernel+bounces-144695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF28A4954
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F301C20FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA62C6BD;
	Mon, 15 Apr 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM/aJHdz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040581E4A9;
	Mon, 15 Apr 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713167250; cv=none; b=YtuqDRxVpwEFJ7fr7uOhl63x3e+RacomRIMabAp88AvWOdTTGY5Yfl7ZFaoirMBf0TePC3dlYnXrgzWkC1JInXZoKvkeJuwAUih260jq/ecwaCdPU/f551Y2zpttMzmAceCDcq47lS2mDY9+b+h2wNjQks2arV5jcljuF1kE3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713167250; c=relaxed/simple;
	bh=dIChcWtshEQ+RgJSV60RLBk9HB/akFL2I1K8CprBKsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKF3TNxOPCwV91DbKm5n/4MhCur8ILFG/XCMgR2WJMRPcxmv8aJpyF3gHOpWdeas8+CqkfDzqoYKTrvj30LQxtapRVJl4Q/D9HvWFZU05F2q0iyalPNOxcRP3d0dhM0ELYolSCfsYm1FGSd+/JTSNxkveaIaRn14pBRLPG4Yjno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM/aJHdz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E346C3277B;
	Mon, 15 Apr 2024 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713167249;
	bh=dIChcWtshEQ+RgJSV60RLBk9HB/akFL2I1K8CprBKsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LM/aJHdzCekqsEQB1UMNYGALPXZJp673wWSfgSUwJZSgPCo4q4jtDN6zL6gTgCK+v
	 HboUOJPZ1VRQJUuobtPyFFJOQ82p7QSDlC+630+1yp5J+iPCFpQuCoRQ5dYezFxrD0
	 q4eBJXrV/DXtQ4iQfX8N4zGAe76OWkYc5BwFM3rQjVJ/rT3YCLemewQ1R81mxlOrUo
	 YIGZS1lEB/8/TKO7ayYUr6wSc3nN4gZZpAEcexSUUtcw/X/30lDDZUGH0mk/Rl3Wv6
	 CTDqO8wUL/zOEalxdurfQ5+ZgjanASdk5c6NRW/1/BS2p+gZDB3iCCaaZSYoetCWt8
	 Lgl8vOwP2yWEQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwH3m-000000005NS-1viW;
	Mon, 15 Apr 2024 09:47:27 +0200
Date: Mon, 15 Apr 2024 09:47:26 +0200
From: Johan Hovold <johan@kernel.org>
To: bolan wang <bolan.wang@fibocom.com>
Cc: gregkh@linuxfoundation.org, larsm17@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] USB: serial: option: add Fibocom FM135-GL variants
Message-ID: <ZhzbjokBKaPg6Lww@hovoldconsulting.com>
References: <20240306110339.1353496-1-bolan.wang@fibocom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306110339.1353496-1-bolan.wang@fibocom.com>

On Wed, Mar 06, 2024 at 07:03:39PM +0800, bolan wang wrote:
> Update the USB serial option driver support for the Fibocom
> FM135-GL LTE modules.
> - VID:PID 2cb7:0115, FM135-GL for laptop debug M.2 cards(with MBIM
> interface for /Linux/Chrome OS)
> 
> 0x0115: mbim, diag, at, pipe

> Signed-off-by: bolan wang <bolan.wang@fibocom.com>

Patch looks good, now applied.

Just one question: Don't you capitalise your name as "Bolan Wang"?

Johan

