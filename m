Return-Path: <linux-kernel+bounces-60961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 114E5850BAA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 22:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2257A1C20D5A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429F25F492;
	Sun, 11 Feb 2024 21:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8BMww7X"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835D5F47D;
	Sun, 11 Feb 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707687578; cv=none; b=LhQ8CWS+BwGi6LgqzD9IVYzj+xpU/NxLRWAbDFYuJNi1m97g4NBCfUtJ2vA0YwIsYORI4F3hMSiEX7c+b6EcSFIZ1SNqbrSKUIoPyznU6pBR/QH6cZZXrzWtBUUdyCTzFZBfOtZb8SL0UJGnrH0RwLesCrAdpdPKblEabfQaESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707687578; c=relaxed/simple;
	bh=b/McZAbwOWgihgayB8ufX3ArnSpciRzQPcYkpngJu4s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Fmv+ynYyg3KpU5cKJ6idFvY5Um+UvjvrHN63PwU8vsFCRmyFEO2o/liHpbnBIiOhJvHfNORh4r6AdsyDJthszF5RXPTN3k+FheY4UMvFjG5qoepjMCQDVRe1dGwd/uPUXAGJ7ClQdsbAf8X/o2robGlls9wB8tpwD/KLQYDWeLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8BMww7X; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3be9edf370so283390766b.2;
        Sun, 11 Feb 2024 13:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707687575; x=1708292375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XXP6rRuSuhpj3qhcdk0ROpSfFQMPM9dLW3DXtXsKv9A=;
        b=E8BMww7Xqlkfl5kC8Km9DqpjcLNnHNUbWZqNZbgaKzsx6kF59ocFe0+QBcxaqO6cgS
         t4nAyj+57tvv858VDFNKm+aolooHvM+vrG28DIGHXdLm/dJOW5Wsj/m/rm1JXyFvTIP6
         VJbFSUi7gcE0RWYAhrDTgUiFciEamvH9defexf6iQe4f9l7qcA87w5W+Nxtgffc6ksNt
         3OHzNJT01gi2QWvllX1n6ljhKEsJxHZn4A8DUIUiuQVrQHa28o6UqVYY5K7JNyMr8tqB
         PQ8fRDGAG1eNjvfY4adYoShsK3cLTebI1p4EdF2mj3LzbDz6vKT1wSmsf3MEp8ALPYx+
         q8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707687575; x=1708292375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXP6rRuSuhpj3qhcdk0ROpSfFQMPM9dLW3DXtXsKv9A=;
        b=FxQ8Vk0cLqXDsD+7alXmAmyVzoL8mvxZXAFCG1EZmm91bt6f37/c3ptTs+nfiOOaXk
         eP3fT8EioGC2DrNwAas+IncaHIwxCrrPdTinFWs0GxPQjmeHyjwGx4DBltpMe1Muokke
         avFjhz6qba2x5XTM3S/RYH355i68SJ1aQKHkJGlByetVk9NbUcFvF/oYIgshwvdC2OuB
         lANPok0HV0n6DZFJrghImuCj0w/QtvlX/ByM2JDek56nTN6q12cYq99mxeKnW8u3lA4z
         w/kRv/4TZ9b3C9L+X/7R5m19H8cr7hfJ9RtGEyXSmZ3t8fAMF6giqDdu7ddrSEa4TN8M
         UNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVffKkLsc/1pkfseJU0EybPrndPR+JyelUl7BhVm3yuWkxET2X6MxCBq0JjNTRuEK/QwNDvjfJQxEcOACF8GDf+tUo+llihmHiMrj5ljcZUGZM5V+YJdgwTeVQbkioSeVWkCRaHqdRnaqkLWFPq3lzFMaQcOb3mNXSwrJ4AtVl8wHmAMw==
X-Gm-Message-State: AOJu0YyUMH1UPOL92bX/LshZttzbR8Kb//68YCDXooYC2bamvXKzWduB
	GpHdpDf/k+6Bcw9cX4y9vQTJ/ZPZxIoTF5aw/Xk5bdPWJlOWj/CU
X-Google-Smtp-Source: AGHT+IFVGzQFDZaB15caEdzv/S+0ftQ7S5MLO9wsKeY/jCGq+9Ri4eIH+0EbIyZcz30JV0xyv8TL8g==
X-Received: by 2002:a17:906:4544:b0:a3c:8bfe:319f with SMTP id s4-20020a170906454400b00a3c8bfe319fmr1099357ejq.74.1707687574886;
        Sun, 11 Feb 2024 13:39:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVe/erHX0IhHagaiiBCebAgfY03CfDoycttJ6BPox0CSr6uApzK8+4fKAGuQ9x/TiWB1x9S70jW0KH3Kgrghbgeh/SnLVsp0p+BwAb2Dtg7lDg2LraL2C+TVVmpCec5BoDnAg8YXLady6EXC0JwghJiduKEVfMKwtM2Zd63Wt1d/UKQ3chX4r1IHobElAjBbljQnk7GuBisZYOe1Aw77jRGQDLpF8D7sg2WD69vw50beNcM9iaoi6YEvpnTs9f1c+axEMqOpp5PaSS+dkB22uZzgm4VxkNdAuNBI6dgpAQLqUnidhuE9FTKcYqHm6DjtPsITn6SkLdFUCb+r/QiCCLuLdNsd12qrqth/HondIyYPX0qaWKf8lOT0R0uipUS+dcYsKUOHDpjrIVadmi3JycxMe4vrJ49iYg1i5P9wOrHP4C0eUMZTWr6+coo7UxEe+9I91J6PaT/KUWjaT/z8d1yXlcDvvVQ7eyKBEu0AjjungNw+v+Wga4jTs0uopu3a1YcdnE=
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id ps6-20020a170906bf4600b00a3c66ac512asm1206344ejb.214.2024.02.11.13.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 13:39:34 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V3 0/3] dt-bindings: arm: mediatek: convert MT7622-related bindings to the json-schema
Date: Sun, 11 Feb 2024 22:39:22 +0100
Message-Id: <20240211213925.18348-1-zajec5@gmail.com>
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

There are more MediaTek bindings to convert but for now I focused on
those used by MT7622.

V2: Move bindings to /clock/
    Use clock-controller@ nodenames
    Drop incorrectly specified "syscon"

V3: Update titles of all 3 bindings
    Simplify HIFSYS compatbile (drop "items:")

Rafał Miłecki (3):
  dt-bindings: arm: mediatek: convert hifsys to the json-schema clock
  dt-bindings: arm: mediatek: convert PCIESYS to the json-schema clock
  dt-bindings: arm: mediatek: convert SSUSBSYS to the json-schema clock

 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
 .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
 .../arm/mediatek/mediatek,ssusbsys.txt        | 25 ----------
 .../clock/mediatek,mt2701-hifsys.yaml         | 50 +++++++++++++++++++
 .../clock/mediatek,mt7622-pciesys.yaml        | 45 +++++++++++++++++
 .../clock/mediatek,mt7622-ssusbsys.yaml       | 45 +++++++++++++++++
 6 files changed, 140 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml

-- 
2.35.3


