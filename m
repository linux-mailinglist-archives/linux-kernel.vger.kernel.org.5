Return-Path: <linux-kernel+bounces-9457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A5B81C5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24951B23769
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046B3BE47;
	Fri, 22 Dec 2023 07:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mAkhGk8Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE469449;
	Fri, 22 Dec 2023 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BM6o7eA009878;
	Fri, 22 Dec 2023 07:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TNfxueRdhFsROCa7UCw3+se29LjpxvuBSP4v4Lyt9kg=; b=mA
	khGk8YYrlkB/QMYmZbmzAJR18SvwUt+N3EebVIzObKDr2GpChOBRCAwiTrIt6voa
	tI8ZxjboYomvnZKE6Q6dkYKgxbUAfHFnnawi7U0iuFSb7ieyZXki32/4Ir8U3xgd
	VH3OlbssjdohlXoNuWUMNmQhYA0wvvD5WRcP45i1KYNlB+eZF5QpSMpilcXj9Aov
	xvr2+GMn5Ylkpiy3ocHSV8F3cGjdS83hDz62me/JsqQlenXbhSKyk1yHQskjLNKv
	reHRMh/KlpzZ+B0Smu38kjsNzS9Hu31vMd+TgH7mSUF+NFt0zSfjKABM1MBpc5nR
	cXB6AGMtFcl73EPDPcxQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4tue9fxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 07:41:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BM7fHSo004357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Dec 2023 07:41:17 GMT
Received: from [10.253.15.135] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 23:41:13 -0800
Message-ID: <ad95e193-1216-46ae-9f7d-2967a24d7a12@quicinc.com>
Date: Fri, 22 Dec 2023 15:41:11 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/10] phy: qualcomm: phy-qcom-qmp-ufs: Rectify SM8550
 UFS HS-G4 PHY Settings
To: Vinod Koul <vkoul@kernel.org>
CC: <bvanassche@acm.org>, <mani@kernel.org>, <adrian.hunter@intel.com>,
        <beanhuo@micron.com>, <avri.altman@wdc.com>,
        <junwoo80.lee@samsung.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn
 Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK"
	<linux-phy@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1701520577-31163-1-git-send-email-quic_cang@quicinc.com>
 <1701520577-31163-10-git-send-email-quic_cang@quicinc.com>
 <ZYRyJU9klhZzLdni@matsya>
Content-Language: en-US
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <ZYRyJU9klhZzLdni@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S3JmbtEHJvUJ0VfiKaj9D1hSMCc_vLFK
X-Proofpoint-ORIG-GUID: S3JmbtEHJvUJ0VfiKaj9D1hSMCc_vLFK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 impostorscore=0
 phishscore=0 mlxlogscore=613 priorityscore=1501 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312220053

Hi Vinod,

On 12/22/2023 1:13 AM, Vinod Koul wrote:
> On 02-12-23, 04:36, Can Guo wrote:
>> The registers, which are being touched in current SM8550 UFS PHY settings,
>> and the values being programmed are mainly the ones working for HS-G4 mode,
>> meanwhile, there are also a few ones somehow taken from HS-G5 PHY settings.
>> However, even consider HS-G4 mode only, some of them are incorrect and some
>> are missing. Rectify the HS-G4 PHY settings by strictly aligning with the
>> SM8550 UFS PHY Hardware Programming Guide suggested HS-G4 PHY settings.
> 
> This fails for me, as I have picked Abels offset series, can you please
> rebase these two patches and send
> 
In v8, I rebased the two changes to linux-next. Is the ask there to 
rebase the two changes to phy/next?

Thanks,
Can Guo.

