Return-Path: <linux-kernel+bounces-93951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948BC873765
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA19284116
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2020131731;
	Wed,  6 Mar 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XDZSj4MI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE39130E5A;
	Wed,  6 Mar 2024 13:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730690; cv=none; b=cH/xjK+vh7af0bqpZA4kr2vEiy5kgpxWlepAVWHeQ8wcWovjO5eb8B6FlY3egPowlDcPyoNooyL2+/QbDnxyvM3cMXVEapOdS6FKxJ1NboeMEy5/vJ48IzQm5mfg1xknuR1bEB5tiPWHWPxhXZ5zOdgUX9JXTPREK5lFPe72jFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730690; c=relaxed/simple;
	bh=eRzr15zzkKLVQLaXWePd28hOMNIbG9iTc6oNCPSa59g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MP7GvXQZtAY7R+mneXh1/106nyHibKC8HDiw0Bv7Y4C3x6IDhxErnjZSuMnNSKs3USSyrOhKKETG7967caYx5jiHkirQy35bSSPIXltwI4kNMnEPFSoaUog0QrzttOK0bh+xcTFjcN0zih/PGJbjh3K2Pt9+xF5PewG0FC5Gq7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XDZSj4MI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426CPihh001569;
	Wed, 6 Mar 2024 13:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=9+sWLPYVN5M6
	BOe2ZCbASqp6MUFhVnfnocABlSvSYs0=; b=XDZSj4MI1Rj2WqV5FD+h5IWmn2LB
	ZZWAhAZrgVUJVVDC2tIGyV8ZxGBygDJUBfdNxy0IYJQ2Jj+R2dh0iNN2bOgkMFEj
	uaESYN3eZ2yn/rUVlcUOwZQ6Ursl52wyeJa1MNBMQgQUYp9dFnn//6YuKz+nmi5Z
	FIRiyL1bzD43AmdD95fz0Ner+3eNnP/8xLZ3PTEvKFZTbCRw4NYRKCgdxhZt7S8b
	HAJmJv3UsBOJFfxs+1WOfZnamPEFO9W8eOfpQ8CbK5NdxQKdsJkNz1yUjvSsaqxv
	TJDhF1hhlC+ShVUSjigo1nFhwQ/Aaq+wewzThmYzxiBxc1acpwF/q57rcg==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpjy3rtd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 13:11:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 426DBGev019074;
	Wed, 6 Mar 2024 13:11:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wp0608qkb-1;
	Wed, 06 Mar 2024 13:11:16 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426DBGsv019069;
	Wed, 6 Mar 2024 13:11:16 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 426DBGtd019068;
	Wed, 06 Mar 2024 13:11:16 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 1482B26B8; Wed,  6 Mar 2024 18:41:15 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 0/3] arm64: qcom: sa8775p: add cache coherency support for SA8775P
Date: Wed,  6 Mar 2024 18:41:09 +0530
Message-Id: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nrc6TKXXHQ8UKOExaGgtpOfVK_wjkBqE
X-Proofpoint-ORIG-GUID: nrc6TKXXHQ8UKOExaGgtpOfVK_wjkBqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060105
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
the requester is indicating that no cache coherency issues exist for
the addressed memory on the host i.e., memory is not cached. But in
reality, requester cannot assume this unless there is a complete
control/visibility over the addressed memory on the host.

And worst case, if the memory is cached on the host, it may lead to
memory corruption issues. It should be noted that the caching of memory
on the host is not solely dependent on the NO_SNOOP attribute in TLP.

So to avoid the corruption, this patch overrides the NO_SNOOP attribute
by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
needed for other upstream supported platforms since they do not set
NO_SNOOP attribute by default.

This series is to enable cache snooping logic in both RC and EP driver
and add the "dma-coherent" property in dtsi to support cache coherency
in SA8775P platform.

Dependency
----------

Depends on:
https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/
https://lore.kernel.org/all/20240306-dw-hdma-v4-4-9fed506e95be@linaro.org/ [1]

V5 -> V6:
- updated commit message as per comments
- added Kdoc comments in patch1
- change variable name from enable_cache_snoop to
  override_no_snoop
- sort reg offset define in patch2

V4 -> V5:
- Updated commit message in both Patch1 and patch2
- change variable name from no_snoop_override to
  enable_cache_snoop
- rebased patch2 on top of [1]

v3 -> v4:
- added new cfg(cfg_1_34_0) for SA8775P in both RC and EP driver.
- populated a flag in the data structures instead of doing
  of_device_is_compatible() in both RC and EP patch.
- update commit mesaage and added reveiwed-by tag in commit message
  in dtsi patch.

v2 -> v3:
- update commit message(8755 -> 8775).

v1 -> v2:
- update cover letter with explanation.
- define each of these bits and ORing at usage time rather than
  directly writing value in register.

Mrinmay Sarkar (3):
  PCI: qcom: Override NO_SNOOP attribute for SA8775P RC
  PCI: qcom-ep: Override NO_SNOOP attribute for SA8775P EP
  arm64: dts: qcom: sa8775p: Mark PCIe EP controller as cache coherent

 arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 20 +++++++++++++++++---
 drivers/pci/controller/dwc/pcie-qcom.c    | 25 ++++++++++++++++++++++++-
 3 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.7.4


