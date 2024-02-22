Return-Path: <linux-kernel+bounces-77508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0D860695
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D581F25E51
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AEC143C4F;
	Thu, 22 Feb 2024 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U+sTJqFd"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9C213BADE;
	Thu, 22 Feb 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643830; cv=none; b=mLyOfxkXqe1gjIsHCTCQjsg7mCbzTPtnqpVvLRho402iSApG9q/GkQ+F8Geh4LIzi7TjbYm8czKwvu1KUN+m/lIGmSgrJJr2SQCf0sDmbRJ1TE/GCqd+i5rM4+yz9m2ozamyjurz4eP9Hi4DtICYRncBjMRriHKlOc7BtHB+fpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643830; c=relaxed/simple;
	bh=9Alalk7LXfV/SaxnGokCnM4bydl53hwoFnS2Yh52xcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Rpk+F4nWXsWP/UuuQaTcdsyg/FrrLBJFKxZdeknbDudZ0xhSU4i3jZ2mAwxZhVjZskbPznBHK4rQvRxOvwf/W4+C2TSP4MmQrm+v1lwrHliPQxaesuhuUmOzdy43GNSKBk81bUSJssoXPsjRW82ANtkNDYbEFmJ4IuATLAE74zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U+sTJqFd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MN1qgD012101;
	Thu, 22 Feb 2024 23:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=UTw6fdMTFcjfZ33gKj3XSf3I7tXoLgizXBMgo1kqPAM
	=; b=U+sTJqFdPtYFI9+8gqCMOwjh27gzGPcH+qsSLx4MufdlHO9LkEf7qf7ovPi
	ihfRPS7yIKvuWsNlm79oYxdt5QESg0SMMV3yXcwYzo7h7ZcMU8w4biOvwyEWvKB4
	CI2ZJ4GFhKZdQh8y9CD8oNJ0J0Wqqz1k4MYuV98SNyirx3GS+qVM05+9uLuWcM3w
	GflnMQrs5QyhHqppmshSKwJ2L2hMU4aabmMgWIZRozWCydZu1UuoopYXnqcD6DlG
	wd/TAz4240tRmK7d9h4d8s/KjIf3MnP3+KjW6Pjag3OKgpn7/8nvxejhmakPxOk0
	CSXDQOcslaPX//MjSUXoF0G2RiA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we97tgf8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGhSG017967
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:43 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:43 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:52 -0800
Subject: [PATCH v17 29/35] gunyah: rsc_mgr: Add RPC to set VM boot context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-29-1e9da6763d38@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
In-Reply-To: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LYAEtq1tGFHE7mfHB6YGiz_72K1Y_peD
X-Proofpoint-ORIG-GUID: LYAEtq1tGFHE7mfHB6YGiz_72K1Y_peD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

The initial context of a the primary vCPU can be initialized by
performing RM RPC calls.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/rsc_mgr.h     |  2 ++
 drivers/virt/gunyah/rsc_mgr_rpc.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/virt/gunyah/rsc_mgr.h b/drivers/virt/gunyah/rsc_mgr.h
index 99c2db18579ca..2acaf8dff365e 100644
--- a/drivers/virt/gunyah/rsc_mgr.h
+++ b/drivers/virt/gunyah/rsc_mgr.h
@@ -84,6 +84,8 @@ int gunyah_rm_vm_configure(struct gunyah_rm *rm, u16 vmid,
 			   u32 mem_handle, u64 image_offset, u64 image_size,
 			   u64 dtb_offset, u64 dtb_size);
 int gunyah_rm_vm_init(struct gunyah_rm *rm, u16 vmid);
+int gunyah_rm_vm_set_boot_context(struct gunyah_rm *rm, u16 vmid, u8 reg_set,
+				  u8 reg_index, u64 value);
 
 struct gunyah_rm_hyp_resource {
 	u8 type;
diff --git a/drivers/virt/gunyah/rsc_mgr_rpc.c b/drivers/virt/gunyah/rsc_mgr_rpc.c
index dfffcf02ddaea..eabf8659eb8f9 100644
--- a/drivers/virt/gunyah/rsc_mgr_rpc.c
+++ b/drivers/virt/gunyah/rsc_mgr_rpc.c
@@ -24,6 +24,7 @@
 #define GUNYAH_RM_RPC_VM_INIT			0x5600000B
 #define GUNYAH_RM_RPC_VM_GET_HYP_RESOURCES	0x56000020
 #define GUNYAH_RM_RPC_VM_GET_VMID		0x56000024
+#define GUNYAH_RM_RPC_VM_SET_BOOT_CONTEXT	0x56000031
 #define GUNYAH_RM_RPC_VM_SET_DEMAND_PAGING	0x56000033
 #define GUNYAH_RM_RPC_VM_SET_ADDRESS_LAYOUT	0x56000034
 /* clang-format on */
@@ -105,6 +106,15 @@ struct gunyah_rm_vm_config_image_req {
 	__le64 dtb_size;
 } __packed;
 
+/* Call: VM_SET_BOOT_CONTEXT */
+struct gunyah_rm_vm_set_boot_context_req {
+	__le16 vmid;
+	u8 reg_set;
+	u8 reg_index;
+	__le32 _padding;
+	__le64 value;
+} __packed;
+
 /* Call: VM_SET_DEMAND_PAGING */
 struct gunyah_rm_vm_set_demand_paging_req {
 	__le16 vmid;
@@ -447,6 +457,29 @@ int gunyah_rm_vm_init(struct gunyah_rm *rm, u16 vmid)
 }
 ALLOW_ERROR_INJECTION(gunyah_rm_vm_init, ERRNO);
 
+/**
+ * gunyah_rm_vm_set_boot_context() - set the initial boot context of the primary vCPU
+ * @rm: Handle to a Gunyah resource manager
+ * @vmid: VM identifier
+ * @reg_set: See &enum gunyah_vm_boot_context_reg
+ * @reg_index: Which register to set; must be 0 for REG_SET_PC
+ * @value: Value to set in the register
+ */
+int gunyah_rm_vm_set_boot_context(struct gunyah_rm *rm, u16 vmid, u8 reg_set,
+				  u8 reg_index, u64 value)
+{
+	struct gunyah_rm_vm_set_boot_context_req req_payload = {
+		.vmid = cpu_to_le16(vmid),
+		.reg_set = reg_set,
+		.reg_index = reg_index,
+		.value = cpu_to_le64(value),
+	};
+
+	return gunyah_rm_call(rm, GUNYAH_RM_RPC_VM_SET_BOOT_CONTEXT,
+			      &req_payload, sizeof(req_payload), NULL, NULL);
+}
+ALLOW_ERROR_INJECTION(gunyah_rm_vm_set_boot_context, ERRNO);
+
 /**
  * gunyah_rm_get_hyp_resources() - Retrieve hypervisor resources (capabilities) associated with a VM
  * @rm: Handle to a Gunyah resource manager

-- 
2.34.1


