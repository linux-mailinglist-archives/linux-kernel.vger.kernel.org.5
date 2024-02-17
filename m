Return-Path: <linux-kernel+bounces-70036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3789E859220
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6A5282849
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3C27E593;
	Sat, 17 Feb 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9z31H6c"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651891E863;
	Sat, 17 Feb 2024 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708198892; cv=none; b=eI0b54zdVXmi57Nx6RgOoZR5Y0LwRJznnbhdJ6fL+2ps0CLcLgPN2XNgq1PrUMUxGCE4OYH8XFK5QfHp7/P9845DH+5GbykPcaT1PTO2P6OZ/UkeuptZRGIb23UC6DRuoN20rKBNCK3puA9bpT20o9HFMYOvKMgzPNMH4Cv0xjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708198892; c=relaxed/simple;
	bh=rUbuPfH41JVfeYlJtTqiN15yrXup8v2X8caGyi9SR0g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DurXf4zKcteZ9Z4xD8Yg6+0oppBWX5bq0+yfjYfOgj3zV1pPY+OeV+zGhKhm6fDq2qRT0INmNjGqblr1pKy9iEYyLWgzEfE3zPGlWahW7Q4+HerlzHbqr/JbxVZbKyEupL1Abo2O7ZvYRkQtUZc/kkylmmT9C1OOoGdjWFSrOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9z31H6c; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d01faf711so1678487f8f.1;
        Sat, 17 Feb 2024 11:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708198889; x=1708803689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FoNJd93UYhml9Ujt4XegNPtQpjqvmz00PoAt/mJ9soA=;
        b=F9z31H6c33yexv81XsxAtkcvsFEqYEMQiBjNTrNUsp16ju1ROYRG3gvU0I1Sj6SaAM
         CRYKil3QvhI/TvQrC9vEYUVQDNU5Ms2d1auYAQ7bqfO9wQlycTGcTTdeH4uUv7QimevT
         jUVanuAsPPAoD/qCtHDn8tE67lObbrTvyVXxiqJckSQayWJ06eqT7iv2ANWxl98yC1+T
         mmXULgL1YoI1K6bGrQGwCMtMx6iM9yuiF5nJL9k2PnDjm4IbpMG6dxmCSTUbYGsQAeEF
         6ifDAIw1WQSOC+mAdPvLenelUm5KuX8pPxpCEGwQ8fBU9rTMfLm4KypvcMxGhSfW0hfF
         PElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708198889; x=1708803689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoNJd93UYhml9Ujt4XegNPtQpjqvmz00PoAt/mJ9soA=;
        b=ScddXMdCHb2isnQ24BI/8GbkfFjyalln599C4IO1oNBVDKJtk+V6OToEArcKuBtUAn
         7JFMB9hEKq6B6Ix/CjFnhtswXdJ+aQaW8K7ti2kRz0rJzj+4A4Ms4n9/jFqqxhIeJn8d
         iAZhGn+1PA7Wp1BB97NgJ3Pt9b5QrIgiFU7vwOmfMME7dMqnTkc0reZxwwIGPIbtQZc1
         p11w5EiD1nQ2CY/nyXqCyjzk/kFdeBJQXFenGOync94yrAKQiznAmtwR7rH5i9KNHtk8
         DuiPB55cVyAIwsGV/wUB4JKdWgCN3N7eXd07TzwCjJBxXk/J14j5MvZLUao1FqN3mhri
         Xynw==
X-Forwarded-Encrypted: i=1; AJvYcCXnZ9q8gzYakyjq85FYRfUgZa6pRqDUrAvArZzLKYDucqOAqVgd3FOwe0bmjeGXUxyLcV3jsGTpa6jiOy5YXkgeGaBhHsIujArMizGj33KgjYcDPRNANJ4FxQ2S+Rev0uvdhX2Yt+RnfglEGVWljJFGK3KO2oQ3BJ5KYEgXctPRolx+lniUrUoQYH91X3M8azVN/hRuZiUuns9yq0qMmik0Plcd
X-Gm-Message-State: AOJu0Yz9LxriYraNTRi2GZxemzuKvcQ7pPwXfT121tZz7hV2RzXBEC4F
	8lXfxB3zBJ4TCEjSJfVQxqeMk/md+plOnE5f8fhiT7CC26ye3Ej8
X-Google-Smtp-Source: AGHT+IEMhpVotyrQM8FDDo2tYf/RWQ1+Gqe/hReAQZwCqW+WAIvjwxMBlc9fE/sBf+dXkJMnsRz3oA==
X-Received: by 2002:adf:fe46:0:b0:33d:29c1:c28c with SMTP id m6-20020adffe46000000b0033d29c1c28cmr1969393wrs.66.1708198888366;
        Sat, 17 Feb 2024 11:41:28 -0800 (PST)
Received: from localhost.localdomain (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.googlemail.com with ESMTPSA id b10-20020a5d40ca000000b0033ceca3a3dbsm5661169wrq.2.2024.02.17.11.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 11:41:27 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Richard Cochran <richardcochran@gmail.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Peter Geis <pgwipeout@gmail.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Xu Liang <lxu@maxlinear.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Robert Marko <robimarko@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Epping <david.epping@missinglinkelectronics.com>,
	Harini Katakam <harini.katakam@amd.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	rust-for-linux@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [net-next RFC PATCH 0/3] net: phy: detach PHY driver OPs from phy_driver struct
Date: Sat, 17 Feb 2024 20:41:11 +0100
Message-ID: <20240217194116.8565-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Posting as RFC due to the massive change to a fundamental struct.

While adding some PHY ID for Aquantia, I notice that there is a
big problem with duplicating OPs with each PHY.

The original idea to prevent this was to use mask on the PHY ID
and identify PHY Family. Problem is that OEM started to use all
kind of PHY ID and this is not doable, hence for PHY that have
the same OPs, we have to duplicate all of them.

This is present in Aquantia PHY, but is much more present in
other PHY, especially in the BCM7XXX where they use a big macro
for common PHYs.

To reduce patch delta, I added the additional variable without
adding tabs as this would have resulted in a massive patch.
Also to have patch bisectable, this change has to be in one go
hence I had to use this trick to reduce patch delta.

Other solution to this problem were to introduce additional
variables to phy_driver struct but that would have resulted
in having 2 different way to do the same thing and that is not O.K.

I took care to compile-test all the PHY, only exception is the unique
RUST driver, where I still have to learn that funny language and
I didn't had time to update it, so that is the only driver that
I think require some fixup.

I posted 2 example that would benefits from this change, but I can
find much more in other PHY driver.

Christian Marangi (3):
  net: phy: detach PHY driver OPs from phy_driver struct
  net: phy: aquantia: use common OPs for PHYs where possible
  net: phy: bcm7xxx: use common OPs for PHYs where possible

 drivers/net/phy/adin.c                   |   4 +
 drivers/net/phy/adin1100.c               |   2 +
 drivers/net/phy/amd.c                    |   4 +
 drivers/net/phy/aquantia/aquantia_main.c | 189 +++++++++--------------
 drivers/net/phy/ax88796b.c               |   6 +
 drivers/net/phy/bcm-cygnus.c             |   4 +
 drivers/net/phy/bcm54140.c               |   2 +
 drivers/net/phy/bcm63xx.c                |   4 +
 drivers/net/phy/bcm7xxx.c                |  72 +++++----
 drivers/net/phy/bcm84881.c               |   2 +
 drivers/net/phy/bcm87xx.c                |   4 +
 drivers/net/phy/broadcom.c               |  42 +++++
 drivers/net/phy/cicada.c                 |   4 +
 drivers/net/phy/cortina.c                |   2 +
 drivers/net/phy/davicom.c                |   8 +
 drivers/net/phy/dp83640.c                |   2 +
 drivers/net/phy/dp83822.c                |   8 +-
 drivers/net/phy/dp83848.c                |   2 +
 drivers/net/phy/dp83867.c                |   2 +
 drivers/net/phy/dp83869.c                |   2 +
 drivers/net/phy/dp83tc811.c              |   2 +
 drivers/net/phy/dp83td510.c              |   2 +
 drivers/net/phy/dp83tg720.c              |   2 +
 drivers/net/phy/et1011c.c                |   2 +
 drivers/net/phy/icplus.c                 |   8 +
 drivers/net/phy/intel-xway.c             |  20 +++
 drivers/net/phy/lxt.c                    |   8 +
 drivers/net/phy/marvell-88q2xxx.c        |   2 +
 drivers/net/phy/marvell-88x2222.c        |   2 +
 drivers/net/phy/marvell.c                |  44 +++++-
 drivers/net/phy/marvell10g.c             |  16 +-
 drivers/net/phy/mediatek-ge-soc.c        |   4 +
 drivers/net/phy/mediatek-ge.c            |   4 +
 drivers/net/phy/meson-gxl.c              |   4 +
 drivers/net/phy/micrel.c                 |  54 ++++++-
 drivers/net/phy/microchip.c              |   2 +
 drivers/net/phy/microchip_t1.c           |   4 +
 drivers/net/phy/microchip_t1s.c          |   4 +
 drivers/net/phy/motorcomm.c              |   8 +
 drivers/net/phy/mscc/mscc_main.c         |  30 ++++
 drivers/net/phy/mxl-gpy.c                |  24 +++
 drivers/net/phy/national.c               |   2 +
 drivers/net/phy/ncn26000.c               |   2 +
 drivers/net/phy/nxp-c45-tja11xx.c        |   8 +-
 drivers/net/phy/nxp-cbtx.c               |   2 +
 drivers/net/phy/nxp-tja11xx.c            |  16 +-
 drivers/net/phy/phy-c45.c                |   2 +
 drivers/net/phy/phy-core.c               |  18 ++-
 drivers/net/phy/phy.c                    |  85 +++++-----
 drivers/net/phy/phy_device.c             |  79 +++++-----
 drivers/net/phy/qcom/at803x.c            |  18 ++-
 drivers/net/phy/qcom/qca807x.c           |   4 +
 drivers/net/phy/qcom/qca808x.c           |   2 +
 drivers/net/phy/qcom/qca83xx.c           |  12 +-
 drivers/net/phy/qsemi.c                  |   2 +
 drivers/net/phy/realtek.c                |  46 +++++-
 drivers/net/phy/rockchip.c               |   2 +
 drivers/net/phy/smsc.c                   |  14 ++
 drivers/net/phy/ste10Xp.c                |   4 +
 drivers/net/phy/teranetics.c             |   2 +
 drivers/net/phy/uPD60620.c               |   2 +
 drivers/net/phy/vitesse.c                |  22 +++
 drivers/net/phy/xilinx_gmii2rgmii.c      |  16 +-
 include/linux/phy.h                      |  57 ++++---
 64 files changed, 737 insertions(+), 291 deletions(-)

-- 
2.43.0


