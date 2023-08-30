Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB7178D201
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbjH3CVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjH3CUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:20:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCB31AD;
        Tue, 29 Aug 2023 19:20:36 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37U1QYo5010404;
        Wed, 30 Aug 2023 02:20:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=VqevAR2WBoXjzqJy62/LqZY/p887heW7e0n4UOrCB4M=;
 b=b9aH3+ROK0WQw/Sr6RG2cqqM+2sBoHXdFe9Wloh13JMZtKXq0cfyCoJ74AsCS/38OEjR
 UuCOARSbEFZWH9QlCXH6EqRHP/kh5Y12NaCJu11H168TFcy4E2M2pJqteW/tk1dXmKck
 HACEcqUWwEnbiWZAQeunX+Mn6khoAb6oWkFiKYO1X+HRq9KZyxrCtaKFdp+ckr8zIzCt
 BqHWiB5QNmkipuAVyBr2FaslCFsPBpgRccAvdDcc4p6cSTDqqv82nbEOaF43ivQN0YKG
 87igxTiXVMoJ0AAir9rkoMADuAL3NVi0UCOYWM3/ksP47Z4mpxsYRxrvgFD5MKiPCwl9 JQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sruhnv5ch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 02:20:31 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37U2KUw0020019
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 02:20:30 GMT
Received: from [10.216.63.45] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 29 Aug
 2023 19:20:25 -0700
Message-ID: <ee50d097-6213-36dd-9966-bdd5b2bb953b@quicinc.com>
Date:   Wed, 30 Aug 2023 07:50:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 3/7] thermal/drivers/qcom/tsens: Add support for IPQ5018
 tsens
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-4-git-send-email-quic_srichara@quicinc.com>
 <CAA8EJpoHCW2H12U9wzmz5a86TriZr9mLuPi6D6h02byAWOG2mQ@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAA8EJpoHCW2H12U9wzmz5a86TriZr9mLuPi6D6h02byAWOG2mQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BXsVVyP3tsGlC49FkZgAmbaflBtU4Qxs
X-Proofpoint-ORIG-GUID: BXsVVyP3tsGlC49FkZgAmbaflBtU4Qxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300019
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<..>

>> +{
>> +       u32 p1[10], p2[10];
>> +       u32 *qfprom_cdata;
>> +       int mode;
>> +
>> +       qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>> +       if (IS_ERR(qfprom_cdata))
>> +               return PTR_ERR(qfprom_cdata);
>> +
>> +       mode = tsens_read_calibration_legacy(priv, &tsens_ipq5018_nvmem,
>> +                                            p1, p2,
>> +                                            qfprom_cdata, NULL);
> 
> No, this should be used only in _legacy_ cases. Please use
> tsens_calibrate_common() / tsens_calibrate_nvmem() / etc.
> 

  ok.

>> +
>> +       fixup_ipq5018_points(mode, p1, p2);
>> +       compute_intercept_slope(priv, p1, p2, mode);
>> +       kfree(qfprom_cdata);
>> +
>> +       return 0;
>> +}
>> +
>>   static int calibrate_v1(struct tsens_priv *priv)
>>   {
>>          u32 p1[10], p2[10];
>> @@ -79,6 +132,18 @@ static struct tsens_features tsens_v1_feat = {
>>          .trip_max_temp  = 120000,
>>   };
>>
>> +static struct tsens_features tsens_v1_ipq5018_feat = {
>> +       .ver_major      = VER_1_X,
>> +       .crit_int       = 0,
>> +       .combo_int      = 0,
>> +       .adc            = 1,
>> +       .srot_split     = 1,
>> +       .max_sensors    = 11,
>> +       .trip_min_temp  = -40000,
>> +       .trip_max_temp  = 120000,
>> +       .no_early_init  = 1,
>> +};
>> +
>>   static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
>>          /* ----- SROT ------ */
>>          /* VERSION */
>> @@ -150,6 +215,43 @@ static int __init init_8956(struct tsens_priv *priv) {
>>          return init_common(priv);
>>   }
>>
>> +static int init_ipq5018(struct tsens_priv *priv)
>> +{
>> +       int ret;
>> +       u32 mask;
>> +
>> +       init_common(priv);
>> +       if (!priv->tm_map)
>> +               return -ENODEV;
>> +
>> +       ret = regmap_field_write(priv->rf[TSENS_SW_RST], 1);
>> +       if (ret) {
>> +               dev_err(priv->dev, "Reset failed\n");
>> +               return ret;
>> +       }
>> +
>> +       mask = GENMASK(10, 0);
> 
> #define this, then inline the variable. Or extract this codepiece into
> generic function which uses num_sensors to calculate the mask
> 

  ok.

>> +       ret = regmap_field_update_bits(priv->rf[SENSOR_EN], mask, mask);
>> +       if (ret) {
>> +               dev_err(priv->dev, "Sensor Enable failed\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = regmap_field_write(priv->rf[TSENS_EN], 1);
>> +       if (ret) {
>> +               dev_err(priv->dev, "Enable failed\n");
>> +               return ret;
>> +       }
>> +
>> +       ret = regmap_field_write(priv->rf[TSENS_SW_RST], 0);
>> +       if (ret) {
>> +               dev_err(priv->dev, "Reset failed\n");
> 
> This error message is useless. You can not determine if it comes from
> this error or from setting the reset bit.
> 

  ok, will drop it.

Regards,
  Sricharan

