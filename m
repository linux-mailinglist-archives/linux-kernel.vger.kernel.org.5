Return-Path: <linux-kernel+bounces-156937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562FC8B0A94
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73514B2729E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347E15B561;
	Wed, 24 Apr 2024 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DmzCK8jD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8FC143891;
	Wed, 24 Apr 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964344; cv=none; b=ZEZSGYbrpwoA+yVq0+piAlodyutWgGV5uzKDFMrD0813/tkoQr7LpVNbjW0/oX22HI60pivy12kXkDmRISMENNy/2qPmJ1VIuvpxxMlQq2lZ38OAvXRUPKYCQIbT2zxyu7xmoqgVWWkMfMnwgs++h456s7hO8/Dlxtn7c/lv424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964344; c=relaxed/simple;
	bh=Sg4q50VuTvMKAyttTNnN97XrbTe8ZuHrrQjV2zUTHcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y+zl8FRo5y08j7sAYQKLSzTz9bWs9psZQ7mhBQRInnU+wQf6HEs/eedopImENa5KGez6NhkD621IUnJoV7fn3uJryjnAhwmsb6UkUxeZr3IswwGd8Z42PYgya4z7IWicrPi3VAROuv0kgchz1sGr4p5/XXQzwQP6laWQ7hLARwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DmzCK8jD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OCBQ8e012507;
	Wed, 24 Apr 2024 13:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gPm+F3GyhiCj4XQ7yQmxkW68qVsF1yHVwLsts/PgyoQ=; b=Dm
	zCK8jD1XIYqpH6QR5DXBn7ccTKqHJnjKPrEBdKk4M+ST9BBPYufr9gBgiw+WyPLk
	rcowIFVTy0oQOObvv7xM9IkufTQocqHy9qZ+ZjzMirZO75iib/ea/+5kTkAAqrYi
	GTxRC5OxIDoysIMCm4Hdjte3Cw5TaHyMcBJvd/1Wk0aQqzLxNDMWPvFBdOlEuUtc
	1qKYdGo7A+b8FXOUd19G88+tdMbgI8sDNR54uTcklw7Fnud9DaLqap/shHJp3g8v
	7JbdWU1XDfM60/4mQVBFFUco4wATPoFZiyq6oQiFsk3k8TSHS+Ru95SGvob1AgDS
	EYqEiwK+1Q7S5Ak4vYJg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9g8vyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:12:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ODCE8h015478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 13:12:14 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 06:12:12 -0700
Message-ID: <93e15ecf-252f-4789-a23b-a28280f6aa84@quicinc.com>
Date: Wed, 24 Apr 2024 21:12:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Wren Turkal <wt@penguintechs.org>
CC: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Marcel
 Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
 <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org>
 <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sg3kmYL1Fl-hJwpbIUBittx6Ft0hQgZ_
X-Proofpoint-GUID: sg3kmYL1Fl-hJwpbIUBittx6Ft0hQgZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_10,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=500 malwarescore=0 adultscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240046

On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>
>>>>> That's OK, we have the first part right. Let's now see if we can reuse
>>>>> patch 2/2 from Zijun.
>>>>
>>>> I'm compiling it right now. Be back soon.
>>>>
>>>
>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>> right. If I were to guess I'd say we need some mix of both.
>>
>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>
>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>
> 
> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
> Krzysztof's changes and replaces them with a different if else. This
> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
> Krzysztof handle it.
>
do you really realize what do you talk about?
do you really listen what do @Wren says?

he says that my patch 2/2 is right based on several verification results.

BTW, my 2/2 fix don't have anything about DTS usage.

he maybe be a DTS expert but not BT from his present fix history for
bluetooth system.

> Bart


