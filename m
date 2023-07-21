Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD2A75BDA6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 07:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGUFNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 01:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGUFNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 01:13:46 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E263CB4;
        Thu, 20 Jul 2023 22:13:44 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36L4bBvI006336;
        Fri, 21 Jul 2023 05:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KYLJP5AG2VApLjYrHCbXG/wciGhoNgiTStD7XpR2XMk=;
 b=N+WOJPggPbcv1wuzNr2iKIZoZRHcsjGpjQPWQnPaKRRlihTiDuc4PcAxY1z93YFRqJS4
 R3Hf2Yk7Eobc23228ie4nJobzipPV/sxNx3phFsHbc4vdf8RBp131Hpjn7byw98ae+85
 8EesYFDX/9CbJuqFxnBf67W6v0ExSnOtTWVhaeOvQQHLAjlzQUq2lZhdzVfYq9zZxWEk
 iHolIlAtES6II05ixvpNjCDbjDUBuHM7HDll9F4cetW2M6PuOUHVxiFnkwy+gEA1INXk
 K8T8ttxWm/2I9RWE/6wfDvQRMShUn3Gvub4FNGDVXVKNIVxExllpdxUpebCPHh2cuXFm Tw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ryfyf0cde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:13:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36L5DcTu006302
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 05:13:38 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 22:13:37 -0700
Message-ID: <c8002897-c642-fcde-a7e1-da2959d40abe@quicinc.com>
Date:   Thu, 20 Jul 2023 23:13:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] mhi: host: Add tme supported image download functionality
Content-Language: en-US
To:     Qiang Yu <quic_qianyu@quicinc.com>, <mani@kernel.org>
CC:     <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1689907189-21844-1-git-send-email-quic_qianyu@quicinc.com>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <1689907189-21844-1-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WMd-kBRu7JrKhQIwYE-hSF0LZ0mswLoh
X-Proofpoint-ORIG-GUID: WMd-kBRu7JrKhQIwYE-hSF0LZ0mswLoh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_01,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210047
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/2023 8:39 PM, Qiang Yu wrote:
> Add tme supported image related flag which makes decision in terms of how
> FBC image based AMSS image is being downloaded with connected endpoint.
> FBC image is having 2 image combine: SBL image + AMSS image.
> 1. FBC image download using legacy image format:
> - SBL image: 512KB of FBC image is downloaded using BHI.
> - AMSS image: full FBC image is downloaded using BHIe.
> 2. FBC image download using TME supported image format:
> - SBL image: 512 KB of FBC image is downloaded using BHI.
> - AMSS image: 512 KB onward FBC image is downloaded using BHIe.
> There is no change for SBL image download. Although AMSS image start
> address is end address of SBL image while using TME supported image format.

I know what TME is, but in the context of this patch, it doesn't seem 
like relevant information.  "tme" is just a name for this mode, but it 
is not very descriptive.  Also, I suspect that this mode is not 
intrinsically related to the TME hardware on the endpoint, it just 
happens to be used on targets where TME is present.

Is there something else we can call this?

> 
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

This doesn't make sense.  This patch is from you, which makes you the 
author.  But Mayank's SOB is listed first, which means he is the author. 
  Those two facts conflict.

Did Mayank author this and you are just submitting it on his behalf, or 
did the two of you co-author this?

> ---
>   drivers/bus/mhi/host/boot.c | 24 +++++++++++++++++-------
>   include/linux/mhi.h         |  2 ++
>   2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index d2a19b07..563b011 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -365,12 +365,13 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
>   }
>   
>   static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
> -			      const struct firmware *firmware,
> +			      const u8 *image_buf,
> +			      size_t img_size,
>   			      struct image_info *img_info)
>   {
> -	size_t remainder = firmware->size;
> +	size_t remainder = img_size;
>   	size_t to_cpy;
> -	const u8 *buf = firmware->data;
> +	const u8 *buf = image_buf;
>   	struct mhi_buf *mhi_buf = img_info->mhi_buf;
>   	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
>   
> @@ -395,8 +396,9 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	const char *fw_name;
>   	void *buf;
>   	dma_addr_t dma_addr;
> -	size_t size;
> +	size_t size, img_size;
>   	int i, ret;
> +	const u8 *img_buf;
>   
>   	if (MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state)) {
>   		dev_err(dev, "Device MHI is not in valid state\n");
> @@ -478,15 +480,23 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>   	 * device transitioning into MHI READY state
>   	 */
>   	if (mhi_cntrl->fbc_download) {
> -		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image,
> -					   firmware->size);
> +		img_size = firmware->size;
> +		img_buf = firmware->data;
> +		dev_dbg(dev, "tme_supported_image:%s\n",
> +				(mhi_cntrl->tme_supported_image ? "True" : "False"));
> +		if (mhi_cntrl->tme_supported_image) {
> +			img_buf = firmware->data + mhi_cntrl->sbl_size;
> +			img_size = img_size - mhi_cntrl->sbl_size;
> +		}
> +
> +		ret = mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->fbc_image, img_size);
>   		if (ret) {
>   			release_firmware(firmware);
>   			goto error_fw_load;
>   		}
>   
>   		/* Load the firmware into BHIE vec table */
> -		mhi_firmware_copy(mhi_cntrl, firmware, mhi_cntrl->fbc_image);
> +		mhi_firmware_copy(mhi_cntrl, img_buf, img_size, mhi_cntrl->fbc_image);
>   	}
>   
>   	release_firmware(firmware);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index f6de4b6..5f46dc9 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -306,6 +306,7 @@ struct mhi_controller_config {
>    * @reg_len: Length of the MHI MMIO region (required)
>    * @fbc_image: Points to firmware image buffer
>    * @rddm_image: Points to RAM dump buffer
> + * @tme_supported_image: Flag to make decision about firmware download start address (optional)
>    * @mhi_chan: Points to the channel configuration table
>    * @lpm_chans: List of channels that require LPM notifications
>    * @irq: base irq # to request (required)
> @@ -391,6 +392,7 @@ struct mhi_controller {
>   	size_t reg_len;
>   	struct image_info *fbc_image;
>   	struct image_info *rddm_image;
> +	bool tme_supported_image;

A bool in the middle of several pointers?  Surely that makes the pahole 
output rather sad?  A lot of work went into the organization of this 
structure.

>   	struct mhi_chan *mhi_chan;
>   	struct list_head lpm_chans;
>   	int *irq;

