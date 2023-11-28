Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151CC7FC641
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344703AbjK1Utk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1Utj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:49:39 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058271988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:42 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77dbdc184fdso16914685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1701204581; x=1701809381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsBQ1c03W+bPyqjQatoY3AtDcRPwnaylyTF2JWK/6Qg=;
        b=alMS/GLIxw3ls2/A/aDYm19ouFrvpua3I3pNdCaGjL5qbpXTbOaISDHTzVEPc6fLe7
         meXRIE1FuyxGSA/zEeg+Jez6cowKKFRllQ4oicINWr9Gtn5uMwhVduMnxw67Njlhktgp
         vUKyJhK9plRHYks0eU2zL2AYgJAqYLd11S6SrXKzQi2XefE6n2IkloDI6dH5wRyLHqZK
         uDT+kE5Nuz5RIrQlyn30kWx4hHd/a03pa8oQL+Gewfcb0V6Obd6TR4PAT7knPv4OlZc6
         ONLo/T0kLcebPBROohbBZA1qrMfO+o2Fkmtp58m9Z585Uft2HzIGDB59sWzmQEvbLGaJ
         0rvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701204581; x=1701809381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FsBQ1c03W+bPyqjQatoY3AtDcRPwnaylyTF2JWK/6Qg=;
        b=hEERXyts8mYWZy2SEPWxTVZFNXCHuKxtoL1Ea0wYLXx/WWpI2RzC7GYGuaPsx+utJd
         N/2qpCo0xNrF2fiB5sF/H5kMYj5R0Qul2PwgS4xof2i2wJG1uK9MyEKREfBhON060uem
         6Qlwi6GF/2qeBNR4uIlpC+8nlHlLKjqtQRM1EpWn7yE3AM4Ud4nnEZWxw3GzWGlI2xJX
         yuV/f9+YxIUdA+B+18s+vw3pdCKgjnS63OYN/s55Yi2Oq8N6TRNqLgPklSylFI+m2e6z
         7aC+c/ON17Vd9S7Dc8aw73qJTJO9Ec49JBgLfc45qdk00IkZOdf4IpQnS0e3IQ5oPv2F
         TFRw==
X-Gm-Message-State: AOJu0YwvQUaplcQFyggcdup0n2//SWTsOQiA5q1h7nFCkCyknOO1pEaW
        iyAs6n2tpXn/uDPeA0d085/MiQ==
X-Google-Smtp-Source: AGHT+IEGKj81OhPPfZGrAMOrKOsHXDo+wy0whZdL8ikR2KmUyXglOYylmfrRjMDC83oWuy4vndr7lg==
X-Received: by 2002:a05:620a:1452:b0:77d:c593:f63c with SMTP id i18-20020a05620a145200b0077dc593f63cmr2543824qkl.24.1701204581121;
        Tue, 28 Nov 2023 12:49:41 -0800 (PST)
Received: from soleen.c.googlers.com.com (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id d11-20020a0cfe8b000000b0067a56b6adfesm1056863qvs.71.2023.11.28.12.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:49:40 -0800 (PST)
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
To:     akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jgg@ziepe.ca, jonathanh@nvidia.com,
        joro@8bytes.org, kevin.tian@intel.com,
        krzysztof.kozlowski@linaro.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        pasha.tatashin@soleen.com, paulmck@kernel.org,
        rdunlap@infradead.org, robin.murphy@arm.com, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, sven@svenpeter.dev,
        thierry.reding@gmail.com, tj@kernel.org, tomas.mudrunka@gmail.com,
        vdumpa@nvidia.com, virtualization@lists.linux.dev, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Subject: [PATCH 00/16] IOMMU memory observability
Date:   Tue, 28 Nov 2023 20:49:22 +0000
Message-ID: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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

From: Pasha Tatashin <tatashin@google.com>

IOMMU subsystem may contain state that is in gigabytes. Majority of that
state is iommu page tables. Yet, there is currently, no way to observe
how much memory is actually used by the iommu subsystem.

This patch series solves this problem by adding both observability to
all pages that are allocated by IOMMU, and also accountability, so
admins can limit the amount if via cgroups.

The system-wide observability is using /proc/meminfo:
SecPageTables:    438176 kB

Contains IOMMU and KVM memory.

Per-node observability:
/sys/devices/system/node/nodeN/meminfo
Node N SecPageTables:    422204 kB

Contains IOMMU and KVM memory memory in the given NUMA node.

Per-node IOMMU only observability:
/sys/devices/system/node/nodeN/vmstat
nr_iommu_pages 105555

Contains number of pages IOMMU allocated in the given node.

Accountability: using sec_pagetables cgroup-v2 memory.stat entry.

With the change, iova_stress[1] stops as limit is reached:

# ./iova_stress
iova space:     0T      free memory:   497G
iova space:     1T      free memory:   495G
iova space:     2T      free memory:   493G
iova space:     3T      free memory:   491G

stops as limit is reached.

This series encorporates suggestions that came from the discussion
at LPC [2].

[1] https://github.com/soleen/iova_stress
[2] https://lpc.events/event/17/contributions/1466

Pasha Tatashin (16):
  iommu/vt-d: add wrapper functions for page allocations
  iommu/amd: use page allocation function provided by iommu-pages.h
  iommu/io-pgtable-arm: use page allocation function provided by
    iommu-pages.h
  iommu/io-pgtable-dart: use page allocation function provided by
    iommu-pages.h
  iommu/io-pgtable-arm-v7s: use page allocation function provided by
    iommu-pages.h
  iommu/dma: use page allocation function provided by iommu-pages.h
  iommu/exynos: use page allocation function provided by iommu-pages.h
  iommu/fsl: use page allocation function provided by iommu-pages.h
  iommu/iommufd: use page allocation function provided by iommu-pages.h
  iommu/rockchip: use page allocation function provided by iommu-pages.h
  iommu/sun50i: use page allocation function provided by iommu-pages.h
  iommu/tegra-smmu: use page allocation function provided by
    iommu-pages.h
  iommu: observability of the IOMMU allocations
  iommu: account IOMMU allocated memory
  vhost-vdpa: account iommu allocations
  vfio: account iommu allocations

 Documentation/admin-guide/cgroup-v2.rst |   2 +-
 Documentation/filesystems/proc.rst      |   4 +-
 drivers/iommu/amd/amd_iommu.h           |   8 -
 drivers/iommu/amd/init.c                |  91 +++++-----
 drivers/iommu/amd/io_pgtable.c          |  13 +-
 drivers/iommu/amd/io_pgtable_v2.c       |  20 +-
 drivers/iommu/amd/iommu.c               |  13 +-
 drivers/iommu/dma-iommu.c               |   8 +-
 drivers/iommu/exynos-iommu.c            |  14 +-
 drivers/iommu/fsl_pamu.c                |   5 +-
 drivers/iommu/intel/dmar.c              |  10 +-
 drivers/iommu/intel/iommu.c             |  47 ++---
 drivers/iommu/intel/iommu.h             |   2 -
 drivers/iommu/intel/irq_remapping.c     |  10 +-
 drivers/iommu/intel/pasid.c             |  12 +-
 drivers/iommu/intel/svm.c               |   7 +-
 drivers/iommu/io-pgtable-arm-v7s.c      |   9 +-
 drivers/iommu/io-pgtable-arm.c          |   7 +-
 drivers/iommu/io-pgtable-dart.c         |  37 ++--
 drivers/iommu/iommu-pages.h             | 231 ++++++++++++++++++++++++
 drivers/iommu/iommufd/iova_bitmap.c     |   6 +-
 drivers/iommu/rockchip-iommu.c          |  14 +-
 drivers/iommu/sun50i-iommu.c            |   7 +-
 drivers/iommu/tegra-smmu.c              |  18 +-
 drivers/vfio/vfio_iommu_type1.c         |   8 +-
 drivers/vhost/vdpa.c                    |   3 +-
 include/linux/mmzone.h                  |   5 +-
 mm/vmstat.c                             |   3 +
 28 files changed, 415 insertions(+), 199 deletions(-)
 create mode 100644 drivers/iommu/iommu-pages.h

-- 
2.43.0.rc2.451.g8631bc7472-goog

