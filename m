Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A8751BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjGMIhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbjGMIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:37:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06AA4C1E;
        Thu, 13 Jul 2023 01:31:20 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D690Wc022749;
        Thu, 13 Jul 2023 08:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8Nis+TfQQ60xMMpmpAn7X685qG++5OrxMeY/JoeqHhE=;
 b=UmChsKaK6K2+dYjS5XhQeldoBZqOkBW128+Yfo8MO/Xcq8ucIk7nlqRnA5cw7c/Uqomz
 qwi6Nx9WwTCYKMD8su9tW12OAd0uiLzwbenfygeTth81c+Wh8FqF7QSJBeIcm/VeWAEf
 0y9jAI2tNqMbGqab96ZHSYdsI0fL39bGTNtcGOCYVeMSZNRVtxp7NP/ghYQM4z4vWGOn
 EMBkxVzamKautAQhjJJEFWFjfiTQnTX3B6BD6WeRaSh1Syb63b0/yPd+NZhku3dPFBvA
 nn9fSCD3KLHFMn2umEUOo/zKHZfjpHdwz5mrQ1HJuSh7vOiSW9ex9mZ1ltQE9M0Jut4U 6g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsgarbe9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:31:10 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D8V95d007018
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 08:31:09 GMT
Received: from [10.50.29.227] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 01:30:40 -0700
Message-ID: <b33fddb8-b5de-a4dc-3795-bfb3ebf44319@quicinc.com>
Date:   Thu, 13 Jul 2023 14:00:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 2/3] usb: misc: Add notifier call chain to Embedded USB
 Debug(EUD) driver
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1689148711.git.quic_schowdhu@quicinc.com>
 <18212c7abbb8c833cc07f8500d4905b79c49ec59.1689148711.git.quic_schowdhu@quicinc.com>
 <CAH=2Ntz8JEGp_Atsv3iToUG1WdLKvdt5GYu7a=LwgmgY7v0rvw@mail.gmail.com>
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
In-Reply-To: <CAH=2Ntz8JEGp_Atsv3iToUG1WdLKvdt5GYu7a=LwgmgY7v0rvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I0ZCF5f4y-kgScOhUZzZWf7dGTRd6mv_
X-Proofpoint-ORIG-GUID: I0ZCF5f4y-kgScOhUZzZWf7dGTRd6mv_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1011 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130073
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/2023 11:52 PM, Bhupesh Sharma wrote:
> Hi Souradeep,
> 
> On Wed, 12 Jul 2023 at 13:58, Souradeep Chowdhury
> <quic_schowdhu@quicinc.com> wrote:
>>
>> Add the notifier call chain to EUD driver. The notifier call chain
>> is added to check the role-switch status of EUD. When multiple
>> modules are switching roles on the same port, they need to call this
>> notifier to check the role-switch status of EUD. If EUD is disabled,
>> then the modules can go for the role-switch, otherwise it needs to
>> be blocked. The notifier chain can be used to link multiple modules
>> switching roles on the same port and create a ordering, priority and
>> conflict resolution among them. The wrapper functions are defined here
>> which can be used to register a notifier block to the chain, deregister
>> it and also call the chain.
>>
>> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
>> ---
>>   drivers/usb/misc/qcom_eud.c | 52 +++++++++++++++++++++++++++++++++++--
>>   1 file changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
>> index 7f371ea1248c..e6c97a2cf2df 100644
>> --- a/drivers/usb/misc/qcom_eud.c
>> +++ b/drivers/usb/misc/qcom_eud.c
>> @@ -11,10 +11,13 @@
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>   #include <linux/sysfs.h>
>>   #include <linux/usb/role.h>
>> +#include "qcom_eud_notifier.h"
>>
>>   #define EUD_REG_INT1_EN_MASK   0x0024
>>   #define EUD_REG_INT_STATUS_1   0x0044
>> @@ -22,14 +25,16 @@
>>   #define EUD_REG_VBUS_INT_CLR   0x0080
>>   #define EUD_REG_CSR_EUD_EN     0x1014
>>   #define EUD_REG_SW_ATTACH_DET  0x1018
>> -#define EUD_REG_EUD_EN2                0x0000
>> +#define EUD_REG_EUD_EN2        0x0000
>>
>>   #define EUD_ENABLE             BIT(0)
>> -#define EUD_INT_PET_EUD                BIT(0)
> 
> These indentation issues are already addressed in my EUD patches.
> Please rebase your patches on the same to reuse those
Ack

> 
>> +#define EUD_INT_PET_EUD        BIT(0)
>>   #define EUD_INT_VBUS           BIT(2)
>>   #define EUD_INT_SAFE_MODE      BIT(4)
>>   #define EUD_INT_ALL            (EUD_INT_VBUS | EUD_INT_SAFE_MODE)
>>
>> +static RAW_NOTIFIER_HEAD(eud_nh);
>> +
>>   struct eud_chip {
>>          struct device                   *dev;
>>          struct usb_role_switch          *role_sw;
>> @@ -41,6 +46,42 @@ struct eud_chip {
>>          bool                            usb_attached;
>>   };
>>
>> +int eud_register_notify(struct notifier_block *nb)
>> +{
>> +       return raw_notifier_chain_register(&eud_nh, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(eud_register_notify);
>> +
>> +void eud_unregister_notify(struct notifier_block *nb)
>> +{
>> +       raw_notifier_chain_unregister(&eud_nh, nb);
>> +}
>> +EXPORT_SYMBOL_GPL(eud_unregister_notify);
>> +
>> +void eud_notifier_call_chain(unsigned long role_switch_state)
>> +{
>> +       raw_notifier_call_chain(&eud_nh, role_switch_state, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(eud_notifier_call_chain);
> 
> Probably I missed it, but you have not provided any example users of
> these APIs in the patchset or reference to another one which shows how
> these APIs are used.

Ack, the usage for this will be posted in the next version.

> 
>> +static int eud_vbus_spoof_attach_detach(struct notifier_block *nb, unsigned long event,
>> +                                       void *data)
>> +{
>> +       struct device_node *eud = of_find_compatible_node(NULL, NULL, "qcom,eud");
>> +       struct device *eud_device = bus_find_device_by_of_node(&platform_bus_type, eud);
>> +       struct eud_chip  *eud_data = dev_get_drvdata(eud_device);
>> +
>> +       if (eud_data->enabled  && event != USB_ROLE_DEVICE)
>> +               return NOTIFY_BAD;
>> +       else
>> +               return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block eud_notifier = {
>> +       .notifier_call = eud_vbus_spoof_attach_detach,
>> +       .priority = 1,
> 
> Why do you need a 'priority = 1' here, it can be 0 or even lower?

Priority is 0 by default for a notifier block, since eud notifier
needs to be the first to be called in the chain to check the
role-switch status, I have kept the priority as 1 here.

> 
> Thanks,
> Bhupesh
> 
>> +};
>> +
>>   static int enable_eud(struct eud_chip *priv)
>>   {
>>          writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
>> @@ -196,6 +237,10 @@ static int eud_probe(struct platform_device *pdev)
>>                  return dev_err_probe(chip->dev, ret,
>>                                  "failed to add role switch release action\n");
>>
>> +       ret = eud_register_notify(&eud_notifier);
>> +       if (ret)
>> +               return dev_err_probe(chip->dev, ret, "failed to register notifier\n");
>> +
>>          chip->base = devm_platform_ioremap_resource(pdev, 0);
>>          if (IS_ERR(chip->base))
>>                  return PTR_ERR(chip->base);
>> @@ -226,6 +271,9 @@ static void eud_remove(struct platform_device *pdev)
>>
>>          device_init_wakeup(&pdev->dev, false);
>>          disable_irq_wake(chip->irq);
>> +       eud_unregister_notify(&eud_notifier);
>> +
>> +       return 0;
>>   }
>>
>>   static const struct of_device_id eud_dt_match[] = {
>> --
>> 2.17.1
>>
