Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5654D78B9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjH1Ura (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 16:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjH1UrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 16:47:24 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8870011A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:47:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so54340181fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693255640; x=1693860440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xC6lZ6BMGGGW970pla1pAI2sfTG4MPU4nqIiCLcvow=;
        b=CmJOHJeAi+FAllIu7mvMkI3Iw3qdaWZLSF0qzx9zfGZYgxz9uPAbHCMJMQrPqrhFj0
         KWeXH+ttc5aH7ccZ+UJaf3jHQMOWYAT5c46DexbD0zt+r1ZFFmJyh6KgkB2HVr+rI4Uy
         2lWK86r/GvtQYZ7t5O9dMvjaxjhRvejyDsOrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693255640; x=1693860440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xC6lZ6BMGGGW970pla1pAI2sfTG4MPU4nqIiCLcvow=;
        b=H8OIA8ZA4XInPzVui8xHmfO9f6B0fbiFLQlwjIDX5E9iHmL0N6tHZkwfNycKfn3mMp
         F7fNOYhZOJqJdegY1OA/I/ju5JmxbEU6xBxDIvJXmAt8iex/7cI6ePwbD70IGMxx0XHL
         WX01TwnFoCWuNq11ykXF4AUhZ8bFvgyijz8Sn7cfWDYu8UlI6nChmseSHn+ohxtxVVtY
         k+dQ21rFLwkN6DVdW46AAwXsa+u77L1gFuxSEBMfpoyCmEwTJ3/Xcz5NpjF4hijt9lEb
         LszYi0vIn4xYSNyg3EeDa0ukUzS8OtX/9EE7vHzcbdiaS8EwiaVQ8s+IO6YQPj0/U2m1
         o5IQ==
X-Gm-Message-State: AOJu0YyD4d9962VuY0QmRT4qOGSUmjrqZ3Kitw3BXWAQy5RIpxyyIzp8
        xXEcwZJW3gt8PnUea3RoDGC/N7LqsDVdPgSBp2u8Kw==
X-Google-Smtp-Source: AGHT+IGsERbihRzk13LRMf+4HVqatcZ5uGgRwfk/ClbcDnRaTlozyXs+625uI3DQf2agtAGhbV0EYasI15L27f9m5yU=
X-Received: by 2002:a2e:3210:0:b0:2bc:d43c:8607 with SMTP id
 y16-20020a2e3210000000b002bcd43c8607mr14283630ljy.14.1693255639638; Mon, 28
 Aug 2023 13:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
 <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop> <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com> <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
 <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop> <20230828133348.GA1553000@google.com>
 <142b4bff-6a2e-4ea0-928c-3cfe9befa403@paulmck-laptop> <CAAhV-H4MrUm2xZdZyAALV-r+aKMRQ50v6me6hybpR1pRijirqw@mail.gmail.com>
 <CAEXW_YT-z6s+4MnxTnwFk2-mPba65dbnZogdPDSr14LmOW-h-g@mail.gmail.com> <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
In-Reply-To: <CAAhV-H5tYV=ezPY_O7c=sd3DULB6BjoiYnw9nE2EzDFaBHcKPw@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 28 Aug 2023 16:47:07 -0400
Message-ID: <CAEXW_YTfV1NVb3tOhunHZK_6oeUHxz_azv6uVq3k0O2UEAX5OQ@mail.gmail.com>
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

Hi Huacai,

On Mon, Aug 28, 2023 at 11:13=E2=80=AFAM Huacai Chen <chenhuacai@kernel.org=
> wrote:
>
[...]
> >
> > > [Huacai]
> > > I also think the original patch should be OK, but I have another
> > > question: what will happen if the current GP ends before
> > > nr_fqs_jiffies_stall reaches zero?
> >
> > Nothing should happen. Stall detection only happens when a GP is in
> > progress. If a new GP starts, it resets nr_fqs_jiffies_stall.
> >
> > Or can you elaborate your concern more?
> OK, I will test your patch these days. Maybe putting
> nr_fqs_jiffies_stall before jiffies_force_qs is better, because I
> think putting an 'int' between two 'long' is wasting space. :)

That's a good point and I'll look into that.

Meanwhile I pushed the patch out to my 6.4 stable tree for testing on my fl=
eet.

Ideally, I'd like to change the stall detection test in the rcutorture
to actually fail rcutorture if stalls don't happen in time. But at
least I verified this manually using rcutorture.

I should also add a documentation patch for stallwarn.rst to document
the understandable sensitivity of RCU stall detection to jiffies
updates (or lack thereof). Or if you have time, I'd appreciate support
on such a patch (not mandatory but I thought it would not hurt to
ask).

Looking forward to how your testing goes as well!

thanks,

 - Joel
