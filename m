Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485AD7FEFA9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjK3NAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjK3NAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:00:40 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809AC10C9;
        Thu, 30 Nov 2023 05:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701349247; x=1732885247;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lhdDwb899riHRg+OdMRgGaym7NkwiQLIQiSMtL17HzE=;
  b=Z34cHqZPDj+aPJhmCKqnemHVfgTv5UfQbWraIqugZ1jdxhdKXHBMNS4/
   S+cBp1efEkXizf7CVo95fV+zCUpyzCRsCVMeA7XThvwelkm7UGYV9/0sE
   p6Pi93xUVrC2M+Hygci/BuwfwCpbam6VwPRJ+jZ/dl81QH7gNEe5M1uFv
   75xQdU+asmmwuugTY3UybSt0IiJw0GJsEsBNJAtjJttznlps0DQBjOmtL
   hFAwVDKNW3ebv6czuIGiimjhQy1v9Nxji7QKu27P5VOXJ7cxYBgQOpvH8
   ArIBTpxoUNSTxjML5bqbATPvff+kJhqYxgYIcrPmEcHLwXibXB7WKbQTg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="179574"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="179574"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745623060"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="745623060"
Received: from bergler-mobl.ger.corp.intel.com ([10.249.33.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:00:44 -0800
Date:   Thu, 30 Nov 2023 15:00:41 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     SungHwan Jung <onenowy@gmail.com>
cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: acer-wmi: select ACPI_PLATFORM_PROFILE
In-Reply-To: <20231130124452.3460-1-onenowy@gmail.com>
Message-ID: <c13f1666-33a1-2df2-649-c7d32e64c70@linux.intel.com>
References: <20231130124452.3460-1-onenowy@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1571141058-1701349245=:1808"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1571141058-1701349245=:1808
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 30 Nov 2023, SungHwan Jung wrote:

> select ACPI_PLATFORM_PROFILE to fix the dependency problem for acer-wmi
> to support platform profile.
> 
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311301842.ppdT4zWK-lkp@intel.com/
> 
> Signed-off-by: SungHwan Jung <onenowy@gmail.com>
> 
> ---
> I apologize that I missed dependency in kconfig.
> I have submitted a single patch because the series of patches were alreay
> merged to linux-next.
> Is this enough or should I re-submit the patch-series including this patch?
> (or modify this to apply before "platform/x86: acer-wmi: Add platform
> profile and modekey support for Predator PHN16-71" commit?)
> ---
>  drivers/platform/x86/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 8e99a2f10147..81e6cd62a533 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -182,6 +182,7 @@ config ACER_WMI
>  	select INPUT_SPARSEKMAP
>  	select LEDS_CLASS
>  	select NEW_LEDS
> +	select ACPI_PLATFORM_PROFILE
>  	help
>  	  This is a driver for newer Acer (and Wistron) laptops. It adds
>  	  wireless radio and bluetooth control, and on some laptops,
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

I suspect Hans will just included that into the original patch so this 
patch will not appear in the history at all.

-- 
 i.

--8323329-1571141058-1701349245=:1808--
