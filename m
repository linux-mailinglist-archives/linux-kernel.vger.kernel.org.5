Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E57773FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjHHQyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbjHHQxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:53:51 -0400
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 08:58:49 PDT
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1BB4FB11;
        Tue,  8 Aug 2023 08:58:49 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8E93040E01A7;
        Tue,  8 Aug 2023 15:58:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6Xj84UAznqw9; Tue,  8 Aug 2023 15:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691510293; bh=DCkALUn2a0fRPRuE1oEWiAP6SlTKCTfiUiAf37W0FBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKap3it59CcLf6kyeH9uTtkNrsK6AkvlvneSS9U51eiKy2h32T+0Chyu79W6SgQxY
         bcvKjf6cHRFCNRr8tbKHfffuu74JIXxzgpslxJBOBH5Kb3sKtXBQuqmCSZq8+Sc72M
         JIxutB7g4UtC6hs792WKljoOzTwfqcKriyEQN2h7ad4BGrhWbdBtS/4G6Z34YiWVHb
         tZfSlWzS4gct1YoYzpJYJBm7npRBloxqzrxw1/9JY84yGtGKyU/t+t3XeNIheHYcX4
         dZkkpfBbC0qUD9bghD06lPLNcJnk3QmY3V6S2WyaCFqKY8LeKXl+aSvePF5yetFucp
         TDr3Rb4rpCbCTHpLbA9oc474ZeXkdAYGjEuZj9/3edI24boQ1wNMJfJmW4k6eRI76X
         2gXdn8jPGWvG59Oyldz6p0m18WZkWD7IqH81aR9B3OvoUdgIl24krapeIIL+GoQymn
         JHn8kXJrrhTktKr7C3Bp7BPWrfhN5AApwAMVFDyrkXC3nTN7bT79wkNx6zVBk6tpAA
         EVaj8nm4UXi5vmNZZ0kqUecXoq6W/yfdXWHkx6Jhev8XrHfxj1TTDfbwd4rBUuttJN
         evTbM6zCavGG41TqtGfuER8Xh5y3GYcZ6ufBcjlFzIEePX6YyIfNZs+J9emuOE1mhC
         VVv6A8HS/9BM7YI1ncpW2JL0=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D5BC40E01A4;
        Tue,  8 Aug 2023 15:58:04 +0000 (UTC)
Date:   Tue, 8 Aug 2023 17:58:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-edac@vger.kernel.org, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH 1/2] platform/x86/amd: Introduce AMD Address Translation
 Library
Message-ID: <20230808155803.GFZNJmCx15MGlDPVkp@fat_crate.local>
References: <20230802185504.606855-1-yazen.ghannam@amd.com>
 <20230802185504.606855-2-yazen.ghannam@amd.com>
 <58934edf-4fad-48e0-bc5d-62712b11e607@amd.com>
 <894b3737-1a0a-4139-9c73-686a95481795@amd.com>
 <B3BE6B56-FBAB-4878-A45D-E95AFAC86AB1@alien8.de>
 <f989cd56-a066-409a-8d82-40d0bc6ff89b@amd.com>
 <20230808142007.GCZNJPFy8PqTJgTAN5@fat_crate.local>
 <a62282e0-3784-4d96-b632-fdd6d2627ca3@amd.com>
 <20230808143735.GDZNJTL0DlJd3225db@fat_crate.local>
 <b5609e88-2bdb-44ad-8a3a-b61196ee540a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5609e88-2bdb-44ad-8a3a-b61196ee540a@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 11:18:07AM -0400, Yazen Ghannam wrote:
> I think it would be better to avoid dependencies between independent things.

If they really are independent then I guess. Not that it all ends up in
a twisty dependency where you wish you should've merged the two
together. So think about all deps before you design this - it needs to
handle all cases without hackery.

> For example, amd_smn_read() is mostly used in amd64_edac. EDAC was the
> original user of SMN accesses, and all the SMN stuff could have been
> included in EDAC. However, SMN is not specifically for EDAC, so it was added
> to amd_nb.c to be commonly available. Currently, SMN accesses are done in
> other modules. I don't think it would have been a good idea to force other
> modules or subsystems to require EDAC to be used.

What does that have to do with this? SMN access is generic and should be
in amd_nb.c as it is needed by other stuff. EDAC, RAS, whatever are all
users of that thing.

> This is my reasoning for a separate, independent module for the translation.
> EDAC is the first user of this. But there will be future code that can
> leverage this, like CXL, and even the MCE subsystem. And, yes, mce_amd may
> be already loaded, but this isn't a given. A person may want MCE and CXL
> support without wanting to use EDAC.

Is that a real use case or just a hypothetical thing?

> Furthermore, some things using the translation will be built-in, so the
> translation module will need to be built-in.

This sounds weird.

> I agree. And I don't think much of the existing things in EDAC should be
> moved out. But this is new code, so there's an opportunity to have it in a
> more appropriate place.
>
> And, thinking on it more, this could be another example for future "common
> RAS" functionality. Isn't that why the CEC is in drivers/ras?

It is there because it doesn't need EDAC at all. If your translation
doesn't need EDAC and EDAC is going to be only a user of it, then good.

But if you're going to have to need the MCA error decoded by EDAC and
then the error translation done by this thing, then you'd need to
synchronize between the two. I'm not saying it is impossible - it should
be well thought out first though before you go coding.

> It seems like things go into EDAC because it's thought of as the de
> facto RAS location.  But why have something in EDAC if it doesn't
> provide EDAC functionality?  Other RAS things, like AER, APEI, etc.,
> don't live in EDAC.

AER is part of PCI so we haven't considereed tying it into EDAC. And
there wasn't any desire to do so.

As to APEI, there's ghes_edac...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
