Return-Path: <linux-kernel+bounces-161793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F42028B515A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DD661C21298
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817E11CB4;
	Mon, 29 Apr 2024 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fPCzRzkB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2010A09;
	Mon, 29 Apr 2024 06:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371846; cv=none; b=qyGjCUzRcuNbQcZ4XFhzwjMhAecU4Ytftz7dleeNJLFUum2eoefda046wfV6a6cT/Qx78s6WyxSheLO/B8frf3yQPpq8vmfoulwvdGL0UwgmLyjehZYC7oxZX49fobdD/uGgku0gIO8koGSmGP6CXCAP9tWpjxWBziGU/pAb38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371846; c=relaxed/simple;
	bh=Xs9GrMdqFbDwbUQ42x1iozNdh/d5jFq8zBfXqyDL+WU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SjMoGda+UM3AjrNEmaA/3qqA0SL2Bm/+fY54u/XDsVp9TfuUU/qHrbk0pyXY4rVKwYkwbqAd1YAq+QQtVgRcjLqt8j+K6A6teOKQsT5OZQhNrfs6AZSFmmDlY2jYWZ7UHriPgKDqLOhRyiXYyW6RjWH8n3eqrZmA7n9zF2xXRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fPCzRzkB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T60WWT006381;
	Mon, 29 Apr 2024 06:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BJVIrhRmVxolyIU4TO+UULAY1plItlY0xRYZN+J3VMQ=; b=fP
	CzRzkBYbPY4UfNlrjoS+1nNtChFMzwT1OrtLeUmDuwOUAekesN0T1iX1wL8Tu06o
	DUQyDkCl8wFivhwEiUVcQJRncePbag38RGy+Idivsdqgt/SEd4n3SWaj50/kslU6
	gh93bjZR6sTA8IdDZmCVw8b56rFGONqtRTFM2KCwI62FtxVkAvoyfH9W79ZZh6+u
	nk7vht2xM4gl/+O5TJ4En7W2iGU50VjaX8W/vMyjiEma9YiCVWHqP2yXs95kZ+CW
	RkGS9eAXjj+Z/X38ArDWC3oYUdhgknHDsR75jKlWTmiPWqUzbkzl6VMOdKPFQi17
	yuYf/9r190D51+ecpirA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrravjy1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 06:23:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T6Nds1005838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 06:23:39 GMT
Received: from [10.218.46.108] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 28 Apr
 2024 23:23:32 -0700
Message-ID: <64ed9496-577c-4f31-b061-9f3dcaca4b26@quicinc.com>
Date: Mon, 29 Apr 2024 11:53:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [RFC PATCH] ALSA: usb-audio: endpoint: Prevent NULL
 pointer deference in snd_usb_endpoint_close
To: Takashi Iwai <tiwai@suse.de>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20240426122511.547755-1-quic_kuruva@quicinc.com>
 <877cgks399.wl-tiwai@suse.de>
Content-Language: en-US
From: "Rajashekar Kuruva (Temp)" <quic_kuruva@quicinc.com>
In-Reply-To: <877cgks399.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OL3ON6050G4UaXB7Ee_xq_4xYqXQmnDL
X-Proofpoint-ORIG-GUID: OL3ON6050G4UaXB7Ee_xq_4xYqXQmnDL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_03,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=702 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290041


On 4/26/2024 6:13 PM, Takashi Iwai wrote:
> On Fri, 26 Apr 2024 14:25:11 +0200,
> Rajashekar kuruva wrote:
>> When multiple plug-in and plug-out events occur,
>> there is a risk of encountering a NULL pointer dereference
>> leading to a kernel panic during a headset use-case.
>> this issue arises in the snd_usb_endpoint_close function
> Such a scenario can't happen: ep->iface_ref is changed only in
> chip->mutex lock, hence it can't be NULL there.
>
>
> thanks,
>
> Takashi

Hi Takashi,

Actually we are facing NULL pointer deference while running headset case 
when i checked call trace the last running function is 
snd_usb_endpoint_close where iface_ref and clock_ref both are 0x0

[75703.933104][T10585] Unable to handle kernel NULL pointer dereference 
at virtual address 0000000000000004
[75703.933113][T10585] [RB/E]rb_sreason_str_set: sreason_str set NULL 
pointer dereference
[75703.933116][T10585] Mem abort info:
[75703.933117][T10585]   ESR = 0x0000000096000005
[75703.933119][T10585]   EC = 0x25: DABT (current EL), IL = 32 bits
[75703.933120][T10585]   SET = 0, FnV = 0
[75703.933121][T10585]   EA = 0, S1PTW = 0
[75703.933123][T10585]   FSC = 0x05: level 1 translation fault
[75703.933124][T10585] Data abort info:
[75703.933124][T10585]   ISV = 0, ISS = 0x00000005
[75703.933125][T10585]   CM = 0, WnR = 0
…
[75703.933676][T10585] CPU: 3 PID: 10585 Comm: kworker/u17:0 Tainted: G 
S      W  OE 6.1.43-android14-11-ga2fa77d36d26-ab11204829 #1
[75703.933697][T10585] pstate: 62400005 (nZCv daif +PAN -UAO +TCO -DIT 
-SSBS BTYPE=--)
[75703.933700][T10585] pc : snd_usb_endpoint_close+0x30/0x104
[75703.933721][T10585] lr : snd_usb_endpoint_close+0x28/0x104
[75703.933724][T10585] sp : ffffffc04b2bb740
[75703.933725][T10585] x29: ffffffc04b2bb740 x28: ffffff8024e3ba78 x27: 
ffffffd266e91da0
[75703.933728][T10585] x26: ffffffc04b2bb7a8 x25: ffffff89bec5be00 x24: 
00000000ffffffea
[75703.933730][T10585] x23: 0000000000000002 x22: ffffff885d568008 x21: 
ffffff8024e3ba78
[75703.933732][T10585] x20: ffffff885d568000 x19: ffffff8024e3bb18 x18: 
ffffffd26db2d140
[75703.933734][T10585] x17: 00000000f01b0818 x16: 00000000f01b0818 x15: 
0000000000000008
[75703.933736][T10585] x14: ffffff8a3e2b5780 x13: ffffff8a3e2b5780 x12: 
ffffffd26cbd2770
[75703.933738][T10585] x11: 0000000000000001 x10: ffffff8984320000 x9 : 
4f43b86e946b4e00
[75703.933740][T10585] x8 : 0000000000000000 x7 : 0000000000000001 x6 : 
fffffffdef8e8b70
[75703.933742][T10585] x5 : 0000000000000001 x4 : 0000000000000000 x3 : 
ffffff8024e3bb28
[75703.933743][T10585] x2 : 00000001011fa7c9 x1 : ffffffc04b2bb680 x0 : 
0000000000000000
[75703.933746][T10585] Call trace:
[75703.933747][T10585]  snd_usb_endpoint_close+0x30/0x104

That's why I have added the NULL pointer check

Thanks,

Rajashekar K.


