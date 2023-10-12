Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A23E7C6733
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377868AbjJLH3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377849AbjJLH3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:29:44 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC767D3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 00:29:42 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D052440E01AE;
        Thu, 12 Oct 2023 07:29:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Oyqu-lllMva7; Thu, 12 Oct 2023 07:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697095778; bh=2NqQontp5OGh2GXQzQHUNLMzIshcTNJxH9fIiMGZaBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyvR1/dvebLsCCu7oXShN9kHyemFXdzEtiWjiygj4KRXz5Gv3mc06PicVmaN2y+07
         w558y7aToaJ5g7lVsHhfmbPnl8pe0A8NVhHz/eS69sbHRLcyRodyUdez6+XxqqBpBi
         kyRrADFWK4a9gykS5T9hLAqQzgpv16h7ILwEECMPyoglwl87c4HtFIWLTL3jXNWDov
         vsJ/H+l1Zgo3AEmZWHZTWHepHGaXcSDkRyasoo/dLxepx/XkW2ojdj6I2JhYP5o0Jb
         V92D0bJboenJW19hdPXpfBSfcYY2q02n5pJCczPSWdQnRThM03g6uTX9NojvMo5ZvF
         E1dFXl8PUUJw+A1WL4Il6scT4jYaZ2JR4aL5w/dR8GjVWeYteYAEmgPNIr4nlROIv5
         jmhVzSB6uMENVLvf0BUnKELk0p0BBMlrA8Vi6wsvUFImWVWdR778ChDko2q6NtBYs3
         dya9pZIQp1SzHWRDHfAsFEj/y8EiuWA4uzdDnyRmHIa92ZRk7jnOPXtChXv0MeKSPc
         j6N2Q1TlEckVI5VDJk4syUN6y4xiV9QLDpp9e5LDmEsg5hHE55TFkQI232YbaOTiL1
         05NgKL3cCiNO9up5A4NcN1886r1gYmv2j0StffhDwZxzAjk8KNsNKrgCSxAwIh5I3S
         mMo5o4EYkeG84BCSS0/oXLxM=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E786340E0196;
        Thu, 12 Oct 2023 07:29:26 +0000 (UTC)
Date:   Thu, 12 Oct 2023 09:29:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, leit@meta.com,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/bugs: Add a separate config for each mitigation
Message-ID: <20231012072920.GAZSegUJkwHbcernQo@fat_crate.local>
References: <20231010103028.4192223-1-leitao@debian.org>
 <20231011044252.42bplzjsam3qsasz@treble>
 <20231011190317.GDZSbxdd5TuCIp5+JN@fat_crate.local>
 <20231011220325.5uje4xnfxuccumm7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011220325.5uje4xnfxuccumm7@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 03:03:25PM -0700, Josh Poimboeuf wrote:
> I wouldn't call it senseless churn.  There are concrete benefits -- for
> both users and developers -- of having all the mitigation config options
> living in the same config namespace.

I don't see it. What does the same namespace give you? So you see in the
code a bunch of ifdeffery and some or all of them have
CONFIG_MITIGATION_ prepended. To me it doesn't matter whether they're
mitigations or not - it is just the next Kconfig symbol.

> Sure, the change might cause pain for users who disable these options,
> but do those users actually exist?

Apparently there are use cases where people simply want to disable all
that mitigation crap because they want their performance back. This
thread being one. And I know of another one with a similar sentiment.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
