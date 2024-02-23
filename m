Return-Path: <linux-kernel+bounces-79284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B1E862009
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2B528636C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C4145B1B;
	Fri, 23 Feb 2024 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KA6FPh/X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A880722071
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708728588; cv=none; b=CWN9/o5g2eDJuAzVBiY2z3WVD1iu69uo3MNAt6Dsno3iVn8mPh4vHos0lG0WEOaEdqXtXm2Nwgrw2lE/LXc+tfZAF+PSAaSwqlCmdVA6U/fQvz5piswxl1yIlz7xbib9vYja7Ijosd+n/psDHEKz5byhuxkZrmORUhS7ah3O3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708728588; c=relaxed/simple;
	bh=Ks7SPo78oCrLIrhI6M6LYwjO/3m/3moSduoTQS1S5zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B7nw2/d0C4nIO7Ss1mUWyhnRtNK7QmMciHk26lcfnXehKj12++qe+jmCvk3BMPO1z/8dqaTYrYUv/6GF3ZvNIP15i58idBm1ji4xYa1Gnv95pjFZGZmg8YDqwPGZg9ouidmeUX6K78MbXiCuqY/I9j+I/B5yF3WQz1UxfZi0qjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KA6FPh/X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NMcKin032764;
	Fri, 23 Feb 2024 22:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vpuMZEv0YbceRccZms8eDrrRnXr2s8qE9PX8b5ibpy4=; b=KA
	6FPh/XaF+dcbUczrbIzxooHF9ARQIQN0nZr8kvcNtP0f4Y2Ca8vej/g76TSDM8S0
	TCRySNWFoxukwPxaosRADjk9lpHmL5+UR7R+XTTUjlTw6IcBut0GPv8hV69cHyvp
	+5YEj6fm7bzfuQ+gz5tPu5veIGD8dIViV7QxA3aj0LtkRAFDzuSeM6oeAMMF+Ftr
	x7sGRGzo49G0+pfzZevnsAb6M8tPx5zR0hP0ebhHwLxhfx4PLFXe9nhrR4UlE5II
	CocBqnJNK1n/SLRUaNqQJ6WXTDkH0wuwgTD434TzZapthS1wiM0Bxt7K7/D2ZMMF
	Y+aT5D4+w7SxpWJADquQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wew8c10am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:49:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NMndUN008695
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 22:49:39 GMT
Received: from [10.110.73.113] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 14:49:38 -0800
Message-ID: <661f8027-eb7d-4e70-d732-91d1ab0a796b@quicinc.com>
Date: Fri, 23 Feb 2024 14:49:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] accel/habanalabs/gaudi2: check extended errors
 according to PCIe addr_dec interrupt info
Content-Language: en-US
To: Oded Gabbay <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC: Tomer Tayar <ttayar@habana.ai>
References: <20240220160129.909714-1-ogabbay@kernel.org>
 <20240220160129.909714-4-ogabbay@kernel.org>
From: Carl Vanderlip <quic_carlv@quicinc.com>
In-Reply-To: <20240220160129.909714-4-ogabbay@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h3FFhBRVOBm8W00Tal8S4cds8mgh0LZ2
X-Proofpoint-GUID: h3FFhBRVOBm8W00Tal8S4cds8mgh0LZ2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_06,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 clxscore=1015 mlxlogscore=723 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230163

On 2/20/2024 8:01 AM, Oded Gabbay wrote:
> From: Tomer Tayar <ttayar@habana.ai>
> 
> The FW interrupt info for a PCIe addr_dec event is set correctly, so
> check for either global errors or razwi according to the indications
> there.
> 
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> Signed-off-by: Oded Gabbay <ogabbay@kernel.org>

Reviewed-by: Carl Vanderlip <quic_carlv@quicinc.com>

