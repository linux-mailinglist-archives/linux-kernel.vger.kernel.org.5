Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4781E7BA8FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjJESXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjJESX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:23:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B9190
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:23:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40651b22977so3115865e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696530206; x=1697135006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4JjFwT78EtY7VmWefkXz9sGgOSiaAFwksvop57tLQo=;
        b=GEAi6cS2PxnQNun7WO83YwNOL2rpBLIQzIWT3T+wDfXst8MNxyeBOK1Ir2Tk1HKlGx
         ZOCEnDTWRbr+ePHPfOGjZblWiyPZj8t/prPHCojlXI9Ks0zDanegGmdbukl2J0vgzNZM
         FV5WBYO3qhq2c3Qq2lOJ890s4//7hnLM4DSgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696530206; x=1697135006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4JjFwT78EtY7VmWefkXz9sGgOSiaAFwksvop57tLQo=;
        b=r5uFuUsnMTfE/fDY6XDicUuJq2kX/JqEGGjlPfjW92y+hPe2WNp3wehY1jPNNDE1Af
         cBnjZchils5a7+zYgEqdITIzPl8wSVNz1JRSY5WT5WLCSMqbCrMN9V0MsebK8j9OCxMx
         Ue0CBuY3cskiOu3Zvv0zOxwBFn41uROcJ3BEXyeJeQpWjIWHx5MYUPqGN+df8iiKatKS
         Qu+ssm98lTbBv+BJr1CU32a7PwHtbgADlA858fRrVNjK9aEN2XQ6G+bghKv2//kVoTj4
         nxIA07fIGZtvSMnxWQ/vciLJy5QTQQBRbxyKDz3niusIeD4u25Vps0kMnNKtl9aGNArw
         ZV7A==
X-Gm-Message-State: AOJu0YzerGIgLsmugW3WVNE2yVGk3oolNF3E2wExpeAoiSQw6pu7VPiw
        mhJWlf+ZYSMkd2TFmnQhHZENsOO5x4ETFM+bmbHD4Q==
X-Google-Smtp-Source: AGHT+IEhOzhgiaRe5ZJlDz4WZ1RhCtlt/USatM61LmH7o2YMIcHZo6Bk3eti7GXgFb2HFje4l4Wz9JaQ1GGKVfLl2oY=
X-Received: by 2002:adf:d0cc:0:b0:31f:e576:4d3d with SMTP id
 z12-20020adfd0cc000000b0031fe5764d3dmr5325744wrh.5.1696530205859; Thu, 05 Oct
 2023 11:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115839.089944915@infradead.org> <dlbtvvm5cewqzh5bcpl4cqhcwxmnnjb6pdle5jzywiiznlactd@cmhnpim42m3p>
 <20230906131356.GG38741@noisy.programming.kicks-ass.net> <CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com>
 <20231002184136.GA1539@noisy.programming.kicks-ass.net> <20231005120557.GA743@noisy.programming.kicks-ass.net>
In-Reply-To: <20231005120557.GA743@noisy.programming.kicks-ass.net>
From:   Youssef Esmat <youssefesmat@chromium.org>
Date:   Thu, 5 Oct 2023 13:23:14 -0500
Message-ID: <CA+q576MLvCwH2YQFx3V2tf3f4n6JUze7jkpqqTx97UPsOHewhg@mail.gmail.com>
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, mingo@kernel.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 7:06=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Oct 02, 2023 at 08:41:36PM +0200, Peter Zijlstra wrote:
>
> > When mixing request sizes things become a little more interesting.
> >
> > Let me ponder this a little bit more.
>
> Using the attached program (I got *REALLY* fed up trying to draw these
> diagrams by hand), let us illustrate the difference between Earliest
> *Eligible* Virtual Deadline First and the one with the Eligible test
> taken out: EVDF.
>
> Specifically, the program was used with the following argument for
> EEVDF:
>
>   ./eevdf -e "0,1024,6" -e "1,1024,2" -e "2,1024,18" -v 19
>
> and with an additional '-n' for the EVDF column.
>
>
> EEVDF                                                   EVDF
>
>
> d =3D 6                                                   d =3D 6
> d =3D 2                                                   d =3D 2
> d =3D 18                                                  d =3D 18
> q =3D 2                                                   q =3D 2
>
> t=3D0 V=3D1                                                 t=3D0 V=3D1
>  A |----<                                                A |----<
> >B  |<                                                  >B  |<
>  C   |----------------<                                  C   |-----------=
-----<
>    |*--------|---------|---------|---------|----           |*--------|---=
------|---------|---------|----
>
>
> t=3D2 V=3D1                                                 t=3D2 V=3D1
> >A |----<                                                A |----<
>  B    |<                                                >B    |<
>  C   |----------------<                                  C   |-----------=
-----<
>    |*--------|---------|---------|---------|----           |*--------|---=
------|---------|---------|----
>
>
> t=3D8 V=3D3                                                 t=3D4 V=3D2
>  A       |----<                                         >A |----<
> >B    |<                                                 B      |<
>  C   |----------------<                                  C   |-----------=
-----<
>    |--*------|---------|---------|---------|----           |-*-------|---=
------|---------|---------|----
>
>
> t=3D10 V=3D4                                                t=3D10 V=3D4
>  A       |----<                                          A       |----<
>  B      |<                                              >B      |<
> >C   |----------------<                                  C   |-----------=
-----<
>    |---*-----|---------|---------|---------|----           |---*-----|---=
------|---------|---------|----
>
>
> t=3D28 V=3D10                                               t=3D12 V=3D5
>  A       |----<                                          A       |----<
> >B      |<                                              >B        |<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------*---------|---------|---------|----           |----*----|---=
------|---------|---------|----
>
>
> t=3D30 V=3D11                                               t=3D14 V=3D5
>  A       |----<                                          A       |----<
> >B        |<                                            >B          |<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------|*--------|---------|---------|----           |----*----|---=
------|---------|---------|----
>
>
> t=3D32 V=3D11                                               t=3D16 V=3D6
>  A       |----<                                         >A       |----<
> >B          |<                                           B            |<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------|*--------|---------|---------|----           |-----*---|---=
------|---------|---------|----
>
>
> t=3D34 V=3D12                                               t=3D22 V=3D8
> >A       |----<                                          A             |-=
---<
>  B            |<                                        >B            |<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------|-*-------|---------|---------|----           |-------*-|---=
------|---------|---------|----
>
>
> t=3D40 V=3D14                                               t=3D24 V=3D9
>  A             |----<                                    A             |-=
---<
> >B            |<                                        >B              |=
<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------|---*-----|---------|---------|----           |--------*|---=
------|---------|---------|----
>
>
> t=3D42 V=3D15                                               t=3D26 V=3D9
>  A             |----<                                    A             |-=
---<
> >B              |<                                      >B               =
 |<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------|----*----|---------|---------|----           |--------*|---=
------|---------|---------|----
>
>
> t=3D44 V=3D15                                               t=3D28 V=3D10
>  A             |----<                                   >A             |-=
---<
> >B                |<                                     B               =
   |<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------|----*----|---------|---------|----           |---------*---=
------|---------|---------|----
>
>
> t=3D46 V=3D16                                               t=3D34 V=3D12
> >A             |----<                                    A               =
    |----<
>  B                  |<                                  >B               =
   |<
>  C                     |----------------<                C   |-----------=
-----<
>    |---------|-----*---|---------|---------|----           |---------|-*-=
------|---------|---------|----
>
>
> t=3D52 V=3D18                                               t=3D36 V=3D13
>  A                   |----<                              A               =
    |----<
> >B                  |<                                   B               =
     |<
>  C                     |----------------<               >C   |-----------=
-----<
>    |---------|-------*-|---------|---------|----           |---------|--*=
------|---------|---------|----
>
>
> t=3D54 V=3D19                                               t=3D54 V=3D19
>  A                   |----<                              A               =
    |----<
> >B                    |<                                >B               =
     |<
>  C                     |----------------<                C               =
      |----------------<
>    |---------|--------*|---------|---------|----           |---------|---=
-----*|---------|---------|----
>
>
> lags: -10, 6                                            lags: -7, 11
>
> BAaaBCccccccccBBBAaaBBBAaaBB                            BBAaaBBBAaaBBBAaa=
BCccccccccB
>
>
>
> As I wrote before; EVDF has worse lag bounds, but this is not
> insurmountable. The biggest problem that I can see is that of wakeup
> preemption. Currently we allow to preempt when 'current' has reached V
> (RUN_TO_PARITY in pick_eevdf()).
>
> With these rules, when EEVDF schedules C (our large slice task) at t=3D10
> above, it is only a little behind C and can be reaily preempted after
> about 2 time units.
>
> However, EVDF will delay scheduling C until much later, see how A and B
> walk far ahead of V until t=3D36. Only when will we pick C. But this mean=
s
> that we're firmly stuck with C for at least 11 time units. A newly
> placed task will be around V and will have no chance to preempt.
>

Thank you for the detailed analysis! I am still in the process of
digesting everything.
I do have a quick question, this will only be the case if we adjust
C's runtime without adjusting nice value, correct? So it does not
currently apply to the submitted code where the only way to change the
deadline is to also change the nice value and thus how fast/slow
vruntime accumulates. In other words without the sched_runtime
patch[1] we should not run into this scenario, correct?

[1] https://lore.kernel.org/lkml/20230915124354.416936110@noisy.programming=
.kicks-ass.net/

> That said, I do have me a patch to cure some of that:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit=
/?h=3Dsched/eevdf&id=3Dd7edbe431f31762e516f2730196f41322edcc621
>
> That would allow a task with a shorter request time to preempt in spite
> of RUN_TO_PARITY.
>
> However, in this example V is only 2/3 of the way to C's deadline, but
> it we were to have many more tasks, you'll see V gets closer and closer
> to C's deadline and it will become harder and harder to place such that
> preemption becomes viable.
>
> Adding 4 more tasks:
>
>   ./eevdf -e "0,1024,6" -e "1,1024,2" -e "2,1024,18" -v 19 -n -e "3,1024,=
2" -e "4,1024,2" -e "5,1024,2" -e "6,1024,2"
>
> t=3D92 V=3D16
>  A                   |----<
>  B                    |<
> >C   |----------------<
>  D                    |<
>  E                   |<
>  F                    |<
>  G                   |<
>    |---------|-----*---|---------|---------|----
>
>
> And I worry this will create very real latency spikes.
>
> That said; I do see not having the eligibility check can help. So I'm
> not opposed to having a sched_feat for this, but I would not want to
> default to EVDF.
