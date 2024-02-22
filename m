Return-Path: <linux-kernel+bounces-76278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4DF85F51A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1B21C24663
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EF038FAA;
	Thu, 22 Feb 2024 09:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O/GS/WZ5"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF1182DA;
	Thu, 22 Feb 2024 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595746; cv=none; b=qy8joQESn8nQw4kYxLJq/mUJzVgQ4E0OE3q+P5w+3VkkobtbhxUTdcUWnrGuB/bB7SGcEVySubqVc5IPs7TgTVy/JCTChS4QErmRMd1wqGXjgq4WmKOQSembjPU9i9PVYugnD3Y+45hqm0wYsJxEqs0U6uao7Cr18xIG1fOkN1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595746; c=relaxed/simple;
	bh=2HDnhOVRJHbojLSnYAS7XkzG2gdqjQq7B1JmqC5MQZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qwurXiUwlCISue9jCsYmbRgmIPB7ErOrBQiFYgtiLmM2qNum7LTRqrTzHvZ9Zv8GIzmdxRy7GNt3oTb4IyNWkcZN/GHhhDVA9iFRtRdHPipXo21iXpFkD+1OMznvuAwIH76cEVVdZfoGobkUTjsPGcNRGxajAPN+MR/MsiGioAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O/GS/WZ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M56fhw010101;
	Thu, 22 Feb 2024 09:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5OuU5m7TxwbK/rp6+K5E68Y6ra0FqJ05hWgHbe7cVJc=; b=O/
	GS/WZ5rs00m9jUJroN0OHjbBEIWTS5tyBjkIS7TsWomoy8qy9BYNfgqU2k/LMdfO
	d9RyobazqPT0HxO6AiOSt1OO0FrpaPUYBL3myR6I6BIlstC5mImQ3P1Z7KRbBW7o
	iOvMNdtcDWnt0+ddxihfFTNv4H1Pr+S7KFvHyLpnaHnPIe+xS00gN8zpUuk2ABwi
	46ni31THTP6jwms0K4i4SE4t5mq8xXP2er80zgUKRymNUMeHUe3qpKn/p+FJ7z0m
	bySlxh68sowiC9xl2510tmrOfoSfD0TUrXIF4TE8Jct2nyJoeCt1PYNcLA0nTHZi
	sjffwU9UyVsrT95BzGTA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdw13963a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 09:55:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41M9tIUx025649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 09:55:18 GMT
Received: from [10.214.82.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 01:55:14 -0800
Message-ID: <8af59b01-53cf-4fc4-9946-6c630fb7b38e@quicinc.com>
Date: Thu, 22 Feb 2024 15:25:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] Introduction of a remoteproc tee to load signed
 firmware
Content-Language: en-US
To: Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jens
 Wiklander <jens.wiklander@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <op-tee@lists.trustedfirmware.org>, <devicetree@vger.kernel.org>
References: <20240214172127.1022199-1-arnaud.pouliquen@foss.st.com>
 <fe4ec29f-7521-4369-a382-bae50dbf0ee5@quicinc.com>
 <adcf0c0d-f452-4285-8651-c147fcca001b@foss.st.com>
From: Naman Jain <quic_namajain@quicinc.com>
In-Reply-To: <adcf0c0d-f452-4285-8651-c147fcca001b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Yac_XNlh0Nv6ycv1GnJ3h6WLqaY_ujej
X-Proofpoint-GUID: Yac_XNlh0Nv6ycv1GnJ3h6WLqaY_ujej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_06,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220078

On 2/22/2024 2:17 PM, Arnaud POULIQUEN wrote:
> Hello Naman,
> 
> On 2/22/24 06:43, Naman Jain wrote:
>> On 2/14/2024 10:51 PM, Arnaud Pouliquen wrote:
>>> Updates from the previous version [1]:
>>>
>>> This version proposes another approach based on an alternate load and boot
>>> of the coprocessor. Therefore, the constraint introduced by tee_remoteproc
>>> is that the firmware has to be authenticated and loaded before the resource
>>> table can be obtained.
>>>
>>> The existing boot sequence is: >
>>>     1) Get the resource table and store it in a cache,
>>>        calling rproc->ops->parse_fw().
>>>     2) Parse the resource table and handle resources,
>>>        calling rproc_handle_resources.
>>>     3) Load the firmware, calling rproc->ops->load().
>>>     4) Start the firmware, calling rproc->ops->start().
>>>    => Steps 1 and 2 are executed in rproc_fw_boot(), while steps 3 and 4 are
>>>      executed in rproc_start().
>>> => the use of rproc->ops->load() ops is mandatory
>>>
>>> The boot sequence needed for TEE boot is:
>>>
>>>     1) Load the firmware.
>>>     2) Get the loaded resource, no cache.
>>>     3) Parse the resource table and handle resources.
>>>     4) Start the firmware.
>>
>> Hi,
>> What problem are we really addressing here by reordering load, parse of
>> FW resources?
> 
> The feature introduced in TEE is the signature of the firmware images. That
> means that before getting the resource table, we need to first authenticate the
> firmware images.
> Authenticating a firmware image means that we have to copy the firmware into
> protected memory that cannot be corrupted by the non-secure and then verify the
> signature.
> The strategy implemented in OP-TEE is to load the firmware into destination
> memory and then authenticate it.
> This strategy avoids having a temporary copy of the whole images in a secure memory.
> This strategy imposes loading the firmware images before retrieving the resource
> table.
> 
>> Basically, what are the limitations of the current design you are referring to?
>> I understood that TEE is designed that way.
> 
> The limitation of the current design is that we obtain the resource table before
> loading the firmware. Following the current design would impose constraints in
> TEE that are not straightforward. Step 1 (getting the resource table and storing
> it in a cache) would require having a copy of the resource table in TEE after
> authenticating the images. However, authenticating the firmware, as explained
> before, depends on the strategy implemented. In TEE implementation, we load the
> firmware to authenticate it in the destination memory.
> 
> Regards,
> Arnaud


Hello Arnaud,
I think now I got your point. In TEE, you don't want to do anything(read
resource table) with FW images, until its loaded and authenticated.
Since current design was not allowing you to do it, you had to 
reorganize the code so that this can be achieved.

Generally speaking, in current design, if authentication fails for some
reason later, one can handle it, but it depends on the implementation of
parse_fw op if the damage is already done.

Please correct me if this is wrong assumption.
Patch looks good to me.

Regards,
Naman Jain

