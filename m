Return-Path: <linux-kernel+bounces-128491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF99D895B8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC02282ACB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B06B15AD8D;
	Tue,  2 Apr 2024 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kn5Xt9iu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E271F15AABF;
	Tue,  2 Apr 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081829; cv=none; b=TE7NzK6FhBLUvSfnGa2bopc6iUNLcy4v8QBqcTITKFGDuSCFB9gpLRkLe7NgKkqFJWzsyUugc+pyWMTbcMqXe6OwlSU/CL9UnmAXNNgGDkReZbJniyeKUUUsDW5/QsL74hvSB9ksnhZQtNNjsbkbulx7jrGelKPfKIBbh6CXYkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081829; c=relaxed/simple;
	bh=07xKeQCKzNOQCfkA5d1xwrsHMqHXlqaCJFE9t4nKSV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TEmZPCz/mCdfk34nnZ70Ql3jLLy7RLBOKlLXiguhhWBOZrdl5YUZAk2bVTNW3B5e7v5ZTyfA3QWGCEgfZK4J31IiaWLeD7xt6aefLwoc55sGhYeD+xB2zYmmuIgkHJLvrkW6wyxeJ3jp9u//5GkcewRv9+CdKyT4I4fJlgQ6YYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kn5Xt9iu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 432HDvhi014233;
	Tue, 2 Apr 2024 18:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=UsrPKT62R/Whd6jvXGqf5hsJfNGi0E/QvkZwPMslTkE=; b=kn
	5Xt9iuQcK0khLX0Kyzq/PuUrB4wmy+vS8DDm/zioX1IiYE1dhTYZ+sTnb9uZ0W01
	878MhUu2ppIh44mJTjP6viQlr12b9yxwXD6T5jw1+fKbUyuJCGV97tTn4AgKL5er
	I444DGSvv26/+6jBwIxLRiWeAXZg2E/Wuhn5JoVpYmW2oL4LmrshhKVOD0Q36/8A
	4KGJTC+rWPNPClQ31rsR7hymMY/wQVp4wnTSLbj4srEDlNsbQg7QDhXKLPh5M5Un
	2/SaHf7leje/oI6393QCVu9VAMO8ahyz1lA8gULRlySjlriio99GgERKSFfZO6Bh
	506PuVQO/hYtF1pPaOLQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x8h5es5g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 18:17:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432IH2OR021241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 18:17:02 GMT
Received: from [10.216.46.192] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 11:16:55 -0700
Message-ID: <a268f388-8a2c-c192-02ca-134c057086e2@quicinc.com>
Date: Tue, 2 Apr 2024 23:46:29 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/7] clk: qcom: Add DISPCC driver support for SM4450
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Zapolskiy
	<vladimir.zapolskiy@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Taniya Das
	<quic_tdas@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Imran Shaik
	<quic_imrashai@quicinc.com>,
        Satya Priya Kakitapalli
	<quic_skakitap@quicinc.com>
References: <20240330182817.3272224-1-quic_ajipan@quicinc.com>
 <20240330182817.3272224-4-quic_ajipan@quicinc.com>
 <CAA8EJpqZjysw+YE=vKguearf_abSzocvYtMvW9eHAZD-tMKs0g@mail.gmail.com>
Content-Language: en-US
From: Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <CAA8EJpqZjysw+YE=vKguearf_abSzocvYtMvW9eHAZD-tMKs0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ayPKdBqcK1sf3gpvynZn-wmtP2Jo6MON
X-Proofpoint-ORIG-GUID: ayPKdBqcK1sf3gpvynZn-wmtP2Jo6MON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_12,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020135



On 3/31/2024 6:58 AM, Dmitry Baryshkov wrote:
> On Sat, 30 Mar 2024 at 20:29, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>
>> Add Display Clock Controller (DISPCC) support for SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> ---
>>   drivers/clk/qcom/Kconfig         |  10 +
>>   drivers/clk/qcom/Makefile        |   1 +
>>   drivers/clk/qcom/dispcc-sm4450.c | 781 +++++++++++++++++++++++++++++++
>>   3 files changed, 792 insertions(+)
>>   create mode 100644 drivers/clk/qcom/dispcc-sm4450.c
>>
> 
> [skipped]
> 
>> +static int disp_cc_sm4450_probe(struct platform_device *pdev)
>> +{
>> +       struct regmap *regmap;
> 
> Is there a MMCX power domain on the platform? See how other dispcc
> drivers handle pm_runtime status.
> 
Thanks for review , actually SM4450 doesn't support MMCX power domain 
pm_rumtime support is not required here.
>> +
>> +       regmap = qcom_cc_map(pdev, &disp_cc_sm4450_desc);
>> +       if (IS_ERR(regmap))
>> +               return PTR_ERR(regmap);
>> +
>> +       clk_lucid_evo_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
>> +       clk_lucid_evo_pll_configure(&disp_cc_pll1, regmap, &disp_cc_pll1_config);
>> +
>> +       /* Keep some clocks always enabled */
>> +       qcom_branch_set_clk_en(regmap, 0xe070); /* DISP_CC_SLEEP_CLK */
>> +       qcom_branch_set_clk_en(regmap, 0xe054); /* DISP_CC_XO_CLK */
>> +
>> +       return qcom_cc_really_probe(pdev, &disp_cc_sm4450_desc, regmap);
>> +}
>> +
>> +static struct platform_driver disp_cc_sm4450_driver = {
>> +       .probe = disp_cc_sm4450_probe,
>> +       .driver = {
>> +               .name = "dispcc-sm4450",
>> +               .of_match_table = disp_cc_sm4450_match_table,
>> +       },
>> +};
>> +
>> +module_platform_driver(disp_cc_sm4450_driver);
>> +
>> +MODULE_DESCRIPTION("QTI DISPCC SM4450 Driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.25.1
>>
>>
> 
> 

-- 
Thanks, and Regards
Ajit

