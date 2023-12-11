Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA9A80C6EB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjLKKpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbjLKKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:45:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB59A9;
        Mon, 11 Dec 2023 02:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702291543; x=1733827543;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LC4Pclve0K/VznFdQCYhiNQPtxHVC5jnqQW33yq7eXE=;
  b=JHATXVEIdn6C1pnMDq0Kd3b4RtnQVtHKElqlQfHbqaxZl6BqH0WMiLLi
   EqGh3TPVR7Ywq5c3L0rZ8f0oQtqA5p06kqZGGm24T4Ys81YmNYFT2xJBL
   Mu6m5amYTARzgLP0w1Y33t3y2ya/XboEmscQ9R9HnzZxDkaTjy9qwuWij
   x22JBCfxksl8zwaxKhyqrMTYq+WMeTEgxvbT1CqZJgnEmV8rUreIfg8s2
   jmGVGg2TwRCgwSwtd8vi8I1vYhfULf48sskhuvKIG9OLdbHpamDrolChI
   dOu2uMMhVCWNTiJif3bsYW3dx8Eh7KmuezfGtjVjtL5mmmnBvMAvfaPhA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="398481778"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="398481778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:45:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="838979618"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="838979618"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.46.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 02:45:38 -0800
Message-ID: <0faa472c-d21d-46df-922b-264d7915f983@intel.com>
Date:   Mon, 11 Dec 2023 12:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7][2/4] mmc: Add Synopsys DesignWare mmc cmdq host driver
Content-Language: en-US
To:     =?UTF-8?B?SnlhbiBDaG91IFvlkajoirflrold?= <jyanchou@realtek.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "doug@schmorgal.com" <doug@schmorgal.com>,
        "tonyhuang.sunplus@gmail.com" <tonyhuang.sunplus@gmail.com>,
        "abel.vesa@linaro.org" <abel.vesa@linaro.org>,
        "william.qiu@starfivetech.com" <william.qiu@starfivetech.com>
References: <20231121091101.5540-1-jyanchou@realtek.com>
 <20231121091101.5540-3-jyanchou@realtek.com>
 <655c5964-0917-4021-b254-7917b368b05f@intel.com>
 <7b4b7219c2b6430b9c320c8d9ac1cc8b@realtek.com>
 <8e7b6ac2-9d92-4f37-97c4-ae295f7cdbd4@intel.com>
 <49d0b19c5ec741638e41ee6f970d057b@realtek.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <49d0b19c5ec741638e41ee6f970d057b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/23 12:37, Jyan Chou [周芷安] wrote:
> Hi Adrian,
> 
>>>>> +
>>>>> +static irqreturn_t dw_mci_cqe_interrupt(int irq, void *dev_id) {
>>>>> +     struct dw_mci *host = dev_id;
>>>>> +     struct mmc_host *mmc = host->slot->mmc;
>>>>> +     struct cqhci_host *cq_host = NULL;
>>>>> +     int cmd_error = 0, data_error = 0;
>>>>> +
>>>>> +     if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE))
>>>>> +             cq_host = mmc->cqe_private;
>>>>> +
>>>>> +     dw_mci_get_int(host);
>>>>> +
>>>>> +     if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
>>>>> +             if (!mmc->cqe_on && !cq_host->activated)
>>>>
>>>> Shouldn't really look at internals like mmc->cqe_on or cq_host->activated.
>>>> There are the cqhci_host_ops ->enable() and ->disable() callbacks to
>>>> keep track of whether cqhci is expecting interrupts.
>>>
>>> Does this means we need to use cqhci_host_ops ->enable() and
>>> ->disable() callbacks instead of mmc->cqe_on && !cq_host->activated?
>> Thanks.
>>
>> Yes.  ->enable() is always called before cqhci operation and ->disable() before
>> non-cqhci operation, so they can be used to determine if an interrupt is for
>> cqhci.
> 
> Thanks for your advice, and I got your point for calling cqhci_host_ops ->enable()
> 
> and ->disable() callbacks, but the reason we used " if (!mmc->cqe_on && !cq_host->activated) "
> 
> is that when sending command like cmd0, 1, 7, 8... in mmc_init_card before mmc_cmdq_enable,
> 
> we need to use interrupt in legacy mode, it is much better to write in this way?
> 
> +	events = mci_readw(host, NORMAL_INT_STAT_R);
> - 	if (host->pdata && (host->pdata->caps2 & MMC_CAP2_CQE)) {
> - 		if (!mmc->cqe_on && !cq_host->activated)
> +	if (mmc->caps2 & MMC_CAP2_CQE) {
> +		if (!(events & CQE_EVENT))
> 			dw_mci_clr_signal_int(host);
> 
> Using CQE_EVENT to determine whether Command Queue enable or not.

Unless you expect CQ interrupts before cqhci_host_ops ->enable()
is called, then you know it is legacy mode.

