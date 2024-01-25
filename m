Return-Path: <linux-kernel+bounces-38376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA883BE80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35AD1F22CEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E315C1CA8F;
	Thu, 25 Jan 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LzKrfYYm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30B1CD28;
	Thu, 25 Jan 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177879; cv=none; b=rcKYsZpsh13SqCH8gfGAhwXjdzVU6LPCc+ShtNS9Cr3iyIDzcCXLcOW8+Bhtw+P+Y2Sz/9018Ztw8T7NH7WSAx9BcWaLVoNHz3gMNF5w+0rM2zMJfJjF76UbYGrzHfaIn8C+ffJsIUVxlVHLxopNR8AoaPPPQo23MiGV+Cgz+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177879; c=relaxed/simple;
	bh=bB50DiLiSI/AjIntQtj8OLZXA1hJ46f8ucE5lxaMffA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UUE4xgTp7VG7z6pf9l/L2oEXesdKgql2cfsbH6I8PvGh+NzeiCbSmKimeQOdMNTma4YcZOBAmZLZ1dETdgGjbxSE/pZOMlw80mDxSdiOHFhEzSaq+u+7mWg33FcGVuaHko25f6ggQccVsvMPsExNaHAdLXPVH6zMtZ6H41uK6AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LzKrfYYm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40P9No7G004502;
	Thu, 25 Jan 2024 10:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=aLqFVE/DSS8tNOS7Nmf+NZKIYYQc3O4Zzw7wicUI/U4=; b=Lz
	KrfYYmbpHacI5W6qAuMxvWyccrsj21DdiMjPjSFLDaYlRjZ3SuxQqgzFikZbvt+1
	BSwhrCR98T633mgNag568JuaF6lyxDUAQKsMsE2F4nVrB9p2JZokRoxNyMK3VCJs
	e+ncUTFNMePKjr6e36wrCFZo8PqQPhxvxRtIgj3AXHebVD2csxceQOFcehMrGVml
	qnJbQAOrZ0TtKNOy3+lV6kvIfChw+CWLlzSHvu4sUjyYNmzvLzF23fnqWQR04bLF
	MyUeheHkl+qNAog3zgetM8AH0gKfiVCTtJM/RXp2XCnyRq43ZDp9R31u3HZghG6k
	xAS2EXftmZ5V5NCuug8A==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vumyng3dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:17:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PAHlfK003926
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 10:17:47 GMT
Received: from [10.218.0.85] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 25 Jan
 2024 02:17:42 -0800
Message-ID: <d4a14fb9-849c-4236-9ec1-538f2944fb02@quicinc.com>
Date: Thu, 25 Jan 2024 15:46:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/12] Unregister critical branch clocks + some RPM
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
From: Taniya Das <quic_tdas@quicinc.com>
In-Reply-To: <20230717-topic-branch_aon_cleanup-v6-0-46d136a4e8d0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _VS6zcPvV0xrC47TQ77j3pSQdlfwOUgY
X-Proofpoint-ORIG-GUID: _VS6zcPvV0xrC47TQ77j3pSQdlfwOUgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=948 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401250070

Hi Konrad,

Thanks for your patch.

On 1/13/2024 8:20 PM, Konrad Dybcio wrote:
> On Qualcomm SoCs, certain branch clocks either need to be always-on, or
> should be if you're interested in touching some part of the hardware.
> 
> Using CLK_IS_CRITICAL for this purpose sounds like a genius idea,
> however that messes with the runtime pm handling - if a clock is
> marked as such, the clock controller device will never enter the
> "suspended" state, leaving the associated resources online, which in
> turn breaks SoC-wide suspend.

I am really curious to know a little more about the SoC-Wide Suspend not 
happening on these targets. Could you add more details here ?

The Resource Power Manager (RPM) is the main aggregator on these targets 
where the active & sleep votes on XO, shared rails (CX/MX) decide the 
SoC wide suspend. The High Level OS on our internal platforms never had 
any suspend issues due to clocks(GCC/GPUCC) or shared rails being kept 
enabled from the consumers.

> 
> This series aims to solve that on a couple SoCs that I could test the
> changes on and it sprinkles some runtime pm enablement atop these drivers.
> 

As CX is a shared resource/rail on these specific targets we definitely 
do not achieve any power saving with the runtime pm attached to these 
clock controllers, but I see a little more SW overhead. Though you could 
please add your observations/comments.

Removing the CLK_IS_CRITICAL is a good cleanup and moving them to probe 
is a good way to handle the always-on clocks.


> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v6:
> - Rebase (next-20240112)
> - Reorder qcom_branch_set_clk_en calls by register in "*: Unregister
>    critical clocks" (Johan)
> - Pick up tags
> - Link to v5: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v5-0-99942e6bf1ba@linaro.org
> 
> Changes in v5:
> - Change the "Keep the critical clocks always-on" comment to "Keep
>    some clocks always-on"
> - Add the same comment to commits unregistering clocks on 6115/6375/2290
> - Link to v4: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v4-0-32c293ded915@linaro.org
> 
> Changes in v4:
> - Add and unify the "/* Keep the critical clocks always-on */" comment
> - Rebase (next-20231222), also include 8650, X1E and 8280camcc drivers
> - Drop enabling runtime PM on GCC
> - Improve the commit message of "clk: qcom: gpucc-sm6115: Add runtime PM"
> - Link to v3: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v3-0-3e31bce9c626@linaro.org
> 
> Changes in v3:
> - Rebase (next-20231219)
> - Fix up a copypaste mistake in "gcc-sm6375: Unregister critical clocks" (bod)
> - Pick up tags
> - Link to v2: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v2-0-2a583460ef26@linaro.org
> 
> Changes in v2:
> - Rebase
> - Pick up tags
> - Fix up missing pm_runtime_put in SM6375 GCC (Johan)
> - Clarify the commit message of "Add runtime PM" commits (Johan)
> - "GPU_CCC" -> "GPU_CC" (oops)
> - Rebase atop next-20231129
>    - Also fix up camcc-sm8550 & gcc-sm4450
>    - Unify and clean up the comment style
>    - Fix missing comments in gcc-sc7180..
>    - Drop Johan's ack from "clk: qcom: Use qcom_branch_set_clk_en()"
> - Improve 6115 dt patch commit message (Bjorn)
> - Link to v1: https://lore.kernel.org/r/20230717-topic-branch_aon_cleanup-v1-0-27784d27a4f4@linaro.org
> 
> ---
> Konrad Dybcio (12):
>        clk: qcom: branch: Add a helper for setting the enable bit
>        clk: qcom: Use qcom_branch_set_clk_en()
>        clk: qcom: gcc-sm6375: Unregister critical clocks
>        clk: qcom: gpucc-sm6375: Unregister critical clocks
>        clk: qcom: gpucc-sm6115: Unregister critical clocks
>        clk: qcom: gpucc-sm6115: Add runtime PM
>        clk: qcom: gcc-sm6115: Unregister critical clocks
>        clk: qcom: gcc-qcm2290: Unregister critical clocks
>        arm64: dts: qcom: sm6375: Add VDD_CX to GCC
>        arm64: dts: qcom: qcm2290: Add VDD_CX to GCC
>        arm64: dts: qcom: sm6115: Add VDD_CX to GCC
>        arm64: dts: qcom: sm6115: Add VDD_CX to GPU_CC
>  >   arch/arm64/boot/dts/qcom/qcm2290.dtsi |   1 +
>   arch/arm64/boot/dts/qcom/sm6115.dtsi  |   3 +
>   arch/arm64/boot/dts/qcom/sm6375.dtsi  |   1 +
>   drivers/clk/qcom/camcc-sc8280xp.c     |   6 +-
>   drivers/clk/qcom/camcc-sm8550.c       |  10 +--
>   drivers/clk/qcom/clk-branch.h         |   7 ++
>   drivers/clk/qcom/dispcc-qcm2290.c     |   4 +-
>   drivers/clk/qcom/dispcc-sc7280.c      |   7 +-
>   drivers/clk/qcom/dispcc-sc8280xp.c    |   4 +-
>   drivers/clk/qcom/dispcc-sm6115.c      |   4 +-
>   drivers/clk/qcom/dispcc-sm8250.c      |   4 +-
>   drivers/clk/qcom/dispcc-sm8450.c      |   7 +-
>   drivers/clk/qcom/dispcc-sm8550.c      |   7 +-
>   drivers/clk/qcom/dispcc-sm8650.c      |   4 +-
>   drivers/clk/qcom/gcc-qcm2290.c        | 106 +++--------------------------
>   drivers/clk/qcom/gcc-sa8775p.c        |  25 +++----
>   drivers/clk/qcom/gcc-sc7180.c         |  22 +++---
>   drivers/clk/qcom/gcc-sc7280.c         |  20 +++---
>   drivers/clk/qcom/gcc-sc8180x.c        |  28 +++-----
>   drivers/clk/qcom/gcc-sc8280xp.c       |  25 +++----
>   drivers/clk/qcom/gcc-sdx55.c          |  12 ++--
>   drivers/clk/qcom/gcc-sdx65.c          |  13 ++--
>   drivers/clk/qcom/gcc-sdx75.c          |  10 +--
>   drivers/clk/qcom/gcc-sm4450.c         |  28 +++-----
>   drivers/clk/qcom/gcc-sm6115.c         | 124 +++-------------------------------
>   drivers/clk/qcom/gcc-sm6375.c         | 105 +++-------------------------
>   drivers/clk/qcom/gcc-sm7150.c         |  23 +++----
>   drivers/clk/qcom/gcc-sm8250.c         |  19 ++----
>   drivers/clk/qcom/gcc-sm8350.c         |  20 +++---
>   drivers/clk/qcom/gcc-sm8450.c         |  21 +++---
>   drivers/clk/qcom/gcc-sm8550.c         |  21 +++---
>   drivers/clk/qcom/gcc-sm8650.c         |  16 ++---
>   drivers/clk/qcom/gcc-x1e80100.c       |  16 ++---
>   drivers/clk/qcom/gpucc-sc7280.c       |   9 +--
>   drivers/clk/qcom/gpucc-sc8280xp.c     |   9 +--
>   drivers/clk/qcom/gpucc-sm6115.c       |  53 ++++++---------
>   drivers/clk/qcom/gpucc-sm6375.c       |  34 ++--------
>   drivers/clk/qcom/gpucc-sm8550.c       |  10 +--
>   drivers/clk/qcom/lpasscorecc-sc7180.c |   7 +-
>   drivers/clk/qcom/videocc-sm8250.c     |   6 +-
>   drivers/clk/qcom/videocc-sm8350.c     |  10 +--
>   drivers/clk/qcom/videocc-sm8450.c     |  13 ++--
>   drivers/clk/qcom/videocc-sm8550.c     |  13 ++--
>   43 files changed, 234 insertions(+), 653 deletions(-)
> ---
> base-commit: 8d04a7e2ee3fd6aabb8096b00c64db0d735bc874
> change-id: 20230717-topic-branch_aon_cleanup-6976c13fe71c
> 
> Best regards,

-- 
Thanks & Regards,
Taniya Das.

