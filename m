Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C93579307C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244056AbjIEU4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbjIEU4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:56:34 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B222A113
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:56:25 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so47021011fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693947384; x=1694552184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9diK8PcHgpyU+i311Vkwvacj1OZq+KDSvCqh6K53Ntw=;
        b=J2PXZ57Exa3e3ftGJLJsjdiHAcCj2+F0V+KFdYhZm6HCrdsUxP2vdQS4LbP+cFy1JR
         8pCIeD0Aqd8fzIm526EI4TcFzRGJJCcdaFzYktNJ6iLWhBzIZliETltDWsT6mbkK4qvt
         8OOgthlHp7RTTAezJ0mzJa/7hMO7waGNVvDPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693947384; x=1694552184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9diK8PcHgpyU+i311Vkwvacj1OZq+KDSvCqh6K53Ntw=;
        b=DxGn+8BhLz2hMwoJD75azrk6BTq8A6t0E6oelO66V0X2EIO1C0XsEKV4ndaAcJskYK
         wBjeSHd6B7zqUdFcremPfBlAeOpGzaPQWHv8sgOH9mZCcmi/kR2QoLq56SnvtpKWQ49p
         Zeflm9NL2BlW2wrhNhfttyGzY2v8itnbkawYTp8A+eryQbSC0FedTPv/1coHtxjY7tBX
         NGPLNucsgAU/5sBD6dLQvktr7UzdgY/IMsCpSX1EMlUvJFXW8WlzXPUfc6ryd8yNFcYB
         8laSnPYs8btYih6FR6e4MQvqytoXEisBqMIlNbM9I9dY0h2V78UQx+6CZ1/TKGoFNbRl
         lLsA==
X-Gm-Message-State: AOJu0Yy9gIgdu2CY3CIwYFWnNQtQtdbDtvrlVqduqulA5tViaettM2ON
        BnS/w1H4YxGxrxfMvSbS3NnBRR6EMvk48v3l+boCVQ==
X-Google-Smtp-Source: AGHT+IH7F1r/gNPC69vO2am/Jp4XAKZERI9nP33sqw6EPdbN0utatfTsHoMRZaYPC3kDLL58ZVoMRMigLaaIJsH1uKI=
X-Received: by 2002:a2e:9047:0:b0:2b6:df23:2117 with SMTP id
 n7-20020a2e9047000000b002b6df232117mr666823ljg.43.1693947383760; Tue, 05 Sep
 2023 13:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <f4e8d869-401b-43f0-a326-52522730fb17@paulmck-laptop>
 <228160e9-96f1-6d1c-06c7-a5336dc93536@efficios.com> <b79eb142-67b2-48f0-9ad9-f9b634491e09@paulmck-laptop>
 <c312066b2cc44919bd11b6cd938cb05f@AcuMS.aculab.com> <ce51b768-9988-197c-0c35-7574aba77810@efficios.com>
 <abe14f37-ec05-48c3-87fc-9294848d221f@paulmck-laptop> <83422425-0534-4b12-a6e4-8068b7164a17@paulmck-laptop>
 <d2a3456b-aee9-f5b0-f8e4-5c5030c3217f@efficios.com> <b561c3a9-dc70-4c3d-b561-3f24398b01d8@paulmck-laptop>
 <CAEXW_YSe=s9S8OirDJARPvOrGUNXVPBkhucx5iKysjVk=AcLYg@mail.gmail.com> <a51db423-722c-43ab-9182-00f64c460043@paulmck-laptop>
In-Reply-To: <a51db423-722c-43ab-9182-00f64c460043@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 5 Sep 2023 16:56:12 -0400
Message-ID: <CAEXW_YQW_0RD5mmtwnzwik9Q9K9XL9rxHUyb98SLqCJ-840xOQ@mail.gmail.com>
Subject: Re: [PATCH v2] The value may overflow
To:     paulmck@kernel.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        David Laight <David.Laight@aculab.com>,
        Denis Arefev <arefev@swemel.ru>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trufanov@swemel.ru" <trufanov@swemel.ru>,
        "vfh@swemel.ru" <vfh@swemel.ru>, ldufour@linux.ibm.com
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

On Tue, Sep 5, 2023 at 4:52=E2=80=AFPM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Tue, Sep 05, 2023 at 04:40:46PM -0400, Joel Fernandes wrote:
[...]
> > > > > > So this bug appears to have no effect for default RCU setups, e=
ven on very
> > > > > > large 64-bit systems, which is consistent with field experience=
.  Even if
> > > > > > this is the case, it still should be fixed, to avoid confusion =
if nothing
> > > > > > else.  Or just in case someone decides to set CONFIG_RCU_FANOUT=
_LEAF=3D32.
> > > > > > Which actually happened the other day due to someone trusting C=
hatGPT's
> > > > > > opinion about RCU Kconfig options...
> > > > >
> > > > > And I therefore queued Denis's v3 patch with an edited commit log=
.
> > > > > Of course, if anyone sees some other way that the bug could manif=
est
> > > > > other than in a 64-bit kernel built with CONFIG_RCU_FANOUT_LEAF g=
reater
> > > > > than 30 on a system with at least 31 CPUs, please let me know so =
that
> > > > > I can adjust.
> > > > >
> > > > >                                                     Thanx, Paul
> > > > >
> > > > > -----------------------------------------------------------------=
-------
> > > > >
> > > > > commit ed083b0e22f1396dee3599896249a3f218845298
> > > > > Author: Denis Arefev <arefev@swemel.ru>
> > > > > Date:   Mon Sep 4 15:21:14 2023 +0300
> > > > >
> > > > >      Fix srcu_struct node grpmask overflow on 64-bit systems
> > > > >      The value of an arithmetic expression 1 << (cpu - sdp->mynod=
e->grplo)
> > > >
> > > > AFAIU, the overflow resides in the "bitwise expression" and not
> > > > the arithmetic expression.
> > >
> > > Rather than quibble about exactly what constitutes arithmetic, I
> > > updated the first paragraph and added your Reviewed-by as shown
> > > below.  ;-)
> > >
> > > > Other than this, please add my
> > > >
> > > > Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > >
> > > Thank you all!!!
> > >
> > > ---------------------------------------------------------------------=
---
> > >
> > > commit 50477ff756ab99402b1523b7c6be8b5d790d05e7
> > > Author: Denis Arefev <arefev@swemel.ru>
> > > Date:   Mon Sep 4 15:21:14 2023 +0300
> > >
> > >     Fix srcu_struct node grpmask overflow on 64-bit systems
> > >
> > >     The value of a bitwise expression 1 << (cpu - sdp->mynode->grplo)
> > >     is subject to overflow due to a failure to cast operands to a lar=
ger
> > >     data type before performing the bitwise operation.
> > >
> > >     The maximum result of this subtraction is defined by the RCU_FANO=
UT_LEAF
> > >     Kconfig option, which on 64-bit systems defaults to 16 (resulting=
 in a
> > >     maximum shift of 15), but which can be set up as high as 64 (resu=
lting
> > >     in a maximum shift of 63).  A value of 31 can result in sign exte=
nsion,
> > >     resulting in 0xffffffff80000000 instead of the desired 0x80000000=
.
> > >     A value of 31 or greater triggers undefined behavior per the C st=
andard.
> >
> > Do you mean here "A value of 32 or greater"?
> >
> > Only N >=3D 32 throws warning for:
> > unsigned long foo =3D (1 << N);
> >
> > N=3D31 does undesirable sign extension but no warning.
>
> Good catch, thank you, and I will update this on my next rebase.

Thanks, and with that the patch looks good to me:
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel
