Return-Path: <linux-kernel+bounces-77497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EEC860663
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D1C286742
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D090F32C84;
	Thu, 22 Feb 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Aex6mvf2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBE41C680;
	Thu, 22 Feb 2024 23:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643823; cv=none; b=qF748Xrn0f/pRiaFUoFwdvx426fTjL6SnRy/IyUB6BdKidLEKu0dD6sDm+ChtLF/js5qMEy6QRNZcPJmCPEoqiFBZasEYwVnaaYhQJ6J7dzHMv0g8Kev8AD/tciFb65CsV/Oq25RF680waXoXUPIMWPKEzGg72d/Fyo8Hh5zBeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643823; c=relaxed/simple;
	bh=Ka7yMpUBY0NWUH9927zVV6/k4CvFgSZ6vIK6Qbq74FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ejij4vAOzVcZ3H5bZRFj6KQ+p3C9QV6CAvQuQgYI+hgBEdDE2AkaPqP2u0m/uq8WSmu3L0lIR79GLnZLpA5oNrg+N1zB0DGDyh3a7IxIhjtnt6iwFcI8rkxG6lC8zpXdixtdDLbZpQOtI6Qx/q6rS+UOv09YIm31TBQfHKwdZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Aex6mvf2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLSSYf024471;
	Thu, 22 Feb 2024 23:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=BqFFNu68PPJsdW9psryeqdBWeZaEA8iJMtTYpGjEiRs
	=; b=Aex6mvf2g3FnivTElXrRrrHWoO98H3rwWvOrmltuggNv3WUhHob6R/Efvf5
	fth/r/0ebRdtGJN6hnNt00WxB+8pxKlu8y2Zjah3urXwGeZ2A8JIEuZNAzC80uvQ
	WlIeepmVse9WxaI/b//9J8xcsfewNrgxojbn1H3/NNwIMlcpN4bkj5HIqNF8ZUH7
	RIuoI+MZZ6xj4SnJhmTgjSUiB7Us6pTFEBBECy0F6SLzOou0dnNdl49ruiqElAT2
	F+J3iD96h5jsthaHd4CmCy/27vk8MDfgaFFPUXHpqcgipDVinxSZyXQCY0WIlNaK
	tnoNdc9MIJfm8YDvhpRbBPlK5Ig==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we3231h1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGc3b025583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:38 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:37 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:42 -0800
Subject: [PATCH v17 19/35] arch/mm: Export direct {un,}map functions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-19-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MP-x340LqCsOeMxuGX6zrotY1v88l2Gs
X-Proofpoint-GUID: MP-x340LqCsOeMxuGX6zrotY1v88l2Gs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=828 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220178

Firmware and hypervisor drivers can donate system heap memory to their
respective firmware/hypervisor entities. Those drivers should unmap the
pages from the kernel's logical map before doing so.

Export can_set_direct_map, set_direct_map_invalid_noflush, and
set_direct_map_default_noflush.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 arch/arm64/mm/pageattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 924843f1f661b..a9bd84588c98a 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -32,6 +32,7 @@ bool can_set_direct_map(void)
 	return rodata_full || debug_pagealloc_enabled() ||
 	       arm64_kfence_can_set_direct_map();
 }
+EXPORT_SYMBOL_GPL(can_set_direct_map);
 
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
@@ -176,6 +177,7 @@ int set_direct_map_invalid_noflush(struct page *page)
 				   (unsigned long)page_address(page),
 				   PAGE_SIZE, change_page_range, &data);
 }
+EXPORT_SYMBOL_GPL(set_direct_map_invalid_noflush);
 
 int set_direct_map_default_noflush(struct page *page)
 {
@@ -191,6 +193,7 @@ int set_direct_map_default_noflush(struct page *page)
 				   (unsigned long)page_address(page),
 				   PAGE_SIZE, change_page_range, &data);
 }
+EXPORT_SYMBOL_GPL(set_direct_map_default_noflush);
 
 #ifdef CONFIG_DEBUG_PAGEALLOC
 void __kernel_map_pages(struct page *page, int numpages, int enable)

-- 
2.34.1


