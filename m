Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39BC766157
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjG1Beh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjG1Bef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:34:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CD63588;
        Thu, 27 Jul 2023 18:34:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S11Lrp019421;
        Fri, 28 Jul 2023 01:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OKbGTurfBiahMbgPrT+iL1cvW2HNTtGOngSVMmCGrLo=;
 b=D/L6xf3yM0Ev+VZ5PS2r57VgqijFSItehP5QLUhf92gRTnxGQc8k2q6DtuSWxlmkJ1md
 I7XKDL3fIZc1Jp+dlCVPmAB7QCB0W9bedzlLo+PzXCMDB+pPs/Dya0C45pQ3KI56leb/
 89d5nSbRX4UnN5zd3ry9KGymKTSuR3uSmZOdVIm7xxUP7xaaj2VeMCv4rt3OXjVP8Tfs
 u/IC6TYS0c1r7ayha9TXzbgI0qkSc/HDeoq0mMWrBYCAvxLFrsaRhWlqSuXEAhRuCJK+
 WSm9oD4dCMRRxEX9wgepJGADJC2IPoP1dtZoiTUHqUEjCrPE97pRrm+XgbcYCF15mCr5 Sg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s3n2ka584-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 01:34:27 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36S1YQi5006037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 01:34:26 GMT
Received: from [10.110.109.223] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 27 Jul
 2023 18:34:25 -0700
Message-ID: <4bb1c007-8f7f-1e35-8dc9-d9d9f6663aeb@quicinc.com>
Date:   Thu, 27 Jul 2023 18:34:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] firmware: qcom_scm: Convert all symbols to
 EXPORT_SYMBOL_GPL
Content-Language: en-US
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Elliot Berman" <quic_eberman@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <19d9ac0bf79f957574ef9b3b73246ea0113cc0fd.1690503893.git.quic_gurus@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: N0BpMKkvchVNRmrZ3ZNfB-ssJPeMdxXO
X-Proofpoint-ORIG-GUID: N0BpMKkvchVNRmrZ3ZNfB-ssJPeMdxXO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1011 bulkscore=0 mlxlogscore=817 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280012
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 5:42 PM, Guru Das Srinagesh wrote:
> The `qcom_scm` module is GPL v2-licenced and so there is no reason why
> the APIs it exports should not be, too.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>

LGTM. Thank you.

Reviewed-by: Trilok Soni <quic_tsoni@quicinc.com>

-- 
---Trilok Soni

