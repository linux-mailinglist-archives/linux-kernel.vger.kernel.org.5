Return-Path: <linux-kernel+bounces-152282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FC58ABBD9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 15:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F071DB20F09
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50D27453;
	Sat, 20 Apr 2024 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PFbKP1Ln"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7C20326;
	Sat, 20 Apr 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713621249; cv=none; b=ACT3ihYfF7V0cVq3VJqiHlefBPlgn8RfAedZPzAvM8L0PDGILFU9JRaC5Y/5Tw42y52Dz8YjwGCzo4KgxCOJOq2/o+Lrt0jcR6NsZ5ub73G8n0HvufXc6O9sguyokN4Q+W5N2ykdQDleQxWCpoOG3Dk1qk/2unjgbgkDXmIRIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713621249; c=relaxed/simple;
	bh=xFvJad8z9ShvGIHnmmfacH83jUL0xd55b1ZUaiiR2gI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ajiFxBmGROM0A79Ysu8Dl0H2Qwl4+gouZBrvbj4DbxF+ibhIELGtZpxV89eL4L5aH5ynOEh1GSKpeNrJ8BZ8MiRkFa5AEhjc/cPf9B2XT78mraSAyUQXuwdpNt1UwhPFJq9p0sOsw44Q9GPKlLHMiQUEn3be3Hh5yuTvabAdBpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PFbKP1Ln; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KCWRFu018736;
	Sat, 20 Apr 2024 13:53:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RXERqp/s+wwOveqRN1HcpASDEXXZ76enuqc/QtiXO/o=; b=PF
	bKP1LnMdbSyLfUCXmglQttSumrdUWK4q9G4HjEQ4O8PNRw5xUHgxSP6T74Mk+ibC
	UbOugtqBW2mJhyhP0xA06Pv2sklKnsVVH1kdCi77F1C86aVt3Z0OJXjqiXnn3Hjz
	OAZK5mUckF1p5UXf8zu1J0tE4HQPgsn/0ZAimHGK/ldDdZTgzc8TgtpROW9W90Cj
	FozNjJ9oFFYsT4Ax/Bn/DAGE+JC9CXFA0lojwEzAvUhxdNwiUF6H3adD2onn7AL8
	6j+b0ke9xpO5JkNljypTSsPXyf5KV8DWVyIpEadZnq8uSlUgxWG59+Z+BrcmoOdH
	9rA6j0rRC8ZveUKhYYIw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4wx0x2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 13:53:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KDri8q025738
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 13:53:44 GMT
Received: from [10.216.42.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 20 Apr
 2024 06:53:38 -0700
Message-ID: <7034e026-5c50-4c65-ba78-e9c73f4a276a@quicinc.com>
Date: Sat, 20 Apr 2024 19:23:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 5/9] dt-bindings: usb: qcom,dwc3: Add bindings for
 SC8280 Multiport
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring
	<robh@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Johan Hovold
	<johan@kernel.org>, Felipe Balbi <balbi@kernel.org>
References: <20240420044901.884098-1-quic_kriskura@quicinc.com>
 <20240420044901.884098-6-quic_kriskura@quicinc.com>
 <3ca24a3d-e7e0-4f68-9a6f-ebaf83079ebe@linaro.org>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <3ca24a3d-e7e0-4f68-9a6f-ebaf83079ebe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XQsZNxS82Yp6mqZ684_ocyIU-pw4L6QD
X-Proofpoint-ORIG-GUID: XQsZNxS82Yp6mqZ684_ocyIU-pw4L6QD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_12,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200101



On 4/20/2024 5:01 PM, Krzysztof Kozlowski wrote:
> On 20/04/2024 06:48, Krishna Kurapati wrote:
>> Add the compatible string for SC8280 Multiport USB controller from
>> Qualcomm.
>>
>> There are 4 power event interrupts supported by this controller
>> (one for each port of multiport controller). Add all the 4 as
>> non-optional interrupts for SC8280XP-MP
>>
>> Also each port of multiport has one DP and one DM IRQ. Add all DP/DM
>> IRQs related to 4 ports of SC8280XP Teritiary controller.
>>
>> Also added SuperSpeed PHY interrupt for both Superspeed ports.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> 
> v21 and suddenly you drop tags requiring everyone to re-review this. I
> do not think this process is working. I will not re-review this.
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> 

Hi Krzysztof,

  There was a commit text change to fix minor nits:
  -> One minor spell check: /s/oen/one
  -> minor nits like: /s/ss/SuperSpeed

  So removed the tags and requested for a review.
  "Updated commit text in patches 2/5/6."

  Apologies, My intention was to just fix the spell check and minor nits.
.
  The changes in v21 were in patches 1/2/4/7/9.
  Patches 3 and 8 were left untouched.
  Made minor nit fixes to commit text in patches 5 and 6 so that it 
feels more accurate.

Regards,
Krishna,

