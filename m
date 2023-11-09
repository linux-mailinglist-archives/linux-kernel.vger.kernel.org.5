Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368FB7E61C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 02:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjKIBVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 20:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjKIBVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 20:21:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB62B171B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 17:21:35 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5bd85b1939aso251009a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 17:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1699492895; x=1700097695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSfmB+u51JBmKC1Wlkf6iEFeaQtZOycHV3eXMwvCsVM=;
        b=Ul5fY/zjB+HoZAeE6OpMVcElPHAZl2OKe2DMwBhV3svjD8NwgXy/Jw0o/jTs701EA5
         UyzZbbtXfrgj6XgW/naSQM4crFUnE8F5EH3xNyzjqG0kmtqQMj/pmSOaxfcubz+xfs2j
         /Mh98UGCZRYxppBX5F+3wmV8+SvCFmRwJ6m4WPBFGuSMIf7FW56uco4hw3SAKML6tpVN
         NfbgUZOCGZ/Bb439EIgC/Iu/1z4mTn1sUyysp0mrOjFoSU1GI+XRb3lCgTFXAn0J7SA9
         Qsz01BZC57JuzOQZq5sC5MZnBHwKNlUQl9OQAwZ4zquj7NNt8X3cS3s0qak6tH7/8zGh
         JUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699492895; x=1700097695;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSfmB+u51JBmKC1Wlkf6iEFeaQtZOycHV3eXMwvCsVM=;
        b=pSBjO06Seq7w9aTrj2Pdae7Vwegk0pfkYS3ITi49dRUJYgTz5bAMi5nBvFq6GO1uSQ
         FCFsfTJcE/kERH0F1tz6jjgJJoNIK2a2DjBLAugSz4DdX76thv5BS/LPq06XytqzFabo
         jVEQr9s86VwoiNxFfTkQJgaVgpp/BUD7GMwIrGV3jBAi0q2X15CjXQyPwt4VG2eIOsRs
         RDRO3VgoHaoyu+DCHlCNlt/OsuxuXtQl6dyaDPs876gnVwKhqCo5bH+OuFhukQajN5Rp
         GxVf/jXBNJ1qjfHxsOz7K2+Ngr+g4SSF9my6EbgODzULmQVxgxEtpxklCSd/QTh8G+zd
         KsrQ==
X-Gm-Message-State: AOJu0Ywzt6cTxO+a9ImYsiQW+QsnxuXWafdl6FXKCPb9DdGZMH2SH7tM
        4xu4ofe58s3AsuxaoXeVZhUYcQ==
X-Google-Smtp-Source: AGHT+IGXzpJhbmftzemN7E3TZ5XSqtbPdkGaoy05sJ4+xoWY9upXDzaAB6RHGM12rXJkXT8e/q3V2A==
X-Received: by 2002:a05:6a20:441a:b0:16b:f3b1:c040 with SMTP id ce26-20020a056a20441a00b0016bf3b1c040mr4606549pzb.38.1699492895241;
        Wed, 08 Nov 2023 17:21:35 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id o24-20020a17090aac1800b002800d17a21csm132815pjq.15.2023.11.08.17.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 17:21:34 -0800 (PST)
Date:   Wed, 08 Nov 2023 17:21:34 -0800 (PST)
X-Google-Original-Date: Wed, 08 Nov 2023 17:21:32 PST (-0800)
Subject:     Re: drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning: '%s' directive argument is null
In-Reply-To: <ZUwYejD6z1Kxa8ky@sunil-laptop>
CC:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com,
        Conor Dooley <conor.dooley@microchip.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     sunilvl@ventanamicro.com
Message-ID: <mhng-9c8eb5de-4aab-467a-b09f-ff6707b74738@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2023 15:23:38 PST (-0800), sunilvl@ventanamicro.com wrote:
> On Sat, Nov 04, 2023 at 06:24:22AM +0800, kernel test robot wrote:
>> Hi Sunil,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
>> commit: a91a9ffbd3a55a0ae1bb75e2b6e85b2a03f64e8f RISC-V: Add support to build the ACPI core
>> date:   5 months ago
>> config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/config)
>> compiler: riscv64-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040602.sCjU3UXr-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202311040602.sCjU3UXr-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>    In file included from drivers/net/wireless/intel/iwlwifi/fw/acpi.c:9:
>>    drivers/net/wireless/intel/iwlwifi/fw/acpi.c: In function 'iwl_acpi_is_ppag_approved':
>> >> drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:25: warning: '%s' directive argument is null [-Wformat-overflow=]
>>     1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
>>          |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    drivers/net/wireless/intel/iwlwifi/iwl-debug.h:91:56: note: in definition of macro '__IWL_DEBUG_DEV'
>>       91 |                 __iwl_dbg(dev, level, limit, __func__, fmt, ##args);    \
>>          |                                                        ^~~
>>    drivers/net/wireless/intel/iwlwifi/iwl-debug.h:209:41: note: in expansion of macro 'IWL_DEBUG'
>>      209 | #define IWL_DEBUG_RADIO(p, f, a...)     IWL_DEBUG(p, IWL_DL_RADIO, f, ## a)
>>          |                                         ^~~~~~~~~
>>    drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1189:17: note: in expansion of macro 'IWL_DEBUG_RADIO'
>>     1189 |                 IWL_DEBUG_RADIO(fwrt,
>>          |                 ^~~~~~~~~~~~~~~
>>    drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1190:41: note: format string is defined here
>>     1190 |                         "System vendor '%s' is not in the approved list, disabling PPAG.\n",
>>          |                                         ^~
>>
>>
>> vim +1190 drivers/net/wireless/intel/iwlwifi/fw/acpi.c
>>
>> e8e10a37c51c08 Matt Chen 2022-03-04  1187
>> e8e10a37c51c08 Matt Chen 2022-03-04  1188  	if (!dmi_check_system(dmi_ppag_approved_list)) {
>> e8e10a37c51c08 Matt Chen 2022-03-04  1189  		IWL_DEBUG_RADIO(fwrt,
>> e8e10a37c51c08 Matt Chen 2022-03-04 @1190  			"System vendor '%s' is not in the approved list, disabling PPAG.\n",
>>
> Hi,
>
> This should be fixed once SMBIOS is enabled in RISC-V. So, can this
> warning be ignored until SMBIOS support is merged for RISC-V?

Maybe we should just have something like this?

diff --git a/drivers/net/wireless/intel/iwlwifi/Kconfig b/drivers/net/wireless/intel/iwlwifi/Kconfig
index 20971304fdef..cbcd1dcced4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/Kconfig
+++ b/drivers/net/wireless/intel/iwlwifi/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IWLWIFI
 	tristate "Intel Wireless WiFi Next Gen AGN - Wireless-N/Advanced-N/Ultimate-N (iwlwifi) "
-	depends on PCI && HAS_IOMEM && CFG80211
+	depends on PCI && HAS_IOMEM && CFG80211 && DMI
 	depends on IWLMEI || !IWLMEI
 	select FW_LOADER
 	help

>
> Thanks,
> Sunil
>> :::::: The code at line 1190 was first introduced by commit
>> :::::: e8e10a37c51c08b99d272b2e1b3ef70fcd38f9e8 iwlwifi: acpi: move ppag code from mvm to fw/acpi
>>
>> :::::: TO: Matt Chen <matt.chen@intel.com>
>> :::::: CC: Luca Coelho <luciano.coelho@intel.com>
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
