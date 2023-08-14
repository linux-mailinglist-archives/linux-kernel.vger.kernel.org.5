Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31F77C012
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjHNSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjHNSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:51:29 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238DF198B;
        Mon, 14 Aug 2023 11:51:13 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EHlta1022577;
        Mon, 14 Aug 2023 18:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=phoC/O7eCcL2cGh+JNsn5vXg5g6ANzfAakik8m8EXi8=;
 b=JwjWJFCY05ZPLKELz27nNx53QZdUFNuxSLCywGJ9RVnSfQKD4eJh7XRinzWG+IqVH0eq
 RE0xv5Zanu86kh4VEiC/Rxcwgy+++GMwcOMhahlrQTfZ9KBHrirFr+y28Zk+i9UEKerp
 9KfqNTZzKAvLi0xWFh3N2ixMuNWLCjtqDfW1cxW0iNTRT1SkxgBeLEafKIkZByZjMbKh
 hkri9AwufQxHXS2WLWDPm4dulx+Y2qUEQleE9e+3KGPMzFOzWGYAKTTZz/JTP9lnu4ys
 5tpi64r5M2YYSa8LheJmgmneLAqumMkRJQIBKqV2i3vSW29Wd9mGd554db+kSK80juhA Xw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3j94mvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:51:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EIp83j016880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 18:51:08 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 11:51:04 -0700
Message-ID: <040315c8-5e74-5a5f-7187-1dfda71501f3@quicinc.com>
Date:   Tue, 15 Aug 2023 00:21:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
 <ac212920-286c-1ef5-fd40-a59717f59a92@kernel.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <ac212920-286c-1ef5-fd40-a59717f59a92@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 69wURsJO5GiidJOWcttyFZ1ZPlLouHwA
X-Proofpoint-GUID: 69wURsJO5GiidJOWcttyFZ1ZPlLouHwA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/2023 2:53 AM, Krzysztof Kozlowski wrote:
> On 28/07/2023 15:23, Vikash Garodia wrote:
>> From: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>
>> This implements the platform driver methods, file
>> operations and v4l2 registration.
> 
> 
>> +
>> +	core->debugfs_parent = msm_vidc_devm_debugfs_get(&pdev->dev);
>> +	if (!core->debugfs_parent)
>> +		d_vpr_h("Failed to create debugfs for msm_vidc\n");
>> +
>> +	rc = msm_vidc_devm_init_core(&pdev->dev, core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init core failed with %d\n", __func__, rc);
>> +		goto init_core_failed;
>> +	}
>> +
>> +	rc = msm_vidc_init_platform(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init platform failed with %d\n", __func__, rc);
>> +		rc = -EINVAL;
>> +		goto init_plat_failed;
>> +	}
>> +
>> +	rc = msm_vidc_init_resources(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init resource failed with %d\n", __func__, rc);
>> +		goto init_res_failed;
> 
> NAK.
> 
> return dev_err_probe.
Sure, will update in next version.
> 
>> +	}
>> +
>> +	rc = msm_vidc_init_core_caps(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init core caps failed with %d\n", __func__, rc);
>> +		goto init_res_failed;
>> +	}
>> +
>> +	rc = msm_vidc_init_instance_caps(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: init inst cap failed with %d\n", __func__, rc);
>> +		goto init_inst_caps_fail;
>> +	}
>> +
>> +	core->debugfs_root = msm_vidc_debugfs_init_core(core);
>> +	if (!core->debugfs_root)
>> +		d_vpr_h("Failed to init debugfs core\n");
>> +
>> +	d_vpr_h("populating sub devices\n");
>> +	/*
>> +	 * Trigger probe for each sub-device i.e. qcom,msm-vidc,context-bank.
>> +	 * When msm_vidc_probe is called for each sub-device, parse the
>> +	 * context-bank details.
>> +	 */
>> +	rc = of_platform_populate(pdev->dev.of_node, msm_vidc_dt_match, NULL,
>> +				  &pdev->dev);
>> +	if (rc) {
>> +		d_vpr_e("Failed to trigger probe for sub-devices\n");
>> +		goto sub_dev_failed;
>> +	}
>> +
>> +	rc = v4l2_device_register(&pdev->dev, &core->v4l2_dev);
>> +	if (rc) {
>> +		d_vpr_e("Failed to register v4l2 device\n");
>> +		goto v4l2_reg_failed;
>> +	}
>> +
>> +	/* setup the decoder device */
>> +	rc = msm_vidc_register_video_device(core, MSM_VIDC_DECODER, nr);
>> +	if (rc) {
>> +		d_vpr_e("Failed to register video decoder\n");
>> +		goto dec_reg_failed;
>> +	}
>> +
>> +	/* setup the encoder device */
>> +	rc = msm_vidc_register_video_device(core, MSM_VIDC_ENCODER, nr + 1);
>> +	if (rc) {
>> +		d_vpr_e("Failed to register video encoder\n");
>> +		goto enc_reg_failed;
>> +	}
>> +
>> +	rc = venus_hfi_queue_init(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: interface queues init failed\n", __func__);
>> +		goto queues_init_failed;
>> +	}
>> +
>> +	rc = msm_vidc_core_init(core);
>> +	if (rc) {
>> +		d_vpr_e("%s: sys init failed\n", __func__);
>> +		goto core_init_failed;
>> +	}
>> +
>> +	d_vpr_h("%s(): succssful\n", __func__);
> 
> No need, drop.
Sure, will drop.
> 
>> +
>> +	return rc;
>> +
>> +core_init_failed:
>> +	venus_hfi_queue_deinit(core);
>> +queues_init_failed:
>> +	of_platform_depopulate(&pdev->dev);
>> +sub_dev_failed:
>> +	msm_vidc_unregister_video_device(core, MSM_VIDC_ENCODER);
>> +enc_reg_failed:
>> +	msm_vidc_unregister_video_device(core, MSM_VIDC_DECODER);
>> +dec_reg_failed:
>> +	v4l2_device_unregister(&core->v4l2_dev);
>> +v4l2_reg_failed:
>> +init_inst_caps_fail:
>> +init_res_failed:
>> +init_plat_failed:
>> +init_core_failed:
> 
> Ykes! No. This code needs more work.
> 
I understand, will improve the design in next version.
> Best regards,
> Krzysztof
> 
