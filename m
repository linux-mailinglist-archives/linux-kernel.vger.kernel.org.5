Return-Path: <linux-kernel+bounces-14222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDD382195D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D1B282DCA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665DCD28D;
	Tue,  2 Jan 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZBm9+e6E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B182CA64;
	Tue,  2 Jan 2024 10:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4028wxAp031023;
	Tue, 2 Jan 2024 10:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U/qIkXpqNy15nekMfvk/AQomDo1b68nmO+3poX3Uda0=; b=ZB
	m9+e6E1iaENa7KrTz2VptTU7k8/J5qh6JLnl2AaNjd3r5AlULLR/T0nEES7cEPVU
	a73He4TPM1LBIwwGw4yUeHx6t86YDtgS4pO+rFOlN7cFdflMen6A/GrItgesLD3G
	CZH9kM6o8Xc1GQuyTJre3JiMBqLI8oKfVHZL9QMaxL6fdXfsmgxQz6NnhtE0gGGg
	VbqlEkmEOC90t/WMHDp4bd9dpJRKR/9qz4fnZVWINO0VUZyYbASrZa/XdTa7p3sd
	E3FlEBr1Oy8v7J1BqR7E6lA0K1Dr74fNaeUTr980+VOeSnfzpHM7v1JAo6EZDCJx
	HByu9MyZkBTf7PeKDdtQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vccc1gdgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jan 2024 10:02:10 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 402A29iZ016088
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jan 2024 10:02:09 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 2 Jan
 2024 02:02:03 -0800
Message-ID: <dce0f577-b08e-4eed-8457-9ea5fefbd8c9@quicinc.com>
Date: Tue, 2 Jan 2024 18:01:59 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] arm64: dts: qcom: msm8916: Drop RPM bus clocks
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar
	<quic_sibis@quicinc.com>, Will Deacon <will@kernel.org>,
        Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Alexey Minnekhanov
	<alexeymin@postmarketos.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <linux-usb@vger.kernel.org>
References: <20230721-topic-rpm_clk_cleanup-v2-0-1e506593b1bd@linaro.org>
 <20230721-topic-rpm_clk_cleanup-v2-1-1e506593b1bd@linaro.org>
 <bd11d1b1-efe5-4f96-43e7-163fca5d3278@linaro.org>
 <ac501bcc-80a1-4b65-ba24-272152d1c95c@linaro.org>
 <7b500bba-3091-f425-a60d-e58a3d9e4c1a@linaro.org>
 <9a0ab5a9-d4d8-41b8-94b0-9c62bd686254@linaro.org>
 <30bb6068-6bb8-9a2c-af19-b989960d0be9@linaro.org>
 <70b19df7-c70c-41ea-ac4c-8af6956f4fc6@linaro.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <70b19df7-c70c-41ea-ac4c-8af6956f4fc6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wcsyJrzxICN3wHO1NZ9_HEVWn06ctdHI
X-Proofpoint-ORIG-GUID: wcsyJrzxICN3wHO1NZ9_HEVWn06ctdHI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=921
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401020076



On 9/13/2023 7:14 PM, Konrad Dybcio wrote:
> On 13.09.2023 13:14, Krzysztof Kozlowski wrote:
>> On 13/09/2023 12:48, Konrad Dybcio wrote:
>>> On 13.09.2023 10:53, Krzysztof Kozlowski wrote:
>>>> On 13/09/2023 10:47, Konrad Dybcio wrote:
>>>>> On 13.09.2023 09:07, Krzysztof Kozlowski wrote:
>>>>>> On 12/09/2023 15:31, Konrad Dybcio wrote:
>>>>>>> These clocks are now handled from within the icc framework and are
>>>>>>
>>>>>> That's a driver behavior, not hardware.
>>>>> I believe we've been over this already..
>>>>>
>>>>> The rationale behind this change is: that hardware, which falls
>>>>> under the "interconnect" class, was previously misrepresented as
>>>>> a bunch of clocks. There are clocks underneath, but accessing them
>>>>> directly would be equivalent to e.g. circumventing the PHY subsystem
>>>>> and initializing your UFS PHY from within the UFS device.
>>>>
>>>> And every time one write such commit msg, how should we remember there
>>>> is some exception and actually it is about clock representation not CCF
>>>> or ICC framework.
>>> So is your reply essentially "fine, but please make it clear in
>>> each commit message"?
>>
>> I am fine with this change. If commit msg had such statement, I would
>> not have doubts :/
> Ok, I'll resend, thanks for confirming!
Is there any one continue working on this?

The bindings already merged while the dtb is not consistent with current 
binding files. So dt bindings checks are failed actually.
> 
> Konrad
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Thx and BRs,
Aiqun(Maria) Yu

