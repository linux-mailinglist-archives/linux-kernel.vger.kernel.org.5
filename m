Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716DD77C050
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjHNTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjHNTEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:04:47 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C110F2;
        Mon, 14 Aug 2023 12:04:46 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EEaSlr029603;
        Mon, 14 Aug 2023 19:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wLkiQoulrtVl1nu/eQK5PDKtYkoSrqvchhDnIYIqfnI=;
 b=mICfmRZaPP60mqlT2EIDwOU0s6CxiY2pYbIELVWyGXZz4JGqt4uivW0P1FT+m4V8zGaD
 X5woDVViLwrKbuykBVD7YOoC3xwbc459T6MUphR/9uF4kFA/mAQMhK50CC8zmlw1PxNW
 ALsDhOFehaFEzfWtEatuGoqEEvYIoFJV0g571nOqJxAURRlfiYjcvVKooQ3QvGY0UhgJ
 GvzXoGpOV40P3zfCTlyfdVdISwXs71EqbwaBhX2lUx3VAF8cPVUS/Ve0J4rDLDze73dF
 aMpGUgMxAuujIyPamRvgT+BUJ6jTgTJdSiaTDKuR6jEFEpsAGKNmkzZtjP2j3lakRFM8 1Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3tymn54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:04:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37EJ4exu026356
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 19:04:40 GMT
Received: from [10.50.35.106] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 14 Aug
 2023 12:04:36 -0700
Message-ID: <fabe1f43-278c-bd29-bd85-937a87f0c27a@quicinc.com>
Date:   Tue, 15 Aug 2023 00:34:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/33] iris: vidc: define video core and instance context
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-7-git-send-email-quic_vgarodia@quicinc.com>
 <1d640aca-761e-602e-1de4-e34c8184d53d@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <1d640aca-761e-602e-1de4-e34c8184d53d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TiXBkOlSUNXQ6y3uIEyILVXKWI_BpmE8
X-Proofpoint-ORIG-GUID: TiXBkOlSUNXQ6y3uIEyILVXKWI_BpmE8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140176
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/2023 9:17 PM, Bryan O'Donoghue wrote:
> On 28/07/2023 14:23, Vikash Garodia wrote:
>> +#define call_iris_op(d, op, ...)            \
>> +    (((d) && (d)->iris_ops && (d)->iris_ops->op) ? \
>> +    ((d)->iris_ops->op(__VA_ARGS__)) : 0)
>> +
>> +struct msm_vidc_iris_ops {
>> +    int (*boot_firmware)(struct msm_vidc_core *core);
>> +    int (*raise_interrupt)(struct msm_vidc_core *core);
>> +    int (*clear_interrupt)(struct msm_vidc_core *core);
>> +    int (*prepare_pc)(struct msm_vidc_core *core);
>> +    int (*power_on)(struct msm_vidc_core *core);
>> +    int (*power_off)(struct msm_vidc_core *core);
>> +    int (*watchdog)(struct msm_vidc_core *core, u32 intr_status);
>> +};
> 
> So I don't see how this code supports booting the venus firmware, is that
> not required on 8550 ?
> 
> I've applied the full patchset to -next
> 
> We don't appear to have enumerated callbacks for booting, clearing
> interrupts..

Hi Bryan,

Seems you are looking in the incorrect folder, these APIs are implemented
in variant specific folder, i.e. iris/variant/iris3

Thanks,
Dikshita
> 
> grep -r clear_interrupt drivers/media/platform/qcom/iris/vidc/src/*
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: call_iris_op(core,
> clear_interrupt, core);
> 
> grep -r boot_firmware drivers/media/platform/qcom/iris/vidc/src/*
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:    rc =
> call_iris_op(core, boot_firmware, core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:    rc =
> call_iris_op(core, boot_firmware, core);
> 
> There is dead code @ raise_interrupt..
> 
> grep -r raise_interrupt drivers/media/platform/qcom/iris/vidc/src/*
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c:    
> call_iris_op(core, raise_interrupt, core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c:        
> //call_iris_op(core, raise_interrupt, core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi_queue.c:        
> //call_iris_op(core, raise_interrupt, core);
> 
> grep -r clear_interrupt drivers/media/platform/qcom/iris/vidc/src/*
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c: call_iris_op(core,
> clear_interrupt, core);
> 
> grep -r prepare_pc drivers/media/platform/qcom/iris/vidc/src/*
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:int
> __prepare_pc(struct msm_vidc_core *core)
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:    rc =
> call_iris_op(core, prepare_pc, core);
> 
> 
> Here we have an admixture of the new name "Iris" with the old name "venus"
> 
> grep -r power_on drivers/media/platform/qcom/iris/vidc/src/*
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:static int
> __venus_power_on(struct msm_vidc_core *core)
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:    rc =
> call_iris_op(core, power_on, core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:    rc =
> __venus_power_on(core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:        goto
> err_venus_power_on;
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:err_venus_power_on:
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:    rc =
> __venus_power_on(core);
> 
> grep -r power_off drivers/media/platform/qcom/iris/vidc/src/*
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:        goto
> skip_power_off;
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:skip_power_off:
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:static int
> __venus_power_off(struct msm_vidc_core *core)
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:    rc =
> call_iris_op(core, power_off, core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:
> __venus_power_off(core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:
> __venus_power_off(core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:
> __venus_power_off(core);
> drivers/media/platform/qcom/iris/vidc/src/venus_hfi.c:
> __venus_power_off(core);
> 
> Lending credence to the argument we could incorporate all of some of the is
> logic in the existing venus driver.
> 
> ---
> bod
