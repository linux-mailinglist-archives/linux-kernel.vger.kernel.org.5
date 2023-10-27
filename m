Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB57D9A2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345977AbjJ0NjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjJ0NjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:39:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C94D116
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:39:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40806e4106dso12429815e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698413943; x=1699018743; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/rNM3qG+7ShmUtIGpCjGm6Sq06g6NUkhuZrSKUSc88Q=;
        b=gZJ53BAqxVcxI4iJcamEZuzU0bP7E/tZlUCJSz+f5uCFND7/sfdNHxcsPsxbTJmopM
         xLlxs0IBS8F3BLBOrtJ2JNamf+p+rQOuBHO/TnFqJ07teNp5pLTes4Zl/YYBW2R+IlBW
         hgTkuOEDd94GnBthSINSgewlYzaz2/ndZwAR0P6MquPTqnqGwd9uRL60CGpMUo2siDDU
         x2RSv/SDJrzt0UrhsBynZn36faLZKiuF1WrNtXx2KQSRdSRxG96NIGmU0SFbsdPL61o2
         O0t/FpZYriWRgi2N+7WW0djcprA9O2gOsSiNk944WbkmBBIZ8vqCBcxBFozGrHEjaARt
         Ncjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698413943; x=1699018743;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rNM3qG+7ShmUtIGpCjGm6Sq06g6NUkhuZrSKUSc88Q=;
        b=Rs4ue7oiNNkXvKrASs00lDYbTyWHjYNcfZWo02HkQ4/xlxuEz+tEZ0SIk1CpNVQAoD
         l8mEH2z7Enz7/3xl0L1FWdVc7+tRqwxfPgfkPPrsz4WWuQBwCrPRIq7ALLo8F9sLR9VW
         allZBBsRTNfcBdE9G8FvRDNYo1Cbh56g5eW5AysXY3BvCMq+gTaIPX+4UCc6n2/xK+Io
         HOFZO9A5qRYLmlEL7vZ9zQIir0RomoXrcoZSEEhsCw+J/SX0HDBfzeyFXxFgVZ0/b1nU
         are+fOsphTvPMH3qwZpSsu4PRrdzjewvDp28hdqD3/hs7LvCEUmimWq/vuJv1brX8hEu
         q4tw==
X-Gm-Message-State: AOJu0YxLSz9cZDPQe9onCxQhZI/HZN5zhsx40/h0+X80rFW6P7cl6T8u
        PYhp4dMLyfNEiIYNqaDUn+GpNw==
X-Google-Smtp-Source: AGHT+IGPIu+YxmBlnsCsqhU175AiGCa+jaIaQUU0rJVU2/20+2pO7GItM1hbViSEZ86YUnftB9p/lg==
X-Received: by 2002:a05:600c:3b03:b0:3fe:d67d:5040 with SMTP id m3-20020a05600c3b0300b003fed67d5040mr7041851wms.5.1698413942830;
        Fri, 27 Oct 2023 06:39:02 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b0032da35baf7bsm1775442wru.113.2023.10.27.06.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 06:39:02 -0700 (PDT)
Message-ID: <afe378bf254f6c4ac73bb55be3fa7422f2da3f5f.camel@linaro.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Daniel Rosenberg <drosen@google.com>,
        Alessio Balsini <balsini@android.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri, 27 Oct 2023 14:39:01 +0100
In-Reply-To: <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com>
References: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
         <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
         <fa3510f3-d3cc-45d2-b38e-e8717e2a9f83@ddn.com>
         <1b03f355170333f20ee20e47c5f355dc73d3a91c.camel@linaro.org>
         <9afc3152-5448-42eb-a7f4-4167fc8bc589@ddn.com>
         <5cd87a64-c506-46f2-9fed-ac8a74658631@ddn.com>
         <8ae8ce4d-6323-4160-848a-5e94895ae60e@leemhuis.info>
         <CAOssrKdvy9qTGSwwPVqYLAYYEk0jbqhGg4Lz=jEff7U58O4Yqw@mail.gmail.com>
         <2023102731-wobbly-glimpse-97f5@gregkh>
         <CAOssrKfNkMmHB2oHHO8gWbzDX27vS--e9dZoh_Mjv-17mSUTBw@mail.gmail.com>
         <2023102740-think-hatless-ab87@gregkh>
         <CAOssrKd-O1JKEPzvnM1VkQ0-oTpDv0RfY6B5oF5p63AtQ4HoqA@mail.gmail.com>
         <689f677b84b484636b673b362b17a6501a056968.camel@linaro.org>
         <CAOssrKfP+t-cy322ujizQofgZkPZsBu1H4+zfbWNEFCmTsXwug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-27 at 15:24 +0200, Miklos Szeredi wrote:
> On Fri, Oct 27, 2023 at 3:14=E2=80=AFPM Andr=C3=A9 Draszik
> <andre.draszik@linaro.org> wrote:
>=20
> > The patch in question has broken all users that use the higher
> > flags
> > and that don't use your version of libfuse, not just Android.
> > You're
> > filtering them out now when you didn't at the time that those
> > ('official) high flags were added. There are a couple more high
> > flags
> > than just the one that Android added.
>=20
> Okay.=C2=A0 Where are all those users?

That's not the point. The point is the kernel<->user API has rendered
them too non-working.

> =C2=A0 Why haven't they reported this?

Again, not the point. If I was to ask my crystal ball, Android is
trying to track the upstream kernel closely, others might not and might
not have bumped into this issue yet. Still, not the point.


Cheers,
A.

