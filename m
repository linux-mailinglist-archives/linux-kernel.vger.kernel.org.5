Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FD37B1FA0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjI1OeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjI1OeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:34:10 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF80CDA;
        Thu, 28 Sep 2023 07:34:05 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEGpgm023352;
        Thu, 28 Sep 2023 14:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : subject : date :
 message-id : content-type : to : cc : content-transfer-encoding :
 mime-version; s=pp1; bh=+AelF5EobKHqnSr8zhepxLBd8WeHZTYUkZ4i4D+QY1o=;
 b=kxBoyzMI+i9QbAURxp04TY1v51iWVEEc93pEKyUtZmeX3h4lCupu8qQ7DeOnhf3iT99S
 WDG2Yf6xruPiOFMGLSeKXTzom5SS43Kpma9qZIWFa8RXWgh9w4j9ZTSJV15kSKfMIW0X
 5w60HtLcABxnf3fr34TkRSfAhXhh8QTo1XagbYUfRgFNJ9UcAbJPyyRrL4QMK/0BBcGN
 J3L/zBOS3pYQYD35uiwtDppffgBOuVPQ2BQiQrLE7UBYX18Un5q9COSFplpQfxe7Wu9u
 Qmq8GRIcPY7k+EpvVCK3rqadjJLhc4HWRc9eYpnfmLIpZoY/cKQ3LX281BIhn6jGrjPA cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td9we2u4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:33:10 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SEHCuW024068;
        Thu, 28 Sep 2023 14:32:57 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td9we2tg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:32:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SCoA2J008464;
        Thu, 28 Sep 2023 14:32:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabt5fj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:32:35 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SEWW6645810006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:32:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 446A120043;
        Thu, 28 Sep 2023 14:32:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 549E820040;
        Thu, 28 Sep 2023 14:32:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 14:32:31 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH v13 0/6] iommu/dma: s390 DMA API conversion and optimized
 IOTLB flushing
Date:   Thu, 28 Sep 2023 16:31:34 +0200
Message-Id: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
X-B4-Tracking: v=1; b=H4sIAEaOFWUC/3XQS2rDMBAG4KsEryujZyR31XuUUvQY1QJLLnJsU
 oLv3nE2JsHRbkb6Zn50ayaoCabm/XRrKixpSmPBgom3U+N7W36ApICNhlMuqGCUhGy/05jzTBR
 QabwS5ix1g++dnYC4aovvUZR5GLD5WyGm633D5xfWsY6ZXPoKdh/LOWWK42mZYUZISRiZfF9gG
 OBjSGW+tsnl1o95W9On6TLWv3vkxWxzj8IthlDChdQhOgjaxqdBW5ale6k71GflnIEQuAN3pBl
 9ybGiJLLogsEbo+ShZ7vXTD94ht5qS50RXijlDz3fveHqwXP0kuFXKtV10upnv67rP1exi9L8A
 QAA
To:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7652;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=7rAyl/igFDFap60SA/wflrborrZguzM/XaJiNUpgzNU=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJF+zy9peevV/h5amtX6X+1qIkLj7P25jAX/yw1Yebqi
 zV3fsPeUcrCIMbBICumyLKoy9lvXcEU0z1B/R0wc1iZQIYwcHEKwESWnmT4X/74Xbi0QNHHeQ7f
 VdYqxlbL/jMwjxc5ecKrNP9kkH3cCYa/4s5rGU9fZmfd/diP4edcNT6tc0UNi2MOuYjdYvoW2xL
 HCAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9rSMrLf11VgDIp-qxrzVelAu3ZsETmgE
X-Proofpoint-ORIG-GUID: Ib-sQeZOpRA54CuzRakeuvLJsOTMZfeC
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This patch series converts s390's PCI support from its platform specific DMA
API implementation in arch/s390/pci/pci_dma.c to the common DMA IOMMU layer.
The conversion itself is done in patches 3-4 with patch 2 providing the final
necessary IOMMU driver improvement to handle s390's special IOTLB flush
out-of-resource indication in virtualized environments. The conversion
itself only touches the s390 IOMMU driver and s390 arch code moving over
remaining functions from the s390 DMA API implementation. No changes to
common code are necessary.

After patch 4 the basic conversion is done and on our partitioning
machine hypervisor LPAR performance matches the previous implementation.
When running under z/VM or KVM however, performance plummets to about
half of the existing code due to a much higher rate of IOTLB flushes for
unmapped pages. Due to the hypervisors use of IOTLB flushes to
synchronize their shadow tables these are very expensive and minimizing
them is key for regaining the performance loss.

To this end patches 5-6 add a new, single queue, IOTLB flushing scheme
as an alternative to the existing per-CPU flush queues. Introducing an
alternative scheme was suggested by Robin Murphy[1]. The single queue
mode is introduced in patch 4 together with a new .shadow_on_flush flag
bit in struct dev_iommu. This allows IOMMU drivers to indicate that
their IOTLB flushes do the extra work of shadowing. This then lets the
dma-iommu code use a single queue.

Then patch 6 enables variable queue sizes using power of 2 values and
shift/mask to keep performance as close to the fixed size queue code as
possible. A larger queue size and timeout is used by dma-iommu when
shadow_on_flush is set. This same scheme may also be used by other IOMMU
drivers with similar requirements. Particularly virtio-iommu may be
a candidate.

I tested this code on s390x with LPAR, z/VM and KVM hypervisors on an
AMD Ryzen x86 system with native IOMMU and a guest with a modified
virtio-iommu[4] that set .shadow_on_flush = true.

This code is also available in the b4/dma_iommu topic branch of my
git.kernel.org repository[3] with tags matching the version sent.

NOTE: Due to the large drop in performance I think we should not merge
the DMA API conversion (patch 4) until we have a more suited IOVA
flushing scheme with similar improvements as the proposed changes.

NOTE: With the DMA API converted mlx5_core is broken on s390x since commit
06cd555f73ca ("net/mlx5: split mlx5_cmd_init() to probe and reload
routines"). A fix for the breakage has been proposed[5].

Best regards,
Niklas

[0] https://lore.kernel.org/linux-iommu/20221109142903.4080275-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde006257b6f@arm.com/
[2] https://lore.kernel.org/linux-iommu/a8e778da-7b41-a6ba-83c3-c366a426c3da@arm.com/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/niks/linux.git/
[4] https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
[5] https://lore.kernel.org/netdev/20230928-mlx5_init_fix-v1-1-79749d45ce60@linux.ibm.com/

---
Changes in v13:
- Rebase on iommu/core which requires removing the platform domain
  handling with.
- Moved setting iommu_dma_forcedac = true to s390_iommu_init() so it
  happens before the call to iommu_dma_set_pci_32bit_workaround()
- Link to v12: https://lore.kernel.org/r/20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com

Changes in v12:
- Rebased on v6.5-rc7
- Changed queue type flag to an enum
- Incorporated feedback from Robin Murphy
  - Set options centrally and only once in iommu_dma_init_domain() with
    new helper iommu_dma_init_options()
  - Do not reset options of failing to init FQ
  - Fixed rebase mishap that partially rolled back patch 2
  - Simplified patch 4 by simply no claiming the deferred flush
    capability for ISM
  - Inlined and removed fq_flush_percpu()
  - Changed vzalloc() to vmalloc() for queue
- Added Acked-by's from Robin Murphy
- Link to v11: https://lore.kernel.org/r/20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com

Changes in v11:
- Rebased on v6.5-rc2
- Added patch to force IOMMU_DOMAIN_DMA on s390 specific ISM devices
- Dropped the patch to properly set DMA mask on ISM devices which went upstream separately.
- s390 IOMMU driver now uses IOMMU_CAP_DEFERRED_FLUSH to enable DMA-FQ
  leaving no uses of IOMMU_DOMAIN_DMA_FQ in the driver.
- Link to v10: https://lore.kernel.org/r/20230310-dma_iommu-v10-0-f1fbd8310854@linux.ibm.com

Changes in v10:
- Rebased on v6.4-rc3
- Removed the .tune_dma_iommu() op in favor of a .shadow_on_flush flag
  in struct dev_iommu which then let's the dma-iommu choose a single
  queue and larger timeouts and IOVA counts. This leaves the dma-iommu
  with full responsibility for the settings.
- The above change affects patches 5 and 6 and lead to a new subject for
  patch 6 since the flush queue size and timeout is no longer driver
  controlled
- Link to v9: https://lore.kernel.org/r/20230310-dma_iommu-v9-0-65bb8edd2beb@linux.ibm.com

Changes in v9:
- Rebased on v6.4-rc2
- Re-ordered iommu_group_store_type() to allow passing the device to
  iommu_dma_init_fq()
- Link to v8: https://lore.kernel.org/r/20230310-dma_iommu-v8-0-2347dfbed7af@linux.ibm.com

---
Niklas Schnelle (6):
      iommu: Allow .iotlb_sync_map to fail and handle s390's -ENOMEM return
      s390/pci: prepare is_passed_through() for dma-iommu
      s390/pci: Use dma-iommu layer
      iommu/s390: Disable deferred flush for ISM devices
      iommu/dma: Allow a single FQ in addition to per-CPU FQs
      iommu/dma: Use a large flush queue and timeout for shadow_on_flush

 Documentation/admin-guide/kernel-parameters.txt |   9 +-
 arch/s390/include/asm/pci.h                     |   7 -
 arch/s390/include/asm/pci_clp.h                 |   3 +
 arch/s390/include/asm/pci_dma.h                 | 119 +---
 arch/s390/pci/Makefile                          |   2 +-
 arch/s390/pci/pci.c                             |  22 +-
 arch/s390/pci/pci_bus.c                         |   5 -
 arch/s390/pci/pci_debug.c                       |  12 +-
 arch/s390/pci/pci_dma.c                         | 735 ------------------------
 arch/s390/pci/pci_event.c                       |  17 +-
 arch/s390/pci/pci_sysfs.c                       |  19 +-
 drivers/iommu/Kconfig                           |   4 +-
 drivers/iommu/amd/iommu.c                       |   5 +-
 drivers/iommu/apple-dart.c                      |   5 +-
 drivers/iommu/dma-iommu.c                       | 200 +++++--
 drivers/iommu/intel/iommu.c                     |   5 +-
 drivers/iommu/iommu.c                           |  20 +-
 drivers/iommu/msm_iommu.c                       |   5 +-
 drivers/iommu/mtk_iommu.c                       |   5 +-
 drivers/iommu/s390-iommu.c                      | 434 ++++++++++++--
 drivers/iommu/sprd-iommu.c                      |   5 +-
 drivers/iommu/sun50i-iommu.c                    |   6 +-
 include/linux/iommu.h                           |   6 +-
 23 files changed, 634 insertions(+), 1016 deletions(-)
---
base-commit: ccb76c5751634541bfd2222374f46e1dea83d525
change-id: 20230310-dma_iommu-5e048c538647

Best regards,
-- 
Niklas Schnelle
Linux on Z Development

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Gregor Pillen
Geschäftsführung: David Faller
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement - https://www.ibm.com/privacy 

