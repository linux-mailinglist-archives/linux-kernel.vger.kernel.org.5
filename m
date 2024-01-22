Return-Path: <linux-kernel+bounces-33866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF6836FB7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26901F31E88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C114CB49;
	Mon, 22 Jan 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HSbkB7nq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D54CB31;
	Mon, 22 Jan 2024 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945811; cv=none; b=RNm/R1UrxoS2Kaort5y+6ghPKQJVvrctR00aBGvPW9JL9OnqunfqwblBdTs8kY1YEb8Ez7s1U6ht1ITv2qTaxuIBlxSw7t2CEox/HuWXOlRf4JYPwoICRLRBO3ES/CExCszCv7ewQ+U4Rk/lpBbizDcga4wy3rvMjNItH7VubaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945811; c=relaxed/simple;
	bh=nrjMhgFBwkaAZ6DvfofhjPey8YCxeJKDIVmE6A5ckUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lWq4UjQ8NadYmJonOlC0UCkj6p6Vw4wb56QzF+TSaXYAylt0GC+OwXuccK+ehnlGwji5pF37o9a/missZcfRJ9QYiDuP1lpvtunSzw2VPVdse1as0H29W5REaC0Qiwy5E5gXxc18/+KHgsaSP+80ELKjxNLDmpEXqIbqXQjLXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HSbkB7nq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MDaFQe003288;
	Mon, 22 Jan 2024 17:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gmrF2yQZXmlhVvRx/bjIoxB2JXFJsegupGpfsEiApCE=; b=HS
	bkB7nqo1xBBC828dhvRL3EKRNeEZuF4dpKmSxLV03TYc6SmwvkB5qas1x4ku/w0F
	a2j4WQUEvZPjzrBA1Mkyd/b3vWuJFus9Y144+eGU9ptly4gv5gX0N4kyUB9r0A9S
	OhVDV4xOOjG2rv4xA5ZwHsXtF7XQUXZM2ceEgobPGg7wJBIXxJjWNxkI72VXhsHM
	T61mqykPZORWX3qOV2mgRIsODFVqkA1Tsw4TnTLv3DhpjyICPuV3OISf0G5175+p
	4gIkx7gGMmmDNmucn5N9EkjpdqMNyn9PohAHtH9TLcWGvah2HxH4CKGSdLIw1aPz
	AUq72JIUdCB7WJTAhaog==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8s4hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:50:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MHo4ED020349
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:50:04 GMT
Received: from [10.110.104.139] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 09:50:00 -0800
Message-ID: <dff70941-709c-4043-802a-16bfeb8ba4f8@quicinc.com>
Date: Mon, 22 Jan 2024 09:50:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add board-id support for multiple DT selection
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amrit Anand
	<quic_amrianan@quicinc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        <devicetree-spec@vger.kernel.org>
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <6ceb3c5d-4171-4f0e-a1c0-22a8488ea2bc@linaro.org>
Content-Language: en-US
From: Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <6ceb3c5d-4171-4f0e-a1c0-22a8488ea2bc@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 00ZgLwGHbsDfPXQ8AKTa0gTrYi7OTktY
X-Proofpoint-ORIG-GUID: 00ZgLwGHbsDfPXQ8AKTa0gTrYi7OTktY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 mlxlogscore=601
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220124

+devicetree-spec

On 1/20/2024 5:04 AM, Konrad Dybcio wrote:
> On 20.01.2024 12:20, Amrit Anand wrote:
>> Device manufacturers frequently ship multiple boards or SKUs under a
>> single software package. These software packages will ship multiple
>> devicetree blobs and require some mechanism to pick the correct DTB for
>> the board the software package was deployed. Introduce a common
>> definition for adding board identifiers to device trees. board-id
>> provides a mechanism for bootloaders to select the appropriate DTB which
>> is vendor/OEM-agnostic.
> 
> Maybe it'd be a good idea to add it to the base spec!
> 
> https://github.com/devicetree-org/devicetree-specification
> 

I agree. Rob, what do you think?

