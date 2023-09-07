Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA1796ED7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbjIGCVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIGCVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:21:54 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73819A0;
        Wed,  6 Sep 2023 19:21:49 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a56401b9aso443812b3a.1;
        Wed, 06 Sep 2023 19:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694053309; x=1694658109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:to:date:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zrzp+LrMkD8774TjBw8qs3UdHHFa6iqgdGHZnd8QV0M=;
        b=qpejSjsjRLDqHRJhEuFs9Mr7epB9VX7jFd+wkVYZa6vJ4qwk4Y3bT8cmOfowe/qnNW
         GTF/CrYTh4f0UuwJxygBDK8piMPDPqBfFQU8ZtvJhzB1RTSFNe2ohpDF9SeFPwa7wZXa
         9AYjc8Od+Gfcrf/WFafX3JOytzZO0zZr3oAdodieVUvNvEiV4EB/lyXupXMC0VZvCLij
         G1bPHZMlTsUU8MjstbX2omR5JJqQU+mPUlcOc/qwnPHA7cQZbhGCBw883ze9ER1x7w+7
         uT6aTngyEyWS/SphADJuCG3QwKM06X2ebhvy3bUgyYvZPcwpp6xaI52r3QnqHCRqEn3W
         csNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694053309; x=1694658109;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:to:date:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zrzp+LrMkD8774TjBw8qs3UdHHFa6iqgdGHZnd8QV0M=;
        b=NqlQAVRfteiILRJPVEKDCOc6+K5OHN9/NPKdsCRgZU44vWU6gfCkbY6fV5WQ/X46i8
         8l4UulUlcinZXIwE2hkpuT8GJRGLyehjnWJomtCv2t9w8jT/W0xV/ZQCutobAp2uoxrj
         8LSAuyNh0ipfWCe50Yhe/xOjffUzz6lAa4YqcM6h0Lk6EqSKjNmYqVlwqAvtmdhlhV7F
         oxQi205lMX3ND27dDV41n5mcBNtlN+PEuEgE52yi4HyZSwwbgPPGDBlS6uv9Qli7y2A8
         jmi2XycpEWW3E/3y0OhZ/4McgWhMEPl1Po0qyrV5OBtE2bVTrRCzocvcljeZQazNygst
         EShg==
X-Gm-Message-State: AOJu0YwQcHxj27z7/cN0OXq/1obcoPvgDVEZP1eP6Fd4d5XBpKGiOTgz
        HWI4w4Fzr+OtxP+QXU+mkRpQXk0d9x4=
X-Google-Smtp-Source: AGHT+IHmYU1WN263QpinG68LrFn66v8fr8GJ6Z0V5J0QGCjn3TGdhBPHoxSrcY/c4+4HtGeIiBQG+g==
X-Received: by 2002:a05:6a00:b95:b0:686:fd66:a41c with SMTP id g21-20020a056a000b9500b00686fd66a41cmr17566102pfj.17.1694053308208;
        Wed, 06 Sep 2023 19:21:48 -0700 (PDT)
Received: from slk15.local.net (n58-108-90-185.meb1.vic.optusnet.com.au. [58.108.90.185])
        by smtp.gmail.com with ESMTPSA id v10-20020a62ac0a000000b0063b96574b8bsm11354180pfe.220.2023.09.06.19.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 19:21:47 -0700 (PDT)
Sender: Duncan Roe <duncan.roe2@gmail.com>
From:   Duncan Roe <duncan_roe@optusnet.com.au>
X-Google-Original-From: Duncan Roe <dunc@slk15.local.net>
Date:   Thu, 7 Sep 2023 12:21:43 +1000
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi/netfilter: Change netfilter hook verdict code
 definition from macro to enum
Message-ID: <ZPkzt56kHLnHSJR9@slk15.local.net>
Reply-To: duncan_roe@optusnet.com.au
Mail-Followup-To: Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org
References: <20230904130201.14632-1-00107082@163.com>
 <cc6e3tukgqhi5y4uhepntrpf272o652pytuynj4nijsf5bkgjq@rgnbhckr3p4w>
 <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:57:56AM +0800, David Wang wrote:
>
>
> At 2023-09-06 00:38:02, "Daniel Xu" <dxu@dxuuu.xyz> wrote:
> >Hi David,
> >
> >On Mon, Sep 04, 2023 at 09:02:02PM +0800, David Wang wrote:
>
> >>  #include <linux/in6.h>
> >>
> >>  /* Responses from hook functions. */
> >> -#define NF_DROP 0
> >> -#define NF_ACCEPT 1
> >> -#define NF_STOLEN 2
> >> -#define NF_QUEUE 3
> >> -#define NF_REPEAT 4
> >> -#define NF_STOP 5	/* Deprecated, for userspace nf_queue compatibility. */
> >> -#define NF_MAX_VERDICT NF_STOP
> >> +enum {
> >> +	NF_DROP        = 0,
> >> +	NF_ACCEPT      = 1,
> >> +	NF_STOLEN      = 2,
> >> +	NF_QUEUE       = 3,
> >> +	NF_REPEAT      = 4,
> >> +	NF_STOP        = 5,	/* Deprecated, for userspace nf_queue compatibility. */
> >> +	NF_MAX_VERDICT = NF_STOP,
> >> +};
> >
> >Switching from macro to enum works for almost all use cases, but not
> >all. If someone if #ifdefing the symbols (which is plausible) this
> >change would break them.
> >
> >I think I've seen some other networking code define both enums and
> >macros. But it was a little ugly. Not sure if that is acceptable here or
> >not.
> >
> >[...]
> >
> >Thanks,
> >Daniel
>
>
> Thanks for the review~
> I do not have a strong reasoning to deny the possibility of breaking unexpected usage of this macros,
>
> but I also agree that it is ugly to use both enum and macro at the same time.
>
> Kind of don't know how to proceed from here now...

I did see code like that somewhere and wondered what was going on. The #define
lines were interspersed with the enum members which indeed looked ugly to me.

I'd suggest a block of #defines after the enum close e.g.

> #define NF_DROP NF_DROP
>...

perhaps with a comment preceding to advise that the defines were there for
the benefit of anyone using #ifdef.

Cheers ... Duncan.
