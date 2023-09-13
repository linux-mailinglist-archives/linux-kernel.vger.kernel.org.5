Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225279E25C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbjIMIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239080AbjIMIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:39:44 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5422919AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:39:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76ee895a3cbso412447185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694594379; x=1695199179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1mKjggC2W075nhibpYVKP9D/0yEo+GeUcVpdjmDCWk=;
        b=SOc/gDJCxJRHVcWvLWbtNaqC0skqTRJfcIIJ1quV+vTEq1mpbXalmkgQxClKohdGAy
         TcBZSlkf4Z4MSP5D/MnYwp59JKYcoU89LlJzPdwHOlVK+jb7PHjmRxF+h0BL25aXjH2S
         g1v0Y/wAj4XwlyBpa/tW2zVAD43sbUEgGY5nHwefA3uKglkWThbCjDWBm1kAX59wmEKo
         /IbnIxE6TT+lCOqFTufs2H4mBX+iLMBlX9kPVc+3riP6u4ltHCS5k4EHhfdUFCwF3Q50
         1FwaUTUpMiVqeX+btk/+EbdUembEOkazKJLnpAEFGathdnU9bOgahzPCjMmqgNscjf0r
         Vc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594379; x=1695199179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1mKjggC2W075nhibpYVKP9D/0yEo+GeUcVpdjmDCWk=;
        b=JC2jYg3SJcSlgrFwXQTeO8uwQ7lcisRh+NCGhKA3Smap2oet5HMz+dNg5DXim9sidk
         uLPzjlPB/nU7pvctc3WQ8A7CA6q2mZnquMHd7T/8ZEJ7nJxSZuFMpsONHYA56pmxIY9r
         CmyjwRj5HEOwHlBrpChUgYdgCkfm2vOBgktIMZ/NUHAmM4KSCfUS+GrIBlmA+ieo4E4Y
         +45ZpYi0HKCm2hiyKKokwXy7HB4/vjeKv2O3DL7JFr+1fOLi4bAAU1/jHRxJJjG+BTeT
         EU5bC5HDTXlsQepzpofvExt4oUYGh1yHq6DkYbxbzMAk9/5hkBkROMaodLHK24YRXnjl
         C3Aw==
X-Gm-Message-State: AOJu0Yzs/gH0NqeQB+xnmu/mp0FmYedZclF8T3w2tppTA0GJ3+HukrTa
        B3eaE6dXlp5Dv0/Ndy9Vk/mU75RmPrV+hoVVTAz8VQGQW6SmEes3
X-Google-Smtp-Source: AGHT+IE37xJVgvxb0xAug6TV9ASnd/M5FkcUhfc6k/7Z3zfV96Aej1snAQOH1dUz9rXZIJ8BRPW2wfgiZIrg3KKeW7o=
X-Received: by 2002:a05:6214:1042:b0:63d:d83:8808 with SMTP id
 l2-20020a056214104200b0063d0d838808mr1796132qvr.63.1694594379391; Wed, 13 Sep
 2023 01:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230810144943.34976-1-yuehaibing@huawei.com> <CAFA6WYPsaJdGT9kS4ygHNRYDpX8bRaY__EwZWuCF-x-DgWUDhQ@mail.gmail.com>
In-Reply-To: <CAFA6WYPsaJdGT9kS4ygHNRYDpX8bRaY__EwZWuCF-x-DgWUDhQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 13 Sep 2023 10:39:28 +0200
Message-ID: <CAHUa44Gfz8OBm6WEROeKt00O-vj6FtM5f5GXVRHXxF1Vs+i5mQ@mail.gmail.com>
Subject: Re: [PATCH -next] tee: Remove unused declarations
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Yue Haibing <yuehaibing@huawei.com>, etienne.carriere@linaro.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:11=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Thu, 10 Aug 2023 at 20:19, Yue Haibing <yuehaibing@huawei.com> wrote:
> >
> > Commit 4fb0a5eb364d ("tee: add OP-TEE driver") declared but never imple=
mented
> > optee_supp_read()/optee_supp_write().
> > Commit 967c9cca2cc5 ("tee: generic TEE subsystem") never implemented te=
e_shm_init().
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> > ---
> >  drivers/tee/optee/optee_private.h | 2 --
> >  drivers/tee/tee_private.h         | 2 --
> >  2 files changed, 4 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/opte=
e_private.h
> > index 72685ee0d53f..6bb5cae09688 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -238,8 +238,6 @@ int optee_notif_send(struct optee *optee, u_int key=
);
> >  u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_=
params,
> >                         struct tee_param *param);
> >
> > -int optee_supp_read(struct tee_context *ctx, void __user *buf, size_t =
len);
> > -int optee_supp_write(struct tee_context *ctx, void __user *buf, size_t=
 len);
> >  void optee_supp_init(struct optee_supp *supp);
> >  void optee_supp_uninit(struct optee_supp *supp);
> >  void optee_supp_release(struct optee_supp *supp);
> > diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> > index 409cadcc1cff..754e11dcb240 100644
> > --- a/drivers/tee/tee_private.h
> > +++ b/drivers/tee/tee_private.h
> > @@ -47,8 +47,6 @@ struct tee_device {
> >         struct tee_shm_pool *pool;
> >  };
> >
> > -int tee_shm_init(void);
> > -
> >  int tee_shm_get_fd(struct tee_shm *shm);
> >
> >  bool tee_device_get(struct tee_device *teedev);
> > --
> > 2.34.1
> >
