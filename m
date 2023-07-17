Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE267755C23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGQGzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjGQGzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:55:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58376E46
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:55:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-666eef03ebdso2621671b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689576908; x=1692168908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxDj0cr6PXkiRwnNoe82O3oD/hcUvA7dm6frlOMs3zE=;
        b=mpQsO+nWOYeY1Qwk7wnek4NxieRekIpcFy4mrVnTsOVzB7X6Cn3XuJjkEtMfigZb1M
         btMPEuwT+tDgJc/spo+tAUV3wrUIxUDnQjUga8N1bAoN0WTMEMbQs+Oy+E7iA958JP3J
         uRuACVrcFNa2t5wBmKEZiX391yEtGFM3oWfqNPB1++a0/kG63D0a9Ldl8I3dN3z3ZEt5
         dch29l7i44tKfS5lraHIBqaXpZIHpDoI96zQhVt87plNHF4FDDRGGG0+xHNm8zhEJ5k4
         1aWPkeK1EkPxNgef0y3jpWThbIxMo96Z+3CNlj81//16qZAxRHppt7XLxWzmDsAkGloG
         pQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576908; x=1692168908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxDj0cr6PXkiRwnNoe82O3oD/hcUvA7dm6frlOMs3zE=;
        b=mGp9iifrNI7gGSXhplaDRt37jzZl57ge5XBuzJgf0iLM0awO3ARVUgQbVZcsXRuZOt
         aihC80V43L9FSHlQl5MZjp/j4xcagrhtqKkqDP6jMJben5DC8GR20a+EeVQb4x2StDzE
         qTpmLd7pvZTltKxKg80wQyyHNJt6wuSVwzVws+Rt2OOzWUH/WIgu2HYTFilTbIzTf2Ga
         fbLx6BfWHcVlC7n7cZOGWd7EWwI4MHVDtyFLBoDfLcU0k49UlbEcL9zSOVPnXuIT7eIC
         MYE8aRVzysoJD0nQg91juREcbehSKh4BD32M6xd36A8V0GIAt36jeHPgWVR5TObS+qR9
         /YiQ==
X-Gm-Message-State: ABy/qLaHqs29X8cLVnqAc56xncBaEMkyL4/dVhUjYZnev1QecJkbLfMn
        HAzHG0Yl9P4wqHbRRjTpfIpS
X-Google-Smtp-Source: APBJJlFPuHY8ear94TdRwC1bkMd6oiUULZrC/Rb0WVzdEKLvyIuycaJT9ok4CdCKiKP1dBr8DFXsVw==
X-Received: by 2002:a05:6a00:198a:b0:67e:4313:811e with SMTP id d10-20020a056a00198a00b0067e4313811emr12393345pfl.0.1689576907742;
        Sun, 16 Jul 2023 23:55:07 -0700 (PDT)
Received: from localhost.localdomain ([117.193.215.209])
        by smtp.gmail.com with ESMTPSA id x7-20020a62fb07000000b006675c242548sm11196422pfm.182.2023.07.16.23.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 23:55:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, kw@linux.com
Cc:     kishon@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/7] Improvements to Qcom PCIe EP and EPF MHI drivers
Date:   Mon, 17 Jul 2023 12:24:52 +0530
Message-Id: <20230717065459.14138-1-manivannan.sadhasivam@linaro.org>
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

Hi,

This series adds eDMA (embedded DMA) support to the Qcom PCIe EP and EPF 
MHI drivers for offloading the transfers between PCIe bus and the EP
memory. eDMA support makes use of the recently merged eDMA DMAEngine driver
and its integration with DWC PCIe EP core [1].

This series also adds Qcom SM8450 SoC support to EPF MHI driver that has
the eDMA support built-in.

- Mani

[1] https://lore.kernel.org/all/20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru/

Changes in v2:

* Rebased on top of v6.5-rc1

Manivannan Sadhasivam (7):
  PCI: qcom-ep: Pass alignment restriction to the EPF core
  PCI: epf-mhi: Make use of the alignment restriction from EPF core
  PCI: qcom-ep: Add eDMA support
  PCI: epf-mhi: Add eDMA support
  PCI: epf-mhi: Add support for SM8450
  PCI: epf-mhi: Use iATU for small transfers
  PCI: endpoint: Add kernel-doc for pci_epc_mem_init() API

 drivers/pci/controller/dwc/pcie-qcom-ep.c    |   5 +-
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 280 ++++++++++++++++++-
 drivers/pci/endpoint/pci-epc-mem.c           |  10 +
 3 files changed, 281 insertions(+), 14 deletions(-)

-- 
2.25.1

