Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B0375C4A3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjGUK0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjGUK0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:26:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C220B110
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689935195; x=1721471195;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3la85cW8/KmPX/dcr+1vrlAz048TD7nuQ3LGUmKvcgY=;
  b=j1+YUq2LPho4nrLGXxng4EoR63KcTL5syNtDIgNc1tu7VCfd0hbyZduQ
   gSUONHn7d1o+JCAHrYEXJ89JlmZZ0AeN4G3Zi2PFrdkhiBoVX6tITPfKg
   oLWCU7sTTAzdjld2V6JYvTvIKyKpvCn4yAm3Xii69g6y4OyO/IFrBJXq0
   YUNcXDF0LKAtKewUhux++X7lxK8a/u3xyZzzTw+PS8RMO24Wnt8LXsb5b
   /2aI6p7VrnFv0wHUMGkUKzer1SbKzHOk3gUqkIk7LgMUriKx8ZMGPRbDd
   +cyhl2oPM7/riHealI7eapSihH0egwscnu6LkH14BBSnu/B+AWpQYiDzx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="369664217"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="369664217"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="971398246"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="971398246"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:26:33 -0700
Date:   Fri, 21 Jul 2023 13:23:07 +0300 (EEST)
From:   Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To:     Racinglee <cydiaimpactor2003@gmail.com>
cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux ALSA Development <alsa-devel@alsa-project.org>
Subject: Re: 6.4 and higher causes audio distortion
In-Reply-To: <CAL4Djy3KeD51LtT0bT2aRe9S_uwMiAfa-X=V2SfdnYt-MYp5ng@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2307211322100.3532114@eliteleevi.tm.intel.com>
References: <3ee79b53-5c1b-1542-ceea-e51141e3ab74@gmail.com> <CAL4Djy3KeD51LtT0bT2aRe9S_uwMiAfa-X=V2SfdnYt-MYp5ng@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-318106570-2107917860-1689934996=:3532114"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---318106570-2107917860-1689934996=:3532114
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,


On Wed, 19 Jul 2023, Racinglee wrote:

> On Sat, Jul 15, 2023 at 3:56 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >
> > > I have a Lenovo ThinkPad X1 Yoga Gen 7 running Arch Linux. Linux 6.4 
> > > and higher, cause audio distortion. Sometimes, this occurs to the 
> > > point that nearly nothing is discernible. This carries over to wired 
> > > headphones. The issue occurs on the entire mainline 6.4.x kernel 
> > > series and also the 6.4.3 stable and 6.5 RC1 kernel, which are the 
> > > latest at the time of writing. The issue occurs on both the Arch 
> > > distributed kernels, and the mainline kernels.
[...]
> Updating regzbot after newer findings and determinations about the
> possible culprit commit
> 
> #regzbot title: 6.4 and higher causes audio distortion
> 
> #regzbot introduced: v6.4-rc1..1bf83fa6654c
> https://bugzilla.kernel.org/show_bug.cgi?id=217673#c5
> 

thank you, filed a bug to SOF based on the bisect results:
https://github.com/thesofproject/linux/issues/4482

Br, Kai
---318106570-2107917860-1689934996=:3532114--
