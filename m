Return-Path: <linux-kernel+bounces-109956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C95885834
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A24B1C2177B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357EC58AD5;
	Thu, 21 Mar 2024 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNV0MkRh"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DD41A91
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020213; cv=none; b=Km4USW5MQ3Acjnd11LNuv/jIWcSm77oocOgW7rEPINhTuorGzm6sWDmUmARY58E+3JDdz972nAMZfW/QL+efjSD/2N6vg7iirVaqW1PS9Ppc7RppwIyvd2AOxElMVT2Pk8J/knu3d8OOOYsAVCM4JdEoTR4c7Qq63CUY2CvCjCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020213; c=relaxed/simple;
	bh=JjX5rQTZo4PnOzDIoK07BP23seNYxLCWEZfQhQdyN1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXqjGXb2Unk2HIY92ODokeDG67xmtEYniblEH4TM65y4CvUWXfo01qC2ynvXYr/newj0vfTMrzwyDAy8qGTgjPvfi3LO6K77KghHID98W3B6AWQMytFqae1yKrVMLPvox/OmUh1ZCGmeqYXBR2Zuh7nkdtExn0B2mMlNwiTl9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eNV0MkRh; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-222639bf3c4so855448fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711020210; x=1711625010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTVw3VOLiPjAAnXNFxWBHmzEpyoJ/0WYArrSCRNtDwk=;
        b=eNV0MkRhnzJAk4Mi3Flct9SgwfOu1xtnsEQuZTolwjdcA4gWlnB9dJwBu6Mk3w7ayO
         aoqyY6uW9dBRT4xL92siWcpoRsw0oAgSu1I+RCrIiLKVrnSny75MrV7OJs4ch112AWKv
         cJGC75wU7DM+ABQMFh7h1vtxnQHfsX0jhBVgUCYoxXjDP1wkYVyznjD5wZhiwTiUdVEY
         1bxbvBQklnXNxB+gBfFpqeqpAzZ5rRYUeX5hU5oLKQSUIVKL+fHNaAFsHcP0o5utxoSE
         Bqivd6NnDgpzjm3pkX2i66kwR+botzGO4pcUoiN9SG44qCbqMvT6/Wbo7z5VZU3bo6Lp
         9FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020210; x=1711625010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTVw3VOLiPjAAnXNFxWBHmzEpyoJ/0WYArrSCRNtDwk=;
        b=TYDE58LYe+J86NSkGrOnZrPFIhyVYG7ozYsRQt5WB6jUIOmcQu23RermEq3rOSO/FF
         f3XpDfYr678lh3Hocwo4cBr9IVn1wC1GMsdCk6v14d095L9F+vIGW+Nh38we2NdLCMT7
         0eLND0ohsVVVQhZ2OhJ5terjahFa936+4aKs1mCi+BDYM8eQNBuMDzOTZk//VLO4xfud
         UwXj+O2h0jp1Oe6IWbisWtqNUFvhKl+ZKsvptQ35/aDY/wlEgHy4dDQrm6WR8mY5FPjy
         az0GU3IBpssSEUdlqGwodNSMfbgamVVGN8xBIq3tySjEyjtmXRLsgho70155I42ty4YB
         VUMA==
X-Forwarded-Encrypted: i=1; AJvYcCWLtIOivyiG4jFx3WmOAfKhWqoPeU415JcC9EeyLRjxpGp438xaT/cGjwtOG6ZMYOemiQZsM3wo+eWZKYesL/yV0WNmJrnOl2KPp7h6
X-Gm-Message-State: AOJu0Yx5iJMGY5gYPYul7WFeheO3OoBVq7D5Cdkzu78gKMiQNZya2YPM
	h8E7Z7aP5AHtdB1dSPXw0GWX0TOfdzIiAIpP9ZMa7lLfU1Aw5hpIsoB4FG2dKcuqZWvN8FGzeKU
	=
X-Google-Smtp-Source: AGHT+IGwvyGUkGDV6ho8SQWENellaGbkh9BcDgzJIU3V296S/hqDZk5/JFLnDkcfFmeXKk/l8XWvvA==
X-Received: by 2002:a05:6a21:6d9f:b0:1a3:4c8f:dbf2 with SMTP id wl31-20020a056a216d9f00b001a34c8fdbf2mr3288711pzb.27.1711019828039;
        Thu, 21 Mar 2024 04:17:08 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:07 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:27 +0530
Subject: [PATCH v2 07/21] arm64: dts: qcom: sm8650: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-7-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=JjX5rQTZo4PnOzDIoK07BP23seNYxLCWEZfQhQdyN1Q=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcKfo6nILZjT0uVxu9k6L61zmAF0krMsgWSM
 o7hLHsVsL6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXCgAKCRBVnxHm/pHO
 9fpRB/4yJ5GNKfkKv4TU5wFicnI6n/82CVm1TD/Fjc2OFsnwNPP0kQQbQ+5IuThXGWfv9243m8E
 WJN4lpImXtRMHtCESd571i5xfvcIhiJnQiIOuZF22UMQ7X/IOKys6FY1FDct+W1tdzJLRQfjBYt
 8pac7biguPo74gZH2fXpDX4j6th9SJkMnziR/VtbQZMueDJlzJQ8bBFKnVDWBl2orkndM5ao2i1
 zE8bBQjm/OP8CiZaBY30hZG7Iplc4LAW+Y5c2XgWKFliF0SRthvNJIlPVbcb0as28QS4W6zuLuN
 7jongFh1sIqnMAS290MvHGe4Mp6le+ojO0M3DoBeaozuGNP9
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index ba72d8f38420..06d2b6432ab1 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2294,6 +2294,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 			dma-coherent;
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie0_phy: phy@1c06000 {
@@ -2422,6 +2432,16 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 				 <0x02000000 0 0x40300000 0 0x40300000 0 0x1fd00000>;
 
 			status = "disabled";
+
+			pcie@0 {
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 
 		pcie1_phy: phy@1c0e000 {

-- 
2.25.1


