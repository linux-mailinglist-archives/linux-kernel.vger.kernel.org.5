Return-Path: <linux-kernel+bounces-66176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB0E855824
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD9E1C222C7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75AEC7;
	Thu, 15 Feb 2024 00:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jyEUpOmw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E654817;
	Thu, 15 Feb 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707955705; cv=none; b=N3silsNS/RxasE56dEcaDBvSZvXnp49FWtDPEhwCk2yVhg9s8WqqUCiw2tZ999/hFXB0syadp3wsFmnMRLJ/glAmQEaebtaR/8sHTtwsVl4fZMkA/NH7GBDKantyxu7hPnVXqnQa0wBFhY+HWJcSP+gcu7vlsB2ryZDYiMnCP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707955705; c=relaxed/simple;
	bh=3skvXUzX45ZQt0Qt04jZ9w4wi2O+ZfeRwqQ5jndZYRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDX3YwYuSMFexvl8GeyivjkI4bVjkJXjHkayEuFL6fphBA45MGwmuXwhFrGNcriTBRo6uRLRPCmiC198Vnv2xvuFrzEfUHeka792TaGjdbuV1Xmsmf2txaBkP/wK7LcifycF0hZzDtQd7VUADlFiLtJzNTK2fyi+i3lTTogU4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jyEUpOmw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3832ef7726so33671666b.0;
        Wed, 14 Feb 2024 16:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707955701; x=1708560501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmuuAVLyIEYFzeQGBmFR6Px/vcsaoxt5kPfoddRrxKM=;
        b=jyEUpOmwaYqH7I1csH81pu9H+MrGA8jt8TCqmRGrxwCf6DuZ8nhBTq7OKdpwnj3G38
         24krjLl651UXTrwDvovwGwgGvwKfhwhJXmr5kolVM0Pm9iMfobx0X5jEXzA3MjIxDVWX
         +/x3IKcMgPdSDYYlgUxffgJtBy6bl5Mfs0bRYmMNz7zeuVeIO45sxN3ZGO5JiVYgehkH
         FUTl+DS3Y/UZdlRClefFGAZtG4cuTuYcjA6ZXMeG1IwPY15Tvu7RDtXgfbsCjDe0Gh7x
         WaiQ3BhYrILgk2YLHB4/RKhXHLFkxjnBNQoPYfxkU0A3NPOzafHYA9grh10Kyq1pqKxY
         nw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707955701; x=1708560501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmuuAVLyIEYFzeQGBmFR6Px/vcsaoxt5kPfoddRrxKM=;
        b=kE2Ju9980G7RfjS//TlXDVSboQsByucUY+8XXv2PV2mOswc2XDQZoD9eQtASefXwmt
         qBOUymMUlPQ4Yv5fw8ri5XyIQ1QtLK+N9nvaGgAeJkaMlHbM0jwWUmbOD3JTJit1mnwf
         UI4mqnW6fOt/i2IRGuvaA4OPGeykGn6lNVb4t9kfA9IEcpneS3251YFsJnAOX5vOXVyd
         FCJPdlq/f2L0RiXvhl0rGggi1VuQEfH7MUvS7J3wohSaH/5OXGzk7CqqSNWeS4SJe7Yp
         uS574R7j+l2lT48NkAxlRiGaTlr52TRvzDPCHXZWx6j2QaKmIX3r0ZETr4O8x3WKGJHO
         B+ag==
X-Forwarded-Encrypted: i=1; AJvYcCV5VbkuBwwibjFqmz7o6z5HzJMrL8P/P96Y4WrU4EsNtxvWur6f27Afif5H7MkSfWy1H9doJFANEjIWRjFbEeEzDI6D5z+X4ppv3mLf
X-Gm-Message-State: AOJu0Yx8Y1AtyA5SreeRC9E6AP+dz0VRxD/60mPBWnUeTGz9J1HQjsZk
	K8vN3vsEbAYg+4mpuOkjI/Q4LzmmuRCIrB9VMVaqzlske/KZI3jO
X-Google-Smtp-Source: AGHT+IGP9u5TIVg70k3lbLPpLCdQApaMQvW67ijXOl41joE4zYgynyMPxX8Yi43eaY1dpPK7tBWo9Q==
X-Received: by 2002:a17:906:6808:b0:a3c:fad1:e61f with SMTP id k8-20020a170906680800b00a3cfad1e61fmr67909ejr.37.1707955701560;
        Wed, 14 Feb 2024 16:08:21 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id fj15-20020a1709069c8f00b00a3d26805852sm20756ejc.17.2024.02.14.16.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:08:21 -0800 (PST)
Date: Thu, 15 Feb 2024 02:08:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/15] net: dsa: vsc73xx: use macros for
 rgmii recognition
Message-ID: <20240215000818.p2x3pkmeqf5dzcj7@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-4-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-4-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:16PM +0100, Pawel Dembicki wrote:
> It's preparation for future use. At this moment, the RGMII port is used
> only for a connection to the MAC interface, but in the future, someone
> could connect a PHY to it. Using the "phy_interface_mode_is_rgmii" macro
> allows for the proper recognition of all RGMII modes.
> 
> Suggested-by: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

