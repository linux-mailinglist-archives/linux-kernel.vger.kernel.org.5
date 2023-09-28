Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6DF7B2370
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjI1RLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjI1RLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:11:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EDA1A3;
        Thu, 28 Sep 2023 10:11:09 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SFfKDZ015735;
        Thu, 28 Sep 2023 17:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sm6cNehmgWv8ZfAyHO6st/a82A17AeDo6kCaTc5lR24=;
 b=k3qWCkV0qlXnlH7CyowU6fK6oLUtXXZx2vbvRw+YCsTv9FUzAVCEVmB5A7fOgYzhIHXm
 Rn5supJOB069YBDdr0BW/5psKANwJI6G/ZutSpr6KYe0KvCSYcvGEZNk6b1hvOFMTJTH
 sIvCS3zDDGOFyHqcOFu2pAio3hqAdsVT+9/qG8aWbu1Pwa5PCUe53YA9D6L/dC1bU3tT
 dOzu1UNtrOoIOK0WzOY0mbrELIjixrdBKsTHgB4HHPEPD3oOY8IaE5I3bjBn15+cx+gR
 eboCkkP4qbI7XLU4wHq3PsrMi0xZsl+wKFWqZX09/HWv2XQYh1OGMRBY51fz/wGvnJ04 lg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3td8wdrswd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:10:55 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38SHAsjx014391
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:10:54 GMT
Received: from [10.110.102.158] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 28 Sep
 2023 10:10:51 -0700
Message-ID: <1160e239-b227-411d-8d64-a23fde014dd5@quicinc.com>
Date:   Thu, 28 Sep 2023 10:10:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] firmware: qcom: scm: enable SHM bridge
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230928092040.9420-1-brgl@bgdev.pl>
 <20230928092040.9420-12-brgl@bgdev.pl>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <20230928092040.9420-12-brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zZ4FEoKPw2iW8t8Qxm5b7XcSv3b7Yb47
X-Proofpoint-GUID: zZ4FEoKPw2iW8t8Qxm5b7XcSv3b7Yb47
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_16,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=975 malwarescore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280150
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/2023 2:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Extens the SCM memory allocator with using the SHM Bridge feature if
> available on the platform. This makes the trustzone only use dedicated
> buffers for SCM calls. We map the entire SCM genpool as a bridge.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm-mem.c | 42 ++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm-mem.c b/drivers/firmware/qcom/qcom_scm-mem.c
> index eafecbe23770..12b12b15f46f 100644
> --- a/drivers/firmware/qcom/qcom_scm-mem.c
> +++ b/drivers/firmware/qcom/qcom_scm-mem.c
> @@ -16,6 +16,8 @@
>  
>  #include "qcom_scm.h"
>  
> +#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
> +
>  static size_t qcom_scm_mem_pool_size = SZ_2M;
>  module_param_named(qcom_scm_mem_pool_size, qcom_scm_mem_pool_size,
>  		   ulong, 0400);
> @@ -108,8 +110,24 @@ phys_addr_t qcom_scm_mem_to_phys(void *vaddr)
>  	return chunk->paddr;
>  }
>  
> +static int qcom_scm_mem_shm_bridge_create(void)
> +{
> +	uint64_t pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
> +
> +	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
> +	pfn_and_ns_perm = (u64)qcom_scm_mem.pbase | ns_perms;
> +	ipfn_and_s_perm = (u64)qcom_scm_mem.pbase | ns_perms;
> +	size_and_flags = qcom_scm_mem.size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
> +
> +	return qcom_scm_create_shm_bridge(qcom_scm_mem.dev, pfn_and_ns_perm,
> +					  ipfn_and_s_perm, size_and_flags,
> +					  QCOM_SCM_VMID_HLOS);
> +}
> +
>  int qcom_scm_mem_enable(struct device *dev)
>  {
> +	int ret;
> +
>  	INIT_RADIX_TREE(&qcom_scm_mem.chunks, GFP_ATOMIC);
>  	spin_lock_init(&qcom_scm_mem.lock);
>  	qcom_scm_mem.dev = dev;
> @@ -128,7 +146,25 @@ int qcom_scm_mem_enable(struct device *dev)
>  
>  	gen_pool_set_algo(qcom_scm_mem.pool, gen_pool_best_fit, NULL);
>  
> -	return gen_pool_add_virt(qcom_scm_mem.pool,
> -				 (unsigned long)qcom_scm_mem.vbase,
> -				 qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
> +	ret = gen_pool_add_virt(qcom_scm_mem.pool,
> +				(unsigned long)qcom_scm_mem.vbase,
> +				qcom_scm_mem.pbase, qcom_scm_mem.size, -1);
> +	if (ret)
> +		return ret;
> +
> +	ret = qcom_scm_enable_shm_bridge();
> +	if (ret) {
> +		if (ret == EOPNOTSUPP)
> +			dev_info(dev, "SHM Bridge not supported\n");
> +		else
> +			return ret;
> +	} else {
> +		ret = qcom_scm_mem_shm_bridge_create();
> +		if (ret)
> +			return ret;
> +
> +		dev_info(dev, "SHM Bridge enabled\n");

Do you need to add clean up (deletion) of the SHM bridge on driver remove?

One easy approach I could think: implemnet devm_qcom_scm_mem_shm_bridge_create
which calls qcom_scm_delete_shm_bridge on the clean up 
(qcom_scm_delete_shm_bridge implemented in downstream, not in this series).

> +	}
> +
> +	return 0;
>  }
