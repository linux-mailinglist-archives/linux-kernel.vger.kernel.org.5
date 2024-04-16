Return-Path: <linux-kernel+bounces-147176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC55A8A708E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BE4B24C44
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F075113A40B;
	Tue, 16 Apr 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N7hsaFxW"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F9F13A24C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282821; cv=none; b=AAx5NAe05uOY9vb7ASm8QMbTLflfu+rOT6/tVRhN+U/7GSqRBbTF1VCvXNy64+fZIm7m+OV/CiNFDq6KMv18PV/TaS7djdWLa0tjA6RcHg3/z02CCrWnoNyyuFTGxRlSUHUoGXtUD6HXpnicu3diOOLPbn0h4a4iKOULT2FvKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282821; c=relaxed/simple;
	bh=f9Dg3+1sA9zIqMbmOSkIqYRfnGnKgRgwjxFViDKWg4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYp1AkvAUHZbd2FuAp5QjY+iC1Hd2ZMoewaNKlVoORzpIL745MffdIPoiCo5wh+9XR32p/Ew+SHqGbfV2yNboICj5MnSTT+9N0JwXJ3J+6jUD2Kn1oYCUTY3aah9qOAtUi+NNUk0mXW+tBxKIcL9fKUlEvA8NRHy2/iPKzXOomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N7hsaFxW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44f2d894b7so514409266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282818; x=1713887618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMzjdnJXuF3c5mxPh4yfDUlaYNvWD0FrUY1FJvWIAwc=;
        b=N7hsaFxWmNBxxA0OyxCT18oZaHku6KCyMzh7udMqADYo74Y6M5Kkf4CkV8EtDneMWL
         7e6m3E4NQiL3E0DcW7EPVMSYnmLhFiEayzbPSvSmIQ9RZ/vas7HjjTeV4ZMeaXlngKpj
         ffrTCgWgm58tMXEiQLSSDb2+Vo6A4kbSc8kWqBbyAEMmZv2hHGTibkR3ot4JOGtbpx43
         KRFYdL/pOftl7HkQUdKkV4yDg4jFLxeBd1TPk5HZk66sPHkhZBDAWLYR1f9AOVrzsu8q
         ZDlKxI+uaNHw0l6Fuuz/ZKoaYGYnqcgOVan2jHpt9tvTqOsrKPoyVy0JQIwCjg1c00za
         LOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282818; x=1713887618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lMzjdnJXuF3c5mxPh4yfDUlaYNvWD0FrUY1FJvWIAwc=;
        b=kX95WAKBqbc0zNPuEPcvKurulGeMFfEEdzR9fSgEc/E8Jd2bZBPibCUItMvvxQ1fqv
         067QLZnIe9txRvcIIylhgK3tCfTt4qCv3xRDH36RtV65TwNW1vI1/aPspy+DAm18vO1C
         9G0vez89/TmBRUfFNaWF7LsfZaV8oPP6ZPwHEfpos+fjKv4cqxnInIDHQnfBKLYCOpAY
         mlwinp84M3Imwu1X9V2+lz/2Pcq2FSOhCttKnREPGGi0ns+GJfp1fueD7lL+tiZk6Lcg
         oeWos/XZEsinIqD3x44HIBe9HIW4YuiP4UW4zr3iawqm9DZWV1BJwar1WT5lNp4nne8G
         BMvA==
X-Forwarded-Encrypted: i=1; AJvYcCWNPLEfqitU9VKFpANPy/4ZbawNMFSzgpIroADIzVZT1Lj3lyVmFg7eyFp2imNR61lb/eb0hSb1J4jHDREoTXYRaWEzGtTD1VGEqjib
X-Gm-Message-State: AOJu0YzBC49lPA8zC5Y4AKKk6qM1V2jFrZDzH3BHm5W5KTzRaFx52LqY
	UPRD6q1s7v1OqtBc8VZndF9h3BgzZ7sYhSAp6+bwLH4Qyj0s4xW16miTfWZchugNr+fin+PiLPv
	54MA=
X-Google-Smtp-Source: AGHT+IFk1yoWGLqoBymQWKpJEhd6iWeTqSjELga+zlWWHUviknE2SG8H+UAr/d3dYsubXWOrLr++WQ==
X-Received: by 2002:a17:906:48ce:b0:a55:339d:bd20 with SMTP id d14-20020a17090648ce00b00a55339dbd20mr3437290ejt.51.1713282817957;
        Tue, 16 Apr 2024 08:53:37 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:37 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:13 +0200
Subject: [PATCH v2 12/18] dt-bindings: pwm: mediatek,pwm-disp: add
 compatible for mt8365 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231023-display-support-v2-12-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=f9Dg3+1sA9zIqMbmOSkIqYRfnGnKgRgwjxFViDKWg4s=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qCtkudbE2FgoQGnKNS8vlj9WP5d+Q1enfhm+3
 WS7W4ryJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURauREA
 C8elBHPUwyryiqhU/JftMEstWEhAI7HacOE+GjDLuT91DQoGocSdM/By6VXYsbFsuP3J2Exczi6frz
 ba2GCWSVUwiLb92u1hQpINL7ls0qmmh0r7yGgl5HnwjxAX+Zg4C8yBRoPI8RVLyfU9S/r3fPMRYni6
 Wpr0HozZOKrEQ5d0E7N2R0yj8mjdbLL7woEJYhC0OB6iOVGvyfeJqrSAD1z2BjdwlAlogg6zn4eWwC
 /asr3730Ub39vA+1gIunga8bVsoqsBzHP2xH2WIsGpLHvnHuWyGehFvyUFRY/VhKwNk/myhcyGWAdV
 Y7R57eYwNSHunhPoPnXrH+s5tGAIXqTHmctxoTL1WEd1ASFeCDB4fTxebJYFkaYyULZiWXDuE9Dt0o
 9eLZX9QjD3wcbt6howeDIggSZ3VAY2T+cS0ibSSqBOLMtALjTGE4VHqb1dD/xA2X8dTwyNeNL6eLsK
 MlNvds64Wab3wKigMbpCRWW41CI+jbomgQENOsjcrkA63E7UwXX9i3CWKbIFNn7yYXRnQtF9/ou9oB
 0/4QjL4id4kIukWNLEgjLCA0Wmwdp+jELa8HzLKgqyT13FBTs4FIX/w4if4EN86mMTaKGGznQSt+cY
 sIxk3H1lFvV+liAj3rGgvXTfPVUrOH+OqtB1mIROI0BYACxwnQsLCcUCN7cQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add a compatible string for MediaTek Genio 350 MT8365's display PWM
block: this is the same as MT8183.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index f8988af05287..180dd8366935 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -31,6 +31,7 @@ properties:
               - mediatek,mt8188-disp-pwm
               - mediatek,mt8192-disp-pwm
               - mediatek,mt8195-disp-pwm
+              - mediatek,mt8365-disp-pwm
           - const: mediatek,mt8183-disp-pwm
 
   reg:

-- 
2.25.1


