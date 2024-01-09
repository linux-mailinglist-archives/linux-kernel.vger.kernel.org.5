Return-Path: <linux-kernel+bounces-20656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D2F828309
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9194B25D78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606136AFE;
	Tue,  9 Jan 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OANuaXVM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4882575B;
	Tue,  9 Jan 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4093SbOe010422;
	Tue, 9 Jan 2024 09:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HzuWPpbwZVSHJ1aJFEu6jy0rsDjgywdk2juJPX406wQ=; b=OA
	NuaXVMe7jOQsTbcorcqhluaRKmT7dEhtPVjQLw1a9DG2Lw1LbzC0Oku3DNCbVZ8G
	iSM6OF0SB29N1a4PdHanmKvUGjZjP67brVG5D/GUZ4hO0bJmy5xm7EAhL+rX96eT
	DAjAIGeiJTXecWl6sypeWl7akQvdHUzNbTpLaFrRO4g5wLSTcPdfZ3HRszpVUlkA
	FQTqmS3PUWjdNEfZIr2m5osBPPURA9EAtTcmvYxx/5EDvyC2ygW2+hH+y6KMKCb6
	uQgQjmp6BOodwhomD/T9xDiaD2+EdUw8UDMBn4sTRgVoBNkwfBadcH1+HSV2bFSL
	X+x8Il63RpvFWhSoe+/g==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgwhs8p6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:20:43 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4099Kg0x026714
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 09:20:42 GMT
Received: from [10.253.78.145] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 9 Jan
 2024 01:20:39 -0800
Message-ID: <90c0a654-a02f-46e2-96a9-34f6a30c95a0@quicinc.com>
Date: Tue, 9 Jan 2024 17:20:37 +0800
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
To: Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo
	<quic_jhugo@quicinc.com>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Bhaumik Bhatt <quic_bbhatt@quicinc.com>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
 <20240102165229.GC4917@thinkpad>
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240102165229.GC4917@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QAzX4sz7Hd2CUePXAnk6Lnk9hhMDNg2n
X-Proofpoint-GUID: QAzX4sz7Hd2CUePXAnk6Lnk9hhMDNg2n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=931
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401090073


On 1/3/2024 12:52 AM, Manivannan Sadhasivam wrote:
> On Tue, Jan 02, 2024 at 08:31:15AM -0700, Jeffrey Hugo wrote:
>> On 12/25/2023 12:47 AM, Qiang Yu wrote:
>>> From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
>>>
>>> Forcing the device (eg. SDX75) to enter Emergency Download Mode involves
>>> writing the 0xEDEDEDED cookie to the channel 91 doorbell register and
>>> forcing an SOC reset afterwards. Allow users of the MHI bus to exercise the
>>> sequence using a sysfs entry.
>> I don't see this documented in the spec anywhere.  Is this standard behavior
>> for all MHI devices?
>>
>> What about devices that don't support EDL mode?
>>
>> How should the host avoid using this special cookie when EDL mode is not
>> desired?
>>
> All points raised by Jeff are valid. I had discussions with Hemant and Bhaumik
> previously on allowing the devices to enter EDL mode in a generic manner and we
> didn't conclude on one final approach.
>
> Whatever way we come up with, it should be properly described in the MHI spec
> and _should_ be backwards compatible.

Hi Mani, Jeff. The method of entering EDL mode is documented in MHI spec 
v1.2, Chapter 13.2.

Could you please check once?

>
> - Mani
>
>> -Jeff

