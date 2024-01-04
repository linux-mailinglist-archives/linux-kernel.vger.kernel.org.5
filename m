Return-Path: <linux-kernel+bounces-16850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17C38244E4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4AEC1C21D96
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D1241E9;
	Thu,  4 Jan 2024 15:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0KGMjql"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D7241E6;
	Thu,  4 Jan 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so777268a12.0;
        Thu, 04 Jan 2024 07:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704381912; x=1704986712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1NX3sCNOh0ED9p71133Qk1RKXP6AygCB/B6GJLxt724=;
        b=G0KGMjqlDdRlvv9FLW70mj4aTTF1HgarpXvvrtDRBVOEygzUX4U0GirVgWN2qlR5dr
         hReqLa2MlX+IhWI2x7p5oOJa+1JA0ktlGsO/fjmkidViHPO31o/A/QwblKgGGWDghW3A
         oOmk9Vmnpdlqq9GAeFIENac3Pa6f36KW7jVLgX5voGIQpug/ljHLiWb4AUCM9tgOaus5
         8rhvhC6rKaxmsAMtv0xAOUuqhXgewibTRF1Yxzc78qvGfdcfjF991wKkB9tTnfvTr63a
         /HtlKQx/5jLO4I7Dlhm52PjfZXgwInxsNVr5+yAYdRt2jIJaAXEeWg+utPVX1OIr09u0
         Ncpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704381912; x=1704986712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1NX3sCNOh0ED9p71133Qk1RKXP6AygCB/B6GJLxt724=;
        b=lH8Mx9LprMd3mLM3aULCGEKF22dx7BbDDSTpryNc+6L7yexETq+XYs7RhHf+tdngYu
         7G2PgWiqTY7mfFKQvU5ZV1z4TTtJuG4GUcd1SLlQ5QdvY+Rm4PLshaNE8ByKtpKRBCPT
         7vXa+UcF7xhEKNjhHw07kYJBmn1X83jqJ5Tbv9XnSYjBJMfTXdD7zbGJYAtB+FYJ0mkG
         ey9yqR4bDT21Y34JxKxTFoIE2RdttO0zfkjwtVQwSDNtz6TgTtuKgeRYd9CPlgMebdkG
         8VWSQZE5mrV0bIGtqgypS3Af/JFhy0nRsXa6XyzxYjkdXH49XH9dgkavTQ0/J+j+HONZ
         LfcQ==
X-Gm-Message-State: AOJu0YyXtDyEV+En8Ypc7chqWjAAaezQiuJpoYcj8LadMVcUYgZm/zAe
	Up/Ma1q6oDgiv01HRA0Ef58=
X-Google-Smtp-Source: AGHT+IF5LYbHLGyB9BUopyv0gdjS+WBokyR9trbGqCfXuxoIRLry/U7C9toUg2NmeG6KQ8XjELG+oQ==
X-Received: by 2002:a17:906:4882:b0:a26:b88c:42c2 with SMTP id v2-20020a170906488200b00a26b88c42c2mr370974ejq.93.1704381911381;
        Thu, 04 Jan 2024 07:25:11 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id zh14-20020a170906880e00b00a28e5c875f8sm587686ejb.219.2024.01.04.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 07:25:10 -0800 (PST)
Date: Thu, 4 Jan 2024 17:25:08 +0200
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
Subject: Re: [PATCH net-next v2 4/7] net: dsa: mt7530: improve comments
 regarding port 5 and 6
Message-ID: <20240104152508.nde2nzw4pvcjlov7@skbuf>
References: <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-1-arinc.unal@arinc9.com>
 <20231227044347.107291-5-arinc.unal@arinc9.com>
 <20231227044347.107291-5-arinc.unal@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231227044347.107291-5-arinc.unal@arinc9.com>
 <20231227044347.107291-5-arinc.unal@arinc9.com>

On Wed, Dec 27, 2023 at 07:43:44AM +0300, Arınç ÜNAL wrote:
> There's no logic to numerically order the CPU ports. State the port number
> and its capability of being used as a CPU port instead.
> 
> Remove the irrelevant PHY muxing information from
> mt7530_mac_port_get_caps(). Explain the supported MII modes instead.
> 
> Remove the out of place PHY muxing information from
> mt753x_phylink_mac_config(). The function is for MT7530, MT7531, and the
> switch on the MT7988 SoC but there's no PHY muxing on MT7531 or the switch
> on the MT7988 SoC.
> 
> These comments were gradually introduced with the commits below.
> ca366d6c889b ("net: dsa: mt7530: Convert to PHYLINK API")
> 38f790a80560 ("net: dsa: mt7530: Add support for port 5")
> 88bdef8be9f6 ("net: dsa: mt7530: Extend device data ready for adding a new
> hardware")
> c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

