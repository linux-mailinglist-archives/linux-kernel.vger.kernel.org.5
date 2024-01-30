Return-Path: <linux-kernel+bounces-44782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24946842753
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D6A1C25D39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F378120E;
	Tue, 30 Jan 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3mfmPoZ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD73D7E771;
	Tue, 30 Jan 2024 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626674; cv=none; b=LnJkxtN3j5V/MqF3bz/cwrxhGnpDMSbnvrIy81PnQ4pm3rQgsoxZehXqT4FngMTxEnvbZ67o09RHDZU5wZ2LpifBBX9wQvs+PbXKDTHNVcAkH7tOZQCMVr6pMRBI+3LC/HCKZLdR8H8Ch0x4tUHz84X50v26konpe/mbjMGdUOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626674; c=relaxed/simple;
	bh=vgDyDSISDc1ZdXds3Q5bpKkrZcsHqr6/iiwrlCksTtE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SloFB076KTkV6xIZAfqsE0C/kNrheIT0pumFHQSj7EBn0jFEBFbZ7VEcwK2OEehr+1y1P9NkLbuMZy8ejxu7DtYk7n9Y3C0uwEonLk4gMxWa38UAaluLmLeRNhExGYXBWJpxy1VBKqvtFvAUSANFFNKL4coclb4yVvZA6Aq5or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3mfmPoZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so3947004a12.0;
        Tue, 30 Jan 2024 06:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706626671; x=1707231471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DmcehVDq1GcEjhHx6wGLc0qaDaI/0n7EbffVmbga+mI=;
        b=C3mfmPoZS7dlK1SkabffrITaWzz16QyRvTEygzO/o3zNWAUME8jkn3HXLY1i+wfbHv
         VAgumEKZNWg4ucwZrXbQZSpNtCeBzl7w9UYjUDa4A14KcrlmUNsTzlI/i/HDJQgZXegw
         GtGCy3GfThrFVbsm8UAHvpNj/WfEMMdUeVEUyavSROJGUqihaTRBom0DPVMHZfj9CXUs
         mp8p+b5sLgYJTJaJJq0aTOnj4+qGLKNRJoQIuOVp2t7G6DjoLcyn7/EUGtyM3qhn5WBu
         ra1ljJmwQamZybWUec95xwV3cLL4+NX/nu4efY/O6g7DQPTiVJUQ1YI2UhNoQnQW+ik5
         AFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626671; x=1707231471;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmcehVDq1GcEjhHx6wGLc0qaDaI/0n7EbffVmbga+mI=;
        b=QZl63qA+ZrcjeHUVlmZfC+n1Hc8fYgoByGYEfZcJr1ypItfGbSpCou+AYkqRIWBNDI
         m4Z5bbYbM6FOO1lE1ahN6FD3AEL0p93ukI/f6JYC2Ws4OEs3nlUwwfDOebd2rB3DlMAW
         sdN48I9FIQg4B8OoaJsakDQYaOfWreO0igVO6UxibVs7097/+Wr0axclKnjAgktHvuqQ
         4Ej/Q+kz4UPFskmP3/9j7DjAMPwfSNNVBrR0WOAxC9XhsPOowdTKAUz1URdAzXM1GqdE
         pafvSuf3inMmhTHyRL/vPP9qd3bYo4mr2A/G5qjlm3AxhmA04B3bZMnhczQoW4AdzTHe
         If9g==
X-Gm-Message-State: AOJu0YxITgKOkSeSBilA+5J1U+dituu9KDJirM+Bpr52BAQtE79kCDeo
	aFW/9wGEGtEaFyPx6Hr7W7Egltp5LhlK1E9/ZbNA5FNLlMtXj7a7
X-Google-Smtp-Source: AGHT+IEb4naCDu6qsxfxml3F3iSc7EgngZPLyYUgWoadasH9mTVJRoKm7IlmAEYW00Gu1o9PGZLd9w==
X-Received: by 2002:a05:6402:2550:b0:55e:deca:edac with SMTP id l16-20020a056402255000b0055edecaedacmr6232937edb.7.1706626671074;
        Tue, 30 Jan 2024 06:57:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU3EbKMiWmvSROr5Ah/T9RLbJmUTfnTZc22fmTiffBecwf/fw2VsXVHg9i1EnHr7aCc6u8/sCjUqhfRBZwjNE7kYDBUJbnCpQa4qB9tmOxWZlTgs/txjGulZ9/GkZjsaFOE5AYwHbFG+HS3/zjd1doGyQBvkA2Qey1gEEJLX9LLU90BSvkDraclnaRrw+DnpHNZ79/zlggmZe2dQP0XTnLex2z1jlL1ZgIyqZE/7WZzLWaQdVrBEHFO9OVGH93sgNc1hw4LdVcaDRHyYX6JdXA6+6ABdWCUekzOvM8s4fBmIobLiGosCGjKGFXkskOl2dSd2Ajthep0jSiJRre1H18H8qrS6dHPdK38Ad2rqgML9i/wTqBRXa2Lx43BXIo0MA079y2jV9QxGA7eUPbDTleh1qdRGvqgub0PQX8xrizN7V5oSCvzF3j00auNb9FMxk1Bk6AMVYRdGL9NZ6T3JEPpjzwXJuA03aTKR5DfVsWvGiILk/HGEzlaxzFg+Cr9hXkBMZiE8rTSCcHx34MmIqGNpLmTizXEoww=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0055f0c027a3esm1879542eds.30.2024.01.30.06.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:57:50 -0800 (PST)
Message-ID: <4bdaddeb-06d6-4f43-a83c-6646a9a06f05@gmail.com>
Date: Tue, 30 Jan 2024 15:57:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 4/6] ARM: dts: rockchip: fix rk322x hdmi ports node
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

Fix rk322x hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk322x.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
index 831561fc1814..ff8e778ea50f 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -720,7 +720,6 @@ iep_mmu: iommu@20070800 {
 	hdmi: hdmi@200a0000 {
 		compatible = "rockchip,rk3228-dw-hdmi";
 		reg = <0x200a0000 0x20000>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		assigned-clocks = <&cru SCLK_HDMI_PHY>;
 		assigned-clock-parents = <&hdmi_phy>;
@@ -732,18 +731,25 @@ hdmi: hdmi@200a0000 {
 		reset-names = "hdmi";
 		phys = <&hdmi_phy>;
 		phy-names = "hdmi";
+		reg-io-width = <4>;
 		rockchip,grf = <&grf>;
 		status = "disabled";

 		ports {
-			hdmi_in: port {
-				#address-cells = <1>;
-				#size-cells = <0>;
-				hdmi_in_vop: endpoint@0 {
-					reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port@0 {
+				reg = <0>;
+
+				hdmi_in_vop: endpoint {
 					remote-endpoint = <&vop_out_hdmi>;
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


