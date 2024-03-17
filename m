Return-Path: <linux-kernel+bounces-105578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1887E0B1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC041C20B88
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AC121A0B;
	Sun, 17 Mar 2024 22:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnEjYgW2"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC191CD20;
	Sun, 17 Mar 2024 22:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710714739; cv=none; b=csVrcwHMf5ChHE0nvz6P8/6Pg7u/LmNtcbDu9HYO55wgLVOdp74E/vkIB9/2ATgunR4Q2b8JPRG3GfeEWim7Z5M7SJpSIHWuq1mkSTnm4Ro5cwnhNzFQNZoTSPgH35cSOEoc5IR6zecXSRK3yqpuvV87Snyq95tgQvD4PBkbh4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710714739; c=relaxed/simple;
	bh=YwyXzBsCn0m01mKM2HJvWuLmwm5cQ57o0KjKSzpgtzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggllz7eHZNyVZoWNA5EXkI+Af38GcnX73ZnQCrzP7x99/Hustj0CUl7vsoDTD1jljk943gjdMRulPz3JoV28bKsZRAdb+KmLobSPSGAR/PGuNorXecj7rfmUstIEwOsSB9jFinIH0y30aeRvOOeUd+OBgVLABAqe/rBwMNwnQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnEjYgW2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d46dd5f222so41545301fa.1;
        Sun, 17 Mar 2024 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710714736; x=1711319536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmdm3dIttaltfYgNn91n9oleuQB7czhKG4DCjwg6DSs=;
        b=fnEjYgW2I5lG10xeHMIKViX80wrNufCBuGWjyhrWzCi71okE2y8IF1Pot2THhg/RWC
         9peAy9tGC2dxZcXyXHueemPqmUp1mz3Vz9f5S6uN8C5Bl6GMwF6GHjAa7VX+7VF4z8gC
         j/+2tGa/hHuEZ5TI+1Ez806CHdHLEUlOfopZVmmRttdpgKLPedn113s5YXj+jREJcHor
         ZcYzYbLyl4F/Q3sk4WTpWDi0KTGQLrN8areoeFCNzg4JFhKt4h1UFRkU0e2XsA7yCudk
         bUl0ryZ4GL6nceRSPzy31Aq8ZKOayafMIVZHKv2gSlq071HsW5N9M2X1Ua/Eh+QFK3sv
         9pOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710714736; x=1711319536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmdm3dIttaltfYgNn91n9oleuQB7czhKG4DCjwg6DSs=;
        b=ojQKV2s3MSaue8icbR1JBSget/3P85Ac16MVKpgstJZB/Afkk6ke12J1sJmllvx/wy
         n5sFBQEqa+AArpqFq865mrET6vpUjC7BcuvRv2JFjzeX4kDtECFai8Gt9iKNaPPL+KHb
         jZ8StyFoNHTkQTsFmMwQgy+L0VcXws92Jgc/L3FpzMZykjI+07tV6k6xqdHPLApI6ubU
         SdlDz6S8i2K7P6mOjdTT/Kw8OOgWgqUvFLTny08CIqJ2cwVq6383MdMdjf6o0w9nY65y
         YxVAvzMrW03In/92Y3l/2NLocvwwS3R9JEbUpdn5spcbFrz6UDzY8qdtu1v1LzFWLvBO
         gyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXviYsIfvsbY1hoLnFqy973UUFFQkWp/lRuLzCl0Z3XrP/84jyaOjqk4Qdhnq/WViKKH6fc7uCf+yBBici+jKu5j0UZ45PrdaH8Y4SCJmSB7afELTYk8PbQHnjylH9qAPStnurvkM8Z4Q==
X-Gm-Message-State: AOJu0YyQjaY5u0ZcSAr/0s8MCWrdXpzJq+kdkH+EcUPkpaWxwPdws7+P
	/qEuom/J7OunjZlIYelad1cZZ9PUwKS7FwxCLqLkASSQKeLQv4PP
X-Google-Smtp-Source: AGHT+IFMwanalas0xcU0GCo7+jbgNY41telHFIVcpw8xKYTtxzTPzgyobaq1C/yYMMQnklPjIHsVBw==
X-Received: by 2002:a19:3850:0:b0:513:bea3:7f60 with SMTP id d16-20020a193850000000b00513bea37f60mr6493783lfj.44.1710714736199;
        Sun, 17 Mar 2024 15:32:16 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id x5-20020ac259c5000000b0051322c11100sm1366981lfn.221.2024.03.17.15.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:32:15 -0700 (PDT)
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
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V3 1/4] dt-bindings: vendor-prefixes: add Cudy
Date: Sun, 17 Mar 2024 23:32:03 +0100
Message-Id: <20240317223206.22033-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240317223206.22033-1-zajec5@gmail.com>
References: <20240317223206.22033-1-zajec5@gmail.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b97d298b3eb6..8e0dc4a138b1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -334,6 +334,8 @@ patternProperties:
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


