Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC760754411
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236299AbjGNVGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjGNVGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:06:04 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADC2735;
        Fri, 14 Jul 2023 14:06:02 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EKxNNK007685;
        Fri, 14 Jul 2023 21:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : cc : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Ms9TLlo2He1cUv8G+DWoc1UYc5TuGr3UZ3dnSNWqRNo=;
 b=e9kRz/CagMbF269726sO0iRTOxn/chlrUrulK/OtHtIWeOdIdV80oYNoIdexYfit2WSD
 arJtSO9HXIdRHDbUDQDfHzuqZbzjWNrOFIspXR4/qUM7KFJeGajsoId8fQLLSd9Ya4Q3
 ah1jmzpR+XELDMOL6OiwR85kf299suRnI6xgEZwALUySSlVAyo0RIe4KYu+MnYFXJz4Z
 PxJvCye54yEMk0VGzylL+mq56q05k2T6PcrnLiT7RJUq4WpsQgp6u9Wn+K5TPHwfFZ7g
 G1yl1bNYRTPxQHcOKi+BJ+D3cPeiVMphuHHKttb7r3Id+2AfwriBil2o2wUlRfWmvWkZ 6w== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpujtspd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 21:05:57 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36EL5XGN023895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 21:05:33 GMT
Received: from [10.110.26.85] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 14 Jul
 2023 14:05:32 -0700
Message-ID: <d43a0ce0-c915-a5d2-1d01-549ae08c678e@quicinc.com>
Date:   Fri, 14 Jul 2023 14:04:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: FW: [PATCH] pinctrl: qcom: Add intr_target_width to define
 intr_target_bit field width
To:     "Ninad Naik (QUIC)" <quic_ninanaik@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230714061010.15817-1-quic_ninanaik@quicinc.com>
 <p5vyji2weclwgshyxbf2evzpzefckzyecjnoada7dvzbuenxsb@55abp36rrbub>
 <BY5PR02MB6339C6B8A53C5D0CB55E58B7C034A@BY5PR02MB6339.namprd02.prod.outlook.com>
Content-Language: en-US
CC:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Parikshit Pareek (QUIC)" <quic_ppareek@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        "Prasanna Kumar (QUIC)" <quic_kprasan@quicinc.com>,
        <quic_psodagud@quicinc.com>
From:   Prasad Sodagudi <quic_psodagud@quicinc.com>
In-Reply-To: <BY5PR02MB6339C6B8A53C5D0CB55E58B7C034A@BY5PR02MB6339.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SKNdTqWP19OYvYgLC95YrM9BuyI-7YLw
X-Proofpoint-ORIG-GUID: SKNdTqWP19OYvYgLC95YrM9BuyI-7YLw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_10,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140193
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Halaney <ahalaney@redhat.com>
> Sent: Friday, July 14, 2023 11:17 AM
> To: Ninad Naik (QUIC) <quic_ninanaik@quicinc.com>
> Cc: andersson@kernel.org; agross@kernel.org; konrad.dybcio@linaro.org; linux-arm-msm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-kernel@vger.kernel.org; Parikshit Pareek (QUIC) <quic_ppareek@quicinc.com>; Prasad Sodagudi <psodagud@quicinc.com>; Prasanna Kumar (QUIC) <quic_kprasan@quicinc.com>
> Subject: Re: [PATCH] pinctrl: qcom: Add intr_target_width to define intr_target_bit field width
> 
> WARNING: This email originated from outside of Qualcomm. Please be wary of any links or attachments, and do not enable macros.
> 
> On Fri, Jul 14, 2023 at 11:40:09AM +0530, Ninad Naik wrote:
>> SA8775 and newer target have added support for an increased number of
>> interrupt targets. To implement this change, the intr_target field,
>> which is used to configure the interrupt target in the interrupt
>> configuration register is increased from 3 bits to 4 bits.
>>
>> In accordance to these updates, a new intr_target_width member is
>> introduced in msm_pingroup structure. This member stores the value of
>> width of intr_target field in the interrupt configuration register.
>> This value is used to dynamically calculate and generate mask for
>> setting the intr_target field. By default, this mask is set to 3 bit
>> wide, to ensure backward compatibility with the older targets.
>>
>> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> 
> Thanks for the patch. Naive question (without really reading the code), but what practical affect does this have?
> 

Target bits configures irq destination processor on Qualcomm SoC. 
g->intr_target_kpss_val(0x3) routes the gpio IRQ to application process.
On this SoCs target bits length is changed from 3 bits to 4 bits in hw 
and reset value of g->intr_target_reg register value is 0x1E2. So reset 
value of target bits is 0xf.  With old logic, when writing 
g->intr_target_kpss_val(0x3) value result is 0xb instead of 0x3 as top 
most bit is not getting cleared out and leading to IRQ is not getting 
fired on application processor. 0xb value is unused on current HW and 
IRQ would not be fired.

> i.e. does this change behavior of how IRQs were handled before this patch vs after on this platform?
> 
> To shed some light on the question, there's a GPIO IRQ for the ethernet phy on this platform that is purposely _not_ described because it didn't ever trigger, resulting in the interface staying down. Things work fine without the IRQ (the driver goes into polling mode).
> The explanation I got was very brief and attributed it to a "hardware issue".
> 
> I'm wondering if I should re-evaluate that, and if this was the "hardware issue".

Hi Andrew,

I don't have complete idea on ethernet phy gpio irq issue and I will 
sync up with offline. Please try this patch for ethernet use case.

> 
> Thanks,
> Andrew
> 
