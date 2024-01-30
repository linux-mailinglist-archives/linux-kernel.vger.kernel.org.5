Return-Path: <linux-kernel+bounces-44780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E217F84274F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2060B1C24EAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE87E571;
	Tue, 30 Jan 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jimh5doY"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B509B7CF1B;
	Tue, 30 Jan 2024 14:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626648; cv=none; b=LAcP4iHszf6eErnFI653tGRlcDwvk/NBCH9oMrbKqJjdK/ATb4sT7fp/WVpSUGpIDn2DA4tiL1dgttB2HuhflwK3kLwTizS4BTSpTZBadVknvotkuIUa4EpstVwmO3U3M3sKpnDSRwye5S+0LlcSLkzWFFGrx+WyRzPoiZUjmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626648; c=relaxed/simple;
	bh=I3D56ztm6VwrbCw9L+d+uBEayJgH8T8DvY4j5AeO/JQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bGTtEmeu3m8v6FOtNvTHjbdjGaas2MDNeliaZWoffaHKUTG/LFIVFDwZPGwzJu4OGv/tXpl/Kx44gr8bkU9wJnYbths4Zg4cvOwu6SKSLWV5NDHSB8uQAYA6fNJyAotImqesPqTxeMBmhhjzR9njA+m7NKSEzeEGtxFc3SdOSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jimh5doY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55eed368b0bso4453683a12.0;
        Tue, 30 Jan 2024 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706626645; x=1707231445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yBP1sbQ2NlcbjUdIKedXdoU619EWO8zH/xknpjbpMbs=;
        b=Jimh5doYQHKNygQlKpOutNyl9SdiA9PYHJ6q+sXwquCdhgtHwZ6BY/YSHLuYIMqYXr
         fi+o6bOLL3u8H1mh+b5WOgL3Uq7o11GkEcfRX2BmjavIbYtN/g/GGkKTfZxnEIwwzagy
         nD0rLWD/CTebWmoSqGcznuludS+G2TMlmcyw/MFB61LtUD3g/pHUqY6E+fy6Ybtx6NQC
         gyluver13MW4tXGFkZVDiKXfp4u7tCBBk1dpcnlgcBkcZnh2WDzlGgZ9GYsZp9okCRHo
         /oqlzlgKvpNTG4oKw+ZNVxRxoUosc7mafUSvt9kBQ/+FniQ0e0u161L4lY/lU0x9rfcl
         dWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626645; x=1707231445;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yBP1sbQ2NlcbjUdIKedXdoU619EWO8zH/xknpjbpMbs=;
        b=GiCo9l1MNn1zz9TCAGtOurlpyct71mq4EbWz9/tekrwRZMHrn4l3jf6B8h1zydlYEG
         UIAnHaTFCaK+bw5EB4BKzbkttHT/3hcEBm90q3fruqtIuBGBBMJ4W5GGsycYOKTtzFng
         Zxo6zCkFuRYLOFw1ElLZ67oSLT5kdUS9Fp08Kq5PVeqShMwXH4ee1NGzWfv5OAGl0SUp
         nhJ9WA2OPhZV0rvCa8+9usZSD0CDDy1CzU7saUnWjE8FgJrha8wcz3xZPtvGfwASY2qS
         fC2HBfk7f6sRI1EQGOv7/c5elgwss5/oLpK769gbNeAQhzKD1ssEL0UP+2PJOMu1jexM
         1Slg==
X-Gm-Message-State: AOJu0YzLGlzy+4UUYNTDAD/YQ77Oguc1yiqR85LV+HeYgGjkI1djt2dx
	B/kpxHUPMuoM4mxRI56GlhLDhcvXRyP2BBS7GCZP/VtDLlIveix1
X-Google-Smtp-Source: AGHT+IH//S6wHUjFESQBomnwxG2DYoedW49QyrUW/xp6mvOC/FyH5Af9zjaHLj1VUrPKp0hJ355nag==
X-Received: by 2002:a50:c317:0:b0:55f:3353:3f5f with SMTP id a23-20020a50c317000000b0055f33533f5fmr1906511edb.1.1706626644679;
        Tue, 30 Jan 2024 06:57:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWD66v/nfypZCrDeVMlFSJTke9rSFnz4LEWI5XDkPB0fIraAKLfu6mEMXGHcIuQO7Pse/Ni6Bo99H8azYLPwTKhq+rqHwYxKilKFAjPVhVIb9a3WOs8hGvfMxENUDzoQ4VJYpNCz3T+ZSWpipsBmX5z4C6QsCrqROr5OwmysLw7SGoy+/KR3Gu1Jofz+h8B2Gyh14swkAwMXk60fqxZdp6Zt4Vj2YK+QWucrV9ymDnAn0tDHrUmPdyf3lJCFWB1i5QAt3HgTcQjyGzo94dHNle1VVQ+XJ3489Z6bt+yEdZbmxfREBkFdg2pQJ9npQ0YN72FkBBqjAPAlt4hZDg94VMvKEGbZbtYpzOl6Eln+7t1WwXcRfZ3XflyDDIkfg5GXTEDmOTpbbOEMojfpmnr+ro/nMcoco3rs7i02aUMZaugZy6ncBWW5+a/RCdwlciXgO+DkLDJFLElYJlaEb4+1laq34wtqzLloBAsh+KwIB93yD2qVmg305liBHJ9DICey9RVdvDTRrEd+oZahc/jZ+mfFbihRvnnYFs=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0055f0c027a3esm1879542eds.30.2024.01.30.06.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:57:24 -0800 (PST)
Message-ID: <1ba8b40d-005a-4665-afd9-a4eacf3e3031@gmail.com>
Date: Tue, 30 Jan 2024 15:57:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/6] dt-bindings: display: rockchip,dw-hdmi: add
 power-domains property
To: robh+dt@kernel.org
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 mripard@kernel.org, markyao0591@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
Content-Language: en-US
In-Reply-To: <6626d288-ecf1-436b-b0a3-3417308a8633@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Most Rockchip hdmi nodes are part of a power domain.
Add a power-domains property. Fix example.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/rockchip/rockchip,dw-hdmi.yaml   | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index cd0a42f35f24..6f421740b613 100644
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

@@ -141,16 +144,18 @@ examples:
     #include <dt-bindings/clock/rk3288-cru.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/power/rk3288-power.h>

     hdmi: hdmi@ff980000 {
         compatible = "rockchip,rk3288-dw-hdmi";
         reg = <0xff980000 0x20000>;
-        reg-io-width = <4>;
-        ddc-i2c-bus = <&i2c5>;
-        rockchip,grf = <&grf>;
         interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>;
         clock-names = "iahb", "isfr";
+        ddc-i2c-bus = <&i2c5>;
+        power-domains = <&power RK3288_PD_VIO>;
+        reg-io-width = <4>;
+        rockchip,grf = <&grf>;

         ports {
             #address-cells = <1>;
--
2.39.2


