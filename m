Return-Path: <linux-kernel+bounces-72993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDD685BBA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5985E284869
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F2E67E70;
	Tue, 20 Feb 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+i4EtAa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B167A0F;
	Tue, 20 Feb 2024 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431400; cv=none; b=HSWzLD7h6XPyrSukPbSWC5170e33KjOtZNXrRqrh/uDNKA8dW30IBawKXPNmBF1ePsJ1pU4HSkhbplEleZkqwcseTxktdAKkkgHWYuEc4wLNus4EqYDTVE334cO6oynaWaBnsXa+JPxII/khnLgsHTM/aw3SUAzzcOnnL+fxLqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431400; c=relaxed/simple;
	bh=xxe7xXR5ViJ5P3nkZGEWWSAnOaRJH0LbxjktoljLWLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k0BeQFDOVf3r9XR+0gUL1BNAQmSYy/jJTZrFOGEhSLGVaKPHHVimWx1NadbZBS5EDjusn/Ut+licmghTj7RYJQfalYumU39+u5EEf+gxflXjh7EE+UVuIAvu4KWV0MVMos5/t3fJ4e2Kfz2GItyrmODs+BlJi9kuUZzmOsXTnCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+i4EtAa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KAweER007356;
	Tue, 20 Feb 2024 12:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=AO32al+Us7Zr/WvVNVqK8EIUSqXn1K1PdLFIuOU3tXs=; b=k+
	i4EtAadU3l2YApB/YDUl9KqyPlgkngnST7tx5736pUq6kjXvBXuduvpLSYSlQwVw
	yH3KDtq4H1b3dOL1c02mFs6dVMYAzJykDq4+SWRuwhxQUtUJguuEzV4pgZggakcS
	LFxupIAevkajN4hbo628RHPXWZOd7mhlxJI5xiVRD0u4HjAVpTPj0YYCJIR9iihm
	+dqC0RSNf0pAQqzAPX55VZ652qpfCvw/PRFkFHq+ptV7GAVodlFEVUyW4LYt5DDD
	hudbyTS2ZJ5wzNiE8pG2VuTYSqklozHfkCf/q3YPSCBa6GmwR+lyXo2G+8qaowxC
	NYx+mqFLj11MUWcEEpKQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wctmtr5du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:16:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KCGPFR018880
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 12:16:26 GMT
Received: from [10.216.16.129] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 04:16:19 -0800
Message-ID: <8bc1f81e-3f41-a1a4-69cc-2cc1ecd112af@quicinc.com>
Date: Tue, 20 Feb 2024 17:46:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq9574: Disable eMMC node
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-6-quic_mdalam@quicinc.com>
 <CAA8EJpqV=w38TqjfTp6OurAwHjR87PpmQTs2jUo6O7vF1-T-WQ@mail.gmail.com>
 <584a5308-c73d-4559-bb61-21d07cd63d6c@linaro.org>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <584a5308-c73d-4559-bb61-21d07cd63d6c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0owUN9JrF2nGv8lGvUMjMvU4ZMm1fcva
X-Proofpoint-GUID: 0owUN9JrF2nGv8lGvUMjMvU4ZMm1fcva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=604 spamscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402200088



On 2/15/2024 11:28 PM, Konrad Dybcio wrote:
> On 15.02.2024 16:00, Dmitry Baryshkov wrote:
>> On Thu, 15 Feb 2024 at 15:49, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>>>
>>> Disable eMMC node for rdp433, since rdp433 default boot mode
>>> is norplusnand.
>>
>> Are they exclusive?
> 
> Even if they're not, having access to the eMMC/sdcard would still
> be nice..

   GPIO are shared b/w eMMC and NAND so we can't keep both.
> 
> Konrad

