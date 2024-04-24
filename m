Return-Path: <linux-kernel+bounces-157215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FE98B0E89
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18AC31C2529A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC90168AE9;
	Wed, 24 Apr 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KdR+4Pm3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771A11607AD;
	Wed, 24 Apr 2024 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972957; cv=none; b=nABkNjow91VX8yo7y4xvkKfBVQKc83VQM8x74zxL0h+l3cxkpMu7gp24TsCkzeTV+DsA2nkU7hmavac2aTauUGWP54qe2FUD79cX5k35VmxqtW4U0cOE9hQ9Df1cP4wwpgwwrCGREreCCG3ujmQqSNfQa2W6LhUyC48gNOdXwxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972957; c=relaxed/simple;
	bh=ZZVGlcxEhzyXPiqDqdJdHkVrzNSAqDFnZrPYvAmquwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R4ETX5+BXYxjYHPhIZgdF388tinZFkn0n4Rmb6vT2oOODmM8wtA0VJA+ohsLSfFXmLDWd/wXgn52bUNPAPS0gy0ruK3FVpl1iqm5g2fO7s4j8UH6UngsnxXiujVfyniZvzqgmISfcYZ2rQ17mZtjIhwdEtcc5vy79GNVVkQjr6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KdR+4Pm3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OBGKdh009472;
	Wed, 24 Apr 2024 15:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w4iNbsTEMhlwQqf/pJx7GjQgFNNjNa/aTNBMQ1olwbs=; b=Kd
	R+4Pm3OT+7pHSThKoXHgKsdfKcRAyh1m7D0i1phaOZ3rQXxoSQd/0ruzLCMTuEu2
	e3X+zPNjLVdaptJBuSogOnntGPrKUl/LRYkuq1ry0RZu3Aal5dvyU7VD2rqKjkog
	9RIukgirHDhzTUhOJlHQBF03Ks7e/dmWZn3+r9FcB+NVfFSRHpbxDK4TOg8BZMPr
	5wTPPD8dphYHoUHXs6Izf0ej5cofIBrJS5hau+mr66StpaDrHSZ/iKZDxZImfjwj
	oBlqC/CzWZvbV/kD4tmL3BjD+RuGYdmYUfMV965wFv8VSCgAaMiysb8C1mKUGLTo
	Cxky1kx6Hvi/XQUJsxxQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fh9pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:35:47 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OFZloG024064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 15:35:47 GMT
Received: from [10.253.14.221] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 08:35:45 -0700
Message-ID: <f1d41e3a-e864-43a3-bb59-f59a8667b595@quicinc.com>
Date: Wed, 24 Apr 2024 23:35:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wren Turkal <wt@penguintechs.org>
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
 <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
 <f4bffd0e-0d9b-4fb9-926e-c75a20c92b50@quicinc.com>
 <CAMRc=MfqKsRqKck5Wb052zuUURxqRykjbu+c3K9oFPMHaHuiJA@mail.gmail.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <CAMRc=MfqKsRqKck5Wb052zuUURxqRykjbu+c3K9oFPMHaHuiJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 77Q4NYzepkcRnXtdS54MJltaxpv-KU4s
X-Proofpoint-ORIG-GUID: 77Q4NYzepkcRnXtdS54MJltaxpv-KU4s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_12,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240061

On 4/24/2024 11:31 PM, Bartosz Golaszewski wrote:
> On Wed, Apr 24, 2024 at 5:30 PM quic_zijuhu <quic_zijuhu@quicinc.com> wrote:
>>
>> On 4/24/2024 11:24 PM, quic_zijuhu wrote:
>>> On 4/24/2024 10:52 PM, Bartosz Golaszewski wrote:
>>>> On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
>>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>>
>>>>> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
>>>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>>>
>>>>>
>>>>>>               qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>>>>>               if (IS_ERR(qcadev->susclk)) {
>>>>>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>>>               qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>                                              GPIOD_OUT_LOW);
>>>>>>               if (IS_ERR(qcadev->bt_en)) {
>>>>>> -                     dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>> -                     power_ctrl_enabled = false;
>>>>>> +                     dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>> +                     return PTR_ERR(qcadev->bt_en);
>>> please think about for QCA2066. if it is returned from here.  BT will
>>> not working at all.  if you don't return here. i will be working fine
>>> for every BT functionality.
>> sorry, correct a type error, it is QCA6390 not QCA2066.
> 
> Doesn't matter. If enable-gpios is not there, gpiod_get_optional()
> will return NULL and we will not return.
> 
i think i need to explain more for my consider case.
let me take QCA6390,  if the property enable-gpios is configured.
but IS_ERR(qcadev->bt_en) case happens, your change will do error
return, so BT will not work at all

but if you don't do error return, BT will working fine.

so your fix is not right regarding QCA6390.

> Bart
> 
>>> NAK again by me.
>>>
>>>>>>               }
>>>>>>
>>>>>> +             if (!qcadev->bt_en)
>>>>>> +                     power_ctrl_enabled = false;
>>>>>
>>>>> This looks duplicated - you already have such check earlier.
>>>>>
>>>>
>>>> It's under a different switch case!
>>>>
>>>> Bartosz
>>>
>>>
>>


