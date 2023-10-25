Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D3A7D6396
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjJYHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjJYHhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:42 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC2E3C21
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dff202b4bso1883003f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219347; x=1698824147; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LuZMkbxv4lOoR8L5PlaX616AqvMbmm0wHfhqvqys2P8=;
        b=d3q+ytglzxkl3BT4ew+V5ltbnyUfV/ulSXO8J8F42egYDwalMCMhpQydGHdvVCdPRg
         R0NMtyW2r7C/0q0GzPUk52Xr1m3MhuAQQS0ZEDb0dbJ7KX8TfjgLlo7HH0w5T2Dg6Up0
         s4x0xxICGePW4pwg+OvqG7Yom3oRf628W9BEvImaAb7GqIsAF8EQHYEHRSPqhCQqzb3I
         6X29UYWyHPU3510hvDLmbE7nkABCtMj8wUP4cyp+495vrBw8rRC+bJgHfN8K95KsdWcK
         tDcnKKRLK78BRkAgkFwfkYiIShGb+VGIvC/1UFkdOfOtnbqseQLyOssYhUuu5G6E4YpX
         t3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219347; x=1698824147;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuZMkbxv4lOoR8L5PlaX616AqvMbmm0wHfhqvqys2P8=;
        b=sq+wzdVYND6oWoFffG8GjH03yMWQY6NUnbax2v9lhdHjP+h8f7qOVrtLWKLmuc3lZe
         5TfWMTusRO4O6F1GUfHzlXKyPRVpIrv5pwO4JB5qDP0SEJy9edEAbQK88qEvDZTlGtc6
         DIA6cmrjLooobEWRCfBCiOdaDJ9rRjQhEHdJiL5unrMLVUzhyWUmLU0fQ+SIIVoUts+q
         KSDiSZj3bJ1vU8q3d9ANQ0/yWyT/u4NKj4m4Jm0wwLZZ3eaLvTOwKl6x9lFoajj2v6qw
         UKht+aP0jeaYnUB2UQqZQFlpDgPP7Iykc5b8h+iSYmQBLvJocFr7EEmFPJeJF8F9s/j7
         ECzg==
X-Gm-Message-State: AOJu0YxU3LZNQIBArZ7Hyr1FVjetSAWN/2FB+SnzTI38JV00kWnCU9fe
        2x7YhfKveJ0FEiRtmckv+fy1tQ==
X-Google-Smtp-Source: AGHT+IE/jBJ78iYrm60h7+ZediUSZppT/KAya0yPIC8L6ZyljEwy3u1G6Ruj/TRjmlLHPjvUruAeCg==
X-Received: by 2002:a5d:4043:0:b0:314:1313:c3d6 with SMTP id w3-20020a5d4043000000b003141313c3d6mr8273034wrp.33.1698219347171;
        Wed, 25 Oct 2023 00:35:47 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id d14-20020adffd8e000000b0031984b370f2sm11416346wrr.47.2023.10.25.00.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:35:46 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/3] remoteproc: qcom: Introduce DSP support for SM8650
Date:   Wed, 25 Oct 2023 09:35:43 +0200
Message-Id: <20231025-topic-sm8650-upstream-remoteproc-v1-0-a8d20e4ce18c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/FOGUC/x3NQQrCMBBG4auUWTuQtDgWryIuYvyrs0gTJlGE0
 rs3uPw2721UYYpK12Ejw1er5rXDnwaK77C+wPrsptGNk3deuOWikWua5ez4U2ozhMSGlBuK5cg
 iYb4AD1kA6pliWPT3X9zu+34AdvU/MnIAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YgeLp8OwDHnCQkyYhlcUdjOeopES1tNQUXbEyCTj8Oc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMVQ1OwV/MZ2jOQdUnfkOghpJyNe/BxAhxiT+PQm
 kAXjk2KJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFUAAKCRB33NvayMhJ0RDOD/
 9DOhccEOhJq2/GIEU3oWWYhH7xSI8VBsGHFfRXy6dS2+m6z/0GfvDcDES6KFVZIublrVIshgLHvLYo
 SmIjrxawVa/mccex+OzEXp8SuBPFaSmrtGlp6vJgOiQkFCd3pyhL5hk0HJeqisVImKPBn6vAkg5e9w
 6dwvGlrOl+tVyiAjO/etMJftpEL41DYaHaPG1KMLF3ocSrMaLni6m2AmzEcogj+Ual2BXVWraZkd5i
 0r8VWLul4v8MRlJwwq9kOwwghD35nzvhzVvntT9PaN7TpcN9mDZeC1mZDa5vxOye86z56vQ0Ccw9/w
 +Iu1reIXq5Te/t5uequFUHaWq1GCr94/tEVm9vIK6LMMUTmkNv+bFWKNTst5Is1D/k4oumKInN4ozh
 PwmRZ7ROh+bNRp1IIEMj9fNC/dRiR9be61XsezBv/8Hlb67OZhJBh4QqVtGG9hOw/jVxsp21UW2irL
 opHCsfp1RmdK7MLtXWOC9p2EEwcwY45RgJJ48V1lvt9WjBBwk47nyFd6xsZtDFZiJ6Cc+J6Y7sYZaQ
 ZQLpYVtnzHhhDRkuDgmiW493qN0Cq0Fx2AOL43YKRzoVUo77dqo1HKOBYG5pAjA7XB9a36vRwhOWpQ
 70drGS4IcmIOLb7kxVwVqNZA7ba0YBO4UEMMZFX5lnVPOzSOBzMsAtDRIUDg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the bindings and driver changes for DSP support on the
SM8650 platform in order to enable the aDSP, cDSP and MPSS
subsystems to boot.

Compared to SM8550, where SM8650 uses the same dual firmware files,
(dtb file and main firmware) the memory zones requirement has changed:
- cDSP: now requires 2 memory zones to be configured as shared
  between the cDSP and the HLOS subsystem
- MPSS: In addition to the memory zone required for the SM8550
  MPSS, another one is required to be configured for MPSS
  usage only.

In order to handle this and avoid code duplication, the region_assign_*
code patch has been made more generic and is able handle multiple
DSP-only memory zones (for MPSS) or DSP-HLOS shared memory zones (cDSP)
in the same region_assign functions.

Dependencies: None

For convenience, a regularly refreshed linux-next based git tree containing
all the SM8650 related work is available at:
https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm85650/upstream/integ

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (3):
      dt-bindings: remoteproc: qcom,sm8550-pas: document the SM8650 PAS
      remoteproc: qcom: pas: make region assign more generic
      remoteproc: qcom: pas: Add SM8650 remoteproc support

 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |  41 +++++-
 drivers/remoteproc/qcom_q6v5_pas.c                 | 152 ++++++++++++++++-----
 2 files changed, 156 insertions(+), 37 deletions(-)
---
base-commit: fe1998aa935b44ef873193c0772c43bce74f17dc
change-id: 20231016-topic-sm8650-upstream-remoteproc-66a87eeb6fee

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

