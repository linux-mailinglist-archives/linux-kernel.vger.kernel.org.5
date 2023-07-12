Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A275119C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGLUBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGLUBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:01:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AFB1FE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:01:34 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 228F31EC0CEB;
        Wed, 12 Jul 2023 22:01:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689192093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RBf/VRQY6ZYlffHqzHNozjMXb6SDfRecdeWe0WcrEkU=;
        b=FFRboVNh6wZg9hAF+ccWr86fW5rE3LE2cNX3OO1de/7erHzDY8QyVefD7p799fiw34oht6
        lppj0h5Z6bMmZmI7MnEZ0Uhu3umyEmbE+XH3Qhk/yuCh1QFpprB4e3YNDTQ+em4wLOAHxu
        ILqDTE7o/dA5CzAQTZzjsT7lBIsX35k=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8QmG1JM-9gEa; Wed, 12 Jul 2023 20:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689192089; bh=RBf/VRQY6ZYlffHqzHNozjMXb6SDfRecdeWe0WcrEkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HEr+MirJzHKzFXI1mQG6Ry65rGNS7wqBV6eTa8kZm7/XqOu7eTz4WmtXBKg5ryuSN
         tBZFAMJ4FhZ/cI6sXPropy5FkK//KBhTixc+VhackFzURKOXDJnQCI9cRPvuwOEsUI
         qNlCprJV2zQaUofnQM+8w/9bLL676Ek4g1vIhUSGeXPcD+qoYJmadPULXB+OH2GC4a
         MQnMKm661VbeFwGadR6JYEcGcobtMDRs87u2pUnOP1G1tcq67QeKzjqPQMrkZ4ZNlf
         LoXerREteVCQZqlEQFYKZK1mTwdZZf5Xuy2DGZC8qR0Dqa6aS1Xf+HqyJYFCn4DoZG
         yriUYVQidbhrDH+zlB+DiA41I6fo+nzeGyGORF1XEl/t8lxScjYPfffQ7f4zTFjfRD
         g52GJ2P/c8FMytOhjYwRGo/1iH/rogYtTU0pNNm3FvIMREW8WXfkv9q589smIyWiqc
         eKYB5tfzkDAeVG1kdNq31/GJQO3BkR4goxQEZZXtFvl23DHBS05MhnI/QsahKwl9gW
         85/X0D3/xUCv9KmpHq052Y+c7dKcOa9I9pVXEOIgPPsBxEsN0OTfYO7ve4GYW6T0OP
         kY0UPlSkkes8qPkfWUe4n1H+cpH3EUtcwv+R4J/qpqgRe1n+a/K+arNQYmHaBNmbo8
         vPjblgPQs7EEFnRI8dz5b5MY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8086440E01A4;
        Wed, 12 Jul 2023 20:01:13 +0000 (UTC)
Date:   Wed, 12 Jul 2023 22:01:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, lennart@poettering.net,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] x86/boot: add .sbat section to the bzImage
Message-ID: <20230712200108.GOZK8GhJTkpuIDI4Rg@fat_crate.local>
References: <20230712132840.GKZK6qiK70m1O90jFL@fat_crate.local>
 <ZK6zdsIbnQFUmK69@redhat.com>
 <2023071200-unopposed-unbuckled-cde8@gregkh>
 <CAMw=ZnTVRaqRmtz+sDj7AeAS7xivSu+56UgKbzmuW9+K6TTx1A@mail.gmail.com>
 <2023071239-progress-molasses-3b3d@gregkh>
 <CAMw=ZnRheXk7W_r-32bGymbHKdXc7aKUpwGAOX+k7DJkN+DiCQ@mail.gmail.com>
 <2023071229-dusk-repacking-da3a@gregkh>
 <CAMw=ZnSmZTBs+bJsQ_Y2CVO8K3OTuHOZDKW4cbxKpGbo4Vgs7Q@mail.gmail.com>
 <20230712194202.GNZK8CCj4yacgFMgfB@fat_crate.local>
 <CAMw=ZnSa-NqfbEd9vchEwHwdUujNAXo=gb3dfd=HDw4W37RNjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMw=ZnSa-NqfbEd9vchEwHwdUujNAXo=gb3dfd=HDw4W37RNjQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:56:36PM +0100, Luca Boccassi wrote:
> Everything < 3 is revoked _and_ the generation id in the stable branch
> is _not_ bumped, because it's still vulnerable and so that branch is
> effectively dead and unbootable on any system with secure boot
> enabled. This is a revocation mechanism, not a bug tracking mechanism.
> There's no mix-and-matching.

No, this is a mess waiting to happen.

> Nah, it belongs in both places. Please read the documentation and
> spend at least some time trying to understand the actual problem being

You want to have this patch in the tree - the commit message should
explain why it is needed and not point to some documentation somewhere.

> solved before commenting - or don't comment at all, that's fine too.

Here's a comment for ya:

Naked-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
