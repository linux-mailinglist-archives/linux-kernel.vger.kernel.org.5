Return-Path: <linux-kernel+bounces-23962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B499B82B486
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B2E8284438
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC68537F5;
	Thu, 11 Jan 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HxdKXFpd"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2037652F7B;
	Thu, 11 Jan 2024 18:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BHcXWM030596;
	Thu, 11 Jan 2024 18:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EO3J9A6TroCBSWwiiGnlVOrch5ftdo4Wu2ZAYo+fcUk=;
 b=HxdKXFpdlqUOQRMHMptzjr5RPR41La1ViQaQXWhZNmb/B/N18udSfIFMFkT6M1Ktu+KY
 GF9B0cdwFN3ejWP+QpX3Ms90qwiQoNhi1Dd/hwR7YzQ7blEbdlWSTtlGt5cfiipvaGeD
 D6phIWWjLUaGcWSQvY5XpezwjxNSJgWD1HdxnLmf0XUTqq23jh3oXAFh3m+UO41kZMPx
 8Flhx6RjNw3q+b1n5ZQlSd3TLH17g3ovEyZanDnnVwqXc9P9igLARUGIJQ7xJRzFttSF
 PwmYIahhEk0R4aHJv13gtxK0RMJ9tyoLj5wN2ojRNSrsioz+QV3pvJSz3keCZTSDn3yN Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjmwh0yt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:09:44 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40BHdWMt000491;
	Thu, 11 Jan 2024 18:09:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjmwh0ysu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:09:44 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40BGBmnJ027253;
	Thu, 11 Jan 2024 18:09:43 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2cps8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:09:43 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40BI9gN715532638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jan 2024 18:09:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48A0C5805A;
	Thu, 11 Jan 2024 18:09:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F06258064;
	Thu, 11 Jan 2024 18:09:42 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jan 2024 18:09:42 +0000 (GMT)
Message-ID: <70838bd2-8b03-4003-86f5-50a635ae31ec@linux.ibm.com>
Date: Thu, 11 Jan 2024 12:09:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] tpm: tis-i2c: Add more compatible strings
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        Joel Stanley <joel@jms.id.au>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ninad Palsule <ninad@linux.vnet.ibm.com>
References: <20231214144954.3833998-1-ninad@linux.ibm.com>
 <20231214144954.3833998-2-ninad@linux.ibm.com>
 <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <20240109-saddling-nintendo-c7fbb46bb0dd@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uuvxTt3KtfKDFwLlGQhoor5IRYlDO1V2
X-Proofpoint-ORIG-GUID: HfjQtr4LDqAAdNKAYr1YyqQ97IZh4rcz
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
 definitions=2024-01-11_09,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401110142

Hello Conor,

On 1/9/24 11:11, Conor Dooley wrote:
> On Thu, Dec 14, 2023 at 08:49:53AM -0600, Ninad Palsule wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>>
>> https://www.nuvoton.com/products/cloud-computing/security/trusted-platform-module-tpm/
>>
>> Add a compatible string for it, and the generic compatible.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> I don't understand why you broke this series up and dropped patches.
> NAK, these compatibles are not documented.

I have reconfirmed and other two patches are already dropped and merged 
by Lukas:

https://lore.kernel.org/all/3f56f0a2bb90697a23e83583a21684b75dc7eea2.1701093036.git.lukas@wunner.de/

This is the only one pending from that series. Please let me know if I 
need to do anything else for this patch series.

Regards,

Ninad

>
>

