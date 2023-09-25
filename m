Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47457ACE87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjIYCzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIYCzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:55:13 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E45A4;
        Sun, 24 Sep 2023 19:55:05 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P2gt4X007064;
        Mon, 25 Sep 2023 02:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=7UFvb4x1ufa4NQ2eiWXACcu4+I4OVBxRffudukHAra0=;
 b=XgKklgdbCXZwYWUnELRESYNXa06shr/HtNPD/EBaX9W6CICjBzWlXCkGtwQoWj5SyJx1
 TovrETGH65NCqLme8ilkrFlZSg6Kjn3owasMyLH2MhRW3HclUmAjONlhggD4Ip0VIMaT
 BUDvRkXaArRmZvM28myi76Td+/LevgEZD7mYkBR6FtKUPkA7EcRz9RvlMm+PE+TaFhff
 c3a4qXN5RDA1kzwjhYKWtHLBvqGbkRp0fVxC4XVP7wsokDiiu7H+51Ecgc+DwggwwZOv
 MD/JWHlIIvc0DttnkjWdq0bvGviPOj853Bv/tTH5Mig9osa3BO7hu9LnETJTd+BDgexd vw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t9s6uapg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:54:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38P2spSs015416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 02:54:51 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 24 Sep
 2023 19:54:48 -0700
Message-ID: <12887370-0ada-359b-8a4f-18a28495c69a@quicinc.com>
Date:   Mon, 25 Sep 2023 10:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH v6 3/3] input: pm8xxx-vibrator: add new SPMI
 vibrator support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <quic_collinsd@quicinc.com>,
        <quic_subbaram@quicinc.com>, <quic_kamalw@quicinc.com>,
        <jestar@qti.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>
References: <20230922083801.3056724-1-quic_fenglinw@quicinc.com>
 <20230922083801.3056724-4-quic_fenglinw@quicinc.com>
 <CAA8EJpoW8DJOTVHBu9_+BQs5DtxyJu3xrCfDNyYHn2MeHZHV4w@mail.gmail.com>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <CAA8EJpoW8DJOTVHBu9_+BQs5DtxyJu3xrCfDNyYHn2MeHZHV4w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HMgsSnKTi8houzVy0Duw3ykix6KzWOOG
X-Proofpoint-GUID: HMgsSnKTi8houzVy0Duw3ykix6KzWOOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-24_21,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=825 impostorscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309250017
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/2023 3:07 AM, Dmitry Baryshkov wrote:
>> +
>> +       switch (vib->data->hw_type) {
>> +       case SSBI_VIB:
>>                  mask = SSBI_VIB_DRV_LEVEL_MASK;
>>                  shift = SSBI_VIB_DRV_SHIFT;
>> +               break;
>> +       case SPMI_VIB:
>> +               mask = SPMI_VIB_DRV_LEVEL_MASK;
>> +               shift = SPMI_VIB_DRV_SHIFT;
>> +               break;
>> +       case SPMI_VIB_GEN2:
>> +               mask = SPMI_VIB_GEN2_DRV_MASK;
>> +               shift = SPMI_VIB_GEN2_DRV_SHIFT;
>> +               break;
>> +       default:
>> +               return -EINVAL;
> Could you please move the switch to the previous patch? Then it would
> be more obvious that you are just adding the SPMI_VIB_GEN2 here.
> 
> Other than that LGTM.

Sure, I can move the switch to the previous refactoring patch.

> 
>>          }
