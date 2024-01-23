Return-Path: <linux-kernel+bounces-34882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A28E8388C1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A561F22B9A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530B56765;
	Tue, 23 Jan 2024 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZ2He0UL"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C556741;
	Tue, 23 Jan 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998104; cv=none; b=WEb4O/OcM1nZ2EJXOFwyhJa3srZk8EogXDLhKorT+D3pmKX3CJbBr+hOWK7THJf4xGf3E0D1aoRca2KUYB2K9mMq/oBLnbs5/iLtXhVnVKm1SkJ+wC8XsMAwXo1ZR+QgYfoM8V9uGDHG82NEuW5vuMuNmx670CNfQM9zssKpShc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998104; c=relaxed/simple;
	bh=h5Mtvm9/njbeiueNCib+RM+5uzF7as2WgQNuvCZscA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LuQ1dTPypQuWhqfpwreHdR4121i6bcj5+z9ewA3PKqX8BTo+geShaD+drdcb9zFCOh9Brg2+Q9lXJpMuL2+QV2PVXgrJs1bcp5fje4K4cTpl5BtPkPuiS4583dJ6tNGGO9TR3f0/mke1Q1LqbZOrEdwDtzHJlv/Y9QFlX5zAjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZ2He0UL; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so4548297e87.0;
        Tue, 23 Jan 2024 00:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705998101; x=1706602901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5IbYX72GKDgKEeebQF3JWpFaouRh1FyJnCJ8FxmRXQ=;
        b=JZ2He0ULim5tKedwrOsaph4lPJtaxd+ckyvS9iptiav3rusbFM0mA+KLC/NpvzBKHc
         tGzuWUN0/ey29jBhzwQrU6wW54Gp716ASzZ2XUntinEJdQrJ19a3ZcWJV86S4cEJBKNp
         06J+J/k4WF9jPb7CkOyay39BkdW2sWluxDmDOEM7t0/7yH5No0g/xumFebQsaV862vjl
         6QW1Am7bsZgMs0jqS24YTySeSaESUkdCccYBtpn3I0mm1rGEBFH7W2PLUTikpUmxPmcO
         LyHuxSgAq7dybcu7FYXiQ0uvYAtQN0QqSSW7OgdOOBZ3sZeUjA3JngjqCd5kOHm6PQ3k
         FN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705998101; x=1706602901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5IbYX72GKDgKEeebQF3JWpFaouRh1FyJnCJ8FxmRXQ=;
        b=a3+f47Tx8ziX7WPUHh38LClJBDr3vwka/wiKZl+KKnitKmAyP0Uq4XDeZzrunpjGlD
         NAJi2h4EJic7kndX8ZIBRd1u9BCnly4zL0jlLoN2g9IPaluOAqzAz6iXF5eQbrOFwTbi
         as7XK4vi0AwezN3R+xUtUPq82tltolYMM+LLYouqT9hTKlyzn7JMDtdbVWEvrlkid5j2
         KvNg+u8b+lKvl0bAsZxfYmkR1XS44lB9MUClnx1WxTxS6mgxySvdtfb+D/cy+qk+hyDF
         PWQXQ7HEKFKtveel+UHkvULtQGtIxqOKqjsKgPk7+J7b+YjkMySop9uDnvAuGEJq4mVW
         s1sQ==
X-Gm-Message-State: AOJu0YwrCt+G+fPU6BOpCcBEcVJkeR5hAzsLsPUD7Tzmh9qdThB+DEOf
	/jST11Q/p3XzV3RpwrDYkNZjXxvpnu4Rok2dh8V7p+ydlTRfE0E7
X-Google-Smtp-Source: AGHT+IGW98fsghFfKlw+hkN3TgO1Gz02ckvGCA+O1HdiFcvUycwq8dljNadfhv7w5DjrFW/E7/gJmA==
X-Received: by 2002:a05:6512:31c9:b0:50e:2e5d:10a8 with SMTP id j9-20020a05651231c900b0050e2e5d10a8mr1214541lfe.133.1705998100946;
        Tue, 23 Jan 2024 00:21:40 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id u11-20020a056402110b00b00558aa40f914sm14810435edv.40.2024.01.23.00.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:21:40 -0800 (PST)
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
Subject: [PATCH 0/3] dt-bindings: arm: mediatek: convert MT7622-related bindings to the json-schema
Date: Tue, 23 Jan 2024 09:20:57 +0100
Message-Id: <20240123082100.7334-1-zajec5@gmail.com>
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

Rafał Miłecki (3):
  dt-bindings: arm: mediatek: convert hifsys to the json-schema
  dt-bindings: arm: mediatek: convert PCIESYS to the json-schema
  dt-bindings: arm: mediatek: convert SSUSBSYS to the json-schema

 .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ---------
 .../arm/mediatek/mediatek,mt2701-hifsys.yaml  | 54 +++++++++++++++++++
 .../arm/mediatek/mediatek,mt7622-pciesys.yaml | 47 ++++++++++++++++
 .../mediatek/mediatek,mt7622-ssusbsys.yaml    | 47 ++++++++++++++++
 .../arm/mediatek/mediatek,pciesys.txt         | 25 ---------
 .../arm/mediatek/mediatek,ssusbsys.txt        | 25 ---------
 6 files changed, 148 insertions(+), 76 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt2701-hifsys.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-pciesys.yaml
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt7622-ssusbsys.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt

-- 
2.35.3


