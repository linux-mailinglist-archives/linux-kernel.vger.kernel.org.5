Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0EB7A5ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjISH0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjISH0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:26:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D665E10F;
        Tue, 19 Sep 2023 00:26:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38J6TQ5w023980;
        Tue, 19 Sep 2023 07:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B0HAny+iaRcLCu1oD8NtxuUAZPFt49ZZzWn7M51XohI=;
 b=Xxz0cILSK5FxtYX8lrLj7GCCoohnDIYe53lZhDI3hUcUg1fIEuOqJdShMLCG+H2fT+NJ
 NxctU2oIX8FR5yqSsCqEyv4QyQI2TyaoMstos+x3UoMguBuzW1FRm9ZgzK1ANSIfUB2r
 ZbBT5bgzVhJu/9wT+jyiZYeiM3CBUlRcU5wiot8LHgW71DFcWnUzxUoHUZJgKGdMRXI/
 sTc+sGGdqfyrE+sXEaa6AdIL+wF5Fz/kgqgUBeyKO4p2/m1WrstmsFSrKtUb0J+E/j28
 7gRANGyhnfBiEfaw5lnHiXhe9Y+a5yMV3BUZ2QP+Jj4h2NcccnE3Ttc9dx8LeYQNO42K ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t6mv1t7sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:26:29 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38J7QSdm022516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 07:26:28 GMT
Received: from [10.201.203.60] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 19 Sep
 2023 00:26:23 -0700
Message-ID: <46b8a66b-5cb7-2ad1-d633-f393696fb238@quicinc.com>
Date:   Tue, 19 Sep 2023 12:56:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V2 3/4] thermal/drivers/tsens: Add support for IPQ5018
 tsens
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <krzysztof.kozlowski@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thara.gopinath@gmail.com>, <rafael@kernel.org>,
        <daniel.lezcano@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
References: <20230915121504.806672-1-quic_srichara@quicinc.com>
 <20230915121504.806672-4-quic_srichara@quicinc.com>
 <CAA8EJpqJaY3ocZYMxWyDhzoCvCrn6d-YyD=jtumAM7aXe_DEdg@mail.gmail.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <CAA8EJpqJaY3ocZYMxWyDhzoCvCrn6d-YyD=jtumAM7aXe_DEdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NI_GPPdDH_WLwBL7Cb1gus9pi5cTc5RA
X-Proofpoint-ORIG-GUID: NI_GPPdDH_WLwBL7Cb1gus9pi5cTc5RA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_01,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=897 suspectscore=0 mlxscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309190061
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<..>

>> +static int init_ipq5018(struct tsens_priv *priv)
>> +{
>> +       int ret;
>> +       u32 mask;
>> +
>> +       init_common(priv);
> 
> Please take care of init_common()'s return code. Don't continue init
> if init_common() fails.

  ok

> 
>> +       if (!priv->tm_map)
>> +               return -ENODEV;
> 
> Why?
> 
  ok, redundant, will remove.

Regards,
  Sricharan

