Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465397CBEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjJQJVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbjJQJVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:21:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51E811B;
        Tue, 17 Oct 2023 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697534451; x=1729070451;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v/7G7MGX1gcW6Dj8Rktw//OjNQ+o0JO+cRKd4i36UZg=;
  b=W9uLLy+AyzYv1HzTg9S8jn6++nAcAX1CihwhesmPVBX6Pht+w/f4z0B/
   /ppIQ5d8rKvB2okZrKPcxROIJdsPH0TCV2h9/X+QU6ArOFpmFuHuR3RWs
   TIIE/Prb6YCGJFJ5dxwsscygasdoEE04IvhoBnn3loQWzM5iyGiN0TsnN
   HMU80jyGiuaYtT1nEXgzGR+XkkUeB5uCkL/shJVDapKRSL7NlpleOa1WA
   G8vR+5JhEvNgO7f6wA6UDnbMlwIDrhnSZwTNKjDxSuN2JoYG2LTDj1Twf
   GZrnNRuRzHsCcNOBozLGbZTIuLOHhCvwR2+eMh2ikiDmj0txFRnUueDo/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="365999435"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="365999435"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:20:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="759733290"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="759733290"
Received: from spandruv-mobl.amr.corp.intel.com ([10.252.44.24])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 02:20:19 -0700
Date:   Tue, 17 Oct 2023 12:20:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Ma Jun <Jun.Ma2@amd.com>
cc:     amd-gfx@lists.freedesktop.org, lenb@kernel.org,
        johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com, majun@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v12 1/9] Documentation/driver-api: Add document about
 WBRF mechanism
In-Reply-To: <20231017025358.1773598-2-Jun.Ma2@amd.com>
Message-ID: <f3c89e85-a683-eedf-9c3-ed54173bc12@linux.intel.com>
References: <20231017025358.1773598-1-Jun.Ma2@amd.com> <20231017025358.1773598-2-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023, Ma Jun wrote:

> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
> explaining the theory and how it is used.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  Documentation/driver-api/wbrf.rst | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/driver-api/wbrf.rst
> 
> diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
> new file mode 100644
> index 000000000000..8561840263b3
> --- /dev/null
> +++ b/Documentation/driver-api/wbrf.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=================================
> +WBRF - Wifi Band RFI Mitigations
> +=================================
> +Due to electrical and mechanical constraints in certain platform designs

Add empty line before starting the content of a section.

> +there may be likely interference of relatively high-powered harmonics of
> +the GPU memory clocks with local radio module frequency bands used by
> +certain Wifi bands.
> +
> +To mitigate possible RFI interference producers can advertise the
> +frequencies in use and consumers can use this information to avoid using
> +these frequencies for sensitive features.
> +
> +When a platform is known to have this issue with any contained devices,
> +the platform designer will advertise the availability of this feature via
> +ACPI devices with a device specific method (_DSM).
> +* Producers with this _DSM will be able to advertise the frequencies in use.
> +* Consumers with this _DSM will be able to register for notifications of
> +frequencies in use.
> +
> +Some general terms
> +==================
> +Producer: such component who can produce high-powered radio frequency
> +Consumer: such component who can adjust its in-use frequency in
> +           response to the radio frequencies of other components to
> +           mitigate the possible RFI.
> +
> +To make the mechanism function, those producers should notify active use
> +of their particular frequencies so that other consumers can make relative
> +internal adjustments as necessary to avoid this resonance.
> +
> +ACPI interface
> +==============
> +Although initially used by for wifi + dGPU use cases, the ACPI interface
> +can be scaled to any type of device that a platform designer discovers
> +can cause interference.
> +
> +The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
> +
> +3 functions are available in this _DSM:
> +
> +* 0: discover # of functions available
> +* 1: record RF bands in use
> +* 2: retrieve RF bands in use
> +
> +Driver programming interface
> +============================
> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
> +
> +Sample Usage
> +=============
> +The expected flow for the producers:
> +1) During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
> +can be enabled for the device.
> +2) On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
> +param to get other consumers properly notified.
> +3) Or on stopping using some frequency band, call
> +`acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
> +
> +The expected flow for the consumers:
> +1) During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> +can be enabled for the device.
> +2) Call `amd_wbrf_register_notifier` to register for notification
> +of frequency band change(add or remove) from other producers.
> +3) Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
> +current active frequency bands considering some producers may broadcast
> +such information before the consumer is up.
> +4) On receiving a notification for frequency band change, run
> +`amd_wbrf_retrieve_freq_band` again to retrieve the latest
> +active frequency bands.
> +5) During driver cleanup, call `amd_wbrf_unregister_notifier` to
> +unregister the notifier.

Align these so that only the numbers start from first column. I think the 
proper markup for numbered lists is 1. not 1).


-- 
 i.

