Return-Path: <linux-kernel+bounces-88358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AD686E071
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74C11C21103
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34E56DCE3;
	Fri,  1 Mar 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOgdt2xW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A36D1AB;
	Fri,  1 Mar 2024 11:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292921; cv=none; b=OanhZUVHSmvMz3B6Jb1mx3jv2l2WtKBRe670h0xZxfBU2BHX6N6K7nz+Agd/EfOj6gvEzU2KOfMuoNEnjTOdpP++TwbnXrpg+pwj9NVFPPWq9xd40Y2SLkE5Nm/McIX0a+OeXQXCfKBgcRPGox6njjGVo9w2hciwR7AqzmtykjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292921; c=relaxed/simple;
	bh=v5LwDfrdQNRLlgVDjkMOAz6ZZ6l8qF06wP7A6a9XPWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cKk/EcjMVr8TmLKGusyDsdCg89VH+Zm/Mn1uUVX05dW9duNiObgpOsIHMWxTkY44fsUAXXepyZEg0igCzlHcvXn7basisbul2tMAZOKc1Xix6a8TPNqTQUl3LtpTaOCv1PWwrc6//bbV6n6INTm4IaUxowgf5FfIutqpnUnhVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOgdt2xW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a446478b04bso184042666b.3;
        Fri, 01 Mar 2024 03:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709292918; x=1709897718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ANMO22MOCLOseMHqz7b8w8mZ7xvIu6QEfchh73NuPA=;
        b=XOgdt2xWOq/OfjgcrsvugYD6tBBvQaGz69vmNVkH8iPk4l4gtIqG0VZmf4jULCYonq
         ToE7RX0vNi8MihVvak3iRVUZqYmGCCdnPXUkdMpwvIwpxDNZnBcYqU3oLVZjyZifruZ0
         cxFNlKVJx/dnL11/RwJ3Nf+HFOdxlPh2vj/2ECe5VEXkCN/LB3/0Kp/cqkH9eVXEEGJN
         geZhlQtKGoFXTlNGaDwSSvP+2cpuRrZ1BLwEPnhNIX2H9xkhrWVepYOPVHasNVQW/8jP
         rEamscjHQfZ2EjiHApgz1rs0RhbWQh/KnV1Ytd4GWhN2us86Bd1eqQgt1FcKTEQZieYO
         IKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292918; x=1709897718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ANMO22MOCLOseMHqz7b8w8mZ7xvIu6QEfchh73NuPA=;
        b=iYO+918TBmV6RYTAp3NVlW3hZpQom7Ywn+SB+xhMoODFUIYuU/ekCxNRfkCGK4lbCZ
         ssURtjQRDWDasBSNon/DB+8rOuQN96rShnrikfWUFOcUgIU105/bi+i/0MkHm/TY1ye0
         43A3g5gjm+6AMHKD2z3DjAXIIknqGITp4/tbZLmnBFnrTPgzxO8Wlf59aVGphdaGF9zi
         iIzPHTayOQ9owgNG5kJ8iIMo2vFgb78haQSoM5LyUbQ7ZujY7LaIfLP/Z9ibTgn0jomF
         Xoa6S4lesRyPo6gNaYQGa9bgR5YnoHTAgVzAlEeBrkjuDi3uDJcPRPGO+xZTdvSvVMoz
         o5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnJBbTWdsRTFdaYHELsr8Jstua8XOXJmDcXqfWTW/Xp/g0XmZEuL7x5wyrvQzqsbS7FmElLt3wBoBI3uyvPy08YTnBEZt2M3ujyH4+
X-Gm-Message-State: AOJu0YzV2nwt0hgCKHjjRkod4XNQ7zAhFQPmsKIaekjrG3xnlGgAexV8
	j5Aet2dhYElR/MqDWkalxjNpcjRKKzb5+WQL8W9Li/Gp3vDG5G/h
X-Google-Smtp-Source: AGHT+IElLhQLIeI3YoRkTcHz7gFe9n+M5dds8sXk3F7WL148eZoifYZznoFyilWXwc16gxZ714fQcg==
X-Received: by 2002:a17:907:20b9:b0:a43:6cd2:7a27 with SMTP id pw25-20020a17090720b900b00a436cd27a27mr949733ejb.19.1709292917317;
        Fri, 01 Mar 2024 03:35:17 -0800 (PST)
Received: from localhost.lan (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.gmail.com with ESMTPSA id st11-20020a170907c08b00b00a3f5c39bf2asm1618457ejc.0.2024.03.01.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:35:16 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/4] arm64: dts: mediatek: mt7622: fix IR nodename
Date: Fri,  1 Mar 2024 12:35:04 +0100
Message-Id: <20240301113506.22944-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301113506.22944-1-zajec5@gmail.com>
References: <20240301113506.22944-1-zajec5@gmail.com>
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

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 283fdf7d2d8b..7714775d1bd0 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -252,7 +252,7 @@ scpsys: power-controller@10006000 {
 		clock-names = "hif_sel";
 	};
 
-	cir: cir@10009000 {
+	cir: ir@10009000 {
 		compatible = "mediatek,mt7622-cir";
 		reg = <0 0x10009000 0 0x1000>;
 		interrupts = <GIC_SPI 175 IRQ_TYPE_LEVEL_LOW>;
-- 
2.35.3


