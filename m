Return-Path: <linux-kernel+bounces-37004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C2083AA19
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70AE91F227D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35177641;
	Wed, 24 Jan 2024 12:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y2Od0xPz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D766A002;
	Wed, 24 Jan 2024 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706100167; cv=none; b=Bg/qoug6bSoPDeNWNbIQ695+dETfzV3hm3NlDAqau5wON9XvKbeG/UdrLL/0Npm8/NfpYrWeXWeAurGSO9MsHCX6XssWvh6w+NVm94BVmTmOFOZn+7AQoeKPbQX36lmFyzfu1sQalQHOhcPdMu2Hc+l2VUif19mHDLH25SaWrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706100167; c=relaxed/simple;
	bh=N01sEIdXxdAZjuBvaTnGLi0tuo4RuNA8mAbpjxb83G4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K4YRgx970+yOn5mEpwYi0E+mH3OffwnGVUBOSOJ8tySCBkoJlgjMaiV/CIIDh8igSFtvmUU9GWFjeqiSPxfOwnYn5OmV6ycoiS2Grho+3GxwpH2rZuMk2w8HJCyP8IUxEkjtMRpjpEssUO6DJPJ9JOihO7BuE2gWBngV2OXDE4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y2Od0xPz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40OCagV6013961;
	Wed, 24 Jan 2024 12:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zwIMoTBgetyseescEdSkA0iCKrExxyXXP+mXbDfuKZo=; b=Y2
	Od0xPz6oB5P09zEPXET/hXhYQni14v+IUbdybwwKnAHEFrpCdMnKLlU6WuXClbsi
	RgNpvNhUkg285i6hXKIU2FBXW7Z0Bsr4MkBpQV5pejBneHyNXRUmRKcCMhJpXoiy
	0gLUcRnVIzxzVR3ebdZOJhqjA63tTDLbVSFALJIJAaBy3uqzqguMegf4n/99aHAj
	j2ZK4ruep9YUM+tZiAHQCSJus+MU+CbRWMTg2RNOc9DasKTezd3nYrSBO7BoWmNi
	3zHx+rd0YW7ngFHVZTsIF5oOZn3r/R0nJZmRw8aoJ4qjobClfKkB2anVMckRU+zP
	hFQQjRs6tIb8+heRJX9g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmhr1rx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:42:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40OCgdLm009550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 12:42:39 GMT
Received: from [10.216.58.233] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 24 Jan
 2024 04:42:32 -0800
Message-ID: <b4c27fb4-0cbf-7bad-3fc3-163fb4a5eb3f@quicinc.com>
Date: Wed, 24 Jan 2024 18:12:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: hwinfo: Introduce board-id
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <1705749649-4708-2-git-send-email-quic_amrianan@quicinc.com>
 <1fc9815e-76dd-41d7-aa1a-caa72ef4ad34@linaro.org>
From: Amrit Anand <quic_amrianan@quicinc.com>
In-Reply-To: <1fc9815e-76dd-41d7-aa1a-caa72ef4ad34@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0eY5KIcnb5mcYtI6Yy6ULcCFaiHf0Ci4
X-Proofpoint-GUID: 0eY5KIcnb5mcYtI6Yy6ULcCFaiHf0Ci4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401240091


On 1/23/2024 5:39 PM, Krzysztof Kozlowski wrote:
> On 20/01/2024 12:20, Amrit Anand wrote:
>> From: Elliot Berman <quic_eberman@quicinc.com>
>>
>
>
>> How is this better than Qualcomm's qcom,msm-id/qcom,board-id?
>> -------------------------------------------------------------
>> The selection process for devicetrees was Qualcomm-specific and not
>> useful for other devices and bootloaders that were not developed by
>> Qualcomm because a complex algorithm was used to implement. Board-ids
>> provide a matching solution that can be implemented by bootloaders
>> without introducing vendor-specific code. Qualcomm uses three
>> devicetree properties: msm-id (interchangeably: soc-id), board-id, and
>> pmic-id.  This does not scale well for use casese which use identifiers,
>> for example, to distinguish between a display panel. For a display
>> panel, an approach could be to add a new property: display-id,
>> but now	bootloaders need to be updated to also read this property. We
>> want to	avoid requiring to update bootloaders with new hardware
> Some mis-indentation in two lines above.
Sure will take care of this.
>
>> identifiers: a bootloader need only recognize the identifiers it can
>> handle.
>>
>> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>> ---
>>   .../devicetree/bindings/hwinfo/board-id.yaml       | 53 ++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwinfo/board-id.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwinfo/board-id.yaml b/Documentation/devicetree/bindings/hwinfo/board-id.yaml
> I think we should add it to dtschema, because bootloaders are using these.
Do you want us to move this file completely to the below mentioned repo 
and under which directory?
https://github.com/devicetree-org/dt-schema

>
>> new file mode 100644
>> index 0000000..82d5ff7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwinfo/board-id.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwinfo/board-id.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Board Identifier for Devicetree Selection
>> +
>> +maintainers:
>> +  - Amrit Anand <quic_amrianan@quicinc.com>
>> +  - Elliot Berman <quic_eberman@quicinc.com>
>> +
>> +description: |
> Do not need '|' unless you need to preserve formatting.
Will drop it.
>
>> +  Device manufacturers frequently ship multiple boards under a single
>> +  software package. These software packages will ship multiple devicetree
>> +  blobs and require some mechanism to pick the correct DTB for the board
>> +  the software package was deployed. board-id provides a mechanism for
>> +  bootloaders to select the appropriate DTB which is vendor/OEM-agnostic.
>> +
>> +select:
>> +  anyOf:
>> +    - required:
>> +        - 'board-id'
>> +    - required:
>> +        - 'board-id-types'
>> +    - required:
>> +        - '#board-id-cells'
> I don't fully get why do you need this select. Isn't the schema selected
> by nodename? Or maybe it is for the final required: but then this could
> be just set of dependencies.
The nodename here would be "/". So it will be applied to all the DTs, right?
Here, we wanted this to apply only if the above mentioned properties are 
present.
Do you suggest moving this to qcom,board-id.yaml and the required: as well.
So that vendor specific yaml could be applied?
>> +
>> +properties:
>> +  $nodename:
>> +    const: "/"
> Blank line.
Will add it.
>> +  board-id:
>> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
>> +    description: |
> Do not need '|' unless you need to preserve formatting.
Ack
>> +      A list of identifiers that can be used to match with this devicetree.
> s/devicetree/Devicetree/ ?
Will update
>> +      The interpretatation of each cell can be matched with the
> Typo: interpretation
Will update
>> +      board-id-type at the same index.
>> +
>> +  board-id-types:
>> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
>> +    description:
>> +      Defines the type of each cell, indicating to the DeviceTree selection
> s/DeviceTree/Devicetree/ ?
Will update
>
>> +      mechanism how to parse the board-id.
>> +
>> +  '#board-id-cells':
>   What are the cells for?
Bootloader will use this to check the number of entries in a tuple of 
board-id.
Vendors can have different logic in bootloader to specify the number
So wanted to make it flexible.

Thanks,
Amrit.

