Return-Path: <linux-kernel+bounces-40974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3B83E92A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E71C228F9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2188B667;
	Sat, 27 Jan 2024 01:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZLhdb4W"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E9B8F51;
	Sat, 27 Jan 2024 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320595; cv=none; b=Ok8wabcOPhM7WmNT84oBD2qsqjruE1exNApxfz1jo+8zyZvQmBulPCE9w4vjuDQyqhMZeqQ+yiI9PMgzxAfbq/Uq3701106UAQtCYZz401YTNAlWm8QQcSbf+e9cDeSMGw5NP2Bu22btmqXavFmh+di2cwh/ixrWveFs4uYM09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320595; c=relaxed/simple;
	bh=Bwi5+CdWnELYANOK9dYY2Ztg4Ol9QkvktdG+N4SsqOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lu0W9t5oDBl8Tx5mitKZWwsSlBcPXrlfbZyxPf8o1+FgCY7PqajMHbInlIfPKDkVY0wRC1Cz4kth/BLaLP5suiDOXpvMttXVXnuR1LD4Gj/ta5rku93FMJR/C5f5boagFEmsXnxPD4I+OpyK8Zg0iHNdtvoYW37G7sHCgRH5Tg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZLhdb4W; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6868f31a555so6045446d6.1;
        Fri, 26 Jan 2024 17:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706320592; x=1706925392; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/afVxJVRAH/Hka426Kik5pPJmKRNBFsEk7DBPTNKyGs=;
        b=QZLhdb4WIgxoyHuO3DhL92IWkQk0qr1zvopIl91l/m/35H3AAzsxEl4/vvmz7/AoSa
         X822ZfM1fuQeyBNELSlHpw0XjMQLHLMDrahCB5+NlU3ucolQTFvaGViZPW4HMtF5Sf7f
         xz0AjLSiZFWQG9oPaUYbJUjc0bGtDIdg7sC3osMSayOlDf9EP3FPX39550bcKVl/BsoL
         oB+Z29RSIsVsf++2laQrTXKZLGcRaF1wIxeJgZ4yxPKJaZ+xHgVbTZEz8mMC5Zl6EALQ
         qlcov1vElco+ckU314t18wQIRdDniHN2HoqCEpiB1cEMToTMWn8yNUikfSe9vRWuYoc9
         XC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706320592; x=1706925392;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/afVxJVRAH/Hka426Kik5pPJmKRNBFsEk7DBPTNKyGs=;
        b=tjsfc3JtX0C9k3Z/xgMAzx1flltGy1SoSf5mlrN5TkKzrL5B+Hw01aI1H7I1ZLuF8K
         sT1fFaDl8DIgYpXF+l2JTcFL3ktFsfNh91oMRFSZIO8bgtIFMgvfNutjrtxI/FjVz4v8
         u/FF4e50OxVz+96f7BSVgIjeX3AHaVQdB+2Bpm7iHWswL/2VoA5MuxpTw8VAK01l7pD0
         NWSaeEXpk/z/ML2v9AZ9zi0INqXoVwC9T8/0ijHm/iUDwlqyp9tyIeOb+nIgnPABDwAw
         GpJyZ1x4k9dekYDV70G9A798eAHEjv2r6MrQ+PTvFhqkahOeNfGS96o+W3REs4Yg2XxS
         MClA==
X-Gm-Message-State: AOJu0Yyws5J2x/jF2JwOqMM5NFrGofcPaPukO8N56JMctkPBX4yydlQ5
	BOOcu2/SfH8l5b2n2TWmc5UVjgVvlA2y0blEacakX3X7E9G1D5U0
X-Google-Smtp-Source: AGHT+IFkNflH+BD21PMssYPhDkGtjPw/IUQ5epAxGPBNdBEmXmNHE/6kB23j0pbiLNRS52u4ol6Y4g==
X-Received: by 2002:ad4:5c8b:0:b0:683:c2b7:bee8 with SMTP id o11-20020ad45c8b000000b00683c2b7bee8mr1017615qvh.72.1706320592406;
        Fri, 26 Jan 2024 17:56:32 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id dk6-20020a056214092600b0067f339c0c16sm1015924qvb.134.2024.01.26.17.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 17:56:31 -0800 (PST)
Date: Fri, 26 Jan 2024 20:56:29 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Jonas Karlman <jonas@kwiboo.se>, Chen-Yu Tsai <wens@csie.org>,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rock-pi-e: fix location of
 snps properties
Message-ID: <20240127015629.GA36077@localhost>
References: <20240116204103.29318-1-twoerner@gmail.com>
 <df78489b-7546-46ea-b09f-39a80692a962@kwiboo.se>
 <20240118230312.GB14779@localhost>
 <1976352.usQuhbGJ8B@phil>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1976352.usQuhbGJ8B@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu 2024-01-25 @ 09:12:46 PM, Heiko Stuebner wrote:
> Hi,
> 
> Am Freitag, 19. Januar 2024, 00:03:12 CET schrieb Trevor Woerner:
> > On Thu 2024-01-18 @ 08:31:30 AM, Jonas Karlman wrote:
> > > On 2024-01-17 09:15, Jonas Karlman wrote:
> > > I have just sent out a U-Boot series that fix ethernet on the v1.21
> > > revision of the ROCK Pi E board, see [2].
> > 
> > Thank you! I have tested your patches both in U-Boot and Linux and they work
> > perfectly.
> 
> if I'm reading this correctly, this patch is not needed anymore, right?

True, patch 2/2 is not needed (or correct).

> I'm not yet sure about the first patch, as it really is
> just a cosmetic ;-)

I wouldn't say it's entirely cosmetic. Some rock-pi-e boards come with the
8211e PHY and others come with the 8211f PHY. Labelling the phandle as
"rtl8211e" would be misleading/confusing for people who had boards whose boot
logs would report otherwise.

