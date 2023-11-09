Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838DE7E633D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjKIFh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 00:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIFh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:37:27 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3C21BD4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 21:37:25 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7ad501764f4so19759239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 21:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699508245; x=1700113045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uqCVKURZkdnc8Sc+q8t4D7aQ1PHCBVFIg7Q1EQgXMic=;
        b=j+dKgVhCe9DCPDbDAJbEMkeyXHOlWNBOclIXGGfDj+qkAZ8GpQH5bcJl2y9FbfgV/O
         s6DHlFXUBnJaWTlekRrNFCQbdPLuAYhtDxc9DrVxWnuzrFCHr47mQ9Vk4OMUeqOYp04B
         sAO6ENUQlLY+2LAzL37Xn052cQtQbgOHThtC1HZOASzT1zgVLdA30x8Tia+BV6k11p7I
         zC2w8quBpQKAuMW0bl1r/d0Coj+HyMJZnZm8wiLslVU200h15bIBKBWHMbvGh7o9cZCv
         9VYWyjqty4Kyn02OccKI5NycidnqPcrmM+wPdU7oklAb8G6wahYBZQ2oioVy2q2Pwlc1
         lkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699508245; x=1700113045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqCVKURZkdnc8Sc+q8t4D7aQ1PHCBVFIg7Q1EQgXMic=;
        b=QZ8ke1LoiPrNQCpbl3wlN5ImxpcPRI73KgXMmtiAPBdYcYBFyYmS+nxJQC3hnzF7NV
         lni5wBdHj9wNcnXVupP7UTwAxCr4x5JBZ34m92fdqrXjLiYO5pGiJwGzYqsDhJ+eycEA
         7QpkRaaY8aACidle+IAm3dyyW9sxcJwZ2EPn2lkjvDza0H/Yxigb1xXwzQsKcNVp/7so
         9OtxA7Ho+0d7nl/iKoRW/dFK/PhcB437FxzM4j2r3rbKqdj4KYb79z2KQgUBrEWtMYwZ
         XArCyIp7gSoY7RO71X8nCxuMf/qdFh6iWPEBOYmtxBCU03m+Rqj2P8V89EzeOmNlqw7M
         fptA==
X-Gm-Message-State: AOJu0Yw3hpoUFv2/qzlRyrI4fswHXpearzx9eTDcY/ya/BuJHuSbIXHa
        cIvyNneBoCEyMnFlLztCfGYGDQ==
X-Google-Smtp-Source: AGHT+IGP2r3bL9pu9iBmV91XbZ//ufgsIl+ac7AYpSyfa7ARxO8Ui2ecns7UT/BAyxHNTDbx6AaEyA==
X-Received: by 2002:a92:cc82:0:b0:359:97f3:e7e7 with SMTP id x2-20020a92cc82000000b0035997f3e7e7mr3059994ilo.26.1699508244822;
        Wed, 08 Nov 2023 21:37:24 -0800 (PST)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id a25-20020a634d19000000b005894450b404sm3837985pgb.63.2023.11.08.21.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 21:37:24 -0800 (PST)
Date:   Thu, 9 Nov 2023 11:07:18 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning:
 '%s' directive argument is null
Message-ID: <ZUxwDgFhC/gAidXU@sunil-laptop>
References: <ZUwYejD6z1Kxa8ky@sunil-laptop>
 <mhng-9c8eb5de-4aab-467a-b09f-ff6707b74738@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-9c8eb5de-4aab-467a-b09f-ff6707b74738@palmer-ri-x1c9>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 05:21:34PM -0800, Palmer Dabbelt wrote:
> On Wed, 08 Nov 2023 15:23:38 PST (-0800), sunilvl@ventanamicro.com wrote:
> > On Sat, Nov 04, 2023 at 06:24:22AM +0800, kernel test robot wrote:
> > > Hi Sunil,
> > > 
> > > FYI, the error/warning still remains.
> > > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
> > > commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
> > > date:   5 months ago
> > > config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/config)
> > > compiler: riscv64-linux-gcc (GCC) 13.2.0
> > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202311040602.sCjU3UXr-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >    In file included from drivers/net/wireless/intel/iwlwifi/fw/acpi.c:9:
> > >    drivers/net/wireless/intel/iwlwifi/fw/acpi.c: In function 'iwl_acpi_is_ppag_approved':
> > > >> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning: '%s' directive argument is null [-Wformat-overflow=]
> > >     1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
> > >          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >    drivers/net/wireless/intel/iwlwifi/iwl-debug.h:91:56: note: in definition of macro '__IWL_DEBUG_DEV'
> > >       91 |                 __iwl_dbg(dev, level, limit, __func__, fmt, ##args);    \
> > >          |                                                        ^~~
> > >    drivers/net/wireless/intel/iwlwifi/iwl-debug.h:209:41: note: in expansion of macro 'IWL_DEBUG'
> > >      209 | #define IWL_DEBUG_RADIO(p, f, a...)     IWL_DEBUG(p, IWL_DL_RADIO, f, ## a)
> > >          |                                         ^~~~~~~~~
> > >    drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1189:17: note: in expansion of macro 'IWL_DEBUG_RADIO'
> > >     1189 |                 IWL_DEBUG_RADIO(fwrt,
> > >          |                 ^~~~~~~~~~~~~~~
> > >    drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:41: note: format string is defined here
> > >     1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
> > >          |                                         ^~
> > > 
> > > 
> > > vim +1190 drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> > > 
> > > e8e10a37c51c08 Matt Chen 2022-03-04  1187
> > > e8e10a37c51c08 Matt Chen 2022-03-04  1188  	if (!dmi_check_system(dmi_ppag_approved_list)) {
> > > e8e10a37c51c08 Matt Chen 2022-03-04  1189  		IWL_DEBUG_RADIO(fwrt,
> > > e8e10a37c51c08 Matt Chen 2022-03-04 @1190  			"System vendor '%s' is not in the approved list, disabling PPAG.\n",
> > > 
> > Hi,
> > 
> > This should be fixed once SMBIOS is enabled in RISC-V. So, can this
> > warning be ignored until SMBIOS support is merged for RISC-V?
> 
> Maybe we should just have something like this?
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
> index 20971304fdef..cbcd1dcced4d 100644
> --- a/drivers/net/wireless/intel/iwlwifi/Kconfig
> +++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
> @@ -1,7 +1,7 @@
> # SPDX-License-Identifier: GPL-2.0-only
> config IWLWIFI
> 	tristate "Intel Wireless WiFi Next Gen AGN - Wireless-N/Advanced-N/Ultimate-N (iwlwifi) "
> -	depends on PCI && HAS_IOMEM && CFG80211
> +	depends on PCI && HAS_IOMEM && CFG80211 && DMI
> 	depends on IWLMEI || !IWLMEI
> 	select FW_LOADER
> 	help
> 
Sure Palmer. This works to resolve the warning but I was bit hesitant to
do this because it appeared only part of the driver code depend on
ACPI/DMI. So, I was not sure adding a dependency would disable the
driver on non-ACPI platforms. Anyway, let me send the patch and see
whether driver maintainer would be okay.

Thanks!
Sunil
