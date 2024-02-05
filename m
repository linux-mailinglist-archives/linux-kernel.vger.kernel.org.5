Return-Path: <linux-kernel+bounces-53246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD1A84A2A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6D01C20F22
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19F481CD;
	Mon,  5 Feb 2024 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gBgAJ3IY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830E48796;
	Mon,  5 Feb 2024 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158612; cv=none; b=S+irNdiXj3NckLfZzjeoIek+j/GEBWp6iwzK+RA9sc12MtJ6jtiltEE5BS+PvnmPvJXSDL6R9fd2lqDl0s9fhL8tfJLTo9maY++z6eiEzoy5s/WmHFxOjQAFU1EFo2AU0KMw9smNpEuiAO72+VnUkSoA1G+RA8dZKkehwsHAb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158612; c=relaxed/simple;
	bh=QlgzPgs6KCB4COcwRVJDbUMBhSrCoN/54lajE9rvpI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NZ2bZDa7d/PVfoq22TJ0STbh94zPw+0CdneDicnGteiE4Z7LQlIQYiTCjc5uu2uCOrrtOfgY1eduwEKRarezsFzFTxVJZxcBPO5s2544kP/eTMpgSfo1MCnnGsZlHxJxCT1NzDf0NbmLakNktqmOV8GN0kxkyXPJE/PyroVLAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gBgAJ3IY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 415Ado7U025429;
	Mon, 5 Feb 2024 18:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4ZWfCHX4P4mlG3MlnCZlj7DBCqdL6mjOYU2eJew/9K0=; b=gB
	gAJ3IYsf82/V/OXH5V6LKEf7Zn8fNNE9NGQS038fIidvS7L5Zlj6Hthpgr73DhJv
	7mzfePExJdKlnxTyNm5zENNC3xWyrjKmft6VFaTrdGMAIIMdihrZVKw6VPX/CCnE
	/8Gwv7GLiCEoHM0IP0z3n0T0QIZL2Im2CU+6U8nXXwlB5qHupHpie4GkJDWOyEgI
	1hXqZeBx0miKTWn4AkXe/Vjr1nHroD2nDNqfWoAQrj8aR9ZTNEJCGN1uOANgyuLc
	XkV1EEK2Q16HaWgEdqDzhr0HQfzI2qNU1vZ710/e+EpVk0ztKQ2UTjpxoDK0kfSK
	mnJgiTRv+txSxL7X4pzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v729e3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:43:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 415IhPSf026192
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Feb 2024 18:43:25 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 10:43:24 -0800
Message-ID: <1d1db241-c4e3-75f8-5dc3-69598bf4ec76@quicinc.com>
Date: Mon, 5 Feb 2024 11:43:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] dt-bindings: clock: qcom: Fix @codeaurora email in
 Q6SSTOP
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240202171915.4101842-1-quic_jhugo@quicinc.com>
 <20240205183338.GA3905881-robh@kernel.org>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240205183338.GA3905881-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XMKFtqzjRdtXP_s1gu_eudgW1S5OnsA-
X-Proofpoint-ORIG-GUID: XMKFtqzjRdtXP_s1gu_eudgW1S5OnsA-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402050141

On 2/5/2024 11:33 AM, Rob Herring wrote:
> On Fri, Feb 02, 2024 at 10:19:15AM -0700, Jeffrey Hugo wrote:
>> The servers for the @codeaurora domain are long retired and any messages
>> addressed there will bounce.  Govind Singh has left the company which
>> appears to leave the Q6SSTOP clock controller binding unmaintained.
>>
>> Move maintenance of the binding to the Qualcomm Clock Drivers maintainer
>> as suggested by Bjorn Andersson.
>>
>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>> ---
>>   Documentation/devicetree/bindings/clock/qcom,q6sstopcc.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> How about the rest of the tree?:
> 
> Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml:  - Sandeep Panda <spanda@codeaurora.org
>>
> Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml:  - Harigovindan P <harigovi@codeauro
> ra.org>
> Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml:  - Odelu Kukatla <okukatla@codeaurora.org>
> Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml:  - Kiran Gunda <kgunda@codeaurora.org>
> Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml:  - Balakrishna Godavarthi <bgodava
> r@codeaurora.org>
> Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml:  - Rocky Liao <rjliao@codeaurora.o
> rg>
> Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml:  - Shyam Kumar Thella <sthella@codeaurora.org>
> Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml:  - Srinivasa Rao Mandadapu <srivasam@
> codeaurora.org>
> Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml:  - Sai Prakash Ranjan <saiprakash.ranjan@codeauro
> ra.org>

Most of these already have patches posted with updates.

The following have not yet been updated as we are looking for a new 
owner.  Hoping to have someone identified this week so we can post updates.

Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml:  - Shyam 
Kumar Thella <sthella@codeaurora.org>
Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml:  - Sai Prakash 
Ranjan <saiprakash.ranjan@codeaurora.org>
Documentation/devicetree/bindings/display/panel/visionox,rm69299.yaml: 
- Harigovindan P <harigovi@codeaurora.org>

-Jeff

