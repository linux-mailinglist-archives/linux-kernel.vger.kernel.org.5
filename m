Return-Path: <linux-kernel+bounces-7970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AA081AFEE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EB01C233D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746FC17735;
	Thu, 21 Dec 2023 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A56F+kNL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF64168DC;
	Thu, 21 Dec 2023 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL63Ybt000962;
	Thu, 21 Dec 2023 08:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HmVP3IU1SjpxqjTkq5j6cDNuXbEN5+VhE5eP5wjabgI=; b=A5
	6F+kNLktkSss3iY2gwhBbj24ZYZD+cI0rHoZ0zwnh82v9HzfGNOgFueg1eabfkZ4
	Iua5x2XosAu4nTUcy0D/cqYbE4QslvkPwuZPaU/MWUvsksRTBpjVlSA7AbCr793r
	8vaQnl6IKcZIjznrbg+aUPD1obrFVlY4+k1/F7lcCaWAbFY6J7kI7HMvtkNEa4dU
	DbKodidSVQcCxJCPraRCdONuh98DnYPdyCu7BVNddRgyixFuxYN+uZ4CAgQDaSon
	1ZeccaPB9zaI+Hi0t1PrP5aBT8fN98ugb/qeBa+N/1ncbs00YYj+TrTg2ushY4sB
	Rer8D+KHFHZ5JS/QL+BQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4dwx0xm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:01:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BL81L69016990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 08:01:21 GMT
Received: from [10.216.32.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 21 Dec
 2023 00:01:12 -0800
Message-ID: <6b4ba9ab-7f5a-6733-5cd0-d0b8da80b3d1@quicinc.com>
Date: Thu, 21 Dec 2023 13:31:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linus.walleij@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <sboyd@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <quic_subbaram@quicinc.com>, <quic_collinsd@quicinc.com>,
        <quic_kamalw@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        <linux-iio@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-7-quic_jprakash@quicinc.com>
 <bb225c12-f017-fac3-45f1-c828a10553e2@linaro.org>
 <99070bce-6188-82eb-c92c-cf7a323394e2@quicinc.com>
 <c4ef9cac-15ac-4c2c-9f9a-cb9e740e2900@linaro.org>
 <06d0f06a-7a5a-44d1-0bad-27f56bfc1421@quicinc.com>
 <e469039c-9370-4718-9081-98a203c62e77@linaro.org>
From: Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <e469039c-9370-4718-9081-98a203c62e77@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SgOsP3SemRNaoZg_pUYcdpLv83saZw_C
X-Proofpoint-GUID: SgOsP3SemRNaoZg_pUYcdpLv83saZw_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=724 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210058

Hi Krzysztof

On 11/16/2023 5:16 PM, Krzysztof Kozlowski wrote:
> On 16/11/2023 04:23, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 10/23/2023 12:06 PM, Krzysztof Kozlowski wrote:
>>> You cannot remove constraints from an entry. 
>>
>> In this case, minItems: 1 will remain true for all other ADC devices
>> documented here, but it will not be true for ADC5 Gen3, as this one can
>> have multiple base addresses if more than one SDAM is used for ADC. I'll
>> update this separately for each compatible, keeping it the same for the
>> older ones, hope that should work.
> BTW, you disagree with me and send new version 2 minutes later.
> Basically you did not leave me any time to respond to you.
>
> That's not how the process works.


Sorry about this, I'll make sure not to repeat this.

Thanks,

Jishnu


>
> Best regards,
> Krzysztof
>

