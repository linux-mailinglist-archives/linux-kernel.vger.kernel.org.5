Return-Path: <linux-kernel+bounces-65326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2855E854B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE711F28BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C555C3B;
	Wed, 14 Feb 2024 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bnGo2ZFd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E183029437;
	Wed, 14 Feb 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920330; cv=none; b=OiL8suyfTEBjgujuAkTGXgPLXkr3qftcWL4DzFBNICKHvCVeJpbfAp01l4mnCmTwxVQu5rTS7Su4gvfeva5cRrPL7jy/YcGTez1SqgWgBqaUfaG6m5teH/ew6d1brxZt9kvyw36aUR8aeab7kMFylv/sxk5sgyjnRvaQq2P0zYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920330; c=relaxed/simple;
	bh=PIuaAUi/HzNr4VIVJ5ZGwCFEsvTBUElTsmJcUcDltIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LjpbkRzKoEFOcU7M2f7wxo+sFgzk2wle+tcLdGoN0erMU0wbtPiGjYPr8w+XmavgLt97z+leoB9c9UPTRPgwMI9n4gtw3bzQ6GMyYtvM7nd+0DTFPfCt3UCII7u1t+GIAOWbI4VCcEhDOKsYWY9sN0Te8EJYyeRIcwWtLA6F/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bnGo2ZFd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41EDgeuc031838;
	Wed, 14 Feb 2024 14:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Yi7PoTcuUFdMcrMmHrp4lMRyH4ZMSNadhMdkORqgv98=; b=bn
	Go2ZFdRWmIkxDYakQ8s+BTC2FQfnBaEdXtWTBy4KYITzp1RFs0129inOMHOmNKrY
	qp/UDJy95D8hV33tUxX2WgMZK7Qo8Ig3JbuebXuecNaS9tEgLPwdO0dPDlNKf1sR
	LaDmt9ZroHBRSgDk0rp6Zl6zgqZfMhD2FyOpjF9VMIbNdt1s4+vcPmdEw0k/4d51
	xnkOPt33SEQa3SDEoVt4KNGXAwtNQW74sFAayh6F7a+HDolxi476h/GGdbq362O1
	z6x/s5sRQHUSQTIhaDsWpJfkKRUnKkATKqT3lO4GwKLClHeysGVvSauEXpKYdWO/
	eNKHJFl9rv9a/1G6yvFg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w8enn9u9w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 14:18:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41EEIQiS010082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 14:18:26 GMT
Received: from [10.253.37.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 14 Feb
 2024 06:18:23 -0800
Message-ID: <162256e1-416f-46ea-9698-9de507768cb0@quicinc.com>
Date: Wed, 14 Feb 2024 22:18:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: qcom,coresight-tpdm: Rename
 qcom,dsb-element-size
Content-Language: en-US
To: James Clark <james.clark@arm.com>, Rob Herring <robh@kernel.org>
CC: Mike Leach <mike.leach@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Tao Zhang <quic_taozha@quicinc.com>,
        "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240213160521.15925-1-quic_jinlmao@quicinc.com>
 <20240213160521.15925-2-quic_jinlmao@quicinc.com>
 <20240213222957.GA2502642-robh@kernel.org>
 <a062ce8d-638a-4a33-8afa-45ad47efcd72@quicinc.com>
 <df3162c0-4b29-77a2-20b5-b36637fb11cf@arm.com>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <df3162c0-4b29-77a2-20b5-b36637fb11cf@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8V3cEsuZeHlInIBshwPCyrtxSdRR6O96
X-Proofpoint-ORIG-GUID: 8V3cEsuZeHlInIBshwPCyrtxSdRR6O96
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_06,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=935
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402140109


On 2/14/2024 5:36 PM, James Clark wrote:
>
> On 14/02/2024 01:43, Jinlong Mao wrote:
>> On 2/14/2024 6:29 AM, Rob Herring wrote:
>>> On Tue, Feb 13, 2024 at 08:05:17AM -0800, Mao Jinlong wrote:
>>>> Change qcom,dsb-element-size to qcom,dsb-element-bits as the unit is
>>>> bit.
>>> That may be, but this is an ABI and you are stuck with it. Unless, you
>>> can justify why that doesn't matter. (IIRC, this is new, so maybe no
>>> users yet?)
>> Hi Rob,
>>
>> Because for CMB type, it uses qcom,cmb-element-bits. So I change the
>> format to be the same as
>> CMB.
>>
>> Thanks
>> Jinlong Mao
>>
> I think what Rob was trying to say was that in the interest of not
> breaking existing DTs it's best to leave the existing names as they are,
> even if they aren't technically correct. And to only add new parameters
> with the -bits suffix, even if it's inconsistent with what's already there.

Hi Rob & James,

There is no tpdm nodes in any DT as of now. So I want to make this 
change before any tpdm
node is added in DT.

Thanks
Jinlong Mao

>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

