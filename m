Return-Path: <linux-kernel+bounces-29912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB8B83150C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E297E1C222B0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807F6125D1;
	Thu, 18 Jan 2024 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="H81lwFHu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257E11C89;
	Thu, 18 Jan 2024 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705567582; cv=none; b=YbYl5Kdu9tgeNYEKrDcUY2MKO6S5pxoPW5+XN9Yq2eylSc4E8Y7IM/UGg1sd5qE0ZuhhLonhSjYDHbuveZk8i+FnD/0JPU7msrIR9wMO6CbA+ygkQ0iMLcUSOG2SmFmEirgBWn3c/6sSZUezib8/ZTtJX9zNl3nvIGfVm22jB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705567582; c=relaxed/simple;
	bh=3py4IxVUyHSKWw0EVz/Y6De2AR5tGiM/bpOlBfeFiG8=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-QCInternal:X-Proofpoint-Virus-Version:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=Fwnw0F1DCqGEAZmuBanw0/vEqKd6qrFNhrbnl/7RIRXwkNTOOiopNDNIbBaX8HQ/dHMZBHudlA1F7IURgMXpBUjIn8jGW/zKwkE1UIbOgoLiSWadUDISh3JZ+a02YAetDMVSLwBpRWvyCfF1KzVSSqSBs7vvAepAjfINpDEH7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=H81lwFHu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I6FmPk023540;
	Thu, 18 Jan 2024 08:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sIr0uxMxWHk2Z3UsG2tkbx7PQFYJUyRChndnXYqGeVc=; b=H8
	1lwFHu/A5cnfim8KRFxpmNihYiwD9thKX86unzvxpZrDbKtPqmMVSm0NOse80tjm
	x0pKr4umyVaA60yjtJ5mbCMYjui5EkhlHFJ+XqJa7S4ItdLEcJloQ0siLDrdiFcE
	+SYC4PffHKdGX3zic3vhryLnBca9UL58LshfRo1Zn4+JGeHLnvCTLZ0VPfQeo/VX
	MREHkYrJztqelKA+2GkgVb1MXtr4ygoqVy7VQcXAEJVwFp91SfZPgD1a1xBIvRa+
	I7yYBSEGU0h9QuA07+1WaTx8Xj9ORh0iOWQyDwbk7eSP/CihEgYx7QKp+DtGFOhR
	F/MDBiXf90SUMHDU5p9Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vpm1fshxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:46:17 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40I8kGiD016309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jan 2024 08:46:16 GMT
Received: from [10.218.39.189] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 18 Jan
 2024 00:46:14 -0800
Message-ID: <0ef3fb11-a207-2db4-1714-b3bca2ce2cea@quicinc.com>
Date: Thu, 18 Jan 2024 14:16:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH] usb: dwc3: gadget: Fix NULL pointer dereference in
 dwc3_gadget_suspend
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Kuen-Han Tsai <khtsai@google.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
References: <20240110095532.4776-1-quic_uaggarwa@quicinc.com>
 <CAKzKK0qJOz_+pNAVAD8Ub6TZ9uhFOzuDC_bws9MVzxNa7RqYhA@mail.gmail.com>
 <77ffee9a-cd77-6a09-10ee-bdf17bfca5ec@quicinc.com>
 <8ba84432-bd07-3e59-3638-924d5fadec30@quicinc.com>
 <20240118005641.fpydq2opopbmlnvj@synopsys.com>
Content-Language: en-US
From: UTTKARSH AGGARWAL <quic_uaggarwa@quicinc.com>
In-Reply-To: <20240118005641.fpydq2opopbmlnvj@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: E3ZrRg25Bu8y2dGaCNxBfvu76Ub-LnLg
X-Proofpoint-GUID: E3ZrRg25Bu8y2dGaCNxBfvu76Ub-LnLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=665
 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401180062


On 1/18/2024 6:26 AM, Thinh Nguyen wrote:
> On Wed, Jan 17, 2024, UTTKARSH AGGARWAL wrote:
>> On 1/17/2024 2:52 PM, UTTKARSH AGGARWAL wrote:
>>> On 1/17/2024 12:47 PM, Kuen-Han Tsai wrote:
>>>>>           ret = dwc3_gadget_soft_disconnect(dwc);
>>>>>           if (ret)
>>>>>                   goto err;
>>>> For improved readability, we can remove the goto statement and move
>>>> the error handling logic here.
>>> Hi Kuen-Han,
>>>
>>> Thanks for the suggestion.
>>> Does this looks good to you ?
>>>
>>>     int ret = dwc3_gadget_soft_disconnect(dwc);if (ret) {        if
>>> (dwc->softconnect)            dwc3_gadget_soft_connect(dwc);
>>>
>>>         return ret;    }    spin_lock_irqsave(&dwc->lock, flags);    if
>>> (dwc->gadget_driver)  dwc3_disconnect_gadget(dwc);
>>>   spin_unlock_irqrestore(&dwc->lock, flags);
>> Sorry for the mistake.
>>
>> int ret = dwc3_gadget_soft_disconnect(dwc);
>>
>> if (ret) {
>>
>>        if (dwc->softconnect)
>>
>>                   dwc3_gadget_soft_connect(dwc);
>>
>>        return ret;
>>
>> }
>>
>> spin_lock_irqsave(&dwc->lock, flags);
>>
>> if (dwc->gadget_driver)
>>
>>         dwc3_disconnect_gadget(dwc);
>>
>> spin_unlock_irqrestore(&dwc->lock, flags);
>>
> Please only make one logical fix per change. If any unrelated refactor
> or style change is needed, keep it to a separate commit.
>
> Thanks,
> Thinh

Sure Thinh,I’ll only push fix in v2, not refactoring.

Thanks,

Uttkarsh


