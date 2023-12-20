Return-Path: <linux-kernel+bounces-6386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FB8819834
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0B11C254E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D66101CC;
	Wed, 20 Dec 2023 05:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BEXDwgOy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7915AC7;
	Wed, 20 Dec 2023 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK4oRe6001889;
	Wed, 20 Dec 2023 05:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=K33oHyfwjCkr5btHRVdLguivGo60Y0wp3ZnNoXIm724=; b=BE
	XDwgOyJBbwhnKGnOGjoH64xhSpD9Fta9Gu6FzaVPbOneMqVEYXAqzXQ0S/mQp4HM
	XcuYIaGBp591lKRU893EkYLUoCrYySXQ8xj42bpT9bbWw6c1DgD008vViAD6PFHL
	kbG1vvMI96Frzjp7cfTHdqs8kmRgls5dw9WjvRcAgQ1u4sDic7ieCQOSJmHRnQX3
	6B1RxZjBMhKNrvB0WtL0tzfLDu+Lq1XLmHhekTU3mwXwcVhiu8IE0QrMhhirhMUC
	2Xz/4lUIj3DSEMiA/BoiWtySu6ezEx0VqqySHK05MAP9NwOT0kQfH2/PDqc2ppVf
	oo8893MFSCdlRHgnlmAg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v37vxtk4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 05:34:37 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK5YarL012961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 05:34:36 GMT
Received: from [10.239.132.150] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 21:34:30 -0800
Message-ID: <f8719779-a3d4-49c5-9dc1-240ef982384e@quicinc.com>
Date: Wed, 20 Dec 2023 13:34:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 0/1] arm64: dts: qcom: sm8550: remove
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <20231219003106.8663-1-quic_tengfan@quicinc.com>
 <170301441259.365364.2180258670074890979.b4-ty@kernel.org>
From: "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>
In-Reply-To: <170301441259.365364.2180258670074890979.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a2swOqmPy2OUHI4zHupBY4Pox0NBNmDP
X-Proofpoint-GUID: a2swOqmPy2OUHI4zHupBY4Pox0NBNmDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=785
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200034



On 12/20/2023 3:33 AM, Bjorn Andersson wrote:
> 
> On Tue, 19 Dec 2023 08:31:05 +0800, Tengfei Fan wrote:
>> The address/size-cells in mdss_dsi1 node have not ranges and child also
>> have not reg, then this leads to dtc W=1 warnings:
>>
>>    sm8550.dtsi:2937.27-2992.6: Warning (avoid_unnecessary_addr_size): /soc@0/display-subsystem@ae00000/dsi@ae96000:
>>      unnecessary #address-cells/#size-cells without "ranges" or child "reg" property
>>
>>
>> [...]
> 
> Applied, thanks!
Hi Bjorn,

Discussion is still on going.
Dmitry dropped the previous review-by.
> 
> [1/1] arm64: dts: qcom: sm8550: remove address/size-cells from mdss_dsi1
>        commit: 53081095936cdb1501d6bcf6cb703fdd3ac71b85
> 
> Best regards,

-- 
Thx and BRs,
Aiqun(Maria) Yu

