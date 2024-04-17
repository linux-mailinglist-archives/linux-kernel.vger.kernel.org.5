Return-Path: <linux-kernel+bounces-148016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BF8A7CA7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38351C21046
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2286A335;
	Wed, 17 Apr 2024 07:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="ZPvF+/BI"
Received: from outbound8.mail.transip.nl (outbound8.mail.transip.nl [136.144.136.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDF5524BC;
	Wed, 17 Apr 2024 07:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.136.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713337341; cv=none; b=RtwWAMOrZmy7foAhs3fFSVNUOvfwilrhVmb0tqnEs43zDOns/VV1QUUSmZHovi5QG+1xbkiGm3YYSk3GUaYiIz5mcUgW5JqQ5SWjvyFQ9DykKYrfZCWXfKPAMgTa3lp7lyMiEq7gIj8XoWx/cTcho8NovZEntIPlFFkB22C7yWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713337341; c=relaxed/simple;
	bh=oyTv7o1eonYTsAfT4cfj7AhE76HukCBjbWZvcV2c8dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e2lH7OKxHxP3Hihi1rGbMoEw45MpvOaOcWedyOzRqoh2RD9ODPUHwK1L9TJuMeiR2mRDWYn201fLBbJpUO19kaAdiQMDFcgqwfFINEYY++nBP995lCb5jaFCP4qrmJr+s74OliaNk70ROV73cy4LvG8gXXSDTSa1FNinGbQu/N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=ZPvF+/BI; arc=none smtp.client-ip=136.144.136.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound8.mail.transip.nl (Postfix) with ESMTP id 4VKBVX4TpjzY75qH;
	Wed, 17 Apr 2024 08:55:00 +0200 (CEST)
Received: from herrie-desktop.. (110-31-146-85.ftth.glasoperator.nl [85.146.31.110])
	by submission4.mail.transip.nl (Postfix) with ESMTPA id 4VKBVW5l7qznTZy;
	Wed, 17 Apr 2024 08:54:59 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: github.com@herrie.org
Cc: benwolsieffer@gmail.com,
	chris.chapuis@gmail.com,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: phy: qcom,usb-hs-phy: Add compatible
Date: Wed, 17 Apr 2024 08:54:54 +0200
Message-Id: <20240417065454.3599824-1-github.com@herrie.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417065020.3599755-1-github.com@herrie.org>
References: <20240417065020.3599755-1-github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1713336900; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=D6JFtwlOS+AWIs+Hh5HvpbMUdPE/n8YDLeJQmQvnz18=;
 b=ZPvF+/BIPf/+uVoF/uO9Aw8JuwmI4AgXWBQGcK8Se6yLI1h7Rxof7+zTHSJcKP+Tla5crz
 HUAimAbPFQ34MASE9P8Es2h7qZoH7g2XhB31t837Hu+/4H++isT/dBh4VMvUI0bAYz4+BO
 gNsab8paxHjf+LWEFheDknSLmp+Ko8M3KYjiVhdhPmiamBQ/85DhIvHmM/98ZPOjMdAy9/
 LfMnnWCEYz2EskriHJUkJFbOzA8HjTJvhF4LjWv5elED7Qe474A829cDRBYlWUqbcWqBKO
 yHatklDkMyWU/WQm2tdstnF5JgcNM5i5IJ9AX7hkU1WNBfotYwWefQnO+MNJZQ==
X-Report-Abuse-To: abuse@transip.nl

Adds qcom,usb-hs-phy-msm8660 compatible

Used by HP Touchpad (tenderloin) for example.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index f042d6af1594..e03b516c698c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -15,6 +15,7 @@ if:
       contains:
         enum:
           - qcom,usb-hs-phy-apq8064
+          - qcom,usb-hs-phy-msm8660
           - qcom,usb-hs-phy-msm8960
 then:
   properties:
@@ -41,6 +42,7 @@ properties:
       - enum:
           - qcom,usb-hs-phy-apq8064
           - qcom,usb-hs-phy-msm8226
+          - qcom,usb-hs-phy-msm8660
           - qcom,usb-hs-phy-msm8916
           - qcom,usb-hs-phy-msm8960
           - qcom,usb-hs-phy-msm8974

