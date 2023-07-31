Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CF4769D12
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbjGaQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjGaQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:45:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101321725
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:45:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe0e132352so2535e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690821948; x=1691426748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQzQUdiSOA8VvEKYMDGz6s+mzA6mySlLioGv/IsCNj4=;
        b=AxI8bncJvaugk9IFd0D9XMWnIwJpgtDCs04XAEOvs3unLxxTIHzloJOqon8M7dfE1w
         KUn9G5L91BvVCIykV2sJArlGRJgI1IFhsH9li3oB7UeQYSSOkptXMhDEVYToji277qXV
         wK+vC3ePUKQfMiXj6c71xWNq0vwuePMwEsC63a5cM2ZiYmm+cVWdR8aXysiW6v5rU+LE
         JImqnVw5LN3GhrMQnQeYKP7gVXsTCO5CIV+nqkY83d6xe06V3KCjwPCeiUx04wfA93Js
         BItWrSfwI4XE+GXx6R0EhXcIsusT1LYouW644KzRpxiMCWvLgcP2rH4cOQ+K9uLQWIW+
         OAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690821948; x=1691426748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQzQUdiSOA8VvEKYMDGz6s+mzA6mySlLioGv/IsCNj4=;
        b=EuK5ZpZVDMOW0XdQ0uJSke8fcTW13gWOadkNmdaegBCtWoj5+uM2QPD7DTmPXb8V7V
         nOdTqZ+dao6Bvh8cE9Drv+XP6VJmkg+IsSRm6Gd1ppzoWwkfFohFexYjHMazUHTs3bB3
         QVdTjshF6EvfhBpC/mYU18exarkv5hed0JTfGJZ/1PQBKJz4//tMBPEDduT7qF9m0irF
         evDAEr7nQ+fsdyEGJmnRF0rHzF/gs89NHmhMGozHfOh7HIQ9mI5Z3sATcj6g3hbHv7ku
         dcZcogC3//u1ZBzhAGaDc6TWy+SfJzwwJWjVFczCpJ9+5GBglaj2UOnExFXsFYQbJp7N
         4P1g==
X-Gm-Message-State: ABy/qLZcGjnohyBnYO7UuS4c0nhCaDJhHX2P8VtatPewImiJdGhVcS7n
        evHz830ybtLrEmyoxiN6APiVDoVeolJudOe2ejPqiA==
X-Google-Smtp-Source: APBJJlGL4ckDiyTn2m00tO5oVOOX8flfvRabDyK6Jum/HR2op6l2KaR8wvSPMi1vQ+7qxO5rsgOMG+xiEkaYZy4h57U=
X-Received: by 2002:a05:600c:4202:b0:3f7:3e85:36a with SMTP id
 x2-20020a05600c420200b003f73e85036amr137325wmh.7.1690821948388; Mon, 31 Jul
 2023 09:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
 <169057267580.180586.15710177655506555147.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169057267580.180586.15710177655506555147.stgit@dwillia2-xfh.jf.intel.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 31 Jul 2023 10:45:36 -0600
Message-ID: <CAMkAt6r=r_utT6sd_LD-2rO-GpH4zd1D04p04P8WF51BKX-JMg@mail.gmail.com>
Subject: Re: [PATCH 4/4] virt: sevguest: Add TSM key support for SNP_{GET, GET_EXT}_REPORT
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     dhowells@redhat.com, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>, peterz@infradead.org,
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
> The sevguest driver was a first mover in the confidential computing
> space. As a first mover that afforded some leeway to build the driver
> without concern for common infrastructure.
>
> Now that sevguest is no longer a singleton [1] the common operation of
> building and transmitting attestation report blobs can / should be made
> common. In this model the so called "TSM-provider" implementations can
> share a common envelope ABI even if the contents of that envelope remain
> vendor-specific. When / if the industry agrees on an attestation record
> format, that definition can also fit in the same ABI. In the meantime
> the kernel's maintenance burden is reduced and collaboration on the
> commons is increased.
>
> Convert sevguest to use TSM keys to retrieve the blobs that the
> SNP_{GET,GET_EXT}_REPORT ioctls produce. The flow for retrieving the
> SNP_GET_REPORT blob via the keyctl utility would be:
>
>     dd if=3D/dev/urandom of=3Dpubkey bs=3D1 count=3D64
>     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=3D2" =
@u
>     keyctl print $key_id | awk '{ print $3 }' | xxd -p -c 0 -r | hexdump =
-C
>
> ...while the SNP_GET_EXT_REPORT flow adds the "format=3Dextended" option
> to the request flow:
>
>     keyctl add tsm tsm_test "auth $(xxd -p -c 0 < pubkey) privlevel=3D2 f=
ormat=3Dextended" @u
>
> The output format from 'keyctl print' is:
>
>     <pubkey blob> <auth blob desc[:format]> <auth blob>
>
> ...where the blobs are hex encoded and the descriptor string is either
> "sev" or "sev:extended" in this case.
>
> Note, the Keys subsystem frontend for the functionality that
> SNP_GET_DERIVED_KEY represents is saved for follow-on work that likely
> needs to become a new trusted-keys type. The old ioctls can be lazily
> deprecated, the main motivation of this effort is to stop the
> proliferation of new ioctls, and to increase cross-vendor colloboration.

collaboration

>
> Note, only compile-tested.
>
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.=
intel.com.notmuch [1]
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Dionna Glaze <dionnaglaze@google.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/virt/coco/sev-guest/Kconfig     |    2 +
>  drivers/virt/coco/sev-guest/sev-guest.c |   87 +++++++++++++++++++++++++=
++++++
>  2 files changed, 89 insertions(+)
>
> diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-=
guest/Kconfig
> index da2d7ca531f0..bce43d4639ce 100644
> --- a/drivers/virt/coco/sev-guest/Kconfig
> +++ b/drivers/virt/coco/sev-guest/Kconfig
> @@ -2,9 +2,11 @@ config SEV_GUEST
>         tristate "AMD SEV Guest driver"
>         default m
>         depends on AMD_MEM_ENCRYPT
> +       depends on KEYS
>         select CRYPTO
>         select CRYPTO_AEAD2
>         select CRYPTO_GCM
> +       select TSM_KEYS
>         help
>           SEV-SNP firmware provides the guest a mechanism to communicate =
with
>           the PSP without risk from a malicious hypervisor who wishes to =
read,
> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/=
sev-guest/sev-guest.c
> index f48c4764a7a2..2bdca268272d 100644
> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> @@ -21,6 +21,7 @@
>  #include <linux/psp-sev.h>
>  #include <uapi/linux/sev-guest.h>
>  #include <uapi/linux/psp-sev.h>
> +#include <keys/tsm.h>
>
>  #include <asm/svm.h>
>  #include <asm/sev.h>
> @@ -769,6 +770,84 @@ static u8 *get_vmpck(int id, struct snp_secrets_page=
_layout *layout, u32 **seqno
>         return key;
>  }
>
> +static int sev_auth_new(struct tsm_key_payload *t, void *provider_data)
> +{
> +       struct snp_guest_dev *snp_dev =3D provider_data;
> +       const int report_size =3D SZ_16K;
> +       const int ext_size =3D
> +               PAGE_ALIGN_DOWN(TSM_DATA_MAX - report_size - sizeof(*t));
> +       int ret;
> +
> +       if (t->pubkey_len !=3D 64)
> +               return -EINVAL;

Magic number?

We only support asymmetric keys with public keys exactly equal to 64
bytes? Is that only p256? SNP uses p384 can we atleast allow that
curve too? But why not let userspace what key type they want to use?

> +
> +       if (t->auth_blob_format[0] &&
> +           strcmp(t->auth_blob_format, "extended") !=3D 0)
> +               return -EINVAL;
> +
> +       if (t->auth_blob_format[0]) {
> +               u8 *buf __free(kvfree) =3D
> +                       kvzalloc(report_size + ext_size, GFP_KERNEL);
> +
> +               struct snp_ext_report_req req =3D {
> +                       .data =3D { .vmpl =3D t->privlevel },
> +                       .certs_address =3D (__u64)buf + report_size,
> +                       .certs_len =3D ext_size,
> +               };
> +               memcpy(&req.data.user_data, t->pubkey, 64);

Again without any freshness from the remote party, of what use is this
attestation report?

> +
> +               struct snp_guest_request_ioctl input =3D {
> +                       .msg_version =3D 1,
> +                       .req_data =3D (__u64) &req,
> +                       .resp_data =3D (__u64) buf,
> +               };
> +
> +               ret =3D get_ext_report(snp_dev, &input, SNP_KARG);
> +               if (ret)
> +                       return ret;
> +
> +               no_free_ptr(buf);
> +               t->auth_blob =3D buf;
> +               t->auth_blob_len =3D report_size + ext_size;
> +               t->auth_blob_desc =3D "sev";
> +       } else {
> +               u8 *buf __free(kvfree) =3D kvzalloc(report_size, GFP_KERN=
EL);
> +
> +               struct snp_report_req req =3D {
> +                       .vmpl =3D t->privlevel,
> +               };
> +               memcpy(&req.user_data, t->pubkey, 64);
> +
> +               struct snp_guest_request_ioctl input =3D {
> +                       .msg_version =3D 1,
> +                       .req_data =3D (__u64) &req,
> +                       .resp_data =3D (__u64) buf,
> +               };
> +
> +               ret =3D get_report(snp_dev, &input, SNP_KARG);
> +               if (ret)
> +                       return ret;
> +
> +               no_free_ptr(buf);
> +               t->auth_blob =3D buf;
> +               t->auth_blob_len =3D report_size;
> +               t->auth_blob_desc =3D "sev";
> +       }

Can we reduce the code duplication between the branches here?
