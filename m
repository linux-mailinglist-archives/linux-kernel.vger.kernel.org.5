Return-Path: <linux-kernel+bounces-47144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE73D8449CE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7508B28B881
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07F3985A;
	Wed, 31 Jan 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgdTdw7t"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282A738F8F;
	Wed, 31 Jan 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735789; cv=none; b=qNJjk3i/moYHXyOY2fp6rFraFkHFoJ6byK8IaKISnSt8Rg91YEVx93Jol7+pCJvpME6xrJNP6Ts20cy2FRCpWZgS/xVtlsOdu4mooxl/NPH6XniI+wL0VcaWY3KvKfsITaokrWwfx3/iRbw1rLMc7jdYqmaNmqqLYv3UwaNROrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735789; c=relaxed/simple;
	bh=VxIVD2Uu8YJWcT8mNEh5Gm55vkRnDKI5CB+olARhzR8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tTwToJITx2ntiIyV57SW1A5mj0v86snuum3/rHfdikjYkkOTpmpJehYOv4DbfG8IPU9F0Z419+3C+4RapI+LhroRd1jwBqAQiBEV8r0PhmEcDyEvGfI3LIb6lDRgyAdfOrr/P0cLnBjm4eZ3Y3hG9VfOHWhn2ZD2T18Bbvr+WAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgdTdw7t; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a271a28aeb4so20899466b.2;
        Wed, 31 Jan 2024 13:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706735786; x=1707340586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7WAHmXqhwFGwnUoVVTvOT31zVVDiv5ormXLbiLzvJr0=;
        b=YgdTdw7tqPeP5yMJ13eO5y6/QSzG7Yc0MdvCDNgQ4OEm0RjkjAoRJOynUAsfgU23Es
         5RU2Nhaw5YoAGSeHjeQ0xSYj3MBLC1RAROoFbBTVT/APC2KeHo1tQBnLtCFyE3d/EqiF
         tLMRTrbJFI8CaiE4GC75nKxoljD3laE+1OVVeCDqwZSXkvzrBJqdzK6EGrucRhhdpL6k
         LGgwO2azKskmFHH6W+9rKQ2pjlBDx92EE+pUYNlRWwHvyMGYRBiBWbIa9nzaXUcwnVcg
         4/FIjo688bZiV0MYXv+O0oyzo9k3ItBEdrpjbWb0Sm5HNcFNh6HAQzJ2dRut02/rOMAy
         eKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735786; x=1707340586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WAHmXqhwFGwnUoVVTvOT31zVVDiv5ormXLbiLzvJr0=;
        b=lzQ3Azn7mwLwI4uTIUYvArKh+nYcIAc4W8A6gM6l5eVwFfLFMYmvrbVLMv7aFNUt2f
         WoZRs4jIMsLuF9nmT+EKjkKCt7PiJjJznGrtVB/wzfu/fzpqpBX86di6Om5rPkic1SpB
         8mdz5B0PLo5Yn/tnwb4RDWKuVIiT84BmgsSvqKYFsKSi8+0K1iUY70Z0KUOEaW/K4f5N
         0NoBSx6ZY2HttZEH4hip21gSgx3cnnU7rBzfeI1R2ePf60lwNP72kZokleO0RgAiSvPI
         J1fUjaW+PlImXE3OR1s6YTUK2RSgYd/qJoTnq9zQX70q73GOS0WN+xeR5iYvfbEX/FxM
         Bbsg==
X-Gm-Message-State: AOJu0YyKR8R8C0axQXFOd/tkNpt1oZIZp3BioeBwnxcWevOZABJRV7Wv
	e9GCT7o7wxr/I7JwYwR5OSoeCcdDRv2FACZMC1iX1zP7KrKBR0FL
X-Google-Smtp-Source: AGHT+IG1BFq7Pp2hw0FCVuWw6rIJcYrAM9nq28Kr5azCiS9LKzq/m7hwGTr5nk2ETTNoY9f8m7yc6A==
X-Received: by 2002:a17:906:da06:b0:a35:edda:ca8b with SMTP id fi6-20020a170906da0600b00a35eddaca8bmr1992854ejb.76.1706735786182;
        Wed, 31 Jan 2024 13:16:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVc2fs4IrBG2YWUC5LcZZStHjB+RqDtXVILboDRP8Y2Xm1IoMKnaO2pMi/h4SQUCrAruBblHzoOgDf+Aud6ulOos3QKpvTrOPDbWDrqrs4HoncHMRv6melTKIpllEW8OtFwnN33yPaEFX9kPiIJVFaz94d8Y4gJLNprrxIiTqgEwAzZF7DeO5/IO+fEX+0/dhCvlliQGm9DqOzAUU99bBQXn8o6SMzo0Hgoqm5QeA2k8zgHOry8CgP0VBNfmF6GRhoZHfwmUaL8uBJq2XbfcWxvunXQBbU7jqJRykZJI7KloTyZpPzrwxL2fFFCF6Bhxt2IUP/Th38ZoCpdRzQ6aMCLFa2oh+q58pPry2SEjx389pdHUxDhLD1zBehNndrSw2rsYkLQxOTTyGj1urAZFRt7Si96ewe9IW1EE5T+1hm6QZu0b3o05WuKCL0qn+GsDGuC/NhYfkqoWV0flggiV7whpyZ47IjqSXr14Zgh9zg3S1LmTND+9p305Lhk7uaXtn3un3AdZ6x3agLqjRDz/BlXoxQTGjcJ4DNSh7kyURpMcQ7mZNxtPNxNIrdB1QW1nlxVxlpJ1FUsiiLxuuc=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a35a8571419sm4040634ejc.135.2024.01.31.13.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:16:25 -0800 (PST)
Message-ID: <5c45527a-e218-40a3-8e71-a5815417e5f7@gmail.com>
Date: Wed, 31 Jan 2024 22:16:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/6] dt-bindings: display: rockchip,dw-hdmi: add
 power-domains property
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Content-Language: en-US
In-Reply-To: <a493c65e-7cf9-455f-95d5-8c98cad35710@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Most Rockchip hdmi nodes are part of a power domain.
Add a power-domains property and include it to the example
with some reordering to align with the (new) documentation
about property ordering.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Changed V2:
  keep reg-io-width together with reg
  explain reordering
---
 .../bindings/display/rockchip/rockchip,dw-hdmi.yaml      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index 391c2a7e79de..af638b6c0d21 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -94,6 +94,9 @@ properties:
       - const: default
       - const: unwedge

+  power-domains:
+    maxItems: 1
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

@@ -138,16 +141,18 @@ examples:
     #include <dt-bindings/clock/rk3288-cru.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3288-power.h>

     hdmi: hdmi@ff980000 {
         compatible = "rockchip,rk3288-dw-hdmi";
         reg = <0xff980000 0x20000>;
         reg-io-width = <4>;
-        ddc-i2c-bus = <&i2c5>;
-        rockchip,grf = <&grf>;
         interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>;
         clock-names = "iahb", "isfr";
+        ddc-i2c-bus = <&i2c5>;
+        power-domains = <&power RK3288_PD_VIO>;
+        rockchip,grf = <&grf>;

         ports {
             #address-cells = <1>;
--
2.39.2


