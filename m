Return-Path: <linux-kernel+bounces-22362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD79829CA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778011F230B7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284824B5C3;
	Wed, 10 Jan 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o2g8JTUT"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6224BA86;
	Wed, 10 Jan 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ADOIUx009655;
	Wed, 10 Jan 2024 14:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=eRKw5TvoHiPyQ/uMjZkop2dj1ccGWuRaQv9PKmpKVlw=;
 b=o2g8JTUTAyghaq6puEaplfoMuLgz7WhvcUeb2jDH+0QwDfMWPOmT2Sk60UsdqGeqF0tc
 1VkQAMPnpPxDBfacT+nBzwUcxGBAPqE2uVFjrxiJjFuRZdFl2Aeom9Zx0zIjynvw9XTm
 0Bbw6tBwnqL8dp5YhBO6NQRkn/dVOJX6MS5WTUcuSR2zQAYR5WdD0cscftNvjIkUlGLe
 hkjLQOTnrQUyH/RgsTsQJ7yud4Wd+eYOH9xLY5DmzLy1tb6BEyBbxQ/He3HOSZKdGTk3
 /T4HLcu8OUD2Y37hpu8hNyN65WfigCCjObVO/BHo1GXlnPM/URzKpeVWbWE3NGdBYL6R YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhttkv3ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 14:31:25 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AEPoWT003422;
	Wed, 10 Jan 2024 14:31:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhttkv38h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 14:31:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40ADDYZE000902;
	Wed, 10 Jan 2024 14:31:07 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkdkdawm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 14:31:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40AEV63c24773186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jan 2024 14:31:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B05B05803F;
	Wed, 10 Jan 2024 14:31:06 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBAF258063;
	Wed, 10 Jan 2024 14:31:05 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jan 2024 14:31:05 +0000 (GMT)
Message-ID: <2dd37d2b-28da-4e73-9047-61ec5d64bdb5@linux.ibm.com>
Date: Wed, 10 Jan 2024 08:31:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes.holland@infineon.com, broonie@kernel.org,
        patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
 <20231212-mouth-choice-40a83caa34ec@spud>
 <2946fbb1-2a47-4d21-83dc-8e45bf6ba5a9@roeck-us.net>
 <60c8bbdb-4e08-44f0-88d4-ab164d4843b5@linux.ibm.com>
 <20240109-pep-coerce-2a86ae88753d@spud>
 <01974929-dfbf-4989-ba39-369e521827d0@linux.ibm.com>
 <3d194e84-bf1a-48e4-a376-e5c327c6508d@linaro.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <3d194e84-bf1a-48e4-a376-e5c327c6508d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jA44_2QH4Y4-dwtIoZ0QyTBP3AArg-3E
X-Proofpoint-ORIG-GUID: kvD9Pbj-qjIURh1_JHB9jqK_xXX28IpA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_06,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401100119

Hello Krzysztof,



>>>> I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad@linux.ibm.com/
>>> Why did you do that? It now just adds undocumented compatibles to the
>>> driver. Please, as Rob requested, work with Lukas on his series to make
>>> sure that these devices are documented.
>> I think krzysztof kozlowski suggested to send these patches separately:
>> https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f564d1c83f@linaro.org/
>>
>> Did I misunderstood it? Do you guys want me to include that commit again?
> My comment was in DTS thread under specific DTS patch. How did you
> figure out it applies to driver and bindings? This does not make sense.

Sorry for the misunderstanding. Where do you want me to add driver 
patch? Before all DTS patches or after all DTS patches?

tpm: tis-i2c: Add more compatible strings
ARM: dts: aspeed: System1: IBM system1 BMC board
dt-bindings: Add DPS310 as trivial device
dt-bindings: arm: aspeed: add IBM system1-bmc

OR

ARM: dts: aspeed: System1: IBM system1 BMC board
dt-bindings: Add DPS310 as trivial device
dt-bindings: arm: aspeed: add IBM system1-bmc

tpm: tis-i2c: Add more compatible strings

Thanks & Regards,

Ninad Palsule


