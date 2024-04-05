Return-Path: <linux-kernel+bounces-132903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384DD899BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693DF1C22798
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D46A16C6A4;
	Fri,  5 Apr 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PxcJsTtc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465016C6A5;
	Fri,  5 Apr 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316193; cv=none; b=qRmVd4vZXaXGRbxC+8+0F2y1j6o2TVQnHp3T7oAoxwgQdgveNJ8S0vhrMSZ8FS9IQ+Hnhr2U+wpXGThQh4GBbYjCg8stRWSto/cAs2qUnR1Qw6PH/KzA1UsSX7ccz2W9aJ51HilZxs3aneacOKH5cBe6kAqz8a3sHZFZKtUxKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316193; c=relaxed/simple;
	bh=RFBYteiUsDRtmHhvt8RCDv8kgTDEiNMm0DqviBfGnx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aUGgQ3pRZcfj1SY8XcLRM0EHTfavgVpa/XxhPOlJ2qCaCk4kiJSgI9D7eQ0MYlX5CBnNGZjhjeRr5FzDlPwkDa1KWGf9mEf168jS0UnZsp3fQIinWFXGWVh/jqNAIJ1LA51dNgWQVea3UH4fRpBMPQg6ItItXAMVCgXzWraZNEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PxcJsTtc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435AmO2I006512;
	Fri, 5 Apr 2024 11:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SDAabO8gn5di0giN8zcTGrQbYAhA5+USYJnh7uYKzLw=; b=Px
	cJsTtcQIp5fTVa7qqXJjItqRTOlY7R4rYTBAFbFOT6hSYwmrGoq3Fyrcx87cC4EX
	vTKkc3vW1jk3S2WaU3vftlptSuZ0ydNqBDnL0aDByaqGJwsf7bFaAmhll4HOVBKn
	fMSWDLTBm5KCIe/aK5jFV6+StrGG73ZvW52fJ1vCKujtznHMmdgZ17olcfU7BItO
	DIjAkxN8EvG4IThaYhj8J1F8C6ypPkhDduR0b7p+UbKMFrguK59LxklOOVGwK0/W
	J2d6y34ruqygzruL+DHaaOuIi8JCgEktvsWqLYUFG3vs3iz7zGwJSLC/u6bxiyWn
	GW5++xoV2euWN+NGdZzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9v8jjhsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 11:22:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435BMmp1000993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 11:22:48 GMT
Received: from [10.214.67.128] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 04:22:44 -0700
Message-ID: <7c616ed5-fd80-7afc-a881-9f21e85ea6b6@quicinc.com>
Date: Fri, 5 Apr 2024 16:52:40 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: qcs6490-rb3gen2: Enable various
 remoteprocs
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_tsoni@quicinc.com>
References: <20240402090349.30172-1-quic_kbajaj@quicinc.com>
 <20240402090349.30172-3-quic_kbajaj@quicinc.com>
 <Zg9nmVl9eqTbkkDe@hu-bjorande-lv.qualcomm.com>
From: Komal Bajaj <quic_kbajaj@quicinc.com>
In-Reply-To: <Zg9nmVl9eqTbkkDe@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oukBI9rZ0PY-4A628WA1Qm1_KbBesS-X
X-Proofpoint-ORIG-GUID: oukBI9rZ0PY-4A628WA1Qm1_KbBesS-X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=941 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050081



On 4/5/2024 8:23 AM, Bjorn Andersson wrote:
> On Tue, Apr 02, 2024 at 02:33:49PM +0530, Komal Bajaj wrote:
>> Enable the ADSP, CDSP and WPSS that are found on qcs6490-rb3gen2.
>>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> index 97824c769ba3..a25431ddf922 100644
>> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
>> @@ -434,6 +434,21 @@ &qupv3_id_0 {
>>   	status = "okay";
>>   };
>>
>> +&remoteproc_adsp {
>> +	firmware-name = "qcom/qcm6490/adsp.mbn";
> 
> Should this be qcm6490?
>  >
> I already proposed a patch to add adsp and cdsp, using qcs6490, and this
> was merged earlier this week. Please pay attention and review patches
> posted on the public list.

Apologies, I missed that.
Will drop adsp and cdsp firmware path update in the next series.

Rebase this change on top of your change, also will add the firmware 
path update for modem for GPS usecase.

Thanks
Komal

> 
> Either way, this will now have to be rebased on linux-next.
> 
> Thanks,
> Bjorn
> 
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/qcm6490/cdsp.mbn";
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_wpss {
>> +	firmware-name = "qcom/qcm6490/wpss.mbn";
>> +	status = "okay";
>> +};
>> +
>>   &tlmm {
>>   	gpio-reserved-ranges = <32 2>, /* ADSP */
>>   			       <48 4>; /* NFC */
>> --
>> 2.42.0
>>

