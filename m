Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4DB779700
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjHKSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjHKSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:20:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDCD30DD;
        Fri, 11 Aug 2023 11:20:22 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BFx0Li021196;
        Fri, 11 Aug 2023 18:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=G88JxBfrH9UeGJz3GgsTjJbBlyq4bjs4lzmCWIywtkI=;
 b=E5i7uGRTblonN4p2x4kzyUc8ydxXu4JLXdwiXpd/a9g30giL9BUibctXuJadPZ+fraff
 KNvhMenQNPsrp9ukrAKc+t6y476azmUc7U4U4rbw1SMIUVqXaJTZ2pxtwvnRNKZ6lEHF
 G8iTXFPCS8G9Qewy+uLLvz81CeAkHyYDAUvnZ6GnfDZoA8Ia5Oz6vUvIb+zi3ywVvRef
 wGJfY482+ag1tkNhOHwXOqMWNU7gJAMFEo+a7DJAYVUp9yPIat+YnNBjZoOlckJdP/f/
 7Z5vssCMzRBKlLmPK2LODrQ9PR7pZ1pAmnTihDWngmSVNA00egqr+Aak5OAPL9Go+GZg UQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sd8yaag2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 18:19:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37BIJJ8w020916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 18:19:19 GMT
Received: from hu-mdtipton-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 11 Aug 2023 11:19:18 -0700
Date:   Fri, 11 Aug 2023 11:19:17 -0700
From:   Mike Tipton <quic_mdtipton@quicinc.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Richard Acayan <mailingradian@gmail.com>,
        David Dai <daidavid1@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luca Weiss" <luca.weiss@fairphone.com>,
        Sibi Sankar <sibis@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vinod Koul <vkoul@kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/11] interconnect: qcom: qdu1000: Set ACV enable_mask
Message-ID: <20230811181917.GA1864@hu-mdtipton-lv.qualcomm.com>
References: <20230811-topic-acv-v1-0-a85b6e94f46d@linaro.org>
 <20230811-topic-acv-v1-1-a85b6e94f46d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230811-topic-acv-v1-1-a85b6e94f46d@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p-6f0PzDCKkL0p3TyFlTZoMWpBsXCUrC
X-Proofpoint-ORIG-GUID: p-6f0PzDCKkL0p3TyFlTZoMWpBsXCUrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110168
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 03:04:08PM +0200, Konrad Dybcio wrote:
> ACV expects an enable_mask corresponding to the APPS RSC, fill it in.
> 
> Fixes: 1f51339f7dd0 ("interconnect: qcom: Add QDU1000/QRU1000 interconnect driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/bcm-voter.h | 2 ++
>  drivers/interconnect/qcom/qdu1000.c   | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/bcm-voter.h b/drivers/interconnect/qcom/bcm-voter.h
> index b4d36e349f3c..da92267877f9 100644
> --- a/drivers/interconnect/qcom/bcm-voter.h
> +++ b/drivers/interconnect/qcom/bcm-voter.h
> @@ -16,4 +16,6 @@ struct bcm_voter *of_bcm_voter_get(struct device *dev, const char *name);
>  void qcom_icc_bcm_voter_add(struct bcm_voter *voter, struct qcom_icc_bcm *bcm);
>  int qcom_icc_bcm_voter_commit(struct bcm_voter *voter);
>  
> +#define ACV_RSC_APPS		BIT(3)

This isn't entirely common to all chips. It's been BIT(3) for most of
history and is for all the chips in the series. But there upcoming chips
where it'll be different. There are only a finite number of ACV bits
available, so depending on the requirements they can be repurposed. We
should probably just have the raw mask defined in the target files.

> + #endif diff --git a/drivers/interconnect/qcom/qdu1000.c
> b/drivers/interconnect/qcom/qdu1000.c index bf800dd7d4ba..c504bf348294
> 100644 --- a/drivers/interconnect/qcom/qdu1000.c
> +++ b/drivers/interconnect/qcom/qdu1000.c
> @@ -769,6 +769,7 @@ static struct qcom_icc_node xs_sys_tcu_cfg = {
>  
>  static struct qcom_icc_bcm bcm_acv = {
>  	.name = "ACV",
> +	.enable_mask = ACV_RSC_APPS,
>  	.num_nodes = 1,
>  	.nodes = { &ebi },
>  };
> 
> -- 
> 2.41.0
> 
