Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE5178A1D0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 23:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjH0V1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 17:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjH0V07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 17:26:59 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD52EB;
        Sun, 27 Aug 2023 14:26:57 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37RLMqnK029582;
        Sun, 27 Aug 2023 21:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vtUbiwv+rQk5LNZDpZ3ag1UdVFuCpZM5Zp0LLUtoAKA=;
 b=Jtriqobv3xiJBD2zyu/JP+L4xq3Mnmyd7SStC7/3ylyndTNfPzuruy7Uf6pEA/o3tr5H
 oTQw1p0MwGoLQAoQSIhIg7O5iaekyKuSecRT5uGLLYO3kOWeG9yHzlAG1QsZFBbSaWqI
 wEilfHg9UvG1L53gt2AJ/z5tRBbXO2pGyCrObVOdj/zAbZcFcvmZzx2bShsONyYotFb+
 0sdnpm/6Abvgy3/+etvABpV0Jjh1wuXUYwa+rehSJizOXcWuCCUoh6Ral+gXB4EsZiX6
 6zxlpGig2AaPitDuYKKZETG9Hfg5GMe37qj7JMcvkCPaWNPiOh+VazRRoJcaHAweyvxh Zg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sqapfj68y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 21:26:36 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37RLQZAL006083
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 27 Aug 2023 21:26:35 GMT
Received: from [10.110.11.89] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 27 Aug
 2023 14:26:34 -0700
Message-ID: <0d7697fd-11b3-1d4a-78da-7e5eb293d186@quicinc.com>
Date:   Sun, 27 Aug 2023 14:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 3/3] firmware: Add support for Qualcomm UEFI Secure
 Application
Content-Language: en-US
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Johan Hovold <johan@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
References: <20230827211408.689076-1-luzmaximilian@gmail.com>
 <20230827211408.689076-4-luzmaximilian@gmail.com>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <20230827211408.689076-4-luzmaximilian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qrO8u05cilapbf4kZF0uXmt1BHCeQA01
X-Proofpoint-GUID: qrO8u05cilapbf4kZF0uXmt1BHCeQA01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-27_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=723 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308270203
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/2023 2:14 PM, Maximilian Luz wrote:
>  
> +config QCOM_QSEECOM_UEFISECAPP
> +	bool "Qualcomm SEE UEFI Secure App client driver"

Why not "tristate"? This driver can be a loadable module, right?

> +	depends on QCOM_QSEECOM
> +	depends on EFI
> +	help


-- 
---Trilok Soni

