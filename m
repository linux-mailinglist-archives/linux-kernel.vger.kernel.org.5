Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF1C7840AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjHVMYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjHVMYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:24:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C421B2;
        Tue, 22 Aug 2023 05:24:06 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37M9Uu5P019649;
        Tue, 22 Aug 2023 11:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=q3CEcAMK1BPwNANS5ZGNItwwcCsuN+Y63PbtS+iHC9s=;
 b=dIwOctzEiMo3HPyNiyMLpdl/lcRvQ5FfuRhCUWKsdkv61ytOL08u/bHNg3md9GIt7lYx
 79bAD9e1sSA+FgekgkaOlMMKmb2ZxA4cFxJ/2Bs52VXJ6oDaQqFNKgTutQ7rj3viUOo8
 NqiX5xRN6hPRP0zPLLuK2bp8Ao97SigPCm2a6FSbfjw73cIs2KxcfS/yrtM5hYAyKzU5
 LKlqLCIBGadkSLNX91eGkspwyUpfUaluSk061kVKzq5gDwRWtuRaOIIVqpHFuZzWG/Ue
 U1OoUt7JaGXSo9FGl0c3fy4NvSeZ7YQbq97xcDUlQO/XzbiR8BgJ2NR/niZkcJIS7+5i rg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3smf3q9fvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:46:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37MBkmZY013267
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Aug 2023 11:46:48 GMT
Received: from [10.216.34.168] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 22 Aug
 2023 04:46:44 -0700
Message-ID: <1136bf59-3ecb-db33-6dd6-eeca7fb8accc@quicinc.com>
Date:   Tue, 22 Aug 2023 17:16:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/4] clk: qcom: Add ECPRICC driver support for QDU1000 and
 QRU1000
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20230808051407.647395-1-quic_imrashai@quicinc.com>
 <20230808051407.647395-4-quic_imrashai@quicinc.com>
 <7d9ac1c6-be2d-4fd6-ba56-3976ec847274@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <7d9ac1c6-be2d-4fd6-ba56-3976ec847274@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eECfzVK_BxfDF8UlXUBdgLpgs1xsL3Un
X-Proofpoint-ORIG-GUID: eECfzVK_BxfDF8UlXUBdgLpgs1xsL3Un
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_10,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 adultscore=0 mlxlogscore=525
 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308220089
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 1:31 AM, Konrad Dybcio wrote:
> On 8.08.2023 07:14, Imran Shaik wrote:
>> Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 SoCs.
>>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
> Please ensure inline hex is lowercase
> 

Sure, will update all the hex values in lowercase and push another series.

> No GDSCs in this clock controller?
> 
> Konrad

There are no GDSCs in this clock controller.

Thanks,
Imran
