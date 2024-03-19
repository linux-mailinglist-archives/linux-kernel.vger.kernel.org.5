Return-Path: <linux-kernel+bounces-107815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE4588020B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2EF2812C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E968287D;
	Tue, 19 Mar 2024 16:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDwEOCR7"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6952127B6B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864856; cv=none; b=UXGy7uLjsDD7OAEIhgvcM5Ir7yVaaHnPqlxeKsj7+MQx675L2k0gFD+/31zwBuhju0KhLx3ZlA7EXvdFctAFKLZrt0hDqrfTuFe3/DvBAl73APOfDmNQZ/ovsSDO3B+VZpPT6QshhB6pPjjJvy4ZW7Al1uiYZ3LiiDbz/1I/atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864856; c=relaxed/simple;
	bh=C1WwkTnF4D51zKxLRgtTi7neKO7FUlW1WZehIPRagUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WQK7RebJExPhUgPyAyjLuf6Qw5uiOtE3MHbQ+7XmygwHRWRdZYTw8LBD6nYNPP2V7+8A+MVlin42MnSYcBuzsxp/oPz2WomSqPxW/cx0NUEYQm3GbLzpQRnxJxUkswOQ2nZazy4ZqskslGUoE7bTUxIjkDCAgLn/H6uiHdjTZr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dDwEOCR7; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515830dc79cso758157e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710864852; x=1711469652; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE7A1TMqiKAqmFzW6nlWEzBc38jwIdf+oOhpNZjQBgs=;
        b=dDwEOCR7VW56O/7jQOeucTWq+b1EtjyBDgf6+7e3c1VbctQ9BHENidEj2iTC7gOg3L
         lWOqFZmgHH7XbjiMbWY7yaVVpMWUehoL8YlXF8F74AhfLBIcfdFpL8PDL9oXYHCUw6W3
         xXHRwMQmmacqjBaEigAzcRJcHh0lP894W6skbgPRQS9jNir/knY9pVaEVEOIcrDWGgcb
         6D/g2BoQLRxu4eUjnKKTfRdbaj/MFTUSuMLalQorSRzb9aTStT2azoZWPYvFmUVq6j3Z
         p0EeUXeExg6bLbeMHheb1dpQscFE4WDXW921HlbPON6SUUGlhvaluKeRo+D9XDQFUlp3
         93Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710864852; x=1711469652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE7A1TMqiKAqmFzW6nlWEzBc38jwIdf+oOhpNZjQBgs=;
        b=R6If+YAQtirsIZYzolWlP8kKRU2U1kuvNk9xfS3Nl7CapX3cr8FdZkKG9MVVcLfEs4
         EXDNeTuptuPSApAWQqB04Ka4zMV9GQitxE7jc49ClrvXELt5L9PPuXiyQR+FaPr4OaDd
         Dhqmt51TxD9ltsUx/eilBfs7tfDNuKEPGHhSG+n9/5C6RrXREflNsKkAT2S47jwpouah
         mFCytLpf6SYZEkOUoIHT18GVvo82PTpclWoAVNVQF5wsHQubcpH1X+v41eO7Gn60nAlk
         B8YgCeM6BMcflShwBfq1ZHDISaCmGEcCvHBzOo+kIV9VOLLDE2g6K6uuqOcKxHASpfoR
         kygA==
X-Forwarded-Encrypted: i=1; AJvYcCVu438LdSTN30bZOP+uXg9k/zuQYhx6C5Jrqnmc1qxNdoEJ3kaaCtckhlsHSs6kZlaYnI7NGhxzyBzkcYS3RLbq2mmmRoMpZRkGDZm0
X-Gm-Message-State: AOJu0Yz9XzjeTNNlyi181Q8WQoa4s4hI0+lynmbCod7EZcU6/0yYJG4H
	RL+DlA1xAgWrgDplVjZHMe7wu59aD+cPfpaHrUxCNKNUy2X1oGL9GB10SGHNLZA=
X-Google-Smtp-Source: AGHT+IG9nJYuESJlyiQ7awgWZhAwPnAQNG+SHgHrl9DiIHJkT+cc5Zh1SDoCpiSoJ/eFSy9gFswN4Q==
X-Received: by 2002:ac2:4985:0:b0:513:9f14:8f73 with SMTP id f5-20020ac24985000000b005139f148f73mr10387113lfl.36.1710864852401;
        Tue, 19 Mar 2024 09:14:12 -0700 (PDT)
Received: from [127.0.1.1] (netpanel-87-246-222-29.pol.akademiki.lublin.pl. [87.246.222.29])
        by smtp.gmail.com with ESMTPSA id dx9-20020a0565122c0900b00513ee207982sm607686lfb.198.2024.03.19.09.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:14:12 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 19 Mar 2024 17:14:01 +0100
Subject: [PATCH 31/31] arm64: dts: qcom: sm8650-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-topic-msm-polling-cleanup-v1-31-e0aee1dbcd78@linaro.org>
References: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
In-Reply-To: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 88 ------------------------------------
 1 file changed, 88 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..f7707c155696 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5091,8 +5091,6 @@ compute-cb@8 {
 
 	thermal-zones {
 		aoss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -5111,8 +5109,6 @@ aoss0-critical {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -5131,8 +5127,6 @@ cpuss0-critical {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -5151,8 +5145,6 @@ cpuss1-critical {
 		};
 
 		cpuss2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -5171,8 +5163,6 @@ cpuss2-critical {
 		};
 
 		cpuss3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -5191,8 +5181,6 @@ cpuss3-critical {
 		};
 
 		cpu2-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -5217,8 +5205,6 @@ cpu2-critical {
 		};
 
 		cpu2-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -5243,8 +5229,6 @@ cpu2-critical {
 		};
 
 		cpu3-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -5269,8 +5253,6 @@ cpu3-critical {
 		};
 
 		cpu3-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -5295,8 +5277,6 @@ cpu3-critical {
 		};
 
 		cpu4-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -5321,8 +5301,6 @@ cpu4-critical {
 		};
 
 		cpu4-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -5347,8 +5325,6 @@ cpu4-critical {
 		};
 
 		cpu5-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -5373,8 +5349,6 @@ cpu5-critical {
 		};
 
 		cpu5-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -5399,8 +5373,6 @@ cpu5-critical {
 		};
 
 		cpu6-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -5425,8 +5397,6 @@ cpu6-critical {
 		};
 
 		cpu6-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
@@ -5451,8 +5421,6 @@ cpu6-critical {
 		};
 
 		aoss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 0>;
 
 			trips {
@@ -5471,8 +5439,6 @@ aoss1-critical {
 		};
 
 		cpu7-top-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -5497,8 +5463,6 @@ cpu7-critical {
 		};
 
 		cpu7-middle-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -5523,8 +5487,6 @@ cpu7-critical {
 		};
 
 		cpu7-bottom-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -5549,8 +5511,6 @@ cpu7-critical {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -5575,8 +5535,6 @@ cpu0-critical {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -5601,8 +5559,6 @@ cpu1-critical {
 		};
 
 		nsphvx0-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
@@ -5621,8 +5577,6 @@ nsphvx1-critical {
 		};
 
 		nsphvx1-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
@@ -5641,8 +5595,6 @@ nsphvx1-critical {
 		};
 
 		nsphmx0-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 8>;
 
 			trips {
@@ -5661,8 +5613,6 @@ nsphmx0-critical {
 		};
 
 		nsphmx1-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 9>;
 
 			trips {
@@ -5681,8 +5631,6 @@ nsphmx1-critical {
 		};
 
 		nsphmx2-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 10>;
 
 			trips {
@@ -5701,8 +5649,6 @@ nsphmx2-critical {
 		};
 
 		nsphmx3-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 11>;
 
 			trips {
@@ -5721,8 +5667,6 @@ nsphmx3-critical {
 		};
 
 		video-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 12>;
 
 			trips {
@@ -5741,8 +5685,6 @@ video-critical {
 		};
 
 		ddr-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 13>;
 
 			trips {
@@ -5761,8 +5703,6 @@ ddr-critical {
 		};
 
 		camera0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 14>;
 
 			trips {
@@ -5781,8 +5721,6 @@ camera0-critical {
 		};
 
 		camera1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens1 15>;
 
 			trips {
@@ -5801,8 +5739,6 @@ camera1-critical {
 		};
 
 		aoss2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 0>;
 
 			trips {
@@ -5821,8 +5757,6 @@ aoss2-critical {
 		};
 
 		gpuss0-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 1>;
 
 			trips {
@@ -5841,8 +5775,6 @@ gpuss0-critical {
 		};
 
 		gpuss1-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 2>;
 
 			trips {
@@ -5861,8 +5793,6 @@ gpuss1-critical {
 		};
 
 		gpuss2-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 3>;
 
 			trips {
@@ -5881,8 +5811,6 @@ gpuss2-critical {
 		};
 
 		gpuss3-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 4>;
 
 			trips {
@@ -5901,8 +5829,6 @@ gpuss3-critical {
 		};
 
 		gpuss4-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 5>;
 
 			trips {
@@ -5921,8 +5847,6 @@ gpuss4-critical {
 		};
 
 		gpuss5-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 6>;
 
 			trips {
@@ -5941,8 +5865,6 @@ gpuss5-critical {
 		};
 
 		gpuss6-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 7>;
 
 			trips {
@@ -5961,8 +5883,6 @@ gpuss6-critical {
 		};
 
 		gpuss7-thermal {
-			polling-delay-passive = <10>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 8>;
 
 			trips {
@@ -5981,8 +5901,6 @@ gpuss7-critical {
 		};
 
 		modem0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 9>;
 
 			trips {
@@ -6001,8 +5919,6 @@ modem0-critical {
 		};
 
 		modem1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 10>;
 
 			trips {
@@ -6021,8 +5937,6 @@ modem1-critical {
 		};
 
 		modem2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 11>;
 
 			trips {
@@ -6041,8 +5955,6 @@ modem2-critical {
 		};
 
 		modem3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&tsens2 12>;
 
 			trips {

-- 
2.40.1


