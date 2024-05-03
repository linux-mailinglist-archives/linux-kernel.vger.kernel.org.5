Return-Path: <linux-kernel+bounces-167257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 280388BA697
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E15283157
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 05:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F5139599;
	Fri,  3 May 2024 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AyiS+Pki"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933192C181;
	Fri,  3 May 2024 05:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714713847; cv=none; b=caMik5LQkTvJxVxPAtKwZlnXbACfy96A0049Y1757dNS9F/rIgSd6MA6boau28x1qRKoXPOKq1HxLBzoIJnisxJZRCo3t2VM5QNkjw77FYdmb7ZYHRLcRu1C/53Dmw6GQM0/OXukRORBFbLkqwlj8IbPD15RiuEFrrcgoOQ5iC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714713847; c=relaxed/simple;
	bh=qA0ymVuG//ywc/xEbtNGOXLUl1uitJl7+WvsuwdeV7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PhQu6h2PXKjy6HYMnHG3mN/S5cr1DgxpkHpjZ4M82ldKCvbuErhRgX5bjemZALVQt4TlPmWIKxjg7+y7Bd1+RKDxy2nUArzWkBH9fapCNJOU12NBHAsvhH2Fwe3V+QFl6XrDNggh9Tov6goKlaDA3WJNznsfpQglX+vSJYzWFEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AyiS+Pki; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4434hH9p004580;
	Fri, 3 May 2024 05:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=I6xdoCHOHKehKUSxYk5VnCRqgQe/24QjHGkXEwwcr0c=; b=Ay
	iS+Pki+B9YbmaWEvLQ3w4G/LbP6p6RyJSoxk7X2esMgZuJcqeQs0KI1HLG3tDAZy
	oP9maPQrqWk0RE3pgWWJF2Tidnuuh25Ts6OZLcta+7P4Nzf73Aife6GmAW26NOZm
	5MIJcnuNi73QnRvkrEpqUesCviMi8MnreY9HfIs9sVAFYrMBw39KkVIys9GTD4kK
	ttzWGmSPOWb0M0Dbhbirv3EGs1+WcYXLrbbDER8bjECmBMh50dX+RVND7EfAUnNT
	zyNB8MSbW6SP4fV6ddWqpkeQ7LJjRB5MNfginueQookgKtMUpCohFEtxTvp4nanN
	25kMSZ7+pCVPZbYbauiw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xv7pxj6y5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 05:23:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4435Nuh2020700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 05:23:56 GMT
Received: from [10.217.219.221] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 22:23:53 -0700
Message-ID: <2f3dd278-02b8-4939-8b75-55c342adcddf@quicinc.com>
Date: Fri, 3 May 2024 10:53:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom-snps-femto-v2: Add load and voltage setting for
 LDO's used
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay
 Abraham I <kishon@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20240502123312.31083-1-quic_ugoswami@quicinc.com>
 <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com>
Content-Language: en-US
From: Udipto Goswami <quic_ugoswami@quicinc.com>
In-Reply-To: <CAA8EJppeQTadmny=hcs4xCQDXHwXEBHXjeecvZCUVcSXmwBTgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IMh8dstdDZSkJ0k__r6y4e0xJkgEhb7g
X-Proofpoint-ORIG-GUID: IMh8dstdDZSkJ0k__r6y4e0xJkgEhb7g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_03,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405030035

Hi Dmitry,

On 5/2/2024 6:42 PM, Dmitry Baryshkov wrote:
> On Thu, 2 May 2024 at 15:33, Udipto Goswami <quic_ugoswami@quicinc.com> wrote:
>>
>> The Femto phy depends on 0.88/ 1.8/ 3.3V regulators for its operation.
>> If one of the regulators is not voted to the required minimum voltage
>> for phy to operate, then High speed mode of operation will fail.
>>
>> On certain targets like (qcm6490_rb3gen2) where the minimum voltage
>> of the regulator is lower than the operating voltage of the phy.
>> If not voted properly, the phy supply would be limited to the min value
>> of the LDO thereby rendering the phy non-operational.
>>
>> The current implementation of the regulators in the Femto PHY is not
>> setting the load and voltage for each LDO. The appropriate voltages and
>> loads required for the PHY to operate should be set.
> 
> Please move min/max voltages to the DTS. There is no need to set them
> from the driver.
that also can be done.
> 
> Also, is there any reason why you can't use `regulator-initial-mode =
> <RPMH_REGULATOR_MODE_HPM>;` like other boards do?


but the regulator loads & voltages for the phy doesn't change for every 
platform.
Phys operational limits will still be the same for all the different 
platforms which exists today and the upcoming ones as well if they use it.

Suppose te LDO's HPM is 2000 but the phy require 6000, its not getting 
enough power, same for reverse say 6000 in LDO's HPM and phy require 
2000, isn't this power leakage ?

This also seems to be the case with voltages as well, the phy require 
0.88V for operation but if LDO is lower then that say 0.70, phy won't work.

So instead of doing it seperately doesn't it make sense to do it in driver ?
> 
>>
>> Implement a bulk operation api to set load & voltages before doing bulk
>> enable. This will ensure that the PHY remains operational under all
>> conditions.
>>
>> Signed-off-by: Udipto Goswami <quic_ugoswami@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 121 +++++++++++++++++-
>>   1 file changed, 114 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> index eb0b0f61d98e..cbe9cdaa6849 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
>> @@ -78,11 +78,39 @@
>>
>>   #define LS_FS_OUTPUT_IMPEDANCE_MASK            GENMASK(3, 0)
>>
>> -static const char * const qcom_snps_hsphy_vreg_names[] = {
>> -       "vdda-pll", "vdda33", "vdda18",
>> +
>> +struct qcom_snps_hsphy_regulator_data {
>> +       const char *name;
>> +       unsigned int enable_load;
>> +       unsigned int min_voltage;
>> +       unsigned int max_voltage;
>> +};
>> +
>> +static const struct qcom_snps_hsphy_regulator_data hsphy_vreg_l[] = {
>> +       {
>> +               .name = "vdda-pll",
>> +               .enable_load = 30000,
>> +               .min_voltage = 825000,
>> +               .max_voltage = 925000,
>> +       },
>> +
>> +       {
>> +               .name = "vdda18",
>> +               .enable_load = 19000,
>> +               .min_voltage = 1704000,
>> +               .max_voltage = 1800000
>> +       },
>> +
>> +       {
>> +               .name = "vdda33",
>> +               .enable_load = 16000,
>> +               .min_voltage = 3050000,
>> +               .max_voltage = 3300000
>> +       },
>> +
>>   };
>>
>> -#define SNPS_HS_NUM_VREGS              ARRAY_SIZE(qcom_snps_hsphy_vreg_names)
>> +#define SNPS_HS_NUM_VREGS              ARRAY_SIZE(hsphy_vreg_l)
>>
>>   struct override_param {
>>          s32     value;
>> @@ -132,12 +160,90 @@ struct qcom_snps_hsphy {
>>          struct clk_bulk_data *clks;
>>          struct reset_control *phy_reset;
>>          struct regulator_bulk_data vregs[SNPS_HS_NUM_VREGS];
>> +       const struct qcom_snps_hsphy_regulator_data *vreg_list;
>>
>>          bool phy_initialized;
>>          enum phy_mode mode;
>>          struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
>>   };
>>
>> +static int __vdda_phy_bulk_enable_disable(struct qcom_snps_hsphy *hsphy, bool on)
> 
> Separate functions, please.
sure.
> 
>> +{
>> +       int ret = 0;
>> +       int i;
>> +
>> +       if (!on)
>> +               goto disable_vdd;
>> +
>> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
>> +
>> +               ret = regulator_set_load(hsphy->vregs[i].consumer,
>> +                                        hsphy->vreg_list[i].enable_load);
>> +
>> +               if (ret < 0) {
>> +                       dev_err(hsphy->dev, "unable to set HPM of %s %d\n",
>> +                                               hsphy->vregs[i].supply, ret);
>> +                       goto err_vdd;
>> +               }
>> +       }
>> +
>> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
>> +               ret = regulator_set_voltage(hsphy->vregs[i].consumer,
>> +                                           hsphy->vreg_list[i].min_voltage,
>> +                                           hsphy->vreg_list[i].max_voltage);
>> +               if (ret) {
>> +                       dev_err(hsphy->dev,
>> +                               "unable to set voltage of regulator %s %d\n",
>> +                                               hsphy->vregs[i].supply, ret);
>> +                       goto put_vdd_lpm;
>> +               }
>> +       }
>> +
>> +       ret = regulator_bulk_enable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
>> +       if (ret)
>> +               goto unconfig_vdd;
>> +
>> +       return ret;
>> +
>> +disable_vdd:
>> +       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
>> +
>> +unconfig_vdd:
>> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
>> +               ret = regulator_set_voltage(hsphy->vregs[i].consumer, 0,
>> +                                           hsphy->vreg_list[i].max_voltage);
>> +               if (ret) {
>> +                       dev_err(hsphy->dev,
>> +                       "unable to set voltage of regulator %s %d\n",
>> +                                       hsphy->vregs[i].supply, ret);
>> +               }
>> +       }
>> +
>> +put_vdd_lpm:
>> +       for (i = 0; i < SNPS_HS_NUM_VREGS; i++) {
>> +               ret = regulator_set_load(hsphy->vregs[i].consumer, 0);
>> +
>> +               if (ret < 0) {
>> +                       dev_err(hsphy->dev, "unable to set LPM of %s %d\n",
>> +                                               hsphy->vregs[i].supply, ret);
>> +               }
>> +       }
>> +
>> +err_vdd:
>> +       return ret;
>> +
>> +}
>> +
>> +static int vdda_phy_bulk_enable(struct qcom_snps_hsphy *hsphy)
>> +{
>> +       return __vdda_phy_bulk_enable_disable(hsphy, true);
>> +}
>> +
>> +static int vdda_phy_bulk_disable(struct qcom_snps_hsphy *hsphy)
>> +{
>> +       return __vdda_phy_bulk_enable_disable(hsphy, false);
>> +}
>> +
>>   static int qcom_snps_hsphy_clk_init(struct qcom_snps_hsphy *hsphy)
>>   {
>>          struct device *dev = hsphy->dev;
>> @@ -390,7 +496,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
>>
>>          dev_vdbg(&phy->dev, "%s(): Initializing SNPS HS phy\n", __func__);
>>
>> -       ret = regulator_bulk_enable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
>> +       ret = vdda_phy_bulk_enable(hsphy);
>>          if (ret)
>>                  return ret;
>>
>> @@ -471,7 +577,7 @@ static int qcom_snps_hsphy_init(struct phy *phy)
>>   disable_clks:
>>          clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
>>   poweroff_phy:
>> -       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
>> +       ret = vdda_phy_bulk_disable(hsphy);
>>
>>          return ret;
>>   }
>> @@ -482,7 +588,7 @@ static int qcom_snps_hsphy_exit(struct phy *phy)
>>
>>          reset_control_assert(hsphy->phy_reset);
>>          clk_bulk_disable_unprepare(hsphy->num_clks, hsphy->clks);
>> -       regulator_bulk_disable(ARRAY_SIZE(hsphy->vregs), hsphy->vregs);
>> +       vdda_phy_bulk_disable(hsphy);
>>          hsphy->phy_initialized = false;
>>
>>          return 0;
>> @@ -592,8 +698,9 @@ static int qcom_snps_hsphy_probe(struct platform_device *pdev)
>>
>>          num = ARRAY_SIZE(hsphy->vregs);
>>          for (i = 0; i < num; i++)
>> -               hsphy->vregs[i].supply = qcom_snps_hsphy_vreg_names[i];
>> +               hsphy->vregs[i].supply = hsphy_vreg_l[i].name;
>>
>> +       hsphy->vreg_list  = hsphy_vreg_l;
>>          ret = devm_regulator_bulk_get(dev, num, hsphy->vregs);
>>          if (ret)
>>                  return dev_err_probe(dev, ret,
>> --
>> 2.17.1

-Udipto

