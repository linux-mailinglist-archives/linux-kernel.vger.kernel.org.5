Return-Path: <linux-kernel+bounces-132283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC46B899275
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C7B2683E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE1B139B;
	Fri,  5 Apr 2024 00:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CKef0fEU"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAA536F;
	Fri,  5 Apr 2024 00:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275738; cv=none; b=VbvmtIriTEtqfmouSRj0JhAZ5La+8XCR4A7X/+xsBOngm5NSLlZbG5/k4zU060CqWetlU7KibhvbKcEx4ezLPgj9cYmEWDbNRnsnHe4QK/YXUN1WdMDrjJWYJTtv0C9NHjXynBSSm5vg2SflTudz8D4jw75rMqCy0VKjNTcdyCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275738; c=relaxed/simple;
	bh=hkT8Xw/lwI1O9nFpwBZFoeYoZ1+6G1/0F85MqFOKbCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=orTreF6fwEzBk6t9l4WscUwITXUJbxyNGT6Kyj7hhBp0hjiq5TpAvg8krN0sYYCworQbRHSta6Bu8csqwjI8Ct1M3AqQePG3H7g2/4nieHJE+w8tdqg0DkT2L8HL/SXFDURGKjOtVRj1YXN8NEcd4sZPoPaRxvSPKhxOdnBUyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CKef0fEU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 434NkNIJ002798;
	Fri, 5 Apr 2024 00:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=n9RriNW+JPnoxBFbCK+dtbYshB3mpiienH+rsyVoBPc=; b=CK
	ef0fEUIMrjBkbKpqR+ZxQ9JBrIxzOyElIef967xLlDpKm45x/tTmiixAH2AGCaw9
	iJxIHq+QsfMtK6L9yOwsYGxxC/CpSXMLzAjOyMn42pAsI7W2aSPaKpW4D0pvaKYy
	6M8yFTfO8rtH00OkWiUZp3v1JeaAUk9dWn/YeiRduMngkT/Y2Wl75MRGZl3gtdHu
	94AqvmB999adCcFxNPH3efvdaWGlh3UIs73GIZtvIyXaDbMuqo2DVXR/N9Wsdw+X
	t4GcyVa95xFLBx6nAzyhNjTn5fBk/uVe68KyXh1UiVSp6g47/GOJiaeBgUOud91g
	35o919jyB3A7Rw1Qa8Eg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ej867b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 00:08:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43508gKC009934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 00:08:42 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 4 Apr 2024
 17:08:41 -0700
Message-ID: <5b7c83f8-2b51-64d8-04c4-49a2047818a5@quicinc.com>
Date: Thu, 4 Apr 2024 17:08:40 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix register base for
 QSERDES_DP_PHY_MODE
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, Vinod Koul <vkoul@kernel.org>,
        "Kishon
 Vijay Abraham I" <kishon@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-phy@lists.infradead.org>, <freedreno@lists.freedesktop.org>,
        "Douglas
 Anderson" <dianders@chromium.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>, Steev Klimaszewski <steev@kali.org>,
        "Johan
 Hovold" <johan+linaro@kernel.org>,
        Bjorn Andersson
	<quic_bjorande@quicinc.com>
References: <20240405000111.1450598-1-swboyd@chromium.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240405000111.1450598-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MqIBCu0PLoWjjOkhmGTBls-XToid3Ogy
X-Proofpoint-GUID: MqIBCu0PLoWjjOkhmGTBls-XToid3Ogy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_21,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404040172



On 4/4/2024 5:01 PM, Stephen Boyd wrote:
> The register base that was used to write to the QSERDES_DP_PHY_MODE
> register was 'dp_dp_phy' before commit 815891eee668 ("phy:
> qcom-qmp-combo: Introduce orientation variable"). There isn't any
> explanation in the commit why this is changed, so I suspect it was an
> oversight or happened while being extracted from some other series.
> Oddly the value being 0x4c or 0x5c doesn't seem to matter for me, so I
> suspect this is dead code, but that can be fixed in another patch. It's
> not good to write to the wrong register space, and maybe some other
> version of this phy relies on this.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Steev Klimaszewski <steev@kali.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Yes I dont know why the commit 815891eee668 ("phy:
  qcom-qmp-combo: Introduce orientation variable") changed the base in 
below code. Certainly looks like a bug to me because we should be 
writing to DP_PHY_MODE which is at an offset 0x1c from the dp_phy base.

Hence, this LGTM,


Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>


