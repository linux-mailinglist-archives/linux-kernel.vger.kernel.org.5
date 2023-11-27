Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218887F9FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjK0Mpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjK0Mpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:45:38 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5D010F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:45:44 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77d84f8808dso139748885a.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089143; x=1701693943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=My7gSFRp+Y7hoOV+FBK21Q8iK89AnBNbYhuMMj6/9YA=;
        b=nq8c2ZQ2iSF2Iu1oeCXn1TmpOK9wA//99CcvtoPaue8jEu34xZewQr/FOqKtlyXOvM
         LFPOti7AhKNQbW6rCNst3etX9twZ2x+FOzOM9qDoduhn6Dkdd3mIV2nlqz3wu1xGEB0q
         F7eGUEg+oJPYkKqEm0P/TVpu7AG8ZuevnFpaiv4WrpJxoWg5wfBP+1BiNf3Cfp3ByBJb
         Qamtj5LlliWbprW14a7hPYCygiBUZhm7i+tJYIBlJ6I+MiVT8/VwgkOy2ljK4E6xdlC8
         CBO+apEVSIgkTU950iQceu39ruj3WgPKsn/2pMy1ieivBPxm/ByxjeRBgjXpHan4un72
         ABPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089143; x=1701693943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=My7gSFRp+Y7hoOV+FBK21Q8iK89AnBNbYhuMMj6/9YA=;
        b=C+4GN7UC0KDdVqFSH3vu1QOUFUsP0b7rIXmhqw3gYfZhaIzW/T3R7NhsGAMkbABr3B
         N+0QdZkoWNIM90Gdn8B2PZHW1STVQXoVtckIsbfk4TghKnotn3uREFprO/O1zKFJh62w
         dOBBWvXd8Yhb7lZFq3tY9NrxpEIJo0qtQYweIvlP1vMFyg3A4AOyzbfq24c0SQqjwITt
         VZ+yAUTUJ0XIzA/3ozJMem4/Dk9eqzXkMAIcpxyG5ILREc3CqYK4dVu6qQ8xsxeOrl0S
         VdFWJ5AWCTi+UlBVA1JiZ2ZjUpPhXx3PiDGnfsD8coYgfc0J6HFGb/Q5W1tGFw+pa+jj
         cX4g==
X-Gm-Message-State: AOJu0YzNWwmyoJPstdAUO8SYKrFTDzyK/v9MrbTHImf6vwhSOYK4897q
        svbPwu6iWp7qziclmSaTER++
X-Google-Smtp-Source: AGHT+IHxlyPEMgiSFO7SQKkp2Y9pFf7htAgqwPBMkxZfJRWlUXhmb2oNI5Vr/2R6YVNt+HXPnHuOGQ==
X-Received: by 2002:ad4:4986:0:b0:66d:5d31:999e with SMTP id u6-20020ad44986000000b0066d5d31999emr12774208qvx.43.1701089143185;
        Mon, 27 Nov 2023 04:45:43 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:45:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/9] bus: mhi: ep: Add async read/write support
Date:   Mon, 27 Nov 2023 18:15:20 +0530
Message-Id: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series add async read/write support for the MHI endpoint stack by
modifying the MHI ep stack and the MHI EPF (controller) driver.

Currently, only sync read/write operations are supported by the stack,
this resulting in poor data throughput as the transfer is halted until
receiving the DMA completion. So this series adds async support such
that the MHI transfers can continue without waiting for the transfer
completion. And once the completion happens, host is notified by sending
the transfer completion event.

This series brings iperf throughput of ~4Gbps on SM8450 based dev platform,
where previously 1.6Gbps was achieved with sync operation.

- Mani

Manivannan Sadhasivam (9):
  bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs
  bus: mhi: ep: Rename read_from_host() and write_to_host() APIs
  bus: mhi: ep: Introduce async read/write callbacks
  PCI: epf-mhi: Simulate async read/write using iATU
  PCI: epf-mhi: Add support for DMA async read/write operation
  PCI: epf-mhi: Enable MHI async read/write support
  bus: mhi: ep: Add support for async DMA write operation
  bus: mhi: ep: Add support for async DMA read operation
  bus: mhi: ep: Add checks for read/write callbacks while registering
    controllers

 drivers/bus/mhi/ep/internal.h                |   1 +
 drivers/bus/mhi/ep/main.c                    | 256 +++++++++------
 drivers/bus/mhi/ep/ring.c                    |  41 +--
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 314 ++++++++++++++++---
 include/linux/mhi_ep.h                       |  33 +-
 5 files changed, 485 insertions(+), 160 deletions(-)

-- 
2.25.1

