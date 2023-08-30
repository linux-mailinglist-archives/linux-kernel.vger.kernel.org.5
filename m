Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5E178D2BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbjH3E0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241941AbjH3E0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:26:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8221A3;
        Tue, 29 Aug 2023 21:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EA9760B00;
        Wed, 30 Aug 2023 04:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CD3C433CB;
        Wed, 30 Aug 2023 04:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693369570;
        bh=AGWJXrk34QfKCluDOSZ+qIvzRL4oGvSVWcF+e6r8B1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W76f79cbhYNV1HaLoPPw6ChQQGlxQMXa6Vp/C4KsueuwI7mUTXe0THLP3uYWWaRCN
         0PVw+pLlTrHd6SfMUoJ5lx7WJ+VL4Gmq1h815u0eHe1oNnsz06oU1E25l5BKXnqvWx
         BVKUvGLCZ8w7u9Ce+jKEoHC/Fw9DPhObOfnMlKs3RYSQR7QHe036dRSFMEXErUnSul
         hO4jyRTrtMLlJcvmZJ02TPvYGh/hC9rh9AKpU5dBHBGFFDuMwaFO+j2LtVZhxZ/ZlE
         w2tI57tvHEH04r9Ibc584u+JIIO4WcHA2fcVmwtc3/0fuXBqfEyv429/ZutNtL9B2f
         3hnQj5L/L6FQA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9a1de3417acso104949066b.0;
        Tue, 29 Aug 2023 21:26:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzcmgw6rkJWs1OPy3S1XYpUc/thgkqqRu9/R4KC4Jrlf3ucuKca
        fT6bGSOSYRDmnda7r5A7o/BgmiIdWGfqZf8nAD0=
X-Google-Smtp-Source: AGHT+IENS5XKygzRXhsGNpGVrGYIDfiJDdTZarMiH5CvLSCIUBmBLXQNPKyN/6mMRxVY6PJNEKu/kFeu0CZnUzrVOzo=
X-Received: by 2002:a17:906:7688:b0:9a5:a543:2744 with SMTP id
 o8-20020a170906768800b009a5a5432744mr1210778ejm.33.1693369568864; Tue, 29 Aug
 2023 21:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
 <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com> <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
 <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop> <20230828133348.GA1553000@google.com>
 <142b4bff-6a2e-4ea0-928c-3cfe9befa403@paulmck-laptop> <CAAhV-H4MrUm2xZdZyAALV-r+aKMRQ50v6me6hybpR1pRijirqw@mail.gmail.com>
 <CAEXW_YT-z6s+4MnxTnwFk2-mPba65dbnZogdPDSr14LmOW-h-g@mail.gmail.com>
 <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
 <CAEXW_YTfV1NVb3tOhunHZK_6oeUHxz_azv6uVq3k0O2UEAX5OQ@mail.gmail.com>
 <CAAhV-H6oN69rV2OyGzUganRv4KbS7a3_gNyWhCqVp51Ay9Q_=g@mail.gmail.com> <CAEXW_YRpT8wcLmsaHA6yMQ-ZCNYG7v4b4m-qvLHVxcbOJJcrPg@mail.gmail.com>
In-Reply-To: <CAEXW_YRpT8wcLmsaHA6yMQ-ZCNYG7v4b4m-qvLHVxcbOJJcrPg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 30 Aug 2023 12:25:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H62o96sgwWK7JAh+GOP=KNtZGS0HjVgHR19jJS1ONJW2Q@mail.gmail.com>
Message-ID: <CAAhV-H62o96sgwWK7JAh+GOP=KNtZGS0HjVgHR19jJS1ONJW2Q@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 10:46=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Tue, Aug 29, 2023 at 12:08=E2=80=AFAM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > Hi, Joel,
> >
> > On Tue, Aug 29, 2023 at 4:47=E2=80=AFAM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > >
> > > Hi Huacai,
> > >
> > > On Mon, Aug 28, 2023 at 11:13=E2=80=AFAM Huacai Chen <chenhuacai@kern=
el.org> wrote:
> > > >
> > > [...]
> > > > >
> > > > > > [Huacai]
> > > > > > I also think the original patch should be OK, but I have anothe=
r
> > > > > > question: what will happen if the current GP ends before
> > > > > > nr_fqs_jiffies_stall reaches zero?
> > > > >
> > > > > Nothing should happen. Stall detection only happens when a GP is =
in
> > > > > progress. If a new GP starts, it resets nr_fqs_jiffies_stall.
> > > > >
> > > > > Or can you elaborate your concern more?
> > > > OK, I will test your patch these days. Maybe putting
> > > > nr_fqs_jiffies_stall before jiffies_force_qs is better, because I
> > > > think putting an 'int' between two 'long' is wasting space. :)
> > >
> > > That's a good point and I'll look into that.
> > Another point, is it better to replace ULONG_MAX with ULONG_MAX/4 as
> > Paul suggested?
> >
>
> I could do that but I don't feel too strongly about it. I will keep it
> at ULONG_MAX if it's OK with everyone.
>
> > > Meanwhile I pushed the patch out to my 6.4 stable tree for testing on=
 my fleet.
> > >
> > > Ideally, I'd like to change the stall detection test in the rcutortur=
e
> > > to actually fail rcutorture if stalls don't happen in time. But at
> > > least I verified this manually using rcutorture.
> > >
> > > I should also add a documentation patch for stallwarn.rst to document
> > > the understandable sensitivity of RCU stall detection to jiffies
> > > updates (or lack thereof). Or if you have time, I'd appreciate suppor=
t
> > > on such a patch (not mandatory but I thought it would not hurt to
> > > ask).
> > >
> > > Looking forward to how your testing goes as well!
> > I have tested, it works for KGDB.
>
> Thanks! If you don't mind, I will add your Tested-by tag to the patch
> and send it out soon. My tests also look good!
You can add my Tested-by, but Reported-by should be "Binbin Zhou
<zhoubinbin@loongson.cn>"

Huacai
>
>
>  - Joel
