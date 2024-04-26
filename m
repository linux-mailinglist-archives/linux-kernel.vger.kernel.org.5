Return-Path: <linux-kernel+bounces-160655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF38B40AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66B61F21350
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1D23758;
	Fri, 26 Apr 2024 20:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LTutAkMA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254E171A5;
	Fri, 26 Apr 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161869; cv=none; b=QJCEvAfFrB6lh70p5v4FHjZ74Ga263QwYQIpL4Hq9JdheIWyl+ncL7iFiAW8W0nSTmCxbJY7RQo17LZ7hUpg9ijGyYWF/hmjvHRPudx1uJou/Awza1z3SqmHW4pc0W8jQBn8gqbinlemNzEngmuPd/69g38uCDyuBrbmJunRzsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161869; c=relaxed/simple;
	bh=4Y/1SNbJpP6Iq6bpaDNDG2do5EqjdK+s/ofDm4Cz0GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K1nW0SrFmx3MZLpY9PxpYwquDMhLnn4Cd3309/U2rhHMOhjJ8xE6eTYaspn4RqZP405mIjV4qh+L8Mdm+T25L4HedyJg7I/HoYm+eTmrJqiyLFbAdc51QPR9TDdm5SJzHgWbvCqywt3zBhRn650S/KlQMfdD/xU0Q/oGzWVM7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LTutAkMA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QCBwdj013759;
	Fri, 26 Apr 2024 20:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=CVAZFTsLc+ZUqoicJEH8S6rIGArbQdqBeftallr55BM=; b=LT
	utAkMA83j3mmHOC5EsZVXQFScJhAWIiDmS8EZZ4zx+ionvatYbvZqsiDHEfColcc
	7kCdPpAoqcqMyi/cELiDp7YnXq5mKUSf9pFl/VQ+68TA1K2PDLZq14FrAsdZ+sRc
	5I1uSrAgY4z0vN/tS46aJGRrZPqzUNRhGPORUtSInegHg7NHitHelXU6yuFRRa7O
	slbqL4ICvyNl4k9ruQfB6OGdpY9qYtwxiITczJ+mBsayfGrEqrVO/u7akFNr/c15
	w9OA2Gv8q9x0tF4yvDw54aMxyIEqQjy8rk+zm79qCigYm90O6E38t9ED39FwJ7aV
	s4VUIExgbu0B8W4k2QJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr35ettv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 20:03:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QK3Hd7016370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 20:03:18 GMT
Received: from [10.110.6.235] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 26 Apr
 2024 13:03:17 -0700
Message-ID: <a24aac59-961f-0a1a-4558-61e333c6fa7f@quicinc.com>
Date: Fri, 26 Apr 2024 13:03:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v20 08/41] usb: host: xhci-mem: Allow for interrupter
 clients to choose specific index
Content-Language: en-US
To: =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>,
        <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
 <20240425215125.29761-9-quic_wcheng@quicinc.com>
 <60c17b0c-8069-4019-b062-3b3cb892297b@linux.intel.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <60c17b0c-8069-4019-b062-3b3cb892297b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g6oaGlBmz1dhPebrOegIfxkgZhb6mMgK
X-Proofpoint-ORIG-GUID: g6oaGlBmz1dhPebrOegIfxkgZhb6mMgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_17,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=718
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404260139

Hi Amadeusz,

On 4/26/2024 6:24 AM, Amadeusz Sławiński wrote:
> On 4/25/2024 11:50 PM, Wesley Cheng wrote:
>> Some clients may operate only on a specific XHCI interrupter instance.
>> Allow for the associated class driver to request for the interrupter that
>> it requires.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
> 
> (...)
> 
>> -
>> -    /* Find available secondary interrupter, interrupter 0 is 
>> reserved for primary */
>> +    /* Find available secondary interrupter, interrupter 0 is 
>> reserverd for primary */
> 
> You introduce a typo in here.

Thanks for the review!  Will fix it.

Thanks
Wesley Cheng

