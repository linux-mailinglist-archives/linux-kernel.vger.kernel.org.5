Return-Path: <linux-kernel+bounces-110719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6B78862DA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A531C2208E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB82136665;
	Thu, 21 Mar 2024 22:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Tp92+aJJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA73132489;
	Thu, 21 Mar 2024 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058574; cv=none; b=fJOQkY2wFSJc3OomCkMatPn37HniuxYZejQRAEdSH5uraYhl6VKFGhWoUUneyUNGoQpMFWwXn9WiZY5KEQ5h/gWjfOWKXDwQjAECyuH56hVcZAVxtCQEbblVMm+zn9Elzku389ZB0jY/zfEhbmc6LQkXFojhBxZ7qTdzTBoh0H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058574; c=relaxed/simple;
	bh=MZP+pDBk5yZGI71QJY70VMufwYlkMEV93+IrtS+YrBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r2RrGSu0FRwIAQTaWD7elOR3VCL6wk5Ub7fDggwna1aX9ffO2P22dlvCqgihQHdy3Fpg803AD9cqtY73fMZq74QPRPmS1rhwt22kR0uIcCSHe3mrxKgxeEc4wyD7pTylNOGZuf2rBxh33nr+AqdJ8Gqb6q8OsQMfW5B0XFVCDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Tp92+aJJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LLBsOp016222;
	Thu, 21 Mar 2024 22:02:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0FFtFPBGTzIpEtiJO1+Eeph0LCed5pNbdH8mu6v7l0w=; b=Tp
	92+aJJFRzBM9PuS/9XBP4v8Z1d0afFa2RtP6OLwd15hFSCghgMQx8hTsUGBTLAG3
	JbPJN93/RDUQWV0ZRSEanolknbDmTmjzNoScNw7q2MNpGneaO8t+Kl5paAv89h4F
	yIhJeQvxS0D09LKK3VcLBUYHo/I5F7OlfM7DIiCyU4fgzYAgcP3diwvSrHxZAMzx
	VAjSMBi+dA0J/UMvQnUShhwMsHxG33KW4Z3we1etBzZnPImwj04ync6MD2vKyNOH
	mEAftnOSeTV7Zabe4m0xPbysiq1z695skD+kchHjw/rBo/nJe22ukm+N/HU69KXQ
	d29R6+jigghMbixxwiGw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0r7q8ppu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 22:02:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LM2eJ4016945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 22:02:40 GMT
Received: from [10.110.74.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Mar
 2024 15:02:39 -0700
Message-ID: <5039256c-03eb-4cda-8d11-49e4561cf1ef@quicinc.com>
Date: Thu, 21 Mar 2024 15:02:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath10k: allocate dummy net_device dynamically
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Breno Leitao <leitao@debian.org>, Kalle Valo <kvalo@kernel.org>,
        Jeff
 Johnson <jjohnson@kernel.org>, <keescook@chromium.org>,
        "open list:NETWORKING
 DRIVERS (WIRELESS)" <linux-wireless@vger.kernel.org>,
        "open list:QUALCOMM
 ATHEROS ATH10K WIRELESS DRIVER" <ath10k@lists.infradead.org>,
        open list
	<linux-kernel@vger.kernel.org>
References: <20240319104754.2535294-1-leitao@debian.org>
 <9fcdb857-da62-4832-ae11-043fe993e4ad@quicinc.com>
 <20240321072821.59f56757@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240321072821.59f56757@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 18rkzDPrhtFQ_wRo6TOTlnCsMpXcyT9N
X-Proofpoint-GUID: 18rkzDPrhtFQ_wRo6TOTlnCsMpXcyT9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210166

On 3/21/2024 7:28 AM, Jakub Kicinski wrote:
> On Wed, 20 Mar 2024 08:12:46 -0700 Jeff Johnson wrote:
>> NAK this based upon the ath11k patch results.
> 
> The ath11 patch is much more complex, I'd wager this one is fine.
> 
>> As suggested there we should just use kmalloc/kfree to match the existing logic.
> 
> Please no. There is no magic here. alloc + free must match whether
> you're using magic object alloc wrapper (alloc_netdev()) or straight
> up kzalloc().

Based upon the ath11k patch there must be something going on with
alloc_netdev()/free_netdev() that doesn't occur when these aren't used.

So I'm just suggesting that instead we use kmalloc() and kfree(), which are
matching functions, and which, like the existing code, are not subject to
whatever is happening in alloc_netdev()/free_netdev().

I don't understand your objection.

/jeff

