Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD3978BE3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjH2GGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjH2GFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:05:40 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B211123;
        Mon, 28 Aug 2023 23:05:38 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T3rpOJ016232;
        Tue, 29 Aug 2023 06:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=U8pplH7h/uric7UyNlrI5s/aM+rEmReVzKWvR4nxuCg=;
 b=I19Ohw9UNot9j5/p92pJsXRh9DlKYk0c05+ayWt9OcEqzKdvtFRJa+v2EEqlqVbbkqJk
 q4yL/83MJFhc4MtVDT5cLZPimNr4MznMMerRh8fHx3dDK0kYowoZirbd2o45jaLxoCD3
 VctUM9qWksah1ztRQg4Lgl5ScFX39rYalky9CL3zFi4YMhwkpW4U2Lu203XO51ZDYQge
 wmgZG/OhykEbWfS0X2wUm/vrMefbbQoWxM4F925L05UxjbN00LyEXJBspl8xnMVz24Cb
 QXMk5Mg+JLA3M5EnADP643m6TYvq6NECA/9/tD533CWRGtLPPWWt/BCGRNThpW9gMUXr FA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sruhnsrax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:05:34 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T65X9X018369
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 06:05:33 GMT
Received: from [10.216.63.45] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 28 Aug
 2023 23:05:28 -0700
Message-ID: <87991b5f-0b29-872c-95a2-ade1160ebaf4@quicinc.com>
Date:   Tue, 29 Aug 2023 11:35:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq5018: Add thermal zones
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <srinivas.kandagatla@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <thara.gopinath@gmail.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <1693250307-8910-1-git-send-email-quic_srichara@quicinc.com>
 <1693250307-8910-8-git-send-email-quic_srichara@quicinc.com>
 <867ec3f0-1a43-8d1f-1475-363fc660ab60@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <867ec3f0-1a43-8d1f-1475-363fc660ab60@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CZykfbb_Io7yDtycwpFLXSRoGktP9e2L
X-Proofpoint-ORIG-GUID: CZykfbb_Io7yDtycwpFLXSRoGktP9e2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_03,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=742 suspectscore=0 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290051
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/29/2023 1:04 AM, Krzysztof Kozlowski wrote:
> On 28/08/2023 21:18, Sricharan Ramabadhran wrote:
>> IPQ5018 has 4 thermal sensors (zones). With the
>> critical temperature being 120'C and action is to reboot.
>> Adding all the 4 zones here.
>>
> 
> Not much benefit of having it separate patch... You added the
> thermal-sensor for this purpose.

  ok, will squash.

Regards,
  Sricharan
