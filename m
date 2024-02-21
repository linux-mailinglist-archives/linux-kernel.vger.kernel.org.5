Return-Path: <linux-kernel+bounces-74243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ADB85D182
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2401D1F2369E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D713BB28;
	Wed, 21 Feb 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji0VEXo3"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422339FE4;
	Wed, 21 Feb 2024 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500968; cv=none; b=IYYpeFWNfUREduzBB++3p/PxJtkmO7E91hdNbz/Dppm7CaXLRFCvDTfaRsF0UTOyfMsXW20/bmtKsdqLfg1yV+NAP3yai8iRYUGTyMCCsf067Vs1ktNKKDvpD1rgktd3aw+0gM9VKeWSHZXXb7ZLhhSvFqXLhbYXQwL7gHMt6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500968; c=relaxed/simple;
	bh=IXtgJ7B52SSM6oCdUaahthr9WdWayBzoYK4fhiqgrbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwNyNy/x7MebK0RUhoyNrMbbLgQvJHCT469K7MgYWeh8wztvwTzIMxjFbBuxe23ha7pMdUREEmpu9Etd3RvHXyX0l42rR7kP6f2Tk5UkYul6rzhd/eG7yj8mqP1WJxMGF9rWKno5437x4A+J1iTHhLUKef+Ox1b2+TnSqOl8qPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji0VEXo3; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d24a727f78so17895811fa.0;
        Tue, 20 Feb 2024 23:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708500965; x=1709105765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGszybDShMhaNAGR4ySRJN3naBbuC1XXSNLMe7bzTxk=;
        b=Ji0VEXo3UwQpM5d7ojDUBFI83naVF/SB4V1SJVIkif1H4EWAR+Mohz4VnGevNNQNJA
         Eq/f2CsTV17I4Hg2orAbj5E4mLih4QW97t6BV1vJedCioMz7mKZSiDEYW1eprblSVie3
         Nn7hGPrUjSlEI0gqp0KUZDOdDXw9opmm9UzCu1On5eBm+ZFNevMAcFveIl/zaZKBByVu
         rDnAiO7mb2YrDipORxsMeEoSkozXQOehsQroehdagrK3BB+ZY1mcLMNCfWET115whEYu
         96qLUHrPBSa9+aEmSFQPzP5zcDwJFYd6glQQD9gO4Dg1oVpQjmzHn3A7AyxMNxRhoWOV
         DBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500965; x=1709105765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGszybDShMhaNAGR4ySRJN3naBbuC1XXSNLMe7bzTxk=;
        b=nBOgwiCApvtSQYq4qx5WqJ4HrdCPkOJfvcw5O4mUggaOR2WiMcTV8FPKoKLmaShazF
         XOzWDs1YhH9zSTfpoFVUc1uchVYrywdUbySM2a22svP4jVnfdSmpyVUx6r7GaqeZMr31
         3ScAD+Eq73T/I+QeL2lhua0hvzYCPImde7lcioRU7fZBjQ7Zfh0m261S7QYKcJALmQoH
         cLbFAmSO7592PcUB5IZc/nK00A17tFAxdvf5UIML28UvPbw/rkZjiXA62TjPnQ5yRwPc
         WH3mM+maFiEvtxHbqywd/bPHJftn/CsPfnsFzWonMZEn1wWRWPYc5/SO58Vm4zULIRia
         MMbg==
X-Forwarded-Encrypted: i=1; AJvYcCWRRCWzLbZ55aWRdny8f8jSFcG6gsL3FWn+KFwweFm1gSj/7+XXtB4T3uW5DU7tJpQ51jIuU4vL7PEJxLlf88+VkD4B4EN0LvNfFHZ/2vrYeg02I1ho+naO9KK4u407qrQhO19zeuBjZw==
X-Gm-Message-State: AOJu0YxD+nHB1h1x+FRawyMmg4kVlLAex95B0Q1cYnrIGRW6NG/LEDAt
	DB9Ss4pRww9jxNWihyqxPoe85UU/hjI4HRmglwu1jmYujkv4l9Mm
X-Google-Smtp-Source: AGHT+IEpDpUFtOBVRxAziPmxL4BsaHXTCxebYbK1exwOUJPejgWUwRRCbEDLbdQydsLRZ1dJd1tQCQ==
X-Received: by 2002:a05:651c:1a24:b0:2d2:396d:66f1 with SMTP id by36-20020a05651c1a2400b002d2396d66f1mr8456718ljb.47.1708500965056;
        Tue, 20 Feb 2024 23:36:05 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id z3-20020a2e7e03000000b002d0f99a7fc4sm1722330ljc.79.2024.02.20.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:36:04 -0800 (PST)
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
Subject: [PATCH 1/4] dt-bindings: vendor-prefixes: add Cudy
Date: Wed, 21 Feb 2024 08:35:21 +0100
Message-Id: <20240221073524.20947-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240221073524.20947-1-zajec5@gmail.com>
References: <20240221073524.20947-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Cudy is a Chinese company providing networking products.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2dbcdc5f5d7d..cb4dd176bf41 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -332,6 +332,8 @@ patternProperties:
     description: Czech Technical University in Prague
   "^cubietech,.*":
     description: Cubietech, Ltd.
+  "^cudy,.*":
+    description: Shenzhen Cudy Technology Co., Ltd.
   "^cui,.*":
     description: CUI Devices
   "^cypress,.*":
-- 
2.35.3


