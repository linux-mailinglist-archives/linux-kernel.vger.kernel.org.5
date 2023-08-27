Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480A978A1C3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjH0VOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjH0VOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:14:24 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AF7B9;
        Sun, 27 Aug 2023 14:14:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c73c21113so2295083f8f.1;
        Sun, 27 Aug 2023 14:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693170860; x=1693775660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFbgrL50bzSftgmNjyPujQR4Of2JfipVU9EaUv5eW7k=;
        b=B5c+CBf7Yn/n8mBJmOnnd1TShNW0G5Opod/g1mWNmOZe5oaLLGZRiGXZKyloxPpTbv
         54UdCUiSdKo49RguR4xMFZgQ7nm0X1/rlEWV3VyT6j6YHoo3i6S8M6NKrZ+4bJJV0Snt
         zQS7SBZKvRpTys1e8bBSjKIbja4iIyGI4Cg0EMtViB3ZRSP4NCKUwCM+m0ajJyHGzZSp
         Hk4qbPAFJslPNYW8/WvIGl+RAu3tbdvJh7jFc4ezLZ6YZvFrGYOO8iPx5waH4p5yqx0m
         nZOIGymc2bCFybtOmuwb+4khu+gMa58aKmnTbrpxlnBFY+OGtqAcKms2/b6kNAXlsq4q
         2eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693170860; x=1693775660;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFbgrL50bzSftgmNjyPujQR4Of2JfipVU9EaUv5eW7k=;
        b=gTaREs3/veR3KUOaIOX55HVzRELFqoJeTYgzUDVjk0g30j98Qfc4x+c3o74ndqTggi
         78PFY8RZc9GulW+UfDaG6rZy55mvxCpFma8A/Lm5eeb4UxeRgm/ynwQXxugou0w+H4nv
         471GXVzkksD2aDOC6esZsUO6WBWsYyEWScGeyyiJEdr4WodLcpfbCfNu0j6Ge+JDb6Ln
         ePPzBvxUPqVOGCrtM9q+gYVD9f44XXdggycKUk0/2hOMd4iZfu3RegcCiZIDShdo1F0P
         Il31hTb3uTJaEccuaRA67kJ1V+dj8i+vY8kXH+Xk1UZr3lY717VttOE5CiJMCagFyf6t
         Xn1g==
X-Gm-Message-State: AOJu0YwZFXQJUkytkks+NhI1eUA0cq7MWuJUri4Zxvp3o9YxeV2gwPw9
        /7RXD5T1+DO8QudOgVyTq91opL3uxBU=
X-Google-Smtp-Source: AGHT+IGaKQafzwpIEkOUAjoanB8y3BbvHV7Le9YzTS+LmIdP/bFXe2qobbXbha1VypEqPKqR+cUVdQ==
X-Received: by 2002:adf:f9c4:0:b0:314:420c:5ef7 with SMTP id w4-20020adff9c4000000b00314420c5ef7mr17282539wrr.11.1693170859784;
        Sun, 27 Aug 2023 14:14:19 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d638e000000b0031971ab70c9sm8541997wru.73.2023.08.27.14.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 14:14:19 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Sun, 27 Aug 2023 23:14:03 +0200
Message-ID: <20230827211408.689076-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for the QSEECOM interface used to
communicate with secure applications running in the TrustZone on certain
Qualcomm devices. In addition to that, it also provides a driver for
"uefisecapp", the secure application managing access to UEFI variables
on such platforms.

For a more detailed description, see the blurb of v1.

Previous versions:

 - V5: https://lore.kernel.org/lkml/20230730161906.606163-1-luzmaximilian@gmail.com/t/
 - V4: https://lore.kernel.org/lkml/72c0359a-eda6-30ea-0ec0-b7e9b804b87b@gmail.com/t/
 - V3: https://lore.kernel.org/lkml/20230305022119.1331495-4-luzmaximilian@gmail.com/t/
 - V2: https://lore.kernel.org/lkml/20230127184650.756795-1-luzmaximilian@gmail.com/
 - V1: https://lore.kernel.org/lkml/20220723224949.1089973-1-luzmaximilian@gmail.com/

Changes in v5:

 - Small code fixes (e.g., missing 'static inline', missing includes,
   removal of unnecessary functions, improvements and fixes for
   documentation and comments). No larger or structural changes.

Changes in v5:

 - Re-introduce a dedicated platform device for managing QSEECOM client
   devices. The device is now added via qcom_scm.c instead of the device
   tree (as has been done in v3).

 - Replace ucs2_strlcpy() with ucs2_strscpy()

 - Drop "firmware: qcom_scm: Clear scm pointer on probe failure" and
   sort out probe-related issue.

 - Clean up comments in qcom_qseecom_uefisecapp.c

Changes in v4:

 - Integrate the QSEECOM interface into qcom_scm.c instead of
   instantiating a custom device and requiring device-tree bindings for
   it. With that, drop the respective patches exporting SCM call
   functions from qcom_scm.c and the DT bindings.

 - Restructure management of DMA memory and move DMA mapping entirely
   into the app_send() command, removing the need for DMA handling in
   app client drivers.

 - Add support for EFI's query_variable_info() call.

 - Move UCS-2 string helpers to lib/ucs2_string.c (introduces patch 1).

 - Add fix for related cleanup-issue in qcom_scm.c (introduces patch 2).

 (Refer to individual patches for more details.)

Changes in v3:

 - Fix doc comment in qcom_scm.c
 - Rebase on top of latest changes to qcom_scm.

Changes in v2:

 - Bind the qseecom interface to a device.

 - Establish a device link between the new qseecom device and the SCM
   device to ensure proper PM and remove ordering.

 - Remove the compatible for uefisecapp. Instead, introduce a compatible
   for the qseecom device. This directly reflects ACPI tables and the
   QCOM0476 device described therein, which is responsible for the
   secure app / qseecom interface (i.e., the same purpose).

   Client devices representing apps handled by the kernel (such as
   uefisecapp) are now directly instantiated by the qseecom driver,
   based on the respective platform-specific compatible.

 - Rename the base name (qctree -> qseecom) to allow differentiation
   between old (qseecom) and new (smcinvoke) interfaces to the trusted
   execution environment. This directly reflects downstream naming by
   Qualcomm.

Maximilian Luz (3):
  lib/ucs2_string: Add UCS-2 strscpy function
  firmware: qcom_scm: Add support for Qualcomm Secure Execution
    Environment SCM interface
  firmware: Add support for Qualcomm UEFI Secure Application

 MAINTAINERS                                |  12 +
 drivers/firmware/Kconfig                   |  32 +
 drivers/firmware/Makefile                  |   2 +
 drivers/firmware/qcom_qseecom.c            | 120 +++
 drivers/firmware/qcom_qseecom_uefisecapp.c | 871 +++++++++++++++++++++
 drivers/firmware/qcom_scm.c                | 394 ++++++++++
 include/linux/firmware/qcom/qcom_qseecom.h |  46 ++
 include/linux/firmware/qcom/qcom_scm.h     |  22 +
 include/linux/ucs2_string.h                |   1 +
 lib/ucs2_string.c                          |  52 ++
 10 files changed, 1552 insertions(+)
 create mode 100644 drivers/firmware/qcom_qseecom.c
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c
 create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h

-- 
2.42.0

