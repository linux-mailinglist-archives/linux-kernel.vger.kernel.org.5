Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47CE769C9F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbjGaQds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjGaQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:33:41 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBDA19AE
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:33:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fd28ae8b90so115695e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690821215; x=1691426015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuWATRET77tyb1uo8IPo90xACV32fUCq2guhUdmEFls=;
        b=Tdg2MKQqHhluls/uCjqroj+MH+TUAoR1i0qc/ajQ8wWZdqmcHcbjP5CMcNqdZJ9GPz
         y/3dy8uy3dAYcMFthHLGlpmt7hok6t5YchQg3nqIOryvlxcWoGqoJJYhSW+4zFVoEuHX
         MHQquMb8bjj6X8tmfEcyxqIudzu5FqvcBA8q42vM2L4D8oO/ZrX+qafYWVrC1X6+jVGn
         ofRImATJqqmenIBWk2ACmz4Mfdc6zuku/HNRDKMeRa5Ae/QTbENrG1GoBIxpuqSGKQon
         LgEhCxjz1Punm9aVHSExvRsWLwq3klE2BtG/ADCzScmZ5mL74lSz8P+fU/kftyhS9o0v
         PZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821215; x=1691426015;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuWATRET77tyb1uo8IPo90xACV32fUCq2guhUdmEFls=;
        b=EFV6jmHgzXyGVR0nNoKY0GqQMPwR5+t/zEobv/o7o3F03RTDZkrIyVbwwzVxnqlMcw
         6M7Uqd6QKW+YmGDe+32S36EayY8n2oZwBIOhreRgxjGikYmU7QvBAcayTclbwqUQyf2j
         DjPXTkWnE/J7g1o/lQZd8iMk/8xCheHHxLphfelGVzL8NsLsZqS2byCFReDWy2XI8+dE
         lwEHmmdtvDms/Dlf+wqg7OAHPsowS/d9YRm3+usb7bWQQhgslB4HkjmYBnn3bIPM+X57
         2wPODM8jOs2S5it7rOsjr9xJzauNRehH8Dyo5Kz81Ol6kYVmTpGN0K6QX3yzoKRupwuD
         jkEw==
X-Gm-Message-State: ABy/qLbcfM39Pz5YbpYtW214mTjW1iLowJ+PK0hcHGG24NeyRe3MV0hl
        2JUktFKRVPl6ejSnPVzYPUWRx7Ed+GTN2dE68JHYBw==
X-Google-Smtp-Source: APBJJlG9N8QU9egW8mkno1wAm32nx+rrXKs4+cxx9edfMDm2d5Dnl47NavsjDU3KvuNODbh6H8N+hHNjuXp8MgG9Lhk=
X-Received: by 2002:a05:600c:68a:b0:3f1:70d1:21a6 with SMTP id
 a10-20020a05600c068a00b003f170d121a6mr158278wmn.0.1690821214889; Mon, 31 Jul
 2023 09:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169057265801.180586.10867293237672839356.stgit@dwillia2-xfh.jf.intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 31 Jul 2023 10:33:23 -0600
Message-ID: <CAMkAt6ot9zyUL9Ub-qYq+d9v-6rTft4ea2mUxp3o1s3GVFq7nw@mail.gmail.com>
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 1:31=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
>
> One of the common operations of a TSM (Trusted Security Module) is to
> provide a way for a TVM (confidential computing guest execution
> environment) to take a measurement of its run state and use that with a
> key-exchange protocol to establish a shared secret with a third-party /
> remote attestation agent. The concept is common across TSMs, but the
> implementations are unfortunately vendor specific. While the industry
> grapples with a common definition of this attestation format [1], Linux
> need not make this problem worse by defining a new ABI per TSM that
> wants to perform a similar operation. The current momentum has been to
> invent new ioctl-ABI per TSM per function which at best is an abdication
> of the kernel's responsibility to make common infrastructure concepts
> share common ABI.
>
> The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> more, is to define a new key type that produces a TSM common blob format
> and moves the vendor specificity inside that envelope. The common Linux
> definition is:
>
>     "<hex encoded pubkey> <blob descriptor> <hex encoded attestation blob=
>"
>
> This approach later allows for the standardization of the attestation
> blob format without needing to change the Linux ABI. TSM specific
> options are encoded in the frontend request format where the options
> like SEV:vmpl (privilege level) can be specified and TSMs that do not
> support them can decide to ignore them or fail if they are specified.
> For now, "privlevel=3D" and "format=3D" are the only implemented options.
>
> Example of establishing a tsm key and dumping the provider-specific
> report:
>
>     dd if=3D/dev/urandom of=3Dpubkey bs=3D1 count=3D64
>     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=3D2" =
@u
>     keyctl print 280877394 | awk '{ print $3 }' | xxd -p -c 0 -r | hexdum=
p -C

What is the purpose of this report? What does it prove to whom? I'm a
bit confused because it doesn't seem like there is an ability for a
remote party to participate in a challenge and response to introduce
any freshness into this protocol.

Also shouldn't the report have a little more context into the key we
are signing? For instance what type of public key is this? And what is
its purpose? In your example this isn't even a valid public key.

>
> Now, this patch ends up being a fairly simple custom-key format because
> most of the follow-on work that happens after publishing a TSM-wrapped
> public-key is performed by userspace. The TSM key is just one step in
> establishing a shared secret that can be used to unlock other keys. For
> example a user-key could be populated with the resulting shared secret
> and that could be used as a master-key for an encrypted-key
> (security/keys/encrypted-keys/encrypted.c).
>
> While the discussion that led to this proposal hinted at a new
> trusted-key (security/keys/trusted-keys/trusted_core.c) type rooted in
> the TSM [2], more work is needed to fetch a secret from the TSM
> directly. The trusted-key core expects a pre-established secure channel
> to seal and unseal secrets locally. For that reason a "tsm" flavor
> trusted-key is saved for follow on work. That will likely starting as a
> wrapper around SNP_GET_DERIVED_KEY.
>
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.=
intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/CAAH4kHYLETfPk-sMD-QSJd0fJ7Qnt04FBwFuEkpne=
hB5U7D_yw@mail.gmail.com [2]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.co=
m>
> Tested-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.i=
ntel.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/keys/tsm.h     |   71 ++++++++++++
>  security/keys/Kconfig  |   12 ++
>  security/keys/Makefile |    1
>  security/keys/tsm.c    |  282 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 366 insertions(+)
>  create mode 100644 include/keys/tsm.h
>  create mode 100644 security/keys/tsm.c
>
> diff --git a/include/keys/tsm.h b/include/keys/tsm.h
> new file mode 100644
> index 000000000000..61a81017d8f5
> --- /dev/null
> +++ b/include/keys/tsm.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TSM_H
> +#define __TSM_H
> +
> +#include <linux/types.h>
> +#include <linux/module.h>
> +
> +/*
> + * @TSM_DATA_MAX: a reasonable max with enough space for known attestati=
on
> + * report formats. This mirrors the trusted/encrypted key blob max size.
> + */
> +#define TSM_DATA_MAX 32767
> +#define TSM_PUBKEY_MAX 64
> +#define TSM_FORMAT_MAX 16
> +
> +/**
> + * DOC: TSM Keys
> + *
> + * Trusted Security Module Keys are a common provider of blobs that
> + * facilitate key-exchange between a TVM (confidential computing guest)
> + * and an attestation service. A TSM key combines a user-defined blob

Are we limited to only doing key-exchanges between guests and
attestation services? What if some user would like to handle the
attestation verification without a service?

> + * (likely a public-key for a key-exchance protocol) with a signed

key-exchange

> + * attestation report. That combined blob is then used to obtain
> + * secrets provided by an agent that can validate the attestation
> + * report.
> + *
> + * A full implementation uses a tsm key to, for example, establish a

Should 'TSM' be capitalized everywhere? Or does it not matter?

> + * shared secret and then use that communication channel to instantiate
> + * other keys. The expectation is that the requester of the tsm key
> + * knows a priori the key-exchange protocol associated with the
> + * 'pubkey'.

Can we instead be very specific about what protocols and cryptography
are being used?

> + *
> + * The attestation report format is TSM provider specific, when / if a

I'm confused about the TSM terminology and what a TSM provider is. Is
TSM the confidential compute framework of the vendor? So for Intel
this is TDX, and the TSM provider is the SEAM module?

> + * standard materializes it is only a change to the auth_blob_desc
> + * member of 'struct tsm_key_payload', to convey that common format.
> + */
> +
> +/**
> + * struct tsm_key_payload - generic payload for vendor TSM blobs
> + * @privlevel: optional privilege level to associate with @pubkey
> + * @pubkey_len: how much of @pubkey is valid
> + * @pubkey: the public key-exchange blob to include in the attestation r=
eport
> + * @auth_blob_desc: base ascii descriptor of @auth_blob
> + * @auth_blob_format: for TSMs with multiple formats, extend @auth_blob_=
desc
> + * @auth_blob_len: TSM provider length of the array it publishes in @aut=
h_blob
> + * @auth_blob: TSM specific attestation report blob
> + */
> +struct tsm_key_payload {
> +       int privlevel;
> +       size_t pubkey_len;
> +       u8 pubkey[TSM_PUBKEY_MAX];
> +       const char *auth_blob_desc;
> +       char auth_blob_format[TSM_FORMAT_MAX];
> +       size_t auth_blob_len;
> +       u8 *auth_blob;
> +};

How is freshness incorporated into the key exchange protocol? Wouldn't
we need to do a challenge response between each remote party that we
need to attest the provenance of @pubkey too?

> +
> +/*
> + * tsm_parse - parse the tsm request data
> + *
> + * input format: "auth <hex pubkey data> [options]"
> + *
> + * Checks for options and parses a hex blob of data to be wrapped by the
> + * TSM attestation format.
> + *
> + * options:
> + *     privlevel=3D integer for selecting the privelege level of the

privilege

> + *                request, if the platform TSM supports that concept. To
> + *                date only SEV accepts this option. Default 0.

SEV-SNP or just SNP? Plain SEV or SEV-ES doesn't actually support this
interface at all.


> + *     format=3D    string modifier for the format, if the platform TSM
> + *                supports multiple formats. To date only SEV accepts an
> + *                "extended" argument. Default "".
> + *
> + * On success returns 0, otherwise -EINVAL.
> + */
