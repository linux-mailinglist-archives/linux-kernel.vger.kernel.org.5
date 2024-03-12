Return-Path: <linux-kernel+bounces-100499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF58798A7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4C31C218C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1278E7D3F9;
	Tue, 12 Mar 2024 16:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EkPp1FMb"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDD7A73F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259985; cv=none; b=DgpJCHhLJWZ8EKR1UQ8pTAzsQSQvJNd5gFzwWA8acgaGtMdcMQZRead9QGYxid7KGJMKCmGY9kswiDhUUbxL6RcxXwF4fpPW8vL5AoidMajcU2w6dAvc7iCFFNlV/MMXjMmNozJ5Azox5PRjW3sX5AOlhUpa/yeTRXQP7xNh/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259985; c=relaxed/simple;
	bh=ZCJROvJRrAYT7Jc6E1xIj5ZKRMxyPfvbC0G1OA9L3W8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aLtdJAMw8X7A62WSEiZibQuH5q76lOZLhl1PFTDVsd/5Ej8oWR8NLfeLWg+CpmG8onncn4U4ts5AckhVNz0KssUwwVCtxtZY9ImzocAC3WXUSac5nEvT+ka5fz2RnD3uHdAxUnTYRurH8pSdxfzgdmXVSBg/gtomSiIwavjgbGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EkPp1FMb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CDK4Xx023716;
	Tue, 12 Mar 2024 16:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jFeOfqofpER02Z0W5dJuJpJa9a9anKP1f9O1bGqjJMY=; b=Ek
	Pp1FMb9TvCDqEaWHo5ap2AkjMtbnuOsZWJp4CnhKpRFqWveniZPH0+6VPp1U+XNP
	NGvRTIoQxJ23Ys/zQojnxVcRzIH7Qckgo405506I8+ihLC4xKUJxsrU4cJorZUsI
	3mDqsahVooQa0b8IPhdyIxg45ZguMtgW7WcWeUB7mM8qEY9+7JbIDLoicL+i3ihw
	jCGAIDFqUo80HNO4hqfhfhDG3gsP59jf3Q3MUiP3NR5ZTXMha+m382/3kMNRTmql
	FHvSvN7sHpdTGso9K+nVNfg2OdU4/cK0r9UaNNAQkUOQNnVH2W/tnUqwQ0qxp99t
	F/iqZI/RRT3tfx9T8YjQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtgc3hdhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 16:12:57 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CGCvWC004990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 16:12:57 GMT
Received: from [10.216.60.182] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 09:12:53 -0700
Message-ID: <792e956f-eefb-3d2b-ada2-0eaa175ba81e@quicinc.com>
Date: Tue, 12 Mar 2024 21:42:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvmem: meson-mx-efuse: Remove nvmem_device from efuse
 struct
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC: <srinivas.kandagatla@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1709621888-3173-1-git-send-email-quic_mojha@quicinc.com>
 <CAFBinCC2n+Muu2qaAG0PWFj6f+bVFDtHnzm78jSpeodTD47TOg@mail.gmail.com>
Content-Language: en-US
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAFBinCC2n+Muu2qaAG0PWFj6f+bVFDtHnzm78jSpeodTD47TOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GfegUGf7_eY_C748SFCEi1-9w7RLtqJz
X-Proofpoint-GUID: GfegUGf7_eY_C748SFCEi1-9w7RLtqJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120122

Hi Martin,

On 3/8/2024 2:26 AM, Martin Blumenstingl wrote:
> Hello Mukesh,
> 
> On Tue, Mar 5, 2024 at 7:58 AM Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> nvmem_device is used at one place while registering nvmem
>> device and it is not required to be present in efuse struct
>> for just this purpose.
>>
>> Drop nvmem_device and manage with nvmem device stack variable.
> I'm generally fine with this approach

Thanks.
Sorry for the late reply, was on vacation.

> 
> [...]
>> @@ -223,9 +222,9 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
>>                  return PTR_ERR(efuse->core_clk);
>>          }
>>
>> -       efuse->nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
>> +       nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
> But this doesn't compile for me:
>    CC      drivers/nvmem/meson-mx-efuse.o
> ../drivers/nvmem/meson-mx-efuse.c: In function 'meson_mx_efuse_probe':
> ../drivers/nvmem/meson-mx-efuse.c:252:9: error: 'nvmem' undeclared
> (first use in this function)
>   252 |         nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);

Sent too soon., change was cached never got commited..

v2:
https://lore.kernel.org/lkml/1710259663-14095-1-git-send-email-quic_mojha@quicinc.com/

Thanks,
-Mukesh

> 
> 
> Best regards,
> Martin

