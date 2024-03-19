Return-Path: <linux-kernel+bounces-107947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED528803E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE1C1C23060
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921CA2C84C;
	Tue, 19 Mar 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOUEq9Pt"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2A320DC8;
	Tue, 19 Mar 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870630; cv=none; b=E9kuKzgCVlXC8Rtg4kCEoW0ANZqlJ2ooA5PVlLzqoBaHNLU4HkcnaDpPp6dm3rP+u33BifaM9lsrQlVPfyR2WPYYV3RE46d1JTzs83nZ131bWJtPwfvvhWXHUAV9FOaQFPRlz981wYQ7GBu09JX8EZipQ1msET/RMDrf6ZfSOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870630; c=relaxed/simple;
	bh=tAVWYYe9dpkSRvGr9SnXb4EgP8xnjDbkrGFp/vqltQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIwIbcbofpCTsLoZFSFNvtzBl9GzfmyGJV9ImbhIfHuvkzYYWFmwwiwkRyAlWQkOzcZlHZnEnGKVxjvkLUtkC248XB+5Y82R+sgpbchGBV/l7bfJBZE/l9udwaeFrSJWCJVCrFVzBVjMk0XHxYWjojR4pzZK7kTmP3iE/XBY8j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOUEq9Pt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6731280a12.0;
        Tue, 19 Mar 2024 10:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710870627; x=1711475427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2WVTygkXOkhQKlJ16ez8Cadly8Dz43/RCcghJb/HIc=;
        b=lOUEq9PtQ+sEzxYmaOPckMAfuqXwpk5Vay+M0JVw0qYTS02jIl3EqiqB4wMVi/x2OV
         HoKNgkPwe5EqgJeZYFPoRMA7x/yqK7zrtDEQ/c1RYWV1IyRr2bKwn4rGy6r++SvJwxGQ
         eGMdRBz3emJNCVY1414u5G7UVsk1RmBz8NVwsW7QZYUtX+INbog115M/eyCiWwyO1UhQ
         IMuAgh/MNDFAkgMxrTaUnX+N39hHlhbFVj0JcmjuZgpM4taGmS6d48M+rRxwRQk4QQ8m
         be3tUSvdd9OabqeskiqMfWO6mVoQGKmdpn954SIElDNDjA6zFvLnRQnnBubEjjLn8UU/
         H2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870627; x=1711475427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2WVTygkXOkhQKlJ16ez8Cadly8Dz43/RCcghJb/HIc=;
        b=dnsafZUNzIeXIsWTa671O/2dhXp4InwmGRdzpEui6O33wdHGDbXPFIZs94JjZH8K30
         9gzm+qwG08Jwpm2Atwvr8qq027nCMQ6oP+aIBiIQuHVHsWNtLORfPWxYIYrNyORamBXC
         2RucLY5IHMSFAEUoTdc18XV2pb9foZicjJRTFiMGHUvxCPUKcPqx3geVD3gos1iDH9Hl
         wY877w6JU0dmUG+UhIlFSdPb8Eqj79Gu5Dmvxq9Nv5gyGurMPS1VUa3q7GKaw+usBfVG
         G+MYOVUbW/stkgkfTOEK+/2o+8A5pnjRoWEi5gPcWGl/xRYa5SjlVbIMaxrST6RzBhPa
         SENw==
X-Forwarded-Encrypted: i=1; AJvYcCWUTXinz8KP6vgEPrqww9nXLUMyYEGD+C7BsEILsdlImPPPOkAhEKyUOnvnYrrlatbzX+ufy8qH5Ba7PxCPMexoAwnFuPQQazqDirGQ
X-Gm-Message-State: AOJu0Yx8X7GBgjP5M3A/Iojw1dAL8B4jRKS6ohbNWIbkN16OVxLxYcxJ
	Om/vj0j+4fyNtXwFoFynHW5GwIT73bXkcY9U6oMZnoLQWTFh86tl
X-Google-Smtp-Source: AGHT+IFgw2MAXl1ekkmpg2UUcVT/D9qKd0PbxO1Yhkri6A3LPIGpySGb5iyoIzjfFbfGhaIkm4zKfg==
X-Received: by 2002:a05:6402:3983:b0:568:25f2:ed88 with SMTP id fk3-20020a056402398300b0056825f2ed88mr3078980edb.24.1710870627412;
        Tue, 19 Mar 2024 10:50:27 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id et5-20020a056402378500b0056ba8b68505sm84329edb.92.2024.03.19.10.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:50:27 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Date: Tue, 19 Mar 2024 18:50:23 +0100
Subject: [PATCH v4 2/3] dt-bindings: arm: sunxi: add T95 AXP313
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-add-t95-axp313-support-v4-2-6204b6d23229@gmail.com>
References: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
In-Reply-To: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

Add T95 AXP313 TV Box variant to dt-bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..6fe137605ba5 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -860,6 +860,11 @@ properties:
           - const: allwinner,sl631
           - const: allwinner,sun8i-v3
 
+      - description: T95 5G (AXP313) TV Box
+        items:
+          - const: t95,t95max-axp313
+          - const: allwinner,sun50i-h616
+
       - description: Tanix TX6
         items:
           - const: oranth,tanix-tx6

-- 
2.34.1


