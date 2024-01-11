Return-Path: <linux-kernel+bounces-23390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE50A82AC28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3B5284125
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C99D14F83;
	Thu, 11 Jan 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1RsDWD7"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDA014ABB;
	Thu, 11 Jan 2024 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ec948ad31so3858053e87.2;
        Thu, 11 Jan 2024 02:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704969577; x=1705574377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPI1X20P/Je0ba5yFdcffHFwmZ27vo/Hq5v/+iKRorM=;
        b=d1RsDWD74z9SkLWtuBoidcp9nYJgPe4TS015Zr/5zoasuDISJ0GqcqnyBCLY3sSLKa
         dVGFzPMcX+XFWwvb2Juo4y4xXyISRx+PydpPvTcCt/cxXW50zf4Qh/e7SOrfWYsTouPj
         Giez/sA3gjEr0FRssT2HFrX0KE/QtAvJzLE99NGhDbXYG/N8pn6sCNGtBcwjLFgVvtI8
         zreQjtBnibZN6BV6mTB1o8C0zapDeTZeKtwaMqyIdDqM+22BMTQFOVZPkDt+n0rxGvJk
         Z8ba6/yhIp9jrvHjQH0u1HcmEUf9ZE+MuAGsryJ2sqi6wsNGt/o3X/dUA2UVNV07Y+H2
         oiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704969577; x=1705574377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPI1X20P/Je0ba5yFdcffHFwmZ27vo/Hq5v/+iKRorM=;
        b=vCS2z32WLFyolsSI7kNdSNFTPmQFP3bJsgVpPzp7NIKHD/ZHnF7vAgvHMdBL5tPXt4
         DMWoiwB0iECxa5r5v16M09GBrJb3XuisC/4GUqiUv6RAslwNclr8A0o3YTzYcu52YrMX
         pb88oxX5XcWnwYGRIVZU9kvMcpkPRnIy8NtnHDoSjNZGNB1rddDcwxmcVL6PwpehQhEO
         e5dRRLHx5RqkhUvxMHxvHcHKRS1Jfu2OInC8H4SuJ1sN8DW6Odf1d6xBzgKTAiGW1snx
         2TDuZ/0D9SY9EepCULgA5oL9PxuMJerHR67rOEmL1D8SZx2o4aNC9Yl+UmS0h88DsK8H
         3LUw==
X-Gm-Message-State: AOJu0YwaihIPRw9sUXZTh7RN+eLqbLVlTexMJ9uu7/LOB1Rp8x5ToWKo
	AVvvL8pWCM/PHJqT9nayxj8=
X-Google-Smtp-Source: AGHT+IEpoHyDf1gqLg9M/jmdtKfdJe1FslovTRkFcPaMSTdBqVE/TypY2qP1lbz07KRoJPguDTflnA==
X-Received: by 2002:a05:6512:31d2:b0:50e:7ade:d394 with SMTP id j18-20020a05651231d200b0050e7aded394mr636997lfe.0.1704969577147;
        Thu, 11 Jan 2024 02:39:37 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id d14-20020a170906c20e00b00a298e2f6b3csm407179ejz.213.2024.01.11.02.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 02:39:36 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>,
	jason-ch chen <Jason-ch.Chen@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	soc@kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V2 1/2] dt-bindings: arm64: mediatek: Add MT7981B and Xiaomi AX3000T
Date: Thu, 11 Jan 2024 11:39:27 +0100
Message-Id: <20240111103928.721-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240111103928.721-1-zajec5@gmail.com>
References: <20240111103928.721-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

MT7981B (AKA Filogic 820) is MediaTek's dual-core ARM Cortex-A53 SoC.
One of market devices using this SoC is Xiaomi AX3000T.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 92dbfb862757..12cf02b30967 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -82,6 +82,10 @@ properties:
           - enum:
               - mediatek,mt7629-rfb
           - const: mediatek,mt7629
+      - items:
+          - enum:
+              - xiaomi,ax3000t
+          - const: mediatek,mt7981b
       - items:
           - enum:
               - bananapi,bpi-r3
-- 
2.35.3


