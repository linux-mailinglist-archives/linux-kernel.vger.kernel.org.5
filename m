Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82233800E35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379341AbjLAPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379339AbjLAPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:14:23 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBAD10DF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 07:14:29 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cb749044a2so2234396b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701443668; x=1702048468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUXpiI1HIHar4nszgC34tqcGQO72u7/9KK72eoUn/m0=;
        b=ucYHW4TfsNmzie2dOI98fMpUY5GzQqni0265D7x0vJ/ah3L2o2DRIsovbI+pnN4430
         lwawxmHCFsFeWF2svDRtB08iyQSF+UBvaB7e9zFn8GDKB2cWW20pdsCbFBee9OwvGO6t
         Jgz4vuluOQGuF5ajl037IPK4I0gvCAzbs5p7Awuavix56YQU97R7SHpOWh26p/hF1D95
         U1JD2Jz2f8HzwdkDxJY+FmTCWyhh1dr5qdSUZ+avrbhHtWbejr8e7qYYhnnnsOGd79S2
         2s40GEGK2H4I5XP24pDX6a3btZaZHXTa7MOPQk9wW/oTzNie60FLe8+iOG0cwmPW7/Jv
         2m5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443668; x=1702048468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AUXpiI1HIHar4nszgC34tqcGQO72u7/9KK72eoUn/m0=;
        b=aQLoS1z4p9Ux97Lmc64LIJIT3fCAQR4X/UywmVNSTFSdfKoL2Cv03VYjIO+jrwfKTY
         qxkBSjZc/Sx7GRt6/HWV4rdU+05rlEHA9O6+Z1fmPDux/n0l6jE7I2GP7TLUtrZslVMk
         /NgtPqqIrB3oNG4SoSPcNCYvynGz5GtLweNKvxXUxs1ISfTqvvDGd5rb00SkzObv3fgS
         a3sx6PSysXRFGA+r2+ozZjocYwvcfXSy+mRcGMVuBCm74+FDr9OPfbkptaduS2pHAPYB
         QUSnkzNR7Hn5xpKdpo7grkqgCbJrSVdnSe1Pm+NffIqrBfzYoslCbwx1SyHyvbtbXQnV
         d2Iw==
X-Gm-Message-State: AOJu0YyuUwhncXexHRPPV7OtLS1ccee+z/qjZHDYmbWzCauFrzLz36xy
        7ccMop+WjzTTe5zKHwFEmv4JpfmyL6EVkoI5tQ==
X-Google-Smtp-Source: AGHT+IEnHLXEm9et6sxxnwHKFL/XwVuOliwUqpAfFgSFw3DXH7guGuMqTVOIRUyPv5TBQwBgPxgkSA==
X-Received: by 2002:a05:6a20:d704:b0:181:44c:d6a with SMTP id iz4-20020a056a20d70400b00181044c0d6amr36642382pzb.21.1701443668367;
        Fri, 01 Dec 2023 07:14:28 -0800 (PST)
Received: from localhost.localdomain ([117.213.98.226])
        by smtp.gmail.com with ESMTPSA id s14-20020a65644e000000b00578afd8e012sm2765824pgv.92.2023.12.01.07.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:14:27 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/13] scsi: ufs: qcom: Minor code cleanups
Date:   Fri,  1 Dec 2023 20:44:04 +0530
Message-Id: <20231201151417.65500-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series has some minor code cleanups to the Qcom UFS driver. No functional
change.

Tested on: RB5 development board based on Qcom SM8250 SoC.

- Mani

Manivannan Sadhasivam (13):
  scsi: ufs: qcom: Use clk_bulk APIs for managing lane clocks
  scsi: ufs: qcom: Fix the return value of ufs_qcom_ice_program_key()
  scsi: ufs: qcom: Fix the return value when
    platform_get_resource_byname() fails
  scsi: ufs: qcom: Remove superfluous variable assignments
  scsi: ufs: qcom: Remove the warning message when core_reset is not
    available
  scsi: ufs: qcom: Export ufshcd_{enable/disable}_irq helpers and make
    use of them
  scsi: ufs: qcom: Fail ufs_qcom_power_up_sequence() when core_reset
    fails
  scsi: ufs: qcom: Check the return value of
    ufs_qcom_power_up_sequence()
  scsi: ufs: qcom: Remove redundant error print for devm_kzalloc()
    failure
  scsi: ufs: qcom: Use dev_err_probe() to simplify error handling of
    devm_gpiod_get_optional()
  scsi: ufs: qcom: Remove unused ufs_qcom_hosts struct array
  scsi: ufs: qcom: Sort includes alphabetically
  scsi: ufs: qcom: Initialize cycles_in_1us variable in
    ufs_qcom_set_core_clk_ctrl()

 drivers/ufs/core/ufshcd.c   |   6 +-
 drivers/ufs/host/ufs-qcom.c | 165 ++++++++----------------------------
 drivers/ufs/host/ufs-qcom.h |   6 +-
 include/ufs/ufshcd.h        |   2 +
 4 files changed, 43 insertions(+), 136 deletions(-)

-- 
2.25.1

