Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54A579A2DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjIKFeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjIKFeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:34:06 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F32FBB;
        Sun, 10 Sep 2023 22:34:02 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5D2KX014545;
        Mon, 11 Sep 2023 05:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=qGVtQH9i1/p1l5lwNmxDZizEaJk5h6AWrJfE+j6DzYM=;
 b=WiiuVPN2bZKep1Juy0l6eZNgnNMYnffZJ/SIC7OfL+46lnf/iS4XPc08qtPIshseyX/t
 r21sh3xQDhDXQg3YWA1K1ruxYTbSmcDuFcoaMerRfYvuH9vyO/7d73t7C37a/Z0X83Be
 0uN1b/zEGy0VvM9ZEdQ46snn0jtGEd1OEWLS7csqsSa2sAJhqBCrhsQTNwdnqP+QbT+x
 VxsGvqnxYQKgVgO91CtOER3fvPdjCfdbrnOvKidYOVfbKLviPD6bFvbkUcJ4sIv0YlmX
 kMzyxGd7oWWQhwX0X2OpZaCRbmeDs5YfFTb6laNCzCHEdcOU10IFZnhXYjkFfLAUDDw9 iw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t1u3yr54e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:33:35 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38B5XYXF007753
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:33:34 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 10 Sep 2023 22:33:23 -0700
Date:   Mon, 11 Sep 2023 11:03:19 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
CC:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
Subject: Re: [PATCH v5 09/17] pstore/ram: Use dynamic ramoops reserve resource
Message-ID: <20425ace-3ef5-4eaf-8319-999bafa34a07@quicinc.com>
References: <1694290578-17733-1-git-send-email-quic_mojha@quicinc.com>
 <1694290578-17733-10-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1694290578-17733-10-git-send-email-quic_mojha@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ovr4UUYPh7dBKNqwdThbcwPFW3JLBLqC
X-Proofpoint-ORIG-GUID: ovr4UUYPh7dBKNqwdThbcwPFW3JLBLqC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=938 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110050
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 10, 2023 at 01:46:10AM +0530, Mukesh Ojha wrote:
> As dynamic ramoops command line parsing is now added, so
> lets add the support in ramoops driver to get the resource
> structure and add it during platform device registration.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  fs/pstore/ram.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Documentation/admin-guide/ramoops.rst might need an update as well.

> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index 2f625e1fa8d8..e73fbbc1b5b5 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -913,13 +913,17 @@ static void __init ramoops_register_dummy(void)
>  
>  	/*
>  	 * Prepare a dummy platform data structure to carry the module
> -	 * parameters. If mem_size isn't set, then there are no module
> -	 * parameters, and we can skip this.
> +	 * parameters. If mem_size isn't set, check for dynamic ramoops
> +	 * size and extract the information if it is set.
>  	 */
> -	if (!mem_size)
> +	if (!mem_size && !dyn_ramoops_res.end)
>  		return;
>  
>  	pr_info("using module parameters\n");
> +	if (dyn_ramoops_res.end) {
> +		mem_size = resource_size(&dyn_ramoops_res);
> +		mem_address = dyn_ramoops_res.start;
> +	}
>  
>  	memset(&pdata, 0, sizeof(pdata));
>  	pdata.mem_size = mem_size;

You might want to add "arch_" prefix to dyn_ramoops resource so that it
would be clear that it is coming from arch code. This code needs to
guard against arch not supplying this.

Thanks,
Pavan
