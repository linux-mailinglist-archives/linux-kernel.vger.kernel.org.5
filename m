Return-Path: <linux-kernel+bounces-151731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58068AB313
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10815B22397
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793D130E3B;
	Fri, 19 Apr 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SKmo+WEy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A312F376
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543255; cv=none; b=Ih+L14wtjb24qqa76i9SfDSt7+LQ7eZdG7Z+90pMBfYuZ0TRcMoDN32ye+j0AHUmsuYzH88iNH/ZMqMSFiFge7yjtYyyMhnuWWOU+KDnedmVJYWvnhw/64a0p45GZwxYlGy0/xODAfUJ4nJmmPezXyniwjHyQDyOGMzdfWP4IyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543255; c=relaxed/simple;
	bh=dATceXyW1aFB6GDMYipKiutnHij7Lpxvfb3TquoiYMQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kdkpm/927rUtlu/b2vvDKUg8rNwP9DFi5vG/0pzEGmPQLOskX+z9HVm7PI+WzH7huAR8wT4AurtSF4vrx2G5SJavMef4t38QQfzfeGHcSEn97AWuNl9UnevWR+v1YWVbVMkMPsQaCnHy2CRwUiiX1yXQyUn/2SmeTAly5GYnjoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SKmo+WEy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4187c47405aso15546505e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713543252; x=1714148052; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O33KtnJFn30ZRs6MUWLrVuDMWodrSE+fF5KPMFo8lfk=;
        b=SKmo+WEyMiPb92hYYuZVTdKgIuPsGhd6gB3KwEaNfrcQhBTObn7hGHPwgmMkkVEBra
         dIiI+WSvfe1rm2kX2zsfPjZ+gj0srvp4QcAaKqIPt8fp9OkajOVgYScC6vPEF7DXEYVH
         15Yp//zdYlQWPNVusguCpVWRjfTvlolfTsDHPs0rR8WhKbeNKEMXC8m4fFAthqqDlV7n
         BjErcRoHGckgjJId/+hgNJfQ1YjKlO6kZQTnrDn3F3uQvl+mxNZlaJMUXA0nppdbMFb4
         cxaSR6nwBVzSbH3rFxhcEvSUY811INIUXfZsqJDAtZpXLp2E8RpHN3O+5K4vwotMimyV
         HZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543252; x=1714148052;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O33KtnJFn30ZRs6MUWLrVuDMWodrSE+fF5KPMFo8lfk=;
        b=YbtQy+doUp9CNKNyk/JwT5XafExhUVK6UvD40LDpAqv+A490w8HVJS2WEY32Ja2Imq
         XlzDe2zBFa3y8qogfVqwLELDHmKScyBvofMl6QA5PvwRTUsdMXLsedfbC9OixwSqLTT6
         YLjR807WXFtvXk47RZ9onsu8dS9e8t5SNRVcev+HL6uAJt2Bfmiqf+gSlANNR3jF+TgV
         PTgprPnYQRoWhv2JFtBkk0OQnHGu/wzN8lnQSHfhodwKJOEHuwBWoSzy/FtcWlj54of9
         W3Ty9+Bh2l4B1gwmuCjTyZJrH8n8aNngtbM7Z5nX6ke8hPP9NdePLKIGChCnf7sQHswf
         3/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUM0tNw6YifSvJMEmnRqbbkz9CYtUELi1M0B4q4JWvYs8FBi+uJhq3gNrQhlcMGTOnYEfAesRi+MklCmmogj7wqu2p8dAl4jNB6eEVa
X-Gm-Message-State: AOJu0Yz1m2Isvgua/+5+73x4rkfZqFR/LMwvr4xXnswtFopiYZT4b/hg
	s/XmmLoVBht9ovw602Jx8R5GTd55Ou5lRGIWCwtIQYWfbssJX8NEOh/KhMcEM6E=
X-Google-Smtp-Source: AGHT+IET0WFWs+FWc8W1+M+r1ADzmI6SW5hXvkLQtHoJV0fLgauXP38LjeJBDmG2eptsbA8WWBKhpg==
X-Received: by 2002:a05:600c:358c:b0:418:301e:6c60 with SMTP id p12-20020a05600c358c00b00418301e6c60mr1902551wmq.12.1713543251679;
        Fri, 19 Apr 2024 09:14:11 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.100.236])
        by smtp.gmail.com with ESMTPSA id d20-20020a05600c34d400b00419c4e85b54sm1448229wmq.16.2024.04.19.09.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 09:14:11 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: x1e80100: Fix the data-lanes and
 link-frequencies
Date: Fri, 19 Apr 2024 19:13:55 +0300
Message-Id: <20240419-x1e80100-dts-fix-mdss-dp3-v2-0-10f4ed7a09b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEOYImYC/42NSwqDQBBEryK9Toeej6BZ5R7iQpxWGxJHpkUM4
 t0z8QRZvirq1QHKSVjhURyQeBOVOGewtwL6qZtHRgmZwZL15E2Fu+GKDBGGVXGQHd9BFcPisLf
 Ol8yO2Q6Q90vi3F/ups08ia4xfa6rzfzSf6ybQcJ6qLwldnUZ/PMlc5fiPaYR2vM8vwW7ngHDA
 AAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=dATceXyW1aFB6GDMYipKiutnHij7Lpxvfb3TquoiYMQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmIphJR57GEkzfF2APRNtuy5Idax3l6vDM4dUkB
 mtITdBRJpGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZiKYSQAKCRAbX0TJAJUV
 ViA0EAC/lzn4tmMvQnKum/DfyXKsDesUQFx60vahKBCOJUW55SAAO8w5LumUzQ6WUBFP6Jlr596
 CP0ejIpnZ15JCIm3UuvNBsKucMCM5I5Y04kBOpX99dKejl3DYCKxgjJc/3TtLpw+Ny6P5IQK88X
 Cs4hNsz28IKR4RJJG7zBwXFl1vMKny8puIKwNWoa0SDegfnkroKEp0lZQaovzwGZpSE1E2v5/Ua
 U2wLZIw3RAP/rvZuLa1d30f/kojr6MmYCRtHt7hcXDb7wElAwiWOkkkSsoPDhgah0nEqtOugPeE
 /fnk0HMuPzCjc9cnServ9IOWDl5ih+dd4RWrUheCrQDJwcu322mKvcMAOE1JVO8qbKuszr9wAW/
 NNN5XFqmN3+oGK8sxTzvse19qm6/qjFc5MKqzzX/6RNhDfEciUsJD6yd6u3fTkSZjQ/LUy6RK/t
 LAPoQwzCkfZYucKlnoyedbYOpIStKqVVMVGTu/ldU4PwzMJdhAxZ30z+P45dPz/tuDwOv39U6dc
 kC6j6CKA7HVVdZUEqVoBTaBZvJaUkTRGMG9X+iznIO+FQj3bXC3aArtkop1rpJi3h2mtVTmnFOG
 ffUkYNc5OgB9Ih3IcJ4unUwlBNkTGGkPv82QWE8krRcbc2D4okj/niCb1sbRK8xmKyr4xYdGI1i
 OGZaQi2Va1ie00Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Both the CRD and the QCP have the data-lanes and the link-frequencies
for the DP3 in the wrong place. Both are properties of the out remote
endpoint. So move them to the mdss_dp3_out for each board.

Without these fixes, the eDP is broken on both boards.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Dropped blank line left above the removed link-frequencies in
  mdss_dp3_in node, spotted by Konrad
- Dropped the "Display is broken ..." part from the first commit
  message
- Added Konrad's R-b tags to all patches
- Link to v1: https://lore.kernel.org/r/20240418-x1e80100-dts-fix-mdss-dp3-v1-0-9f8420e395d4@linaro.org

---
Abel Vesa (3):
      arm64: dts: qcom: x1e80100: Drop the link-frequencies from mdss_dp3_in
      arm64: dts: qcom: x1e80100-crd: Add data-lanes and link-frequencies to DP3
      arm64: dts: qcom: x1e80100-qcp: Add data-lanes and link-frequencies to DP3

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 5 +++--
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 5 +++--
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 2 --
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: a35e92ef04c07bd473404b9b73d489aea19a60a8
change-id: 20240418-x1e80100-dts-fix-mdss-dp3-c2345ee3ee2f

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


