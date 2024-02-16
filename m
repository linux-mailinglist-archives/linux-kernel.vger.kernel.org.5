Return-Path: <linux-kernel+bounces-68947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE0B858244
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418111F24CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73A12FF97;
	Fri, 16 Feb 2024 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YLhZ8Urr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19F12FB07;
	Fri, 16 Feb 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100271; cv=none; b=L5eYnczTvLLr7DkShFI5NPp2mY9MC21z9N2NJIgkgA2nxyOZGzEQL8FRpBCQCIy0omQdj9l258D//Tgnoh5Z7fjrAqLJGHFWbY3Xb3SMnIktNvQACftMxHv1cVErzWdHLYZcARpsEkm93qvi1so+g5GZDwMcACH4sBpW8Wv2esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100271; c=relaxed/simple;
	bh=1wNdSjbg5tRh3dMTBmjtbbkcd3rSjBMoG/xSPJIZT1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tj/TTFMyETeMenF3GRzgz73Wqg+gnzXGQ92iLnVjeDQ4ba5IuhdlzhWCe7T34CIwMU7wYDfT1ML+X4vp9w8QxM+OG9mfeBEL9JSzXu1AOFrBiBF5lA8Yus+b40btWj14sQqLYwVf6FgDNU2G2RfCrS7fF0VVgrsehTKKCrH1dbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YLhZ8Urr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GD3VNV002219;
	Fri, 16 Feb 2024 16:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=B4eyMajiTRUV1N5hgCQ1JZM85SAd3ezHL/YInFjHpd4=; b=YL
	hZ8UrrFO1p25b7bZ9BpKHg/JH/0ZE2O3HQpX1kMUY1EkyBa8AegeAmiBuxlzZoaI
	dQw0MaSPXoevghgDc8QMogmjga0yuUqHCFWFG2FpMGsIdDAr/wRop/uPecQGFNXY
	3JMSgNIMzFdvRmcrxiYLaqWpQ8ndUkYFNHmCoomOnxOvhshImtaruQucDZ2JzNK3
	7D3mgTEqfG37kbGJS9kQz3a3HrRzMdMY3uqh6/WsbOjnbs6r6FviMxgQo6lah6kz
	mjRUoioIuVxaZ/1EPSh/+agyGphX9d2RiDqk2Oa/gxaSqnQzp6Sdhrl4ayWS1Ohf
	OnBKDnDjCkFzsWuqsYfw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9fkfc17a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:17:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GGHdUw010327
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 16:17:39 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 08:17:38 -0800
Message-ID: <640dcd49-394b-1cc0-8cce-01aaabc751b8@quicinc.com>
Date: Fri, 16 Feb 2024 09:17:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: net: bluetooth: qualcomm: Fix bouncing
 @codeaurora
Content-Language: en-US
To: <quic_bjorande@quicinc.com>, <marcel@holtmann.org>, <luiz.dentz@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <quic_bgodavar@quicinc.com>, <quic_rjliao@quicinc.com>
CC: <linux-bluetooth@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240202181122.4118105-1-quic_jhugo@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240202181122.4118105-1-quic_jhugo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kVbLdiVGyazhhJ7RiokAvXEoMV4iz0lg
X-Proofpoint-GUID: kVbLdiVGyazhhJ7RiokAvXEoMV4iz0lg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_15,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=489
 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160130

On 2/2/2024 11:11 AM, Jeffrey Hugo wrote:
> The servers for the @codeaurora domain are long retired and any messages
> sent there will bounce.  Update the maintainer addresses for this
> binding to match the entries in .mailmap so that anyone looking in the
> file for a contact will see a correct address.
> 
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Rob, will you take this?  You seemed willing to take similar changes.

-Jeff

