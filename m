Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521A776855C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 15:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjG3M7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG3M7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:59:49 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452DF1B4;
        Sun, 30 Jul 2023 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690721985;
        bh=aTCP3UxCBeuVAEKl1+SX/+ZqLaEOkx9fzHoLqvvFSnE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rONyQaGdzkgGhN+1CWDh+MxFrfElh3sCp15EwQhA/gq3wMC0oZHCuzvR3VsMMpilE
         CDkd9swgyayuUxcW6S4B3PDeC0GkTf88/56ROo9S3ASkHwzUPw21xrRbzWeFngdomJ
         o/b2XJTuciMuzM9In7CH/mh1al5v3AW6bxGrrkFM=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 68A4B12817D7;
        Sun, 30 Jul 2023 08:59:45 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 3l-1yNjY9oIw; Sun, 30 Jul 2023 08:59:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1690721985;
        bh=aTCP3UxCBeuVAEKl1+SX/+ZqLaEOkx9fzHoLqvvFSnE=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rONyQaGdzkgGhN+1CWDh+MxFrfElh3sCp15EwQhA/gq3wMC0oZHCuzvR3VsMMpilE
         CDkd9swgyayuUxcW6S4B3PDeC0GkTf88/56ROo9S3ASkHwzUPw21xrRbzWeFngdomJ
         o/b2XJTuciMuzM9In7CH/mh1al5v3AW6bxGrrkFM=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id D9B6F1281747;
        Sun, 30 Jul 2023 08:59:43 -0400 (EDT)
Message-ID: <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dan Williams <dan.j.williams@intel.com>, dhowells@redhat.com
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Samuel Ortiz <sameo@rivosinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 30 Jul 2023 08:59:41 -0400
In-Reply-To: <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-07-29 at 21:56 -0700, Dan Williams wrote:
> James Bottomley wrote:
> > On Fri, 2023-07-28 at 12:30 -0700, Dan Williams wrote:
> > > The bulk of the justification for this patch kit is in "[PATCH
> > > 1/4] keys: Introduce tsm keys". The short summary is that the
> > > current approach of adding new char devs and new ioctls, for what
> > > amounts to the same functionality with minor formatting
> > > differences across vendors, is untenable. Common concepts and the
> > > community benefit from common infrastructure.
> > 
> > I agree with this, but ...
> > 
> > > Use Keys to build common infrastructure for confidential
> > > computing attestation report blobs, convert sevguest to use it
> > > (leaving the deprecation question alone for now), and pave the
> > > way for tdx-guest and the eventual risc-v equivalent to use it in
> > > lieu of new ioctls.
> > > 
> > > The sevguest conversion is only compile-tested.
> > > 
> > > This submission is To:David since he needs to sign-off on the
> > > idea of a new Keys type, the rest is up to the confidential-
> > > computing driver maintainers to adopt.
> > 
> > So why is this a keys subsystem thing?  The keys in question cannot
> > be used to do any key operations.  It looks like a transport layer
> > for attestation reports rather than anything key like.
> 
> Yes, it has ended up as just a transport layer.
> 
> > To give an analogy with the TPM: We do have a TPM interface to keys
> > because it can be used for things like sealing (TPM stores a
> > symmetric key) and even asymmetric operations (although TPM key
> > support for that in 1.2 was just removed).  However, in direct
> > analogy with confidential computing: the TPM does have an
> > attestation interface: TPM2_Quote and TPM2_Certify (among others)
> > which is deliberately *not* wired in to the keys subsystem because
> > the outputs are intended for external verifiers.
> > 
> > If the goal is to unify the interface for transporting attestation
> > reports, why not pull the attestation ioctls out of sevguest into
> > something common?
> 
> That's fair. I originally started out with a draft trusted-keys
> implementation, but abandoned it because that really wants a vTPM
> backend. There is no kernel consumer for attestation reports like
> other key blobs, so that leaves either a key-type that is just a
> transport layer or a new ABI.
>  
> I have a personal distaste for ioctls and the presence of user-
> defined blobs in the Keyring subsystem made me think "why not just
> have a key-type to convey the per-TSM attestation reports". Is that a
> fair observation?

The trouble with this argument is that it's an argument for every new
ioctl becoming a key type.  We have a ton of interfaces for
transporting information across the kernel to user boundary: sysfs,
filesystem, configfs, debugfs, etc ... although to be fair the
fashionably acceptable one does seem to change each year.  Since
there's nothing really transactional about this, what about a simple
sysfs one?  You echo in the nonce to a binary attribute and cat the
report.  Any additional stuff, like the cert chain, can appear as
additional attributes?


> An ioctl interface would make sense for a common report format, but
> the presence of per-TSM options and per-TSM format modifiers (like
> SEV privilege level and "extended" attestation reports) attracted me
> to the ability to just have "options" specified at report
> instantiation time.

The "extended" report is nothing but a way of getting the signing key
cert chain.  It's really just a glorified caching mechanism to relieve
the relying party from the job of doing the lookup themselves.

> I.e. like the options specified to trusted-key instantiation.
> 
> > I also don't see in your interface where the nonce goes?  Most
> > attestation reports combine the report output with a user supplied
> > nonce which gets added to the report signature to defend against
> > replay.
> 
> The user supplied data is another argument to instantiate the report
> blob. The instantiation format is:
> 
>     auth <ascii hex blob user data> [options]
> 
> ...for example:
> 
>     # dd if=/dev/urandom of=pubkey bs=1 count=64
>     # keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey)
> privlevel=2" @u
> 
> > Finally, I can see the logic in using this to do key release,
> > because the external relying entity usually wishes to transport
> > secrets into the enclave, but the currently developing use case for
> > that seems to be to use a confidential guest vTPM because then we
> > can use the existing TPM disk key interfaces.  Inventing something
> > completely new isn't going to fly because all consumers have to be
> > updated to use it (even though keys is a common interface, using
> > key payloads isn't ... plus the systemd TPM disk encryption key
> > doesn't even use kernel keys, it unwraps in userspace).
> 
> I do think the eventual vTPM enabling is separate from this and I
> mention that in the changelogs.

vTPM requires no enabling: it will just work with the existing trusted
key interface.

>  That functionality like SNP_GET_DERIVED_KEY is amenable to a
> trusted-keys frontend and being unified with existing TPM paths.

To get a bit off topic, I'm not sure derived keys are much use.  The
problem is in SNP that by the time the PSP does the derivation, the key
is both tied to the physical system and derived from a measurement too
general to differentiate between VM images (so one VM could read
another VMs stored secrets).

> 
> This report interface on the other hand just needs a single ABI to
> retrieve all these vendor formats (until industry standardization
> steps in) and it needs to be flexible (within reason) for all the
> TSM-specific options to be conveyed. I do not trust my ioctl ABI
> minefield avoidance skills to get that right. Key blob instantiation
> feels up to the task.

To repeat: there's nothing keylike about it.

If you think that the keyctl mechanism for transporting information
across the kernel boundary should be generalised and presented as an
alternative to our fashion of the year interface for this, then that's
what you should do (and, I'm afraid to add, cc all the other
opinionated people who've also produced the flavour of the year
interfaces).  Sneaking it in as a one-off is the wrong way to proceed
on something like this.

James


