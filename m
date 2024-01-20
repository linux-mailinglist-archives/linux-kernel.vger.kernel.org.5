Return-Path: <linux-kernel+bounces-31639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CF68331BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 01:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615A8284D01
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D845D39C;
	Sat, 20 Jan 2024 00:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="js/hoM1E"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A02170;
	Sat, 20 Jan 2024 00:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705709532; cv=none; b=EfSqjcpLefn+zneokLT07HOrNr4Jlxdm3gITZVHhbvmK+ufpTJFiPJHfQ6rU8lEFxmfyLmUM1Cd29GhWFVTInwwLiyC9IJAdIR6hcziTUwyeY5BSTVa7/KXhKDYzZoNUzQnuhV17L4k57mwcaIobfbNE/fPsNRNTRNUBJqIRVFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705709532; c=relaxed/simple;
	bh=t2YKQSRZhMvKZWSEbQfEKkLCPogfqfSRvplfZIxNilc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rWd9zc90LThdn5GcwweVwfR4sRtRWNrK0T9MYbJVpc/AFYuEr4rNBw7aFfxLl/xcBea55bLOgsRmRspnrShYsWxqCZEcDRwkgu2jDNmR0zPJjTdruvb1BJ+BM/y7CPyCjpOczumO51dF6HJREg83mta8udlFdRDxUybJ3JqzgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=js/hoM1E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40K05ma2031619;
	Sat, 20 Jan 2024 00:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=FrqUNUAdbZExbZI/fVfv3yWEUzNTR44642+Bc6d0vy8=;
 b=js/hoM1E9NebuvFXZzPifYspl2Ik1AvIkmIk3Vmy6wThRf893PMd3sepPwGevPkAY6pe
 Djs2DZRZPpUH72oUoi+MwKWWsxiiMC1KVEa6ZMBD9OtskAUMsKU9jK3GjhUlKrh0UFiX
 +RqHGy6YzQnFFSIeQbUB2Mlw57JeG5xHdd2Z2wi0MPWQn5jvaA4+NwywarAE/Mk45vzP
 Pw9DOPbXZLg+uCRU5oLZ79cRialQXA0rDU+gVZFUdBkYMIyajVbk226q2IQM8p//FjcC
 YBuoSPmUm7bZxnNh9M4U9/9oqAJkj1AYrdLDtGozHPPRn4RhVdn1HQoC0dDpib265z5G VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vr2wv8gnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 00:11:10 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40K072BR003156;
	Sat, 20 Jan 2024 00:11:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vr2wv8gjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 00:11:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40JKgAW1000441;
	Sat, 20 Jan 2024 00:06:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm4utcpkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jan 2024 00:06:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40K06BbH18809420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jan 2024 00:06:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A7D058056;
	Sat, 20 Jan 2024 00:06:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB8B95803F;
	Sat, 20 Jan 2024 00:06:08 +0000 (GMT)
Received: from [9.61.126.81] (unknown [9.61.126.81])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 20 Jan 2024 00:06:08 +0000 (GMT)
Message-ID: <baeb57e5-a13e-41b3-b74c-76d1a5442821@linux.ibm.com>
Date: Fri, 19 Jan 2024 18:06:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: Add DPS310 as trivial device
To: Rob Herring <robh@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
        jarkko@kernel.org, tony.luck@intel.com, jgg@ziepe.ca,
        naresh.solanki@9elements.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        bhelgaas@google.com, geert+renesas@glider.be, vincent@vtremblay.dev,
        keescook@chromium.org, peterhuewe@gmx.de, robh+dt@kernel.org,
        joel@jms.id.au, patrick.rudolph@9elements.com,
        peteryin.openbmc@gmail.com, luca.ceresoli@bootlin.com,
        andrew@codeconstruct.com.au, andre.werner@systec-electronic.com,
        conor+dt@kernel.org, linux@roeck-us.net, geissonator@yahoo.com,
        johannes.holland@infineon.com, broonie@kernel.org,
        devicetree@vger.kernel.org, gpiccoli@igalia.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        linux-hardening@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240116183734.3944028-1-ninad@linux.ibm.com>
 <20240116183734.3944028-3-ninad@linux.ibm.com>
 <170569701502.1007352.2755613869226739924.robh@kernel.org>
Content-Language: en-US
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <170569701502.1007352.2755613869226739924.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pwdJZ3JYFnkVn8MihU2LwPzvf_aNPGk-
X-Proofpoint-GUID: vIj4mehuiT57tTptbXl5KJvHXJGn-UtM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_12,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401190150

Hello Rob,
Thank you!

On 1/19/24 14:43, Rob Herring wrote:
> On Tue, 16 Jan 2024 12:37:33 -0600, Ninad Palsule wrote:
>> Infineon DPS310 is a barometric pressure and temperature sensor.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> Applied, thanks!
>

