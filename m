Return-Path: <linux-kernel+bounces-90114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3AC86FA83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85791F210DB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5C134B4;
	Mon,  4 Mar 2024 07:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I/a/xaxO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DEF53A6;
	Mon,  4 Mar 2024 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536298; cv=none; b=s9LaqqGJtOyEuAGI6eK6FCE2xPlnyQhYURCPevQUjpW3lUxG2SI2BFnbIqgwS6kpGPqwB/zdR5K68LBbtp/vwmIwokYOpSX/7zoz75653vIokNHkGl/FStMQzh54OqbuFx5x3UewzTCi+z0O7qTusrImk0krLwHZ6KHmZqc6kNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536298; c=relaxed/simple;
	bh=yEOEQXF0H2FBhoJGXkIL2OPkt58wIm8TcWBWFZyvlDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZQSMTZmPiqQH29QLge7k9K24syulev2Db3K0cKmxVYWzASOMc2JDP8vKU2kUEsWlQ0QfhkR2XXLWhAU4rG3/lVu8GVHEGtch/RlODjsFyuzs1+a3GO9mihVmp16VLSZD5znDopHGzikutdD6U8Vwff29dmg0gdhufRLO8vGvIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I/a/xaxO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4245rRuB023986;
	Mon, 4 Mar 2024 07:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8xdavV9VxJS3gbSMA4GVJCJSFzEE4ysqGE/5kUmjQy4=; b=I/
	a/xaxOd4LUiJyOWyBdoCCfA9zkxTu/FpFpLLMMLTQ324ZJjWPVCqu3cX42n/CmXz
	11xIRsbCUMxeTB0INu/3iOJ9Iz2kuCJR1YjWbMldoCgcIS8fleaV4B+5MvlY7gQL
	Qx5Cbmbk779kSANxJqYvw2dzRu1OUyjYZH5O4qBjX9Tg4KTMRsjW5mG2dNUsI630
	xwDPMDNdKRs/1GTf1l+d9A4D9kpvV/0vdXjzBCEZxKXlQx77aeBJ2dJWLltOfvfV
	Zx61wLQn1yl4iH0L8udrr23JPyLzK1XbS5K6rIf2/I3szcFMsHs+nu2dPF64qdfc
	0QqkdPAVnpYt44a5YvrQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn6qx09mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 07:11:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4247BU0D016409
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 07:11:30 GMT
Received: from [10.239.105.140] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Mar
 2024 23:11:28 -0800
Message-ID: <e2e5a7a0-7a2b-40d3-acf7-6f0b91bd5d40@quicinc.com>
Date: Mon, 4 Mar 2024 15:11:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
To: Harald Mommer <Harald.Mommer@opensynergy.com>
CC: <quic_ztu@quicinc.com>, Matti Moell <Matti.Moell@opensynergy.com>,
        "Mikhail Golubev" <Mikhail.Golubev@opensynergy.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        Viresh Kumar
	<viresh.kumar@linaro.org>,
        "Mark Brown" <broonie@kernel.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
Content-Language: en-US
From: Haixu Cui <quic_haixcui@quicinc.com>
In-Reply-To: <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TRfS_aeVgQMiISkc-z98zurtH--oPIV3
X-Proofpoint-ORIG-GUID: TRfS_aeVgQMiISkc-z98zurtH--oPIV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1011 adultscore=0 spamscore=0 mlxlogscore=732 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040053



On 2/13/2024 9:53 PM, Harald Mommer wrote:
> +static struct spi_board_info board_info = {
> +	.modalias = "spi-virtio",
> +};

Hi Harald,
     Do you add "spi-virtio" in spidev_spi_ids in spidev.c when you 
doing the tests, to probe spidev driver?

Thanks

