Return-Path: <linux-kernel+bounces-36003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EE88399F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E641C2781D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B50182D92;
	Tue, 23 Jan 2024 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UxL+L9NL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAEE63511;
	Tue, 23 Jan 2024 20:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040371; cv=none; b=cZ/PrgUupvO1pNmarddrkkYKb70mkQXcbEr9GmfGhbHy2nu5QZrwCpSur/f3+aZAdMjnsby0i3R25Db2Z0xwj+vex1IGlmvf3efxooNuF9znIH7PTCw5huaFTj9AT3oEOhM0to1Nd8fUQ3oqntO72aZg1VsZkX33O4vzskitG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040371; c=relaxed/simple;
	bh=GzhJCzJzKpc9xeFhTpsdwMvee7CM5aTLill6q4USv3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nNgJFY8pYQz6l4ko0JKZD3FJAdN9fhcX/lWv6sOp50QtlENpWQFLUZFjJzcTRw3L1jmm0+HqJx3cuRWHqWFmHODhYbJND0Ndr/1dn16kOA0x+sSPjxGC/BIsal7c7ArZTm5lIyKgl5tKfrseSOLvP1nWYdns9qRCo90Ed/u+M2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UxL+L9NL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40NGPRR5029341;
	Tue, 23 Jan 2024 20:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hUYsYhKG8zh/NNdalZUM0dorkIoNrzpo0eGcmzdbCH4=; b=Ux
	L+L9NL7W3fcIBkONqHWLOW36dZTeWbd+HPbi4EFcKAV6JZr41W7+xaANSML/P/cb
	9G7Qw+65VseuGMlWiNptOiO9ViqhfdjEBRyeDNfN7vF/+AiTtDh/PkV7Ep0onY50
	6vb3yAz1BmjO8J4hOvuLsmAMEqostsCsyXR4ndGZ/lDme8zDforBZnF6Pkja2E7O
	eYB8L0A4tOHPp8R7Q/5iXdMdw+25u6THmb/Ee43t+OKpbb98OhLvfmo34QllQdm/
	TlYQEa87hfYRdb5xzrl4LUBSRo31DUGGlfR8rkJD6qCyAAgPI3DGcy0d/1bmbOKI
	MEhkJsOjMX/ehg7PpstQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtesch2a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 20:06:01 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40NK60r0023727
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 20:06:00 GMT
Received: from [10.110.28.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 12:05:56 -0800
Message-ID: <fd2c8c1b-02f3-2750-3449-f93fc119fda2@quicinc.com>
Date: Tue, 23 Jan 2024 12:05:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Content-Language: en-US
To: Elliot Berman <quic_eberman@quicinc.com>,
        Amrit Anand
	<quic_amrianan@quicinc.com>
CC: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Conor Dooley
	<conor@kernel.org>, <andersson@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <6e40dd60-884f-be23-0052-d14f7194f844@quicinc.com>
 <f21bc259-45fa-d14b-a556-625b813287f4@quicinc.com>
 <499320f4-f6b1-4582-9512-89ab505305b6@linaro.org>
 <20240123-sterilize-flap-8971aa3bad4b@spud>
 <1941558d-d1e0-43b7-9208-65b9ba191bc2@quicinc.com>
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <1941558d-d1e0-43b7-9208-65b9ba191bc2@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Tbf2azYCNSayz4Q5wH74QmTAEgBJ7PpC
X-Proofpoint-ORIG-GUID: Tbf2azYCNSayz4Q5wH74QmTAEgBJ7PpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_11,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=892
 impostorscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230148

On 1/23/2024 10:51 AM, Elliot Berman wrote:
> 
> 
> On 1/23/2024 9:18 AM, Conor Dooley wrote:
>> On Tue, Jan 23, 2024 at 12:50:07PM +0100, Krzysztof Kozlowski wrote:
>>> On 22/01/2024 11:10, Amrit Anand wrote:
>>>>
>>>> On 1/21/2024 12:40 AM, Trilok Soni wrote:
>>>>> On 1/20/2024 3:20 AM, Amrit Anand wrote:
>>>>>> From: Elliot Berman <quic_eberman@quicinc.com>
>>>>>>
>>>>>> Device manufacturers frequently ship multiple boards or SKUs under a
>>>>>> single software package. These software packages will ship multiple
>>>>>> devicetree blobs and require some mechanism to pick the correct DTB for
>>>>>> the board the software package was deployed. Introduce a common
>>>>>> definition for adding board identifiers to device trees. board-id
>>>>>> provides a mechanism for bootloaders to select the appropriate DTB which
>>>>>> is vendor/OEM-agnostic.
>>>>> Please extend CC list to more architectures? linux-arm-kernel, risc-v etc; since
>>>>> the proposal below is not specific to ARM but any architecture is using the
>>>>> devicetree.
>>>> Wouldn't devicetree@vger.kernel.org will have concern folks from all the 
>>>> architectures?
>>>> Please correct me.
>>>
>>> No.
>>
>> The chromium guys should get a CC on future versions of this stuff,
>> since they like doing wacky things with compatible strings in their
>> bootloader and this problem is one they also face. Doug Anderson and the
>> mediatek chromebook folks would be a good start.
>>
> 
> Please CC Peter Griffin from Linaro as he helped restart this 
> discussion at Plumbers.
> 
> Peter Griffin <peter.griffin@linaro.org>
> 
> Also, for the oneplus boards:
> Caleb Connolly <caleb.connolly@linaro.org>

Thank you everyone. Amrit - please take care of above comments
when you post next revision and as suggested please add other
architecture mailing lists using the devicetree. Thank you. 

-- 
---Trilok Soni


