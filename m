Return-Path: <linux-kernel+bounces-109962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2781885848
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674E71F23DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CA458AC0;
	Thu, 21 Mar 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8kaxpsL"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25A758AA3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711020313; cv=none; b=PrGDtMv9gSNamJ0T+oANT2n2bvgJJNUiPUj6a4qEzBGwlg/pSwoUxzHcHeYYn8gdSyvkzc64l/EduzFjBzu0mCSfm8b8/s9+4wcBKrFSGnLSb3jufGMitjgIKePtaM1oyx3/oICb7WMwUSO1vsYqrD20OhFu12we7TdrD8NvaTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711020313; c=relaxed/simple;
	bh=KMWylqW711t7MACsRbN1TvhF6nbAcTz/VLJbxkHR4gI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=srjnqNBjT2RfMDCinmfdPwztMC/Xsc7v7VK55/sQGbqVwZBixUzZfyr/3FtmqHZ+J59bjgkNl6uIYoaKEjkWx6JWEz5+2lSuA0pR3AlnjtzUzPyeKtGZPQHV9c9MJPUb1RocDCPGUujlsHhfz5g2Dd49pZXF0s+FaLjziqepHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8kaxpsL; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78a2a97c296so56709285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711020311; x=1711625111; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYDoji15P5HsiN/P0wTyX60zAfAmG6vlj4lO2mZaCqk=;
        b=s8kaxpsLTOexlJz3JoL0NX0gr2h/mmG1/qAPqItTbKxpC7nBoh3YLPcl/AkcttUyx9
         k6FnLgWUIhgakBHmI7tHBZNPB42CnvNveWxv+yVxD6YlMi5vJPnnqU3hWhHax7M1TAL9
         Ifhv+ZGDi+yM+het1myRcCnp8Emhq0rX3VXIKjL2ayv7n/GkWyOt/SPwFnoJr94Kt15h
         VGfr/Afxi4Sswoy327x3m2Q93dUK82aURaiImdkg5BLmuxbGkEFrty4mxvpBFOSt+iZz
         uwg+130a7Vhjm5MyYGGXrioXVXQLdNldZOJ1f0aYsFGwq9EDecL7eH+XqqCSNzYGa5yj
         cdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711020311; x=1711625111;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KYDoji15P5HsiN/P0wTyX60zAfAmG6vlj4lO2mZaCqk=;
        b=NlyFQzqbRPkILyrLs5moVsFPVkflqj1XVUK5WPYmlyRSw+6HGc7EwNuEvvfBrk72CW
         WKl7XyeAwcQ/e2bcQfxTOUnmgGV93NnRrbfxYcLtn6DS1audn0Pw2473HDH9aVlXQEIS
         s6plmwRAjfaV/LI39v/qksaSvvz5jbOMxeJLLqVRNli6Xu5vx1LZuixMix1B6baCJrYr
         x8KUp7PW82y4nqyo+ixaK4643Yjx0SiH47RBZ4AHl0INiPkzkW6z8H1BKw+XxPUYV20J
         nJkUqHBOjjeo3Z4dNsga6b6HOnLUh9gkblBE1HHRdoOsaQi+NfNIsjm8m1MIsK+jK2oT
         8yRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLxWWnQHvKYJAQb6yvYpYcnXw67KejtJmmJ5ajH188NNZVjSo7qzVkV1XtaBUBjRo1pGrhqog6GqRfoH9XyuxC1xMVnBz2vquiCneg
X-Gm-Message-State: AOJu0YzQF65rN5GZZe34VAmzoHvIbgnSD1OCU0sGU6MTXr+kqQ8FDHn6
	vl75bgPLKU0M3E9KMhWnz9zOC+/Qt0ELYvV7eVz/YkgAiPAIK8iDj2VIUkOjOp0aV2Bxk0PHEHc
	=
X-Google-Smtp-Source: AGHT+IEPtkF9qX1leYPHNRDsFpttA8FXZ0PmY8cLC2e9jIid7J3TwoC8DsN/sCK7Xx/HgMkb1KyXkQ==
X-Received: by 2002:a05:6a20:1582:b0:1a3:64e1:b6d with SMTP id h2-20020a056a20158200b001a364e10b6dmr10529382pzj.46.1711019852932;
        Thu, 21 Mar 2024 04:17:32 -0700 (PDT)
Received: from [127.0.1.1] ([2409:40f4:102b:a64b:d832:a82a:837c:6d3])
        by smtp.gmail.com with ESMTPSA id ka6-20020a056a00938600b006e7324d32bbsm5531120pfb.122.2024.03.21.04.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 04:17:32 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 21 Mar 2024 16:46:33 +0530
Subject: [PATCH v2 13/21] arm64: dts: qcom: sc8180x: Add PCIe bridge node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240321-pcie-qcom-bridge-dts-v2-13-1eb790c53e43@linaro.org>
References: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
In-Reply-To: <20240321-pcie-qcom-bridge-dts-v2-0-1eb790c53e43@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=KMWylqW711t7MACsRbN1TvhF6nbAcTz/VLJbxkHR4gI=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl/BcMSC6ZcFxTragSwKQJPd9VtucfQCSDZDiMq
 0b5lht1HT2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfwXDAAKCRBVnxHm/pHO
 9dz2B/4zFUeB8rvtM8DzqBQbkRT4yKNFxGHi9RQpnuQYpw3H0Fov8cSnLGpDWf3zAm0ABaWuQ8u
 NitXa72HXSjRF/bxpamNtgy8nKgiRMCDbihGnAhjE8dV4AF623fSqLdEs2lzan0FFIE0LJ3C/UC
 sXH/e+NA8EVwgbYBhXRcBMkV5uS8oZEV8rlnwBcTZ5gKnWoehT56HCm/wXEAJIN+4I4MefHhbcu
 CMgssacecJIjBQDYJIfRlogjrJ4vn619b3iS0juhFtJ9pNUb947AaKoQ+7BRo7i14Uc5b7ey67n
 8f8vkhufueWHl+NKrCQbLucTx1cZgWgRvrwv20v0kpjIJGoQ
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On Qcom SoCs, the PCIe host bridge is connected to a single PCIe bridge
for each controller instance. Hence, add a node to represent the bridge.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 32afc78d5b76..322ead0389c9 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -1777,6 +1777,16 @@ pcie0: pcie@1c00000 {
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
@@ -1888,6 +1898,16 @@ pcie3: pcie@1c08000 {
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
 
 		pcie3_phy: phy@1c0c000 {
@@ -2000,6 +2020,16 @@ pcie1: pcie@1c10000 {
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
 
 		pcie1_phy: phy@1c16000 {
@@ -2112,6 +2142,16 @@ pcie2: pcie@1c18000 {
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
 
 		pcie2_phy: phy@1c1c000 {

-- 
2.25.1


