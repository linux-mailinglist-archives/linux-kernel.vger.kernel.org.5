Return-Path: <linux-kernel+bounces-143791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0162E8A3D81
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC72A1F21958
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD56481CE;
	Sat, 13 Apr 2024 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7KL8ppn"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7346B91;
	Sat, 13 Apr 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022754; cv=none; b=qVI4/edtqSW95RLftnR7LbzLBlj3+120gfZYre/pnTN9eZ65FqLA1lpR7nEtiICwvHg1D+ZbxMCtH0WfEpAgOeLOKT1SvAX/ofCkzDeAYC7WQTKCKQ65k7uBQOs4ecy4GJNyqMRFP5fJPvPbgkatW+Gq+yeUZ5A/pJQ12g53sjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022754; c=relaxed/simple;
	bh=R0hQU1JQFBJczNHVHglQM6MToktaoc1ppzYaJMl2mZc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EoIbDGkj37fx568BhSUYyh3wfF5mxROXTmzChvOdO+60TedPi2dgCYRWrrznsG5Lj+/WxzaX6PuLkfq0LQ2ZBSjRGwEYeUV4yjgPfawvUFQOr+Xw0AP4jQrv8Cwc8UF/+hFK/S5uL6V3YAJAgcEKM+ugvKiDwvvoJn1sjvYILzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7KL8ppn; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d536f6f2so2082144e87.2;
        Sat, 13 Apr 2024 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713022751; x=1713627551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f0oNO6mfFQuvlHpMk4G/znEiHbjMhsBrBQyKFqCxSZQ=;
        b=F7KL8ppnX2gzWYdo3A3BvQ/q3382MtIQzm4ZlxYyfv+63R1f4gg19e8eoYX6dn94W8
         6/sXcQ3iqBoVd7VrL/NfhbFyb49JpD6qzuKaIbB4aVB2OhflkaiZG1LEwyIE39VPUCTi
         +l9bZ2h208Wz+Ir3w+G3Fl5SgrzFU/CZAmKfwWAP06MusMlCnO5cgASRrVmvxyPo5e6E
         3vxCd8Mum41n7XbpJ+0264tbniL99sKl78ugKUBBCWsD3CS6YgIav5PCguTPi2nfjYNo
         FLMIb5qYKWCRN3DKxhf+JAV/6CGaZzsd2Lx33hnG+CCAtwFSixQ9WMhc3DrxJ7su80s4
         sAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713022751; x=1713627551;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f0oNO6mfFQuvlHpMk4G/znEiHbjMhsBrBQyKFqCxSZQ=;
        b=CxVKLRMAORuw/aGmf1XGuv827kU269VOsyp8X3QOk12uil1/E0mkIMDyjFq8Y+qG+h
         OfrgGQLw4QYw5j+5uIFTICcndUXyXM0GWRF5crXQ42p5JWCmVORA+Mf1OTqbcIEdBSkV
         BzjiAyE0OvYIK442uC/xSKhjYDjOZAYCnWCgd4t3IXJZGPqBXCn5+GySvcaYx2nqgwG2
         N/XaFW2RS7uJx9CeDGp7MUcYckxUP/ytgcLrGSh4YaEu/oZ3+TXXbFK8r9zx3EapEmrF
         ce3MMXtNkJeL5GCWQZshQOk7OIDmsCmTTZx0kzXLouql0fo/tIqLQgqybXRQn/kf9qSi
         etxA==
X-Forwarded-Encrypted: i=1; AJvYcCUunAjf52Wyhgs89fuEqKIb0dUzcWwDHOCAi68/fMDvousRx9ZQyorp0yiSWIgWnVnXYg8iIPB7xfPdN4G0hWClyP6Zn0LUOjMErGqkfr+2yMducHGDwyXw9/aDGk3ZdKdyxWxJRMxNww==
X-Gm-Message-State: AOJu0Yxzzf5NuF5HMsMZ3q46NoXu4j2o7/7bJhYOMwA8L06JGp8fBci9
	ST3MlOski459ue0ko+ckSgXkniQ00HqZIvXFhJuJgW6sefwqk8ja/nFp1w==
X-Google-Smtp-Source: AGHT+IGZgdHHvUfwKJqy8JDTyxqVid7fQ63n4t17VeuS+OeS1rzrTs5iqeQLOHcedJp/MKxDaD9YEA==
X-Received: by 2002:a19:7609:0:b0:516:d04f:b58e with SMTP id c9-20020a197609000000b00516d04fb58emr4324330lff.30.1713022750586;
        Sat, 13 Apr 2024 08:39:10 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cx10-20020a170906c80a00b00a51b5282837sm3131680ejb.15.2024.04.13.08.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 08:39:10 -0700 (PDT)
Message-ID: <b9864655-7c60-4066-8305-f291a3551872@gmail.com>
Date: Sat, 13 Apr 2024 17:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/3] dt-bindings: display: add #sound-dai-cells property to
 rockchip rk3066 hdmi
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com
Cc: airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, markyao0591@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
Content-Language: en-US
In-Reply-To: <3a035c16-75b5-471d-aa9d-e91c2bb9f8d0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Rockchip rk3066 HDMI controller can take one I2S input and transmit it
over the HDMI output. Add #sound-dai-cells (= 0) to the binding for it.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../bindings/display/rockchip/rockchip,rk3066-hdmi.yaml    | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
index 1a68a940d165..6d4b78a36576 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3066-hdmi.yaml
@@ -10,6 +10,9 @@ maintainers:
   - Sandy Huang <hjc@rock-chips.com>
   - Heiko Stuebner <heiko@sntech.de>

+allOf:
+  - $ref: /schemas/sound/dai-common.yaml#
+
 properties:
   compatible:
     const: rockchip,rk3066-hdmi
@@ -34,6 +37,9 @@ properties:
     description:
       This soc uses GRF regs to switch the HDMI TX input between vop0 and vop1.

+  "#sound-dai-cells":
+    const: 0
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports

@@ -83,6 +89,7 @@ examples:
       pinctrl-names = "default";
       power-domains = <&power RK3066_PD_VIO>;
       rockchip,grf = <&grf>;
+      #sound-dai-cells = <0>;

       ports {
         #address-cells = <1>;
--
2.39.2


