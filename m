Return-Path: <linux-kernel+bounces-60132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0855850089
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD4B232A0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B3374FA;
	Fri,  9 Feb 2024 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pwg24t6H"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024125625;
	Fri,  9 Feb 2024 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707519638; cv=none; b=RAt+1jzy+gFdC00Nj178/+A4o5e1aLSYkj9DlxWna5ngcgQhjF9mfTSDMEIVQGe/l3Ypo4CuwE46NCnVn6NNPy7XWlTrAFDustYQQXP21FdLCjekWWnb5KxtFMVEJB7RboHNe5Zauumy87kRLpQ/FMcsi9IaGsalRJ96UxTFRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707519638; c=relaxed/simple;
	bh=T+PvjDwY/Hn8AAPu8/4akRrXz4Nvc83esFAymZg5xBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eunA/9msoPQ9YwjKMs1WkGl+hTtoc5dnt8XsvECAJFscdRruQr/jEhqYEBRowxVx4qVRDTV4LquPIj1+wa9lyrIQl8CrPuQbZHsytr8zN5PpKFWNSPHcdtwfldqOZ0gEK6ldaoIcGMMnwtuDEUKNhuNmjrvtZ0FFNNRiKVvTyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pwg24t6H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419MwhK4030804;
	Fri, 9 Feb 2024 23:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=2zBR+IkjLHI1yS66YvjnS+R0KDHeCNMM9/4VVTgmt+w=; b=pw
	g24t6HHnMn0j+J6ME9wvDXyEKWj1xyG+lbFP6QIta1/bbzoxo6aQ+1J/Z0BZH8W7
	H5FnzpLPL8/qMJ/FtVqdz/GaFrpdqoQKO7D8U0XbBLsTslV372ddnRJKoncFjUk7
	jdNqXnLFVVrHkWJENXLl/aSfy5I0cgnsEi/0P89X7FI67CAYhmA9+/iqwzS5Utsy
	3MvKp2eeO+95yZ7NJeXhGMyd9F9a5ghYkpdAXb0bZtAVNzDR7jhyU7Op0DTJzwl0
	3SNlVz9VvVT/ZhxNkK1gZcXtTdqfkoNkYUpCJM+ndi/k3ENfybKI7R1Fu9SGvwDl
	nL2dl2Rl2kWiYOIEUqEg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5gk2hqf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 23:00:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419N0F7I010813
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 23:00:15 GMT
Received: from [10.110.93.252] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 15:00:14 -0800
Message-ID: <cc9500fb-1d31-6878-4feb-595a67947991@quicinc.com>
Date: Fri, 9 Feb 2024 15:00:13 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v14 45/53] ASoC: usb: Create SOC USB SND jack kcontrol
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alsa-devel@alsa-project.org>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
 <20240208231406.27397-46-quic_wcheng@quicinc.com>
 <87plx5294p.wl-tiwai@suse.de>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <87plx5294p.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3Of01_LhwD_a14Q1kLsldSnmg9_zfk3q
X-Proofpoint-GUID: 3Of01_LhwD_a14Q1kLsldSnmg9_zfk3q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 mlxlogscore=447 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402090168

Hi Takashi,

On 2/9/2024 3:02 AM, Takashi Iwai wrote:
> On Fri, 09 Feb 2024 00:13:58 +0100,
> Wesley Cheng wrote:
>>
>> Expose API for creation of a jack control for notifying of available
>> devices that are plugged in/discovered, and that support offloading.  This
>> allows for control names to be standardized across implementations of USB
>> audio offloading.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> 
> Again, use a more intuitive control element name.
> 

Sorry, missed these.  Will fix.

Thanks
Wesley Cheng

