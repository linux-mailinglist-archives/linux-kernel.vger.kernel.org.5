Return-Path: <linux-kernel+bounces-21576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2807829166
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA63288F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E626B644;
	Wed, 10 Jan 2024 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UG0OGwXh"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED757EF;
	Wed, 10 Jan 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A08SZZ015550;
	Wed, 10 Jan 2024 00:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=fcdpkler2Rec7WUNPC8tXx/5Sp8IWWTCEuuRDbJEpAI=; b=UG
	0OGwXhCZ7UsyphKBnOOZRqvCtGZENhg///tuunm3BpEqr4YdmOqa2pijyqYZWoA6
	sFvrduplD1RZ4zkZxom/JIWFtsIdpPRseXBrXZDfUYBvTjnSmPHUo5gS7wZS6c75
	ZjGT6Zi6shBAAQPaEWCD54KNxuftM8IkaQWPuq+fThrMzE3gdqk9Kuyc+YGiRlDv
	gIXgVWjXAWbm6zrCS3UI4WOISwFG7xonBGIke5xemo/T05EFeBozHGyBPGsUQUk5
	Q8mShkVnzCy2WVCy23QxX8dWx+xOYR6QTTWXEGgwHlNgJgqwh5liu22iM+3EzfxO
	J83ABf+fNjL0zlQ0Rv7Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9bmh04c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 00:28:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40A0SlYq027252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 00:28:47 GMT
Received: from [10.71.108.105] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 16:28:46 -0800
Message-ID: <731ee7a9-72c8-4ae7-8fcd-2c9bb07b09ac@quicinc.com>
Date: Tue, 9 Jan 2024 16:28:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 01/34] docs: gunyah: Introduce Gunyah Hypervisor
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Murali Nalajal
	<quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Srivatsa
 Vaddagiri" <quic_svaddagi@quicinc.com>,
        Carl van Schaik
	<quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
 <20240109-gunyah-v16-1-634904bf4ce9@quicinc.com>
 <d5b041d9-1691-4259-a76c-176c5b3d8be3@infradead.org>
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <d5b041d9-1691-4259-a76c-176c5b3d8be3@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -UClUus9G_GkxMyCJNYM4wqqYC_paeay
X-Proofpoint-GUID: -UClUus9G_GkxMyCJNYM4wqqYC_paeay
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=652 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100002



On 1/9/2024 3:31 PM, Randy Dunlap wrote:
> 
> 
> On 1/9/24 11:37, Elliot Berman wrote:
>> Gunyah is an open-source Type-1 hypervisor developed by Qualcomm. It
>> does not depend on any lower-privileged OS/kernel code for its core
>> functionality. This increases its security and can support a smaller
>> trusted computing based when compared to Type-2 hypervisors.
>>
>> Add documentation describing the Gunyah hypervisor and the main
>> components of the Gunyah hypervisor which are of interest to Linux
>> virtualization development.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> ---
>>  Documentation/virt/gunyah/index.rst         | 134 ++++++++++++++++++++++++++++
>>  Documentation/virt/gunyah/message-queue.rst |  68 ++++++++++++++
>>  Documentation/virt/index.rst                |   1 +
>>  3 files changed, 203 insertions(+)
>>
>> diff --git a/Documentation/virt/gunyah/index.rst b/Documentation/virt/gunyah/index.rst
>> new file mode 100644
>> index 000000000000..da8e5e4b9cac
>> --- /dev/null
>> +++ b/Documentation/virt/gunyah/index.rst
>> @@ -0,0 +1,134 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=================
>> +Gunyah Hypervisor
>> +=================
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>> +   message-queue
>> +
>> +Gunyah is a Type-1 hypervisor which is independent of any OS kernel, and runs in
>> +a higher CPU privilege level. It does not depend on any lower-privileged
> 
> Is this the usual meaning of higher and lower? Seems backwards to me.
> 

Hmm, I guess this x86 having ring 0 as most privileged and arm using EL3 as most
privileged. I'll switch to "more" and "less" privilege rather than implying
a numbering scheme.

Thanks for the rest of suggestions, applied those!

- Elliot


