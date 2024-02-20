Return-Path: <linux-kernel+bounces-73590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCB785C492
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E95391F245AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521B14A4C0;
	Tue, 20 Feb 2024 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2j8/i97"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4CF1353EA;
	Tue, 20 Feb 2024 19:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456955; cv=none; b=EGnMZ+CRecTprxRnDr1PWlR7rxaFJ0IvMUL9O5Xkl17QnBSsqiDRMSkentNSXwx71u8f0O1pD1zeee3YGZU6wNBhqLsbeY2vT0kJ8w7zjoyqlBAj14m8XxtIQMDmwu9rnCQ8G4+Zw+rwQXPRnyOxw58hmlJH4L2CJxiZTFXlsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456955; c=relaxed/simple;
	bh=iETYLic/GnoHZMrLLtBPhdaUdXYC0To+q4lhTtjXdgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LphuXy1VZ2Czdtqwl1lQIWflcJBMMyujPg3qGccJaK9lga6Rb4ICL8+N3DLV9merr6Y/5n196jv+W74PQJHelkPH84ZKzkHIm6V0qWOSHqQyPQtF/NZh/Euv32Widp+SLCCLzz0Y6AUgmFOmeyP3vR2jtwTA2uzVHMZtBD9gQC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2j8/i97; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso34389645e9.0;
        Tue, 20 Feb 2024 11:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708456952; x=1709061752; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vr4WFlS9/GiUzUgyJ2V+G5bwrUNZLQw/Jx2ML4aaFjk=;
        b=P2j8/i97yq9HxvAc3oD4gMpkwdeyRlOZq/Mrw3n+nmQELd6lNuXFfi/l2gestaaxBN
         B85lBJbUz+K9JdMhLwu1jXvv8N9XP6OhWSlyqohK29f0r1IAqDk0pe6i7qgdtD6UP+PR
         cgdWxwMOuxID1mXT0GTgzagQtkur4lT86jHO1+RtSYyS7uW+EW9kXoru3TYM0YBeNwV1
         3tbTk6ZTfD+l/sPkDD9171dHki9mKfN6fT4qFEKlkYWQL8Aw/X3qa9pqcrugGMkSiT+a
         qkWZgEhelZWDkhDPKtfKfu3eUpwlMGRggxFLl7OEHyxs7IqPoN/Rt2Pq3fF82fuO202r
         Cw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456952; x=1709061752;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vr4WFlS9/GiUzUgyJ2V+G5bwrUNZLQw/Jx2ML4aaFjk=;
        b=UG+WyOqr2tFkqsysHxe1MnhQ5wXmuYUJAmXSe+I/aW8WHULibL4SMSvtEuVHpi5VYB
         nrEsOIUYvZ+bZndBozfVm07FPbBm8waRSX538K9mfBKMWB684ioovkApu/wdjA0WBk94
         FSROg4SxkPXlpJD4aPEu9qy18tTuhd/g7smdu5khxyk7lAJqx7mtTkSPxby6WCtvy/Wj
         qpJLM8YXWL7R2r+vsmBHiSA4/ieo+McKdLSh+zvBKps17VPSwKm1bLM+ZPawTeEOkBsD
         ruunRgnBkbRb+oecXZ0Bf7Nd2ABxBf5wYFiN8ViDjed/nOniJK4uONPRXzrPTdLKlmO3
         8sXw==
X-Forwarded-Encrypted: i=1; AJvYcCWwIh/s9nXmHOhINQWllF/huf168bdS7yp1YbUWxqtPcpx13TwBVrid6ElDRaVqmVuGrfXb9H7LcnSGuovdnvT79J06o6Z7vNKKoZ5BXikhmlEIJYz1Ovk+q1Rbx6uJpXXPcukTbBvCuWTkU2+xjR6K9SAgj4r+Z794In/XMgTRhTgykw==
X-Gm-Message-State: AOJu0YzVivLlrOKQqdcguE0xiG3UrtoOSrLJn1bFhWqgDGyYN3C20/69
	k6yU+W2EjRvQTbXTNo3SJhph25hyNi1Bg12aNSZxXa4SeLs9cq4GeIhAEzQ9K6U=
X-Google-Smtp-Source: AGHT+IFZQREKFQJmcdKI/Yhn1UaRjKV+UzDWjPGCC+Re35EsAMnplszDN1boVkaacvaHa6v3pZOvoQ==
X-Received: by 2002:a5d:6811:0:b0:33d:374f:83f1 with SMTP id w17-20020a5d6811000000b0033d374f83f1mr6373789wru.43.1708456952254;
        Tue, 20 Feb 2024 11:22:32 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id ba20-20020a0560001c1400b0033d640c8942sm3942265wrb.10.2024.02.20.11.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:22:31 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 20 Feb 2024 20:22:18 +0100
Subject: [PATCH] dt-bindings: usb: qcom,dwc3: fix a typo in interrupts'
 description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-dt-bindins-qcom-dwc3-fix-typo-v1-1-742bf6e49641@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOn71GUC/x3MQQqDMBBA0avIrDuQTC3SXkW6SDMTnYWJJqIW8
 e4NXT4+/BOKZJUCr+aELJsWTbHC3hrwo4uDoHI1kKHWEBnkFT8aWWPBxacJefd3DHrg+p0T2kf
 obPskxy5AfcxZavv/+/d1/QBCwZXqbwAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The correct interrupt name is 'hs_phy_irq' not 'hs_phY_irq'.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index 63d150b216c5..38a3404ec71b 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -102,7 +102,7 @@ properties:
     description: |
       Different types of interrupts are used based on HS PHY used on target:
         - pwr_event: Used for wakeup based on other power events.
-        - hs_phY_irq: Apart from DP/DM/QUSB2 PHY interrupts, there is
+        - hs_phy_irq: Apart from DP/DM/QUSB2 PHY interrupts, there is
                        hs_phy_irq which is not triggered by default and its
                        functionality is mutually exclusive to that of
                        {dp/dm}_hs_phy_irq and qusb2_phy_irq.

---
base-commit: b401b621758e46812da61fa58a67c3fd8d91de0d
change-id: 20240220-dt-bindins-qcom-dwc3-fix-typo-15f71492adaf

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


