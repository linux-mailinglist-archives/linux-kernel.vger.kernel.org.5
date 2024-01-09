Return-Path: <linux-kernel+bounces-21553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC0829112
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BC1F26409
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30733EA74;
	Tue,  9 Jan 2024 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZpfH1gCD"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ED53E49A;
	Tue,  9 Jan 2024 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409NgGId025342;
	Tue, 9 Jan 2024 23:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=coUqhojDtCV+5O9qYrOFzPaaw+yGNGV3C/Tk6YzwbEk=;
 b=ZpfH1gCDhl18K1vnq7dBH8+NvpklpA4kdXEbayxSsvfy5q3uPKm8ybb7b8fnalMD9cpP
 uKM4xajmkEVv+Rf3EdaA74nLP1ujzslGxM+2kNQufEoiuxNEfqNwTl57jyuX1W9V6rHZ
 HKnCXgIvfBe1/bWBK1Pt5Ek+gJVZBng8VGDhHDuY8mNRqfo1uwdemxfq8ua6VzOhpeZK
 TDc0PeTC6FI+k+QPsrnHqP1vDJxOZMqo4iTotzp4SEKbqOPDRhRJnjSuEr2U5juWqmZy
 ZDT0/jHCEJlGcyMW3GPj8LCvkt92OmiafbiZ0A9awGLWv8P/wRcE8ptS11C4CWw1lzo7 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhg21g5qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 23:55:13 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409NtCKj020726;
	Tue, 9 Jan 2024 23:55:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhg21g5pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 23:55:12 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409LfTKQ022787;
	Tue, 9 Jan 2024 23:55:10 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjyj2yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 23:55:10 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409NtABQ18023082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 23:55:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 143EA58052;
	Tue,  9 Jan 2024 23:55:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381C05805D;
	Tue,  9 Jan 2024 23:55:09 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 23:55:09 +0000 (GMT)
Message-ID: <43a9b568-69b3-4f59-9f7b-c85880a55929@linux.ibm.com>
Date: Tue, 9 Jan 2024 17:55:08 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
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
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20240109-pep-coerce-2a86ae88753d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Uf48EK8vqPqZj9oX-j3Y7eL_vKoKWJRq
X-Proofpoint-ORIG-GUID: xBvSjs4MU-BP-LVxs0ZB4SKLCJ5sCMLR
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
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401090192

Hi Conor,

On 1/9/24 11:14, Conor Dooley wrote:
> On Mon, Jan 08, 2024 at 02:05:53PM -0600, Ninad Palsule wrote:
>> Hello Guenter,
>>
>> On 12/12/23 13:50, Guenter Roeck wrote:
>>> On 12/12/23 10:51, Conor Dooley wrote:
>>>> On Tue, Dec 12, 2023 at 10:00:39AM -0800, Guenter Roeck wrote:
>>>>> On Tue, Dec 12, 2023 at 05:15:51PM +0000, Conor Dooley wrote:
>>>>>> On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
>>>>>>> From: Joel Stanley <joel@jms.id.au>
>>>>>>>
>>>>>>> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>>>>>>>
>>>>>>> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
>>>>>>>
>>>>>>>
>>>>>>> Add a compatible string for it, and the generic compatible.
>>>>>>>
>>>>>>> OpenBMC-Staging-Count: 3
>>>>>> Delete this from every patch that it appears from.
>>
>> I have send it as a separate commit. https://lore.kernel.org/linux-kernel/20231214144954.3833998-1-ninad@linux.ibm.com/
> Why did you do that? It now just adds undocumented compatibles to the
> driver. Please, as Rob requested, work with Lukas on his series to make
> sure that these devices are documented.

I think krzysztof kozlowski suggested to send these patches separately: 
https://lore.kernel.org/linux-kernel/1c5ace65-2fd8-4503-b22f-e0f564d1c83f@linaro.org/

Did I misunderstood it? Do you guys want me to include that commit again?

Regards,

Ninad

>
> Thanks,
> Conor.

