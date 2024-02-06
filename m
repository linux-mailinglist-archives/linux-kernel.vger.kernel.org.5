Return-Path: <linux-kernel+bounces-54369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147A84AE52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1A9B23E71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446EE83CA9;
	Tue,  6 Feb 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E12asoxT"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426208004A;
	Tue,  6 Feb 2024 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707200199; cv=none; b=CFNsG7+5qhOMV+iNnjxFSU1VqQNifBBconU1IkXOuBuWgpFFKUJ9FLgnrR2chvoAA6MHISTEgc5CZITftsW7/NtxcEmu2XmcvimgKSLLCMpI7md1avtc/eH6+a/EyBkEzDRbTlnxXkwNyGnW05PWvMGOXcAtEjV9MJc86gnWtrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707200199; c=relaxed/simple;
	bh=B3tLwb+Ce8mAkLq890UoJ9rPxK/p2G3d9nBQVdJ+m6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJLCHcPlNmCVmAYSTjSOrbck+aibl6dC7qhYmIPNQeJJDKskRP0FaBzwThw+vucaRlofsN2cuQFlcLsihLdYKYniMB6nG9wCt+osjF5Kx88P1WV3pMdR6aFGiS/1Ck3Kw67p13lIIvXhB/SjIKUihL+STuN439vZKpCwa5enxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E12asoxT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso192471b3a.0;
        Mon, 05 Feb 2024 22:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707200197; x=1707804997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUK9QqVsVGjBDisUANUUn0yteaZaAoyKpXGmI2G8lZA=;
        b=E12asoxTzfWNEZkPdMegNlx9B+wZXqvGalcP3nO05bEqEBS3KD6aPS6buEGT9M2vQH
         Wenp4CohITVsb7sybP0SlPEmruGtOdgBvkDJNi+117yS9xm2Tq+Hyqwe92mDNDM/aG77
         EhNM0xUoOipw+qAqf7DH2yx6YSAWlyb7YjsM0v1f+teUZKVGeRZ0pzqUZoR995XC6bPl
         2ipfKqHtcqEuKMmVBoSggtDPiFZzeCHwEehEQXeW5s0XvH67byUErqzV3fH70MzoUuD2
         bZEGUDjHnCuAUff0PSJavFdObC4xnQ8/IFzyvrpT+T6NXmA3OCotVgVe5/GqiL+UvfK4
         rQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707200197; x=1707804997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUK9QqVsVGjBDisUANUUn0yteaZaAoyKpXGmI2G8lZA=;
        b=ZBfuqFlD/zE+8hYBMSQZxKlCySVNecMgdqb0N3GgtKaFzITmtxm5QRva1jiQZFYqn2
         /8qi0YFk3/mRk84RH+5wlFqN6dEN9SUEmDhNI/pMd/zydTZEeSJaHxfUrMZ8MEBnnQd5
         OzmWhGruvF2n8na9+qTNj1op4siHNJvMnR1TZTYuQIM6fmSNhsgYOubhNMLyMOhJ6vay
         /w0Ms5TcAL0Y96eO/9Bfp3iRdONmKxdIjcGS3RVLW/XwKUvT33S2k9kjIRqQIcS1U1vq
         qiiDutZL99ijq5F4QhbhecMx7v67/WTdZUvxYqGjDuzOFdgBoLvduD6YQQTZMmKIhdcj
         oTJw==
X-Gm-Message-State: AOJu0YxbQCWpcZnaeTaX+D5TwtmRwR4cpURiUcYuJEvr2cf3RKYWrbww
	sijI4mEHhj8MqRnQR84D17DJQkQY4u4K5G7NzaFdSu06UiWdVFKs
X-Google-Smtp-Source: AGHT+IHnVWUiw6+w1n7GssxxDbLPpR4C9DVDKR6aPhknSImz5koyqXPRbRtw5rrShoprP+NpphRKdA==
X-Received: by 2002:a05:6a00:1a93:b0:6e0:5cb7:168c with SMTP id e19-20020a056a001a9300b006e05cb7168cmr419732pfv.17.1707200197487;
        Mon, 05 Feb 2024 22:16:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUmGMaaJ+Hp4uWP5KtYN2l2pRRmqlXSfMGqEuOQEOvPyoIR8hKY8wilBjedRnF2IwOWstLa7J1MaXBl7VStNvswVoiEpQM6hez5OXezRA9Rc1HCCSH5nFDvIZGJwpEuPQGV0X+/eJuf26Zyk3Z9344Hf4gAMK2Q/it72zMGBb1FzsPbJZQtPuyiXGgoQUQwxeB37/rPUtLKecFWcagH2CxNWzbKD7+bsHdGjitgyx3wafBbz19SlYD7MExRwaNMuMr5isMLf2Cgv0nuShLkDX6qtv8Hz2r+TDbT5+CFU3g1Mnr9bboXSBWK7w5UqV2rqg0jHpHbs+Chg3wgXbLS+Lx0WgS8
Received: from dragon (144.34.186.27.16clouds.com. [144.34.186.27])
        by smtp.gmail.com with ESMTPSA id du17-20020a056a002b5100b006e047a34834sm950990pfb.182.2024.02.05.22.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:16:36 -0800 (PST)
Date: Tue, 6 Feb 2024 14:16:26 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/4] arm64: dts: ls1012a: correct the size of dcfg block
Message-ID: <ZcHOuo7iTQBlHC/2@dragon>
References: <20240119201035.3124007-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119201035.3124007-1-Frank.Li@nxp.com>

On Fri, Jan 19, 2024 at 03:10:32PM -0500, Frank Li wrote:
> From: Li Yang <leoyang.li@nxp.com>
> 
> Correct the size of dcfg block to 4k.
> 
> Signed-off-by: Zhang Ying-22455 <ying.zhang22455@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied all, thanks!

