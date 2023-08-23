Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF2785A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbjHWO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjHWO25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:28:57 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73DBE63
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:28:53 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-64b98479a66so32140346d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692800933; x=1693405733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuYLroRk7v4cNdGcv2Tg+q5lCchzj6TGGh550Kkz/3w=;
        b=nEfqC6/iinefM3mi0Ed2vlG8NkKGX+QiYNico5geOi4g1vdTuEkUfwe4pBXh8DnX9H
         Fcy8Fwjwll7xoYiE0LX+QpC1bbnWOvCcAaA3jHueYzIb16iIRvxS/5fcnQ6JxsZHYsaw
         ASKoc4rBfmyBmIj7MFOFnbv+c4eDtp/eg8VueBw6Wal/k3iGSWbkEGddDNYOSgbpSw4Q
         YXoTAxIg4t7m4tw5zesGXlCULyC2NRQiwaho9/bIqrrfEayHmW7Zs+uoJP98M5kkJuMA
         xWteEC0cOaitTCDZt656AiWY9o2SXeadcQApWhPTBcR/IQhEz8TF8X1ZO4ICUAKKMa45
         K7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692800933; x=1693405733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuYLroRk7v4cNdGcv2Tg+q5lCchzj6TGGh550Kkz/3w=;
        b=MQ0vcWWDPOPzzR32H+GeQaIeXcjvSG+rgppHP+Sl6HDTzgIV1bOMdz/v2oJLA9IjhT
         gf3iS0WSVh7XrZUV+nw9ymLZYOpKMzX8I5T6cb9pZ7KzgR8KzIfgrjA6t3rTjxhR2Eqg
         94dOBW41gctvOzJspTueh0mfUD4vd4iSlNLpExOcMeHzeyfkNaF6Z9pq1x8yIWWaSvns
         0l4z8rYEzpGJpLDDeld5R/62f9vkcHMPsxBgzuvvJJvwZOSMVaPKWUp/mCSFTRi9JlIV
         RGK9/khi7WujQF/gcxf6318FwcUvPMM3YmY2CyBm0ZVO1fmcAGljkj/s1pbcx3OYI4g1
         XOBg==
X-Gm-Message-State: AOJu0YzmHZG8TPl1CqEMM1BFlXZx7xXeiRZFOUSgfv7EQJozvyAVqsKI
        NGsa9Cvapaa9TvNyuQiY0FIJB2r/MQj3MHb+juuclQ==
X-Google-Smtp-Source: AGHT+IG1yJa6qx7+hC6KnYHh8+bE2RCw8j/cpts6jwyBaHE61kL/aTCP1jhCgMs5PRGNO8/OimzKKJE+/+KqzHPNwhM=
X-Received: by 2002:a0c:aa55:0:b0:63c:f856:8aa7 with SMTP id
 e21-20020a0caa55000000b0063cf8568aa7mr12649492qvb.59.1692800932761; Wed, 23
 Aug 2023 07:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org>
 <20230822125555.GA82256@rayden> <CAFA6WYPy=yxGg1HbT+ipWJFpxiJeUGK6BSgMhtRPd=zmKef-cw@mail.gmail.com>
 <CAHUa44G9jCeHcRq=AZeieaTPWN_tpOVKeJNY=777QAh-bw1QNg@mail.gmail.com> <CAFA6WYPY70iYCmQhzCkATGinqK_C1i4SEZzTdv4yDwntpGNzew@mail.gmail.com>
In-Reply-To: <CAFA6WYPY70iYCmQhzCkATGinqK_C1i4SEZzTdv4yDwntpGNzew@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 23 Aug 2023 16:28:41 +0200
Message-ID: <CAHUa44H5eG6N0M_aAiWsYJorWVt4pYEZPWXgOJHgXAYVmR=cww@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        jarkko@kernel.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        sudeep.holla@arm.com, achin.gupta@arm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 3:04=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 23 Aug 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Wed, Aug 23, 2023 at 8:55=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Tue, 22 Aug 2023 at 18:25, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > On Tue, Aug 22, 2023 at 04:59:33PM +0530, Sumit Garg wrote:
> > > > > The OP-TEE driver using the old SMC based ABI permits overlapping=
 shared
> > > > > buffers, but with the new FF-A based ABI each physical page may o=
nly
> > > > > be registered once.
> > > > >
> > > > > As the key and blob buffer are allocated adjancently, there is no=
 need
> > > > > for redundant register shared memory invocation. Also, it is inco=
mpatibile
> > > > > with FF-A based ABI limitation. So refactor register shared memor=
y
> > > > > implementation to use only single invocation to register both key=
 and blob
> > > > > buffers.
> > > > >
> > > > > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > > > > Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >  security/keys/trusted-keys/trusted_tee.c | 64 ++++++++----------=
------
> > > > >  1 file changed, 20 insertions(+), 44 deletions(-)
> > > > >
> > > > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/=
keys/trusted-keys/trusted_tee.c
> > > > > index ac3e270ade69..aa3d477de6db 100644
> > > > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > > > @@ -65,24 +65,16 @@ static int trusted_tee_seal(struct trusted_ke=
y_payload *p, char *datablob)
> > > > >       int ret;
> > > > >       struct tee_ioctl_invoke_arg inv_arg;
> > > > >       struct tee_param param[4];
> > > > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > > > > +     struct tee_shm *reg_shm =3D NULL;
> > > > >
> > > > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > > > >       memset(&param, 0, sizeof(param));
> > > > >
> > > > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p-=
>key,
> > > > > -                                              p->key_len);
> > > > > -     if (IS_ERR(reg_shm_in)) {
> > > > > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > > > > -             return PTR_ERR(reg_shm_in);
> > > > > -     }
> > > > > -
> > > > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p=
->blob,
> > > > > -                                               sizeof(p->blob));
> > > > > -     if (IS_ERR(reg_shm_out)) {
> > > > > -             dev_err(pvt_data.dev, "blob shm register failed\n")=
;
> > > > > -             ret =3D PTR_ERR(reg_shm_out);
> > > > > -             goto out;
> > > > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->ke=
y,
> > > > > +                                           sizeof(p->key) + size=
of(p->blob));
> > > >
> > > > This is somewhat fragile. What if struct trusted_key_payload has a =
small
> > > > unexpected change in layout?
> > >
> > > key and blob buffers are just two adjacent fixed sized byte arrays. S=
o
> > > I am not worried here as long as they stay adjacent (which has been
> > > the case since trusted keys were introduced in the kernel).
> >
> > Yeah, that was my point, but fine if you don't believe it's an issue.
> >
>
> Does it resolve the issue with FFA ABI for you? It would be good to
> have your Tested-by tag.

It does:
Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

Thanks,
Jens

>
> -Sumit
>
> > Thanks,
> > Jens
> >
> > >
> > > -Sumit
> > >
> > > >
> > > > Thanks,
> > > > Jens
> > > >
> > > > > +     if (IS_ERR(reg_shm)) {
> > > > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > > > +             return PTR_ERR(reg_shm);
> > > > >       }
> > > > >
> > > > >       inv_arg.func =3D TA_CMD_SEAL;
> > > > > @@ -90,13 +82,13 @@ static int trusted_tee_seal(struct trusted_ke=
y_payload *p, char *datablob)
> > > > >       inv_arg.num_params =3D 4;
> > > > >
> > > > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > > > +     param[0].u.memref.shm =3D reg_shm;
> > > > >       param[0].u.memref.size =3D p->key_len;
> > > > >       param[0].u.memref.shm_offs =3D 0;
> > > > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > > > +     param[1].u.memref.shm =3D reg_shm;
> > > > >       param[1].u.memref.size =3D sizeof(p->blob);
> > > > > -     param[1].u.memref.shm_offs =3D 0;
> > > > > +     param[1].u.memref.shm_offs =3D sizeof(p->key);
> > > > >
> > > > >       ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, para=
m);
> > > > >       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > > > @@ -107,11 +99,7 @@ static int trusted_tee_seal(struct trusted_ke=
y_payload *p, char *datablob)
> > > > >               p->blob_len =3D param[1].u.memref.size;
> > > > >       }
> > > > >
> > > > > -out:
> > > > > -     if (reg_shm_out)
> > > > > -             tee_shm_free(reg_shm_out);
> > > > > -     if (reg_shm_in)
> > > > > -             tee_shm_free(reg_shm_in);
> > > > > +     tee_shm_free(reg_shm);
> > > > >
> > > > >       return ret;
> > > > >  }
> > > > > @@ -124,24 +112,16 @@ static int trusted_tee_unseal(struct truste=
d_key_payload *p, char *datablob)
> > > > >       int ret;
> > > > >       struct tee_ioctl_invoke_arg inv_arg;
> > > > >       struct tee_param param[4];
> > > > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > > > > +     struct tee_shm *reg_shm =3D NULL;
> > > > >
> > > > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > > > >       memset(&param, 0, sizeof(param));
> > > > >
> > > > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p-=
>blob,
> > > > > -                                              p->blob_len);
> > > > > -     if (IS_ERR(reg_shm_in)) {
> > > > > -             dev_err(pvt_data.dev, "blob shm register failed\n")=
;
> > > > > -             return PTR_ERR(reg_shm_in);
> > > > > -     }
> > > > > -
> > > > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p=
->key,
> > > > > -                                               sizeof(p->key));
> > > > > -     if (IS_ERR(reg_shm_out)) {
> > > > > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > > > > -             ret =3D PTR_ERR(reg_shm_out);
> > > > > -             goto out;
> > > > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->ke=
y,
> > > > > +                                           sizeof(p->key) + size=
of(p->blob));
> > > > > +     if (IS_ERR(reg_shm)) {
> > > > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > > > +             return PTR_ERR(reg_shm);
> > > > >       }
> > > > >
> > > > >       inv_arg.func =3D TA_CMD_UNSEAL;
> > > > > @@ -149,11 +129,11 @@ static int trusted_tee_unseal(struct truste=
d_key_payload *p, char *datablob)
> > > > >       inv_arg.num_params =3D 4;
> > > > >
> > > > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > > > +     param[0].u.memref.shm =3D reg_shm;
> > > > >       param[0].u.memref.size =3D p->blob_len;
> > > > > -     param[0].u.memref.shm_offs =3D 0;
> > > > > +     param[0].u.memref.shm_offs =3D sizeof(p->key);
> > > > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > > > +     param[1].u.memref.shm =3D reg_shm;
> > > > >       param[1].u.memref.size =3D sizeof(p->key);
> > > > >       param[1].u.memref.shm_offs =3D 0;
> > > > >
> > > > > @@ -166,11 +146,7 @@ static int trusted_tee_unseal(struct trusted=
_key_payload *p, char *datablob)
> > > > >               p->key_len =3D param[1].u.memref.size;
> > > > >       }
> > > > >
> > > > > -out:
> > > > > -     if (reg_shm_out)
> > > > > -             tee_shm_free(reg_shm_out);
> > > > > -     if (reg_shm_in)
> > > > > -             tee_shm_free(reg_shm_in);
> > > > > +     tee_shm_free(reg_shm);
> > > > >
> > > > >       return ret;
> > > > >  }
> > > > > --
> > > > > 2.34.1
> > > > >
