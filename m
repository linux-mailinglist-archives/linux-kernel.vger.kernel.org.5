Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251CC7EE015
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjKPLqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:46:34 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B537B0;
        Thu, 16 Nov 2023 03:46:31 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGBg9kM018730;
        Thu, 16 Nov 2023 11:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LdxD296FT6Gvt/TpfuJhIwbLudXw79+Wb1W39adnXMs=;
 b=ST724KIs3nVl2IPILTZLdo8ul1G0crRkhK7JZWJiob0h6YKf4vr/oo9Jcy5vGNAzq1d5
 PFJxF7QnCvTOLecGVzEJj4ef7bF+i5Si/gwFRg1IyO7uPhG+AJCwK9OEuCTZ0m9/33Kd
 7NFyNsCM/SeGIw1y2mbZ3bMVcxsxM7+vSZ0alunpIwDtwc4XzNh+aVtaxIEX5/rxKDlk
 hEB6N9D0vpu+VgvjJE1m22fJ+7Fxvq4fR2CROw5/BpepHOVFDkYjHGRiuLdenRj1zbS4
 R1TmHVKUFqvpqG3F2EsuzuQ/blYzYrCaM2YUo0+ycuOXUgvLTFVGtUzoIgVgtQ5q1AUv hA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udg6f09u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 11:46:11 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGBjgZ9026289
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 11:45:42 GMT
Received: from [10.216.58.70] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 03:45:32 -0800
Message-ID: <5ff90cc0-cb1d-4a5d-bf0d-fdff68cb4366@quicinc.com>
Date:   Thu, 16 Nov 2023 17:15:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: defconfig: Enable GCC for SDX75
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <konrad.dybcio@linaro.org>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <m.szyprowski@samsung.com>,
        <u-kumar1@ti.com>, <peng.fan@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>
References: <20231116093513.14259-1-quic_rohiagar@quicinc.com>
 <20231116093513.14259-2-quic_rohiagar@quicinc.com>
 <4b8b486a-3bce-4b1d-b844-7d2dc499db0f@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <4b8b486a-3bce-4b1d-b844-7d2dc499db0f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y5bDWwBgCfEzCMMRI4vE-qXK1YDDl3Rd
X-Proofpoint-GUID: y5bDWwBgCfEzCMMRI4vE-qXK1YDDl3Rd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 phishscore=0 mlxscore=0 mlxlogscore=288 priorityscore=1501 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311160094
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/2023 4:46 PM, Krzysztof Kozlowski wrote:
> On 16/11/2023 10:35, Rohit Agarwal wrote:
>> Enable Global Clock controller framework support for
>> Qualcomm's SDX75 SoC which is required to boot to console
>> on sdx75-idp platform.
> No, really, this is just one patch, not three. You do not enable a
> platform with one-by-one config patches.
Ok, Sure. Will combine it into a single patch.

Thanks,
Rohit.
>
> Best regards,
> Krzysztof
>
