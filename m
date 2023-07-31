Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E9276A022
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjGaSPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGaSPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:15:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE43173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:15:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb0336ed4fso383e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690827306; x=1691432106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfc0ZrNLA6zQl3jaRXfzTrubuX7/0gu0ECzNsItyn3s=;
        b=rflr9XU4TwpyGletRVo4NimWyo2UCf84AdoV59Cui+4WYFUSc8IRXD9kNZDxNZI876
         hUccfdI01rYK+sk6J4XI7fZ/VtEaHRFxAIpSZozWDs+CEJjhPRq98lC7l19q9JynRN5r
         t0wx6gPCinx1jze49scE3qk8gVhKHW1h+1dfoBbg+KSQNWpuSKTN0AtfrkGgiZIGMycd
         f6roAEH2/N+AXALG0D+DuCMqQKODiBYdywPiJ2l5fRR8kgyMFmAiZUVneIR84icsyqrG
         oHPhr6w9b9w2ild1PDnm3K42fSySVK2fX5vm4KrS+fIkZA3LDV6N3oZM0g07kw0KEZbV
         My+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827306; x=1691432106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nfc0ZrNLA6zQl3jaRXfzTrubuX7/0gu0ECzNsItyn3s=;
        b=HoaYGr/2xDFKwqnn2Jz+lVEXfoGMPMtNtb8vXAKBDewU3Rhwdf7Sm0rv5w2jo5kdDI
         SvakBPbIfJ4pqOMyiF8QCLDPYMzJGxFhZT9zln5l4OKCjfay26pIfoixbSaHn0Jmlmc3
         dlAZA7L1H2V2v8cUlbpBsMykioSCA7hKTkAc9ksZrL0G1o02SUKCDvTNBMQDNvyCgnYn
         OQGu/dYMS8tYxndouB6xFuWXX5jLyHS7IpHQIxQ+JBb2U9lrZVpHdMoPppFPkwj+/0Fg
         kgwEzTmPvKCf+qxYWyk9VQRsQRca7+JIJOEhtMDjsdDE+eWR8kN6zZZSrOdacC4yP1bl
         8Dwg==
X-Gm-Message-State: ABy/qLYOubiRtjz7+ZHLVm0Hu56V94mNiM0YFK1H1JwWvt0gWa4EM4mz
        +y7papYFEBReV5LKSOFZTHeRUXEJamlhLjHXrQpm0Q==
X-Google-Smtp-Source: APBJJlHzPYEsPQoGZKBGcISLmxg9T7aK4UcTE4EP23HAK2IrWsravftS+ON20zsFnwee/ESQbfAlUdc2VO9z+Hy1Hxw=
X-Received: by 2002:a19:a40a:0:b0:4fd:eb37:7980 with SMTP id
 q10-20020a19a40a000000b004fdeb377980mr116355lfc.1.1690827306097; Mon, 31 Jul
 2023 11:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
 <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com> <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <64c7f3df475d5_51ad02943f@dwillia2-xfh.jf.intel.com.notmuch>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 31 Jul 2023 12:14:54 -0600
Message-ID: <CAMkAt6p9yEM7A5B9TyZsVTH=X=UQ3Z9wfYDg9etuc806mNdOiQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] keys: Introduce tsm keys
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dhowells@redhat.com,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-coco@lists.linux.dev, keyrings@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:48=E2=80=AFAM Dan Williams <dan.j.williams@intel=
.com> wrote:
>
> Peter Gonda wrote:
> > On Fri, Jul 28, 2023 at 1:31=E2=80=AFPM Dan Williams <dan.j.williams@in=
tel.com> wrote:
> > >
> > > One of the common operations of a TSM (Trusted Security Module) is to
> > > provide a way for a TVM (confidential computing guest execution
> > > environment) to take a measurement of its run state and use that with=
 a
> > > key-exchange protocol to establish a shared secret with a third-party=
 /
> > > remote attestation agent. The concept is common across TSMs, but the
> > > implementations are unfortunately vendor specific. While the industry
> > > grapples with a common definition of this attestation format [1], Lin=
ux
> > > need not make this problem worse by defining a new ABI per TSM that
> > > wants to perform a similar operation. The current momentum has been t=
o
> > > invent new ioctl-ABI per TSM per function which at best is an abdicat=
ion
> > > of the kernel's responsibility to make common infrastructure concepts
> > > share common ABI.
> > >
> > > The proposal, targeted to conceptually work with TDX, SEV, COVE if no=
t
> > > more, is to define a new key type that produces a TSM common blob for=
mat
> > > and moves the vendor specificity inside that envelope. The common Lin=
ux
> > > definition is:
> > >
> > >     "<hex encoded pubkey> <blob descriptor> <hex encoded attestation =
blob>"
> > >
> > > This approach later allows for the standardization of the attestation
> > > blob format without needing to change the Linux ABI. TSM specific
> > > options are encoded in the frontend request format where the options
> > > like SEV:vmpl (privilege level) can be specified and TSMs that do not
> > > support them can decide to ignore them or fail if they are specified.
> > > For now, "privlevel=3D" and "format=3D" are the only implemented opti=
ons.
> > >
> > > Example of establishing a tsm key and dumping the provider-specific
> > > report:
> > >
> > >     dd if=3D/dev/urandom of=3Dpubkey bs=3D1 count=3D64
> > >     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=
=3D2" @u
> > >     keyctl print 280877394 | awk '{ print $3 }' | xxd -p -c 0 -r | he=
xdump -C
> >
> > What is the purpose of this report? What does it prove to whom? I'm a
> > bit confused because it doesn't seem like there is an ability for a
> > remote party to participate in a challenge and response to introduce
> > any freshness into this protocol.
> >
> > Also shouldn't the report have a little more context into the key we
> > are signing? For instance what type of public key is this? And what is
> > its purpose? In your example this isn't even a valid public key.
> >
> > >
> > > Now, this patch ends up being a fairly simple custom-key format becau=
se
> > > most of the follow-on work that happens after publishing a TSM-wrappe=
d
> > > public-key is performed by userspace. The TSM key is just one step in
> > > establishing a shared secret that can be used to unlock other keys. F=
or
> > > example a user-key could be populated with the resulting shared secre=
t
> > > and that could be used as a master-key for an encrypted-key
> > > (security/keys/encrypted-keys/encrypted.c).
> > >
> > > While the discussion that led to this proposal hinted at a new
> > > trusted-key (security/keys/trusted-keys/trusted_core.c) type rooted i=
n
> > > the TSM [2], more work is needed to fetch a secret from the TSM
> > > directly. The trusted-key core expects a pre-established secure chann=
el
> > > to seal and unseal secrets locally. For that reason a "tsm" flavor
> > > trusted-key is saved for follow on work. That will likely starting as=
 a
> > > wrapper around SNP_GET_DERIVED_KEY.
> > >
> > > Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh=
.jf.intel.com.notmuch [1]
> > > Link: http://lore.kernel.org/r/CAAH4kHYLETfPk-sMD-QSJd0fJ7Qnt04FBwFuE=
kpnehB5U7D_yw@mail.gmail.com [2]
> > > Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.inte=
l.com>
> > > Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > > Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Samuel Ortiz <sameo@rivosinc.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  include/keys/tsm.h     |   71 ++++++++++++
> > >  security/keys/Kconfig  |   12 ++
> > >  security/keys/Makefile |    1
> > >  security/keys/tsm.c    |  282 ++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  4 files changed, 366 insertions(+)
> > >  create mode 100644 include/keys/tsm.h
> > >  create mode 100644 security/keys/tsm.c
> > >
> > > diff --git a/include/keys/tsm.h b/include/keys/tsm.h
> > > new file mode 100644
> > > index 000000000000..61a81017d8f5
> > > --- /dev/null
> > > +++ b/include/keys/tsm.h
> > > @@ -0,0 +1,71 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __TSM_H
> > > +#define __TSM_H
> > > +
> > > +#include <linux/types.h>
> > > +#include <linux/module.h>
> > > +
> > > +/*
> > > + * @TSM_DATA_MAX: a reasonable max with enough space for known attes=
tation
> > > + * report formats. This mirrors the trusted/encrypted key blob max s=
ize.
> > > + */
> > > +#define TSM_DATA_MAX 32767
> > > +#define TSM_PUBKEY_MAX 64
> > > +#define TSM_FORMAT_MAX 16
> > > +
> > > +/**
> > > + * DOC: TSM Keys
> > > + *
> > > + * Trusted Security Module Keys are a common provider of blobs that
> > > + * facilitate key-exchange between a TVM (confidential computing gue=
st)
> > > + * and an attestation service. A TSM key combines a user-defined blo=
b
> >
> > Are we limited to only doing key-exchanges between guests and
> > attestation services? What if some user would like to handle the
> > attestation verification without a service?
>
> From the kernel perspective it does not matter, it is just marshalling
> the quote data. I assume local attestation could be built around this,
> but that's all user-space policy.

Makes sense. Can we tweak the language of these comments then?

>
> >
> > > + * (likely a public-key for a key-exchance protocol) with a signed
> >
> > key-exchange
>
> got it.
>
> >
> > > + * attestation report. That combined blob is then used to obtain
> > > + * secrets provided by an agent that can validate the attestation
> > > + * report.
> > > + *
> > > + * A full implementation uses a tsm key to, for example, establish a
> >
> > Should 'TSM' be capitalized everywhere? Or does it not matter?
>
> Probably should be.
>
> > > + * shared secret and then use that communication channel to instanti=
ate
> > > + * other keys. The expectation is that the requester of the tsm key
> > > + * knows a priori the key-exchange protocol associated with the
> > > + * 'pubkey'.
> >
> > Can we instead be very specific about what protocols and cryptography
> > are being used?
>
> Again this is a contract to which the kernel is not a party. The
> requester knows the significance of the user-data, and it knows where to
> send the combined user-data plus quote to provision further secrets.
>
> Not that I like that arrangement, but the kernel is not enabled by these
> TSM implementations to know much more than "user-data in", "report out".

Can you explain why using this key API is better than the ioctl
version? Is there an overhead to adding keys? You could imagine some
userspace application that receives RPCs and does some attestation for
each one, would adding then deleting a huge number of keys present any
issues?

>
> >
> > > + *
> > > + * The attestation report format is TSM provider specific, when / if=
 a
> >
> > I'm confused about the TSM terminology and what a TSM provider is. Is
> > TSM the confidential compute framework of the vendor? So for Intel
> > this is TDX, and the TSM provider is the SEAM module?
>
> Yes, I borrowed this term from the TDISP specification where the "Trusted
> Security Module" is the overarching term for the confidential compute
> infrastructure for the vendor. Yes, TDX + SEAM is a TSM and SEV-SNP +
> PSP is a TSM.

Thanks for the explanation.

>
> >
> > > + * standard materializes it is only a change to the auth_blob_desc
> > > + * member of 'struct tsm_key_payload', to convey that common format.
> > > + */
> > > +
> > > +/**
> > > + * struct tsm_key_payload - generic payload for vendor TSM blobs
> > > + * @privlevel: optional privilege level to associate with @pubkey
> > > + * @pubkey_len: how much of @pubkey is valid
> > > + * @pubkey: the public key-exchange blob to include in the attestati=
on report
> > > + * @auth_blob_desc: base ascii descriptor of @auth_blob
> > > + * @auth_blob_format: for TSMs with multiple formats, extend @auth_b=
lob_desc
> > > + * @auth_blob_len: TSM provider length of the array it publishes in =
@auth_blob
> > > + * @auth_blob: TSM specific attestation report blob
> > > + */
> > > +struct tsm_key_payload {
> > > +       int privlevel;
> > > +       size_t pubkey_len;
> > > +       u8 pubkey[TSM_PUBKEY_MAX];
> > > +       const char *auth_blob_desc;
> > > +       char auth_blob_format[TSM_FORMAT_MAX];
> > > +       size_t auth_blob_len;
> > > +       u8 *auth_blob;
> > > +};
> >
> > How is freshness incorporated into the key exchange protocol? Wouldn't
> > we need to do a challenge response between each remote party that we
> > need to attest the provenance of @pubkey too?
>
> That's left to userspace.

But you haven't allowed userspace to add any data into the quote other
than just the raw public key.

The current sevguest ioctl allows users to pass arbitrary userdata.
This would allow for some nonce to be included.

At a highlevel I'm not sure why this is better than each vendor having
their own driver. It doesn't seem that difficult for userspace to deal
with these systems given userspace will need to be written carefully
for these PKI protocols anyways.


>
> >
> > > + *                request, if the platform TSM supports that concept=
. To
> > > + *                date only SEV accepts this option. Default 0.
> >
> > SEV-SNP or just SNP? Plain SEV or SEV-ES doesn't actually support this
> > interface at all.
>
> Yeah, I was using "SEV" as a shorthand for the AMD "TSM". So maybe just
> "SNP" is appropriate?

I'm not sure what AMD prefers. I'll let them chime in.
