Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC5B7925A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjIEQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353663AbjIEHI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:08:59 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A71B4;
        Tue,  5 Sep 2023 00:08:55 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3856wr0S017319;
        Tue, 5 Sep 2023 07:08:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8TT2LhKEX5eaqHthp0Ltat/ICpv1eC9eiSOETIB1TyE=;
 b=jpJY+bvpyNUG7xSVf15Mh34RJWPWWLBXz3kcXpqKghWHpbV5AQDbkYTQHBsLhGK23P+e
 iyfGWBgX6e4B54Elq4eA0WGLwC76V82E5dzTBdIPqz+J2Q3O7iqjcyq8YuKbs9cVAzeO
 eVNbzIqM7Qw+DpUMsV9qk7pY26AQ6LChj+7unPbR+yL3W9HdvYTNJnn+j8Kx4i6M5YAl
 KFky7WdbMsOqP6/S3DkY2J6QYvOk2xXXZCYSRx39iKixyPCF5lcodH3/8eO6I2EDM0cG
 V21Z9jb/Q7887JYZTSYOvt7EE1ClkGRKZFw4lWNb5vRwDWfOOp3TbSpYK3IiTHc7riHI Ug== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvcrcy3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 07:08:44 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38578hZJ015080
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 5 Sep 2023 07:08:43 GMT
Received: from [10.216.59.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 5 Sep
 2023 00:08:34 -0700
Message-ID: <00bf888f-1501-70d6-eaf0-2592a36d1114@quicinc.com>
Date:   Tue, 5 Sep 2023 12:38:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add qcom,sdx75-qmp-usb3-uni schema
 file
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <abel.vesa@linaro.org>,
        <quic_wcheng@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <kernel@quicinc.com>
References: <1693889028-6485-1-git-send-email-quic_rohiagar@quicinc.com>
 <1693889028-6485-3-git-send-email-quic_rohiagar@quicinc.com>
 <0a2fcbc0-4b18-a54c-9f91-9710cc0bea1c@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <0a2fcbc0-4b18-a54c-9f91-9710cc0bea1c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WJi2L6tr0Y3vYh4-3fbhkkACVpKhUOVe
X-Proofpoint-ORIG-GUID: WJi2L6tr0Y3vYh4-3fbhkkACVpKhUOVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=643 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050063
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2023 12:19 PM, Krzysztof Kozlowski wrote:
> On 05/09/2023 06:43, Rohit Agarwal wrote:
>> Add a dt-binding schema for SDX75 SoC.
>>
> It's the same as qcom,ipq9574-qmp-usb3-phy.
Seems like this change is not in the tree. Will rebase my change on top 
of it and mention the dependency.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
