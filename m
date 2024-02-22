Return-Path: <linux-kernel+bounces-77515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3E68606B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01341C2180F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCC414CAD3;
	Thu, 22 Feb 2024 23:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KBZZOdWE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208A14039F;
	Thu, 22 Feb 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643832; cv=none; b=EQ21xrose4HjPsejmFwGVqbnFGEIem0GM9eEjeduA2EbD9+ShAP37lNwsOfw4E2mC59Bn2krvfyo+zUfEiaWp8GwmRYvWEG39peM3Hulq6EvEXtY2titber21VTy8rudzcnhAOX3tzms4Nj0KoD2T7HfaPoqj8SBeikkABemWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643832; c=relaxed/simple;
	bh=w/D7r26XZ0yYCLrpalxmyA8FV0rkftK0ivNgur7CBWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gDxVdk9zoE+tBUTzQMlBF8ZG8GRB74g/nzlZygOuRKQTrxFLY1Y9uzqOiEQw9l/6PTaxOkVPH1ThQdz+llj+77is4DtgwB27TcTWFmbtsZkqY28aR2yTttBneK1iX7MofOSBuzguRexBrjqXzkGLn5DdhdTGJVb9A4EdGYirgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KBZZOdWE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMbD9R002908;
	Thu, 22 Feb 2024 23:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=HSfYN4ASmajbR465rFcbd8dDlprgPpo+2HlUXq69zlQ
	=; b=KBZZOdWEpYyIHHsdQVqr01IY7F8f8kShHAH6rwPxXFMleuTm65CON99rn5u
	Vr62MR3hyz8ommojpHx/P8xTqWGT7Sm/UepRpOVpDbG0QEjqGYqkWjk340i1tBMz
	fcxu35kcasBlTqRykW2QDzICNtERSN+IK4aXZE+7p2v6IzEk2ylzKTCp4UI9HB/I
	cXmayPouDScih+1r4AhIPB9K0xpMvwBHvOhaBpvB6rz8+U/rTY8S1TSPpjNlmjsL
	zGNJIsRGSb3TDoV/o5OBs23GzjFWWlAFEjvvUYIKfL+fWC9JiZtsHjHrVsISO9fG
	CUi8G1FAxwpeYdxOeVUa1W9pmww==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we1b0jxst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGanv016004
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:36 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:35 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:39 -0800
Subject: [PATCH v17 16/35] gunyah: Add hypercalls for demand paging
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-16-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: zQIDYaV4Xlly6E59RQQafshiQ0DfVG7f
X-Proofpoint-GUID: zQIDYaV4Xlly6E59RQQafshiQ0DfVG7f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=527
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Three hypercalls are needed to support demand paging.
In create page mappings for a virtual machine's address space, memory
must be moved to a memory extent that is allowed to be mapped into that
address space. Memory extents are Gunyah's implementation of access
control. Once the memory is moved to the proper memory extent, the
memory can be mapped into the VM's address space. Implement the
bindings to perform those hypercalls.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/gunyah/gunyah_hypercall.c | 87 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/gunyah.h      | 21 +++++++++
 include/linux/gunyah.h               | 56 +++++++++++++++++++++++
 3 files changed, 164 insertions(+)

diff --git a/arch/arm64/gunyah/gunyah_hypercall.c b/arch/arm64/gunyah/gunyah_hypercall.c
index fee21df42c176..38403dc28c66f 100644
--- a/arch/arm64/gunyah/gunyah_hypercall.c
+++ b/arch/arm64/gunyah/gunyah_hypercall.c
@@ -39,6 +39,9 @@ EXPORT_SYMBOL_GPL(arch_is_gunyah_guest);
 #define GUNYAH_HYPERCALL_HYP_IDENTIFY		GUNYAH_HYPERCALL(0x8000)
 #define GUNYAH_HYPERCALL_MSGQ_SEND		GUNYAH_HYPERCALL(0x801B)
 #define GUNYAH_HYPERCALL_MSGQ_RECV		GUNYAH_HYPERCALL(0x801C)
+#define GUNYAH_HYPERCALL_ADDRSPACE_MAP		GUNYAH_HYPERCALL(0x802B)
+#define GUNYAH_HYPERCALL_ADDRSPACE_UNMAP	GUNYAH_HYPERCALL(0x802C)
+#define GUNYAH_HYPERCALL_MEMEXTENT_DONATE	GUNYAH_HYPERCALL(0x8061)
 #define GUNYAH_HYPERCALL_VCPU_RUN		GUNYAH_HYPERCALL(0x8065)
 /* clang-format on */
 
@@ -114,6 +117,90 @@ enum gunyah_error gunyah_hypercall_msgq_recv(u64 capid, void *buff, size_t size,
 }
 EXPORT_SYMBOL_GPL(gunyah_hypercall_msgq_recv);
 
+/**
+ * gunyah_hypercall_addrspace_map() - Add memory to an address space from a memory extent
+ * @capid: Address space capability ID
+ * @extent_capid: Memory extent capability ID
+ * @vbase: location in address space
+ * @extent_attrs: Attributes for the memory
+ * @flags: Flags for address space mapping
+ * @offset: Offset into memory extent (physical address of memory)
+ * @size: Size of memory to map; must be page-aligned
+ */
+enum gunyah_error gunyah_hypercall_addrspace_map(u64 capid, u64 extent_capid, u64 vbase,
+					u32 extent_attrs, u32 flags, u64 offset, u64 size)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = GUNYAH_HYPERCALL_ADDRSPACE_MAP,
+		.a1 = capid,
+		.a2 = extent_capid,
+		.a3 = vbase,
+		.a4 = extent_attrs,
+		.a5 = flags,
+		.a6 = offset,
+		.a7 = size,
+		/* C language says this will be implictly zero. Gunyah requires 0, so be explicit */
+		.a8 = 0,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_hvc(&args, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gunyah_hypercall_addrspace_map);
+
+/**
+ * gunyah_hypercall_addrspace_unmap() - Remove memory from an address space
+ * @capid: Address space capability ID
+ * @extent_capid: Memory extent capability ID
+ * @vbase: location in address space
+ * @flags: Flags for address space mapping
+ * @offset: Offset into memory extent (physical address of memory)
+ * @size: Size of memory to map; must be page-aligned
+ */
+enum gunyah_error gunyah_hypercall_addrspace_unmap(u64 capid, u64 extent_capid, u64 vbase,
+					u32 flags, u64 offset, u64 size)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = GUNYAH_HYPERCALL_ADDRSPACE_UNMAP,
+		.a1 = capid,
+		.a2 = extent_capid,
+		.a3 = vbase,
+		.a4 = flags,
+		.a5 = offset,
+		.a6 = size,
+		/* C language says this will be implictly zero. Gunyah requires 0, so be explicit */
+		.a7 = 0,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	arm_smccc_1_2_hvc(&args, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gunyah_hypercall_addrspace_unmap);
+
+/**
+ * gunyah_hypercall_memextent_donate() - Donate memory from one memory extent to another
+ * @options: donate options
+ * @from_capid: Memory extent capability ID to donate from
+ * @to_capid: Memory extent capability ID to donate to
+ * @offset: Offset into memory extent (physical address of memory)
+ * @size: Size of memory to donate; must be page-aligned
+ */
+enum gunyah_error gunyah_hypercall_memextent_donate(u32 options, u64 from_capid, u64 to_capid,
+					    u64 offset, u64 size)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(GUNYAH_HYPERCALL_MEMEXTENT_DONATE, options, from_capid, to_capid,
+				offset, size, 0, &res);
+
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(gunyah_hypercall_memextent_donate);
+
 /**
  * gunyah_hypercall_vcpu_run() - Donate CPU time to a vcpu
  * @capid: capability ID of the vCPU to run
diff --git a/arch/arm64/include/asm/gunyah.h b/arch/arm64/include/asm/gunyah.h
index 0cd3debe22b64..4adf24977fd18 100644
--- a/arch/arm64/include/asm/gunyah.h
+++ b/arch/arm64/include/asm/gunyah.h
@@ -33,4 +33,25 @@ static inline int arch_gunyah_fill_irq_fwspec_params(u32 virq,
 	return 0;
 }
 
+enum arch_gunyah_memtype {
+	/* clang-format off */
+	GUNYAH_MEMTYPE_DEVICE_nGnRnE	= 0,
+	GUNYAH_DEVICE_nGnRE		= 1,
+	GUNYAH_DEVICE_nGRE		= 2,
+	GUNYAH_DEVICE_GRE		= 3,
+
+	GUNYAH_NORMAL_NC	= 0b0101,
+	GUNYAH_NORMAL_ONC_IWT	= 0b0110,
+	GUNYAH_NORMAL_ONC_IWB	= 0b0111,
+	GUNYAH_NORMAL_OWT_INC	= 0b1001,
+	GUNYAH_NORMAL_WT	= 0b1010,
+	GUNYAH_NORMAL_OWT_IWB	= 0b1011,
+	GUNYAH_NORMAL_OWB_INC	= 0b1101,
+	GUNYAH_NORMAL_OWB_IWT	= 0b1110,
+	GUNYAH_NORMAL_WB	= 0b1111,
+	/* clang-format on */
+};
+
+#define ARCH_GUNYAH_DEFAULT_MEMTYPE	GUNYAH_NORMAL_WB
+
 #endif
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index 6c24544f38dc9..24c02c6827738 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -273,6 +273,62 @@ enum gunyah_error gunyah_hypercall_msgq_send(u64 capid, size_t size, void *buff,
 enum gunyah_error gunyah_hypercall_msgq_recv(u64 capid, void *buff, size_t size,
 					     size_t *recv_size, bool *ready);
 
+#define GUNYAH_ADDRSPACE_SELF_CAP 0
+
+enum gunyah_pagetable_access {
+	/* clang-format off */
+	GUNYAH_PAGETABLE_ACCESS_NONE		= 0,
+	GUNYAH_PAGETABLE_ACCESS_X		= 1,
+	GUNYAH_PAGETABLE_ACCESS_W		= 2,
+	GUNYAH_PAGETABLE_ACCESS_R		= 4,
+	GUNYAH_PAGETABLE_ACCESS_RX		= 5,
+	GUNYAH_PAGETABLE_ACCESS_RW		= 6,
+	GUNYAH_PAGETABLE_ACCESS_RWX		= 7,
+	/* clang-format on */
+};
+
+/* clang-format off */
+#define GUNYAH_MEMEXTENT_MAPPING_USER_ACCESS		GENMASK_ULL(2, 0)
+#define GUNYAH_MEMEXTENT_MAPPING_KERNEL_ACCESS		GENMASK_ULL(6, 4)
+#define GUNYAH_MEMEXTENT_MAPPING_TYPE			GENMASK_ULL(23, 16)
+/* clang-format on */
+
+enum gunyah_memextent_donate_type {
+	/* clang-format off */
+	GUNYAH_MEMEXTENT_DONATE_TO_CHILD		= 0,
+	GUNYAH_MEMEXTENT_DONATE_TO_PARENT		= 1,
+	GUNYAH_MEMEXTENT_DONATE_TO_SIBLING		= 2,
+	GUNYAH_MEMEXTENT_DONATE_TO_PROTECTED		= 3,
+	GUNYAH_MEMEXTENT_DONATE_FROM_PROTECTED		= 4,
+	/* clang-format on */
+};
+
+enum gunyah_addrspace_map_flag_bits {
+	/* clang-format off */
+	GUNYAH_ADDRSPACE_MAP_FLAG_PARTIAL	= 0,
+	GUNYAH_ADDRSPACE_MAP_FLAG_PRIVATE	= 1,
+	GUNYAH_ADDRSPACE_MAP_FLAG_VMMIO		= 2,
+	GUNYAH_ADDRSPACE_MAP_FLAG_NOSYNC	= 31,
+	/* clang-format on */
+};
+
+enum gunyah_error gunyah_hypercall_addrspace_map(u64 capid, u64 extent_capid,
+						 u64 vbase, u32 extent_attrs,
+						 u32 flags, u64 offset,
+						 u64 size);
+enum gunyah_error gunyah_hypercall_addrspace_unmap(u64 capid, u64 extent_capid,
+						   u64 vbase, u32 flags,
+						   u64 offset, u64 size);
+
+/* clang-format off */
+#define GUNYAH_MEMEXTENT_OPTION_TYPE_MASK	GENMASK_ULL(7, 0)
+#define GUNYAH_MEMEXTENT_OPTION_NOSYNC		BIT(31)
+/* clang-format on */
+
+enum gunyah_error gunyah_hypercall_memextent_donate(u32 options, u64 from_capid,
+						    u64 to_capid, u64 offset,
+						    u64 size);
+
 struct gunyah_hypercall_vcpu_run_resp {
 	union {
 		enum {

-- 
2.34.1


