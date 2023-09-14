Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251467A0588
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238946AbjINNZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbjINNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:25:45 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCD71BF4;
        Thu, 14 Sep 2023 06:25:41 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5733aa10291so554943eaf.3;
        Thu, 14 Sep 2023 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694697941; x=1695302741; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cJIpWS5SrdKk/VFTptvgYCrhGzB7h1Pz3OrqzGI13xw=;
        b=PvOmovLLx+bgCSbPvN36cYqJ3235fhDU+XEyl9VV2lLvEE1j0G68Z0tN5o7Rgthf3k
         b8Nrxn96WkOj14dSItZeemMRwECwDQbmg7PJGDJ/5+5WorcaXYiTlBK/XZ/nLLxZmXyb
         2c6aRBtQlm5yJQvdK8tDLvvEbODygXlPcKcL0s/qHZin6L10nzugnpjHfbs6NXqlD48z
         rFJjnwPGtBBgz3B8DZFz1lkBHwGDNb0VnczcnjA423S/dXM/yPhav8UBizmgNk6ZUhgS
         LBY91fCmY7nqrUhTT8ucGWOyhxNn2xv+zSjSj3QHww6txpoJRUGTaXdoB3W3Hv1Nftkh
         ZIGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697941; x=1695302741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJIpWS5SrdKk/VFTptvgYCrhGzB7h1Pz3OrqzGI13xw=;
        b=hTIeRksdj6+8vBrnjycOS+JyQUFmlB4A652zHRZMjREPGFwSd8qDSrfgWgf8P9GHoQ
         89q9HnH58D+//J6VGCVa7C2bk4Fe6TLzD1myXoqdExn4FBhWv6p7z9KrLGCKswNDY3BT
         gdcF2bjWf7ytPPY9Ao0nTIWPIVd82+wDRsDCvYWVbK+SxinlOKeltW97nUTv1UPpzqaC
         UUFHOt5pgcqUbEwr7ub+l1lbhLZff1EFDrvDVdC+VaFpXFvJSQ/2GsqQ5Cq/7JWT+Wyy
         3435j7nymtuvQzzfPlDlQxT2VW9ORK9JG9xCXfipZlsvJgsEqGqOpHn9jwd5A3yCGSRY
         va8g==
X-Gm-Message-State: AOJu0YzXjYJcTTRyuQviVLZuwCshD90cFGUmGIMBZ+YTn3ZmO6KpS3t5
        W9o95cZw6VGfdrzee8T7EeznIB5BYZIAWQV3DnA=
X-Google-Smtp-Source: AGHT+IFymUr0ituV17ECs8Nzz27wjNloVV2tRP9LEJvWEDttquVKGMNIUWW3tnoff/EcR08Qm7KPJwTT+nKOljHbqlo=
X-Received: by 2002:a4a:9b0f:0:b0:571:24b4:15b7 with SMTP id
 a15-20020a4a9b0f000000b0057124b415b7mr6229791ook.1.1694697940903; Thu, 14 Sep
 2023 06:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230822134849.3352329-1-alessandro.carminati@gmail.com>
 <CAPp5cGTshQJ3aLeLqv=CbaVeg9GnK_k9nsoaWrBKs1dcXzNZow@mail.gmail.com>
 <fc8023b435f78e02c96fecbe8e7599ee.sboyd@kernel.org> <CAPp5cGQ0Wp4my93tEm9-Huc6R+22zCj91mNJsPpGTFoo49=mcQ@mail.gmail.com>
 <fde1b20074cf5c0e0bc1944959486150.sboyd@kernel.org> <CAPp5cGSbdhLb2c5hQrP-O-+j63haXs0c6=JCoFxnAzF1mhspuA@mail.gmail.com>
 <f72f0a599fa5ca03321454fd14dd8856.sboyd@kernel.org>
In-Reply-To: <f72f0a599fa5ca03321454fd14dd8856.sboyd@kernel.org>
From:   Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Thu, 14 Sep 2023 15:25:04 +0200
Message-ID: <CAPp5cGT12pHf3JbZe5SvJD1kW6gJSTHV8s-7FgDHj0=f5U-h2A@mail.gmail.com>
Subject: Re: [PATCH] Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Philip Daly <pdaly@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Carminati
Mobile: +39.339.8870183


Il giorno mar 12 set 2023 alle ore 19:59 Stephen Boyd
<sboyd@kernel.org> ha scritto:
>
> Quoting Alessandro Carminati (2023-09-12 10:05:19)
> > Il giorno ven 8 set 2023 alle ore 23:25 Stephen Boyd
> > <sboyd@kernel.org> ha scritto:
> > >
> > > Is nothing actually wrong? And this is a speculative patch?
> >
> > In the current state, Linux can crash, so I would say that there's something
> > wrong.
> > I submitted this patch in response to a specific bug report that caused a
> > kernel crash during testing.
>
> Where is the bug report? On some public tracker? Can you link to it?
Sorry for the wait, I used this time to verify internally if the test can
be shared.
Unfortunately, we can't share it on a public tracker or the test outside
our company.

But I can definitely provide a simple reproducer.
It's a breeze once you've got the right hardware, like the Qualcomm
SA8540P-based board where I found it.
Here it is:

# cat /sys/kernel/debug/clk/gcc_usb4_phy_sys_clk_src/clk_possible_parents
[  139.322764] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  139.331802] Mem abort info:
[  139.334679]   ESR = 0x0000000096000004
[  139.338536]   EC = 0x25: DABT (current EL), IL = 32 bits
[  139.343991]   SET = 0, FnV = 0
[  139.347131]   EA = 0, S1PTW = 0
[  139.350356]   FSC = 0x04: level 0 translation fault
[  139.355360] Data abort info:
[  139.358326]   ISV = 0, ISS = 0x00000004
[  139.362270]   CM = 0, WnR = 0
[  139.365322] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109abb000
[  139.371931] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  139.378909] Internal error: Oops: 0000000096000004 [#1] PREEMPT_RT SMP
[  139.378915] Modules linked in: rfkill dwc3 pinctrl_spmi_gpio
rtc_pm8xxx qcom_spmi_pmic marvell regmap_spmi udc_core
dwmac_qcom_ethqos socinfo stmmac_platform stmmac qrtr crct10dif_ce
ghash_ce sha2_ce qcom_q6v5_pas sha256_arm64 sha1_ce qcom_pil_info
spmi_pmic_arb mdt_loader qcom_common spmi qcom_glink_smem
phy_qcom_qmp_usb dwc3_qcom qcom_glink llcc_qcom pcs_xpcs qcom_smd
phy_qcom_qmp_combo phylink qcom_q6v5 phy_qcom_snps_femto_v2
qcom_sysmon rpmsg_core qcom_hwspinlock qmi_helpers qcom_cpufreq_hw
qcom_aoss qcom_wdt qcom_rng smp2p smem sg fuse ext4 mbcache jbd2
ufs_qcom ufshcd_pltfrm ufshcd_core qcom_geni_serial rpmhpd
qcom_geni_se qcom_rpmh_regulator pinctrl_sc8280xp pinctrl_sa8775p
pinctrl_msm phy_qcom_qmp_ufs qnoc_sc8280xp qnoc_sa8775p icc_rpmh
icc_bcm_voter governor_simpleondemand gcc_sc8280xp gcc_sa8775p
clk_rpmh qcom_rpmh cmd_db clk_qcom
[  139.379012] CPU: 7 PID: 623 Comm: cat Not tainted 5.14.0+ #149
[  139.379017] Hardware name: Qualcomm SA8540P Ride (DT)
[  139.379019] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  139.379024] pc : __pi_strlen+0x14/0x150
[  139.379037] lr : seq_puts+0x28/0x70
[  139.379047] sp : ffff800009bbba90
[  139.379048] x29: ffff800009bbba90 x28: ffff10604726fdd0 x27: 0000000000400cc0
[  139.379054] x26: 000000007ffff000 x25: ffff10604726fdc0 x24: 0000000000000000
[  139.379058] x23: ffff800009bbbbd0 x22: 0000000000000020 x21: ffff10604076a500
[  139.379063] x20: 0000000000000000 x19: ffff10604726fd98 x18: 0000000000000000
[  139.379067] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[  139.379071] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[  139.379076] x11: 0000000000000000 x10: ffffa59b267f6f1b x9 : ffffa19b2397332c
[  139.379080] x8 : 0101010101010101 x7 : 00000000736c6c65 x6 : 0080e3ecef636b2d
[  139.379085] x5 : 2d6b636f6c630000 x4 : 0000000000000000 x3 : 0000000000000000
[  139.379090] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[  139.379094] Call trace:
[  139.379095]  __pi_strlen+0x14/0x150
[  139.379101]  possible_parent_show+0x7c/0x100
[  139.379108]  possible_parents_show+0x4c/0x90
[  139.379114]  seq_read_iter+0xdc/0x480
[  139.379120]  seq_read+0xc0/0x100
[  139.379127]  full_proxy_read+0x64/0xb0
[  139.379135]  vfs_read+0xb4/0x1d0
[  139.379142]  ksys_read+0x70/0x100
[  139.379148]  __arm64_sys_read+0x20/0x30
[  139.379154]  invoke_syscall.constprop.0+0x7c/0xd0
[  139.379164]  el0_svc_common.constprop.0+0x124/0x134
[  139.379170]  do_el0_svc+0x2c/0xac
[  139.379176]  el0_svc+0x38/0x1c0
[  139.379184]  el0t_64_sync_handler+0x10c/0x11c
[  139.379187]  el0t_64_sync+0x17c/0x180
[  139.379192] Code: 92402c04 b200c3e8 f13fc09f 5400088c (a9400c02)
[  139.631968] ---[ end trace f38c177abbfb4315 ]---
[  139.631971] Kernel panic - not syncing: Oops: Fatal exception
[  139.642601] SMP: stopping secondary CPUs
[  139.643039] Kernel Offset: 0x219b1b280000 from 0xffff800008000000
[  139.643040] PHYS_OFFSET: 0xffffefa0c0000000
[  139.643040] CPU features: 0x0000000,05c01018,c801720b
[  139.643042] Memory Limit: none

>
> >
> > >
> > > All other arms of this conditional statement check the validity of the
> > > pointer before printing the string. And when the parent isn't known we
> > > print "(missing)", so it looks like we should do that instead. How about
> > > this patch?
> >
> > Indeed, your patch appears to provide a more verbose coding and accurate
> > message, which is valuable for troubleshooting.
> > So yeah, for what it is worth, I think it is good as well.
>
> Cool, can you send it after testing it out?
I will thank you for your assistance.
