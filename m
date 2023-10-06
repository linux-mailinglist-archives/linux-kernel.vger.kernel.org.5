Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D847BBB5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjJFPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjJFPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:10:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28F49F;
        Fri,  6 Oct 2023 08:10:08 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 396DJY15008473;
        Fri, 6 Oct 2023 15:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=116pN689ygt9psamelJSV3WSJBDI4hnmaTYmjbIGKPk=;
 b=bdTG9AugUWu6LZ23FBsbNo/TYE0Bc53Am3b/ITJMrq3duow2m6UG+kCPo0Q0zBjE6lok
 jXNh/0lktZrzyDLQSahmVBPvTOLPUxAIzNJ2Dgqi6ywJbq8eg7ipC766HQS5dqvn8pI9
 TecjD2S/U4jqZlspKF24O7PvjxuxzYL8Xt/56vibIV9nG+IIr29iRtGc06YbRFIJ27JO
 DSi3qnitzCGz/EI6qe/3RlwB895LeEdmhQ1yUk3TgWlDcBN36cBMKTCmzCCSU5gjTbSx
 OvVynM3j6ePsCd4zDrFKH/wUmsAmu2FJmhcvFscbnLz14awDjUBCohkYUHsJkOn3goya yw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tj820sp79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 15:09:30 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 396F9TqR026704
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 15:09:29 GMT
Received: from [10.216.35.212] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 6 Oct
 2023 08:08:56 -0700
Message-ID: <bb29aba3-9378-6405-5f6d-a7d77e0374ad@quicinc.com>
Date:   Fri, 6 Oct 2023 20:38:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [REBASE PATCH v5 04/17] remoteproc: qcom: Remove minidump related
 data from qcom_common.c
Content-Language: en-US
To:     <corbet@lwn.net>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linus.walleij@linaro.org>, <andy.shevchenko@gmail.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <matthias.bgg@gmail.com>,
        <kgene@kernel.org>, <alim.akhtar@samsung.com>,
        <bmasney@redhat.com>, <quic_tsoni@quicinc.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <kernel@quicinc.com>
References: <1694429639-21484-1-git-send-email-quic_mojha@quicinc.com>
 <1694429639-21484-5-git-send-email-quic_mojha@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1694429639-21484-5-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TY-OAbVjGnyZJBDRL_fedObtLqGklWvb
X-Proofpoint-GUID: TY-OAbVjGnyZJBDRL_fedObtLqGklWvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060113
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn/Mathieu,

Patches from 2/17-4/17  is just a movement of functions to separate 
config/file.

Do you think, these can be picked independently from this series ?
I can send them separately, if required.

@Bjorn: I have sent 13/17-15/17 separately [1] as it is needed
by some folks and independent from this series.

[1]
https://lore.kernel.org/all/1696440338-12561-1-git-send-email-quic_mojha@quicinc.com/

-Mukesh

On 9/11/2023 4:23 PM, Mukesh Ojha wrote:
> As minidump specific data structure and functions move under
> config QCOM_RPROC_MINIDUMP, so remove minidump specific data
> from driver/remoteproc/qcom_common.c .
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/remoteproc/qcom_common.c | 160 ---------------------------------------
>   1 file changed, 160 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 03e5f5d533eb..085fd73fa23a 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -17,7 +17,6 @@
>   #include <linux/rpmsg/qcom_smd.h>
>   #include <linux/slab.h>
>   #include <linux/soc/qcom/mdt_loader.h>
> -#include <linux/soc/qcom/smem.h>
>   
>   #include "remoteproc_internal.h"
>   #include "qcom_common.h"
> @@ -26,61 +25,6 @@
>   #define to_smd_subdev(d) container_of(d, struct qcom_rproc_subdev, subdev)
>   #define to_ssr_subdev(d) container_of(d, struct qcom_rproc_ssr, subdev)
>   
> -#define MAX_NUM_OF_SS           10
> -#define MAX_REGION_NAME_LENGTH  16
> -#define SBL_MINIDUMP_SMEM_ID	602
> -#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> -#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> -#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> -
> -/**
> - * struct minidump_region - Minidump region
> - * @name		: Name of the region to be dumped
> - * @seq_num:		: Use to differentiate regions with same name.
> - * @valid		: This entry to be dumped (if set to 1)
> - * @address		: Physical address of region to be dumped
> - * @size		: Size of the region
> - */
> -struct minidump_region {
> -	char	name[MAX_REGION_NAME_LENGTH];
> -	__le32	seq_num;
> -	__le32	valid;
> -	__le64	address;
> -	__le64	size;
> -};
> -
> -/**
> - * struct minidump_subsystem - Subsystem's SMEM Table of content
> - * @status : Subsystem toc init status
> - * @enabled : if set to 1, this region would be copied during coredump
> - * @encryption_status: Encryption status for this subsystem
> - * @encryption_required : Decides to encrypt the subsystem regions or not
> - * @region_count : Number of regions added in this subsystem toc
> - * @regions_baseptr : regions base pointer of the subsystem
> - */
> -struct minidump_subsystem {
> -	__le32	status;
> -	__le32	enabled;
> -	__le32	encryption_status;
> -	__le32	encryption_required;
> -	__le32	region_count;
> -	__le64	regions_baseptr;
> -};
> -
> -/**
> - * struct minidump_global_toc - Global Table of Content
> - * @status : Global Minidump init status
> - * @md_revision : Minidump revision
> - * @enabled : Minidump enable status
> - * @subsystems : Array of subsystems toc
> - */
> -struct minidump_global_toc {
> -	__le32				status;
> -	__le32				md_revision;
> -	__le32				enabled;
> -	struct minidump_subsystem	subsystems[MAX_NUM_OF_SS];
> -};
> -
>   struct qcom_ssr_subsystem {
>   	const char *name;
>   	struct srcu_notifier_head notifier_list;
> @@ -90,110 +34,6 @@ struct qcom_ssr_subsystem {
>   static LIST_HEAD(qcom_ssr_subsystem_list);
>   static DEFINE_MUTEX(qcom_ssr_subsys_lock);
>   
> -static void qcom_minidump_cleanup(struct rproc *rproc)
> -{
> -	struct rproc_dump_segment *entry, *tmp;
> -
> -	list_for_each_entry_safe(entry, tmp, &rproc->dump_segments, node) {
> -		list_del(&entry->node);
> -		kfree(entry->priv);
> -		kfree(entry);
> -	}
> -}
> -
> -static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
> -			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
> -				void *dest, size_t offset, size_t size))
> -{
> -	struct minidump_region __iomem *ptr;
> -	struct minidump_region region;
> -	int seg_cnt, i;
> -	dma_addr_t da;
> -	size_t size;
> -	char *name;
> -
> -	if (WARN_ON(!list_empty(&rproc->dump_segments))) {
> -		dev_err(&rproc->dev, "dump segment list already populated\n");
> -		return -EUCLEAN;
> -	}
> -
> -	seg_cnt = le32_to_cpu(subsystem->region_count);
> -	ptr = ioremap((unsigned long)le64_to_cpu(subsystem->regions_baseptr),
> -		      seg_cnt * sizeof(struct minidump_region));
> -	if (!ptr)
> -		return -EFAULT;
> -
> -	for (i = 0; i < seg_cnt; i++) {
> -		memcpy_fromio(&region, ptr + i, sizeof(region));
> -		if (le32_to_cpu(region.valid) == MINIDUMP_REGION_VALID) {
> -			name = kstrndup(region.name, MAX_REGION_NAME_LENGTH - 1, GFP_KERNEL);
> -			if (!name) {
> -				iounmap(ptr);
> -				return -ENOMEM;
> -			}
> -			da = le64_to_cpu(region.address);
> -			size = le64_to_cpu(region.size);
> -			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
> -		}
> -	}
> -
> -	iounmap(ptr);
> -	return 0;
> -}
> -
> -void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
> -		void (*rproc_dumpfn_t)(struct rproc *rproc,
> -		struct rproc_dump_segment *segment, void *dest, size_t offset,
> -		size_t size))
> -{
> -	int ret;
> -	struct minidump_subsystem *subsystem;
> -	struct minidump_global_toc *toc;
> -
> -	/* Get Global minidump ToC*/
> -	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
> -
> -	/* check if global table pointer exists and init is set */
> -	if (IS_ERR(toc) || !toc->status) {
> -		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
> -		return;
> -	}
> -
> -	/* Get subsystem table of contents using the minidump id */
> -	subsystem = &toc->subsystems[minidump_id];
> -
> -	/**
> -	 * Collect minidump if SS ToC is valid and segment table
> -	 * is initialized in memory and encryption status is set.
> -	 */
> -	if (subsystem->regions_baseptr == 0 ||
> -	    le32_to_cpu(subsystem->status) != 1 ||
> -	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED) {
> -		return rproc_coredump(rproc);
> -	}
> -
> -	if (le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
> -		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
> -		return;
> -	}
> -
> -	/**
> -	 * Clear out the dump segments populated by parse_fw before
> -	 * re-populating them with minidump segments.
> -	 */
> -	rproc_coredump_cleanup(rproc);
> -
> -	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
> -	if (ret) {
> -		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
> -		goto clean_minidump;
> -	}
> -	rproc_coredump_using_sections(rproc);
> -clean_minidump:
> -	qcom_minidump_cleanup(rproc);
> -}
> -EXPORT_SYMBOL_GPL(qcom_minidump);
> -
>   static int glink_subdev_start(struct rproc_subdev *subdev)
>   {
>   	struct qcom_rproc_glink *glink = to_glink_subdev(subdev);
