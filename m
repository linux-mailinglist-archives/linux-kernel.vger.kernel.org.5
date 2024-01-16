Return-Path: <linux-kernel+bounces-27714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3D82F49D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23FAFB22155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAE51CFAD;
	Tue, 16 Jan 2024 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EYvnLMYD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A501D520;
	Tue, 16 Jan 2024 18:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431018; cv=none; b=HsRLyvFNEO2MkQuBC5FpPDdZjhFrlgCKhBS+YtGz3sSO1mbE4BNdoX7V0F/YDDLT1nK/rZqbnc/uFGL0o/rkZ9oTceluO1CPiVrPfBy+44NYnCGqrJIYmYBeUwzWyZI+X/UXDf/YuW9nm+gSZkkeflXSQjXu0ITNjqSqb4uo69U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431018; c=relaxed/simple;
	bh=u9HtAreXvZzRNiP6Z/mv4lczqcqgpaGLfP2V36U+ZO8=;
	h=Received:DKIM-Signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:CC:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Originating-IP:X-ClientProxiedBy:X-QCInternal:
	 X-Proofpoint-Virus-Version:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details; b=O1PmgqplueSvGIQJPSCiLfQH20XwdN/fX4jdnCRgz44Nd/UC70JeEojwcpdH+x1ek+zMv7olqlQlFlrCP0WVAKGCwOYx4eZmxZ7ZEx9f1A5ktQ7rq27wxP1eWRkUi0rh+nUpg4Wpt0//mWuj/4tSxA9N389ISwfdWZ0pdoGNIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EYvnLMYD; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40GHJqcE002807;
	Tue, 16 Jan 2024 18:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RhJ8xMqSq4+fViYmhVIvXju/z80MFnRKlqjM76zqqC8=; b=EY
	vnLMYDbg+PpcPxubij3rLp7H+lyFZmVAvrPDIDYnk6+NmTyVKZ0dZT6pu1l+8JUy
	qmqx6H+RhL3QWuWwbUEOxrI7GOE6FDIMP7VL1dEMf1A4b7uUkS4t0ZTqld9HgXgk
	bK5xfvSI3PuhSaE7Hy+crhuiz5XFz24cRn/F+qxKoBY0ntDWWezS6m9chfXQkAJ2
	S6Zdyr0dtXbRfrkQeYZHafd93/adpNV8AV7AK3mprx+tQeXpkV+gPKAeORjV6g6V
	p/afQoEnPKV6sQrZpOVQ5iTvquGhoNEdnPZ43Iu23FK29RUeut1MoWfPL2VXzzT4
	92CiJEZqhb8LStdsyLUQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnnajhm3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:50:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40GInwWh009909
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 18:49:58 GMT
Received: from [10.110.59.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 16 Jan
 2024 10:49:58 -0800
Message-ID: <dc8a58ab-00df-bfd4-39f7-ec196e578260@quicinc.com>
Date: Tue, 16 Jan 2024 10:49:49 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: (subset) [PATCH v8 0/7] Add support for LUT PPG
Content-Language: en-US
To: Lee Jones <lee@kernel.org>, <pavel@ucw.cz>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC: <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <quic_gurus@quicinc.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pwm@vger.kernel.org>
References: <20231221185838.28440-1-quic_amelende@quicinc.com>
 <170496750168.1654525.11132648331912183091.b4-ty@kernel.org>
 <20240111100747.GM7948@google.com>
From: Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <20240111100747.GM7948@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nCYl4rsDxYDo4V1V6G-YW2wRQ5an-h_m
X-Proofpoint-ORIG-GUID: nCYl4rsDxYDo4V1V6G-YW2wRQ5an-h_m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401160148



On 1/11/2024 2:07 AM, Lee Jones wrote:
> On Thu, 11 Jan 2024, Lee Jones wrote:
> 
>> On Thu, 21 Dec 2023 10:58:30 -0800, Anjelique Melendez wrote:
>>> In certain PMICs, LUT pattern and LPG configuration is stored in SDAM
>>> modules instead of LUT peripheral. This feature is called PPG.
>>>
>>> This change series adds support for PPG. Thanks!
>>> Changes since v7:
>>>   - Patch 4/7
>>>     - Initialize hi/lo_pause variables in lpg_pattern_set()
>>> Changes since v6:
>>>   - Patch 2/7
>>>     - Removed required by constraint on PPG dt properties
>>> Changes since v5:
>>>   - Patch 4/7
>>>     - Update logic so that multicolor led device triggers pattern
>>>       on all LEDs at the same time
>>>     - Update nitpicks from Lee
>>>   - Patch 5/7
>>>     - Update nitpicks from Lee
>>> Changes since v4:
>>>   - Patch 3/7
>>>     - Get rid of r/w helpers
>>>     - Use regmap_read_poll_timeout() in qcom_pbs_wait_for_ack()
>>>     - Update error path in qcom_pbs_trigger_event()
>>>     - Fix reverse christmas tree
>>>   - Patch 4/7
>>>     - Get rid of r/w helpers
>>>     - Update variables to use "sdam" instead of "nvmem"
>>>     - Fix comments
>>>     - Fix reverse christmas tree
>>>     - Update lpg_pattern_set() logic
>>>   - Patch 5/7
>>>     - Removed sdam_lut_base from lpg_data
>>> Changes since v3:
>>>   - Patch 4/7
>>>     - Fix function returns
>>>     - Move register definition to top of file
>>>     - Revert max_brightness and probe accidental changes
>>>     - Combine init_sdam() and parse_sdam()
>>>     - Change error prints in probe to use dev_err_probe
>>>     - Remove ppg_en variable
>>>     - Update when pbs triggers are set/cleared
>>>   - Patch 6/7
>>>     - Remove use of nvmem_count
>>>     - Move register definition to top of file
>>>     - Remove lpg_get_sdam_lut_idx()
>>> Changes since v2:
>>>   - Patch 1/7
>>>     - Fix dt_binding_check error
>>>     - Rename binding file to match compatible
>>>     - Iclude SoC specific comptaibles
>>>   - Patch 2/7
>>>     - Update nvmem-names list
>>>   - Patch 3/7
>>>     - Update EXPORT_SYMBOL to EXPORT_SYMBOL_GPL
>>>     - Fix return/break logic in qcom_pbs_wait_for_ack()
>>>     - Update iterators to be int
>>>     - Add constants
>>>     - Fix function calls in qcom_pbs_trigger_event()
>>>     - Remove unnessary comments
>>>     - Return -EPROBE_DEFER from get_pbs_client_device()
>>> Changes since v1:
>>>   - Patch 1/7
>>>     - Fix dt_binding_check errors
>>>     - Update binding description
>>>   - Path 2/7
>>>     - Fix dt_binding_check errors
>>>     - Update per variant constraints
>>>     - Update nvmem description
>>>   - Patch 3/7
>>>     - Update get_pbs_client_device()
>>>     - Drop use of printk
>>>     - Remove unused function
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [2/7] dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
>>       commit: 2fdd08fec742e0c94a2a06a0c9ee0912b6f7ac39
>> [4/7] leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
>>       commit: 07a1afc8fbb77cc893e2285112482902ac88a295
>> [5/7] leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
>>       commit: f4f5f6a6f8d7bcc8efd0eee6751def22c9a38fd0
>> [6/7] leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT SDAM
>>       commit: 7399a927272de1fc42f4da8af1d8d60b65a15b84
>> [7/7] leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
>>       commit: 7b4066868689b1f341e61957611d252b6fa8cafc
> 
> This set had a bunch of checkpatch.pl errors.
> 
> Please fix them up subsequently.
> 
Hi Lee,

Just wanted to get some quick clarification. Would you like checkpatch.pl issues fixed in a new version
of this series or would you like a new patch to fix all the issues? Looks like these patches are in your
for-leds-next-next branch so I am guessing you would like a new follow up patch
but I just wanted to double check.

Thanks,
Anjelique

