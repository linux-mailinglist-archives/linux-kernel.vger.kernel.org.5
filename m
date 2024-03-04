Return-Path: <linux-kernel+bounces-91326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193C870EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85A42B27399
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848667BAE6;
	Mon,  4 Mar 2024 21:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F05ipFzq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D41E10A35;
	Mon,  4 Mar 2024 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588792; cv=none; b=gSHo90drCFaStRAm9cWBuMCfNo/DgEakhtbSbKFzLDN2SQiZ7osiqfiXxddeg6+JjT/D5SyN1VAdL1xGFhpRNV/qoe5+zrbB/AhJUKahxn8LHnKcnB7ALMUxkIMCBxxUA5pxNit6ARnKgt46s8gbPP5+nJoayqCeJwVloq/6+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588792; c=relaxed/simple;
	bh=PkIAzelvrlhN7PE4DU9IpFBpQgozAf+D/ekjzn1DMXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lNVn2bMxTzU4onpVDc7qEkiWlUQE2G7m0sa+Ubg+YkP1CSRbYXZzWWakEXVsdcGfF0MwrR4Y2WINsU5qeDqLt7a6PUT5MhkhPtuc3oMZZgAGDnNCcnth8ehnvxgYiLBNkpyG7jT6hO+IhP4G+zfBAgG9C0wHyqqfNzWROY26wHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F05ipFzq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424Hb3bO030620;
	Mon, 4 Mar 2024 21:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=peMhEB7LCKrCHa9OQkkEzlMT5kXB97fl2hhCe2/Uhp8=; b=F0
	5ipFzqX2DqedTwKQaNkZu0i6fINNBBHXpMl40gfvSLuBSV57UHwkxOszjHIuW0/h
	ifk1VaqNMcungqiqp4moEj7SzADlppz1D8M2USpjKpMuJ9zcMb2g7YvL1k4B7FN4
	wegXQgkTKLhcZt/bJsxnn5qMiN6Fpn0QPseA/Tw+FXS6IQBdQFaBrgzTrfyIEIvy
	mqIavOUbDdADtWCcoA89r+W79jHTSPFd2PRM8bxYv6/CbDx0q5H5T0MjWijBd/D8
	8o1AJ7zKp5JwKj8yaNDEIDMesTMTZCtNlT2dGXzpuWs3kZCYuRJNHNkMJiTxe7Rf
	r45sRoG7jOjKe7dAUEAg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn8fxsys0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 21:46:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 424LkBW2008665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 21:46:11 GMT
Received: from [10.110.86.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 4 Mar
 2024 13:46:10 -0800
Message-ID: <228772c6-034e-4727-b410-391316d8f340@quicinc.com>
Date: Mon, 4 Mar 2024 13:46:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: build ath12k as a module
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven
	<geert+renesas@glider.be>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arnd
 Bergmann" <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Marek
 Szyprowski" <m.szyprowski@samsung.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240219084610.11007-1-brgl@bgdev.pl>
 <CAMRc=Md0H4=UZWNOoZR3-b50BrF-ch=34aPdqm2JhOXQzNi-mQ@mail.gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <CAMRc=Md0H4=UZWNOoZR3-b50BrF-ch=34aPdqm2JhOXQzNi-mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZlLrK936vgFL4t36CuSf9fGamDQGBLFA
X-Proofpoint-ORIG-GUID: ZlLrK936vgFL4t36CuSf9fGamDQGBLFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_18,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=666 clxscore=1015 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040169

On 3/3/2024 2:34 AM, Bartosz Golaszewski wrote:
> On Mon, Feb 19, 2024 at 9:46 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> Qualcomm sm8550-qrd and sm8650-qrd boards have ath12k modules as part of
>> their on-board WCN7850 WLAN/BT packages. Enable the relevant driver in
>> defconfig.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Would have been nice to cc the ath12k and linux-wireless lists (done
now). Just happened to stumble across this.

As an ath12k maintainer--
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

>> ---
>>  arch/arm64/configs/defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 056a6cc546a4..3f3d3350cf90 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -408,6 +408,7 @@ CONFIG_WCN36XX=m
>>  CONFIG_ATH11K=m
>>  CONFIG_ATH11K_AHB=m
>>  CONFIG_ATH11K_PCI=m
>> +CONFIG_ATH12K=m
>>  CONFIG_BRCMFMAC=m
>>  CONFIG_MWIFIEX=m
>>  CONFIG_MWIFIEX_SDIO=m
>> --
>> 2.40.1
>>
> 
> Gentle ping.
> 
> Bart
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


