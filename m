Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6B5768662
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjG3QTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG3QTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:19:16 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DB6E7A;
        Sun, 30 Jul 2023 09:19:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99357737980so599355766b.2;
        Sun, 30 Jul 2023 09:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690733954; x=1691338754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a9yciUwcqPp7vxkA0tX3c4DgVq60cq74Tw4ZK4zb2CE=;
        b=oKc+Okt5cyxQRykiFRQ0w28E6t3uBK7LtEnm2NH5WPLBITVmG4eDgGGFQzoHZ/wVAv
         tVJB3GTOCmbpLzfRWdFQqjHH8lRPEpXpbRgC7z0aW4SkB7vTO5Zm0vyOqY3zfKg7z5l6
         c2qlzQLSI+UxMdv9C8VIhrsfYEHdF5OuokiDmFNYiIxy3ubJFd3gojpOp40NICdpKjn3
         Ft6SLCGXqMHo2eqi+4Ou6vr9oNKihAShHj8ZCMyhRiBkx6J7Ssx3xD4DdKD6MEoLgoI6
         jdxOyvHsiz39h//xGJil7RkacecYILtNyYWwywD5rxAAWB/K3sV/Kab7xSytC4isRpJl
         bWwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690733954; x=1691338754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9yciUwcqPp7vxkA0tX3c4DgVq60cq74Tw4ZK4zb2CE=;
        b=Uxx6lHkGtu5mOSVl3ev62EW1Z/gv7fQrInNPc5fZH/UsyOHSyXbsW5LOq/9tRJaj0M
         Gd6iWv3fb07tGespbtSX3sL7YQgPGo5sDwHi7bwJnKKwUOH2HXS16ikgvKPbShugWIx8
         mD7KSQTUaJvzRYVcquTV65YIuwb8Dku26d71gBxjHNPHmudC5sLJhyA5RUBX7UDIbQRR
         PmkZO14+Ty8ojalokvnk4J6qngR40Lqso6e98jtvStfK1WkyAm7W/2WHTsNR5NCFLrNx
         N/Vs9DcBNyYK3ce9sIrMVbKrnpMSWs1QXNKbga3NPLYGDGMxRPuuBTyT/bss2yxetqFb
         nZJA==
X-Gm-Message-State: ABy/qLZ5fQTCuwFFL1e1XSQEOEeE70su1qZcIBGOY/r8DvIRAnttBezE
        hrGtOjVmTqQfKHcizfsX7GM=
X-Google-Smtp-Source: APBJJlE4hi+E54wa0hbU+O7PNuLuz1mBMNOWGw6gqGOV2kFEl/bUNHXovqOaSll7UNle+IMKNAAB1A==
X-Received: by 2002:a17:906:30c5:b0:99b:c985:cf7e with SMTP id b5-20020a17090630c500b0099bc985cf7emr5771936ejb.54.1690733953475;
        Sun, 30 Jul 2023 09:19:13 -0700 (PDT)
Received: from xws.fritz.box ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id va16-20020a17090711d000b00992aea2c55dsm4858798ejb.153.2023.07.30.09.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 09:19:12 -0700 (PDT)
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
Subject: [PATCH v5 0/3] firmware: Add support for Qualcomm UEFI Secure Application
Date:   Sun, 30 Jul 2023 18:19:01 +0200
Message-ID: <20230730161906.606163-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

 - V4: https://lore.kernel.org/lkml/72c0359a-eda6-30ea-0ec0-b7e9b804b87b@gmail.com/t/
 - V3: https://lore.kernel.org/lkml/20230305022119.1331495-4-luzmaximilian@gmail.com/t/
 - V2: https://lore.kernel.org/lkml/20230127184650.756795-1-luzmaximilian@gmail.com/
 - V1: https://lore.kernel.org/lkml/20220723224949.1089973-1-luzmaximilian@gmail.com/

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
 drivers/firmware/Kconfig                   |  33 +
 drivers/firmware/Makefile                  |   2 +
 drivers/firmware/qcom_qseecom.c            | 130 +++
 drivers/firmware/qcom_qseecom_uefisecapp.c | 869 +++++++++++++++++++++
 drivers/firmware/qcom_scm.c                | 392 ++++++++++
 include/linux/firmware/qcom/qcom_qseecom.h |  46 ++
 include/linux/firmware/qcom/qcom_scm.h     |  21 +
 include/linux/ucs2_string.h                |   1 +
 lib/ucs2_string.c                          |  35 +
 10 files changed, 1541 insertions(+)
 create mode 100644 drivers/firmware/qcom_qseecom.c
 create mode 100644 drivers/firmware/qcom_qseecom_uefisecapp.c
 create mode 100644 include/linux/firmware/qcom/qcom_qseecom.h

-- 
2.41.0

