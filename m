Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C578B3AF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjH1Ovm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjH1OvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:51:11 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D3110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:51:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bce552508fso50009101fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693234262; x=1693839062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ck9BHPTF2/vArNYaB+1376c7DGbr23gt1ZrUj3zlvNU=;
        b=joOfYcACO/BUFEwPVnZ/VuU8zL5TKv33/CtwAY/tfSjGGGLYE9ob+oyPZ8YL6jjIoD
         SVwxhtn+hDUzEaz5kPYi6eAgS4e1is62mAfA2p/6Bsm3QVjx2WOWtcZl4FpO1+OlCIMo
         M3W/Wc6kGmHuZyD84nwM5EN0juwQfpz4Ce7P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693234262; x=1693839062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ck9BHPTF2/vArNYaB+1376c7DGbr23gt1ZrUj3zlvNU=;
        b=SQnUz5bbRbHqEnFZBgDG7hIQMQxw83s1NJzxlKmG7EoLGXx8dWO3QC4Ic8C9BrRNJ0
         Od/vDYH7xIJ6VJj2piGu55XqDlHmXs1cVMQz5LlwOkxCQMewsr5gsGMfP/dMulI7hfj1
         W8mg1TB1s/XzFkwQAiyxur8+n/yDYr7WzGalofNBYVh0187ebz6JTaZotL+Dyc1OXcBh
         x2CSkgZKoKqQPVHEQYcee5tWqgQJieOUQXFqzsQ1gciR8HH5HBDgZFsgMfzq/PlYNLYm
         22K6fUJ+AG9sdaATk7D/TUCOKdGpuNiz+gcuIU5kuDlKt53LWdgqky5GPuPD5O4Mjfoo
         U+hg==
X-Gm-Message-State: AOJu0YzRgvK5iJP/6zxnRj/EKEa2r9vjeXgsJGro+wXJEeQMDM0M5Mdr
        2lvBYw/v3wxvVTXdybc4FWSv+lQMLAiUHGUDgpbDKQ==
X-Google-Smtp-Source: AGHT+IEivgW1A7qYnLHfvXVSPDQIrnz+0p+GglYmVT3gQBTjEz14SooitH8TQ6HZj92hw0drU62dh7UNT6kIt+f6/wk=
X-Received: by 2002:a2e:320c:0:b0:2b9:e93e:65e6 with SMTP id
 y12-20020a2e320c000000b002b9e93e65e6mr19577053ljy.35.1693234261999; Mon, 28
 Aug 2023 07:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
 <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com> <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
 <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop> <20230828133348.GA1553000@google.com>
 <142b4bff-6a2e-4ea0-928c-3cfe9befa403@paulmck-laptop> <CAAhV-H4MrUm2xZdZyAALV-r+aKMRQ50v6me6hybpR1pRijirqw@mail.gmail.com>
In-Reply-To: <CAAhV-H4MrUm2xZdZyAALV-r+aKMRQ50v6me6hybpR1pRijirqw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 28 Aug 2023 10:50:50 -0400
Message-ID: <CAEXW_YT-z6s+4MnxTnwFk2-mPba65dbnZogdPDSr14LmOW-h-g@mail.gmail.com>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
To:     Huacai Chen <chenhuacai@kernel.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:37=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
> On Mon, Aug 28, 2023 at 10:02=E2=80=AFPM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> >
> > On Mon, Aug 28, 2023 at 01:33:48PM +0000, Joel Fernandes wrote:
> > > On Mon, Aug 28, 2023 at 03:47:12AM -0700, Paul E. McKenney wrote:
> > > > On Sun, Aug 27, 2023 at 06:11:40PM -0400, Joel Fernandes wrote:
> > > > > On Sun, Aug 27, 2023 at 1:51=E2=80=AFAM Huacai Chen <chenhuacai@k=
ernel.org> wrote:
> > > > > [..]
> > > > > > > > > > The only way I know of to avoid these sorts of false po=
sitives is for
> > > > > > > > > > the user to manually suppress all timeouts (perhaps usi=
ng a kernel-boot
> > > > > > > > > > parameter for your early-boot case), do the gdb work, a=
nd then unsuppress
> > > > > > > > > > all stalls.  Even that won't work for networking, becau=
se the other
> > > > > > > > > > system's clock will be running throughout.
> > > > > > > > > >
> > > > > > > > > > In other words, from what I know now, there is no perfe=
ct solution.
> > > > > > > > > > Therefore, there are sharp limits to the complexity of =
any solution that
> > > > > > > > > > I will be willing to accept.
> > > > > > > > > I think the simplest solution is (I hope Joel will not an=
gry):
> > > > > > > >
> > > > > > > > Not angry at all, just want to help. ;-). The problem is th=
e 300*HZ solution
> > > > > > > > will also effect the VM workloads which also do a similar r=
eset.  Allow me few
> > > > > > > > days to see if I can take a shot at fixing it slightly diff=
erently. I am
> > > > > > > > trying Paul's idea of setting jiffies at a later time. I th=
ink it is doable.
> > > > > > > > I think the advantage of doing this is it will make stall d=
etection more
> > > > > > > > robust in this face of these gaps in jiffie update. And tha=
t solution does
> > > > > > > > not even need us to rely on ktime (and all the issues that =
come with that).
> > > > > > > >
> > > > > > >
> > > > > > > I wrote a patch similar to Paul's idea and sent it out for re=
view, the
> > > > > > > advantage being it purely is based on jiffies. Could you try =
it out
> > > > > > > and let me know?
> > > > > > If you can cc my gmail <chenhuacai@gmail.com>, that could be be=
tter.
> > > > >
> > > > > Sure, will do.
> > > > >
> > > > > > I have read your patch, maybe the counter (nr_fqs_jiffies_stall=
)
> > > > > > should be atomic_t and we should use atomic operation to decrem=
ent its
> > > > > > value. Because rcu_gp_fqs() can be run concurrently, and we may=
 miss
> > > > > > the (nr_fqs =3D=3D 1) condition.
> > > > >
> > > > > I don't think so. There is only 1 place where RMW operation happe=
ns
> > > > > and rcu_gp_fqs() is called only from the GP kthread. So a concurr=
ent
> > > > > RMW (and hence a lost update) is not possible.
> > > >
> > > > Huacai, is your concern that the gdb user might have created a scri=
pt
> > > > (for example, printing a variable or two, then automatically contin=
uing),
> > > > so that breakpoints could happen in quick successsion, such that th=
e
> > > > second breakpoint might run concurrently with rcu_gp_fqs()?
> > > >
> > > > If this can really happen, the point that Joel makes is a good one,=
 namely
> > > > that rcu_gp_fqs() is single-threaded and (absent rcutorture) runs o=
nly
> > > > once every few jiffies.  And gdb breakpoints, even with scripting, =
should
> > > > also be rather rare.  So if this is an issue, a global lock should =
do the
> > > > trick, perhaps even one of the existing locks in the rcu_state stru=
cture.
> > > > The result should then be just as performant/scalable and a lot sim=
pler
> > > > than use of atomics.
> > >
> > > Thanks Paul and Huacai, also I was thinking in the event of such conc=
urrent
> > > breakpoint stalling jiffies updates but GP thread / rcu_gp_fqs() chug=
ging
> > > along, we could also make the patch more robust for such a situation =
as
> > > follows (diff on top of previous patch [1]). Thoughts?
> > >
> > > Also if someone sets a breakpoint right after the "nr_fqs =3D=3D 1" c=
heck, then
> > > they are kind of asking for it anyway since the GP kthread getting
> > > stalled is an actual reason for RCU stalls (infact rcutorture has a t=
est mode
> > > for it even :P) and as such the false-positive may not be that false.=
 ;-)
> >
> > [Paul]
> > That would indeed be asking for it.  But then again, they might have se=
t
> > a breakpoint elsewhere that had the unintended side-effect of catching
> > the RCU grace-period kthread right at that point.
> >
> > If that isn't something we are worried about, your original is fine.
> > If it is something we are worried about, I recommend learning from my
> > RCU CPU stall warning experiences and just using a lock.  ;-)

This sounds good to me.

> [Huacai]
> I also think the original patch should be OK, but I have another
> question: what will happen if the current GP ends before
> nr_fqs_jiffies_stall reaches zero?

Nothing should happen. Stall detection only happens when a GP is in
progress. If a new GP starts, it resets nr_fqs_jiffies_stall.

Or can you elaborate your concern more?

Thanks.
