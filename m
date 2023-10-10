Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9AF7BF3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442429AbjJJHEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377808AbjJJHE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:04:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3060D9E;
        Tue, 10 Oct 2023 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696921467; x=1728457467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QzWpFvDaJHvmkToEy7no3ioBWVCBUs+c4gOsmO5SnR0=;
  b=GN1sKsfLdb/9yxRypxDb4ZmGtQpNogaE8UyvIIJGgtt1c9GTbGDl/zGG
   64oafo1kMMEIBR889jHwg2cj2/wykKIdkFQ7z23rSYx/4e5dp9W/3DoP9
   RxdfxMYLRjxr+ZnmbMzNPdhU+717Vo5HZFpb3PcwsG8Poe2Q44/N4MZPS
   5MyCAB4pnhyQ/ghTxioudK9WoHEapUCQ/aa+HVkwVDpH9xOvK35A6ENAn
   PqBLIZNOOgdmIlvvXs5ksUoRgs8D8nGWwMXPdd3aqkOHfQx98YmAL00PQ
   /6G3brWmk7lBjmMF8w2l3hf1OwmCjdnIwMb/n4L+IH9x1/hIg+BuNQSVH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="5883826"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="5883826"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="729977507"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="729977507"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.36.106])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 00:04:24 -0700
Message-ID: <b35ef5aa-08c8-4316-9699-50ce907324a5@intel.com>
Date:   Tue, 10 Oct 2023 10:04:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] [02/03] mmc: Add Synopsys DesignWare mmc cmdq host
 driver
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        jh80.chung@samsung.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.tai@realtek.com
References: <cover.1693991785.git.jyanchou@realtek.com>
 <9617f04133ba8b6907b253c4154083f75956a341.1693991785.git.jyanchou@realtek.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <9617f04133ba8b6907b253c4154083f75956a341.1693991785.git.jyanchou@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please put version numbers in the patch subject.  Refer to:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

On 6/09/23 12:28, Jyan Chou wrote:
> We implemented cmdq feature on Synopsys DesignWare mmc driver.
> The difference between dw_mmc.c and dw_mmc_cqe.c were distinct
> register definitions and the addition of cmdq.

Register differences can be abstracted away, for example
by providing callbacks for reading / writing registers.
So this still needs much more explanation.

> 
> More over, the flow of abort command sequence had change.
> We added a wait status function to satisfy synopsys user guide's
> description, since this flow might be specific in synopsys host
> driver only.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> —
> v0 to v1 change:
> 1. Seperate different support into single patch.
> 2. Fix the compiler complains.
> ---
>  drivers/mmc/host/Kconfig      |   13 +
>  drivers/mmc/host/Makefile     |    1 +
>  drivers/mmc/host/dw_mmc_cqe.c | 1634 +++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc_cqe.h |  443 +++++++++
>  4 files changed, 2091 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.h

My comments pertain only to the use of cqhci.

[SNIP]

> +static void dw_mci_cqe_set_tran_desc(u8 *desc,
> +					dma_addr_t addr,
> +					int len,
> +					bool end,
> +					bool dma64)
> +{
> +	__le32 *attr = (__le32 __force *)desc;
> +
> +	*attr = (CQHCI_VALID(1) |
> +		 CQHCI_END(end ? 1 : 0) |
> +		 CQHCI_INT(0) |
> +		 CQHCI_ACT(0x4) |
> +		 CQHCI_DAT_LENGTH(len));
> +
> +	if (dma64) {
> +		__le64 *dataddr = (__le64 __force *)(desc + 4);
> +
> +		dataddr[0] = cpu_to_le64(addr);
> +	} else {
> +		__le32 *dataddr = (__le32 __force *)(desc + 4);
> +
> +		dataddr[0] = cpu_to_le32(addr);
> +	}
> +}
> +
> +static void dw_mci_cqe_setup_tran_desc(struct mmc_data *data,
> +				      struct cqhci_host *cq_host,
> +				      u8 *desc,
> +				      int sg_count)
> +{
> +	struct scatterlist *sg;
> +	u32 cur_blk_cnt, remain_blk_cnt;
> +	unsigned int begin, end;
> +	int i, len;
> +	bool last = false;
> +	bool dma64 = cq_host->dma64;
> +	dma_addr_t addr;
> +
> +	for_each_sg(data->sg, sg, sg_count, i) {
> +		addr = sg_dma_address(sg);
> +		len = sg_dma_len(sg);
> +		remain_blk_cnt  = len >> 9;
> +
> +		while (remain_blk_cnt) {
> +			/*DW_MCI_MAX_SCRIPT_BLK is tha max for each descriptor record*/
> +			if (remain_blk_cnt > DW_MCI_MAX_SCRIPT_BLK)
> +				cur_blk_cnt = DW_MCI_MAX_SCRIPT_BLK;
> +			else
> +				cur_blk_cnt = remain_blk_cnt;
> +
> +			/* In Synopsys DesignWare Databook Page 84,
> +			 * They mentioned the DMA 128MB restriction
> +			 */
> +			begin = addr / SZ_128M;
> +			end = (addr + cur_blk_cnt * SZ_512) / SZ_128M;
> +
> +			if (begin != end)
> +				cur_blk_cnt = (end * SZ_128M - addr) / SZ_512;
> +
> +			if ((i+1) == sg_count && (remain_blk_cnt == cur_blk_cnt))
> +				last = true;
> +
> +			dw_mci_cqe_set_tran_desc(desc, addr,
> +					(cur_blk_cnt << 9), last, dma64);
> +
> +			addr = addr + (cur_blk_cnt << 9);
> +			remain_blk_cnt -= cur_blk_cnt;
> +			desc += cq_host->trans_desc_len;
> +		}
> +	}
> +}

It would be preferable to use a callback only for setting
the descriptor.
Please see comments about dwcmshc_cqhci_set_tran_desc()
and dwcmshc_cqhci_prep_tran_desc() made here:
https://lore.kernel.org/linux-mmc/0932b124-16da-495c-9706-bbadadb3b076@intel.com/

[SNIP]

> +static void dw_mci_cqe_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct dw_mci *host = slot->host;
> +
> +	WARN_ON(slot->mrq);
> +
> +	/*
> +	 * The check for card presence and queueing of the request must be
> +	 * atomic, otherwise the card could be removed in between and the
> +	 * request wouldn't fail until another card was inserted.
> +	 */
> +
> +	if (!dw_mci_cqe_get_cd(mmc)) {
> +		mrq->cmd->error = -ENOMEDIUM;
> +		mmc_request_done(mmc, mrq);
> +		return;
> +	}
> +
> +	down_write(&host->cr_rw_sem);
> +
> +	/*cmdq case needs extra check*/
> +	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> +		if ((host->cqe) == NULL) {
> +			dev_err(host->dev, "dw_mci_request_cqe not done yet\n");
> +			mdelay(2);
> +		}
> +
> +		if (mmc->cqe_on == false && host->cqe->activated == true)
> +			cqhci_deactivate(mmc);

This should not be necessary.  Instead, please try to use
->pre_enable() and ->post_disable() like in mtk-sd.c

[SNIP]
