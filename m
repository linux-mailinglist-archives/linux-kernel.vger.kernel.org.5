Return-Path: <linux-kernel+bounces-16686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08989824271
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D1031C23DCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2AB224FD;
	Thu,  4 Jan 2024 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hgNbxPSt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124C208BA;
	Thu,  4 Jan 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 404CrvFf002506;
	Thu, 4 Jan 2024 13:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iZ02oudVObT73rUvull5mPw1mLSb+Ok1PRO+/3yI4n4=; b=hg
	NbxPStYP2vurRAHoGT3AJAMuH+MZJXAWv/idt9p6VQLYjeoagCj3aOeEQR46DVS3
	MIQN/gYH1UMrjC2TVkylIE6RsJRYnqznBXyfkquF+FOlaXK4i5RlUEHzopFElMTP
	yLE8ZsBBEyddcdqGjSWXQ2vfXzTE7kvWkTkpMQq7Mh1LqUWAnglnNvAmo1qQvWjo
	RTdPI3mnyoyAf+WOxOHg/hb/z7sZKjdFtZ7DYKuF/GXhy3L4mnP9UEo6isSsRFNn
	SCcuToThUn70e+cXrL7vnsa79og3tA6ODeOWykuY1d234O+X3KWOLye7u0kArWuF
	xVVMkp2qrrVglq+cSDYg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vdm07hf84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 13:05:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 404D5hsJ019314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Jan 2024 13:05:43 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 05:05:41 -0800
Message-ID: <eade09eb-4454-460f-9ce6-87da986c5acf@quicinc.com>
Date: Thu, 4 Jan 2024 18:35:38 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: core: Prevent null pointer dereference in
 update_port_device_state
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Alan Stern <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240104102616.20120-1-quic_ugoswami@quicinc.com>
 <2024010447-sprite-shelter-0743@gregkh>
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <2024010447-sprite-shelter-0743@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wLYbTVVtiX1F6jGLloAo15U9cqmXD3bd
X-Proofpoint-ORIG-GUID: wLYbTVVtiX1F6jGLloAo15U9cqmXD3bd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=965 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401040101

Hi Greg,

On 1/4/2024 4:14 PM, Greg Kroah-Hartman wrote:
> On Thu, Jan 04, 2024 at 03:56:16PM +0530, Udipto Goswami wrote:
>> Currently,the function update_port_device_state gets the usb_hub from
>> udev->parent by calling usb_hub_to_struct_hub.
>> However, in case the actconfig or the maxchild is 0, the usb_hub would
>> be NULL and upon further accessing to get port_dev would result in null
>> pointer dereference.
> 
> Is this true for any real (or fake) hardware?

We saw this in our QCOM hardwares where lvstest.c was calling 
get_dev_desc_store:

	usb_set_device_state+0x128/0x17c
	create_lvs_device+0x60/0xf8 [lvstest]
	get_dev_desc_store+0x94/0x18c [lvstest]
	dev_attr_store+0x30/0x48

I think the part of the test procedure is to first unbind the hub driver 
which calls hub_disconnect setting the maxchild = 0.

So if after this the dev_attr try to access, it throws the NULL pointer 
de-reference.

> 
>>
>> Fix this by introducing an if check after the usb_hub is populated.
>>
>> Fixes: 83cb2604f641 ("usb: core: add sysfs entry for usb device state")
>> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
> 
> Any specific reason you don't want this backported to the stable kernels
> that include the commit you marked this as a fix for?
> 
> As my bot says:
> 
> - You have marked a patch with a "Fixes:" tag for a commit that is in an
>    older released kernel, yet you do not have a cc: stable line in the
>    signed-off-by area at all, which means that the patch will not be
>    applied to any older kernel releases.  To properly fix this, please
>    follow the documented rules in the
>    Documentation/process/stable-kernel-rules.rst file for how to resolve
>    this.
Got it, I'll take care of it in next version.

Thanks,
-Udipto

