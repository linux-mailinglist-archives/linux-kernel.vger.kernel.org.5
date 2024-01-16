Return-Path: <linux-kernel+bounces-27634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D982F36B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725B11F233A1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C26D1CD0C;
	Tue, 16 Jan 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pwtea/BH"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E017E1CD03;
	Tue, 16 Jan 2024 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427072; cv=none; b=OCJx3MGRFJkOolwyEsuGw6TlJW0SNiLz9CeOfDBAwi0KF9sn6Tq/lK9YM2N0dlo8JW0qolAlt5kwl68R0wWuviSN9NjwJteuGUwKXyiKN3oBn7eBHsOriNfUpLV3v0sqFgty1wS9EvkIHb6gtOT4wi2vGl2uSjCXTsbUsWfkZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427072; c=relaxed/simple;
	bh=8ZQSUM5HHyNNwWiT3KNnANcyU223j6kAUF5U/zEq3eE=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:
	 In-Reply-To:Content-Type:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:Content-Transfer-Encoding:
	 X-Proofpoint-UnRewURL:MIME-Version:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=gx+0f9WJZz8baZlYkAtgQvBa24shWdUioaRxoVUnHhHGQx0woH5PAdrIdZW8CO6Gd7xXAGrEVazQAQ7xLQPBUnwHwENyDf5XHCbLOkY4n9yUZeV2g0hoFr0VbfoyweIcYEWuj01mCqs7A+7hcmpP83sG1AA4CoMajAUe/xOxveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pwtea/BH; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40GHauhh021964;
	Tue, 16 Jan 2024 17:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=zvksaMNtL6Ps/tgLmmbcPa9+3ibbYYEzNDam56TV9u8=;
 b=Pwtea/BHdFspXSIpzVV4rPzuU8QeAUxNTMxrjNzg7p6hOIojeKqh4k28DoAFCTcCuhDe
 OzwmPR5Kchzs4QsbJW/sPorLJJXv1Vcw4jWbepnVzcM5P07C3jQJrdAHAjd/uCcy2CI+
 i1dBSMwsmVMGAmr/swPdstTuPkIjOOnyflUAAGtvfOk+VrytwphJjR06Mc4TkwyFd7Qn
 9OhPw/sX8MftndEpl6a7hDm09CIG34ePeBHMyr4nv32hn4w4EAzJMJJgyFW4dap9HaPB
 g7QzoK7ilKS66xkTxletj7RL7lVXs3EhHGGl1bZjROXBQqdDZ5p3jLvvl6dxVhZydU79 pg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnwm61p3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 17:44:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GHC5rZ004365;
	Tue, 16 Jan 2024 17:44:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnwm61p31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 17:44:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40GGSUCR011053;
	Tue, 16 Jan 2024 17:44:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57yg81m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 17:44:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40GHiKKk25297546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jan 2024 17:44:20 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF11B58060;
	Tue, 16 Jan 2024 17:44:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 685F058051;
	Tue, 16 Jan 2024 17:44:20 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jan 2024 17:44:20 +0000 (GMT)
Message-ID: <9a3d26a5-acfc-443a-911c-80f2ef6ba946@linux.ibm.com>
Date: Tue, 16 Jan 2024 11:44:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] tpm: tis-i2c: Add more compatible strings
To: Conor Dooley <conor@kernel.org>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        Joel Stanley <joel@jms.id.au>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
References: <20231214144954.3833998-1-ninad@linux.ibm.com>
 <20231214144954.3833998-2-ninad@linux.ibm.com>
 <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
 <77fe0ccd-53ff-4773-9787-0d038434297f@linux.ibm.com>
 <20240112-unrevised-wafer-649c0ebffda5@spud>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20240112-unrevised-wafer-649c0ebffda5@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IARhOqyUtolwKtH3lyayBaHxU5ltsstz
X-Proofpoint-ORIG-GUID: gxD_H4TXGT-l9LAEmD7DpCZS8UHWw7kS
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
 definitions=2024-01-16_10,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160139

Hello Conor,

On 1/12/24 11:24, Conor Dooley wrote:
> On Thu, Jan 11, 2024 at 10:43:08AM -0600, Ninad Palsule wrote:
>> Hello Conor,
>>
>> On 1/9/24 11:11, Conor Dooley wrote:
>>> On Thu, Dec 14, 2023 at 08:49:53AM -0600, Ninad Palsule wrote:
>>>> From: Joel Stanley <joel@jms.id.au>
>>>>
>>>> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>>>>
>>>> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
>>>>
>>>> Add a compatible string for it, and the generic compatible.
>>>>
>>>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>>>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
>>>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>>> I don't understand why you broke this series up and dropped patches.
>>> NAK, these compatibles are not documented.
>>>
>> The original series has three patches:
>>
>> 1) Adding compatibility string which I am adding in this series.
>>
>> 2) Adding schema for the TIS I2c devices which is already covered by Lukas's
>> patch (already merged in linux-next) https://lore.kernel.org/all/3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de/
>>
>> 3) Removing "Infineon,slb9673" from trivial-devices.yaml which is not done
>> as it is already added in the TPM specific file. I will add it in my patch.
>> Good catch!
> Dropping this should be a standalone patch (with a Fixes tag I suppose).
>
> Looking at what got merged:
>        - description: Generic TPM 2.0 chips conforming to TCG PTP interface
>          items:
>            - enum:
>                - infineon,slb9673
>                - nuvoton,npct75x
>            - const: tcg,tpm-tis-i2c
>
> There's no need to add "nuvoton,npct75x" to this driver, since a
> fallback to tcg,tpm-tis-i2c is required by the binding. Adding the
> generic compatible however makes sense.
>
> If there's a good reason to add it (like existing QEMU releases that do
> not have the generic compatible, but claim to have the npct75x) then
> please note why we should make an exception in your commit message.
>
> You need not carry the NAK, the motivation behind patch is fine.

Make sense. As there is no specific code for npct75x in the driver, I 
will remove it.

Thanks for the review.

Regards,

Ninad


