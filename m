Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61443755AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGQFSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjGQFRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:17:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45911AC;
        Sun, 16 Jul 2023 22:17:53 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36H50BBH000742;
        Mon, 17 Jul 2023 05:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KX2i6izncnxQp77hTHS1vGs8DkxSfQopCQafcfovuiU=;
 b=JQfpHON71IO63dWZafbWEzYggAb6rGCCqpr0+27V7e5j/HhQouP/ITfUdS+eVGwqToAw
 tJ96L97bRmA6q/p9aVSOkbqtHZwp3ojp5Xpnb6/4+PJ4B1HIvsDLvA/kWH5sU/s1B0fR
 ngZdqsS5cqDW8WWtjGdvja4QrSZRj+3qqnlqg7MmzZEDZC2jjYmyAZLc1hnNzN3eD3qZ
 sbermSnhm8IdkX7uoop4G/yZG9yZJpNcqSd26H2Igh+I06h+stKiD/lHSvLGcZh3rgSz
 bokCzijJqY+z49m7HkH4rlatPAtjgfIZhDBHdBQalZk8e0P0IFhsLthEcaeaJjVv5AWp 4Q== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0dtgj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:17:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36H5HkXn027375
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 05:17:46 GMT
Received: from [10.216.12.245] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 16 Jul
 2023 22:17:41 -0700
Message-ID: <9a64823c-f475-ef2d-aba8-a674e4b27cba@quicinc.com>
Date:   Mon, 17 Jul 2023 10:47:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/5] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <amitk@kernel.org>,
        <thara.gopinath@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_varada@quicinc.com>
References: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
 <20230713052732.787853-2-quic_ipkumar@quicinc.com>
 <1fbb2e36-87d7-339d-ba2f-42916a213607@linaro.org>
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
In-Reply-To: <1fbb2e36-87d7-339d-ba2f-42916a213607@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bTWhjOBKG0KALtRis8mBLCiExxW7FG__
X-Proofpoint-GUID: bTWhjOBKG0KALtRis8mBLCiExxW7FG__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_04,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170048
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/2023 7:35 PM, Konrad Dybcio wrote:
> On 13.07.2023 07:27, Praveenkumar I wrote:
>> SoCs without RPM have to enable sensors and calibrate from the kernel.
>> Though TSENS IP supports 16 sensors, not all are used. So used hw_id
>> to enable the relevant sensors.
>>
>> Added new calibration function for V2 as the tsens.c calib function
>> only supports V1.
>>
>> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
>> ---
> [...]
>
>>   
>>   /* ----- SROT ------ */
>>   #define SROT_HW_VER_OFF	0x0000
>>   #define SROT_CTRL_OFF		0x0004
>> +#define SROT_MEASURE_PERIOD	0x0008
>> +#define SROT_Sn_CONVERSION	0x0060
>> +#define V2_SHIFT_DEFAULT	0x0003
>> +#define V2_SLOPE_DEFAULT	0x0cd0
>> +#define V2_CZERO_DEFAULT	0x016a
>> +#define ONE_PT_SLOPE		0x0cd0
>> +#define TWO_PT_SHIFTED_GAIN	921600
>> +#define ONE_PT_CZERO_CONST	94
>> +#define SENSOR_CONVERSION(n)	(((n) * 4) + SROT_Sn_CONVERSION)
>> +#define CONVERSION_SLOPE_SHIFT	10
>> +#define CONVERSION_SHIFT_SHIFT	23
> Please define bitfields with GENMASK() and use FIELD_PREP/GET() helpers
Sure, will change in the next patch.
>
>>   
>>   /* ----- TM ------ */
>>   #define TM_INT_EN_OFF			0x0004
>> @@ -59,6 +71,11 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>   	/* CTRL_OFF */
>>   	[TSENS_EN]     = REG_FIELD(SROT_CTRL_OFF,    0,  0),
>>   	[TSENS_SW_RST] = REG_FIELD(SROT_CTRL_OFF,    1,  1),
>> +	[SENSOR_EN]    = REG_FIELD(SROT_CTRL_OFF,    3,  18),
>> +	[CODE_OR_TEMP] = REG_FIELD(SROT_CTRL_OFF,    21, 21),
>> +
>> +	/* MAIN_MEASURE_PERIOD */
>> +	[MAIN_MEASURE_PERIOD] = REG_FIELD(SROT_MEASURE_PERIOD, 0, 7),
>>   
>>   	/* ----- TM ------ */
>>   	/* INTERRUPT ENABLE */
>> @@ -104,6 +121,130 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
>>   	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
>>   };
>>   
>> +static int tsens_v2_calibrate_sensor(struct device *dev, struct tsens_sensor *sensor,
>> +				     struct regmap *map,  u32 mode, u32 base0, u32 base1)
>> +{
>> +	u32 slope, czero, val;
>> +	char name[15];
> What's the rationale behind choosing 15 here?
Chose 15 when I had the sensor data name as s[0-9]+_offset. Right now 
sensor data name is changed to s[0-9]+, I can reduce it to 8 based on 
"mode0".
>
>> +	int ret;
>> +
> [...]
>
>> +static int tsens_v2_calibration(struct tsens_priv *priv)
>> +{
>> +	struct device *dev = priv->dev;
>> +	u32 mode, base0, base1;
>> +	int i, ret;
>> +
>> +	if (priv->num_sensors > MAX_SENSORS)
>> +		return -EINVAL;
>> +
>> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
>> +	if (ret == -ENOENT)
>> +		dev_warn(priv->dev, "Calibration data not present in DT\n");
> I think bindings don't allow that anyway
Updated the bindings in [v3 2/5] and with that it is allowing.
>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dev_dbg(priv->dev, "calibration mode is %d\n", mode);
>> +
>> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base0", &base0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Calibrate each sensor */
>> +	for (i = 0; i < priv->num_sensors; i++) {
>> +		ret = tsens_v2_calibrate_sensor(dev, &priv->sensor[i], priv->srot_map,
>> +						mode, base0, base1);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int __init init_tsens_v2_no_rpm(struct tsens_priv *priv)
>> +{
>> +	int i, ret;
>> +	u32 val = 0;
>> +	struct device *dev = priv->dev;
> Reverse-Christmas-tree, please.
Sure, will update in next patch.
>
>> +
>> +	ret = init_common(priv);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	priv->rf[CODE_OR_TEMP] = devm_regmap_field_alloc(dev, priv->srot_map,
>> +							 priv->fields[CODE_OR_TEMP]);
>> +	if (IS_ERR(priv->rf[CODE_OR_TEMP]))
>> +		return PTR_ERR(priv->rf[CODE_OR_TEMP]);
>> +
>> +	priv->rf[MAIN_MEASURE_PERIOD] = devm_regmap_field_alloc(dev, priv->srot_map,
>> +								priv->fields[MAIN_MEASURE_PERIOD]);
>> +	if (IS_ERR(priv->rf[MAIN_MEASURE_PERIOD]))
>> +		return PTR_ERR(priv->rf[MAIN_MEASURE_PERIOD]);
>> +
>> +	regmap_field_write(priv->rf[TSENS_SW_RST], 0x1);
>> +
>> +	/* Update measure period to 2ms */
> What's the unit? Can we name the 0x1 value?
Deci-Celcius is supported in hardware.
Sure, will name the values in the next patch.
>
>> +	regmap_field_write(priv->rf[MAIN_MEASURE_PERIOD], 0x1);
>> +
>> +	/* Enable available sensors */
>> +	for (i = 0; i < priv->num_sensors; i++)
>> +		val |= 1 << priv->sensor[i].hw_id;
>> +
>> +	regmap_field_write(priv->rf[SENSOR_EN], val);
>> +
>> +	/* Real temperature format */
> What does that mean?
Result format can be selected via the below write and supported format 
is ADC Code or Temperature in deci-celcius. Added a comment to mention 
selecting temperature format.
Will name the value and remove the comment.
>
>> +	regmap_field_write(priv->rf[CODE_OR_TEMP], 0x1);
>> +
>> +	regmap_field_write(priv->rf[TSENS_SW_RST], 0x0);
>> +
>> +	/* Enable TSENS */
>> +	regmap_field_write(priv->rf[TSENS_EN], 0x1);
> It would be really nice if you could provide the names of all these
> magic values.
Sure, will update in the next patch.
>
> Konrad
>> +
>> +	return 0;
>> +}
>> +
>>   static const struct tsens_ops ops_generic_v2 = {
>>   	.init		= init_common,
>>   	.get_temp	= get_temp_tsens_valid,
>> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
>> index 98c356acfe98..9dc0c2150948 100644
>> --- a/drivers/thermal/qcom/tsens.c
>> +++ b/drivers/thermal/qcom/tsens.c
>> @@ -974,7 +974,7 @@ int __init init_common(struct tsens_priv *priv)
>>   	ret = regmap_field_read(priv->rf[TSENS_EN], &enabled);
>>   	if (ret)
>>   		goto err_put_device;
>> -	if (!enabled) {
>> +	if (!enabled && (tsens_version(priv) != VER_2_X_NO_RPM)) {
>>   		dev_err(dev, "%s: device not enabled\n", __func__);
>>   		ret = -ENODEV;
>>   		goto err_put_device;
>> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
>> index 2805de1c6827..b2e8f0f2b466 100644
>> --- a/drivers/thermal/qcom/tsens.h
>> +++ b/drivers/thermal/qcom/tsens.h
>> @@ -35,6 +35,7 @@ enum tsens_ver {
>>   	VER_0_1,
>>   	VER_1_X,
>>   	VER_2_X,
>> +	VER_2_X_NO_RPM,
>>   };
>>   
>>   enum tsens_irq_type {
>> @@ -168,6 +169,8 @@ enum regfield_ids {
>>   	TSENS_SW_RST,
>>   	SENSOR_EN,
>>   	CODE_OR_TEMP,
>> +	/* MEASURE_PERIOD */
>> +	MAIN_MEASURE_PERIOD,
>>   
>>   	/* ----- TM ------ */
>>   	/* TRDY */
--
Thanks,
Praveenkumar
