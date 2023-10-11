Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418CA7C4C1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344899AbjJKHjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjJKHjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:39:32 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2667792
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:39:30 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7b5f0bbe137so788125241.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1697009969; x=1697614769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWrbWu0Oap0wNNOVGtrSvCx+2kjgQ+v9eimTvsjr3Uc=;
        b=UbzsGaAvjJDDjAtrxt+DGTCOaCO5LOui8STj4oM+YBVj56kHK7hyLZHZAskHjMOUJD
         uTnsH07u4d6kXZI0GBcA6moJbihWf7FfkLFqr5tcYgZ+sWIyiVX3p9NXVg2mDitU8nqL
         TykxsDWeF1+RhnwtdWj5kT6z8pL/M2r9SVT8L+F7sELKxlWtMRPBdIDQH6uw1m6JJn68
         zE9xbn9If3mWCzMW8Pxhzh8wVza72sudkeOBxqkFsxUOtsR2EmrZ14JzsdGXtVclHN6b
         3qN0dYqAvIF9rsQM3t/nH2N8DFj6+m6D7kzbqaN4I83NNflAq3FSNQv37c0FMLnschfr
         dPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697009969; x=1697614769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWrbWu0Oap0wNNOVGtrSvCx+2kjgQ+v9eimTvsjr3Uc=;
        b=PXzKz8+MpUcEzc5hXrgw942r3o2RIFmYRqQ4VLWB5V1qMb/4iSnkSnNsRwAxDoaj5y
         xS6Hzr6muOUHUSR41HMJ6OZ72swGPC3vmmAL5AIBY8y0cFQZmaF/vrOhoYJPF9j4f93J
         Wg7QUDssomE/PNCd9MQNvYTfB5DawAn6yp7yaP+fWy1C/VHjrU7/X0HSalfVwEMVZwM7
         ZVZzIqaiWwADDpL+iq3IyNWe9f04p+gRD9Waiy6zQBhkG42SzmVr7uCUqbyuDFd6QYjd
         4MjB6YS/g0QsIIWgliNhyRjeUWjsEJChv3WYmfD2f0R6jWPk2iHKf98sKnrUHdmSl27Q
         nRsw==
X-Gm-Message-State: AOJu0YzPPan78yesbYG4UDQjTcurMR7Y6On0urwxm+KkpeKdDKD5uBAh
        VvDqz4ejVI3j5oJvkoGsqUIsBQk0l6X/UEUo1msK7w==
X-Google-Smtp-Source: AGHT+IGT+p8cX4ZYoTo/8ckQrPA8I5Vc5IL/grT0LsRd6i2r04fEYIazqISHa9JfJgrXhgPtoVAT7EJr9hg2NXYOvWk=
X-Received: by 2002:a67:e2da:0:b0:452:5e2e:a4e1 with SMTP id
 i26-20020a67e2da000000b004525e2ea4e1mr19185104vsm.14.1697009969146; Wed, 11
 Oct 2023 00:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-5-brgl@bgdev.pl>
 <f6jspdoeyv6ntcrl6qndy2ud3mcdkoxxcnzqm3qpbtcd3ztdpi@7iw5f5og7is2>
 <CAMRc=MchBQrpSqHHs-cD0RmOdSoKt2SLd76a97E8mSmHYGUCUg@mail.gmail.com> <pmmetoy5pb6khrjzsg6cd565cw3eowvs5i67465ne4xlqkrqgk@befdv3vfran3>
In-Reply-To: <pmmetoy5pb6khrjzsg6cd565cw3eowvs5i67465ne4xlqkrqgk@befdv3vfran3>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 11 Oct 2023 09:39:18 +0200
Message-ID: <CAMRc=MfnzH-oa926MQ4w+ELKc_S=PnTkmsmtEoiofp4om6mA8w@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] firmware: qcom: add a dedicated TrustZone buffer allocator
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:48=E2=80=AFPM Andrew Halaney <ahalaney@redhat.co=
m> wrote:
>
> On Tue, Oct 10, 2023 at 10:26:34AM +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 9, 2023 at 11:28=E2=80=AFPM Andrew Halaney <ahalaney@redhat=
.com> wrote:
> > >
> > > On Mon, Oct 09, 2023 at 05:34:16PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > We have several SCM calls that require passing buffers to the Trust=
Zone
> > > > on top of the SMC core which allocates memory for calls that requir=
e
> > > > more than 4 arguments.
> > > >
> > > > Currently every user does their own thing which leads to code
> > > > duplication. Many users call dma_alloc_coherent() for every call wh=
ich
> > > > is terribly unperformant (speed- and size-wise).
> > > >
> > > > Provide a set of library functions for creating and managing pool o=
f
> > > > memory which is suitable for sharing with the TrustZone, that is:
> > > > page-aligned, contiguous and non-cachable as well as provides a way=
 of
> > > > mapping of kernel virtual addresses to physical space.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > > ---
> >
> > [snip]
> >
> > >
> > > I got these warnings with this series:
> > >
> > >     ahalaney@fedora ~/git/linux-next (git)-[7204cc6c3d73] % ARCH=3Dar=
m64 CROSS_COMPILE=3Daarch64-linux-gnu- make W=3D1 C=3D2 drivers/firmware/qc=
om/
> > >     drivers/firmware/qcom/qcom_tzmem.c:137: warning: Function paramet=
er or member 'size' not described in 'qcom_tzmem_pool_new'
> > >       CHECK   drivers/firmware/qcom/qcom_tzmem.c
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect typ=
e in assignment (different address spaces)
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slo=
t
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] =
__rcu **
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect typ=
e in assignment (different address spaces)
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slo=
t
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] =
__rcu **
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect typ=
e in argument 1 (different address spaces)
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void [node=
ref] __rcu **slot
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void **slot
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect typ=
e in assignment (different address spaces)
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slo=
t
> > >     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] =
__rcu **
> > >     drivers/firmware/qcom/qcom_tzmem.c:339:13: warning: context imbal=
ance in 'qcom_tzmem_to_phys' - wrong count at exit
> >
> > I fixed the other ones but this one I think comes from CHECK not
> > dealing correctly with the spinlock guard.
> >
> > >
> > >
> > > All are confusing me, size seems described, I don't know much about
> > > radix tree usage / rcu, and the locking in qcom_tzmem_to_phys seems s=
ane
> > > to me but I'm still grappling with the new syntax.
> > >
> > > For the one address space one, I _think_ maybe a diff like this is in
> > > order?
> > >
> > >     diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmwar=
e/qcom/qcom_tzmem.c
> > >     index b3137844fe43..5b409615198d 100644
> > >     --- a/drivers/firmware/qcom/qcom_tzmem.c
> > >     +++ b/drivers/firmware/qcom/qcom_tzmem.c
> > >     @@ -193,7 +193,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_p=
ool *pool)
> > >             struct qcom_tzmem_chunk *chunk;
> > >             struct radix_tree_iter iter;
> > >             bool non_empty =3D false;
> > >     -       void **slot;
> > >     +       void __rcu **slot;
> > >
> > >             if (!pool)
> > >                     return;
> > >     @@ -202,7 +202,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_p=
ool *pool)
> > >
> > >             scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
> > >                     radix_tree_for_each_slot(slot, &qcom_tzmem_chunks=
, &iter, 0) {
> > >     -                       chunk =3D *slot;
> > >     +                       chunk =3D radix_tree_deref_slot_protected=
(slot, &qcom_tzmem_chunks_lock);
> >
> > We need to keep the lock taken for the duration of the looping so we
> > can use the regular radix_tree_deref_slot().
>
> IIUC, using the protected version is preferable since you already
> have the lock in hand: https://www.kernel.org/doc/html/latest/RCU/whatisR=
CU.html#id2
>
> Quote:
>     The variant rcu_dereference_protected() can be used outside of an RCU
>     read-side critical section as long as the usage is protected by locks
>     acquired by the update-side code. This variant avoids the lockdep war=
ning
>     that would happen when using (for example) rcu_dereference() without
>     rcu_read_lock() protection. Using rcu_dereference_protected() also ha=
s
>     the advantage of permitting compiler optimizations that rcu_dereferen=
ce()
>     must prohibit. The rcu_dereference_protected() variant takes a lockde=
p
>     expression to indicate which locks must be acquired by the caller.
>     If the indicated protection is not provided, a lockdep splat is emitt=
ed.
>
> Thanks,
> Andrew

I should have RTFM I guess. I assumed that the _protected() variant
just takes the indicated lock.

Thanks
Bart

>
>
> >
> > Bart
> >
> > >
> > >                             if (chunk->owner =3D=3D pool)
> > >                                     non_empty =3D true;
> > >
> > >
> > > Still planning on reviewing/testing the rest, but got tripped up ther=
e
> > > so thought I'd highlight it before doing the rest.
> > >
> > > Thanks,
> > > Andrew
> > >
> >
>
