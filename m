Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6C76AAE2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjHAIZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjHAIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:25:33 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8664212B;
        Tue,  1 Aug 2023 01:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690878316; x=1722414316;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y2+ZeiOBJGw1xzpxMubXvwDfFcZrn5IRphqvWbOunvw=;
  b=XCT5j0j9OX294N0D8ubLCrhKyD2xRLKQBbvnNXOECt0PoECUe19rL8GF
   9pgrLBVWK4Rr4zmC4u/mzduHNF0tFDMKI9CRS2DrohpC26S0B49CovBwI
   QhIsvUAvuHjSnZygPKhECRcMF03cb0FFSuWJ11gU2eu0lP1YHykmuwVsU
   anoPS1meSA2xHO3/bsKx8v1XbT9u8ysip/aG9dda1FNbUMrAo8JFjyno3
   UuVSg355MFE9lY6voeaZPIeEhoc9mF5Mw5piMlmHeZiE/8eNlsQ7j2jSd
   c2OCdGqxDWwT5Laaz3ih2yP0wANiDvW3pmsWHZz7vyLeCFXM9aFx4NVaH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="435557799"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="435557799"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678612519"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="678612519"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.38.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 01:25:12 -0700
Message-ID: <48f05875-5255-70d2-0737-36fa95470037@intel.com>
Date:   Tue, 1 Aug 2023 11:25:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.1
Subject: Re: [PATCH] scsi: ufs: ufs-pci: Add support for QEMU
Content-Language: en-US
To:     jeuk20.kim@samsung.com, "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "dlunev@chromium.org" <dlunev@chromium.org>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
 <20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/08/23 10:37, Jeuk Kim wrote:
> Add PCI ID to support QEMU ufs.
> 
> The new qemu ufs device can be found at
> https://lore.kernel.org/qemu-devel/20230727155239.GA979354@fedora

Please say something about why a UFS device is being virtualized
and what features it is expected to support.

> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>  drivers/ufs/host/ufshcd-pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
> index cf3987773051..29d322931427 100644
> --- a/drivers/ufs/host/ufshcd-pci.c
> +++ b/drivers/ufs/host/ufshcd-pci.c
> @@ -590,6 +590,7 @@ static const struct dev_pm_ops ufshcd_pci_pm_ops = {
>  };
>  
>  static const struct pci_device_id ufshcd_pci_tbl[] = {
> +	{ PCI_VENDOR_ID_REDHAT, 0x0013, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ PCI_VENDOR_ID_SAMSUNG, 0xC00C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
>  	{ PCI_VDEVICE(INTEL, 0x9DFA), (kernel_ulong_t)&ufs_intel_cnl_hba_vops },
>  	{ PCI_VDEVICE(INTEL, 0x4B41), (kernel_ulong_t)&ufs_intel_ehl_hba_vops },

