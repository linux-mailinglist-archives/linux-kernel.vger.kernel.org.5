Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D1E76C812
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjHBILD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjHBILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:11:00 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE819A;
        Wed,  2 Aug 2023 01:10:58 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37262OjY020135;
        Wed, 2 Aug 2023 08:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=smCHiQUBPz96P0liCJANi4we28VIWNrJWsESBimGYGw=;
 b=WGZIvsp1fJAsdErDN61DSBB+Ah63jjJHnTuXCFtPy2LEcz6U4cJUq141CkH5YaPZQNAE
 hPlkyX/NHNkAbyhc+voUHfisRbakCbb+fq+GpxAemLYMdfigsjcQU/yKJccRAqBdpXrU
 6yKJVuf2gal16o+FpxYWpBCd6szlzU3TWq400oZ/AlsoY5SMh1WBBGWD4gSUUIjGNIFa
 C2dOrCvE/WFfjWj9QOtZtXxcNdqUpJYxGm45k2StK6i8q93vPKHcry6rmitMUsXB2vfZ
 66UPsB0ZXXRpVH/YCbeg/hrZ/UfxuxGXrBfA6Cn79snKo2UMylmbFSiA4Z3Piy4U3cFI Pw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s72gqt7ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 08:10:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3728AqII004396
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 08:10:52 GMT
Received: from [10.216.21.225] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 01:10:46 -0700
Message-ID: <1ea8fdc9-4e0c-19ff-f340-f746d0fed1fe@quicinc.com>
Date:   Wed, 2 Aug 2023 13:40:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH V4 4/7] clk: qcom: gcc-qdu1000: Update GCC clocks as per
 the latest hw version
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Melody Olvera <quic_molvera@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230719041450.737929-1-quic_imrashai@quicinc.com>
 <20230719041450.737929-5-quic_imrashai@quicinc.com>
 <b3175a93-0b41-49d7-ca29-bc4ca9b5c8fc@linaro.org>
Content-Language: en-US
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <b3175a93-0b41-49d7-ca29-bc4ca9b5c8fc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WQGxo1FUvojrNRLOz21Ew7SbSaOTB5f9
X-Proofpoint-ORIG-GUID: WQGxo1FUvojrNRLOz21Ew7SbSaOTB5f9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_03,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=732 adultscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020072
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 9:12 PM, Konrad Dybcio wrote:
> On 19.07.2023 06:14, Imran Shaik wrote:
>> Update the GCC clocks as per the latest hw version of QDU1000 and
>> QRU100 SoCs.
>>
>> Co-developed-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
> [...]
> 
>> +	[GCC_GPLL1_OUT_EVEN] = &gcc_gpll1_out_even.clkr,
> So, this clock was there before, but it was never registered with the
> clock framework, even though it was referenced as a parent..
> 
> Sounds like a bug!
> > Konrad

Yes, I will split this change adding the fixes tag and push another series.

Thanks,
Imran
