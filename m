Return-Path: <linux-kernel+bounces-14451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7022A821D3B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7E6C2837AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072D611704;
	Tue,  2 Jan 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n/a8o/Rr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0C101D5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40d8991f1acso14225695e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204163; x=1704808963; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V/7mv4b7UJD/BzLag5HRBVmocUnHPWAiQ2MQxiW+kVo=;
        b=n/a8o/RrAmHhEpgPYMai0dS2DnnJ/z/mtJ4o4zfOVe5CHmb8lr7sLaXXDcYh411a6e
         Y8T7H58bJeZ6+iEUqNi52DA99pXuJheX/166vjY4Z0aTFhGDKlN8/1O3o36o5QWsqpGm
         niODAyFIQmWVKCN97Ky+RuUnZBdqkoUWy/V3Zy19dmjconClkTVAqj1Yp8D5ghzgtGad
         62v+7QDFBp9Pz2J1MUvE/WM3FZn8bWDrCOnh+Oryj1VzB/eGJPJy/jpPHmIOtD1ZLBwY
         cds9EC6nJcBWgZ6X29YDlyxjyXp1uzuZG8xoblZWG1ySMB3TfpKcSUMKYRKLrBBimCtd
         SDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204163; x=1704808963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/7mv4b7UJD/BzLag5HRBVmocUnHPWAiQ2MQxiW+kVo=;
        b=dub46/MlCK1XelxcImaEub46nipKjzaS9eE6rgxsdii9K4NY4ycpryuR5MSb16YOKT
         M2KsMaS7NTTqVR9vYUi/M6XRIqF1eULF8yj9qJYOw8NJUDbBvgKnX9prlqBNB3y+yaxg
         Hrc17RYNZhZunjdJXCmHiZr0+q6YVElJPpPA/22cBHJNTw7vqPau1xEdTwO7Oj323tUo
         E/ASlvIvGFPeKGwLSwBNEJ/MmxAoXEHSAGrhGqBCnVCrqzwOJaNjaMxmVhfEYpQc6sW4
         eM2kOYvVNMr2EdqU0V4QktihfrnGkG+7isMR4aFy0WTiWOw7+iimv5ClRw0TcCS4gJt+
         TR2g==
X-Gm-Message-State: AOJu0Yw+amF5gYe+VElesrLAvDezKLiFoQW69RdSlH90fAfUW70xYDIv
	mUBrpNOuBWH+Rkj+tbi+yMJHLReewb/AUQ==
X-Google-Smtp-Source: AGHT+IH3VhlRlXj3x0V/u8jvLVtAXEEM7HcxvHM0IRuRu0WxGAZJxGIyDO1XWwQIMO+yb2HlWf8VnQ==
X-Received: by 2002:a05:600c:2d84:b0:40b:5e59:ccb3 with SMTP id i4-20020a05600c2d8400b0040b5e59ccb3mr8821823wmg.148.1704204163222;
        Tue, 02 Jan 2024 06:02:43 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040d6eb862a7sm18594695wmo.41.2024.01.02.06.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:02:42 -0800 (PST)
Date: Tue, 2 Jan 2024 14:16:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: Re: [PATCH net-next 07/15] net: dsa: mt7530: do not run
 mt7530_setup_port5() if port 5 is disabled
Message-ID: <48b664fb-edf9-4170-abde-2eb99e04f0e5@suswa.mountain>
References: <20231118123205.266819-1-arinc.unal@arinc9.com>
 <20231118123205.266819-8-arinc.unal@arinc9.com>
 <20231121185358.GA16629@kernel.org>
 <a2826485-70a6-4ba7-89e1-59e68e622901@arinc9.com>
 <90fde560-054e-4188-b15c-df2e082d3e33@moroto.mountain>
 <20231207184015.u7uoyfhdxiyuw6hh@skbuf>
 <9b729dab-aebc-4c0c-a5e1-164845cd0948@suswa.mountain>
 <20231208184652.k2max4kf7r3fgksg@skbuf>
 <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3a0fc6a-825c-4de3-b5cf-b454a6d4d3cf@arinc9.com>

On Sun, Dec 17, 2023 at 03:22:27PM +0300, Arınç ÜNAL wrote:
> On 8.12.2023 21:46, Vladimir Oltean wrote:
> > Hmm, maybe the problem, all along, was that we let the -ENODEV return
> > code from of_get_phy_mode() pass through? "interface" will really be
> > uninitialized in that case. It's not a false positive.
> > 
> > Instead of:
> > 
> > 	ret = of_get_phy_mode(mac_np, &interface);
> > 	if (ret && ret != -ENODEV) {
> > 		...
> > 		return ret;
> > 	}
> > 
> > it should have been like this, to not complain:
> > 
> > 	ret = of_get_phy_mode(mac_np, &interface);
> > 	if (ret) {
> > 		...
> > 		return ret;
> > 	}
> > 
> 
> I just tried this, smatch still reports "interface" as uninitialised.
> 
> $ export ARCH=mips CROSS_COMPILE=mips-linux-gnu-
> $ ../smatch/smatch_scripts/kchecker --spammy drivers/net/dsa/mt7530.c
> 
>   UPD     include/config/kernel.release
>   UPD     include/generated/utsrelease.h
>   CHECK   scripts/mod/empty.c
>   CALL    scripts/checksyscalls.sh
>   CC      drivers/net/dsa/mt7530.o
>   CHECK   drivers/net/dsa/mt7530.c
> drivers/net/dsa/mt7530.c:217 mt7530_mii_read() warn: call of 'warn_slowpath_fmt' with non-constant format argument
> drivers/net/dsa/mt7530.c:454 mt7530_setup_port6() error: uninitialized symbol 'ncpo1'.
> drivers/net/dsa/mt7530.c:868 mt7530_set_ageing_time() error: uninitialized symbol 'age_count'.
> drivers/net/dsa/mt7530.c:868 mt7530_set_ageing_time() error: uninitialized symbol 'age_unit'.
> drivers/net/dsa/mt7530.c:2324 mt7530_setup() error: uninitialized symbol 'interface'.

That's so strange.

Vladimir was right that I was misreading what he said and also hadn't
noticed the break.

For me, his approach silences the warning with or without the cross
function DB.  Also of_get_phy_mode() initializes interface on all paths
so checking for -EINVAL doesn't matter as far as this warning is
concerned.

regards,
dan carpenter

