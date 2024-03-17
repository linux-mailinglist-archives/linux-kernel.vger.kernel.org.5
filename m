Return-Path: <linux-kernel+bounces-105573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE32187E099
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F351F20FE6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC822F0C;
	Sun, 17 Mar 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StIcRzMV"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD5224CC;
	Sun, 17 Mar 2024 22:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710713501; cv=none; b=DPDVzWWV5SBAyQCXUP3PM1O6QBmZQPpEMN4DzNAS2/SOaUseUpzHiTb/xcfJDcMJ8GdUkoZsWpIo3O5V7SfGWQNaWgfFb7Qe/aeTGXCjuU9KSVMxFwDHZoC/4bCj89dK6gnT6InedGI3orHkLvIgCX6kG+sgcBly9XeMrlcvyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710713501; c=relaxed/simple;
	bh=vwsmzsYk3zSPF3hTJu03DpkMmM0A+hdO1gXbpj2iPIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pbq/x1tKt6+U7kD3n8ll5zKYZpzygI2TTiWT0ZX97jyHO2GIsiS9Yl1N9opNNMyTqGVC5I9kchTWVEdm2tJI1cRc4eMLjhlSA/X0Ci7gjRusLb8aqS48H3z9B1s7nU1O/Y4iSgyZG1NdbBMQkXYVfWrVKjvTS46R1SROmcFwnLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StIcRzMV; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513cf9bacf1so4688513e87.0;
        Sun, 17 Mar 2024 15:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710713498; x=1711318298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZxjhUkiqFkClpGT78n0zWyw9JFAZozf+iRUYHp00LM=;
        b=StIcRzMVJo74soPgXIqjqKqYcZYAwefTZOvVHUhz1wZAlIZs7ClITxfJfhYB1mlchZ
         mu2IQD7i6mtOs2mHDnXbKKZz9p1EgTu+Vpnnix+eU/brgh3gF+YM6fB1xJebO9z68deT
         xqHseCSPq0gAQT79sOJ+ibjRcKTDy7MvkcPkgNjjKDM8CEgpYGu8z7FPibch6DmHB3aX
         QLIq5OZim7OvPB07idM6AMAhfGik7ABCkB8elV+xgG7Lq+LQ4xpO+jN7HIocVuGg8HWH
         /r2l2xSdkdIDEk1Ru/pgb82Ik/f0a4SU+cv0z0bG/XOYsBYv12MYwkwBVo0SnO+l0Ein
         yltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710713498; x=1711318298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZxjhUkiqFkClpGT78n0zWyw9JFAZozf+iRUYHp00LM=;
        b=TtFv/Xg5ziGL8Q/fZ2HSzbOrl356ad7RuIsyytkgX98OzICkkejDsjAJsgoqyWS/2t
         IwnKuIZnJ/hsPUnZ/Yv+r5dqgIDpUo8EcvPDTefeOwI0I6Z0XaoR7mr2lJq7+mmnUVz9
         eSDMLHME/LexwhlfhS0fKtlvq7vj96gbPpgsBf2phiHjsFVaciozagDp1fvVCMIn4psh
         AmAiS6Q8T2rJ91KfKTPLMRsqwsQ3q32cEd32GJsZYAdBFTUN9Eh6kjhm8XkN7QDiOX6h
         B5h4XXEPVvSq+8ku07iJqVkf84t9FFeOI7YTMnx5tOxS7CR7HeRMwPzjUkU+1p9vsdi3
         XfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxF+kn2z4B4qz4b68qmUCrE+kopavdSNzijnS6oHeQKbWCAlyzxpXr9vuRYH8BCPF0rZvuzBxChpmaGZ4vSLFRdWai5+ZP7xRcKUzQnEWx1KYzpLzE7Xi/Epmp6+SQ31iNqNhighcFPg==
X-Gm-Message-State: AOJu0YyfNLKsv8c7GrDI/vui7GemxwC7LWb/SBsZCvmd7uTE2RhXZURc
	rdU+vsaJIVxgynGEEqG5JI32z2QMpIImfkMjfJqXmNRjNVruQT8W
X-Google-Smtp-Source: AGHT+IHDc5SfkGYQVm+IZ730jSs+MzWYmeVVfiTOParJ3XUUCgcIV05kxzRF/+gGgCUsr1h64CZbcA==
X-Received: by 2002:ac2:5b03:0:b0:513:c596:713 with SMTP id v3-20020ac25b03000000b00513c5960713mr5733785lfn.28.1710713498423;
        Sun, 17 Mar 2024 15:11:38 -0700 (PDT)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id y16-20020a197510000000b00513d8e5a088sm973049lfe.140.2024.03.17.15.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 15:11:38 -0700 (PDT)
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
Subject: [PATCH V2 3/4] arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
Date: Sun, 17 Mar 2024 23:10:49 +0100
Message-Id: <20240317221050.18595-4-zajec5@gmail.com>
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
arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: ethernet@1b100000: compatible: ['mediatek,mt7622-eth', 'mediatek,mt2701-eth', 'syscon'] is too long
        from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
(and other complains about wrong clocks).

Fixes: 5f599b3a0bb8 ("arm64: dts: mt7622: add ethernet device nodes")
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 4c8a71c8184b..8e46480b5364 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -963,9 +963,7 @@ wed1: wed@1020b000 {
 	};
 
 	eth: ethernet@1b100000 {
-		compatible = "mediatek,mt7622-eth",
-			     "mediatek,mt2701-eth",
-			     "syscon";
+		compatible = "mediatek,mt7622-eth";
 		reg = <0 0x1b100000 0 0x20000>;
 		interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_LOW>,
 			     <GIC_SPI 224 IRQ_TYPE_LEVEL_LOW>,
-- 
2.35.3


