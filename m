Return-Path: <linux-kernel+bounces-12225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4813D81F18D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 20:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F81A1C20AF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 19:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60C47771;
	Wed, 27 Dec 2023 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BroBp/Bk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2F46B87;
	Wed, 27 Dec 2023 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336897b6bd6so5354887f8f.2;
        Wed, 27 Dec 2023 11:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703704317; x=1704309117; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xpjVZsNPX+sIY/4iKnMdXb+nJyZj3/QdyFQ3Fr0Lb3o=;
        b=BroBp/Bkryn3R95ETZq5+E7OjwwfOZNMueU2GMiMw6E8M1OJNokwWzLWR057IsywBx
         5e42TgXlFwA9tjLL7vubRpmaKNvu7FU8wNP+6R1pOv0al184a2C+f1Q71TDMsyTYouF0
         DGvLo4V7GESxVYDyrRsr1FfaNK3M6kK7c1mheKRNPc40A2xyoh6wzUW3i2q6YIqE0pzn
         72S52VfCtvZSN/QAJMTyjIQZmL/qWIZj/c2bmaC3euQ33VWHCUeXy9gEJfq7bFKu/ZN8
         H7VBFJgThHPFGewVFyPPzNa4mk36ufdKh2y46x9r2bReDuYfyaBpPUdhysGoG1yGZ01E
         6DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703704317; x=1704309117;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpjVZsNPX+sIY/4iKnMdXb+nJyZj3/QdyFQ3Fr0Lb3o=;
        b=JIYLPyR8tSWUfMCdQ6LOzQtEjNO6E4LYR7u5SjnI0K2NOfAn+tD3nqr2Wxutli5zh2
         VEQDsg7PgBddeB87LrJ+yLNaQwsgCkDnrBx4AEzSlDrTrH2Amu7TIS2FYxZcIv/HgLO3
         xImbM3rQ2x5tljWpFRoEZ4RnTLZAQOhDSgDCsjWVN13g4RcS601Ey2uWB8tGagRNEMOG
         VKgISi8jtvrOzWPxcICUfDwUNIXyJ2RY4/sWAI4E55xWP/TBZtynSkFihOyhCSXpw40R
         xdvl0pqcYLVc2hPpFjN86lyW/vl0XRWW97F3aaJlVCEtw7hy8XTxqZuH2ZeVoeIHcLIY
         aAGQ==
X-Gm-Message-State: AOJu0Yxf6tH9xeBRLclhVS1S4pln3owyNj7tztX6LTFSbilCXmYKRD9/
	esDwgg3cXuUzgHvLStGrhAI=
X-Google-Smtp-Source: AGHT+IHvTbKNlF2hf7/6KQNTwjMRnya8Ovzc9i033ephLhJKTcFyZTtSNY6K4A36to6c3+dS8P8amQ==
X-Received: by 2002:a5d:4a4e:0:b0:333:44e2:16b7 with SMTP id v14-20020a5d4a4e000000b0033344e216b7mr1701205wrs.49.1703704317311;
        Wed, 27 Dec 2023 11:11:57 -0800 (PST)
Received: from skbuf ([188.25.254.72])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d4dc7000000b00336ebf93416sm3452910wru.17.2023.12.27.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 11:11:57 -0800 (PST)
Date: Wed, 27 Dec 2023 21:11:54 +0200
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
	David Bauer <mail@david-bauer.net>, mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next] net: dsa: mt7530: register OF node for internal
 MDIO bus
Message-ID: <20231227191154.6jkqdlqdxciidpfw@skbuf>
References: <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231220173539.59071-1-arinc.unal@arinc9.com>
 <20231221151607.ujobhh4aet4obxdz@skbuf>
 <6600c6b1-2230-4963-940c-8b95a01750fd@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6600c6b1-2230-4963-940c-8b95a01750fd@arinc9.com>

On Sun, Dec 24, 2023 at 10:37:12AM +0300, Arınç ÜNAL wrote:
> If the MDIO bus of the switch is defined on the devicetree, the
> (!ds->user_mii_bus && ds->ops->phy_read) check in dsa_switch_setup will be
> true so the MDIO bus will be attempted to be registered again, resulting in
> a kernel panic.

Where does mt7530 provide ds->ops->phy_read() in upstream?

