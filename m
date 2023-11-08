Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE58F7E6103
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 00:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjKHXXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 18:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKHXXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 18:23:47 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A83F259F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 15:23:45 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b3f6f330d4so137937b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 15:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1699485824; x=1700090624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XMP1dSc2B6fVK8rculgAcWd9QSXnR3AnywG7adHAIn0=;
        b=RM6gsAgiENEbhSBJK8pjoHQtutQF6/xP8xrRwfaAqV2qaMTOIjD5MZxiJIuO0wDmTq
         GqERkpL/zGfF550m/m8Q0xCL7fAL8EIb47iuGFb6k4noPxblQr2H8VLD3VgfILeg/FB1
         5XCtrXQxhcb9N5xans2whskfeJhS0D3z6dgs+4omvQBWMSkze0D5+6/1fo/UpZY7YowZ
         BIs28tOU82YEV2DvdNI3hxQOYaohTFSIisflLS+Dqf79qrJ1isdbVYNZUay59xchjtZ1
         po1K3/+LAZDrdzNX1AnnqPI/5fHealpuRogz8QFyYLx8KJKko8kNFcUI52wXCudZvNhc
         XG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699485824; x=1700090624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XMP1dSc2B6fVK8rculgAcWd9QSXnR3AnywG7adHAIn0=;
        b=h8unoNHt+ZjRpMG0yaFNFyA3IWtLNx1li17Vz+qbRSzpdbQ1k2WoF8a///Z2vjon4w
         Px7LIQ03VPHEXFVJYOxbEtaIy7087j+E6D1cf8ECsPJyfz0WFUjEwOPghdx2J1Lr5oR8
         w/mp1vpEEroaDm0lDGAMOpYz41SxP0XI1UwOGnpnkwyTMrv6cajDleFwYPh3XCrpuLia
         1usrFY0M7mD1GL/YNz/Ki1guBZKAbvrVqNmShKmWJfmuLfGUWQEl3HkjbrbJPFS/rLnw
         0MgjJ1vwIdhbxbnwrHywCEAD9GG3KyoOMauB21ey1k8x/2gqIKQpNubvMPqwvX0JiBwu
         Eqhw==
X-Gm-Message-State: AOJu0YzXk4wZnEcWGMBxnjwRwOwjmaEWE/WA1lVazUZFEDsA4oRPwx+8
        6qgiKRyisa9ya55QwS9AnJX5xQ==
X-Google-Smtp-Source: AGHT+IFVyjWrMDuUEDjsPPi+KtcqEncel0P8jifN3Cd7eWqdIQZN9rGxu18qBPddDAMBNdA4V50nuA==
X-Received: by 2002:aca:2105:0:b0:3b5:7044:37f with SMTP id 5-20020aca2105000000b003b57044037fmr23236oiz.17.1699485824551;
        Wed, 08 Nov 2023 15:23:44 -0800 (PST)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id x6-20020a056a000bc600b006862b2a6b0dsm9813414pfu.15.2023.11.08.15.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 15:23:44 -0800 (PST)
Date:   Thu, 9 Nov 2023 04:53:38 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning:
 '%s' directive argument is null
Message-ID: <ZUwYejD6z1Kxa8ky@sunil-laptop>
References: <202311040602.sCjU3UXr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311040602.sCjU3UXr-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 06:24:22AM +0800, kernel test robot wrote:
> Hi Sunil,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
> commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
> date:   5 months ago
> config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311040602.sCjU3UXr-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/net/wireless/intel/iwlwifi/fw/acpi.c:9:
>    drivers/net/wireless/intel/iwlwifi/fw/acpi.c: In function 'iwl_acpi_is_ppag_approved':
> >> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning: '%s' directive argument is null [-Wformat-overflow=]
>     1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/net/wireless/intel/iwlwifi/iwl-debug.h:91:56: note: in definition of macro '__IWL_DEBUG_DEV'
>       91 |                 __iwl_dbg(dev, level, limit, __func__, fmt, ##args);    \
>          |                                                        ^~~
>    drivers/net/wireless/intel/iwlwifi/iwl-debug.h:209:41: note: in expansion of macro 'IWL_DEBUG'
>      209 | #define IWL_DEBUG_RADIO(p, f, a...)     IWL_DEBUG(p, IWL_DL_RADIO, f, ## a)
>          |                                         ^~~~~~~~~
>    drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1189:17: note: in expansion of macro 'IWL_DEBUG_RADIO'
>     1189 |                 IWL_DEBUG_RADIO(fwrt,
>          |                 ^~~~~~~~~~~~~~~
>    drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:41: note: format string is defined here
>     1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
>          |                                         ^~
> 
> 
> vim +1190 drivers/net/wireless/intel/iwlwifi/fw/acpi.c
> 
> e8e10a37c51c08 Matt Chen 2022-03-04  1187  
> e8e10a37c51c08 Matt Chen 2022-03-04  1188  	if (!dmi_check_system(dmi_ppag_approved_list)) {
> e8e10a37c51c08 Matt Chen 2022-03-04  1189  		IWL_DEBUG_RADIO(fwrt,
> e8e10a37c51c08 Matt Chen 2022-03-04 @1190  			"System vendor '%s' is not in the approved list, disabling PPAG.\n",
> 
Hi,

This should be fixed once SMBIOS is enabled in RISC-V. So, can this
warning be ignored until SMBIOS support is merged for RISC-V?

Thanks,
Sunil
> :::::: The code at line 1190 was first introduced by commit
> :::::: e8e10a37c51c08b99d272b2e1b3ef70fcd38f9e8 iwlwifi: acpi: move ppag code from mvm to fw/acpi
> 
> :::::: TO: Matt Chen <matt.chen@intel.com>
> :::::: CC: Luca Coelho <luciano.coelho@intel.com>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
