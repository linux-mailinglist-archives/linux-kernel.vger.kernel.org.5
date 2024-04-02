Return-Path: <linux-kernel+bounces-127381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1FA894A88
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21761C22172
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890117C69;
	Tue,  2 Apr 2024 04:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OaUrQT2K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F52581;
	Tue,  2 Apr 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712032554; cv=none; b=ekaLWbCbiXoY+xsadiY0tKNdiJnr6KTajnorO7U4bvj+sY8Z/0GtHFXjI0aiqTOel87pmWFcjdNDwNNYtmOQFd6WsjFiD5bZzHyPrJMO95vky+Sc5mhuuQnZh8dwQ17HKsXmSXdknVSO8RxuzUY7SMWcluWUW8itxJFWhTO4JxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712032554; c=relaxed/simple;
	bh=6E0gncyahqLdIZmjYurjLKkiLv9IqAKbu9Y8s4D03c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cc2PhW3gpFx2lOhZr/M2QJdTtNdGLU2S1LSfw+Ys2DKEXm7jlABMDuPlVjMXsHFOXNdyRRikMUobUUvkqhzgjlE9OrSiP32BBO/62D32GhbCD35dVkjEVHF3iE052MR1ZSpJFS2EYCAFuqIMyZ5o0ONJzLW21cDKVfwTB90+AXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OaUrQT2K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432304np019450;
	Tue, 2 Apr 2024 04:35:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lzKJU18hJQSyG8eJysHY81OevBjTN6oSacJs9+hF2cU=; b=Oa
	UrQT2K3I+LnpC2jPFM8EHZwywPzNYMDbbRFmnBBwEmKMHBJTGKtf2fO7vOlnuHlJ
	Jd4eu2hf0y8Z5TMymOVtWev7+VOiIdyjYyrvL50uEfzVDl9exvdAhwMTojiH0e2y
	1FUCWKXPpshaZ1u+TgxMkH7JFVwI8ObLCmKA79nxHAP/jeQQsAw6PEAGul3w8TQq
	jw10PClmaxDU/tiUbbq0+bCb3AwOsdazgivDiTo88/m5H8/o6pGIEjMwRQnIBzRH
	vLjs2+vNbM83iVO8KPxZ0luO6E/Z8Pf324g4xGSVPf47iFkeRllz+WOi6TWpEj3g
	7rmhizMUhdgP02VbGuMg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x88eh88s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 04:35:39 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4324Zcev012366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 04:35:38 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 1 Apr 2024
 21:35:36 -0700
Message-ID: <e78382b5-428e-4de8-be0d-b319534238f1@quicinc.com>
Date: Tue, 2 Apr 2024 12:34:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: host: Add sysfs entry to force device to enter
 EDL
Content-Language: en-US
To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam
	<mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Bhaumik Bhatt <quic_bbhatt@quicinc.com>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
 <20240102165229.GC4917@thinkpad>
 <90c0a654-a02f-46e2-96a9-34f6a30c95a0@quicinc.com>
 <a10439f1-0fcd-834c-12a3-677976529cf1@quicinc.com>
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <a10439f1-0fcd-834c-12a3-677976529cf1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zje4CYopREeAD-Wvde_0CYqXrbZiWhvn
X-Proofpoint-ORIG-GUID: Zje4CYopREeAD-Wvde_0CYqXrbZiWhvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_01,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020030


On 1/12/2024 3:08 AM, Jeffrey Hugo wrote:
> On 1/9/2024 2:20 AM, Qiang Yu wrote:
>>
>> On 1/3/2024 12:52 AM, Manivannan Sadhasivam wrote:
>>> On Tue, Jan 02, 2024 at 08:31:15AM -0700, Jeffrey Hugo wrote:
>>>> On 12/25/2023 12:47 AM, Qiang Yu wrote:
>>>>> From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
>>>>>
>>>>> Forcing the device (eg. SDX75) to enter Emergency Download Mode 
>>>>> involves
>>>>> writing the 0xEDEDEDED cookie to the channel 91 doorbell register and
>>>>> forcing an SOC reset afterwards. Allow users of the MHI bus to 
>>>>> exercise the
>>>>> sequence using a sysfs entry.
>>>> I don't see this documented in the spec anywhere.  Is this standard 
>>>> behavior
>>>> for all MHI devices?
>>>>
>>>> What about devices that don't support EDL mode?
>>>>
>>>> How should the host avoid using this special cookie when EDL mode 
>>>> is not
>>>> desired?
>>>>
>>> All points raised by Jeff are valid. I had discussions with Hemant 
>>> and Bhaumik
>>> previously on allowing the devices to enter EDL mode in a generic 
>>> manner and we
>>> didn't conclude on one final approach.
>>>
>>> Whatever way we come up with, it should be properly described in the 
>>> MHI spec
>>> and _should_ be backwards compatible.
>>
>> Hi Mani, Jeff. The method of entering EDL mode is documented in MHI 
>> spec v1.2, Chapter 13.2.
>>
>> Could you please check once?
>
> I do see it listed there.  However that was a FR for SDX55, so devices 
> prior to that would not support this.  AIC100 predates this change and 
> would not support the functionality.  I verified the AIC100 
> implementation is not aware of this cookie.
>
> Also, that functionality depends on channel 91 being reserved per the 
> table 9-2, however that table only applies to modem class devices as 
> it is under chapter 9 "Modem protocols over PCIe". Looking at the 
> ath11k and ath12k implementations in upstream, it looks like they 
> partially comply.  Other devices have different MHI channel definitions.
>
> Chapter 9 doesn't appear to be in older versions of the spec that I 
> have, so it is unclear if this functionality is backwards compatible 
> (was channel 91 used for another purpose in pre-SDX55 modems).
>
> I'm not convinced this belongs in the MHI core.  At a minimum, the MHI 
> controller(s) for the applicable devices needs to opt-in to this.
>
> -Jeff
Hi Jeff

Sorry for reply so late. In older versions of the spec, there is no 
description about EDL doorbell. However, in MHI spec v1.2, section 13.2,
It explicitly says "To set the EDL cookie, the host writes 0xEDEDEDED to 
channel doorbell 91." So I think every device based on MHI spec v1.2
should reserve channel doorbell 91 for EDL mode.

So can we add another flag called mhi_ver in mhi controller to indicate 
its mhi version and then we can add mhi_ver checking to determine if this
device supports EDL sysfs operation?

Thanks,
Qiang

