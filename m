Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A3D792AD3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242048AbjIEQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354370AbjIELFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 07:05:12 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905B91A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 04:05:08 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-7a52a1e2a59so857443241.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 04:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693911907; x=1694516707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjdfAUMQt11lOtOZhXgZtyQBLOJqMLXTb8Y4HhqzChQ=;
        b=lcFsCct2iHd6Yqum5uTTqukHzbH+rplnx0vqFnNYDQUSw5WAULSLXIKHAmwgZhk7RB
         /XV9P30gFTv8X4e+Ljbmu2dyqaW/s9p7+eKMSiNGErKioeN56aB2rbL5XdLw1Su9Vtgu
         X7sYtda4TPlZO+fOFnNw3u4EaK43fp4J6YkgwdwSFE97vtNvy+sCHGuiAGC4FzeKCuzY
         lHtQK8+XTb9ZtMuRdy/BrTKOSWapld2F/ArHF8qRtj1v4iLZsotKPXdeV9Z4JteFR5DW
         iItPz8ZLoSDkun98u/XPwg3zDFyFSP/Q4mFvEIpI3YYopbTL52EC4jsbFAEaRGaszeO0
         YLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693911907; x=1694516707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AjdfAUMQt11lOtOZhXgZtyQBLOJqMLXTb8Y4HhqzChQ=;
        b=TkRLtMVwT8MtBY/mLkThwd35qik6bsWm/2ZoZGKw2wDRthQGLM8142huBIY7UhAHcK
         CZWNG6lwd7639pPc8r+9NS0TbPbo/+SAxGIB96rwqNoFkG9Bee4sourAXivZiFUYgC5l
         aWxfNU9m0oB76mjg9XkUNaeVEVH7YHoVSu1L7OcbBYJZUMMFbAHfqvqOhw0Te2vVj+JX
         R9552Fit6dq8U7azcrNPgzdCJqyuaqEC+Z9GCcnCiHT3igu7j7RyMG0NWpkw5hqhNlwU
         URjWluo9g9OlZpOrUQ4ZUm0C+0niSpFSQd53leEcBR0hlUyxOPl4e89jloljBBLLLFjO
         xGnA==
X-Gm-Message-State: AOJu0YyzYELLw7+aTWL+GWq8TMdqJWpLrqMzqZtXMvCoT8Y7+KDhVYH7
        tDKF4VbxhiV9hwsvfDXW8VYZZUNWc6X4hV6T5/sfjA==
X-Google-Smtp-Source: AGHT+IE7fBNntLQi1M21QzJ8SZhchLaav2pstQ/dADdPA6JsBb22kj31acXgw3V2iy63h6j6WUTXLA4nVMn1nuZCk5c=
X-Received: by 2002:a67:f3ce:0:b0:44d:4385:1627 with SMTP id
 j14-20020a67f3ce000000b0044d43851627mr11184867vsn.14.1693911907511; Tue, 05
 Sep 2023 04:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org>
 <20230822125555.GA82256@rayden> <CAFA6WYPy=yxGg1HbT+ipWJFpxiJeUGK6BSgMhtRPd=zmKef-cw@mail.gmail.com>
 <CAHUa44G9jCeHcRq=AZeieaTPWN_tpOVKeJNY=777QAh-bw1QNg@mail.gmail.com>
 <CAFA6WYPY70iYCmQhzCkATGinqK_C1i4SEZzTdv4yDwntpGNzew@mail.gmail.com> <CAHUa44H5eG6N0M_aAiWsYJorWVt4pYEZPWXgOJHgXAYVmR=cww@mail.gmail.com>
In-Reply-To: <CAHUa44H5eG6N0M_aAiWsYJorWVt4pYEZPWXgOJHgXAYVmR=cww@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 5 Sep 2023 16:34:56 +0530
Message-ID: <CAFA6WYNAifDVZy-pLSTJWonGTJBECijsTFw4OQdqToW3u6Lj_Q@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
To:     jarkko@kernel.org
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>, jejb@linux.ibm.com,
        zohar@linux.ibm.com, sudeep.holla@arm.com, achin.gupta@arm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

On Wed, 23 Aug 2023 at 19:58, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Wed, Aug 23, 2023 at 3:04=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Wed, 23 Aug 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Wed, Aug 23, 2023 at 8:55=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > On Tue, 22 Aug 2023 at 18:25, Jens Wiklander <jens.wiklander@linaro=
.org> wrote:
> > > > >
> > > > > On Tue, Aug 22, 2023 at 04:59:33PM +0530, Sumit Garg wrote:
> > > > > > The OP-TEE driver using the old SMC based ABI permits overlappi=
ng shared
> > > > > > buffers, but with the new FF-A based ABI each physical page may=
 only
> > > > > > be registered once.
> > > > > >
> > > > > > As the key and blob buffer are allocated adjancently, there is =
no need
> > > > > > for redundant register shared memory invocation. Also, it is in=
compatibile
> > > > > > with FF-A based ABI limitation. So refactor register shared mem=
ory
> > > > > > implementation to use only single invocation to register both k=
ey and blob
> > > > > > buffers.
> > > > > >
> > > > > > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > > > > > Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > ---
> > > > > >  security/keys/trusted-keys/trusted_tee.c | 64 ++++++++--------=
--------
> > > > > >  1 file changed, 20 insertions(+), 44 deletions(-)
> > > > > >
> > > > > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/securit=
y/keys/trusted-keys/trusted_tee.c
> > > > > > index ac3e270ade69..aa3d477de6db 100644
> > > > > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > > > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > > > > @@ -65,24 +65,16 @@ static int trusted_tee_seal(struct trusted_=
key_payload *p, char *datablob)
> > > > > >       int ret;
> > > > > >       struct tee_ioctl_invoke_arg inv_arg;
> > > > > >       struct tee_param param[4];
> > > > > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NUL=
L;
> > > > > > +     struct tee_shm *reg_shm =3D NULL;
> > > > > >
> > > > > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > > > > >       memset(&param, 0, sizeof(param));
> > > > > >
> > > > > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, =
p->key,
> > > > > > -                                              p->key_len);
> > > > > > -     if (IS_ERR(reg_shm_in)) {
> > > > > > -             dev_err(pvt_data.dev, "key shm register failed\n"=
);
> > > > > > -             return PTR_ERR(reg_shm_in);
> > > > > > -     }
> > > > > > -
> > > > > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx,=
 p->blob,
> > > > > > -                                               sizeof(p->blob)=
);
> > > > > > -     if (IS_ERR(reg_shm_out)) {
> > > > > > -             dev_err(pvt_data.dev, "blob shm register failed\n=
");
> > > > > > -             ret =3D PTR_ERR(reg_shm_out);
> > > > > > -             goto out;
> > > > > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->=
key,
> > > > > > +                                           sizeof(p->key) + si=
zeof(p->blob));
> > > > >
> > > > > This is somewhat fragile. What if struct trusted_key_payload has =
a small
> > > > > unexpected change in layout?
> > > >
> > > > key and blob buffers are just two adjacent fixed sized byte arrays.=
 So
> > > > I am not worried here as long as they stay adjacent (which has been
> > > > the case since trusted keys were introduced in the kernel).
> > >
> > > Yeah, that was my point, but fine if you don't believe it's an issue.
> > >
> >
> > Does it resolve the issue with FFA ABI for you? It would be good to
> > have your Tested-by tag.
>
> It does:
> Tested-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
>

Can you help pick up this fix for v6.6 kernel release?

-Sumit

> Thanks,
> Jens
>
> >
> > -Sumit
> >
> > > Thanks,
> > > Jens
> > >
> > > >
> > > > -Sumit
> > > >
> > > > >
> > > > > Thanks,
> > > > > Jens
> > > > >
> > > > > > +     if (IS_ERR(reg_shm)) {
> > > > > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > > > > +             return PTR_ERR(reg_shm);
> > > > > >       }
> > > > > >
> > > > > >       inv_arg.func =3D TA_CMD_SEAL;
> > > > > > @@ -90,13 +82,13 @@ static int trusted_tee_seal(struct trusted_=
key_payload *p, char *datablob)
> > > > > >       inv_arg.num_params =3D 4;
> > > > > >
> > > > > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > > > > +     param[0].u.memref.shm =3D reg_shm;
> > > > > >       param[0].u.memref.size =3D p->key_len;
> > > > > >       param[0].u.memref.shm_offs =3D 0;
> > > > > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT=
;
> > > > > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > > > > +     param[1].u.memref.shm =3D reg_shm;
> > > > > >       param[1].u.memref.size =3D sizeof(p->blob);
> > > > > > -     param[1].u.memref.shm_offs =3D 0;
> > > > > > +     param[1].u.memref.shm_offs =3D sizeof(p->key);
> > > > > >
> > > > > >       ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, pa=
ram);
> > > > > >       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > > > > @@ -107,11 +99,7 @@ static int trusted_tee_seal(struct trusted_=
key_payload *p, char *datablob)
> > > > > >               p->blob_len =3D param[1].u.memref.size;
> > > > > >       }
> > > > > >
> > > > > > -out:
> > > > > > -     if (reg_shm_out)
> > > > > > -             tee_shm_free(reg_shm_out);
> > > > > > -     if (reg_shm_in)
> > > > > > -             tee_shm_free(reg_shm_in);
> > > > > > +     tee_shm_free(reg_shm);
> > > > > >
> > > > > >       return ret;
> > > > > >  }
> > > > > > @@ -124,24 +112,16 @@ static int trusted_tee_unseal(struct trus=
ted_key_payload *p, char *datablob)
> > > > > >       int ret;
> > > > > >       struct tee_ioctl_invoke_arg inv_arg;
> > > > > >       struct tee_param param[4];
> > > > > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NUL=
L;
> > > > > > +     struct tee_shm *reg_shm =3D NULL;
> > > > > >
> > > > > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > > > > >       memset(&param, 0, sizeof(param));
> > > > > >
> > > > > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, =
p->blob,
> > > > > > -                                              p->blob_len);
> > > > > > -     if (IS_ERR(reg_shm_in)) {
> > > > > > -             dev_err(pvt_data.dev, "blob shm register failed\n=
");
> > > > > > -             return PTR_ERR(reg_shm_in);
> > > > > > -     }
> > > > > > -
> > > > > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx,=
 p->key,
> > > > > > -                                               sizeof(p->key))=
;
> > > > > > -     if (IS_ERR(reg_shm_out)) {
> > > > > > -             dev_err(pvt_data.dev, "key shm register failed\n"=
);
> > > > > > -             ret =3D PTR_ERR(reg_shm_out);
> > > > > > -             goto out;
> > > > > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->=
key,
> > > > > > +                                           sizeof(p->key) + si=
zeof(p->blob));
> > > > > > +     if (IS_ERR(reg_shm)) {
> > > > > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > > > > +             return PTR_ERR(reg_shm);
> > > > > >       }
> > > > > >
> > > > > >       inv_arg.func =3D TA_CMD_UNSEAL;
> > > > > > @@ -149,11 +129,11 @@ static int trusted_tee_unseal(struct trus=
ted_key_payload *p, char *datablob)
> > > > > >       inv_arg.num_params =3D 4;
> > > > > >
> > > > > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > > > > +     param[0].u.memref.shm =3D reg_shm;
> > > > > >       param[0].u.memref.size =3D p->blob_len;
> > > > > > -     param[0].u.memref.shm_offs =3D 0;
> > > > > > +     param[0].u.memref.shm_offs =3D sizeof(p->key);
> > > > > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT=
;
> > > > > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > > > > +     param[1].u.memref.shm =3D reg_shm;
> > > > > >       param[1].u.memref.size =3D sizeof(p->key);
> > > > > >       param[1].u.memref.shm_offs =3D 0;
> > > > > >
> > > > > > @@ -166,11 +146,7 @@ static int trusted_tee_unseal(struct trust=
ed_key_payload *p, char *datablob)
> > > > > >               p->key_len =3D param[1].u.memref.size;
> > > > > >       }
> > > > > >
> > > > > > -out:
> > > > > > -     if (reg_shm_out)
> > > > > > -             tee_shm_free(reg_shm_out);
> > > > > > -     if (reg_shm_in)
> > > > > > -             tee_shm_free(reg_shm_in);
> > > > > > +     tee_shm_free(reg_shm);
> > > > > >
> > > > > >       return ret;
> > > > > >  }
> > > > > > --
> > > > > > 2.34.1
> > > > > >
