Return-Path: <linux-kernel+bounces-63554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA915853130
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A83B2640D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299AF5026F;
	Tue, 13 Feb 2024 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRkq3jMO"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08C51C21;
	Tue, 13 Feb 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829364; cv=none; b=j/eQGMJ23JCKrMf7vU1JmE4CvGqfyO7oVdofl+5RnWlRGO/S9wTb0cXbByZmd75Rt5GI2X2Og2gcwM2qcYN1c7wWREIt0DjKILHZwdDcdvf+VnpAttLsMZcMivnkCHMbvoxWGAU0p95ry9cnyFvkMuhiWeW0dx35g83aCLfg0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829364; c=relaxed/simple;
	bh=2UKit9SFgtqvjTbOGGaL+BAjC72V3p0A6712qXbLmfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BUAyfbeoIr/xEkrsZMjV8Vp8Qr7htOwbJcTosBLx3OMfDk1cZnHXlz18+Alo16796QQMH29vSZ72aGYjkTLcUCoMz59EBLHft82VK3H+klHlhu6pG3sq8rK+ww7sEfPaaP1407+GfDwUXLF/xTEccir0T5ysGtWiPrnLht6wN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRkq3jMO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so67635466b.1;
        Tue, 13 Feb 2024 05:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707829361; x=1708434161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FA+jIHvO6N83h8i/+0IHkCxHo1xBrnoRrPyNFxf5Oks=;
        b=LRkq3jMOectfp0YpfhAlDeJPqLUw5LC+nrI0OnDnPtfTsCmuu20d+popP70EGuLaHZ
         vM2Nhs6N7YmMVE/iZHGgn6mS+ziRwGExJcWD8Wp2HGJnVvIwDEVwM+q/yN9g4NBXkdG0
         7hOVtbA6wUH39eUbB8Xt18sWz56VhXLy5tjzKliExJG+cQRODBoaMig//48y2W5O4Si7
         HJgnA0t1dvWZhiuP+vQGxSROOFLSeuSJ2QAGDUomR0+amlzrnLmubnc1El/qg3fKIpw/
         IllNnjdPX0yLQ9wT6Kj9e10ry2HXdqxnCAQ0qhKlh0Ugu/fmJOO785JbKRO0ErkuxddJ
         3yNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829361; x=1708434161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FA+jIHvO6N83h8i/+0IHkCxHo1xBrnoRrPyNFxf5Oks=;
        b=uEGbjTYncdpF4X69GrWHNuQEz4gaaS68XOHF8EteIqqXrO2VQcutYEkrXyNE3B1vDv
         862kcN3AAw2Sr9M4x0ylN8rGGXyacgFTL8ZO/fd602uWIRZawx6Q7vxVH3Y2pB2dgmnd
         0P2ixfOqIfs2kKTeuFIyBFolncfSbAf68imwQhuXz/2rh18bgFR55ozxlgZ9Txp0vBzn
         qnHtBFuoHnERS4gLNfq9mvqya7C8d3CZeWxlekQq4MZCGyaOMhRwQ+iYha/GrgbnKz6u
         EW/7GycUSOefXSW7kT5h0mKaqCGsMEDtLEgmuFHXuCmrqQ/MvUkzT/YJ7nbU4FCLVR4y
         oLEA==
X-Forwarded-Encrypted: i=1; AJvYcCVPluPIEhmD6/esheS4eOF7MW5XQc0DhR4lITh+cSFZwUqAQeHCr2l1LYmbikROyavOUBfid2cWWjmFkFECMKePm+kSmziqpLu6tS1XMyC/hFB+FwMW5YLKowwMxhePXYj2H4XJnv0IzdCfI11m+9B8qhPTn9WID55TXvQySQnMrb98Mg==
X-Gm-Message-State: AOJu0YzstublMdcvLDgPUrQ2TzaIbfVPmeNZPk7IHiUY/6hy6aWuzYjX
	VACLO2wvowQHCGColSDMBqcM9iIKaOYMjLMk7MoB1xskKtfwsN6/
X-Google-Smtp-Source: AGHT+IGLZFPjqI6ocAaqhcRaxmUy9C+7hjlIlp7ayrZIp/AsNc0AgtcJB7Qxj0AFAKUACpijfOXF2w==
X-Received: by 2002:a17:906:7db:b0:a3c:3411:de61 with SMTP id m27-20020a17090607db00b00a3c3411de61mr5741003ejc.40.1707829360724;
        Tue, 13 Feb 2024 05:02:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWI55+H4k9UgqDL8KLU0rUmH2A9ZLaSIsHdTf4k9CBW8dH54wO/DOBOCkyFHTqJiPEX0c0e0wYflDM7+AI7x6K17BAUFqq6j2lh8k07nujtqQkPv7w7uG63Zx+5p7WHh80vNaPZ/rXbVU6evNkn7/Lso6xD2BVEvPZKfuF4Qgh9r0F+lKh15OpYg+IyEVNtiOGBba8z7FRYpbvP9QimVyuT9cULQ1qWwob3RgG55GRryjEugtLgBmAWkyjidGEeNu48Ic0RyYWgEPi7TKGXwHwxdPnqJI24vJOUCRlUcj+wYoc9Li8fIem9CMGX8M3tmtwAEeDtCG5Vnz+dRM5cd5mkBj/NkK4lCjRbnRsUrD5NW+PovYwvAPfWqXtWAxa9ocEMxj14jDZ0gGW6brFuWSWZv0oCDeIyKXn9ZKbvlvrdWa33sYvRyIk5onw2KWBCjGdH5/8uLK+vKQoK2nl12CXt1XwG6Ifvq45xuyknHyKyib/Ns8UCtE1svBDDejDTtk0SrSIDBZqirQCIiX83SgutbK76Lh0M7ZFgU9qdhtOxGw==
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id cw15-20020a170907160f00b00a3d004237ebsm633078ejd.212.2024.02.13.05.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 05:02:40 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: usb: mtk-xhci: add compatible for MT7988
Date: Tue, 13 Feb 2024 14:00:43 +0100
Message-Id: <20240213130044.1976-1-zajec5@gmail.com>
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

MT7988 SoC contains two on-SoC XHCI controllers. Add proper binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
index 924fd3d748a8..ef3143f4b794 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
@@ -29,6 +29,7 @@ properties:
           - mediatek,mt7623-xhci
           - mediatek,mt7629-xhci
           - mediatek,mt7986-xhci
+          - mediatek,mt7988-xhci
           - mediatek,mt8173-xhci
           - mediatek,mt8183-xhci
           - mediatek,mt8186-xhci
-- 
2.35.3


