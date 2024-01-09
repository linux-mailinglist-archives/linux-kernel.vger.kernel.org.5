Return-Path: <linux-kernel+bounces-20808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4C82857E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C30BA284A26
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 11:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596F9374DB;
	Tue,  9 Jan 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/FYUEKH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A6F37163;
	Tue,  9 Jan 2024 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d5b89e2bfso30334515e9.0;
        Tue, 09 Jan 2024 03:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704801078; x=1705405878; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8zorFy37cTsPEwkpmk1vmBCDGkHkthlVR0ZqxNtPSY=;
        b=h/FYUEKHurohVQQBEyLqeJHhXgbmLfc8QD9KBbm2h6i1Brz6+C8f0eUjHp4yzienR2
         +tZxjGrkAdOdxRWGNf3c9OphruZxPj43gMCobDmK9JECLu2y7QZrMr6e53YmfIcz2GzN
         UNDsCkplkUt3Ckv3DlzBe1juhj32i39VC2S/zZy3qUe9/Aj2gr6vx+DyiE94fbTBbKDg
         5FJ7g5kSwJ6UD1qf/O5NJKmhXpNGwtPgqPkrDYjPEsYvvQ9Eor6SXD4qz33V7JJQc2aV
         2ZSKwC6e83osbBgxJu48cxevNQgr4g7Mq6LS5zkXklyMWzQydPsBLGzVL+KmCCUdYAjO
         f4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704801078; x=1705405878;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8zorFy37cTsPEwkpmk1vmBCDGkHkthlVR0ZqxNtPSY=;
        b=eJZqrZ3lAF9YkQaho47ra1sOXg/97DBMHSxYzQLd5y4YFKMdSLcV/Xvtrc9ls0vpap
         B8BP+Xkv9B4/SCGFul/BdOkfKaT0Ip9qzGqWiijWNYZt+x/VBN8aeamRWrLveU3HOQTU
         FDV720kNgWFub2pPj/pIAT3yk8k2GGgeTyqxX3QBgdXkNqegfnHHGgaHWlaaYNNGw+R1
         c4QjotzaoJZRz7qXWJKIAEtlReF8EzeT43PLgUvOmJqUdUr7BnRJivJIuRqGxSbZ1f3G
         0hHLewntr8NgZv1kM0bHFL/RVaKphWbxpL/YYyYh/UNiPJ5b28VYq43Pv2jbN/bRVlpi
         Gsqg==
X-Gm-Message-State: AOJu0YyFs270y5KDrdnZL/Mh7LX7Ota0AVmhQd/IgnsBNejbcGWZEvaJ
	JPNY7LFoQDu4fwQczXpP9eA=
X-Google-Smtp-Source: AGHT+IF4Oxt1eK3J4/ceekyRc0+o+bLIr0gfQJAzosybtEeRD2xFsf3yE9MiR9sIWEdXxbypk1p2Hw==
X-Received: by 2002:a05:600c:4d21:b0:40d:94f5:b8f5 with SMTP id u33-20020a05600c4d2100b0040d94f5b8f5mr2578892wmp.139.1704801078190;
        Tue, 09 Jan 2024 03:51:18 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c3b1500b0040d5c58c41dsm3342978wms.24.2024.01.09.03.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 03:51:17 -0800 (PST)
Date: Tue, 9 Jan 2024 13:51:15 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 6/7] net: dsa: mt7530: do not set
 priv->p5_interface on mt7530_setup_port5()
Message-ID: <20240109115115.yuct3yw4oy6ipd3i@skbuf>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-7-arinc.unal@arinc9.com>
 <20240104154241.rxjins4mi5zkbhia@skbuf>
 <f9ad000a-2e42-4ddf-89a4-9a3ff452dc4b@arinc9.com>
 <2793938a-91e1-419d-a011-850756177e31@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2793938a-91e1-419d-a011-850756177e31@arinc9.com>

On Tue, Jan 09, 2024 at 02:42:45PM +0300, Arınç ÜNAL wrote:
> Running mt7530_setup_port5() from mt753x_phylink_mac_config() multiple
> times is being prevented which shouldn't be done. That's because of a
> different reason involving MT7531. I will deal with this with a later
> patch.
> 
> I intend to put this on the patch log.

Still not clear why it shouldn't be done. Ideally you could come up with
a plausible hypothesis as to why it's there in the first place, and why
it's not needed.

