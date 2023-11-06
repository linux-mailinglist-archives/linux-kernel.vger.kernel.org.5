Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42607E1D39
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjKFJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjKFJ3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:29:14 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAECAB;
        Mon,  6 Nov 2023 01:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699262952; x=1730798952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n7Pg7QEUgF0AOa0JoeE8yu+anEa9R0Webe/V+kY/BHM=;
  b=fO9AdEK11/Cp4d1rGFPVrRXvuZwXmVWfELpZRxT7a6G/c7EO4BrEH1tF
   Tf18W1SkXjREHAOZ0LAKSLgfNLDVedfyDUJhn7FDyfaFu2EjfpS01Dww7
   Klwzrj7xtNzPTi06m8pCUmRqmhd0WN6GVxXu2TJ/RAfHo6y+O1pw3RA3a
   d2x0t9IidZZm/XlosRlXczkNqGmgaH48b+3rpzKlWN6YvXn1Phv7e5gYc
   r94Ht/7gNedoct2C+tsZgLQHiL5KJgZAoom5BhjlaYybAix+35d5XhpBD
   uQ77+0DswNYlRi2tbXHV9RgoERpFILtJtGtzLDBdJ9rOScfb5BImMWYE6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="453547815"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="453547815"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="10404050"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.231])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 01:29:08 -0800
Message-ID: <d18a2569-ebc3-484f-927a-5e3682457469@intel.com>
Date:   Mon, 6 Nov 2023 11:29:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
Content-Language: en-US
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
References: <20231018103337.34622-1-victorshihgli@gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20231018103337.34622-1-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/23 13:33, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages that will
> often appear in the system log when the system accesses the GL975x
> PCI config. Therefore, the replay timer timeout must be masked.
> 
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> 
> Updates in V2:
>  - Modify the commit message.
> 
> ---
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index d83261e857a5..d8a991b349a8 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -28,6 +28,9 @@
>  #define PCI_GLI_9750_PM_CTRL	0xFC
>  #define   PCI_GLI_9750_PM_STATE	  GENMASK(1, 0)
>  
> +#define PCI_GLI_9750_CORRERR_MASK				0x214
> +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
> +
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -152,6 +155,9 @@
>  #define PCI_GLI_9755_PM_CTRL     0xFC
>  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
>  
> +#define PCI_GLI_9755_CORRERR_MASK				0x214
> +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT	  BIT(12)
> +
>  #define SDHCI_GLI_9767_GM_BURST_SIZE			0x510
>  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET	  BIT(8)
>  
> @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>  	value &= ~PCI_GLI_9750_PM_STATE;
>  	pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
>  
> +	/* mask the replay timer timeout of AER */
> +	pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> +	value |= PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +	pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> +
>  	gl9750_wt_off(host);
>  }
>  
> @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>  	value &= ~PCI_GLI_9755_PM_STATE;
>  	pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
>  
> +	/* mask the replay timer timeout of AER */
> +	pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> +	value |= PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +	pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> +
>  	gl9755_wt_off(pdev);
>  }
>  

