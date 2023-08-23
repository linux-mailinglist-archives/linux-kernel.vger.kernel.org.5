Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D65785238
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjHWICw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbjHWICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:02:13 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8CCE6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:02:08 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-64c1d487e72so27704896d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692777728; x=1693382528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BSjtokwFpqc/G+xGehpwaT4EtO60DWjc8ZrclKikoE=;
        b=NUv0XojToaQWV2XEJ0LjEaacdyesICYdKEdEtsWLVR+gLnOK6GvLf9w9JxEI+NHpdX
         rZdNIUEDcW2bSKm3pWjw8CGZcxG64UPzGCHsUOxNUCofQHdspxVGdkjyLHEvw9Hw0hwC
         Hcw3hZ+24CtPsXqxEI6L8j7lSHggn6dtC/Zaf4Yg46OYOYD8s9ovcvizJKZ0TugHqOa0
         iBUzb6U6/4Zl9XxzB6/iIfxif5I9V1Kgofp1aU2ZGAw1SATOLa+gxihRyiweB7AJR2Y9
         y5lUYJPtjsd8mnfqbf6czlhVih7QoVzDlC5bmVoV5lZWvGyt3HeBs7Z3VipaUQtNAa4X
         K7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692777728; x=1693382528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BSjtokwFpqc/G+xGehpwaT4EtO60DWjc8ZrclKikoE=;
        b=Cgga3c3lu6djXtqcvmQne2aBIZBQWrAzaSAQDW4FmC+WxeX9hl0axPowjTkLut+MTp
         vmdMlFjdbLA7DmVY1LAubC2U0uJarhQrjUpMNxAog+m5qIPloUKzN4ilQIj1OsbK1N7Q
         gFNDD0MvgSruyIqMWr5AvrwEWTIv5IKFzSWqof+aniFNpkUr/ilWBG3St6KzePBHgP3F
         IigbEZ3ogmCr+IcNDVt4D/u+cDkFErmOSDCRmTxtMl4mg8o4xCHC1B514ReS3kjZ1oA2
         MV24e0zOR9ipU1ujgKXxlRHKxE+iSUYaXv1xihw9SO8d7uo03vw7Et+rUzDSJElHAL4l
         CsCQ==
X-Gm-Message-State: AOJu0Yx6/Zui0ObnCEJy2OYOCjUESvmtxOfFdGD9rWo9g7kGEkxAQEHk
        D3MkAdP8WNEOLbz1nkhWcaE7q656EyrRKc+8V6LLujUBqwcgmQVp
X-Google-Smtp-Source: AGHT+IHCXW+5AvKIH5eH5zGGQo7Y2etowbNPiVhAZnAi25/ajgJmtsE/jx/8U3q4/SWOYOX/1wCO3kPrZQDPY2IF2Us=
X-Received: by 2002:a0c:f910:0:b0:647:248b:3614 with SMTP id
 v16-20020a0cf910000000b00647248b3614mr11654949qvn.4.1692777727944; Wed, 23
 Aug 2023 01:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230822112933.1550062-1-sumit.garg@linaro.org>
 <20230822125555.GA82256@rayden> <CAFA6WYPy=yxGg1HbT+ipWJFpxiJeUGK6BSgMhtRPd=zmKef-cw@mail.gmail.com>
In-Reply-To: <CAFA6WYPy=yxGg1HbT+ipWJFpxiJeUGK6BSgMhtRPd=zmKef-cw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 23 Aug 2023 10:01:56 +0200
Message-ID: <CAHUa44G9jCeHcRq=AZeieaTPWN_tpOVKeJNY=777QAh-bw1QNg@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 8:55=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Tue, 22 Aug 2023 at 18:25, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Tue, Aug 22, 2023 at 04:59:33PM +0530, Sumit Garg wrote:
> > > The OP-TEE driver using the old SMC based ABI permits overlapping sha=
red
> > > buffers, but with the new FF-A based ABI each physical page may only
> > > be registered once.
> > >
> > > As the key and blob buffer are allocated adjancently, there is no nee=
d
> > > for redundant register shared memory invocation. Also, it is incompat=
ibile
> > > with FF-A based ABI limitation. So refactor register shared memory
> > > implementation to use only single invocation to register both key and=
 blob
> > > buffers.
> > >
> > > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > > Reported-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tee.c | 64 ++++++++--------------=
--
> > >  1 file changed, 20 insertions(+), 44 deletions(-)
> > >
> > > diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys=
/trusted-keys/trusted_tee.c
> > > index ac3e270ade69..aa3d477de6db 100644
> > > --- a/security/keys/trusted-keys/trusted_tee.c
> > > +++ b/security/keys/trusted-keys/trusted_tee.c
> > > @@ -65,24 +65,16 @@ static int trusted_tee_seal(struct trusted_key_pa=
yload *p, char *datablob)
> > >       int ret;
> > >       struct tee_ioctl_invoke_arg inv_arg;
> > >       struct tee_param param[4];
> > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > > +     struct tee_shm *reg_shm =3D NULL;
> > >
> > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > >       memset(&param, 0, sizeof(param));
> > >
> > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key=
,
> > > -                                              p->key_len);
> > > -     if (IS_ERR(reg_shm_in)) {
> > > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > > -             return PTR_ERR(reg_shm_in);
> > > -     }
> > > -
> > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->bl=
ob,
> > > -                                               sizeof(p->blob));
> > > -     if (IS_ERR(reg_shm_out)) {
> > > -             dev_err(pvt_data.dev, "blob shm register failed\n");
> > > -             ret =3D PTR_ERR(reg_shm_out);
> > > -             goto out;
> > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > > +                                           sizeof(p->key) + sizeof(p=
->blob));
> >
> > This is somewhat fragile. What if struct trusted_key_payload has a smal=
l
> > unexpected change in layout?
>
> key and blob buffers are just two adjacent fixed sized byte arrays. So
> I am not worried here as long as they stay adjacent (which has been
> the case since trusted keys were introduced in the kernel).

Yeah, that was my point, but fine if you don't believe it's an issue.

Thanks,
Jens

>
> -Sumit
>
> >
> > Thanks,
> > Jens
> >
> > > +     if (IS_ERR(reg_shm)) {
> > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > +             return PTR_ERR(reg_shm);
> > >       }
> > >
> > >       inv_arg.func =3D TA_CMD_SEAL;
> > > @@ -90,13 +82,13 @@ static int trusted_tee_seal(struct trusted_key_pa=
yload *p, char *datablob)
> > >       inv_arg.num_params =3D 4;
> > >
> > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > +     param[0].u.memref.shm =3D reg_shm;
> > >       param[0].u.memref.size =3D p->key_len;
> > >       param[0].u.memref.shm_offs =3D 0;
> > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > +     param[1].u.memref.shm =3D reg_shm;
> > >       param[1].u.memref.size =3D sizeof(p->blob);
> > > -     param[1].u.memref.shm_offs =3D 0;
> > > +     param[1].u.memref.shm_offs =3D sizeof(p->key);
> > >
> > >       ret =3D tee_client_invoke_func(pvt_data.ctx, &inv_arg, param);
> > >       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> > > @@ -107,11 +99,7 @@ static int trusted_tee_seal(struct trusted_key_pa=
yload *p, char *datablob)
> > >               p->blob_len =3D param[1].u.memref.size;
> > >       }
> > >
> > > -out:
> > > -     if (reg_shm_out)
> > > -             tee_shm_free(reg_shm_out);
> > > -     if (reg_shm_in)
> > > -             tee_shm_free(reg_shm_in);
> > > +     tee_shm_free(reg_shm);
> > >
> > >       return ret;
> > >  }
> > > @@ -124,24 +112,16 @@ static int trusted_tee_unseal(struct trusted_ke=
y_payload *p, char *datablob)
> > >       int ret;
> > >       struct tee_ioctl_invoke_arg inv_arg;
> > >       struct tee_param param[4];
> > > -     struct tee_shm *reg_shm_in =3D NULL, *reg_shm_out =3D NULL;
> > > +     struct tee_shm *reg_shm =3D NULL;
> > >
> > >       memset(&inv_arg, 0, sizeof(inv_arg));
> > >       memset(&param, 0, sizeof(param));
> > >
> > > -     reg_shm_in =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->blo=
b,
> > > -                                              p->blob_len);
> > > -     if (IS_ERR(reg_shm_in)) {
> > > -             dev_err(pvt_data.dev, "blob shm register failed\n");
> > > -             return PTR_ERR(reg_shm_in);
> > > -     }
> > > -
> > > -     reg_shm_out =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->ke=
y,
> > > -                                               sizeof(p->key));
> > > -     if (IS_ERR(reg_shm_out)) {
> > > -             dev_err(pvt_data.dev, "key shm register failed\n");
> > > -             ret =3D PTR_ERR(reg_shm_out);
> > > -             goto out;
> > > +     reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> > > +                                           sizeof(p->key) + sizeof(p=
->blob));
> > > +     if (IS_ERR(reg_shm)) {
> > > +             dev_err(pvt_data.dev, "shm register failed\n");
> > > +             return PTR_ERR(reg_shm);
> > >       }
> > >
> > >       inv_arg.func =3D TA_CMD_UNSEAL;
> > > @@ -149,11 +129,11 @@ static int trusted_tee_unseal(struct trusted_ke=
y_payload *p, char *datablob)
> > >       inv_arg.num_params =3D 4;
> > >
> > >       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> > > -     param[0].u.memref.shm =3D reg_shm_in;
> > > +     param[0].u.memref.shm =3D reg_shm;
> > >       param[0].u.memref.size =3D p->blob_len;
> > > -     param[0].u.memref.shm_offs =3D 0;
> > > +     param[0].u.memref.shm_offs =3D sizeof(p->key);
> > >       param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> > > -     param[1].u.memref.shm =3D reg_shm_out;
> > > +     param[1].u.memref.shm =3D reg_shm;
> > >       param[1].u.memref.size =3D sizeof(p->key);
> > >       param[1].u.memref.shm_offs =3D 0;
> > >
> > > @@ -166,11 +146,7 @@ static int trusted_tee_unseal(struct trusted_key=
_payload *p, char *datablob)
> > >               p->key_len =3D param[1].u.memref.size;
> > >       }
> > >
> > > -out:
> > > -     if (reg_shm_out)
> > > -             tee_shm_free(reg_shm_out);
> > > -     if (reg_shm_in)
> > > -             tee_shm_free(reg_shm_in);
> > > +     tee_shm_free(reg_shm);
> > >
> > >       return ret;
> > >  }
> > > --
> > > 2.34.1
> > >
