Return-Path: <linux-kernel+bounces-44131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12DC841DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560CF2840BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEBB5645A;
	Tue, 30 Jan 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LQs2gxg3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3855E52;
	Tue, 30 Jan 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603239; cv=none; b=UtijZQzgtxO8yk/T1wYeY9xzNsLzXFk+xUcwJ8/3iQHAw6IbSCrG2mgvYj9A120qSooOHqpdoHAAPd8gaoOamYlAvCZ2u7lSEcYZyldQYAKl2Da6JzympO+y//io41h2TtT40Poe8jQSv2VbIHlc25dH1I4UWEHsy1LpIBpsErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603239; c=relaxed/simple;
	bh=y/tOK4kKubOxMCb3R8YpgrR6A+4VGvjHaSVjdAE5tOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gWu+xYRceLbTkgE5NenXaUdkBlxQZdXMAqb9Djz2/86E3cbYcodD6fYlYnxZ7dkvNgHvdxhNtscMajdBirowNAk3OEwC5tMmisU2EzCS3t4rBoek3WWexy+TScvgX8VIkRwaszMXafUmZD0ROIuQeCggd4yzxapisXKcvzkN2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LQs2gxg3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U6dSR2012565;
	Tue, 30 Jan 2024 08:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BgZ1iZOYhcZCeI2JkhX8IJ0qmAvDNFqA67+unrC01Nk=; b=LQ
	s2gxg3bbO9/7q9JDD9CAiWu6zJfsZCiG30wtIjFGzBH74UT26Bd4Konx/b+wSjBl
	7gXhuE/Wop1vSN4EZi0fpCxcMWkQpanMviGYk5xumX03Z+khz7SvoqgIKXs4N4zb
	Ljal4xa/AADiIzC1WyipokPdtxgWezQOta5fvGRDYZiAUt1bNYJdXmzuOhpV77LO
	0g+P4NMnwESb3HXoVwbyws+73X5FNPW7rk7xMHjDhLR4I+zrPIr413DJqz9T7/6Y
	Wlk5TXv3k421yiiP6JdEjf/+ZxBltWUey7aoJL3DUKy9qgh9Az2ojni5nhe/muW0
	i33/QE7XBlIxRTcKVcEA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxsc40fng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 08:27:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U8R8Sl025543
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 08:27:08 GMT
Received: from [10.206.101.41] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 00:27:03 -0800
Message-ID: <ecd2ffa0-b2b2-3b09-5799-6f7d4d4054c9@quicinc.com>
Date: Tue, 30 Jan 2024 13:56:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] media: dt-bindings: qcom,sc7280-venus: Allow one IOMMU
 entry
Content-Language: en-US
To: Luca Weiss <luca.weiss@fairphone.com>, Conor Dooley <conor@kernel.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240129-sc7280-venus-bindings-v1-1-20a9ba194c60@fairphone.com>
 <20240129-numerate-brought-4660c2a89719@spud>
 <CYRVI1IQ2UKE.15ZGCYLRT3ND3@fairphone.com>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <CYRVI1IQ2UKE.15ZGCYLRT3ND3@fairphone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Xv8y1pP61jrbaPJVNBCBn_IPG2vNeojm
X-Proofpoint-ORIG-GUID: Xv8y1pP61jrbaPJVNBCBn_IPG2vNeojm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=805 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401300060

Hello,

On 1/30/2024 1:17 PM, Luca Weiss wrote:
> On Mon Jan 29, 2024 at 6:37 PM CET, Conor Dooley wrote:
>> On Mon, Jan 29, 2024 at 08:48:54AM +0100, Luca Weiss wrote:
>>> Some SC7280-based boards crash when providing the "secure_non_pixel"
>>> context bank, so allow only one iommu in the bindings also.
>>>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>
>> Do we have any idea why this happens? How is someone supposed to know
>> whether or not their system requires you to only provide one iommu?
>> Yes, a crash might be the obvious answer, but is there a way of knowing
>> without the crashes?
> 
> +CC Vikash Garodia
> 
> Unfortunately I don't really have much more information than this
> message here:
> https://lore.kernel.org/linux-arm-msm/ff021f49-f81b-0fd1-bd2c-895dbbb03d56@quicinc.com/
> 
> And see also the following replies for a bit more context, like this
> one:
> https://lore.kernel.org/linux-arm-msm/a4e8b531-49f9-f4a1-51cb-e422c56281cc@quicinc.com/
> 
> Maybe Vikash can add some more info regarding this.

0x2184 is a secure SID i.e any transactions with that ID would be access
controlled by trustzone (TZ). SC7280 (chromebook) was designed without TZ, while
some other DT deriving from SC7280 (like qcm6490) might have TZ. Hence it is
good to move the iommu entry from SC7280 to chrome-common.

Regards,
Vikash

