Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BEB7DDF9C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjKAKmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAKmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:42:17 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03131DA;
        Wed,  1 Nov 2023 03:42:11 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A19q9Wc002170;
        Wed, 1 Nov 2023 10:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=65c6N/yDEDRfl0w8ERqHsLfi6r9a6fgcu2hrt5OYK40=;
 b=pYRVJR7EmMdLRUk5v4JEoU2IW9DY5H+BZWNAoUfzb7ca1B8lk0Pjf7PXde4kdtQWG2v3
 V9kCGBQd/UBDXM20Dz0EGKwtINk0y7g25R+W/byAnKCCMEGUB+xTlPCKcw5bneUPYKAt
 YSgnlCVq8pdXTO5k22LZL6cyprF80gcPrmCu/aukNMNM24JW6+Tpxq7nrSxS7vh1ziWx
 dk1ayqUgC8SDbmRS2jObcIv4u6uNc+Iwh+9FXDmIZyXAt+M0d+EWCy5LrvrSFMCMG7C5
 SxbzMNHirc/PaLicTtNqQwZV2Aqm6RTyHVooxqlEf0kvIDY6yuoI1+Xq+wAgoXTZbWvA Ug== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u30xebssn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 10:42:06 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A1Ag5vV010833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Nov 2023 10:42:05 GMT
Received: from [10.214.225.95] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 1 Nov
 2023 03:42:02 -0700
Message-ID: <70e6cc10-4300-e9c2-daea-ae5b09923d30@quicinc.com>
Date:   Wed, 1 Nov 2023 16:11:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] firmware: qcom_scm: Clear download bit during reboot
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1678979666-551-1-git-send-email-quic_mojha@quicinc.com>
 <76943268-3982-deaf-9736-429dd51e01b0@gmail.com>
 <0e645486-f0be-4468-18ad-9e49088dee0b@quicinc.com>
 <CAOX2RU4xPNq4-OHUoMZtfZu05QEdpk1UtawZb1xQMrtc5ao84Q@mail.gmail.com>
 <a6c48095-179a-7e72-a282-fbc28af374cb@quicinc.com>
 <CAOX2RU6S-x-KrQ-qQLW-qxu4bph79d+Yq9Vj=PQwWW4o-yG2xA@mail.gmail.com>
 <CAOX2RU6rv0jcnTRAa=kiWHPk1A=DW=smS72df_t+tufOZ9XGfA@mail.gmail.com>
 <cd2c808c-bcb8-85fe-2c56-7accd4853160@quicinc.com>
 <CAOX2RU50+iR0jfyQqzRoTLn0Jydd_c+Ue88rDdhL6PbOKPDMVA@mail.gmail.com>
 <00b49050-5b9b-c16d-bd8f-8604ea993a26@quicinc.com>
 <CAOX2RU6EtRVmezcHhvTJF6Kc69_9dvzUHeoXQ1F1=ctnqhkmrw@mail.gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <CAOX2RU6EtRVmezcHhvTJF6Kc69_9dvzUHeoXQ1F1=ctnqhkmrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: D4Wkue2zrdhTkzH_5dg_I4Wjn_C4x8Cx
X-Proofpoint-ORIG-GUID: D4Wkue2zrdhTkzH_5dg_I4Wjn_C4x8Cx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_07,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 mlxscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010089
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+@Sricharan

On 11/1/2023 3:21 PM, Robert Marko wrote:
> On Thu, 26 Oct 2023 at 17:16, Mukesh Ojha <quic_mojha@quicinc.com> wrote:
>>
>> Hey Robert,
>>
>> Just remembered this thread again,
>>
>> is this issue got fixed with
>>
>> https://lore.kernel.org/lkml/20230816164641.3371878-1-robimarko@gmail.com/
> 
> Sadly no, as this issue is affecting all IPQ4019 boards and not just
> the ones that have SDI enabled.

unless, enabling CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT has problem in 
your SoC, i don't think why current patch can cause issue in your
board.

Can you please help with some debug as i don't have this target but
interested in fixing this issue if it is indeed due to kernel.

whether, CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT works on your target 
basically if qcom_scm_set_download_mode(true); return success and
reboot works with that.

Or may be only writing qcom_scm_set_download_mode(false); has some
unknown affect in the firmware and later causing a problem in reboot.


-Mukesh
