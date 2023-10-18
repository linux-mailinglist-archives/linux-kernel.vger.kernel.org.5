Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A285C7CD9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjJRK6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjJRK5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:57:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9540A10C7;
        Wed, 18 Oct 2023 03:57:42 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I6q9US016294;
        Wed, 18 Oct 2023 10:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tOxH8S0OAocwIY1sycmnBORYAkjAKoNWL/pOqTnuBCo=;
 b=PW+NbAJYP4YmG71l3WspbwvTHQTG3ayH3imkpZ/KOifjC4kUDCIgJReHqExLpwo+1AjP
 fqYWntXS9oLRJhxlKP3Md0xtXFQWupulE6PeOtk+SEJ/4j1769s3kg6KckQtuy3H7yTz
 1PLZ9BWc6ZE9Bicp1vRNId1At1VeqVdynNwt+PJJIIXXrJHKALH6KA8UEqiez7/Oz+dd
 kporx/BsAR4H7Ph0fZ2WYOMLk3mNJnpJGzbjUSWyz9az9YK6OH7N7857CUlBaJAimM6F
 D1AyRR5TmMOdI6HhW208tewCU5SMBKNPtwEXT2ZbvPthgyRWhFuGHlsOdZjZR1dm8ubv +Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt8xs8qcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:39 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IAvcTc003353
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 10:57:38 GMT
Received: from [10.216.39.143] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 03:57:33 -0700
Message-ID: <158cc179-3bdf-a882-942c-c9dae55bded2@quicinc.com>
Date:   Wed, 18 Oct 2023 16:27:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 3/4] clk: qcom: Add ECPRICC driver support for QDU1000
 and QRU1000
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ajit Pandey <quic_ajipan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
References: <20231011090028.1706653-1-quic_imrashai@quicinc.com>
 <20231011090028.1706653-4-quic_imrashai@quicinc.com>
 <3c7115dc-f9b4-42ab-8923-098d96b75e86@linaro.org>
From:   Imran Shaik <quic_imrashai@quicinc.com>
In-Reply-To: <3c7115dc-f9b4-42ab-8923-098d96b75e86@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jhEJJxFyXQCiopQHWc317aMcA99V04k6
X-Proofpoint-ORIG-GUID: jhEJJxFyXQCiopQHWc317aMcA99V04k6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_09,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=787 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310180090
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2023 4:00 PM, Konrad Dybcio wrote:
> 
> 
> On 10/11/23 11:00, Imran Shaik wrote:
>> Add ECPRI Clock Controller (ECPRICC) support for QDU1000 and QRU1000 
>> SoCs.
>>
>> Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
>> ---
> [...]
> 
>> +static int __init ecpri_cc_qdu1000_init(void)
>> +{
>> +    return platform_driver_register(&ecpri_cc_qdu1000_driver);
>> +}
>> +subsys_initcall(ecpri_cc_qdu1000_init);
> module_platform_driver?
> 
> Konrad

Sure, will check and update.

Thanks,
Imran
