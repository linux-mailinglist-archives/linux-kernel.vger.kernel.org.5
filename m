Return-Path: <linux-kernel+bounces-157981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 394E58B19BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F668B23908
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28C2C19E;
	Thu, 25 Apr 2024 03:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MU+Gu4oM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633658468;
	Thu, 25 Apr 2024 03:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714017352; cv=none; b=PG6g+5ll1pzRsPSzkltk6Go3lI+XCF+gTpUlHm13Td145nvzapH0aV8BSgTI6bgMNpl9g6s0y2fmALJ/12cV/tp8Oe1e+A5q9xf1S87BO+7anjFfwO13n0xkYz59m2mN0cXW6k/sTWSbmIcrf8jKvKGkP8yUWMBrLxuFvp1IqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714017352; c=relaxed/simple;
	bh=hEBhp3aA+qmWAFzbPmNzxTz2dCevz5xEmpYM2xZURXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E4uy+fbR3EA3SKSe70NHl8NFuZ79E5ADsWflFV8clrEVN7ffQszr2qMdZuUMf8VE4DQVVYY1bv4imueBZ7seBkbZCP678ot9C9amq79mSJsdC5DAyY9zF/jUts3TJuDMuAvgf2vWJfi2BGPq6Ht6j054jIkAFdE3Tj95MWij9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MU+Gu4oM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P3I4xB013632;
	Thu, 25 Apr 2024 03:55:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EjulsxaA/iLKcO8IMu1Nnol3u4Ujnd7ckOcRYxy8ve0=; b=MU
	+Gu4oMU+R6u3By2CqVhzkUmDPUVQac/qy+STeMqIgfc6JJi+GxyrK6gZUN1/MYCR
	C10trD5wIEpToOMc/i1m8x3tmwmTl3Sb5sjUQ5qlsVuoTKyA/aUMvlwcxXlokiPJ
	KWzClVek3FscLIBl7a5430f3wURg0ZxNdXII3pWuIBjM+3Ijb4DP7no2n/9iqhGV
	DvO4e6PNaYxrLpmhXEk7Haf3CCnoD81P8zrB5Ow4GQeB6HmO1j8rK30rC2IGfpC9
	P3VOu9VMhHIDQit+wKLpvlExI+nqtTu3yCBifprZkFdkBJjCZhtAlXxRRQwZ0tB+
	SUuF0jGa7oh7LCvrOnvw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenmr49w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:55:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43P3tlmI006147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 03:55:47 GMT
Received: from [10.218.35.239] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Apr
 2024 20:55:45 -0700
Message-ID: <f90ddc4e-f3da-3dbf-6414-7852698b6bb3@quicinc.com>
Date: Thu, 25 Apr 2024 09:25:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH] usb: dwc3: Poll CMDACT after issuing EndXfer command
Content-Language: en-US
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng
	<quic_wcheng@quicinc.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>
References: <20240422090539.3986723-1-quic_prashk@quicinc.com>
 <20240424013342.5itkoewx7jdonyk4@synopsys.com>
 <168904cd-4806-0473-085d-43df45efba65@quicinc.com>
 <20240424223618.utauunrz7nud5wfi@synopsys.com>
From: Prashanth K <quic_prashk@quicinc.com>
In-Reply-To: <20240424223618.utauunrz7nud5wfi@synopsys.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KnAmfMbjZNeXBw9m5Ex7Ob8Nxoe50088
X-Proofpoint-ORIG-GUID: KnAmfMbjZNeXBw9m5Ex7Ob8Nxoe50088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_02,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=966 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250026



On 25-04-24 04:06 am, Thinh Nguyen wrote:
> 
> Thanks for the data.
> 
> Ok, I remember now why we did what we did. I just notice the Fixes
> commit you tag: b353eb6dc285 ("usb: dwc3: gadget: Skip waiting for
> CMDACT cleared during endxfer")
> 
> I forgot that at one point we skip CMDACT for End Transfer command.
> Let's not poll for CMDACT for End Transfer command and unconditionally
> wait 1ms. Otherwise we may run into the issue being stuck with CMDACT
> again while SETUP packet is not DMA out again. 1ms should be plenty of
> time for the End Transfer command to complete.
> 
> It should look like this:
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index f94f68f1e7d2..dad30c6ab19d 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1724,8 +1724,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>          dep->resource_index = 0;
>   
>          if (!interrupt) {
> -               if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
> -                       mdelay(1);
> +               mdelay(1);
>                  dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
>          } else if (!ret) {
>                  dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
> 
> Thanks,
> Thinh
> 
> Ps. also please Cc stable.
Thanks for the suggestion, I had tried 1ms initially when encountering 
the issue and it was helping. Then I thought that CMDACT polling was 
better approach. But anyways I echo you, having common solution for all 
controller revisions is the cleaner way. I'll send V2 with mdelay(1).

Thanks again,
Prashanth K

