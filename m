Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA01778B421
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjH1PNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjH1PNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF95EA;
        Mon, 28 Aug 2023 08:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A693163AAA;
        Mon, 28 Aug 2023 15:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122DBC4339A;
        Mon, 28 Aug 2023 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693235583;
        bh=N3IMySmiiCEj8/A+vnkseZhBDT+e5yg8E/rDxpHy0LA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HGb0Tvkq4rhbrCIOUT6HGlKCF4/e/bqyCHfSXRebqONRT/IBPwoK4Sg8EOhBtfwi2
         MwzD7xW9NxE9XYllbsmYwC5cSB1SURIXIl//Jdy+VrJ/j0RzPAVbG4h2XaDn+KZ3S6
         ly8E/j0ur5HCPH6LDTCW2VBhIKzm57kY10PUoVD5HkpBZVGEVQq3sIGjCFZpyNYE4A
         IDyKWwBF6W1thWvwJlUxA+/5led0H+GcU9mam4CHVPIJtK/L2VVM6xCGZyFeOA9Xql
         9wZTPzFzdR1CVHpfbCUlJXSj/dKsjH4p30Ly9zYB2lyERuRgBJ105OdWkPPaah5jac
         Xpvki5llq/7sQ==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-99cce6f7de2so429891566b.3;
        Mon, 28 Aug 2023 08:13:02 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy4pEytM+e0CKr7124FeD8+XzKEp1Yi1Gw30jEIek7xag90W310
        vcBakUJ2zobYP/U8YUHtVE7ESAZVQ5h/HxSQRmY=
X-Google-Smtp-Source: AGHT+IFegWkxgwIMH5DK43tElEQvbPZZ1eb6tSn5VhNonRhcwQxJf/jD9zFHw1WptRe7PqcxaDhW5OEBE346qCxdhZI=
X-Received: by 2002:a17:906:10db:b0:9a1:bcac:8174 with SMTP id
 v27-20020a17090610db00b009a1bcac8174mr14841812ejv.37.1693235581141; Mon, 28
 Aug 2023 08:13:01 -0700 (PDT)
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
In-Reply-To: <CAEXW_YT-z6s+4MnxTnwFk2-mPba65dbnZogdPDSr14LmOW-h-g@mail.gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 28 Aug 2023 23:12:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
Message-ID: <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
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

Hi, Joel,

On Mon, Aug 28, 2023 at 10:51=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> On Mon, Aug 28, 2023 at 10:37=E2=80=AFAM Huacai Chen <chenhuacai@kernel.o=
rg> wrote:
> >
> > On Mon, Aug 28, 2023 at 10:02=E2=80=AFPM Paul E. McKenney <paulmck@kern=
el.org> wrote:
> > >
> > > On Mon, Aug 28, 2023 at 01:33:48PM +0000, Joel Fernandes wrote:
> > > > On Mon, Aug 28, 2023 at 03:47:12AM -0700, Paul E. McKenney wrote:
> > > > > On Sun, Aug 27, 2023 at 06:11:40PM -0400, Joel Fernandes wrote:
> > > > > > On Sun, Aug 27, 2023 at 1:51=E2=80=AFAM Huacai Chen <chenhuacai=
@kernel.org> wrote:
> > > > > > [..]
> > > > > > > > > > > The only way I know of to avoid these sorts of false =
positives is for
> > > > > > > > > > > the user to manually suppress all timeouts (perhaps u=
sing a kernel-boot
> > > > > > > > > > > parameter for your early-boot case), do the gdb work,=
 and then unsuppress
> > > > > > > > > > > all stalls.  Even that won't work for networking, bec=
ause the other
> > > > > > > > > > > system's clock will be running throughout.
> > > > > > > > > > >
> > > > > > > > > > > In other words, from what I know now, there is no per=
fect solution.
> > > > > > > > > > > Therefore, there are sharp limits to the complexity o=
f any solution that
> > > > > > > > > > > I will be willing to accept.
> > > > > > > > > > I think the simplest solution is (I hope Joel will not =
angry):
> > > > > > > > >
> > > > > > > > > Not angry at all, just want to help. ;-). The problem is =
the 300*HZ solution
> > > > > > > > > will also effect the VM workloads which also do a similar=
 reset.  Allow me few
> > > > > > > > > days to see if I can take a shot at fixing it slightly di=
fferently. I am
> > > > > > > > > trying Paul's idea of setting jiffies at a later time. I =
think it is doable.
> > > > > > > > > I think the advantage of doing this is it will make stall=
 detection more
> > > > > > > > > robust in this face of these gaps in jiffie update. And t=
hat solution does
> > > > > > > > > not even need us to rely on ktime (and all the issues tha=
t come with that).
> > > > > > > > >
> > > > > > > >
> > > > > > > > I wrote a patch similar to Paul's idea and sent it out for =
review, the
> > > > > > > > advantage being it purely is based on jiffies. Could you tr=
y it out
> > > > > > > > and let me know?
> > > > > > > If you can cc my gmail <chenhuacai@gmail.com>, that could be =
better.
> > > > > >
> > > > > > Sure, will do.
> > > > > >
> > > > > > > I have read your patch, maybe the counter (nr_fqs_jiffies_sta=
ll)
> > > > > > > should be atomic_t and we should use atomic operation to decr=
ement its
> > > > > > > value. Because rcu_gp_fqs() can be run concurrently, and we m=
ay miss
> > > > > > > the (nr_fqs =3D=3D 1) condition.
> > > > > >
> > > > > > I don't think so. There is only 1 place where RMW operation hap=
pens
> > > > > > and rcu_gp_fqs() is called only from the GP kthread. So a concu=
rrent
> > > > > > RMW (and hence a lost update) is not possible.
> > > > >
> > > > > Huacai, is your concern that the gdb user might have created a sc=
ript
> > > > > (for example, printing a variable or two, then automatically cont=
inuing),
> > > > > so that breakpoints could happen in quick successsion, such that =
the
> > > > > second breakpoint might run concurrently with rcu_gp_fqs()?
> > > > >
> > > > > If this can really happen, the point that Joel makes is a good on=
e, namely
> > > > > that rcu_gp_fqs() is single-threaded and (absent rcutorture) runs=
 only
> > > > > once every few jiffies.  And gdb breakpoints, even with scripting=
, should
> > > > > also be rather rare.  So if this is an issue, a global lock shoul=
d do the
> > > > > trick, perhaps even one of the existing locks in the rcu_state st=
ructure.
> > > > > The result should then be just as performant/scalable and a lot s=
impler
> > > > > than use of atomics.
> > > >
> > > > Thanks Paul and Huacai, also I was thinking in the event of such co=
ncurrent
> > > > breakpoint stalling jiffies updates but GP thread / rcu_gp_fqs() ch=
ugging
> > > > along, we could also make the patch more robust for such a situatio=
n as
> > > > follows (diff on top of previous patch [1]). Thoughts?
> > > >
> > > > Also if someone sets a breakpoint right after the "nr_fqs =3D=3D 1"=
 check, then
> > > > they are kind of asking for it anyway since the GP kthread getting
> > > > stalled is an actual reason for RCU stalls (infact rcutorture has a=
 test mode
> > > > for it even :P) and as such the false-positive may not be that fals=
e. ;-)
> > >
> > > [Paul]
> > > That would indeed be asking for it.  But then again, they might have =
set
> > > a breakpoint elsewhere that had the unintended side-effect of catchin=
g
> > > the RCU grace-period kthread right at that point.
> > >
> > > If that isn't something we are worried about, your original is fine.
> > > If it is something we are worried about, I recommend learning from my
> > > RCU CPU stall warning experiences and just using a lock.  ;-)
>
> This sounds good to me.
>
> > [Huacai]
> > I also think the original patch should be OK, but I have another
> > question: what will happen if the current GP ends before
> > nr_fqs_jiffies_stall reaches zero?
>
> Nothing should happen. Stall detection only happens when a GP is in
> progress. If a new GP starts, it resets nr_fqs_jiffies_stall.
>
> Or can you elaborate your concern more?
OK, I will test your patch these days. Maybe putting
nr_fqs_jiffies_stall before jiffies_force_qs is better, because I
think putting an 'int' between two 'long' is wasting space. :)

Huacai

>
> Thanks.
