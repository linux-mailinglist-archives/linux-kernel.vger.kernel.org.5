Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095E87BF342
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442269AbjJJGnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442277AbjJJGnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:43:03 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E697
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:43:02 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-45290cda80aso1830640137.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696920181; x=1697524981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lBvW18WLjUwg7G89PrHBEFb3Moi1YWmQfZD4XM9e7k=;
        b=LHJyQD6hwaQ80cVpJqKEOTrczTagmI+pTlfHLA4ykIEty4smjw2Be+asT3/K61bR2m
         T6RJe0j1An68xz37EPuJKgh2e/xwIsWoBWdc+GCr3FFms0eckFn+4X1nst2JPrnNaumX
         JlMpJ2cYioEuvYC/d6fL/V2JQSeTYQOLurfyCIACsj+4zT2r18ZKWTymSc5qRh4u7Eab
         WwqqP+agMsgTfab7qTpzn3aOv6REzSJdOHATNjQWl+ODjID4mlVXp7KNwPiBofaaPq5o
         u2AAbgZ5CcJTodtGkH+x1qwM4MK4AF3SWdpbFsPGt+L0o/vpIEX/LVtHQm42x5gBLK3I
         h+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696920181; x=1697524981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lBvW18WLjUwg7G89PrHBEFb3Moi1YWmQfZD4XM9e7k=;
        b=GYPIbjCpLFS5n2N3TzQ2ZyuoLdef2SXrxOY1l1nQ8IduB/HACMyy7NkJyFsFr38Wq0
         MqyCkDHMOyyEfRGJzY7fjRERMW+tvigi2WzRxk9w7AIIEak0B2FhE+XQ+KcJjCtBG5fD
         5wPrn0x0G2sWOHIkje+PpIX7nHOJ0xso7hqkXSz9QFfoeQ/XeOKARaLuUefKk0LlG39g
         9d3AEmZALUvBTTnTfJDjvt4sCYtne/D2DxlwH3jl9sLukbhrSQZ97VjvVex4ae5PHAWQ
         rYOlWZnb3ECdtzg4cZwGqIel4B/OGymwRPi9MjHMUzzgBz+Z1oMOlMG2BbNSgnCw9Z6T
         D/NA==
X-Gm-Message-State: AOJu0YzmmBNmDAhxhK4i0InzmEBOgTXofhOdJ2+2DyKq4r9Ml5e/sjA9
        J7g3IntOogBlZ4kfJyMxFS+IVh+YIQc8GbkfzbuMAg==
X-Google-Smtp-Source: AGHT+IGeVcGNuWOPIH8HtKiVtH22zKN3AzMOIsJxEowAVkv8MKw553qR/wHCRr8WCidIt1jQFj1pmC7LcDjs21qLs3Y=
X-Received: by 2002:a67:ce13:0:b0:44d:3d29:4940 with SMTP id
 s19-20020a67ce13000000b0044d3d294940mr9440631vsl.35.1696920181431; Mon, 09
 Oct 2023 23:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231009153427.20951-1-brgl@bgdev.pl> <20231009153427.20951-5-brgl@bgdev.pl>
 <f6jspdoeyv6ntcrl6qndy2ud3mcdkoxxcnzqm3qpbtcd3ztdpi@7iw5f5og7is2>
In-Reply-To: <f6jspdoeyv6ntcrl6qndy2ud3mcdkoxxcnzqm3qpbtcd3ztdpi@7iw5f5og7is2>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Oct 2023 08:42:50 +0200
Message-ID: <CAMRc=Mdj6fkHaig131=LG2BtzS67mX6o-ornA=Bzo8oBA1UT9w@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 11:28=E2=80=AFPM Andrew Halaney <ahalaney@redhat.com=
> wrote:
>
> On Mon, Oct 09, 2023 at 05:34:16PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > We have several SCM calls that require passing buffers to the TrustZone
> > on top of the SMC core which allocates memory for calls that require
> > more than 4 arguments.
> >
> > Currently every user does their own thing which leads to code
> > duplication. Many users call dma_alloc_coherent() for every call which
> > is terribly unperformant (speed- and size-wise).
> >
> > Provide a set of library functions for creating and managing pool of
> > memory which is suitable for sharing with the TrustZone, that is:
> > page-aligned, contiguous and non-cachable as well as provides a way of
> > mapping of kernel virtual addresses to physical space.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---

[snip]

>
> I got these warnings with this series:
>
>     ahalaney@fedora ~/git/linux-next (git)-[7204cc6c3d73] % ARCH=3Darm64 =
CROSS_COMPILE=3Daarch64-linux-gnu- make W=3D1 C=3D2 drivers/firmware/qcom/
>     drivers/firmware/qcom/qcom_tzmem.c:137: warning: Function parameter o=
r member 'size' not described in 'qcom_tzmem_pool_new'
>       CHECK   drivers/firmware/qcom/qcom_tzmem.c
>     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in=
 assignment (different address spaces)
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rc=
u **
>     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in=
 assignment (different address spaces)
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rc=
u **
>     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in=
 argument 1 (different address spaces)
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void [noderef]=
 __rcu **slot
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void **slot
>     drivers/firmware/qcom/qcom_tzmem.c:204:17: warning: incorrect type in=
 assignment (different address spaces)
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    expected void **slot
>     drivers/firmware/qcom/qcom_tzmem.c:204:17:    got void [noderef] __rc=
u **
>     drivers/firmware/qcom/qcom_tzmem.c:339:13: warning: context imbalance=
 in 'qcom_tzmem_to_phys' - wrong count at exit
>
>
> All are confusing me, size seems described, I don't know much about
> radix tree usage / rcu, and the locking in qcom_tzmem_to_phys seems sane
> to me but I'm still grappling with the new syntax.
>
> For the one address space one, I _think_ maybe a diff like this is in
> order?
>
>     diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qc=
om/qcom_tzmem.c
>     index b3137844fe43..5b409615198d 100644
>     --- a/drivers/firmware/qcom/qcom_tzmem.c
>     +++ b/drivers/firmware/qcom/qcom_tzmem.c
>     @@ -193,7 +193,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_pool =
*pool)
>             struct qcom_tzmem_chunk *chunk;
>             struct radix_tree_iter iter;
>             bool non_empty =3D false;
>     -       void **slot;
>     +       void __rcu **slot;
>
>             if (!pool)
>                     return;
>     @@ -202,7 +202,7 @@ void qcom_tzmem_pool_free(struct qcom_tzmem_pool =
*pool)
>
>             scoped_guard(spinlock_irqsave, &qcom_tzmem_chunks_lock) {
>                     radix_tree_for_each_slot(slot, &qcom_tzmem_chunks, &i=
ter, 0) {
>     -                       chunk =3D *slot;
>     +                       chunk =3D radix_tree_deref_slot_protected(slo=
t, &qcom_tzmem_chunks_lock);
>
>                             if (chunk->owner =3D=3D pool)
>                                     non_empty =3D true;
>

Ah, I was thinking about it but then figured that I already use a
spinlock and I didn't see these errors on my side so decided to
dereference it normally.

I'll check it again.

Bart

>
> Still planning on reviewing/testing the rest, but got tripped up there
> so thought I'd highlight it before doing the rest.
>
> Thanks,
> Andrew
>
