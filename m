Return-Path: <linux-kernel+bounces-21536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496038290E5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E71C248BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89743E486;
	Tue,  9 Jan 2024 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pOdUdYW8"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A618D322B;
	Tue,  9 Jan 2024 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409NMimc018171;
	Tue, 9 Jan 2024 23:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YroQre9O4C8ma+wtdWOu5rcN3Uuco8nK9qLhogwQT7E=;
 b=pOdUdYW8LTr5pNPicdzTJ8uFoVleDhyN9m5xPRF/jP9fNeAJ1GSLnmeo2zpfuDhvcXy+
 azPWPQLvJTbtNRi2Z8Fhdj+Y8F5oLvKPUpRKnStzuKcaHtTgXObDaWDLelwbCuYZBKR1
 26qOsBDM/PnNQxmM3p53ol1n/M3Ezhq13C+kPoZlUVaq1IjGzQBwBku0SlWtKGoX5ZvV
 gpk794rpmrV5eTngciRxth7zXgH03qmIi+H+r0dHIjNpzJD7AhuBI1GbXdCPwrchgUnZ
 DThdBMQHY1PCKCE5FMoBSmoMo5DwTiO+SvJIk27VbAV+f8RuHh4n6Y7+OXC/9N9inNRW ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhfrtr9e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 23:36:09 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409NSfab031576;
	Tue, 9 Jan 2024 23:36:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vhfrtr9de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 23:36:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 409LvUAi022793;
	Tue, 9 Jan 2024 23:36:07 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfhjyj0r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 23:36:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 409Na74f12452600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 23:36:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DFB258056;
	Tue,  9 Jan 2024 23:36:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 356CB5805D;
	Tue,  9 Jan 2024 23:36:06 +0000 (GMT)
Received: from [9.61.145.235] (unknown [9.61.145.235])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jan 2024 23:36:06 +0000 (GMT)
Message-ID: <aeabec28-a3a8-4ce1-b95b-a548cd27d626@linux.ibm.com>
Date: Tue, 9 Jan 2024 17:36:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] ARM: dts: aspeed: System1: IBM system1 BMC board
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net,
        andre.werner@systec-electronic.com,
        Andrew Geissler <geissonator@yahoo.com>, patrick.rudolph@9elements.com,
        vincent@vtremblay.dev, peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
        bhelgaas@google.com, naresh.solanki@9elements.com,
        alexander.stein@ew.tq-group.com, festevam@denx.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        geert+renesas@glider.be, luca.ceresoli@bootlin.com
References: <20240108204114.1041390-1-ninad@linux.ibm.com>
 <20240108204114.1041390-4-ninad@linux.ibm.com>
 <b09d6e54-66e9-482f-8f45-38381fa6b62e@sirena.org.uk>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <b09d6e54-66e9-482f-8f45-38381fa6b62e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5rN_NU02dIQynFsCqZCTop0K698RzYDf
X-Proofpoint-GUID: VhY3YfXllaRNZKSksK6AniEH2tMu_0Oq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401090189

Hello Mark,

On 1/8/24 15:34, Mark Brown wrote:
> On Mon, Jan 08, 2024 at 02:41:14PM -0600, Ninad Palsule wrote:
>
>> +	regulator@60 {
>> +		compatible = "maxim,max8952";
>> +		reg = <0x60>;
>> +
>> +		max8952,default-mode = <0>;
>> +		max8952,dvs-mode-microvolt = <1250000>, <1200000>,
>> +						<1050000>, <950000>;
>> +		max8952,sync-freq = <0>;
>> +		max8952,ramp-speed = <0>;
>> +
>> +		regulator-name = "VR_1.0V";
>> +		regulator-min-microvolt = <770000>;
>> +		regulator-max-microvolt = <1400000>;
> A regulator labelled VR_1.0V can vary between 0.77V and 1.4V and has
> exactly the same configuration as another regulator labelled VR_1.2V?
> That seems...  odd?

That was a typo. I fixed it.

Thanks for the review.

Regards,

Ninad


