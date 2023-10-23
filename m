Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26CB7D2A26
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjJWGQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjJWGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:16:52 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8B4D6B;
        Sun, 22 Oct 2023 23:16:49 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N5sNYG014832;
        Mon, 23 Oct 2023 06:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9tHPUSiSDmzQD1iZQ0eFe1roSph4jo63m+KHHJO3Czs=;
 b=eErNBa1hDtulLdHPfsbWJzIlb3wfvFPl1kcsmOjz+RKgIpMmPheP4JtSLeuKyWxT+mG2
 zqQ5QtLBhDb3J+czg9iQK50pRtELNtUZfNo/33Q7PYI7Yt9eT5M03gFBVy5xGfJYxqJD
 Xw7E+o9oqgRvc0yJjYh5KE1KkyLo3xZbUnmk+9+Mg14EnDJHvP55t3VswozBid/S7cdx
 CHtP2hI2PIZ0Zau9wD0cqGAWwFKQLv3KhLxyicSE1CULBfq3ap1C4uZVPSd55oJvSp+h
 EQ0y1W0AhtIpo94gLRJzgIXiBOv8fpffKalnlsobMZs6px2c13do1tEeHEp11RV5YRNT rA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7xfujc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:16:12 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6GB1N013479
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:16:11 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:15:59 -0700
Message-ID: <0b07febb-5577-cac7-8b45-4d9c9790d4e2@quicinc.com>
Date:   Mon, 23 Oct 2023 11:45:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 07/11] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        "Ramona Bolboaca" <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        Haibo Chen <haibo.chen@nxp.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-8-quic_jprakash@quicinc.com>
 <0b5771b3-31b1-c17c-2be4-9b71538078bb@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <0b5771b3-31b1-c17c-2be4-9b71538078bb@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SydEPT3FAe4bMxqwKrDJK-X_1nMCyftH
X-Proofpoint-GUID: SydEPT3FAe4bMxqwKrDJK-X_1nMCyftH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=783
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230054
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof.

On 7/9/2023 11:11 PM, Krzysztof Kozlowski wrote:
> On 08/07/2023 09:28, Jishnu Prakash wrote:
>> The ADC architecture on PMIC5 Gen3 is similar to that on PMIC5 Gen2,
>> with all SW communication to ADC going through PMK8550 which
>> communicates with other PMICs through PBS. One major difference is
>> that the register interface used here is that of an SDAM present on
> ...
>
>
>> +static int adc5_gen3_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct iio_dev *indio_dev;

>> +		irq = platform_get_irq(pdev, i);
>> +		if (irq < 0) {
>> +			dev_err(adc->dev, "Failed to get SDAM%d irq, ret=%d\n", i, irq);
>> +			return irq;
> return dev_err_probe

Will update it in the next patchset

>
>> +		}
>> +		adc->base[i].irq = irq;
>> +
>> +		scnprintf(buf, sizeof(buf), "adc-sdam%d", i);
>> +		adc->base[i].irq_name = devm_kstrdup(adc->dev, buf, GFP_KERNEL);
>> +		if (!adc->base[i].irq_name)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	platform_set_drvdata(pdev, adc);
>> +
>> +	init_completion(&adc->complete);
>> +	mutex_init(&adc->lock);
>> +
>> +	ret = adc5_get_fw_data(adc);
>> +	if (ret < 0) {
>> +		dev_err(adc->dev, "adc get dt data failed, ret=%d\n", ret);
> return dev_err_probe
Will update it in the next patchset
>
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < adc->num_sdams; i++) {
>> +		ret = devm_request_irq(dev, adc->base[i].irq, adc5_gen3_isr,
>> +					0, adc->base[i].irq_name, adc);
>> +		if (ret < 0) {
>> +			dev_err(adc->dev, "Getting IRQ %d failed, ret=%d\n", adc->base[i].irq, ret);
> return dev_err_probe
Will update it in the next patchset
>
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ret = adc_tm_register_tzd(adc);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (adc->n_tm_channels)
>> +		INIT_WORK(&adc->tm_handler_work, tm_handler_work);
>> +
>> +	indio_dev->name = pdev->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &adc5_gen3_info;
>> +	indio_dev->channels = adc->iio_chans;
>> +	indio_dev->num_channels = adc->nchannels;
>> +
>> +	return devm_iio_device_register(dev, indio_dev);
>> +}
>> +
>> +static int adc5_gen3_exit(struct platform_device *pdev)
>> +{
>> +	struct adc5_chip *adc = platform_get_drvdata(pdev);
>> +	u8 data = 0;
>> +	int i, sdam_index;
>> +
>> +	mutex_lock(&adc->lock);
>> +	/* Disable all available channels */
>> +	for (i = 0; i < adc->num_sdams * 8; i++) {
>> +		sdam_index = i / 8;
>> +		data = MEAS_INT_DISABLE;
>> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_TIMER_SEL, &data, 1);
>> +
>> +		/* To indicate there is an actual conversion request */
>> +		data = ADC5_GEN3_CHAN_CONV_REQ | (i - (sdam_index * 8));
>> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_PERPH_CH, &data, 1);
>> +
>> +		data = ADC5_GEN3_CONV_REQ_REQ;
>> +		adc5_gen3_write(adc, sdam_index, ADC5_GEN3_CONV_REQ, &data, 1);
>> +	}
>> +
>> +	mutex_unlock(&adc->lock);
>> +
>> +	if (adc->n_tm_channels)
>> +		cancel_work_sync(&adc->tm_handler_work);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver adc5_gen3_driver = {
>> +	.driver = {
>> +		.name = "qcom-spmi-adc5-gen3",
>> +		.of_match_table = adc5_match_table,
>> +	},
>> +	.probe = adc5_gen3_probe,
>> +	.remove = adc5_gen3_exit,
>> +};
>> +module_platform_driver(adc5_gen3_driver);
>> +
>> +MODULE_ALIAS("platform:qcom-spmi-adc5-gen3");
> Drop alias. If you need it, it means you screwed ID tables or your DTS.
>
>
> Best regards,
> Krzysztof


OK, I guess it's not needed, will drop it in the next patchset.

Thanks,

Jishnu


>
