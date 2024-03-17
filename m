Return-Path: <linux-kernel+bounces-105572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2890E87E097
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491BF1C20E74
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D7C22626;
	Sun, 17 Mar 2024 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaPHg70C"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11106219ED;
	Sun, 17 Mar 2024 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710713500; cv=none; b=L5b2m2GMUrw7FaME6q/S1hH+SGTUPVCqLc4MvPs7ZHpyx96PQxGok6hXfgLIIBU8McG7ejrCSpYn2dKdzqMUTOx2rTKTiFcPTGkSvMKJ7QKA/HB6XjfOWRDinbBXwzVluFJ5IKcu11jJ/e5JT3UVgllat4WMD4poD4ptobku3KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710713500; c=relaxed/simple;
	bh=jIW3TlTvmfIt8ITt+NPCsYCUedP6AKKFqE7ZAbb3IDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsBYaHJChL/mq7mXLYfuY9DRdG+gm0/siA1FXxQvJ7AlzAEzfKh+CLeRxaw8rbMvI8jNKhZuolP5DhZDkNtHtAA8OvkCdxg8bxG++1cw9vQPeIqH/TWEOmCH4CEvrllDpvv9Ae95Cfm17o4hM9XQdBd/p/wC9+lx9L8tZXQmj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaPHg70C; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513e10a4083so1376913e87.1;
        Sun, 17 Mar 2024 15:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710713497; x=1711318297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJJlhZxC3DnR9uX0BGL/zK0LyaSZIawKZpI8/wEQi7I=;
        b=GaPHg70C0eU6Es4pKVSJ5yRzkJpPalTnGRFU5TjbUbwMW+FJVZiQ8A2CNLFL1YVLuO
         kVpvSaz/4WYVP4hJzdsELU7bcGKkZ1cz5PB+VQLSFduty1mCJK11sJNTEIY1UhAzwjP1
         14tS/V/agUyYJ0rzIysfRXEohRn6MaFHE8zZ7QGsd6xdEkEcn99T87ikmlChDGGf8279
         r5WmQ2CSeOloN1Yc9A5Tkq8sCYbO65QtWpZ9ekwhETs47zyt0tmHVoz4V4AVsjwIFKeq
         ObfVakWNbrDkCPVx2FKZAWFGMhzag+lB77cOkEDYvjQEvnmKbujlDAme0My8hJtynJrl
         c3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710713497; x=1711318297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJJlhZxC3DnR9uX0BGL/zK0LyaSZIawKZpI8/wEQi7I=;
        b=JR6MmYZL6wxy37ARDD73I98hFem5ZA3KCwh5SURsOsauWdwzoixLcH69SuNpBuHOmr
         J8N1it3SdM1m7CHFj4Ibv+uZMmyHhT4f9++AN7AwqUQWcQ+DZA85jPKC7VZHG8hXKTzq
         7QZA78+FqS5UrfUrz/cyOMsc1rJL+2EMkvEhdDslYf4HRj+br3sratGWYyRucNhFE3od
         UyKsSdNKU+CPHxfgc6/UW7uI8DXwsacCRXkWEQ+8/wJHP/lboNUWxfDEV87uTsIuDAWc
         0KSjz70nsDrjIbi7UfUphd2nr5t6EWsyLqpxBET1s90d2uMTULozkUcWHyjPDWMIWERB
         /UtA==
X-Forwarded-Encrypted: i=1; AJvYcCUdx86s0Osgw2uhe7Dv+0ELVMEQ7Vrt8vaceGCG/ma7trvm3SBoDeBoSe+dU0l1rA6EbPO/0nFfSDkoZaXVbQjweZO0OqhvN98fHuuBU/hw8MroRncgWXYTQxK6ovgMqcYprAEdZEHk3w==
X-Gm-Message-State: AOJu0Ywsin+RC8nhSqiOtT9W/Lwnjg9GaVjwq9SP87TybehsIf+USSZO
	313fAj170Y36fODLyeOCh1RsnRcBogJVx1IKpyvGdbn7rCg0Crry
X-Google-Smtp-Source: AGHT+IEXKW6w/S9xZrIWXAJ9k0QE6UUURGDn2Vno16aMewydSUUDduAE3GWNCT8nkfpu0OchnhFDWw==
X-Received: by 2002:a19:740a:0:b0:513:7e83:b3f5 with SMTP id v10-20020a19740a000000b005137e83b3f5mr6426158lfe.67.1710713497094;
        Sun, 17 Mar 2024 15:11:37 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y16-20020a197510000000b00513d8e5a088sm973049lfe.140.2024.03.17.15.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:11:36 -0700 (PDT)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	"David S . Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 2/4] arm64: dts: mediatek: mt7622: fix IR nodename
Date: Sun, 17 Mar 2024 23:10:48 +0100
Message-Id: <20240317221050.18595-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240317221050.18595-1-zajec5@gmail.com>
References: <20240317221050.18595-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rafał Miłecki <rafal@milecki.pl>

Fix following validation error:
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: cir@10009000: $nodename:0: 'cir@10009000' does not match '^ir(-receiver)?(@[a-f0-9]+)?$'
        from schema $id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#

Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 283fdf7d2d8b..4c8a71c8184b 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -252,7 +252,7 @@ scpsys: power-controller@10006000 {
 		clock-names = "hif_sel";
 	};
 
-	cir: cir@10009000 {
+	cir: ir-receiver@10009000 {
 		compatible = "mediatek,mt7622-cir";
 		reg = <0 0x10009000 0 0x1000>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>;
-- 
2.35.3


