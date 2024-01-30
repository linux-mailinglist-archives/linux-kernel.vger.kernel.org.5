Return-Path: <linux-kernel+bounces-44784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7B3842757
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 171E228EF84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BED37F7F8;
	Tue, 30 Jan 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6itl2I8"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9685C5C;
	Tue, 30 Jan 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706626686; cv=none; b=ZkgLXj52adkA9jqZXI+DEQ2WHM3aTcN2oL3owmWMYeXd5btb60HxC5z6RhdrlcveXgU7aajd/9BGhGxcF4x58dTwifVT3LOwv6ULZLrooMkh8D/jPF3KY8a3o5jlEpYj2TmAvEyCABGHqWE3+9+YVvohaazJfemraboTAh79M5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706626686; c=relaxed/simple;
	bh=uvKx/KXiwrX5Tw12wdU034IVRA4WrPOCHCRyoEjEb8U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qvNTTsg4XZES3ncfEU+l7jNsOYaGNbHGwvFFvAxK9cnER8PgInUt74d5UeqP427EuSuD09ASVAnsWX3RGBhu9tQBDQ/awwGqK3wKxg4sg4qlc1h7iEd7yZNtbk/agpRhPREervGVAKb8VzEBXIm/KiE+zTJu3ZlVVIS2G9Cms+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6itl2I8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso6650855e87.0;
        Tue, 30 Jan 2024 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706626683; x=1707231483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4KVEU6pfibVE5vwIMFG0DTRVvqGuby5kG2hwyGagW1Y=;
        b=b6itl2I8fz9fxkyw9NBkKXh2UoZO1tMuJSPStplD+ti8zTOJ+yEOm9f2ZGBZZ24y7E
         QjkGL2GBVjnRXz36L2/s7G3uPcXfDTyH5EAOvO5q2eUuRQY29O7lbyjvIx/yYDxK5P0Y
         ybN1abl4fq1USKqh8/acyLZCrEOLoS0Tu7xDVPfvm3LSsloHbALwmdw7V81vbPj4HH2x
         UA3xrABeceygphpyCID+gmbqOTl8vdYWGfYZdKRzbHncIoKRoyCWL4xwGlimDbc4ts8K
         YatpgmUuIrIdOF536qGc9Zcp9bDOIV2XkyuCukvc7KbSgnDg4KOKQeGFBOqPxvFTCo7l
         awNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706626683; x=1707231483;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4KVEU6pfibVE5vwIMFG0DTRVvqGuby5kG2hwyGagW1Y=;
        b=jdXO7yJOK4fUVSytTxesefJ64aNZEgNhxNWYMQDaXj2TSLYIaFY18kneacBDs7kU3l
         d+2480J78HElMpwdSp3RVoMh86mGXvBca5Cth5CYBsKehYeU4BxrEwucUOut0fj8sX8y
         TSq7Ry3bt5gMOHavd4KdI+Bick/bXz4qA9EpOqyX921N5Rf5tjwRvGFLQHTfZ6HFz6iq
         vPAz2UjrnEQ/J5RSfgBbzKVFppfwYJq9Ka2gvcGRRAxGa/WrMIotY1bIAdytj2z3HamM
         FcTGX7e/MgvkUMsttAq25TMF6g0IMriP4SohwjcHknXkRssgvWZCl++xLZCMZHtiOYOk
         /koQ==
X-Gm-Message-State: AOJu0YwTgnovuSDikelR219M+uTG/nGfHNzYHSmnp2cf2AC9VKH2UQp0
	EJ8jUNSUngVJ86IGeYK6a6A2Rzz5TEThseuddg1bOY5wy5BPcR4p
X-Google-Smtp-Source: AGHT+IFjjgAuwmClX/o+HbWS8xl5uKCY8esTk4Nm5+W6LMTSgfafhSjGxp/blXmlubQ+95+DX33G+w==
X-Received: by 2002:a05:6512:603:b0:510:27a7:ccc4 with SMTP id b3-20020a056512060300b0051027a7ccc4mr5835024lfe.64.1706626682921;
        Tue, 30 Jan 2024 06:58:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWaUrJEimFY5hJaIsjNuilaWQySKKzwncpg3VoY/OIk6fwNHm2uK4XncD/JZQcpwn9no0P0WSEZzR5MUn1hW0cKjM/lCt2KBRqOl5sDeu7MfSaUsRrXslGeT25IM/ejfROyAGJO9i4gSI5Jne/A5pUZoUlqW6eppbAbUNNk/tiDbKEeBUP+ECTvSoUeTpgT4VpvaHBPJ3ABPZ5wdSkiEnUOmio8Ajwdy/APxlVw0HBw3TMcg3jYpUvEXXsgJibDrMTWBVkZTNqtClEngjfKTUFdNRRUmFe5VZgQSBubZBobh44q0727zHc3K10Vs9YKgajk3tJaIyPCBJHfLKdqV39o63YxF7JwUALlDjOqr4a0UfTP5whmJi59i2lOGFipD3R6nUZRJsI2MSKNl9JsC10OOp0HylpGlIUnEyEeX+WjqlO7x+wMJWZlFFd2/DD4IY3/qbWJuAttWev4r/cpkfDDDKQfUCPjtFZOyGUhtUWBhZEBwvPbYPVx0yc6DZqF5ij1Jr1UfqKHOK1yH1VLGfsQtLLK5MLdpQA=
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w7-20020aa7da47000000b0055f0c027a3esm1879542eds.30.2024.01.30.06.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 06:58:02 -0800 (PST)
Message-ID: <a5a6a7c6-0b71-4918-9da4-d0a4043d203a@gmail.com>
Date: Tue, 30 Jan 2024 15:58:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 5/6] arm64: dts: rockchip: fix rk3328 hdmi ports node
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

Fix rk3328 hdmi ports node so that it matches the
rockchip,dw-hdmi.yaml binding.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index fb5dcf6e9327..749b3f965f32 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -727,7 +727,6 @@ vop_mmu: iommu@ff373f00 {
 	hdmi: hdmi@ff3c0000 {
 		compatible = "rockchip,rk3328-dw-hdmi";
 		reg = <0x0 0xff3c0000 0x0 0x20000>;
-		reg-io-width = <4>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru PCLK_HDMI>,
@@ -740,16 +739,26 @@ hdmi: hdmi@ff3c0000 {
 		phy-names = "hdmi";
 		pinctrl-names = "default";
 		pinctrl-0 = <&hdmi_cec &hdmii2c_xfer &hdmi_hpd>;
+		reg-io-width = <4>;
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
+
 				hdmi_in_vop: endpoint {
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


