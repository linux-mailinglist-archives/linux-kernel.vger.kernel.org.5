Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16478587A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbjHWNEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjHWNEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:04:44 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189EE47
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:04:40 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44d3b9bc4c3so2436176137.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692795879; x=1693400679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTbgml3tMCkFOWXWxWk7/YobPm452iPb0dGmYvcga88=;
        b=h+ejQm9ddYknfehNE76UpVyqLKo6BtDzkW5mc6pD+BfMUWcu4xZBtY0pD0y/b8fIu6
         ox+SIK7hVtacQ//ybAnzZC6s4EU2xcPyh1C5F6KUFUody948VKo2oVfFFLnnoBhAba/9
         uY/NMSWOM2Rmed3/Bqq8Mo8s5ukiwA6jKjLQqbuzy3CzhsHVQCY7z/XMMmxr8QSL39Al
         o2ok2tMRyq8UxEhKLqP35fFpa2sX8cfKbZhq5UUZY6joMjbXIwVczvQWwPtBxliZCsJm
         lUxjF4bbWYMbipBQUixh/O8gA6u48mVTqKmbHeXvsau9RxmHfFnCYxfAbGcnlkU7kmn/
         +ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692795879; x=1693400679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTbgml3tMCkFOWXWxWk7/YobPm452iPb0dGmYvcga88=;
        b=WcGZhPbk1eSu71O0JRniJpsmvIAxaP/4MrpCcXZwS21sooWQlj1xWhpOJvz5PM4tde
         djAjAXcmHGwA2ubi5A8jf77TgoEtKvyvy8dxVsWYCvhi6Uwi2V52UAEcvKz0+AEw1NCG
         nLYuNz2A5SzNf3ePDNsSKJQsOCo4XcA1PURoyOJ9ZqBRRPZoeK8DD6y9VurajIynU5Q4
         3bBip0Bxm2xvDpCC0HQzkgQu4sqDQdNP13VxzDaUOoSzaqr6J+B+n2mjZovszYhwyo2c
         WTBc6eJhcMQmlVdG7/LtnJqhs32lEU7rGVQZqq4xs9Cd/JLXZDpbuIt7bJPmIa0vrYXV
         NCfw==
X-Gm-Message-State: AOJu0YztuP6t2YBx0ZUjTphDs3tcotgmH8Qx2gnFhmirfYZXHxSLoVF/
        07s+y3u6qw+erX0+dyZ3rXWSH7amGJZeLTEIFy8XrQ==
X-Google-Smtp-Source: AGHT+IHmtqeAuNNyQBwwt1j3onh8n3qBSuUgfAzZERQ7V73Kqsf2NZlSw2R7OSHjNVuyEVV4FZS/I8IH+2sZn6MnXTM=
X-Received: by 2002:a05:6102:124c:b0:44d:506c:b9c6 with SMTP id
 p12-20020a056102124c00b0044d506cb9c6mr3427028vsg.2.1692795879621; Wed, 23 Aug
 2023 06:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org>
 <20230822125555.GA82256@rayden> <CAFA6WYPy=yxGg1HbT+ipWJFpxiJeUGK6BSgMhtRPd=zmKef-cw@mail.gmail.com>
 <CAHUa44G9jCeHcRq=AZeieaTPWN_tpOVKeJNY=777QAh-bw1QNg@mail.gmail.com>
In-Reply-To: <CAHUa44G9jCeHcRq=AZeieaTPWN_tpOVKeJNY=777QAh-bw1QNg@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 23 Aug 2023 18:34:28 +0530
Message-ID: <CAFA6WYPY70iYCmQhzCkATGinqK_C1i4SEZzTdv4yDwntpGNzew@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: tee: Refactor register SHM usage
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        jarkko@kernel.org, jejb@linux.ibm.com, zohar@linux.ibm.com,
        sudeep.holla@arm.com, achin.gupta@arm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 13:32, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Wed, Aug 23, 2023 at 8:55=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Tue, 22 Aug 2023 at 18:25, Jens Wiklander <jens.wiklander@linaro.org=
> wrote:
> > >
> > > On Tue, Aug 22, 2023 at 04:59:33PM +0530, Sumit Garg wrote:
> > > > The OP-TEE driver using the old SMC based ABI permits overlapping s=
hared
> > > > buffers, but with the new FF-A based ABI each physical page may onl=
y
> > > > be registered once.
> > > >
> > > > As the key and blob buffer are allocated adjancently, there is no n=
eed
> > > > for redundant register shared memory invocation. Also, it is incomp=
atibile
> > > > with FF-A based ABI limitation. So refactor register shared memory
> > > > implementation to use only single invocation to register both key a=
nd blob
> > > > buffers.
> > > >
> > > > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > > > Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > ---
> > > >  security/keys/trusted-keys/trusted_tee.c | 64 ++++++++------------=
----
> > > >  1 file changed, 20 insertions(+), 44 deletions(-)
> > > >
> > > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/ke=
ys/trusted-keys/trusted_tee.c
> > > > index ac3e270ade69..aa3d477de6db 100644
> > > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > > @@ -65,24 +65,16 @@ static int trusted_tee_seal(struct trusted_key_=
payload *p, char *datablob)
> > > >       int ret;
> > > >       struct tee_ioctl_invoke_arg inv_arg;
> > > >       struct tee_param param[4];
> > > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > > > +     struct tee_shm *reg_shm =3D NULL;
> > > >
> > > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > > >       memset(&param, 0, sizeof(param));
> > > >
> > > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->k=
ey,
> > > > -                                              p->key_len);
> > > > -     if (IS_ERR(reg_shm_in)) {
> > > > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > > > -             return PTR_ERR(reg_shm_in);
> > > > -     }
> > > > -
> > > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->=
blob,
> > > > -                                               sizeof(p->blob));
> > > > -     if (IS_ERR(reg_shm_out)) {
> > > > -             dev_err(pvt_data.dev, "blob shm register failed\n");
> > > > -             ret =3D PTR_ERR(reg_shm_out);
> > > > -             goto out;
> > > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > > > +                                           sizeof(p->key) + sizeof=
(p->blob));
> > >
> > > This is somewhat fragile. What if struct trusted_key_payload has a sm=
all
> > > unexpected change in layout?
> >
> > key and blob buffers are just two adjacent fixed sized byte arrays. So
> > I am not worried here as long as they stay adjacent (which has been
> > the case since trusted keys were introduced in the kernel).
>
> Yeah, that was my point, but fine if you don't believe it's an issue.
>

Does it resolve the issue with FFA ABI for you? It would be good to
have your Tested-by tag.

-Sumit

> Thanks,
> Jens
>
> >
> > -Sumit
> >
> > >
> > > Thanks,
> > > Jens
> > >
> > > > +     if (IS_ERR(reg_shm)) {
> > > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > > +             return PTR_ERR(reg_shm);
> > > >       }
> > > >
> > > >       inv_arg.func =3D TA_CMD_SEAL;
> > > > @@ -90,13 +82,13 @@ static int trusted_tee_seal(struct trusted_key_=
payload *p, char *datablob)
> > > >       inv_arg.num_params =3D 4;
> > > >
> > > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > > +     param[0].u.memref.shm =3D reg_shm;
> > > >       param[0].u.memref.size =3D p->key_len;
> > > >       param[0].u.memref.shm_offs =3D 0;
> > > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > > +     param[1].u.memref.shm =3D reg_shm;
> > > >       param[1].u.memref.size =3D sizeof(p->blob);
> > > > -     param[1].u.memref.shm_offs =3D 0;
> > > > +     param[1].u.memref.shm_offs =3D sizeof(p->key);
> > > >
> > > >       ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param)=
;
> > > >       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > > @@ -107,11 +99,7 @@ static int trusted_tee_seal(struct trusted_key_=
payload *p, char *datablob)
> > > >               p->blob_len =3D param[1].u.memref.size;
> > > >       }
> > > >
> > > > -out:
> > > > -     if (reg_shm_out)
> > > > -             tee_shm_free(reg_shm_out);
> > > > -     if (reg_shm_in)
> > > > -             tee_shm_free(reg_shm_in);
> > > > +     tee_shm_free(reg_shm);
> > > >
> > > >       return ret;
> > > >  }
> > > > @@ -124,24 +112,16 @@ static int trusted_tee_unseal(struct trusted_=
key_payload *p, char *datablob)
> > > >       int ret;
> > > >       struct tee_ioctl_invoke_arg inv_arg;
> > > >       struct tee_param param[4];
> > > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > > > +     struct tee_shm *reg_shm =3D NULL;
> > > >
> > > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > > >       memset(&param, 0, sizeof(param));
> > > >
> > > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->b=
lob,
> > > > -                                              p->blob_len);
> > > > -     if (IS_ERR(reg_shm_in)) {
> > > > -             dev_err(pvt_data.dev, "blob shm register failed\n");
> > > > -             return PTR_ERR(reg_shm_in);
> > > > -     }
> > > > -
> > > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->=
key,
> > > > -                                               sizeof(p->key));
> > > > -     if (IS_ERR(reg_shm_out)) {
> > > > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > > > -             ret =3D PTR_ERR(reg_shm_out);
> > > > -             goto out;
> > > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > > > +                                           sizeof(p->key) + sizeof=
(p->blob));
> > > > +     if (IS_ERR(reg_shm)) {
> > > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > > +             return PTR_ERR(reg_shm);
> > > >       }
> > > >
> > > >       inv_arg.func =3D TA_CMD_UNSEAL;
> > > > @@ -149,11 +129,11 @@ static int trusted_tee_unseal(struct trusted_=
key_payload *p, char *datablob)
> > > >       inv_arg.num_params =3D 4;
> > > >
> > > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > > +     param[0].u.memref.shm =3D reg_shm;
> > > >       param[0].u.memref.size =3D p->blob_len;
> > > > -     param[0].u.memref.shm_offs =3D 0;
> > > > +     param[0].u.memref.shm_offs =3D sizeof(p->key);
> > > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > > +     param[1].u.memref.shm =3D reg_shm;
> > > >       param[1].u.memref.size =3D sizeof(p->key);
> > > >       param[1].u.memref.shm_offs =3D 0;
> > > >
> > > > @@ -166,11 +146,7 @@ static int trusted_tee_unseal(struct trusted_k=
ey_payload *p, char *datablob)
> > > >               p->key_len =3D param[1].u.memref.size;
> > > >       }
> > > >
> > > > -out:
> > > > -     if (reg_shm_out)
> > > > -             tee_shm_free(reg_shm_out);
> > > > -     if (reg_shm_in)
> > > > -             tee_shm_free(reg_shm_in);
> > > > +     tee_shm_free(reg_shm);
> > > >
> > > >       return ret;
> > > >  }
> > > > --
> > > > 2.34.1
> > > >
