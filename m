Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E77B784A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241472AbjJDHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbjJDHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:01:22 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6240AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:01:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 051C840E01AE;
        Wed,  4 Oct 2023 07:01:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RIDc3lHE68r0; Wed,  4 Oct 2023 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696402874; bh=bsHdMgmkYQMK2TFiy3Hx4BW+BGLq8oQTxKGgK6wIGjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YNnDMW/syvY4FQeiBdoAYjYaoTBSzrb6Qeveo3rQF+rMz3YPLtLI3+9IjoeQFVqjK
         l4H/MUltLUruTaYYwM9ysD+JgX++w/T01987eavgSDPuRmnQ4p4z6AkGfIHakU+wvP
         XXd5qZQ1QeK92vcDlItj0EvAhsWu4C0c6GF+Kz1OOut/B2mejimGUriL45JZmy1mpl
         DplQZu71YJygfLoym6xagZCqd6un7fOqwY1uTm0fWOoJaRUaTGXYrECjaqKsSSUK2T
         wkD72NGzG/WsSL5ZKCjprg0sNxgtLiGyHVdMgTDKFmEniOb22XqxUTojcu3cjG3XvT
         x8hLcbbdKUQiDM0cVW1RqYfyJa2WDilSp/NBkDLp9RsyxOUR1qzq69mDe9CwgVpfrZ
         Sfo7lmqA0xT5ui7JSCmYY+hrJmj6WAgVDJkW6LJ8+16ZLeRNkTZnGI5s7dSVjyHRjU
         L4bfOGDpmtGm9FoAfg0L2my9UiuhNlB8jjXTFEDqAsnsYTvdnSfFEz2dc8Jhzr5O4M
         /Oj+uqTY2efr0zXcdOUevgkNxnfkHXiW1MjAgs0y7qWV/sl7cptiIrbmRqbKgE5fPC
         xm+BR5LT5TO/U38m2z94eBEfbs4U04ZJG3Dqlga2VfoV5XcUpmp1i99jgUPzHFD0JW
         c0dpHugDDiajnhCgyo/VAUIE=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E6F840E0176;
        Wed,  4 Oct 2023 07:01:06 +0000 (UTC)
Date:   Wed, 4 Oct 2023 09:01:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Nikunj A. Dadhania" <nikunj@amd.com>
Cc:     thomas.lendacky@amd.com, x86@kernel.org, dionnaglaze@google.com,
        pgonda@google.com, seanjc@google.com, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] Add Secure TSC support for SNP guests
Message-ID: <20231004070100.GAZR0NrFSIDKPSQIjA@fat_crate.local>
References: <20230814055222.1056404-1-nikunj@amd.com>
 <f200403b-c460-5ebb-fec5-c5caf0cdb006@amd.com>
 <9a6af215-e696-5091-69fa-1cbebe772471@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a6af215-e696-5091-69fa-1cbebe772471@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:05:14AM +0530, Nikunj A. Dadhania wrote:
> On 8/28/2023 9:17 AM, Nikunj A. Dadhania wrote:
> > On 8/14/2023 11:22 AM, Nikunj A Dadhania wrote:
> >> Secure TSC allows guests to securely use RDTSC/RDTSCP instructions as the
> >> parameters being used cannot be changed by hypervisor once the guest is
> >> launched. More details in the AMD64 APM Vol 2, Section "Secure TSC".
> >>
> ...
> >>
> >> Changelog:
> >> ----------
> >> v4:
> >> * Drop handle_guest_request() and handle_guest_request_ext()
> >> * Drop NULL check for key
> >> * Corrected commit subject
> >> * Added Reviewed-by from Tom
> > 
> > A gentle reminder.
> 
> 
> Ping ?

Pong.

How about you find other SEV patches on LKML which are waiting for
review and review them, while waiting for yours?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
