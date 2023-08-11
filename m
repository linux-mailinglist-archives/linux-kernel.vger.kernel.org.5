Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20065779662
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbjHKRoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjHKRoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:44:14 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3765BEA
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:44:14 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-586a5ac5c29so26337637b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691775853; x=1692380653;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5tf/etP9591sBoXXP0u0lhmE2sGhQYCIj4rXej+PgY=;
        b=z4avZMYBxF/USDP2G14KA+P8N8yreov1u2JOHwfc1TVZdl6Iz+YTKH19wDx7mUMq9M
         o4u6qon1QiMk8DVxh93qeN2Mz6fZGsUFtzOg33bB4Mo7KFsOypRjJRdzz9Y8WFCiY85q
         br+fPgBO/on1YU5soxnymBtm9OPZyICHaFKZfYSg9Ropko2mo0wKLVwIok1lVrWFw51i
         jjhtl/HK+nEz+jNhJe7imTF+VBA6+NGFZjFm7+hHqXCkfP3+rYY1oaYSypJ0v6009kFT
         lq7bEwknPOhWjDhET6YMFrJ/3n1YTZ5hf1bP/IHZB/5/XDyHPzuDGnqfF1kEhe1cc6AD
         1nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775853; x=1692380653;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y5tf/etP9591sBoXXP0u0lhmE2sGhQYCIj4rXej+PgY=;
        b=iwV8MX761MqgvpC9J8Qw3+TatAY6x0xmF2L8WI4vi8Dn++e7OyJpiZupZ+Ek9e4Jyr
         XoF2GT7Z/qR6Kn1EzacaxtzBaichs6/i1ULn/m+JgMqbfvBdbeZjVTPGTx6p2EIbZ2KQ
         MOWrtG6n2jZ9/0uncy21lzmdgIa9nuheRZmWl81BPOb17SfBnO0DAXTlUKfBidl2BAcU
         zSh5TzOzWZjjA2Ad2dXW2SDqNvAeHdOfLdDp0STh/xIdzD0CxtRQrjNV6uFzzEUOlWs8
         o2Pz+CIu0I9EOYww6u1QpoCcrPZsPdaBrC0JzsGud0fD15mxBLGUYMfhxqsiJ4e0tbKH
         O3vA==
X-Gm-Message-State: AOJu0Yz/kMmonwABO+o4aSn3D0placpJAQEAZVFnWy68pzB1yLoLolEY
        +IRbFeIX9h6lZv6z+kqCZO3BKJ/BeHg=
X-Google-Smtp-Source: AGHT+IFlh+eXwF8rMcD2luIRCX1nl8Idt0F+6stO6hsWWfidj415wHUgqoJc8kVAwNGB8y2mQW1tGjk2lPA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:7443:0:b0:d20:7752:e384 with SMTP id
 p64-20020a257443000000b00d207752e384mr41859ybc.3.1691775853469; Fri, 11 Aug
 2023 10:44:13 -0700 (PDT)
Date:   Fri, 11 Aug 2023 10:44:11 -0700
In-Reply-To: <CAGtprH9YE50RtqhW-U+wK0Vv6aKfqqtOPn8q4s8or=UZwPXZoA@mail.gmail.com>
Mime-Version: 1.0
References: <20230718234512.1690985-13-seanjc@google.com> <diqzv8dq3116.fsf@ackerleytng-ctop.c.googlers.com>
 <ZNKv9ul2I7A4V7IF@google.com> <CAGtprH9YE50RtqhW-U+wK0Vv6aKfqqtOPn8q4s8or=UZwPXZoA@mail.gmail.com>
Message-ID: <ZNZza/emWldkJC6X@google.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
From:   Sean Christopherson <seanjc@google.com>
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     Ackerley Tng <ackerleytng@google.com>, pbonzini@redhat.com,
        maz@kernel.org, oliver.upton@linux.dev, chenhuacai@kernel.org,
        mpe@ellerman.id.au, anup@brainfault.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, willy@infradead.org,
        akpm@linux-foundation.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, chao.p.peng@linux.intel.com,
        tabba@google.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com,
        mail@maciej.szmigiero.name, vbabka@suse.cz, david@redhat.com,
        qperret@google.com, michael.roth@amd.com, wei.w.wang@intel.com,
        liam.merwick@oracle.com, isaku.yamahata@gmail.com,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023, Vishal Annapurve wrote:
> On Tue, Aug 8, 2023 at 2:13=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > ...
>=20
> > > + When binding a memslot to the file, if a kvm pointer exists, it mus=
t
> > >   be the same kvm as the one in this binding
> > > + When the binding to the last memslot is removed from a file, NULL t=
he
> > >   kvm pointer.
> >
> > Nullifying the KVM pointer isn't sufficient, because without additional=
 actions
> > userspace could extract data from a VM by deleting its memslots and the=
n binding
> > the guest_memfd to an attacker controlled VM.  Or more likely with TDX =
and SNP,
> > induce badness by coercing KVM into mapping memory into a guest with th=
e wrong
> > ASID/HKID.
> >
>=20
> TDX/SNP have mechanisms i.e. PAMT/RMP tables to ensure that the same
> memory is not assigned to two different VMs.

One of the main reasons we pivoted away from using a flag in "struct page" =
to
indicate that a page was private was so that KVM could enforce 1:1 VM:page =
ownership
*without* relying on hardware.

And FWIW, the PAMT provides no protection in this specific case because KVM=
 does
TDH.MEM.PAGE.REMOVE when zapping S-EPT entries, and that marks the page cle=
ar in
the PAMT.  The danger there is that physical memory is still encrypted with=
 the
guest's HKID, and so mapping the memory into a different VM, which might no=
t be
a TDX guest!, could lead to corruption and/or poison #MCs.

The HKID issues wouldn't be a problem if v15 is merged as-is, because zappi=
ng
S-EPT entries also fully purges and reclaims the page, but as we discussed =
in
one of the many threads, reclaiming physical memory should be tied to the i=
node,
i.e. to memory truly being freed, and not to S-EPTs being zapped.  And ther=
e is
a very good reason for wanting to do that, as it allows KVM to do the expen=
sive
cache flush + clear outside of mmu_lock.

> Deleting memslots should also clear out the contents of the memory as the=
 EPT
> tables will be zapped in the process

No, deleting a memslot should not clear memory.  As I said in my previous r=
esponse,
the fact that zapping S-EPT entries is destructive is a limitiation of TDX,=
 not a
feature we want to apply to other VM types.  And that's not even a fundamen=
tal
property of TDX, e.g. TDX could remove the limitation, at the cost of consu=
ming
quite a bit more memory, by tracking the exact owner by HKID in the PAMT an=
d
decoupling S-EPT entries from page ownership.

Or in theory, KVM could workaround the limitation by only doing TDH.MEM.RAN=
GE.BLOCK
when zapping S-EPTs.  Hmm, that might actually be worth looking at.

> and the host will reclaim the memory.

There are no guarantees that the host will reclaim the memory.  E.g. QEMU w=
ill
delete and re-create memslots for "regular" VMs when emulating option ROMs.=
  Even
if that use case is nonsensical for confidential VMs (and it probably is no=
nsensical),
I don't want to define KVM's ABI based on what we *think* userspace will do=
.
