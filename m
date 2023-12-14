Return-Path: <linux-kernel+bounces-194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D17813D50
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C81F21663
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6599666ABA;
	Thu, 14 Dec 2023 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQvxasax"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2626671E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a1e2ded3d9fso11512466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 14:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702593344; x=1703198144; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/Wmx4TpLF8+lB6I8uR0FvmZriN6eFrYagCqgmm2SWk=;
        b=mQvxasaxdKcxCBG0SK8QJNaBk7qIKNdAOJ4ybw6Qmn/IT0hNuQ3y939DiB0FTbiKjm
         lo4fd7AFt1xTrBhYpA+fENL6D1NiaF4PuvlfkNJFBUzYOmqohBgfFVyNY40uXxjJrOO3
         jxA4GZ/ILmxErr6MM7yZWfh/dnlKEoc4NqBgBOSpYhLJgiXz8UlvK4nWq6XRaJvRoEww
         8Ob5WAALCBp9N3VHBQKsxElG8iqq9mR/fe09crM786lDXWTYhzRCJA2L5LOxxDrpXBgU
         nRwraldb+KnZcyhxNcmQAiPyrWzYzx6/DKLFOq21Nt/1xIzRW1FYokUqDO5XpIWt2vfs
         aGmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702593344; x=1703198144;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W/Wmx4TpLF8+lB6I8uR0FvmZriN6eFrYagCqgmm2SWk=;
        b=RTnkka8J7ONww5VJr3XOiLjeROSnNMlTZkg8VmAwpUMVANMtObPjdRjmx0aJs3+xR/
         xjc7e386HPHSpS0VPDE1JcjxS8owcgowQFSiaEDFtkMduHTX8sxaWOh7P7/l8j6iYGzu
         M1PFzpbaI0CQFj9N3Iyeqi8ATPnrBX6otAQc7mT9r5VoV0LhcAcbj2dtLcNe3MrpNLB2
         qyz4RAMhwZztmVK+s6UsCg3BkyJQ0F2OdEs2IYTqCewpThG+4/GtFVCwV7V9GlR+m+zD
         zjVW/ajHvmovGinrc3j0//RYsiuLN9Eyof9F6mOKIEd9R7/kEor16q2RPQCcv02TeZTG
         0ofQ==
X-Gm-Message-State: AOJu0YxIJm6LUKGm05liHaSIKxzxEguutCODnb+5wbvZX54ozG9YT6qE
	x0kt+v7RIxy4vY7n3zrp0k+Oxw==
X-Google-Smtp-Source: AGHT+IHBUfjW/U017n6GjofZz9DRM/BS29ZM6w1w/ASVPM8T7ljlXUtro1pAKrugLXsPufPCrI8nnw==
X-Received: by 2002:a17:906:c0c5:b0:a19:a19b:78cf with SMTP id bn5-20020a170906c0c500b00a19a19b78cfmr5571775ejb.146.1702593344037;
        Thu, 14 Dec 2023 14:35:44 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906d00900b009c5c5c2c5a4sm9975877ejy.219.2023.12.14.14.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 14:35:43 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/2] arm64: dts: qcom: Add missing nodes to X1E80100
 base dtsi and CRD dts
Date: Fri, 15 Dec 2023 00:35:36 +0200
Message-Id: <20231215-x1e80100-dts-missing-nodes-v2-0-5a6efc04d00c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADiDe2UC/32OQQ6CMBBFr0K6drRTSQRX3sOwaOkAk2BrOoRgC
 HcX0Lh0dm9+/s+blVBiEnXNZpVoZOEYVjCHTNWdDS0B+5WV0eaMRiNMSIVGrcEPAg8W4dBCiJ4
 ErC4bJF9up9YBZ4XAJRvqbptw+elX/kQxDjBEkI76fis8EzU87Tb3auWOZYjptcuNuH2/Hmj+e
 YwIGjC/GGqoNk4Xt56DTfEYU6uqZVneQ8La7fYAAAA=
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1426; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=2F6tRQ7/oxH542LMukW9vn1KG7LtBFSh18s72W3oEeo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBle4M6YPe/bj0I8kobAFpU4NA68XLEfwdh74R4d
 D4MzZaQOhmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXuDOgAKCRAbX0TJAJUV
 Vo2uD/9ujiFDXQPb95MYYVmrdSwmIZbRrdjI7Db/1OgT1BnuO6pa/UhmPSfcdutVYudyh6ZOKfr
 FXEM7E7klN1fZgtXKrHxFrwVv9M41e1Llzd2Gka5YJoBMhNZZ4yRVlGvMDsSXIyWpbXtAjAJEDN
 HdDX6DY4mKWcnmgU+vG+Lp7jNo/ajz7cUcZ9DGyN4IcEXUrnx7nzGwJ5yTWCwzAkxJO0G03KbVa
 Nmpx/gUsBJ2G2pzU4PFAyoBGm9Pxlx3LlO8B6hKmNyW1y1EhA+zufW+7mzJp22kUtG+KShPCSv5
 XA4dRpCj81p08g0HW6FZJSKq+YH1Sw/7uXQGWPAoDGltY+e31PdPhceNr8MeNlkpaEazPV4GRtm
 4xBkGYIgDeP0nA3pyWokJozrrSb+0bxQ4wKEvD7Srz06TBBlHSAAwtLC+VM5LJrWs56ktotMuMN
 OX/thTm2lxrnMO6AOmYNObTwjKlL0ewUeNGFCsVX9xBGQSJju39k4NUG8CTh6KaGda/oQQRBXfJ
 ASyFl5X5ADKRT/T0LcIt2W+pXWIozIV9e/0s+X8eIG9+W5/heTKPCfVqFrEecfnekgVn7oH2yOV
 BehrCnQg/hNUyPVd3fj5tzZ6IisXjkV8zpWaSY9cTIcguRaNcgddQJsUP/0fPpMeXlrKPjzNpZ+
 gImiXOPTqGylCZA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds most of the nodes towards describing the entire
platform. Most of these have dependencies on multimedia clock
controllers and so the entire patchset depends on the clock controllers
patchset:
https://lore.kernel.org/all/20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org/

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
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
      arm64: dts: qcom: x1e80100: Add all missing nodes
      arm64: dts: qcom: x1e80100: Add some issing nodes for CRD

 arch/arm64/boot/dts/qcom/x1e80100-crd.dts |  221 +++++
 arch/arm64/boot/dts/qcom/x1e80100.dtsi    | 1323 ++++++++++++++++++++++++++++-
 2 files changed, 1539 insertions(+), 5 deletions(-)
---
base-commit: d0f93829813ccb38ad35811da864672e32595f9c
change-id: 20231201-x1e80100-dts-missing-nodes-a09f1ed99999

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


