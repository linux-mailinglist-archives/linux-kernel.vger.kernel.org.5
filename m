Return-Path: <linux-kernel+bounces-60202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C208850163
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231A0286DDD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5265C2107;
	Sat, 10 Feb 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GA+awIJM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176CB1C14;
	Sat, 10 Feb 2024 01:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526803; cv=none; b=evTPOnZjYxTXz4nKwl8esqLehCUmx+DHHHOYGjHHwR+ROH8yHBb4BYb5DwlsgwrwyoUl0ls+E+YUtteAD7Mt4fv/K+FRq828e6g7DZ2qzt6PVzde+lI2z+BiRkEJCvF0CQINQnAYCZ2xISW4UJE2h1kzT7Ik6u5Ud0xu3PYKPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526803; c=relaxed/simple;
	bh=zCVQDeEy3CmeNb0W0b/YFSI9W5MU0WGBfkdjpvOgjW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KDTUATVDEIs7k4jgeNQgx52Y3lCstWbENyZ+WwsxTnLTFHEd7W0c18B6kmL3hlvCOUDsdDc6W60foZWCpRoPgv8AMjyOX8XT20n6MhloLyMEsvMd5CZ56+7W36jpUQdaDOJI0ZuqtaDhNAeLflHOFFhSCJY52sgG+fhZA/jhzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GA+awIJM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41A0Zc4Q018024;
	Sat, 10 Feb 2024 00:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=1ThlMgw5BVq5gnMCWmwPaITaugrEhf/WCXzfUOpr6u8=; b=GA
	+awIJMlduenCKEGVHdzXS2ssfU+j0Oxw+sbLnGJOzOkxdTsWLJ2aTTXpqaH5+XS6
	QvIgF2xKZfwdjIBiTksHvy0nCl8lSpqPExO00RGtAwSAhWZVAtzO+D60+rnZ5fHk
	ijJ9QTEDQltLbl4gQqGBYiniPbBM4kHQCvZwjWfTnVwji2QUSF2PAW7Rt2VcM/vA
	mWiTvK4HoqqwJISZ9Kt20ZhVrSOtEFqQNKewOJ5cuoipQqx8KHtoRzMov0cE5C18
	VOjOvi03+MdAi+CJ1BJp60VPk8aiNCYrvof9jsf3lvVYTOO+Tll15Csd6SjkQw4P
	Mj8bM5EtJMZlfW0B1JVg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5ef1t5fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:59:48 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41A0xlLV021105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 10 Feb 2024 00:59:47 GMT
Received: from [10.110.15.103] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 16:59:47 -0800
Message-ID: <4d36cb5f-141b-5e01-783e-47059d0d5083@quicinc.com>
Date: Fri, 9 Feb 2024 16:59:46 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: Fix
 Trilok's email
To: Carlos Bilbao <carlos.bilbao@amd.com>,
        Greg KH
	<gregkh@linuxfoundation.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
CC: <corbet@lwn.net>, <avadhut.naik@amd.com>, <alexs@kernel.org>,
        <iyanteng@loongson.cn>, <2023002089@link.tyut.edu.cn>,
        <quic_bjorande@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240202164119.4090703-1-quic_jhugo@quicinc.com>
 <2024020223-eskimo-armoire-a517@gregkh>
 <78af3df9-693f-49a5-b6bd-02a146506e7e@amd.com>
Content-Language: en-US
From: Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <78af3df9-693f-49a5-b6bd-02a146506e7e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EoVo7zVP3Yg5KdzVIjKlLtmOYeLUq-wR
X-Proofpoint-ORIG-GUID: EoVo7zVP3Yg5KdzVIjKlLtmOYeLUq-wR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_20,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402100005

On 2/2/2024 9:06 AM, Carlos Bilbao wrote:
> On 2/2/24 10:48, Greg KH wrote:
>> On Fri, Feb 02, 2024 at 09:41:19AM -0700, Jeffrey Hugo wrote:
>>> The servers for the @codeaurora domain have long been retired and any
>>> messages addressed to @codeaurora will bounce.
>>>
>>> Trilok has an entry in .mailmap, but the raw documentation files still
>>> list an old @codeaurora address.  Update the address in the
>>> documentation files for anyone reading them.
>>>
>>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>> ---
>>>   Documentation/process/embargoed-hardware-issues.rst             | 2 +-
>>>   .../translations/sp_SP/process/embargoed-hardware-issues.rst    | 2 +-
>>>   .../translations/zh_CN/process/embargoed-hardware-issues.rst    | 2 +-
>>>   .../translations/zh_TW/process/embargoed-hardware-issues.rst    | 2 +-
>>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> I think we need an ack from Trilok for this :)
> 
> Assuming ack from Trilok, regarding the Spanish documentation,
> 
> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>

Looks good to me. Thank you.

Reviewed-by: Trilok Soni <quic_tsoni@quicinc.com> 

-- 
---Trilok Soni


