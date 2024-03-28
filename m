Return-Path: <linux-kernel+bounces-123669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DB2890C6A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CFD1C281C0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352E013B7AE;
	Thu, 28 Mar 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aaJ3ODN8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372713B596;
	Thu, 28 Mar 2024 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660672; cv=none; b=D2wUSOLer22E1XwIbbE/WHA86EywoPVGdvTSsccZ+4qRQBRLvVDLD7n+yW/RG9briGRN0r3NMPyC8z0yuOpFfCnbhQTt0UtkXgFMxkHQ2XF/KAA3OrY27BAix/qrZc3b8YKQv5eGF8rTa4Dfxqj7YTx0zcyugc1Y2NstI9aIcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660672; c=relaxed/simple;
	bh=j0JGGPFhy/onZUZbbAhS1IVqM5lPLVs9j9gED/C9V1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CVhPO10svPqQFpK51Rb6RQ+/L4Sho85bGCj+O6Oep4DILqvNW8kvxiV8afbzEdSFBz65GOba9we0PpFEgE5v/PFs49l5BcNGqJya85TIuVUseKVOvkCYA3umigwdYnuYOQKA4coFJrxvmaqIYkmVIiCTci2dmUgIRjt8tp0Hr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aaJ3ODN8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SKgQPB024748;
	Thu, 28 Mar 2024 21:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=D8O5+mH
	IUcg/G6ki6b37Wx2+aNdV3Y2NASjj7xE/r8Y=; b=aaJ3ODN87+28iow01lBjOwG
	hOJrrM66I+BtPGs3P2jv0yvSKX4XRvD53k3hInkFDgDkd/yQhv4zyNLgfDl+psuX
	HYVCTj4iZ7Uf+OcXqrKGFoGymGFoyC4z3DDCv5QcUv1eUtLXNKIANSPduMS9Wnos
	c64TEVTK3NYO4BY+OaYcxyowCmmZQLfps7QNaeZv1Ut9nOIuJdGKP0QyBadKJZAI
	v+5jecUNK52zgHF2aGvKww3IBUvsBGpHZ0TTiEhf1G908DEto0bgrSxkBIvlrZ9y
	bkse1jv2q9i8p1KxaZeZncF8MwA7RyhBifpoMPz+4pNeWQXq+UjWsL1LIBOLRhA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fs8827d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SLGY8n032402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:34 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 14:16:31 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <vgupta@kernel.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <soc@kernel.org>, <guoren@kernel.org>,
        <monstr@monstr.eu>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <dinguyen@kernel.org>, <chenhuacai@kernel.org>,
        <tsbogend@alpha.franken.de>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <mpe@ellerman.id.au>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH v5 0/4] Dynamic Allocation of the reserved_mem array
Date: Thu, 28 Mar 2024 14:15:39 -0700
Message-ID: <20240328211543.191876-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dRAOY21zhi6KXxMrbJqojpnpkqq8auss
X-Proofpoint-ORIG-GUID: dRAOY21zhi6KXxMrbJqojpnpkqq8auss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280152

The reserved_mem array is used to store data for the different
reserved memory regions defined in the DT of a device.  The array
stores information such as region name, node reference, start-address,
and size of the different reserved memory regions.

The array is currently statically allocated with a size of
MAX_RESERVED_REGIONS(64). This means that any system that specifies a
number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
will not have enough space to store the information for all the regions.

This can be fixed by making the reserved_mem array a dynamically sized
array which is allocated using memblock_alloc() based on the exact
number of reserved memory regions defined in the DT.

On architectures such as arm64, memblock allocated memory is not
writable until after the page tables have been setup.
This is an issue because the current implementation initializes the
reserved memory regions and stores their information in the array before
the page tables are setup. Hence, dynamically allocating the
reserved_mem array and attempting to write information to it at this
point will fail.

Therefore, the allocation of the reserved_mem array will need to be done
after the page tables have been setup, which means that the reserved
memory regions will also need to wait until after the page tables have
been setup to be stored in the array.

When processing the reserved memory regions defined in the DT, these
regions are marked as reserved by calling memblock_reserve(base, size).
Where:  base = base address of the reserved region.
	size = the size of the reserved memory region.

Depending on if that region is defined using the "no-map" property,
memblock_mark_nomap(base, size) is also called.

The "no-map" property is used to indicate to the operating system that a
mapping of the specified region must NOT be created. This also means
that no access (including speculative accesses) is allowed on this
region of memory except when it is coming from the device driver that
this region of memory is being reserved for.[1]

Therefore, it is important to call memblock_reserve() and
memblock_mark_nomap() on all the reserved memory regions before the
system sets up the page tables so that the system does not unknowingly
include any of the no-map reserved memory regions in the memory map.

There are two ways to define how/where a reserved memory region is
placed in memory:
i) Statically-placed reserved memory regions
i.e. regions defined with a set start address and size using the
     "reg" property in the DT.
ii) Dynamically-placed reserved memory regions.
i.e. regions defined by specifying a range of addresses where they can
     be placed in memory using the "alloc_ranges" and "size" properties
     in the DT.

The dynamically-placed reserved memory regions get assigned a start
address only at runtime. And this needs to  be done before the page
tables are setup so that memblock_reserve() and memblock_mark_nomap()
can be called on the allocated region as explained above.
Since the dynamically allocated reserved_mem array can only available
after the page tables have been setup, the information for the
dynamically-placed reserved memory regions needs to be stored somewhere
temporarily until the reserved_mem array is available.

Therefore, this series makes use of a temporary static array to store
the information of the dynamically-placed reserved memory regions until
the reserved_mem array is allocated.
Once the reserved_mem array is available, the information is copied over
from the temporary array into the reserved_mem array, and the memory for
the temporary array is freed back to the system.

The information for the statically-placed reserved memory regions does
not need to be stored in a temporary array because their starting
address is already stored in the devicetree.
Hence, the only thing that needs to be done for these regions before the
page tables are setup is to call memblock_reserve() and
memblock_mark_nomap().
Once the reserved_mem array is allocated, the information for the
statically-placed reserved memory regions is added to the array.

Note:
Because of the use of a temporary array to store the information of the
dynamically-placed reserved memory regions, there still exists a
limitation of 64 for this particular kind of reserved memory regions.
From my observation, these regions are typically small in number and
hence I expect this to not be an issue for now.

Dependency:
This series is dependent on the acceptance of the below patchset for
proper behavior on the sh architecture. The patchset has already been
sent out and is pending review from the sh maintainters.
https://lore.kernel.org/all/1707524971-146908-1-git-send-email-quic_obabatun@quicinc.com/

Patch Versions:
v5 (Current Patchset):
- Rebased changes on top of v6.9-rc1.
- Addressed minor code comments from v4.

v4:
- Move fdt_init_reserved_mem() back into the unflatten_device_tree()
  function.
- Fix warnings found by Kernel test robot:
  https://lore.kernel.org/all/202401281219.iIhqs1Si-lkp@intel.com/
  https://lore.kernel.org/all/202401281304.tsu89Kcm-lkp@intel.com/
  https://lore.kernel.org/all/202401291128.e7tdNh5x-lkp@intel.com/

v3:
https://lore.kernel.org/all/20240126235425.12233-1-quic_obabatun@quicinc.com/
- Make use of __initdata to delete the temporary static array after
  dynamically allocating memory for reserved_mem array using memblock.
- Move call to fdt_init_reserved_mem() out of the
  unflatten_device_tree() function and into architecture specific setup
  code.
- Breaking up the changes for the individual architectures into separate
  patches.

v2:
https://lore.kernel.org/all/20231204041339.9902-1-quic_obabatun@quicinc.com/
- Extend changes to all other relevant architectures by moving
  fdt_init_reserved_mem() into the unflatten_device_tree() function.
- Add code to use unflatten devicetree APIs to process the reserved
  memory regions.

v1:
https://lore.kernel.org/all/20231019184825.9712-1-quic_obabatun@quicinc.com/


References:
[1]
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/reserved-memory/reserved-memory.yaml#L79

Oreoluwa Babatunde (4):
  of: reserved_mem: Restruture how the reserved memory regions are
    processed
  of: reserved_mem: Add code to dynamically allocate reserved_mem array
  of: reserved_mem: Use the unflatten_devicetree APIs to scan reserved
    mem. nodes
  of: reserved_mem: Rename fdt_* functions to refelct use of
    unflatten_devicetree APIs

 drivers/of/fdt.c                |   5 +-
 drivers/of/of_private.h         |   3 +-
 drivers/of/of_reserved_mem.c    | 249 ++++++++++++++++++++++++--------
 include/linux/of_reserved_mem.h |   2 +-
 kernel/dma/coherent.c           |   8 +-
 kernel/dma/contiguous.c         |   8 +-
 kernel/dma/swiotlb.c            |  10 +-
 7 files changed, 209 insertions(+), 76 deletions(-)

-- 
2.34.1


