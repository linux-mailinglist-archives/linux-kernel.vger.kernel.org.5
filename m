Return-Path: <linux-kernel+bounces-47149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC10C8449D9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEE911C2392B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F6D3A1C3;
	Wed, 31 Jan 2024 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kf20KyL0"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CA39ADD;
	Wed, 31 Jan 2024 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735855; cv=none; b=Rnzke8Zf//+QKQbGOt6arYlRg73LCd3kfnpvXWH06wxXvYjflihyIiGhbIbxGyIsuoZAdIQlqZs57z6hezfwbIvVZFOSP0v0qIrMWxeHNvUNXbSPzo95ty8hJlc8+4zbQByjzoW7Vue+wpWHtyimqTtSVqeENhnhra7Cf5pID1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735855; c=relaxed/simple;
	bh=qq0UGnQx6TCiR50GTWZeefaDBebAKa46z6aXuXmVi9s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UnytDTO+FWv0/9tQbDXMc9+jyttfGGYtGeh4z6v8DJBq6Sn7WtKO8Vrt396HP5MVuuDTVpT+EHO7+QN4Mm+Qk6ph0geji6SanDRNqkjrkeuFPo6ks02394L6qpTHuU5EDH4r2alz3fuzYJgfW2n4N95uq43HG7wMHJqfv0HQRIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kf20KyL0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5110fae7af5so256144e87.0;
        Wed, 31 Jan 2024 13:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706735852; x=1707340652; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R4aZnJ0HXPSCrrZnvvv03peCc+aJLdST+sQtI6Yh7ug=;
        b=Kf20KyL0TsT+7fVfunqFXYdYGpQcqOT+SFkAtfsvd863KicFTfLekVlc1J11ajD+a0
         +Bfprx4rpLAfHNIJrkgt1LCZXrmpWtXvhnoHFTQni3k0TJEzD4TUaiZLLo7/yEljg3EC
         59/DA9FebVO/ta3a5O4XOJZTWO7KSocNBrfkuEsPwaJqrTj0ArvcaOP/ufwPzTd3djdL
         e32/UUEaTLWq7N3qMhm6e3Hu4OUka56miYl2zkJ7mk7jkv0JSrS6Qmcj4ghpY/Zr258+
         XrGOuhCIBj2xo0V8m271F2RGki4xcy9e86HuVqenxO9BUus4QWfPGGyXSdeUfxu8Qqrq
         gsmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735852; x=1707340652;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4aZnJ0HXPSCrrZnvvv03peCc+aJLdST+sQtI6Yh7ug=;
        b=mYfc7C6MpPqKuZAJLt9AX2nNRkCbZm7yhNeztUkeUtRgK5rHMpctIatQsQoWg/u9au
         UsM9gH1/dCEG2gMby8bAcdBynePI3bWX36cxAMltb22zVuWq2W+AHk1kyotsFsNRrlUt
         bTybCK9cbv/v1X1zyKKoRPfLBW1I4qvSK364M2whm4ebV5yocuXH6/e7Bix/K00TCTo2
         wBGTTo9tALvuS44s/RrPKLQuDTZguBfEATmimA4TfkUQhukYfZgWCigjMJxUgWCU3Aqb
         dAB4AJ5iUDLIvR6QKwXNR2EcoJ5U1HGzXSv6OUVTEEzVr6z/tP03zWe74ZTMf/8xdMWl
         HCeA==
X-Gm-Message-State: AOJu0YwcWmQv6ZDFxcXe9djhGyzSfITuNogDH4srSP5y1x4JQuk+u/4v
	gwBThgU+EnqLGNkXzmhIfI0ljDduX0d06xdyuLq9n4IQmeRycgpS
X-Google-Smtp-Source: AGHT+IE+0isqNh4+ujtT55m3CO8TfbUQsPsn/Em5gcobBL4NzwWM+JzTycjuSMlXff5ckL/9eHFKzg==
X-Received: by 2002:ac2:559a:0:b0:50e:d514:77bd with SMTP id v26-20020ac2559a000000b0050ed51477bdmr437572lfg.18.1706735852064;
        Wed, 31 Jan 2024 13:17:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW+Y6j2zZMzBfnbk/bhkKrrJOnx2LOrJUHkBhyYcPiBX7GMnrzVU7PF8xepNbZlA/Tzl24kBAFvDkoBY/knhdfC/aVwufd/Onk1b7PatvAlaB9BCwDzlkeQJceUguUkRk8AKe9xsdhFH2JnSGzFSGdECPaNYaLKV/6Kexnb7hyeS1T3vgRJmk9BcOHG8h6Z+TDGC3Y+CT6CjIm/loZSAxPgoE5isYhAEru5DRsM5phL5c6vbzdCo5E3OB4DO8WZzJpJUhQl0vaOLlKfWamY2StJi7vrCvn6PTNsIvX7q20SkFlqqGrW0QVEoKUr4bx/kz2mWl0T2IFEQbmwCT8Gqe22XguZVouuNOG+tGyWhreC/XP2lc6TIn2oYtCUaWAmnyAoY3G9bec+5Q7pK015MK4JEor5WAH/W5Mrix00dlx7XJsmP3Pow5jUDpv2kJ5Y75pw1yEMn1Gx5z/4X78vLgEgEwyCmHCEfSqtrr/5cFJTzBYu/ZZj9cc1WoR3GvcgevMXd6cyPIFXFPO7LT2LwTYwgVKxhDHv2S5WLCekbGhEKzLsItaXOIgThqVcJzKg8cIgXVw4klvFxTMFx9E=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ty5-20020a170907c70500b00a35a8571419sm4040634ejc.135.2024.01.31.13.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:17:31 -0800 (PST)
Message-ID: <a6ab6f75-3b80-40b1-bd30-3113e14becdd@gmail.com>
Date: Wed, 31 Jan 2024 22:17:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 6/6] arm64: dts: rockchip: fix rk3399 hdmi ports node
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

Fix rk3399 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V2:
  keep reg-io-width together with reg
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 0caa842bba0e..9d5f5b083e3c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -2022,6 +2022,7 @@ simple-audio-card,codec {
 	hdmi: hdmi@ff940000 {
 		compatible = "rockchip,rk3399-dw-hdmi";
 		reg = <0x0 0xff940000 0x0 0x20000>;
+		reg-io-width = <4>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH 0>;
 		clocks = <&cru PCLK_HDMI_CTRL>,
 			 <&cru SCLK_HDMI_SFR>,
@@ -2030,13 +2031,16 @@ hdmi: hdmi@ff940000 {
 			 <&cru PLL_VPLL>;
 		clock-names = "iahb", "isfr", "cec", "grf", "ref";
 		power-domains = <&power RK3399_PD_HDCP>;
-		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
 		#sound-dai-cells = <0>;
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

@@ -2049,6 +2053,10 @@ hdmi_in_vopl: endpoint@1 {
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


