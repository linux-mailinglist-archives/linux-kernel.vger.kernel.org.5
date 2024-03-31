Return-Path: <linux-kernel+bounces-126351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F29D89357B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 21:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D502858A9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DBC146D6B;
	Sun, 31 Mar 2024 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b="X5bIwRB2"
Received: from mail.wantyapps.xyz (mail.wantyapps.xyz [66.135.5.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745E146D58
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.135.5.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711911946; cv=none; b=s2dI+pyQXcoGA7caxI+eUUbxMugllC5k+QEZyBqT8kC1qi4vj8PomXXWYIJf8GIeugjQCNc4Ycnz1Xjx1iAA0ZhvweIly3TgTBBnyvtkyROSuX9mHSEaXOjlYkStgocmOBTo7RrvZIi2HBthFtcUMtxSmrbo5j+Yu1kriH/CdXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711911946; c=relaxed/simple;
	bh=j35bephNhIS8d1ho7761Oqr612wgnK/htd9lvzN2ZHQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuHbOCfr86Chmcj26UDx6hyzy4uw+NmIIvn9VTZrfbqFYvuWB28DBbQWSMkvevgYteDMibWKSNqi3+9UTXsMKtEdEkdlsiWHYhnvHs90nHR+cZswr0Xi/540X9VeGAl0nNmBBUqNs5rAiwwwHWVeGb3Ome0akGReQCmlpF2ph20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz; spf=pass smtp.mailfrom=wantyapps.xyz; dkim=pass (2048-bit key) header.d=wantyapps.xyz header.i=@wantyapps.xyz header.b=X5bIwRB2; arc=none smtp.client-ip=66.135.5.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=wantyapps.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wantyapps.xyz
Received: from multivac (unknown [147.235.194.23])
	by mail.wantyapps.xyz (Postfix) with ESMTPSA id E665F933D8;
	Sun, 31 Mar 2024 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wantyapps.xyz;
	s=mail; t=1711911943;
	bh=j35bephNhIS8d1ho7761Oqr612wgnK/htd9lvzN2ZHQ=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=X5bIwRB2zlqaVn3iRMUXzgn1ci8IcggI7aVEkmzaX5FLfofjMsJJsb1edwnlMV+fV
	 e7+330uXpQDuSbKJoU80dv8jimb2fN47fl64QJaCf7v6BI5HKq/BKsm3/0r5exbVP9
	 GySByYpZ3ni49Tfay/pmJLSi6RtciP4iGqQ2q0b70fi8QIjsB2OoYrV/uOhzeexPXE
	 Wr1nw7REGG4zJxuGtb6wRKtyXJ46vaFLh/BAeVWTmRBAwmh8VjuvOq3WA2rVEqVhnB
	 wtbmpSAdbWX1rPEe/SMrUzuZGROIq8XxSwy8N5fRwK3MnWA0UjFezEjRxetV1TPAUC
	 GsC7VO1COrLSg==
Date: Sun, 31 Mar 2024 22:05:38 +0300
From: Uri Arev <me@wantyapps.xyz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Prathu Baronia <prathubaronia2011@gmail.com>, Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>, 
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: Fix indentation
Message-ID: <hwrcjd57mh2iq3ajlz2aho37suyezr4vouvrjnaq4hr4pdmfml@423rbfhcbgb5>
References: <20240305211416.755911-1-me@wantyapps.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305211416.755911-1-me@wantyapps.xyz>

Hey, just pinging to check if you saw my patch.

                 Uri Arev

