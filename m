Return-Path: <linux-kernel+bounces-21997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90598297A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCCA28AF11
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F094121F;
	Wed, 10 Jan 2024 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZCwUmany"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A0740C04;
	Wed, 10 Jan 2024 10:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A8cp1w020844;
	Wed, 10 Jan 2024 10:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5Paa55GUVgZ+hembfGyj7xkKH2+Z6loGiS8NR1WqkBs=; b=ZC
	wUmanymbcjgOcrsNaiAQGHcvAWyQmxDz4i5YemJb4KShtFTffy/wUKHZIfbqA4Hm
	dJPJ8wJluMxEqa52TSTCVJ2IP/9PS7Net9IVkhJ3/4Ho8xnOKGaSEbSg6vDl53Kv
	IuF+8ovc6wbojgX/BdWNgd/tjgNZo2XC7FHr4FBE9UjyjRrYBSZSIFCRRjuNHhMR
	aqCxfiGsabZArdNuWJV6heyz3lSCGTSzHcVI1jcI1UB6i9bdnT2h0kbCUcEIcvsa
	FNPiyceVfrdaol2BX19t6VcrCQbwEPQLNdy7/QHJxQvuFgjIC36UxUv+yHgKlaEi
	p3lxnTVII4wInpBglvzg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhjh2rum5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 10:28:56 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AAStoO014641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 10:28:55 GMT
Received: from [10.218.19.46] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 02:28:48 -0800
Message-ID: <bea0aa48-605e-b2fe-d1ea-d2ace73e42d6@quicinc.com>
Date: Wed, 10 Jan 2024 15:58:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] clk: qcom: gcc-sm8150: Update the gcc resets
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Michael
 Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Deepak Katragadda" <dkatraga@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, "Taniya Das" <quic_tdas@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Ajit Pandey
	<quic_ajipan@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        "Jagadeesh Kona" <quic_jkona@quicinc.com>
References: <20240104-sm8150-dfs-support-v1-0-a5eebfdc1b12@quicinc.com>
 <20240104-sm8150-dfs-support-v1-3-a5eebfdc1b12@quicinc.com>
 <f2a8f12d-1f1a-4717-b837-69c01e57c677@linaro.org>
From: "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <f2a8f12d-1f1a-4717-b837-69c01e57c677@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LAemPs0k_EEFQ3b8YB9CK1dswN94KUu_
X-Proofpoint-GUID: LAemPs0k_EEFQ3b8YB9CK1dswN94KUu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=711 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100085


On 1/4/2024 9:14 PM, Krzysztof Kozlowski wrote:
> On 04/01/2024 15:23, Satya Priya Kakitapalli wrote:
>> Add all the available resets for the global clock controller
>> on sm8150.
>>
>> Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver for SM8150")
> If this is a fix, then please describe observable issue and how users
> are affected. See stable kernel rules document.


No issues are observed as of now, just wanted to make sure all the 
available resets are added. I'll remove the fixes tag.


> Best regards,
> Krzysztof
>

