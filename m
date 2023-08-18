Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BCB78114F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378916AbjHRRLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 13:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378928AbjHRRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 13:11:01 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93A3C3F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:10:59 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-58439daf39fso12107567b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1692378659; x=1692983459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PriZwbnIAIMHjMQhbPfR80F8NjgLCAXSz5gqYEbi/s=;
        b=REtRCgqQ0+mNXEHfvAK08RK8P2UAnIpEHhXLicWF74ds9SZfdo80UyLhZS6M8iZ+4o
         RpO+MTyLJ1HdjWxFGS5QAeR+QIQik1NhuqaPMISDz2gpE9Zq/pwaO+fCk3hv6I20Sqyt
         x3aP66g2tMcms9lp8noO5mXcn+Xk8zshWgyYAouZ7DAjovG2MnEQpBagbXaSXTjBTIrS
         J+VaveHCdSVfv7KNYxa5So6YRoprMeoXtFTnww5lRwtwttDpLOuI3xVptQDson5LTcCT
         X2V0F4gaBr8igsLcWOHn6vT14HEF/INPJv0q3qGCMmDV7cVl+z4S2QgqWXiSQ8pcMUJS
         sAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692378659; x=1692983459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PriZwbnIAIMHjMQhbPfR80F8NjgLCAXSz5gqYEbi/s=;
        b=Jm6HzPGU0B0XV66I71wmqEfhcg1dbHqIjaU60C0Uc7IU7baVgMFiPX/hlqjsFBLnS/
         Mk/8dGRxliIxWoNj1TNUh6wuCmTGHZbVJjTVh1QtOx7uX7XhwezMr9qoETCa+z0ISEGl
         ejHZsk0HjIEr8rEGsxT1Bh9Ktixuq2EdioqDRtZol6J4JKlLUrgJsaKpL+PHS+EJP+L1
         tqtAh8kY09w2DKrMXFsWQVg4si6cMEq2QFp4lgWK27OpBQ7zqq8pKW201STTLEi3wy/x
         adF1ND6PQtlY3eCISraieqrehQk2ru0u52f3mGZrD0TvSx28SYuyr/6k/paYyx6Nfr2q
         9Kzg==
X-Gm-Message-State: AOJu0YylZczU93LHcW/aFCWDjL89nWtvSwPr5W+LFEvhZT7mClCus3ts
        RWrgwAzCkjevZUQgFGhwDrycwyVou3GiZ2Asop88GQ==
X-Google-Smtp-Source: AGHT+IHN96pSPlL9GZDCeJqQ+kwqFrFG8TZjNo73WaE5yRmac0P2df/F6eXz5KK2ir/yGQJ5e7Rl38wJFGjpkvgVeIk=
X-Received: by 2002:a81:a0c5:0:b0:578:1937:868b with SMTP id
 x188-20020a81a0c5000000b005781937868bmr2872180ywg.11.1692378659120; Fri, 18
 Aug 2023 10:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a1fbb0602d4088a@google.com> <20230814160303.41b383b0@kernel.org>
 <20230815112821.vs7nvsgmncv6zfbw@skbuf> <20230816225759.g25x76kmgzya2gei@skbuf>
 <CAM0EoMnux5JjmqYM_ErBZD4x3xkgYOEyn3R4oX6uBW-+OkE_sQ@mail.gmail.com>
 <CAM0EoMk5USiuZ84JeJQYCDQQ5dV-jiuGRVVocqH2izi7xcZnkg@mail.gmail.com> <20230818160711.k7irnjba3qxx3rfu@skbuf>
In-Reply-To: <20230818160711.k7irnjba3qxx3rfu@skbuf>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Fri, 18 Aug 2023 13:10:47 -0400
Message-ID: <CAM0EoM=jAzcQV8XgZ-yAP9KymQvUTZXutkhvrtcvJ5tV5AX8dQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Victor Nogueira <victor@mojatatu.com>,
        syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>,
        bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
        edumazet@google.com, jiri@nvidia.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On Fri, Aug 18, 2023 at 12:07=E2=80=AFPM Vladimir Oltean
<vladimir.oltean@nxp.com> wrote:
>
> Hi Jamal,
>
> On Fri, Aug 18, 2023 at 11:27:27AM -0400, Jamal Hadi Salim wrote:
> > Can you try the attached patchlet?
>
> Thanks for the patch. I've tried it, and it eliminates the code path
> (and thus the problem) exposed by the syzbot program, by responding to
> RTM_NEWQDISC messages having the NLM_F_CREATE|NLM_F_REPLACE|NLM_F_EXCL
> flags with "Error: Exclusivity flag on, cannot modify.".
>

Ok, that is more of the expected behavior.
Noone should ever send that mumbo-jumbo (I doubt there is a "legit"
control app that will do that).

> Actually, to be precise, the first such netlink message successfully
> creates the qdisc, but then the subsequent ones leave that qdisc alone
> (don't change it), by failing with this extack message.
>

Yes, the first one will succeed because the root qdisc hasnt been
grafted yet (and the only interesting bit is NLM_F_CREATE. everything
else is ignored).

> If that's the behavior that you intended, then I guess the answer is
> that it works. Thanks a lot.
>
> What would be an appropriate Fixes: tag?
>

This should have been from early days when we trusted that iproute2
would do the right thing. I will look.
I dont think this is a taprio only potential victim, it's just that
syzbot was able to aggravate taprio sooner (it probably would have got
to some other qdisc later in its adventures).

> Side note: I believe that we can now also revert commit be3618d96510
> ("net/sched: taprio: fix slab-out-of-bounds Read in taprio_dequeue_from_t=
xq"),
> which was papering over an unknown (at the time) issue - the same as
> this one - without really even completely covering it, either.

Unfortunately the commit log is not helpful - i cant tell what
"replace" means and cant seem to find the repro either. If you revert
it and see the problem going away then we are good.
+Cc  Zhengchao Shao <shaozhengchao@huawei.com>

>Hence
> this other syzbot report.
> https://lore.kernel.org/netdev/3b977f76-0289-270e-8310-179315ee927d@huawe=
i.com/T/
> https://lore.kernel.org/netdev/20230608062756.3626573-1-shaozhengchao@hua=
wei.com/

Makes sense.
BTW, thanks for your report - it made it faster to zone on the issue.
The comments above that code also need a bit of fixing to provide clarity.

cheers,
jamal
