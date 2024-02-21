Return-Path: <linux-kernel+bounces-74241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52285D17D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A17C1F24ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAACC3AC34;
	Wed, 21 Feb 2024 07:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuiWCloo"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7724B57;
	Wed, 21 Feb 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500967; cv=none; b=crehpF5X/fHK57Xf09fl47mUsygPALzZ09LkQHsGRZgwvADxGabTvZGtdqcJE1DKYGEGFTDaCYXT0vDzJ9AyFJwfALLtKcXxZpm00la+q1Os1AHHqrn1cKebUuWJGzVABlC7EOZMvd95d+fwuRwG1C2f6OAxskVFW04SQqTDGkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500967; c=relaxed/simple;
	bh=7Vu3rzmObUR+9w2tRopA/lV1r2L5Wu7SYWF1FkmQ0a4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iMJXmmaQukw21+oaM4+LoiBMg1IoSejz8mIrsKnOSoKYbVc/BVocYgunSsXlfO6a3S0g82aiyfXKVCc7Ks4p4tpf/BrWCZddJbaWCHuGAwNG75W0GQlwYHKfugY/43QiYSRLY3Rv3tod6jOhEDHs3WZJdhTRDALEJ+ImoFadTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuiWCloo; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d208d0b282so84721891fa.0;
        Tue, 20 Feb 2024 23:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708500963; x=1709105763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8M8/d2Svm/+PW4IDvaS8Rs5nXrVhcfBCXs/zLlxxKUw=;
        b=VuiWCloocMFbD1MSntf+L1a9UIdOimknj+YVjhI7g4sdCHJQX/L5eeGBVGQwUcm8y2
         9szToLb+78ZISolGAFkh4TuUpfKP4z+oVbWmXTBpfqEANhn30k88kFFZ6LpXZ4XGYzX+
         E4umzNeoyD4Ucg74mLfm9wNizm5QQKzf0vReFy56f15t6v14CPBXIBw9j69shergWhBb
         IwEoySulXIPSQjYBu3ionBVOdUCgbQtVt9Bi+63xZMockpcYvZ+YwqDZBuhM3+cbQ7V6
         0MfmdiClBdU7rVUQLTMIKNn/nIbV5IkuEm4HalpBZz220/JHq4HSkXZF+3tkTx8R78fy
         HKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500963; x=1709105763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8M8/d2Svm/+PW4IDvaS8Rs5nXrVhcfBCXs/zLlxxKUw=;
        b=TW6qEma/mx81kbM5AkwhAy3DANhOvbNjCXVETrorppYhYOESuRrkXwA7OmGN5gALNV
         x6Ph693JQpI7B6UF2ZiAqxWbLXmfGL9t6P5TGAQWB0Bs6l0wkYDb5OiqOzTTqk8a0nUn
         tmAnHBxVyW7sYkAmHpDIrI9asY/oRLy/TdBROlHDpqFN/gqg6iA4N7BSVEiAlKuffBz4
         0yGWvCZSgdNPfZFh919u1zjzKOYLga09HyMIHOkJbv7/3XnH4gjzVr3IJeBSdeslJrcs
         s5maQM14XvwM8lkBkC4VbiTevUjeaQ54dBN3tlNuxuaxl/bZQ5WJlz9s15qjQdbsRZN9
         FbOA==
X-Forwarded-Encrypted: i=1; AJvYcCUh+hSJtTd5+d8tz2uW31LP8qNnAoCYcIHSWeujNcKuvO1qD5G840w2mTNMz1IXYlIc6qH5bYbtyBVzXut1NKI9nm9pkr3LNuohP+qmq9tzLGmiqs1jbOqnFwbxzDPuoqPzXRzhNb804w==
X-Gm-Message-State: AOJu0Yyhy7NIZc6KsYsb8hyCqSI0YAe5D5u4UZEE10rpeR15mzHM2ftb
	sBws9UgXCa6GzRWFXjpB5uV2mn1J5YPOA9LM1DU8bXUEUVG9yV3T
X-Google-Smtp-Source: AGHT+IFE6VuOfV8rlKed7pgakLr9/jErXT6huX7tGt/A7H+Xjl8Zbc3QW5Xe879Z7XUiPdk5AR8aUw==
X-Received: by 2002:a2e:980e:0:b0:2d2:40c6:b7d2 with SMTP id a14-20020a2e980e000000b002d240c6b7d2mr4278968ljj.26.1708500963176;
        Tue, 20 Feb 2024 23:36:03 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z3-20020a2e7e03000000b002d0f99a7fc4sm1722330ljc.79.2024.02.20.23.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:36:02 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 0/4] dts: mediatek: add Cudy WR3000 V1 wireless router
Date: Wed, 21 Feb 2024 08:35:20 +0100
Message-Id: <20240221073524.20947-1-zajec5@gmail.com>
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

Cudy WR3000 V1 is a MediaTek Filogic 820 based 802.11ax wireless router.

https://www.cudy.com/productinfo/1637722.html

Rafał Miłecki (4):
  dt-bindings: vendor-prefixes: add Cudy
  dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1 router
  arm64: dts: mediatek: mt7981: add pinctrl
  arm64: dts: mediatek: Add Cudy WR3000 V1

 .../devicetree/bindings/arm/mediatek.yaml     |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt7981b-cudy-wr3000-v1.dts   | 74 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7981b.dtsi     | 37 ++++++++++
 5 files changed, 115 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7981b-cudy-wr3000-v1.dts

-- 
2.35.3


