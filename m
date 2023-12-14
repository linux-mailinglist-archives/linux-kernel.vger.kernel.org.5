Return-Path: <linux-kernel+bounces-207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD5A813D77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D0F1F22604
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9406A35A;
	Thu, 14 Dec 2023 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JXcnQNeD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6ED35EE8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50bf32c0140so11696e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 14:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702594105; x=1703198905; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=18dR/gJ68Tzlhbbfsas2KAF1Jf59BYu1fkf4Cm16aCY=;
        b=JXcnQNeDdzScn+1jFau6svT5xucEyaZE9cmRSs1yRhMoaeFOgMj7RYVGJBmv0wjAkA
         jnmOneL/lMpnvyEi7+VgUMuesCoTcdGrGFjp6nGZq8tJSPAE6whMeZ5ByERSFBOljxod
         rzZvb3/GiKpPTsYxZGGqO4OT/JPsBZY8baF8i3Pbj/rjiIEJU5zTO6IWJZJ1Tb4LKFDb
         pneDfrrm2U1YX9keQwAWsNkeKd9VyBIZy3YQGqDU2uSEF4kRuL2lfu5HTly5yhFD35RM
         Gk/Lt9leBwKpodjdJXuYSbZcAgvXkgaftqKtDwWtn4GW+6hKum/fPQRxUJJPkeZjb7dN
         LVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702594105; x=1703198905;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18dR/gJ68Tzlhbbfsas2KAF1Jf59BYu1fkf4Cm16aCY=;
        b=iodQBm0O067x0KTRwgnKFdR4Ayf4FFdr4oC0XuAmN6uBhcwk7MSaQLKTn4EmMA43/H
         nDId3INz+DOAMzcy8aPcWPo7dz6cPKnWFfaivKwlU39MDqvfy3xsJxkWiLa6vLb5k7IU
         WTg4I5G1rGZKtJ897+Ya87Eb30EuaVStkK1Ia3pxFJa8MLQgYCnNQ5RWqHk4fZLqRaKC
         Mibl7/gWg/k61Gk66krArIHOlHNC9lDbk2wOdCFPHrbFc/vkBoZjwDImevp9coxtEBNY
         qI/t+xFve9GbzNA6MQrmHOMRM3T46x83eAlfSS1xKQrFrurHd9SmsJrPRFh5tK5uP+Am
         VYjg==
X-Gm-Message-State: AOJu0YzRYSana5LE5bGTogWqSZDaJB2Qv/gMILakVmrEaDfbnjjUoa6g
	yIW4fsYRqNGZjm0cqOrPGeAzgwBph7khtdBr04s=
X-Google-Smtp-Source: AGHT+IEuyPKWvaf66FqyiNgSatAJFLrHoupF3X5SPOt7ddayDF/Fvu57IE0ogmtj67CBfHaf15VZ9Q==
X-Received: by 2002:a05:6512:3b9d:b0:50b:fa5a:6a14 with SMTP id g29-20020a0565123b9d00b0050bfa5a6a14mr6154923lfv.2.1702594104786;
        Thu, 14 Dec 2023 14:48:24 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a19b7362dcfsm10068118ejc.139.2023.12.14.14.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:48:24 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v3 0/2] arm64: dts: qcom: Add missing nodes to X1E80100
 base dtsi and CRD dts
Date: Fri, 15 Dec 2023 00:48:11 +0200
Message-Id: <20231215-x1e80100-dts-missing-nodes-v3-0-c4e8d186adf2@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACuGe2UC/32OQW7CMBBFr4K8ZtoZE1rCqveounDsSTJSsJEni
 qhQ7l6bVohumN2fr//0rkY5C6s5bq4m8yIqKZaw226MH10cGCSUbCzaHVkkuBAfkBAhzAonUZU
 4QEyBFRy2PXFo65kC6JwydNlFP1ZE17zex79VSjPMCXTkaaqDc+ZeLjebz6+SR9E55e+b3EL1+
 +dB9pnHQoBAzbvlnr3t8PAxSXQ5vaQ8mMpd7CNr/5RlC2vv3rj32ARE/4+1rusPANXmakIBAAA
 =
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=5YEbvad2KfLy9y8+cCnaV1ejt6pQXMq+4shP/isxEjU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBle4Yuwm4nzeqQ9a8MynjlUuXVgDGZlvmA80lnx
 9SSxUe+CZCJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXuGLgAKCRAbX0TJAJUV
 Vp1VEACAe9TWlY7ON8EjK0TF4Yddq+ljwt70UosjtPXcD55duhTdLQ4BgHxcuou5D5dDxqxE/In
 4lC3LnKrtNI0svApPLvlSsm5Xu9W8qgnCW22hEeoo4ZLGJoCqDALDIFLB/Wny61tYCNwzSLzs4W
 RXJ1t8iCwMmRRKURjuiD7cqxKNHcnvg/9YX8ArWOBCdwei5Zt/TM4Yp00V5dEn7D6IufqULleHZ
 bHnoVvHEws/BVOn3QJjNO+yZFK9dzTX8c9jC5c0HUxLjRalk+BYeTxQxQ0PU2CwwIgwSG6hiKWJ
 rdQ2MfzqFliO5xe8+v9zU8NAnAM4/fJ88vw8ZCM8eRHv65eEYCPtZBk1FxgjnCBee826HDXst/Y
 +kBsAs312nBYZNNKmQy3WGzQGIJehMPMbvIHX8iRyY7aeIBwi7wqQtQ/KBuLtwPnKidVks+RiiN
 PH7onyIs7QUL/mxdnwyaNFSKck41s3ghqMzzyMb/kTj0hP3jatkSc+cdwOTU8RfvTKceRh533/S
 2cIiL6bOYUevTpib7ph8lD+vQMhjJaGtcZVKhbEtRQUEoI57K4XQOF7P0GXZvWrbLj0y6UoKDX2
 OQJs8qf1E8hM0TnQI23fO5ywzzVoTHOnZ/RjE9aEhMEFRpZunbwXERmhy9QGQXIvjKuEJJj4i2Z
 c0yrOWi5yN2kCHg==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds most of the nodes towards describing the entire
platform. Most of these have dependencies on multimedia clock
controllers and so the entire patchset depends on the clock controllers
patchset:
https://lore.kernel.org/all/20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v3:
- Reword the commit messages
- Link to v2: https://lore.kernel.org/r/20231215-x1e80100-dts-missing-nodes-v2-0-5a6efc04d00c@linaro.org

Changes in v2:
- Reword both commits to make it more clear nodes that are being added
- Dropped comments from interrupt maps from pcie nodes
- Replace all 0x0 with 0 in all reg properties
- Moved on separate lines reg, reset and clock names
- Dropped the sram and cpucp nodes
- Dropped pmic glink node
- Reordered all new clock controller nodes based on address
- Dropped unnecessary indent from touchpad and keyboard TLMM nodes
- Link to v1: https://lore.kernel.org/r/20231212-x1e80100-dts-missing-nodes-v1-0-1472efec2b08@linaro.org

---
Abel Vesa (2):
      arm64: dts: qcom: x1e80100: Add more support
      arm64: dts: qcom: x1e80100-crd: Enable more support

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts |  221 +++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 1323 ++++++++++++++++++++++++++++-
 2 files changed, 1539 insertions(+), 5 deletions(-)
---
base-commit: d0f93829813ccb38ad35811da864672e32595f9c
change-id: 20231201-x1e80100-dts-missing-nodes-a09f1ed99999

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


