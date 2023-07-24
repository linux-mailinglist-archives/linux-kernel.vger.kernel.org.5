Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF575FF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjGXTFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGXTFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:05:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733DC10E4;
        Mon, 24 Jul 2023 12:05:46 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OIU8wU003197;
        Mon, 24 Jul 2023 19:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wC025CNht+9KR2mC22tO0sPKA82DlAb+CLXGtVfxd3o=;
 b=VLqV0uUijpzGntuns1fdLxa6MEfRdf2mZ+oNYWI4iOa5a4Fvra1g8cl4d4FgHtvxyYWg
 dp4XAkQ7MvujXC3Hii1kXJsdG40BUovJbUhR9qMi34vOR/LLxSFvmtPscgG6MTPK3RQZ
 EvnHERV9amxxRkR5W9bmsJZ3LDdK1DdlfH5g82BMlEWzV87lgCDr8ujlN6kD3RYk2nah
 7sVyQFD7jAxYNGAlz0fG3il+Sexep9LX0D92454FfT9h543Ygnejfos2/ePaNSkxpUib
 ERltU/dd1TEqOmMs0iD3IGFFV6vL70E84jsei8TQyoHWu8edobUvPWycH3PRK4/Bl04w pQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s1s1jrxny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 19:05:41 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36OJ5e6l028382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jul 2023 19:05:40 GMT
Received: from [10.134.65.165] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 24 Jul
 2023 12:05:39 -0700
Message-ID: <cc1fec2c-1356-2716-86cf-5b76c18ec1dd@quicinc.com>
Date:   Mon, 24 Jul 2023 12:05:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V5 0/3] Introduce the read-modify-write API to collect
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Mukesh Ojha" <quic_mojha@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_saahtoma@quicinc.com>
References: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230720070408.1093698-1-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1doaf5B8T8Hl4YKTuaOv56BnbWtEhxD9
X-Proofpoint-ORIG-GUID: 1doaf5B8T8Hl4YKTuaOv56BnbWtEhxD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_14,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=597 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240168
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 12:04 AM, Kathiravan T wrote:
> On IPQ platforms, to collect the crashdump, we need to just modify the
> DLOAD bit in the TCSR register. Current infrastructure, overwrites the
> entire regiter value when enabling the crashdump feature, which leads to
> crashdump not gets collected. This series introduce the
> qcom_scm_io_update_field API to achieve the same.
> 

I don't think you describe patch 2 in the subject line or cover letter. 
As best I can tell, Patches 2 and 3 are independent. They're similar 
only in that they both depend on patch 1.

> Intially this approach is posted by Poovendhan[1], later Mukesh
> integrated this patch in his minidump support series[2]. Based on the
> current feedback on the minidump series, seems it will take sometime to
> get into a good shape, in the meantime these patches doesn't have any
> dependency with the minidump series. As discussed with the Mukesh[3],
> posting these 3 patches to enable the crashdump on IPQ chipsets.
> 
> Since the current version of minidump series is V4, I'm posting this as
> a V5. Please let me know if this should be V1.
> 
> [1]
> https://lore.kernel.org/linux-arm-msm/20230113160012.14893-4-quic_poovendh@quicinc.com/
> 
> [2]
> https://lore.kernel.org/linux-arm-msm/1676990381-18184-3-git-send-email-quic_mojha@quicinc.com/
> 
> [3]
> https://lore.kernel.org/linux-arm-msm/d77f5601-2b08-a7c7-1400-7ab68b8add3a@quicinc.com/
> 
> 
> Mukesh Ojha (3):
>    firmware: qcom_scm: provide a read-modify-write function
>    pinctrl: qcom: Use qcom_scm_io_update_field()
>    firmware: scm: Modify only the download bits in TCSR register
> 
>   drivers/firmware/qcom_scm.c            | 26 ++++++++++++++++++++++++--
>   drivers/pinctrl/qcom/pinctrl-msm.c     | 12 +++++-------
>   include/linux/firmware/qcom/qcom_scm.h |  2 ++
>   3 files changed, 31 insertions(+), 9 deletions(-)
> 
