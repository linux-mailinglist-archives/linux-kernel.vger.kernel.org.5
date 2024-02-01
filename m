Return-Path: <linux-kernel+bounces-47659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDB8450DE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72251C23CB6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D088B762D6;
	Thu,  1 Feb 2024 05:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pVj0alU+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E34612F0;
	Thu,  1 Feb 2024 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706766305; cv=none; b=WZ9ZBdrhGJINAXJtZOMhFJSr30RHSRTBDXDCSZ/poskSoZd2kyf5RHojBbB2qxGDKO9dIC5XewarcYl2Q4SkeEYXsobfckzwFvCYkATyIW1HAotyCOLqgVVdyGPVd9kJVe7fsbkmB9miBg0nCVhxUCnhIhR9amT93nFnCcRLGZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706766305; c=relaxed/simple;
	bh=AWWRbwMJsJOhUP71zZ4HmkdRC56JvXUNkwK4Ol4y5eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LtjZcKbw/ufwPskbm1XlDKmKIlVXGSQfObRQCZ+R/UlNQBhsU1vfRY7A8pCrW7rW56rRoCXNFywUNfNSDZH4GXeiwyl+AKCdUJPi4G7CuDtaAABUs9JLkPg4+m1B+QI8klNQoBJG/plbHqepkKRwOfOBTp1uZqtxUz5erOGf9HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pVj0alU+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4114EfYE014251;
	Thu, 1 Feb 2024 05:44:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tMSddtjC0Q3n3JIZVZR+PNnRJQw2W6AVaffevhy+KHc=; b=pV
	j0alU+gqGiBWSW/R/J/CGPb6MXpuAfpWKiFzKc6h7I4js+QLeJbTGkXFzwpydY2S
	yGaELXxrdEAOkPi6PPk0pN7d5Qs5y3DTYTrIGyUmLJO580qBrMRao5678kGH0G9q
	jFQAgRETDSXl6aos/6iaOZ7U9FJGD5aPYVQqb5L3onZJ7F0m4Kwp/DitqoS6W29l
	oK5unXwxleBWCi9FItiVSpmsUBYIK61iRBL5v1lR+B4wEgQxfQFnRBnSsrGiQFI7
	wJu2OduOYxpvhBPH/CK3iBhSJWdKzaY/YGVIiAK+gvIKsKe7lZJMVHhFoRFIG+Bh
	a8ynbaVB0dxWyhskI9qQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w03hh862k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 05:44:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4115ismN012685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 05:44:54 GMT
Received: from [10.216.36.102] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 21:44:51 -0800
Message-ID: <06ac82ec-3a13-47cc-bd94-b664430b7a2c@quicinc.com>
Date: Thu, 1 Feb 2024 11:14:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: ncm: Avoid dropping datagrams of properly
 parsed NTBs
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hardik Gajjar
	<hgajjar@de.adit-jv.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20240131150332.1326523-1-quic_kriskura@quicinc.com>
 <CANP3RGeHXmEcDN=-h1uGBzu_Ur2UcmiEuFDXAEr0Z2ptXnHq=Q@mail.gmail.com>
 <47bf719c-a5c1-473b-9fa0-8cad84f0721c@quicinc.com>
 <CANP3RGf8=3OwCDnE8UT8PQNRwQrtLO97_yR+Vm0h12Q3anbtVA@mail.gmail.com>
Content-Language: en-US
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGf8=3OwCDnE8UT8PQNRwQrtLO97_yR+Vm0h12Q3anbtVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0D0f3J-K6FjmIh3FxKj3Bd4i8zoZOHpm
X-Proofpoint-ORIG-GUID: 0D0f3J-K6FjmIh3FxKj3Bd4i8zoZOHpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=302 bulkscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010044



On 2/1/2024 12:24 AM, Maciej Żenczykowski wrote:

> 
> I believe so, yes.
> 
> I believe they are trying to avoid having to send ZLPs.
> That's determined *purely* by the size of things as they show up on
> the usb cable (ie. the size of the usb xfer).
> ie. that's where things that are a multiple of 512 (USB2) or 1024
> (USB3) need an extra 0 byte sized packet to prevent ZLP.
> 
> The actual size of the NTB doesn't matter.
> 
> That said... maybe we're overcomplicating this...
> Maybe it's enough to just remove this modulo check entirely (I know I
> asked for it before).
> 
> Ultimately if we just do:
> 
> // Windows NCM driver avoids USB ZLPs by adding a 1-byte zero pad as needed
> if (to_process == 1 && !*(u8*)(ntb_ptr + block_len)) --to_process;
> 
> it'll fix the problem too, and perhaps be easier to understand?
> 
I agree. This will simplify the check and also cover all cases.
To keep diff minimal from tested version (because issue comes up easily 
with a particular test here), I can remove the second check in the if 
block in the v2 and push it as v3.

Regards,
Krishna,

