Return-Path: <linux-kernel+bounces-155380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D808AE99A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369AF2896DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A01136E2C;
	Tue, 23 Apr 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BIMc3oNX"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E8C5103D;
	Tue, 23 Apr 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882769; cv=none; b=T3FOs7U9cRFe8LMqMiEf1K+XMGKxHx12t30194+NumCFoJgmBfi5713aE5sj+7ufRUYtPN5i3mGbUz7YXxl/qv3eLjGvOXtnCaR9BbzWAt/GyQTRCwEFkM81Mbk0tlM4Hp1U7W19RrPH1ZzKUIOWRRBOUBSnIiI6WMrjcZJnIzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882769; c=relaxed/simple;
	bh=tioOk9waW8zUZj6/WeQiRb7+mddkLAF9bGd372R4d6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tc9tH2UewgI/31hUd3/hLaBMQXEmAgb0qumpoDmjqvzgmlsDgDwCWm7GIypjw42A/uvDn7HISW1X02bti+RGR2MgTLvAzhr8RQr7PM+5GdfN7i19jgksD4OkGtccD+Zpnj0G4BWb5LVWp12kCdferu0BMHDgSiBZObX2IDJN6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BIMc3oNX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N889eG006371;
	Tue, 23 Apr 2024 14:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EAvQrX4BSekjivlHtLJDsPcMwUtP1BkueQBEmSyAHkc=; b=BI
	Mc3oNXUrWjdGgvz8iJyKK9L+QNRvigf5yKPf/flVVvgY9jRGh3SEoVWVL2aPcG5J
	Aca279V67Pzc/R8owBoICXwv1dZ3SCBaNuF6Pyi68qBPboYB5rh91BbUcbjkfTs0
	fD4TxZ3lsToNHpiB/nacCjjaFV5CZAU3QUdjI4et3FGz12/qAdoo8teGQyM/f3VA
	IlIIQgx8o+D5laGXKCnEP0vZFUjxMdDAqorbwLAhjx0AxxQcVXyyh3NDaZDyMucv
	Kpmvk1/HwrJBn964Z7nJvujmLK+0EMTH/sH7r+FupHX6YDgTWxdNDGCEN5T51ok3
	8hVeEkiUvT004HnrmVQg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp978s2p8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:32:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NEWedO028273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 14:32:40 GMT
Received: from [10.110.61.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 23 Apr
 2024 07:32:37 -0700
Message-ID: <d024a0b0-46aa-4182-a8e8-8ff15f12c363@quicinc.com>
Date: Tue, 23 Apr 2024 07:32:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] of: reserved_mem: Remove the use of phandle from the
 reserved_mem APIs
Content-Language: en-US
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, <robh@kernel.org>,
        <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20240422235243.2878536-1-quic_obabatun@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240422235243.2878536-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BtMjyA9RB0Z0TC52-uuRSxD3hHVR1mW2
X-Proofpoint-GUID: BtMjyA9RB0Z0TC52-uuRSxD3hHVR1mW2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=564 adultscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404230035

On 4/22/2024 4:52 PM, Oreoluwa Babatunde wrote:
> The __find_rmem() function is the only place that references the phandle
> field of the reserved_mem struct. __find_rmem() is used to match a
> device_node object to its corresponding entry in the reserved_mem array
> using its phandle value. But, there is already a function called
> of_reserved_mem_lookup() which carries out the same action using the
> name of the node.
> 
> Using the of_reserved_mem_lookup() function is more reliable because
> every node is gauranteed to have a name, but not all nodes will have a

s/gauranteed /guaranteed /

(jumped out at me while scanning the kernel patches)

