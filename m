Return-Path: <linux-kernel+bounces-77493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD2860653
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B4A91C2265E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5918E11;
	Thu, 22 Feb 2024 23:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G8zLuS0q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F870182AF;
	Thu, 22 Feb 2024 23:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643821; cv=none; b=rjZqlmEo79/UOkye/mU6U7oYdryPlUUIs3dliy/fR3kzE8pl2AeuojrT/jvPCAF+3zdSZY2MEwnmFPDZu1Ah6LNLxMbeAwJVbY1B8mdSLQjiqQcbJTSiQ7fgOLtssXjE06+zEit1CcBO27JsDYivm7lIYgfMx1jQ90sxZl7VZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643821; c=relaxed/simple;
	bh=+QW1VJa5kokGOQa6gzjck0l5r4ueQ0qvSvbOj9eLzJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tatG+PEXIwnxV6DAfeBasINVrh14lYKxLWSs/L3EfB/R3sJJe/NBwIuuGyxbO1XEY79bm8J5HcOqp2vifCWriohtE/gwQpZ4ypapXiSxRS6e6IiINFmKNfz/VHooDjbOF4MHPmv/6kCrdfnsmy7upQyuKP59OKD4cj1kPzJZCHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G8zLuS0q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MN1D1E020603;
	Thu, 22 Feb 2024 23:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=a8k7ZP82tn4JVJwW+w/m7k4EoKpoY9RGrzHrrV6tQxc
	=; b=G8zLuS0qr6d4lZUoE5CoDx+OQ1H30bu9JjA/DBQ4WHtPH6Y32oBCFeCUzqq
	aRECHJ8Nnre0wYkRag/a/bnHEq5di/ZfvzIFt40zo/It/7L/Yo3lf0a0UtEAs7pZ
	SbKN6b5H8bqSMLS9E5/YsoEbDzUgXoHRkwYC5+EJ2/mG09No+OQvpbVvPio+rs7L
	4NoKBtTgW+NDPapXhOFi05jweADI/zkiqUBOSN6yH8dLtghTmF9WdFTRMy56NPQY
	Vv4A92LdxJ2FBQwkeDpNGUF12C3AqSq78fBdwbCBnGZY3F0qL4c9LQ2ISi/HfvhP
	Begi0gYT0HyrwE02SVJkWZOk9xw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3we4dq17sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:38 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGbaG027727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:37 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:37 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:41 -0800
Subject: [PATCH v17 18/35] mm/interval_tree: Export iter_first/iter_next
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-18-1e9da6763d38@quicinc.com>
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
X-Proofpoint-GUID: S-X8YH9UOQhwdKZl5qZ08gJqpUzKbDlZ
X-Proofpoint-ORIG-GUID: S-X8YH9UOQhwdKZl5qZ08gJqpUzKbDlZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=955 clxscore=1015 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402220179

Export vma_interval_tree_iter_first and vma_interval_tree_iter_next for
vma_interval_tree_foreach.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 mm/interval_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/interval_tree.c b/mm/interval_tree.c
index 32e390c42c53f..faa50767496c3 100644
--- a/mm/interval_tree.c
+++ b/mm/interval_tree.c
@@ -24,6 +24,9 @@ INTERVAL_TREE_DEFINE(struct vm_area_struct, shared.rb,
 		     unsigned long, shared.rb_subtree_last,
 		     vma_start_pgoff, vma_last_pgoff, /* empty */, vma_interval_tree)
 
+EXPORT_SYMBOL_GPL(vma_interval_tree_iter_first);
+EXPORT_SYMBOL_GPL(vma_interval_tree_iter_next);
+
 /* Insert node immediately after prev in the interval tree */
 void vma_interval_tree_insert_after(struct vm_area_struct *node,
 				    struct vm_area_struct *prev,

-- 
2.34.1


