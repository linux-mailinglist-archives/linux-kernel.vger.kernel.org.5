Return-Path: <linux-kernel+bounces-47146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B208449D3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF0CD1F23434
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3739FDD;
	Wed, 31 Jan 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRt0GFrI"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579939ADD;
	Wed, 31 Jan 2024 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735806; cv=none; b=hgbSHAPkRbco9+IvoYalwCWD0bVz5jsYus6GsgnHuICJ2/DDwrOOdOiKNPSDZLFenmZU2wX37KqQOWa6gd+q2Ys2agE0aMUJUvMqueF1mHK6VL+SrqHuH31c/tzKEsxSV+TLeLeYg31jUBEj6dRdf17Mbax8a55g9LdRda/yocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735806; c=relaxed/simple;
	bh=SrLkPV32tGSrX4ymybvLbYgLhLU7N6R98bnE332aEHc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DcuotqLW14aa4Du2cK3jO57TqLgmCOMN2xwl24ClXEqgoV+Y+UmCd0Uc3s9eRfXgqIQlouOZrWDRmcrdsNLt7NXAMV6yHhdMLob0XUEBHjZ/eUQiMNEtqP6eE3b/YgHkg6CST0O+piVPaNdfXmokJicCmCva0/Ildm9lhYYXBrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRt0GFrI; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a36126e7459so18438566b.2;
        Wed, 31 Jan 2024 13:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706735803; x=1707340603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9SmInleJJW50YrvZW+J7AO+eV3PNYGh0Bhi/yWPzWQ=;
        b=PRt0GFrI2mrf60LUMydAbhzUWN2pcma3YEyoitEg265CQCY8s02puMnwMHUTqpZOoI
         5Yv40VQ3jSghXC6uKHCZVexebu2Xqg8xCoWRkHcekCQ/dkLNuCK/SI7oE+Ur/Sd51b8l
         FgOfRl2QFltPjTKbNaPiXaWrwGqx624BR9jCF2Hb10hNcH7+lFNjgP+gq1C6HzFghECj
         GCjU6q28rTLLfkAWJeu2/aYEz3yAwdp6E98aw26mF9bA+QlJ0hHrJO+06lxaqRv2gwmE
         g9O9t+iwL094RkrHJsGEi+B6K2j6fVdsf1/kUOiCRT2mh0qv0elhXODgJU2J3iF9q6LG
         szJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735803; x=1707340603;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9SmInleJJW50YrvZW+J7AO+eV3PNYGh0Bhi/yWPzWQ=;
        b=rCPnX46MDJ9zaw3DcEtgMpHcMK0GgVu3LZjglbB3FMS2WYWw786q8lEV0OmTl9cKeL
         245Fk5td7rZkd2ZWuIAV+3nQjM2ufilqb/Uekqx7oNwOtu1ZYvvvuoK/3oHKhINPdyBe
         VmE20q4xKuRpeRsi+72oc/ugWljzlahP4XJg8DeL9uQSYJUMBZjxPEVPG42fUgJi1DNy
         unVkRg9jg3rstRgpplFqVf0zvfEXpdaa9LoX7kTZptOaWq2HDOtcNL6TSxbgHQ4Y9Nak
         fUXhOjCStHcpX5ZC1idhnf1drjKiD0n4H/Bug1AZrUUaQrcDwAuAgjBeXYwZjVfVR1UB
         0/mw==
X-Gm-Message-State: AOJu0YwCCZoPGMqsb+KzBPg9+58iiPb5z1BKPluGwDAfjCr8dpcJVoQO
	YCJZNE9reGvPOszwjOwTuFSPC12MXskZdwORJG6nBnlfcWeTAnwP
X-Google-Smtp-Source: AGHT+IFiNtk2W8Gds5rlEUJucqr0hxZtYVlXx8CB9ZL0yV0dlIBsl7TELozRqSGeP779yRy9JMoREg==
X-Received: by 2002:a17:906:fa92:b0:a36:7291:888f with SMTP id lt18-20020a170906fa9200b00a367291888fmr2238279ejb.65.1706735803038;
        Wed, 31 Jan 2024 13:16:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVj/RaJySAKCvrlAOnjJsXfF/SANVDVD9dt5oLx30qbfHP74A0GI9LD66qJ4884hbNihZ9apPn3ZAAbFpzrkaZKgLp7vGkgRR+JfUqiaGWKEBWH/cqXnosXABbvoq1H/kOLHHsMsFWwlFNDlQ9RUtX2J5fPWK2J60pu6GfS7ODbtoLOBjKyOK+6Lmrc81vyudsuR3NwFx8eCYiSWoofQE/YgtCeqMl0nmGPwYebNcKuDrqzKPzxmH4Ant5DTzhUqhNKJAOA0ExoFEflnMuRtbmQVVzv2hh/4rX77AMIeLe2rbGiY0sIPeI5Fz6sfagpo2z+4TGtYPFfjKV1sqMhwFwqHdrnEZslAwGMyk2ZAQDIweLrFkSqn44rhQW6Bw3jLWU8paue+4/I/lJYkkPSK1tOazJ79ShFvx/ZGKqSIeEBkwvgJU7ERM4S/KJuMfKuK3vKsRdVGd3C0Sne5Hs5n6aZz5MYkFCZcRqdLx5KQCz5ywXobujwvEhVmsuC3rU3OEAF/cKka0SpzdwRoXko3ORfMvZpH0DRMr7P1WxrNROWfBcosCRQ+s1KJFedfrqtTqLLpoeuTVcMnjXxqmY=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a35a8571419sm4040634ejc.135.2024.01.31.13.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:16:42 -0800 (PST)
Message-ID: <cc3a9b4f-076d-4660-b464-615003b6a066@gmail.com>
Date: Wed, 31 Jan 2024 22:16:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 3/6] ARM: dts: rockchip: fix rk3288 hdmi ports node
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

Fix rk3288 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding with some reordering
to align with the (new) documentation about
property ordering.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  keep reg-io-width together with reg
  reword
---
 arch/arm/boot/dts/rockchip/rk3288.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index ead343dc3df1..3f1d640afafa 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -1240,27 +1240,37 @@ hdmi: hdmi@ff980000 {
 		compatible = "rockchip,rk3288-dw-hdmi";
 		reg = <0x0 0xff980000 0x0 0x20000>;
 		reg-io-width = <4>;
-		#sound-dai-cells = <0>;
-		rockchip,grf = <&grf>;
 		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru  PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>, <&cru SCLK_HDMI_CEC>;
 		clock-names = "iahb", "isfr", "cec";
 		power-domains = <&power RK3288_PD_VIO>;
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
 		status = "disabled";

 		ports {
-			hdmi_in: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+
 				hdmi_in_vopb: endpoint@0 {
 					reg = <0>;
 					remote-endpoint = <&vopb_out_hdmi>;
 				};
+
 				hdmi_in_vopl: endpoint@1 {
 					reg = <1>;
 					remote-endpoint = <&vopl_out_hdmi>;
 				};
 			};
+
+			hdmi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.39.2


