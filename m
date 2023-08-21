Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B28782551
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbjHUIVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjHUIVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:21:52 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7641BE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:21:48 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-44779e3e394so994232137.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 01:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692606108; x=1693210908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dal7qUCVaoYplLAJ6diY8MBMZJHT6q6J2xawaGqTb2Y=;
        b=lGeDXAoKxU9Dl1Ws/07RazE+kVEr1lg12i4mxHfWfuKEDTXmNj84CBiBah8umC6VOH
         MxA339LtU+1z4MActkft8MYh8f//O6zRc/RvjbAv3S8wmXyLj+AI4uRDRcjrHpKUNqwH
         es0Hf7vyv9AaHmcksPeHOdErHjwH8MEOUOV5izFpY33SV9EScHDmtb9DQC6uzIi30I/f
         iTmj8JCe2z/ToBle0GgHO0c1L/+yGxB8g+2O9TnUAoLLVuKf7ZajbWZv6PWXhnhtRqbC
         zs4e/VM5d7NUNxeobRhO1CTj67nyZzYfD2NAeQ9z6AAr38/VXDSrsLbQitku15qGHDgi
         yX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692606108; x=1693210908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dal7qUCVaoYplLAJ6diY8MBMZJHT6q6J2xawaGqTb2Y=;
        b=can1s2+VMQVmlG+LtnmFzBtH/X4RolTSsZVkFrEaXlJ2sHz45JhpHhkxjuMxdAT2Yu
         YC6WGvVMj6XK5gPN1M81PE7SNwg2iDZNDI2XH4IisPFVT1+3c9N2uT4/BUk2z3lR0Ev3
         XzVznKoaq6loOn7T4r160Bg2HUUtlQfYTVI9f6LzTNIjQx+nWW+SrkJpTJ4UFEAtGHui
         fE8ZeRbqPg8Jz1wZbyWYKSZ1dcJgfHGvf4yGb+j9SDAJdrLSbY6urutOi/Jh27u2/a0k
         yhQHwZMNjjj4GF7LkDG2yRsRGQ04MNUB01P9Phd+N9imHVoNWrHdCqgmWwqsea+gonZy
         /EPg==
X-Gm-Message-State: AOJu0YyrXhWi1/GqX0kawqyg5iKHUI7T+zc1OQrQRRVMa5JnNhYkvhaE
        JgeHZbAIOjayfri8PgAYWsRu929CypbERIRRUPWDfg==
X-Google-Smtp-Source: AGHT+IFB20g0y6GSAv/nFSWbPQ4lMazycqwRDUDNbs4MO/OSsDAjH3Kqr0vWxuGaeUvulYXUcWsEr4UnLfG9EC0pATc=
X-Received: by 2002:a67:fd59:0:b0:44d:4160:4f8a with SMTP id
 g25-20020a67fd59000000b0044d41604f8amr2577805vsr.12.1692606107933; Mon, 21
 Aug 2023 01:21:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230803123515.4018838-1-jens.wiklander@linaro.org>
 <CAFA6WYMzBJTNUxh6b-y=a_NND8FX65YjEP4i-HPS4tQ-Qfm+0w@mail.gmail.com> <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
In-Reply-To: <CAHUa44ET3Oqc4Yq8E4ouAjn5dF9ygxoXyWh0sjFF_vPoooxrnA@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Aug 2023 13:51:36 +0530
Message-ID: <CAFA6WYMxAUeGVoDU6tHLD_j9FKz7O0D=eby+OsAE_GA1gXGGuw@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: use tee_shm_register_alloc_buf()
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Achin Gupta <achin.gupta@arm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sudeep, Achin

On Tue, 8 Aug 2023 at 14:37, Jens Wiklander <jens.wiklander@linaro.org> wro=
te:
>
> Hi Sumit,
>
> On Mon, Aug 7, 2023 at 9:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
> >
> > Hi Jens,
> >
> > On Thu, 3 Aug 2023 at 18:05, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> > >
> > > Prior to this patch was trusted_tee_seal() and trusted_tee_get_random=
()
> > > relying on tee_shm_register_kernel_buf() to share memory with the TEE=
.
> > > Depending on the memory allocation pattern the pages holding the
> > > registered buffers overlap with other buffers also shared with the TE=
E.
> > >
> >
> > The overlap here is due to the fact that we are registering two array
> > members of the same struct. This overlap can be removed by registering
> > the overall structure at once. But that sounds unnecessary data
> > structure type sharing with trusted keys TA.
> >
> > > The OP-TEE driver using the old SMC based ABI permits overlapping sha=
red
> > > buffers, but with the new FF-A based ABI each physical page may only
> > > be registered once.
> >
> > Would it be possible for OP-TEE FF-A ABI to check if a page is already
> > registered?
>
> No, there's no such ABI in the FF-A specification.

It should at least provide us a unique return code that this page is
already registered with, right?

Sudeep, Achin,

The problem we are discussing here is related to limitations put by
FF-A ABI on registered memory. As you may know the client doesn't
always have to share page aligned buffers. But rather it is possible
to share sub page buffers across multiple shared memory registration
invocations.

Does FF-A ABI provide a way to support that? Or can we extend the current A=
BI?

>
> > If it is then just return success with appropriate page
> > offset.
>
> It's more complicated than that. What if only there's a partial registrat=
ion?
>

I suppose "struct tee_shm" gives us enough room to deal with page offset.

> > As otherwise this sounds like an unnecessary restriction for
> > users. I don't think the problem is only particular to the trusted
> > keys driver but can be reproduced for user-space clients as well.
>
> Indeed, we're dealing with it by using a temporary buffer in the client l=
ib.
>

It looks like we are talking about this [1] here. It is not a TRUE
zero copy but rather a workaround to support FF-A ABI limitation. We
should fix it if we really need to support TEEC_RegisterSharedMemory()
in its true sense.

[1] https://github.com/OP-TEE/optee_client/commit/562dadc726b8ecbde98168659=
3a0d7f8ffb4757b

> >
> > >
> > > Fix this problem by allocating a temporary page aligned shared memory
> > > buffer to be used as a bounce buffer for the needed data buffers.
> > >
> > > Since TEE trusted keys doesn't depend on registered shared memory
> > > support any longer remove that explicit dependency when opening a
> > > context to the TEE.
> > >
> > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tee.c | 68 +++++++++++++---------=
--
> > >  1 file changed, 36 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys=
/trusted-keys/trusted_tee.c
> > > index ac3e270ade69..3085343c489a 100644
> > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > @@ -8,6 +8,7 @@
> > >
> > >  #include <linux/err.h>
> > >  #include <linux/key-type.h>
> > > +#include <linux/minmax.h>
> > >  #include <linux/module.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/string.h>
> > > @@ -65,38 +66,37 @@ static int trusted_tee_seal(struct trusted_key_pa=
yload *p, char *datablob)
> > >         int ret;
> > >         struct tee_ioctl_invoke_arg inv_arg;
> > >         struct tee_param param[4];
> > > -       struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > > +       struct tee_shm *shm;
> > > +       uint8_t *buf;
> > >
> > >         memset(&inv_arg, 0, sizeof(inv_arg));
> > >         memset(&param, 0, sizeof(param));
> > >
> > > -       reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->k=
ey,
> > > -                                                p->key_len);
> > > -       if (IS_ERR(reg_shm_in)) {
> > > -               dev_err(pvt_data.dev, "key shm register failed\n");
> > > -               return PTR_ERR(reg_shm_in);
> > > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx,
> > > +                                      p->key_len + sizeof(p->blob));
> > > +       if (IS_ERR(shm)) {
> > > +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> > > +               return PTR_ERR(shm);
> > >         }
> > > -
> > > -       reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->=
blob,
> > > -                                                 sizeof(p->blob));
> > > -       if (IS_ERR(reg_shm_out)) {
> > > -               dev_err(pvt_data.dev, "blob shm register failed\n");
> > > -               ret =3D PTR_ERR(reg_shm_out);
> > > +       buf =3D tee_shm_get_va(shm, 0);
> > > +       if (IS_ERR(buf)) {
> > > +               ret =3D PTR_ERR(buf);
> > >                 goto out;
> > >         }
> > > +       memcpy(buf, p->key, p->key_len);
> >
> > These memcpy()'s here and below are undue overheads if we change to
> > tee_shm_alloc_kernel_buf().
>
> There's a bit of overhead when entering and exiting the secure world
> too, just to save and restore registers. Anyway, trusted_tee_seal()
> doesn't together with FF-A without this patch.


I would rather suggest we add a workaround to
tee_shm_register_kernel_buf() in a similar manner as we did for the
user-space client library.

-Sumit

>
> Thanks,
> Jens
>
> >
> > -Sumit
> >
> > >
> > >         inv_arg.func =3D TA_CMD_SEAL;
> > >         inv_arg.session =3D pvt_data.session_id;
> > >         inv_arg.num_params =3D 4;
> > >
> > >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > -       param[0].u.memref.shm =3D reg_shm_in;
> > > +       param[0].u.memref.shm =3D shm;
> > >         param[0].u.memref.size =3D p->key_len;
> > >         param[0].u.memref.shm_offs =3D 0;
> > >         param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > -       param[1].u.memref.shm =3D reg_shm_out;
> > > +       param[1].u.memref.shm =3D shm;
> > >         param[1].u.memref.size =3D sizeof(p->blob);
> > > -       param[1].u.memref.shm_offs =3D 0;
> > > +       param[1].u.memref.shm_offs =3D p->key_len;
> > >
> > >         ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param)=
;
> > >         if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > @@ -104,14 +104,13 @@ static int trusted_tee_seal(struct trusted_key_=
payload *p, char *datablob)
> > >                         inv_arg.ret);
> > >                 ret =3D -EFAULT;
> > >         } else {
> > > +               memcpy(p->blob, buf + p->key_len,
> > > +                      min(param[1].u.memref.size, sizeof(p->blob)));
> > >                 p->blob_len =3D param[1].u.memref.size;
> > >         }
> > >
> > >  out:
> > > -       if (reg_shm_out)
> > > -               tee_shm_free(reg_shm_out);
> > > -       if (reg_shm_in)
> > > -               tee_shm_free(reg_shm_in);
> > > +       tee_shm_free(shm);
> > >
> > >         return ret;
> > >  }
> > > @@ -166,11 +165,9 @@ static int trusted_tee_unseal(struct trusted_key=
_payload *p, char *datablob)
> > >                 p->key_len =3D param[1].u.memref.size;
> > >         }
> > >
> > > +       tee_shm_free(reg_shm_out);
> > >  out:
> > > -       if (reg_shm_out)
> > > -               tee_shm_free(reg_shm_out);
> > > -       if (reg_shm_in)
> > > -               tee_shm_free(reg_shm_in);
> > > +       tee_shm_free(reg_shm_in);
> > >
> > >         return ret;
> > >  }
> > > @@ -183,15 +180,21 @@ static int trusted_tee_get_random(unsigned char=
 *key, size_t key_len)
> > >         int ret;
> > >         struct tee_ioctl_invoke_arg inv_arg;
> > >         struct tee_param param[4];
> > > -       struct tee_shm *reg_shm =3D NULL;
> > > +       struct tee_shm *shm;
> > > +       void *buf;
> > >
> > >         memset(&inv_arg, 0, sizeof(inv_arg));
> > >         memset(&param, 0, sizeof(param));
> > >
> > > -       reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, key, ke=
y_len);
> > > -       if (IS_ERR(reg_shm)) {
> > > -               dev_err(pvt_data.dev, "key shm register failed\n");
> > > -               return PTR_ERR(reg_shm);
> > > +       shm =3D tee_shm_alloc_kernel_buf(pvt_data.ctx, key_len);
> > > +       if (IS_ERR(shm)) {
> > > +               dev_err(pvt_data.dev, "key shm alloc failed\n");
> > > +               return PTR_ERR(shm);
> > > +       }
> > > +       buf =3D tee_shm_get_va(shm, 0);
> > > +       if (IS_ERR(buf)) {
> > > +               ret =3D PTR_ERR(buf);
> > > +               goto out;
> > >         }
> > >
> > >         inv_arg.func =3D TA_CMD_GET_RANDOM;
> > > @@ -199,7 +202,7 @@ static int trusted_tee_get_random(unsigned char *=
key, size_t key_len)
> > >         inv_arg.num_params =3D 4;
> > >
> > >         param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > -       param[0].u.memref.shm =3D reg_shm;
> > > +       param[0].u.memref.shm =3D shm;
> > >         param[0].u.memref.size =3D key_len;
> > >         param[0].u.memref.shm_offs =3D 0;
> > >
> > > @@ -209,18 +212,19 @@ static int trusted_tee_get_random(unsigned char=
 *key, size_t key_len)
> > >                         inv_arg.ret);
> > >                 ret =3D -EFAULT;
> > >         } else {
> > > +               memcpy(key, buf, min(param[0].u.memref.size, key_len)=
);
> > >                 ret =3D param[0].u.memref.size;
> > >         }
> > >
> > > -       tee_shm_free(reg_shm);
> > > +out:
> > > +       tee_shm_free(shm);
> > >
> > >         return ret;
> > >  }
> > >
> > >  static int optee_ctx_match(struct tee_ioctl_version_data *ver, const=
 void *data)
> > >  {
> > > -       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE &&
> > > -           ver->gen_caps & TEE_GEN_CAP_REG_MEM)
> > > +       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
> > >                 return 1;
> > >         else
> > >                 return 0;
> > > --
> > > 2.34.1
> > >
