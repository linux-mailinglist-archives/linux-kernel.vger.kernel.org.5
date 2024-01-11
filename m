Return-Path: <linux-kernel+bounces-23859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C288082B2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A6289373
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970A050255;
	Thu, 11 Jan 2024 16:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ppfd7wav"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4220C50245
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BEsRr0030404;
	Thu, 11 Jan 2024 16:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=yvEoKVrxCx84Qso2ZKN68nnOcsKKBjWqodWTF4MPK2Y=;
 b=Ppfd7wav0FWB0+C05oE/+mZBq6q/VsxjP8wCJOGitOhvDYAAtJZSBZZEzj5sQfZMcuPJ
 zPyc0td38+BO9hcWGT7hJ7VIp7NerKEbo/i2oiaAxp3DwvRgCf7kwLVBIZq53F6BXOnB
 aRW0+JKpsgAodCSroB+tiX90OiBw6ReTwgbYbt5d1mEXBQWyO/cjN/qG8ftyicNKShwE
 PIQQ7NOuolKYJDawchgEQDuIZ1I4t9HynPGVnTi8mz8Kcw205QuMoofOgHyiilyl0RU8
 8qS9MZFdWmF/WdOe15IGsMjBXP70/R3Jor5BqhKiN5hLWlmvx13/js2Ff60CIvs9voGi 0w== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjjghap60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:23:32 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BDjbfp026992;
	Thu, 11 Jan 2024 16:23:31 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2c1x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:23:31 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BGNU1a17564308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 16:23:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FD5158068;
	Thu, 11 Jan 2024 16:23:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36C6458062;
	Thu, 11 Jan 2024 16:23:30 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 16:23:30 +0000 (GMT)
Message-ID: <c5a4cde9-cc30-48f7-8da0-7c0e71d7d2aa@linux.ibm.com>
Date: Thu, 11 Jan 2024 10:23:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] soc/aspeed: Add host side BMC device driver
Content-Language: en-US
To: Ninad Palsule <ninad@linux.vnet.ibm.com>, Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@aj.id.au, eajames@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org
References: <20230821183525.3427144-1-ninad@linux.ibm.com>
 <20230821183525.3427144-2-ninad@linux.ibm.com>
 <5159abb8-1b4c-4576-b370-4dd9db142beb@lunn.ch>
 <6cea8ee7-f845-6ef3-631f-3f252ff5e949@linux.vnet.ibm.com>
 <5c918888-6933-7661-45f0-32ae4521aa2c@linux.vnet.ibm.com>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <5c918888-6933-7661-45f0-32ae4521aa2c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AVbA9MnxxCVVkGqCoodM0HqcSyFelbg7
X-Proofpoint-ORIG-GUID: AVbA9MnxxCVVkGqCoodM0HqcSyFelbg7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401110128

Hello Andrew,

On 8/23/23 12:32, Ninad Palsule wrote:
> Hello Andrew,
>
> On 8/22/23 11:14 AM, Ninad Palsule wrote:
>> Hello Andrew,
>>
>> Thanks for the review.
>>
>> On 8/21/23 2:29 PM, Andrew Lunn wrote:
>>>> Testing:
>>>>    - This is tested on IBM rainier system with BMC. It requires BMC 
>>>> side
>>>>      BMC device driver which is available in the ASPEED's 5.15 SDK
>>>>      kernel.
>>> How relevant is that? To the host side, it just appears to be an
>>> 16550A. Is the SDK emulating an 16550A? If you where to use a
>>> different kernel, is it still guaranteed to be an 16550A? I also
>>> notice there is a mainline
>>> drivers/tty/serial/8250/8250_aspeed_vuart.c. Could that be used on the
>>> BMC? That would be a better testing target than the vendor kernel.
>>
>> This is just to indicate how I tested my code.
>>
>> Yes, aspeed chip (in this case ast2600) is compatible with 16550 UART.
>>
>> I am guessing it should work with different kernel too as 16550 
>> standard is used.
>>
>> The 8250_aspeed_vuart.c is a BMC side driver for accessing VUART over 
>> LPC bus and
>>
>> this is a host side driver to access VUART over PCIe bus.
>>
>>>> +config ASPEED_HOST_BMC_DEV
>>>> +    bool "ASPEED SoC Host BMC device driver"
>>>> +    default ARCH_ASPEED
>>>> +    select SOC_BUS
>>>> +    default ARCH_ASPEED
>>> same default twice?
>> Removed.
>>
>>>> +late_initcall(aspeed_host_bmc_device_init);
>>>> +module_exit(aspeed_host_bmc_device_exit);
>>> It looks like you can use module_pci_driver() ?
>> yes, It should work unless the late initcall is important. I will 
>> test it and see.
>
> I will not be able to use module_pci_driver() as it doesn't support 
> late initcall which is required otherwise
>
> 8250 registration fails. So I am not making this change.

Please let me know if you are fine with this.

Thanks for the review.

Regards,

Ninad


