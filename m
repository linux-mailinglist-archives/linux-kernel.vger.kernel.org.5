Return-Path: <linux-kernel+bounces-19212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F698269D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299E91C2249D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D372C2D0;
	Mon,  8 Jan 2024 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ag6m/7x0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9614D51B;
	Mon,  8 Jan 2024 08:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5572a9b3420so4330116a12.1;
        Mon, 08 Jan 2024 00:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704703967; x=1705308767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ppF24KpgP4fjgy/hlMdkQhkb5I1IwiQejK7rQbEm/PM=;
        b=ag6m/7x0SJQ1qeDuuWnLBi1mjJ362qqHWBH2Vc8ZZ8HwwCFyMEkZafaSCjSejUMaFj
         T1GU4i+fMd5J3EsITrysgq7uakZGRbEGELmj/3Abt4KfiWEk58pZpN0eg4OdGnh2Ba56
         JLWuXxwsKG7yBWGHQ+zuNflJ25RY6znHcVne3blwJaZPkhDMZ67pBw5snzAS3h82MJcd
         DqTyQawtmCGFG6QyepcE2KceOUMcq4JjYoXxjTNeHNbsu+pbPqht1FcTKhcw36ggNbMV
         zIiZAEIHay2aIXvvi+TQSXuDun2TSX6WvzpromJ1wA+m1lEt1ut964qQlTHq2eaWrxqh
         aAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704703967; x=1705308767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppF24KpgP4fjgy/hlMdkQhkb5I1IwiQejK7rQbEm/PM=;
        b=q4pRx8z2rHKgi2uUEyBB2AMi5y6+9ofxVZChk1yfrdYamqe8xtR9PLcqphfMlUGr0h
         HYWN3sIjmDbWFa7Cf5IzXX5G6ZvLBLp4xQ6vA9B1OtOSOBbE1DOHFVCMawOFnGE1iR0N
         GbNXRgxfxhIKPs1cw1XrlZnBItbvMLWlIzwErCcSObJ0D9tCiq0gd9kvMpytTtYVYTlt
         Dq1oT07S2lepnOjCigafafMTN1/dUIB8PvGruGAd47zwkEgFd1Ni7kx2vYvCzABQw0FP
         HZCBHLd2qAWzmGKf+gQrbUe7IFuEGSLsheYPk0Sm7vc6/Vt64hOW5ZHRJOYl0TUZn8yj
         iSOA==
X-Gm-Message-State: AOJu0YxLaem6BVKBtdeQC8XuACeckN57qRPJcrpS3INBel8YyzCq3IoS
	akwZJAq8saeqC47av7T37IQ=
X-Google-Smtp-Source: AGHT+IEZUGj+AGl61d6B5jZoTKEYcG9DUr85VaOxtUgLTqQ+hJ52tqWzHjbsBOE6xTUBngYETXEMGA==
X-Received: by 2002:a17:906:c2d6:b0:a2a:a3dc:621b with SMTP id ch22-20020a170906c2d600b00a2aa3dc621bmr1080196ejb.4.1704703966805;
        Mon, 08 Jan 2024 00:52:46 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id uz29-20020a170907119d00b00a2aae23b414sm666046ejb.26.2024.01.08.00.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 00:52:46 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	=?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 0/3] mt7988: initial DT changes
Date: Mon,  8 Jan 2024 09:52:25 +0100
Message-Id: <20240108085228.4727-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

This work is based on linux-next content and was successfully verified
using "dtbs_check". It's initial code for MT7988A that will get extended
as we get more bindings available (pinctrl is big blocker right now).

AngeloGioacchino, Matthias: is this something you could queue in
git://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux
for v6.9?

Rafał Miłecki (3):
  dt-bindings: arm64: mediatek: Add MT7988A and BPI-R4
  arm64: dts: mediatek: Add initial MT7988A and BPI-R4
  arm64: dts: mediatek: mt7988: add clock controllers

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  |  11 ++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     | 136 ++++++++++++++++++
 4 files changed, 152 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7988a.dtsi

-- 
2.35.3


