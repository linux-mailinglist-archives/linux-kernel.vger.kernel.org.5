Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2F75762B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGRIDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjGRIDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:03:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5C01FD0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:02:31 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9cd6a0051so33224495ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1689667351; x=1692259351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fnwKc/o3ISHm8NcR21OLJ9uDUCnyHyDdo8J6H/w7iTw=;
        b=YDBzoZ2QJljNIlYmSvS0QS08AyWmQkA8eWYBsjFyGKN2ULcH2tKZpx2j3CTyz5zKJ1
         itg3Haejzl9W/y1o8RiUcUBiZwDyI8F4M0avo9WLTpITRc+UcnRqZCEnYxvW4wgL6D8Y
         Z2Gz1B74iO4ilDDZM6OZhcD/m62y4/h25ry3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689667351; x=1692259351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnwKc/o3ISHm8NcR21OLJ9uDUCnyHyDdo8J6H/w7iTw=;
        b=K5TfX+4PhmZ/CUnK3EclDx3E+4zbUTdpjYA3tEQf7lry/DL9R3StKNRkAvAiCV8DlE
         C0t9jVlQD9l13qLeXMgptnp04vo5GvFjdZUWQA5YvvjoxSuc6mfa4TgEVxhpr2mQzxCV
         Yfbbh7GDGTWKDB5u12VO7KNPox/BIXimwnmijFccGcuUv6qUaD+VAaXUPzn1ZO07Oj1P
         +H8K13P00oIjuC0A5nplIO/nHhJa6//qmnFgp46dK4Fm4MfGwIkIV9KLNfXXgKRy9HI/
         7WNrb6B4oA4Y0h+IWVq9QitwV8TgF3ptr1NAH0FAdKMvkahJf7/iEE6vw5HTagqymMmk
         rSIg==
X-Gm-Message-State: ABy/qLbnkWJUZFtnDtJ/HbERkS5M5Zu6rtIea1ndcL8lQtCupSPSAr0B
        Ye30+yUluWpPAZjjralw75KRIw==
X-Google-Smtp-Source: APBJJlEe7fB6yHcAj9JWOSeLLAJphdyZKwKLmfC2xgNTv4YvfT8lwCODnKRipFxioXejYwrlNBunGA==
X-Received: by 2002:a17:902:e743:b0:1b2:5d5b:e871 with SMTP id p3-20020a170902e74300b001b25d5be871mr1425468plf.59.1689667350665;
        Tue, 18 Jul 2023 01:02:30 -0700 (PDT)
Received: from 503599e9be06 ([122.199.31.3])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090322c600b001b53953f306sm1173206plg.178.2023.07.18.01.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 01:02:29 -0700 (PDT)
Date:   Tue, 18 Jul 2023 08:02:22 +0000
From:   Rudi Heitbaum <rudi@heitbaum.com>
To:     "Peer, Ilan" <ilan.peer@intel.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Subject: Re: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
Message-ID: <ZLZHDm3mcxaLdvRH@503599e9be06>
References: <51e53417-cfad-542c-54ee-0fb9e26c4a38@gmail.com>
 <DM4PR11MB6043088A4A65CBF124F5D518E93BA@DM4PR11MB6043.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB6043088A4A65CBF124F5D518E93BA@DM4PR11MB6043.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From 5a6fcc4b2a91608917697f8446ec3e10b2ce9178 Mon Sep 17 00:00:00 2001
> From: Ilan Peer <ilan.peer@intel.com>
> Date: Tue, 18 Jul 2023 00:33:04 +0300
> Subject: [PATCH] wifi: cfg80211: Fix return value in scan logic
> 
> As cfg80211_parse_colocated_ap() is not expected to return a negative
> value return 0 and not a negative value if cfg80211_calc_short_ssid()
> fails.
> 
> This bug was introduced in commit c8cb5b854b40f
> ('nl80211/cfg80211: support 6 GHz scanning').
> 
> Signed-off-by: Ilan Peer <ilan.peer@intel.com>
> ---
> net/wireless/scan.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/wireless/scan.c b/net/wireless/scan.c
>index 8bf00caf5d29..0cf1ce7b6934 100644
>--- a/net/wireless/scan.c
>+++ b/net/wireless/scan.c
>@@ -657,7 +657,7 @@ static int cfg80211_parse_colocated_ap(const struct cfg80211_bss_ies *ies,
> 
> 	ret = cfg80211_calc_short_ssid(ies, &ssid_elem, &s_ssid_tmp);
> 	if (ret)
>-		return ret;
>+		return 0;
> 
> 	for_each_element_id(elem, WLAN_EID_REDUCED_NEIGHBOR_REPORT,
> 			    ies->data, ies->len) {
>-- 
>2.25.1

Hi Ilan, 

I can confirm that this fixes the error in my dmesg.

Regards
Rudi

Tested-by: Rudi Heitbaum <rudi@heitbaum.com>

On Mon, Jul 17, 2023 at 01:41:43PM +0000, Peer, Ilan wrote:
> Hi Sanjaya,
> 
> Can you please check if the attached patch fixes your issue?
> 
> Thanks in advance,
> 
> Ilan.
> 
> > -----Original Message-----
> > From: Bagas Sanjaya <bagasdotme@gmail.com>
> > Sent: Sunday, July 16, 2023 14:11
> > To: Rudi Heitbaum <rudi@heitbaum.com>; Johannes Berg
> > <johannes@sipsolutions.net>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> > Paolo Abeni <pabeni@redhat.com>; Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com>; Michael Ellerman
> > <mpe@ellerman.id.au>; Andrew Morton <akpm@linux-foundation.org>
> > Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Linux
> > Regressions <regressions@lists.linux.dev>; Linux Memory Management List
> > <linux-mm@kvack.org>; Linux Networking <netdev@vger.kernel.org>; Linux
> > Wireless <linux-wireless@vger.kernel.org>
> > Subject: Fwd: mm/page_alloc.c:4453 with cfg80211_wiphy_work [cfg80211]
> > 
> > Hi,
> > 
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> > 
> > > Linux version 6.5.0-rc1+ - up to
> > > 831fe284d8275987596b7d640518dddba5735f61
> > >
> > > [    7.312665] ------------[ cut here ]------------
> > > [    7.312671] WARNING: CPU: 8 PID: 659 at mm/page_alloc.c:4453
> > __alloc_pages+0x329/0x340
> > > [    7.312683] Modules linked in: exfat ntfs3 bnep btusb btrtl btbcm btintel
> > btmtk bluetooth ecdh_generic ecc iwlmvm mac80211 libarc4
> > snd_hda_codec_hdmi iwlwifi snd_hda_codec_realtek
> > snd_hda_codec_generic ledtrig_audio cfg80211 snd_hda_intel
> > snd_hda_codec snd_hwdep intel_rapl_msr x86_pkg_temp_thermal
> > intel_powerclamp snd_hda_core tpm_tis intel_rapl_common
> > snd_intel_dspcfg tpm_tis_core idma64 rfkill tpm_crb tpm rng_core
> > pkcs8_key_parser fuse dmi_sysfs
> > > [    7.312725] CPU: 8 PID: 659 Comm: kworker/8:2 Not tainted 6.5.0-rc1 #1
> > > [    7.312729] Hardware name: Intel(R) Client Systems
> > NUC12WSKi7/NUC12WSBi7, BIOS WSADL357.0087.2023.0306.1931 03/06/2023
> > > [    7.312731] Workqueue: events cfg80211_wiphy_work [cfg80211]
> > > [    7.312785] RIP: 0010:__alloc_pages+0x329/0x340
> > > [    7.312791] Code: a8 44 89 e6 89 df c6 45 c8 00 4c 89 6d b0 41 89 de e8 0b ef
> > ff ff 49 89 c7 e9 90 fe ff ff 80 e3 3f eb c0 c6 05 69 49 f7 09 01 <0f> 0b eb 98 e8
> > 1e ec 6d 01 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
> > > [    7.312794] RSP: 0018:ffffad8e80defbf8 EFLAGS: 00010246
> > > [    7.312798] RAX: 0000000000000000 RBX: 0000000000040dc0 RCX:
> > 0000000000000000
> > > [    7.312800] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 0000000000040dc0
> > > [    7.312802] RBP: ffffad8e80defc50 R08: 0000000000000005 R09:
> > 0000000000000018
> > > [    7.312804] R10: ffff938899d4a800 R11: ffff938891a9c800 R12:
> > 0000000000000034
> > > [    7.312806] R13: 0000000000000000 R14: ffffffffc02b150d R15:
> > fffffffffffffc90
> > > [    7.312808] FS:  0000000000000000(0000) GS:ffff938fb6600000(0000)
> > knlGS:0000000000000000
> > > [    7.312811] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    7.312813] CR2: 00007f540c94b710 CR3: 000000059502c000 CR4:
> > 0000000000f50ea0
> > > [    7.312815] PKRU: 55555554
> > > [    7.312817] Call Trace:
> > > [    7.312819]  <TASK>
> > > [    7.312822]  ? show_regs+0x69/0x80
> > > [    7.312827]  ? __warn+0x89/0x140
> > > [    7.312833]  ? __alloc_pages+0x329/0x340
> > > [    7.312837]  ? report_bug+0x15d/0x180
> > > [    7.312843]  ? handle_bug+0x42/0x80
> > > [    7.312848]  ? exc_invalid_op+0x1c/0x70
> > > [    7.312852]  ? asm_exc_invalid_op+0x1f/0x30
> > > [    7.312857]  ? cfg80211_scan_6ghz+0x12d/0xcb0 [cfg80211]
> > > [    7.312911]  ? __alloc_pages+0x329/0x340
> > > [    7.312916]  ? cfg80211_scan_6ghz+0x12d/0xcb0 [cfg80211]
> > > [    7.312968]  __kmalloc_large_node+0x7e/0x170
> > > [    7.312973]  __kmalloc+0xb9/0x120
> > > [    7.312976]  cfg80211_scan_6ghz+0x12d/0xcb0 [cfg80211]
> > > [    7.313028]  ? sched_clock_noinstr+0xd/0x20
> > > [    7.313034]  ? sched_clock_cpu+0x14/0x190
> > > [    7.313040]  ? raw_spin_rq_lock_nested+0x12/0x20
> > > [    7.313046]  ___cfg80211_scan_done+0x1e0/0x250 [cfg80211]
> > > [    7.313099]  __cfg80211_scan_done+0x23/0x30 [cfg80211]
> > > [    7.313153]  cfg80211_wiphy_work+0xae/0xd0 [cfg80211]
> > > [    7.313201]  process_one_work+0x1f1/0x3e0
> > > [    7.313204]  worker_thread+0x51/0x3f0
> > > [    7.313207]  ? _raw_spin_unlock_irqrestore+0x26/0x30
> > > [    7.313212]  ? __pfx_worker_thread+0x10/0x10
> > > [    7.313217]  kthread+0xdb/0x110
> > > [    7.313222]  ? __pfx_kthread+0x10/0x10
> > > [    7.313226]  ret_from_fork+0x3e/0x60
> > > [    7.313229]  ? __pfx_kthread+0x10/0x10
> > > [    7.313233]  ret_from_fork_asm+0x1b/0x30
> > > [    7.313237]  </TASK>
> > > [    7.313239] ---[ end trace 0000000000000000 ]---
> > 
> > See Bugzilla for the full thread.
> > 
> > Anyway, I'm adding it to regzbot to make sure it doesn't fall through cracks
> > unnoticed:
> > 
> > #regzbot introduced: v6.5-rc1..831fe284d82759
> > https://bugzilla.kernel.org/show_bug.cgi?id=217675
> > 
> > Thanks.
> > 
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217675
> > 
> > --
> > An old man doll... just what I always wanted! - Clara


