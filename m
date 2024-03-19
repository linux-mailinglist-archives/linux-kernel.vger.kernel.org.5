Return-Path: <linux-kernel+bounces-108215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B5880793
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B68128452C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8855FDB4;
	Tue, 19 Mar 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R1FSve7Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402C604AA;
	Tue, 19 Mar 2024 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710888886; cv=none; b=MmECEHgey1B5iddYGnayNFn+j7v5guerb8LPwS+o/KXyRSI5wWlsNyaZx9AC4NHBgefoTThK9E8CkqteUIpjqQMtK5Kz2/YYd3XSazqLFUXvKmLHBfQBBR9PUbAg3/70ko9NMxCvVqoqt064ZgS+D4y0pPTVQ9VDWvTEbh2eCH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710888886; c=relaxed/simple;
	bh=SApLnzf9V9paj7A27Dp2wAi/qBGP4wIFVkmJyrYbWmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BkbDTp6zBOUfBQ5fiCW40zF9I0ZftAYJCfaesdd81nP0UlkmMRA/QnxB4S/3CVt9uYvtvC4r+7Cu7tYqMmhnZWqsh29pCKHc8VcqeG9tfv1X1+h6WXFcHcGfsp5yhwB62oqFF8BXe0vypwPzxPps3ebL0C5pz57KHYJG1u8Th0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R1FSve7Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42JMfsZR006654;
	Tue, 19 Mar 2024 22:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ukAH7JGYlF+FVSLp4/U8HRgc2Qj8dfLCCawIfIhcZ9Q=; b=R1
	FSve7Q7z0b0p4XD1BWSEcu7iFPCjdOZcC2x0oqLV+VD42AE1zyvmfmZVJVbUOGKZ
	5H082+6YsLd4YCNxP95Vlf+VVeCgKrrdjl1PfdFfbwBU7yZv1dFg71SjR20s5A9q
	NlOdpno8xeKn4wA8Cj8bfxYEZoczGD0L5YPLj/dyyJUSpMzbt84gcX70b5XhDSOn
	aRJ/KueWd9DdFlPiozvX8Eq0bkhlq2swOXwdTruB05QKNA6qcbSISokOBtXKxBra
	8aVQraQiEbAHyEde3IQxk1zCtsp3AcoplAIXYs3FaZP8DoBocMTyKdVkrWqEou9/
	BoAmhOsHrxzxm8c+HDMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyh8e0acn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:54:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42JMsThT018329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 22:54:29 GMT
Received: from [10.110.120.226] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Mar
 2024 15:54:28 -0700
Message-ID: <328306d9-953f-482b-bf9a-a753d7d4e2ed@quicinc.com>
Date: Tue, 19 Mar 2024 15:54:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] wireless: ti: Can we just remove this flexible array?
Content-Language: en-US
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo
	<kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <3a531d5b-9bf6-4e88-ba8c-a76cfa95be20@embeddedor.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <3a531d5b-9bf6-4e88-ba8c-a76cfa95be20@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aVjG2jj2h7EngEFGX_zsXtDYP-B3f0I2
X-Proofpoint-GUID: aVjG2jj2h7EngEFGX_zsXtDYP-B3f0I2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 mlxlogscore=684 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 impostorscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190176

On 3/19/2024 2:59 PM, Gustavo A. R. Silva wrote:
> Hi!
> 
> `struct wl1271_cmd_header` is currently embedded in multiple other
> structs, and it's causing many `-Wflex-array-member-not-at-end` warnings.
> 
> Has this flexible-array member been used in the past or is it intended
> for future use?
> 
> Otherwise, I think we could just remove it.
> 
> diff --git a/drivers/net/wireless/ti/wlcore/cmd.h b/drivers/net/wireless/ti/wlcore/cmd.h
> index f2609d5b6bf7..4c2f2608ef3b 100644
> --- a/drivers/net/wireless/ti/wlcore/cmd.h
> +++ b/drivers/net/wireless/ti/wlcore/cmd.h
> @@ -208,8 +208,6 @@ enum cmd_templ {
>   struct wl1271_cmd_header {
>          __le16 id;
>          __le16 status;
> -       /* payload */
> -       u8 data[];
>   } __packed;

I'd think you should just remove it



