Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C327FEBC1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbjK3JVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3JVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:21:48 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F0A9D;
        Thu, 30 Nov 2023 01:21:54 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2243F40E0239;
        Thu, 30 Nov 2023 09:21:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4ubGk9wQ3yGk; Thu, 30 Nov 2023 09:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701336108; bh=GBEhqV+mubDB6FPJ/dMhpSO9uCBniobBE/30dBfoP1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y7vTyJUKfO/m/6Q05oNE0nB9e+JeuSZtvDdd4VcuQS6H/Dovit7G6zOnY0OAZUuYO
         AwHaDeBel8ETDgg7GkEjHZHm2z8oFtIrDy4fX6mGCMzPxPLixzAo2VDzeKQrvvGDdZ
         ujdIiH2ZJ9JAcOOHdrH7MSGf00cBDqAdy9SuyHho3ieqJx4YeW7HmEYtmTSJMVrj9m
         K4xrUrdS0itJGa+3M7P+LplIYYdJ8m6HcrT4sWEOdVDhm7DQ/K8yojEXFNS1+ga2Gg
         0QGB5elyo2cl7GuJA1lAUR/BjSSKXYzfGAVARKZVpy7nsRE1aTiWMC1OJH4Hjk5Tso
         RjpP5SX/03k1s4ugVQHC1w0F8kGSXBVrUmALO2WQtcOWDXoQCIAdQVKYWoY9z8UNvJ
         gbQkdhpqt1L7NwCLW6PHSNv22ZZpn6d/hgLJtDhcF/7TDXCPKXdeoZI0JoyHC5ZKsg
         qyPYoYMPrgKFp5Z500gSyfldAiDY1Jjrffk9TLBveLCgXCl0aKtCGkYCsNtQjStGye
         j9DVPpRk7oMAfkpSTTlpoQI9Z3i3rZBzxrkhGtQ629bfNs48IeoiPyzP+epNJroBGa
         PY3haMimJnzmwwhByWMLzvGDO+24grp0cmw3cOU5rn+/apnyobYq2VoL6HtG3MQ5Ls
         Vj3xyTFGSswpzlHhKquVYydo=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0394240E0030;
        Thu, 30 Nov 2023 09:21:23 +0000 (UTC)
Date:   Thu, 30 Nov 2023 10:21:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
        "cascardo@canonical.com" <cascardo@canonical.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Cui, Dexuan" <decui@microsoft.com>
Subject: Re: [PATCH v1 1/3] x86/tdx: Check for TDX partitioning during early
 TDX init
Message-ID: <20231130092119.GBZWhUD6LscxYOpxNl@fat_crate.local>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <0799b692-4b26-4e00-9cec-fdc4c929ea58@linux.microsoft.com>
 <20231129164049.GVZWdpkVlc8nUvl/jx@fat_crate.local>
 <DM8PR11MB575085570AF48AF4690986EDE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
 <20231130075559.GAZWhAD5ScHoxbbTxL@fat_crate.local>
 <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB575049E0C9F36001F0F374CEE782A@DM8PR11MB5750.namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:31:03AM +0000, Reshetova, Elena wrote:
> No threats whatsoever,

I don't mean you - others. :-)

> I just truly don=E2=80=99t know details of SEV architecture on this and=
 how it
> envisioned to operate under this nesting scenario.  I raised this
> point to see if we can build the common understanding on this. My
> personal understanding (please correct me) was that SEV would also
> allow different types of L2 guests, so I think we should be aligning
> on this.

Yes, makes sense. The only L2 thing I've heard of is some Azure setup.

> Yes, agree, so what are our options and overall strategy on this?  We
> can try to push as much as possible complexity into L1 VMM in this
> scenario to keep the guest kernel almost free from these sprinkling
> differences.

I like that angle. :)

> Afterall the L1 VMM can emulate whatever it wants for the guest.
> We can also see if there is a true need to add another virtualization
> abstraction here, i.e. "nested encrypted guest".

Yes, that too. I'm sceptical but there are use cases with that paravisor
thing and being able to run an unmodified guest, i.e., something like
a very old OS which no one develops anymore but customers simply can't
part ways with it for raisins.

> Any other options we should be considering as overall strategy?

The less the kernel knows about guests, the better, I'd say.

The other thing I'm missing most of the time is, people come with those
patches enabling this and that but nowhere does it say: "we would love
to have this because of this great idea we had" or "brings so much more
performance" or "amazing code quality imrpovement" or, or other great
reason.

Rather, it is "yeah, we do this and you should support it". Well, nope.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
