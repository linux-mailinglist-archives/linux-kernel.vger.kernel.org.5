Return-Path: <linux-kernel+bounces-72963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264585BB34
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA83D283F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA7A67C6B;
	Tue, 20 Feb 2024 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ew8un/RL"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1E67C5C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708430302; cv=none; b=Sl8klM8li86sydMYWPsQ8R7ku4oBfYhw1YMcMrTBqg/u2/N3aQ86Cd2tkk9mIwJEz1m3wefGYwSDmLSod9/za0jd6Ep5QDeq925drWUDmvQwKkC1CqVVhsoAVz4xmUEcbRuRghQoaCNE6PfJULxyFlVFVALl7NCkj5La1SSnspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708430302; c=relaxed/simple;
	bh=7Udz5KW/6xoz4UGY+Rjo1Skg7siskYCtz/9jh9/XGz0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d5ovrS68j45uaoCBPAfsMdv+7ZOQX4EtKrWxK33CN4x3KG0Inx7fsjZIK4B1/jUS/geVkPgmvSeIYyvFHToIB7RfX5CKehkQHgOYIUq7RPnXMSNs3IE100q4lgUu2Sp7LIdYFVnIA+AoixZ9eAbVWw5zUNGHSCwyR7z+C836DCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ew8un/RL; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso224824166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708430299; x=1709035099; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh7WIPngChgpb6/wT2qnSquscN8CZ3uMdGD+jaJxYv8=;
        b=Ew8un/RLU2+YD9Vk+390eAdJv50koVnrDSGvSbDocCgk4/SMv4r1tqWkVyC1ehfT62
         BogqBQHJ8ZFBu7iyxaJmMl+c5SQqNCKg5ImiFeVrEx1xPckKPo+sXYBQVV2TDc2nD+vP
         cr075PbAV1/Y1lgNA9nqmHtpXT4F3ZEW3pzGfbe6KiB+rfVLh9ypzXymBb/UK34CpeUz
         D96OymrBpXphaCeypH5nGpFSDmvvjxI/Lww4w5+MtkmRku7Fyn9mXJ9t5leilxUl9rfT
         2c3AaQoxiEz59XGGPHmzUecczRR7t1/odqTyYQ5UYZc7JBAco0hAHnKjX/7dS3sUyDfH
         PGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708430299; x=1709035099;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh7WIPngChgpb6/wT2qnSquscN8CZ3uMdGD+jaJxYv8=;
        b=sLtj9as5wSaVLzY9udNDBqIMplRGB7oOraHxBRoUA2n8IRh66NPtU0BCFw+kS0lwiY
         YzcNTtGcUo6hPfDhlGlYbQeXlZPhWQqzY5FfiVX6theJkVf0cno8i/TfP6oefHOCsbCB
         Q+cmPU1xI5RO9IAtFHMAI0vUv6xWMP2dg66CpZtkAM1U6bpOw6f7vcklJCCG5wIp53HK
         WYgOEG5PaU9/nQbu2ygZm45ijCTZEiCFXsIRnSoExQ28AQSrIQOt5uxV3i+bURsM+jj/
         W9eKljfVNZO2cpAld7VW2eo40XlK3KOKoi44ln4Sm7zNEB4cpcxblLLWXmzDh7wG7DhQ
         e9Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXdMXWNvBejoi7xznJtY0bi3GjF/A1EG3znilj1GRxC4/OqWBg9uSdWRcAHOWz5VaQ2xQqKetmjw8pWrupKYe/r7a5CfB3KSp7UkmFe
X-Gm-Message-State: AOJu0YxGq4VKaIC0jf5855oUnEaPDlj6wwlSS3J5LpTBmGe8RTsYlb76
	lM0HjwdKyYVbECc65DhJCzCboeNjnBnrn5yi6lOtl8ejjHQ9nVbqA1PQjyfbYRA=
X-Google-Smtp-Source: AGHT+IFoe/LWd8BNCe0CFGtUR4A9XiznkrU4tZkBvlJ7n3YSE6lN588gdYxp2euRyTWqLef7mZ7VkA==
X-Received: by 2002:a17:906:b0d9:b0:a36:5079:d6cb with SMTP id bk25-20020a170906b0d900b00a365079d6cbmr10386563ejb.56.1708430298864;
        Tue, 20 Feb 2024 03:58:18 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id hu11-20020a170907a08b00b00a3e0b6ea9fdsm3806200ejc.26.2024.02.20.03.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 03:58:18 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v5 0/2] phy: qcom: edp: Allow eDP/DP configuring via
 set_mode op
Date: Tue, 20 Feb 2024 13:58:09 +0200
Message-Id: <20240220-x1e80100-phy-edp-compatible-refactor-v5-0-e8658adf5461@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANGT1GUC/5XOwWrDMAwG4FcpPk/DkuM46WnvMXZwbbkxdHFwS
 mgpefephbGNXrLjL4nv103NXDPPar+7qcpLnnMZJdiXnQqDH48MOUpWpMkgYQ8X5E6j1jANV+A
 4QSifkz/nw4mhcvLhXCp0zhgO3oUQvRJqkk2+PGrePyQPeZaz66N1wfv0nwULgobUs3POUm9Nf
 Dvl0dfyWupR3RsW+qUSbVRJVH+wrmsDGdunJ9V8q41G2vqrEZUdJiNksMY+qc2PSthuVBtRg3Y
 poreEXftHXdf1C1PWuJbbAQAA
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2479; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=7Udz5KW/6xoz4UGY+Rjo1Skg7siskYCtz/9jh9/XGz0=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1JPSXVn22nZZVesnmTfbk565klqo4ijWcXGzI
 dqFsP6F07qJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdST0gAKCRAbX0TJAJUV
 VpdoD/9QESOYfZuXavef+P6IDI2bKCPqHFqpYS/m7d5zzf0DruUSxnEOpQoj06n5gqSVhpMUScO
 CuoBvO/3OCQfd8GNN+eWiRJBhKGIskr5VfTQjfpvf70lQYKLdJeCFut6QgAFRxP2iT/OjzUDZce
 I4DOH3CyyW+LtOHn9jkcVLfOXhZ051IkzmC9GmJYmlFXHtajNNnp/fo/XxdBkUDK/UQDu35UKKh
 JKNpqqcQBrhTFBJMFGpI/APQFyGQo1Ug/spdsITxRvMMDITJ6XbgQAdioGrErhej7+FqE3WFvfu
 UZNH/K9OkV55ZSWFICXm3g86ViW2Mqe+DAGvul5YpfKrbDYGiai8CURHfIEyvblzwbJsolldnnr
 ncUwnIbPXTYkCE4VV6kbb9BfBBi5mzZkHezLlysODvdobIXpV3USyY9WRBFC56q3U8Gd6cuvmxt
 LKhqfY45Mb3gAh4s8OnhbTnYOf2Ajgqv3/ociCZABzFYkhvFtjjyXp2donq93PCMXpcCXwnzIO+
 b6EYBacpPj9j67yF1JO+cK3z8n4KRKWU8VO509n78jSK1PFMvbY0gYp4PaCS7LRfEQ8lkd2t/vC
 krGUPze0fSepCrK2ggj2mQavYMhysAC+vxQAc6ZKFCBtQ5Wna3jFJgzPh4lyNDe/P+oa05Xrn03
 v7a9zi0kVJl2yFA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Until now, all platform that supported both eDP and DP had different
compatibles for each mode. Using different compatibles for basically
the same IP block but for a different configuration is bad way all
around. There is a new compute platform from Qualcomm that supports
both eDP and DP with the same PHY. So instead of following the old
method, we should allow the submode to be configured via set_mode from
the controller driver.

The controller part will follow after we conclude the PHY part first.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v5:
- Dropped the unnecessary ternary operator.
- Link to v4: https://lore.kernel.org/r/20240216-x1e80100-phy-edp-compatible-refactor-v4-0-c07fd1a52186@linaro.org

Changes in v4:
- Added todo comment about setting the value of cfg8 based on swing
  pre-emph availability, like Konrad suggested 
- Fixed the condition in qcom_edp_phy_power_on, reported by Dmitry
- Link to v3: https://lore.kernel.org/r/20240129-x1e80100-phy-edp-compatible-refactor-v3-0-e71f3359c535@linaro.org

Changes in v3:
- Dropped needs_swing_pre_emph_cfg as we store the table instead
- Picking the table based on is_edp instead of overriding.
- Link to v2: https://lore.kernel.org/r/20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org

Changes in v2:
- Dropped the dedicated xlate function and added set_mode op instead
- Dropped the eDP PHY type and mode addition
- Added the DP PHY submodes (eDP and DP)
- Removed the device match data storing from the container struct
- Link to v1: https://lore.kernel.org/r/20231219-x1e80100-phy-edp-compatible-refactor-v1-0-f9e77752953d@linaro.org

Initial attepmpt was here:
https://lore.kernel.org/all/20231122-phy-qualcomm-edp-x1e80100-v3-3-576fc4e9559d@linaro.org/
Compared to that version, this one uses the phy-cells method and drops
the X1E80100 support. The X1E80100 support will be a separate patchset.

---
Abel Vesa (2):
      phy: Add Embedded DisplayPort and DisplayPort submodes
      phy: qcom: edp: Add set_mode op for configuring eDP/DP submode

 drivers/phy/qualcomm/phy-qcom-edp.c | 76 +++++++++++++++++++++++++++----------
 include/linux/phy/phy-dp.h          |  3 ++
 2 files changed, 59 insertions(+), 20 deletions(-)
---
base-commit: 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e
change-id: 20231219-x1e80100-phy-edp-compatible-refactor-8733eca7ccda

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


