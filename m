Return-Path: <linux-kernel+bounces-9735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E9281CA68
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D98C32836D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95C519465;
	Fri, 22 Dec 2023 13:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHv53Ru7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078D18B00
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d3dfcc1a4so16043605e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 05:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703250107; x=1703854907; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWmdonR8NpARXjfe3qqartT0mhGrBDRLU87EB6urV1M=;
        b=QHv53Ru7dD3dDJjPkOw+rVTu0U5yTeMUUqQXtxdTiwdxv5FLT3n3YowTLF7wCJkPzo
         mEsnvZkVJsgWsmBNXqUE10nYyd5z9WkSmwzx8oim9CQymRptJ3/PfrgLJyD/4OW8eCqT
         LWdHllIxMAHP4rlYmVvdC3w/ZIKrw+swYraaYJVzeTfxVANjvaVcsyDxNia1dtPt922d
         OKSckHAP2oM0RJH9YC0t77/r/K48YwZBDqXylWFtfTm+8OvX96BG5SKAotk+P5eqLA5q
         /Q9Nkz2xXb+T6V9UxJ9he5x2RXam3qOQkFYKO0CGVdSfWGE3cQrYMOFq33AbXmHmO1Od
         cO7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703250107; x=1703854907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JWmdonR8NpARXjfe3qqartT0mhGrBDRLU87EB6urV1M=;
        b=TKVxzkYGn9Fg0549lVnPFPuc+JQgiqdqVS/SisHVqG3nkdThoTtotZRvqImivsyTxq
         HxOc/EewJ4TR3CxMuJCyP/6/nSLIzQfkyscbhQAGx8WT7kHbgTwnO91FBlW7BId0vwnV
         NbBI+lQzIKkdh/GXb8lE4kg2wK1sSQTkSEcn4KsfsMSf/U+PU8qaUoDZMuQVLSRqiKu+
         VkN070H3T5oh/eL2gBM0QsNJor2Lf8ngeYeDFEzfi6p+H9mWnEZiybWEv6QBOgvvFy5b
         kcHrpRBVleuUHE9McWEd+VtXU8Ci8H10gH0phzgecLm4j7xxpODZmqT0Zl3LbabXQWXV
         ClaQ==
X-Gm-Message-State: AOJu0YwxbaoPscuBk3rugTOZ5VWjyP8bSIDTFd+z4Qm3HZfhU7HEzwGM
	n5A5NKRWSr7EFRxJJWTZ8mUPpbGandoVBQ==
X-Google-Smtp-Source: AGHT+IEoyA67rBN4hpcEFYo6S+igZ3ct0M4Huc2ATJHcWr0tSVPEJyqU9rE5tmgTRM8HN9IfSSXvXg==
X-Received: by 2002:a05:600c:1c9d:b0:40d:38c6:7cfd with SMTP id k29-20020a05600c1c9d00b0040d38c67cfdmr774026wms.35.1703250106701;
        Fri, 22 Dec 2023 05:01:46 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id h1-20020a05600c350100b0040d3f4b1c8esm5375631wmq.36.2023.12.22.05.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 05:01:46 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/2] phy: qcom: edp: Allow eDP/DP configuring via
 set_mode op
Date: Fri, 22 Dec 2023 15:01:30 +0200
Message-Id: <20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKqIhWUC/5WNTQqDMBCFryKz7pT8INGueo/iIk1GHbAmJCKKe
 Pem3qDL773H+w7IlJgyPKoDEq2cOcwF1K0CN9p5IGRfGJRQWirZ4iapEVIIjOOO5CO68Il24fd
 EmKi3bgkJG6M1OWuc8xbKVSwNb5fm1RUeOZfZfllX+Uv/FKwSBfYtGWNq1dbaPyeebQr3kAboz
 vP8AgKA0MrZAAAA
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
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=cDX+OTRf4Doi1u/l+84vE/tm+BZU4P6g8JGruDSER80=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlhYixD+yv7XbZuCNQkxvgIpsKAib9ot+pgK9dZ
 ftlCviPpdKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZYWIsQAKCRAbX0TJAJUV
 VqK3EACPWP40VmX3w6tO2nMIW+Yhud4GatWzn2ZY79z2bMwGc3M3DCL36ntk9c3LUEqGAEH84e/
 Bcb6Ftjeyqg0qOXTmrXIxpg2NAo8K5M4JQe72PH581cZNCTa4SJlaSnlzaHLr5EJaa9xp/SJrT+
 ddP5UrbWhyaPHMAPxo8QewHyYRYBnBED0GZ/Uf62g34M0MRg3VXEtmPwKLLOnbR8fO19Ag7oxEf
 Zi2cxEHQkEbdQLlMBaMcxIvUJWPqe/gppHbKVXnlKb/a0sYoaZdYhYBg0TRYYyzuqYCePcJQ77u
 AnxxJEa/81oJClfHA2MndDvPLkg0qEciRm+ICpPIIfCrPj5DyglyqL/yeFEW4y8kEeX6+6gTz7d
 CoPpiatJmQPrB1q7K7vAoamc/dxMk6gjbbdHqj0FI8CnBqBw04FGkCc1z39YkD5orNqfVJb1VK+
 88t1tkXvdS0hSW19xcUSCmD9CV8l0esR0JtKtXS0tkyj2YdevYzyoPnXyQ/W5MSithZmqKZqYpK
 zrcpw2/42vRFFejm1+O14OMKzulceLQJG2xcI9CjdhAnoM1EJKFl4Gl58GY/jZrVhgzOmLr9lCe
 +pl7qrFpfWVwM/w+i4PAq0vt8gEjC8n9b4ZtwYFWlxp5ywwOHQWUjFGEI0vFOe+lYg688PFmM32
 +paxeYaKrLfKmTQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Until now, all platform that supported both eDP and DP had different
compatibles for each mode. Using different compatibles for basically
the same IP block but for a different configuration is bad way all
around. There is a new compute platform from Qualcomm that supports
both eDP and DP with the same PHY. So instead of following the old
method, we should allow the mode to be configured via set_mode from
the controller driver.

The controller part will follow after we conclude the PHY part first.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
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

 drivers/phy/qualcomm/phy-qcom-edp.c | 90 ++++++++++++++++++++++++++++---------
 include/linux/phy/phy-dp.h          |  3 ++
 2 files changed, 72 insertions(+), 21 deletions(-)
---
base-commit: 8a9be2a3cb673dba9d22311beb74be261f0b3f15
change-id: 20231219-x1e80100-phy-edp-compatible-refactor-8733eca7ccda

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


