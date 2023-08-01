Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5676BD05
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjHASzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHASzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E772E65;
        Tue,  1 Aug 2023 11:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC9961690;
        Tue,  1 Aug 2023 18:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BF2C433C8;
        Tue,  1 Aug 2023 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690916116;
        bh=bDhchSFGotEKZjjNwty8B6gt0TByIrIari98LvQUM4w=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=VPrjzyiZoobIGkOYumxC/BNuw9IcAm8yQGxTVZzKs24x74uKP1uMxyTxjj9vgRFDY
         gbZZ2B+3VUVgYiTorVMji4xeviRe7KWOYhDNYOw3gqySkzHWYPn9UANaTest68ASl3
         0XgmAXG8gEZnsBm+uSRZy6JjYwOXwrWC9+g8UeZjn/DNCs+v1ZkJKpiJ1SAKIhpCTw
         KPH0hXWxqeMIhBEMsf32Gqzdr7pCqbZeuiuxh0mScMYVX9+kUHknyATzVWA5PpOeni
         KXlYMNOP3902NcnHARHR+caOOuLhruiiQ1xHiI1HBE1UT73BhdJZ5RYtY6ynT0W62B
         ysIDP+35ZEWTg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 01 Aug 2023 21:55:11 +0300
Message-Id: <CUHFQHNPO3PG.OKPKFTYYC8V9@suppilovahvero>
Cc:     <linux@dominikbrodowski.net>,
        "Daniil Stas" <daniil.stas@posteo.net>,
        <James.Bottomley@hansenpartnership.com>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <regressions@leemhuis.info>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com>
 <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <105b9d13-cedd-7d3c-1f29-2c65199f1de7@amd.com>
 <CAHk-=why64j-K4e1VxKwx7o6FiGjcXEnu1Pz+1QnNTBCv9AGyA@mail.gmail.com>
 <fd3cc87a-97ec-00ea-e480-f6597664c13a@amd.com>
 <CAHk-=whPvSJH=H9eHZbJQ+sxC-AVDvrgJ+M14fD3K5A+5s=zVA@mail.gmail.com>
 <CAHmME9r9DC+EMfxQy+HQAkf4AkAQnXNeBmOfCWnBUyiFQh2t6Q@mail.gmail.com>
 <61b363bc-286a-535c-27da-0f52673768ad@amd.com>
 <CUHFOCLWR4VO.OLBGKIXELSIN@suppilovahvero>
In-Reply-To: <CUHFOCLWR4VO.OLBGKIXELSIN@suppilovahvero>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 1, 2023 at 9:52 PM EEST, Jarkko Sakkinen wrote:
> On Tue Aug 1, 2023 at 6:04 AM EEST, Mario Limonciello wrote:
> > On 7/31/23 18:40, Jason A. Donenfeld wrote:
> > > Hi all,
> > >=20
> > > I've been tracking this issue with Mario on various threads and
> > > bugzilla for a while now. My suggestion over at bugzilla was to just
> > > disable all current AMD fTPMs by bumping the check for a major versio=
n
> > > number, so that the hardware people can reenable it i it's ever fixed=
,
> > > but only if this is something that the hardware people would actually
> > > respect. As I understand it, Mario was going to check into it and see=
.
> > > Failing that, yea, just disabling hwrng on fTPM seems like a fine
> > > enough thing to do.
> > >=20
> > > The reason I'm not too concerned about that is twofold:
> > > - Systems with fTPM all have RDRAND anyway, so there's no entropy pro=
blem.
> > > - fTPM *probably* uses the same random source as RDRAND -- the
> > > TRNG_OUT MMIO register -- so it's not really doing much more than wha=
t
> > > we already have available.
> >
> > Yeah I have conversations ongoing about this topic, but also I conclude=
d
> > your suspicion is correct.  They both get their values from the=20
> > integrated CCP HW IP.
> >
> > >=20
> > > So this all seems fine. And Jarkko's patch seems more or less the
> > > straight forward way of disabling it. But with that said, in order of
> > > priority, maybe we should first try these:
> > >=20
> > > 1) Adjust the version check to a major-place fTPM version that AMD's
> > > hardware team pinky swears will have this bug fixed. (Though, I can
> > > already imagine somebody on the list shouting, "we don't trust
> > > hardware teams to do anything with unreleased stuff!", which could be
> > > valid.)
> >
> > I find it very likely the actual root cause is similar to what Linus=20
> > suggested.  If that's the case I don't think the bug can be fixed
> > by just an fTPM fix but would rather require a BIOS fix.
> >
> > This to me strengthens the argument to either not register fTPM as RNG=
=20
> > in the first place or just use TPM for boot time entropy.
> >
> > > 2) Remove the version check, but add some other query to detect AMD
> > > fTPM vs realTPM, and ban fTPM.
> >
> > AMD doesn't make dTPMs, only fTPMs.  It's tempting to try to use=20
> > TPM2_PT_VENDOR_TPM_TYPE, but this actually is a vendor specific value.
> >
> > I don't see a reliable way in the spec to do this.
> >
> > > - Remove the version check, and just check for AMD; this is Jarrko's =
patch.
> >
> > I have a counter-proposal to Jarkko's patch attached.  This has two=20
> > notable changes:
> >
> > 1) It only disables RNG generation in the case of having RDRAND or RDSE=
ED.
> > 2) It also matches Intel PTT.
> >
> > I still do also think Linus' idea of TPMs only providing boot time=20
> > entropy is worth weighing out.
>
> You should add something like TPM_CHIP_HWRNG_DISABLED instead and
> set this in tpm_crb before calling tpm_chip_register().
>
> Nothing else concerning AMD hardware should be done in tpm-chip.c.
> It should only check TPM_CHIP_HWRNG_DISABLED in the beginning of
> tpm_add_hwrng().

In English: I think adding the function to tpm-chip.c was a really
bad idea in the first place, so let's revert that decisions and do
this correctly in tpm_crb.c.

BR, Jarkko
