Return-Path: <linux-kernel+bounces-158477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDD8B20AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B82E1C24E41
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3712AADD;
	Thu, 25 Apr 2024 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aW501Lv9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211A12BEB6;
	Thu, 25 Apr 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045694; cv=none; b=qy8OePd/RwEtoBPt6MVYQRJDT4FeWaQuNjPX0Nmrc61NgymN4y3nWh+dreuwf8OVwz7bqO2BOrvXnadsmfX7lPA6c+PcmlDuywrUt19gb0W7cqBb20vVbBAivM+00CeSHrIvRGkGDkDkLuXsL9z2MW64OBS0SHtUzZ8Men7JRGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045694; c=relaxed/simple;
	bh=HwCUhii1v+UVg/w9fnfv1IVtkJsyAJk/WRu0RrIN9fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ngttJ6BNJLtQ7dCW+KWN9K01iJo6FfKsTv+PXjkvENJ5+ibZK9cBLmr78TkwR9GOKtRMEXgmcgJukIe1hNPLb+G+Wy3pLmyMUOeyfrW3lpn5SP1VEccLMywBz5qBy93tKTbd6o23h+1Aao6WIv6HCaX4yAk6IZHp/xBXPuzFNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aW501Lv9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P9wuFT032483;
	Thu, 25 Apr 2024 11:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lU20Dpc0Wn36bS3HRI03h5cXxSl5AqSMPuJYeo3zz2Q=; b=aW
	501Lv9eGYZN6Q/nqLPxyBLz9jiqiR2OSSF3ajSYhm7Biw23Idog4oiBm9iz05+vJ
	mjY6KgQthlPSJ16rJQfMTrCyaHxrXb0beoTT5mKa/BhnZ3a256Rhf4uSGOfc4SLV
	ebM53eqD/RM93G4NbRVt9/lFSp4bv22WGUvWRmpu0uLl2hSZL17aQP9SJv71ntIt
	X7IOpSxBdVY3RhyY1jquzS2uaNAM5MLMQcPsLvfoWbISvzHub+qAHLngSLa/UZtz
	aLHgOXHCslUu5qXvhLMQxPv3ixNuZj4bJ3qNGMwGsFnQi373DYuQMqBvebWPUEPL
	8BnW20qWpKaGWFtmbuGQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqn0wgfx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:47:56 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PBluGN004162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 11:47:56 GMT
Received: from [10.216.8.145] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 04:47:50 -0700
Message-ID: <89c29d6c-173d-5b19-ce7d-9c2b7cec40f2@quicinc.com>
Date: Thu, 25 Apr 2024 17:17:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/7] ASoC: dt-bindings: document wcd937x Audio Codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>
CC: <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_rohkumar@quicinc.com>,
        <quic_pkumpatl@quicinc.com>
References: <20240425091857.2161088-1-quic_mohs@quicinc.com>
 <20240425091857.2161088-2-quic_mohs@quicinc.com>
 <3f961aca-6dff-4d51-bb0b-c974ed80b646@kernel.org>
From: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
In-Reply-To: <3f961aca-6dff-4d51-bb0b-c974ed80b646@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WAC75izVg2jaJXu22yxmMqVvbJbvqI1R
X-Proofpoint-GUID: WAC75izVg2jaJXu22yxmMqVvbJbvqI1R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_11,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250085

On 4/25/2024 4:31 PM, Krzysztof Kozlowski wrote:
> On 25/04/2024 11:18, Mohammad Rafi Shaik wrote:
>> From: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
>>
>> Document the Qualcomm WCD9370/WCD9375 Audio Codec and the soundwire
>> devices can be found on Qualcomm QCM6490 based platforms.
>>
>> The Qualcomm WCD9370/WCD9375 Audio Codec communicates
>> with the host SoC over 2 Soundwire links to provide:
>> - 3 TX ADC paths with 4 differential AMIC inputs
>> - 6 DMIC inputs that are shared with AMIC input
>> - 4 Microphone BIAS
>> - RX paths with 4 PAs – HPHL/R, EAR and AUX
>> - Stereo Headphone output
>> - MBHC engine for Headset Detection
>>
>> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
>> Signed-off-by: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> 
> 1. That's odd order of tags. Who created the first patch?

    First patch is created by : Prasad Kumpatla <quic_pkumpatl@quicinc.com>
> 
> 2. Last time you received report that this was not tested. Now there is
> again report.
> Are you sure you test patches before sending?
> 
   Yes i have tested patches multiple times before sending.

   In my setup the "make dt_binding_check"  became success, there is no 
errors.

   log:

   DTC     Documentation/devicetree/bindings/sound/zl38060.example.dtb
   DTEX 
Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.example.dts
   DTC 
Documentation/devicetree/bindings/sound/qcom,wcd937x-sdw.example.dtb
   DTEX    Documentation/devicetree/bindings/sound/qcom,wcd937x.example.dts
   DTC     Documentation/devicetree/bindings/sound/qcom,wcd937x.example.dtb
   DTEX 
Documentation/devicetree/bindings/soundwire/qcom,soundwire.example.dts
   DTC 
Documentation/devicetree/bindings/soundwire/qcom,soundwire.example.dtb

   Not sure why errors not coming in my setup,
   Will check in different Machine.

> Best regards,
> Krzysztof

Thanks and regards,
Rafi
> 



