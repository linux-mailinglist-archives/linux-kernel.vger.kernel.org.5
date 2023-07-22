Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E005E75DE72
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGVUOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjGVUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:14:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F251AB;
        Sat, 22 Jul 2023 13:14:40 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b9ee68396fso2522440a34.1;
        Sat, 22 Jul 2023 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690056879; x=1690661679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CsgQOpJrjzex4LopMOjsyA5Iab44spIf3uBNriOk4wE=;
        b=Y1mRfoAftJ8i1IS4Ttr0q7It99BesLU3yPhB1VUPZYIe76oUgO95TDR/izqH8qyELC
         QKQLtKmSsWO7M46ED3Ga4010q0oPLiumr6cEteTufTXKh6Nv5yHVZnHi/CA32k3g+3JZ
         Rgu4qu+crdhk6TnNvvIaCzILGftbAHdYIt71Sodo8GLJX728iAirTZVl1NC4BRm05bgL
         vS0rh2evN0C9r+/Za+qDTIWyjsl23jEO4B2ZvOi/Qr2L5FFDVwyvedFA46CMJaeuzdiR
         xN1JeSYP+7wD9UFiGibvfKnRmkb+W9xaVRWqQnSw9OxSmI0Ja/ZkA3etfas2ahCCj0rK
         DuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690056879; x=1690661679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CsgQOpJrjzex4LopMOjsyA5Iab44spIf3uBNriOk4wE=;
        b=jywPMWxK8NUZmSgJG1qTmRpO/JPqbnhpqywPqzuVxEj4HniRlLrkQYvu5vMczJxjIr
         KuFfHqPScW8LZssP7eyYruUa1N4C2k+xTnLvbE+J4jg5mNZiWPrjWg9RM9ZjHa/1cg9p
         FPMki1Pj96/w52HPBSyKDve/8Bc5AQFMCDHfIa2oqJ7W1XXzH23do/3Pkpr+75Q2PEdi
         JawF0z0i7h5eA2kyCqZrXDPlzLRdiqaitmdzYxQ3zgRe97yA8Lupna/REGY7KCNo8QOU
         UocgxFFxB+bvBLgDLFDzwD9RniQ7NKI38mxouGRJatbltUrra6rh/NzTpbPnt1CeNaBM
         eXdg==
X-Gm-Message-State: ABy/qLZG/dS3i0qE3mS0T7Mkwi5b08bH/d/1qZWDmQTIXzoEBT/to/gx
        V6kWaKPYEzjicO8Y1VEPbzgPcQvQ6Qo8MOy78MTQoEoJcGKwvQ==
X-Google-Smtp-Source: APBJJlFkXVHJr7kTUDrRk+LDFUIhS6Li9w7H+7qUMjF8W/7c1EQqes+6G5Nd/VVWMuLqVoErIrCOffsjfvHFfCD1QYE=
X-Received: by 2002:a9d:66cf:0:b0:6b9:3ecb:db8f with SMTP id
 t15-20020a9d66cf000000b006b93ecbdb8fmr3015842otm.10.1690056879490; Sat, 22
 Jul 2023 13:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121534.44328-1-ppbuk5246@gmail.com> <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
 <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com> <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop>
In-Reply-To: <faf07eef-0a51-49f3-be48-0433952171ad@paulmck-laptop>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sat, 22 Jul 2023 21:14:28 +0100
Message-ID: <CAM7-yPTrHN1xPXWjSUrJeTEOuy78DpmL8ytUY+a4ZOekiAbnZg@mail.gmail.com>
Subject: Re: [PATCH] rcu: remove unnecessary check cpu_no_qs.norm on rcu_report_qs_rdp
To:     paulmck@kernel.org
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, osh@joshtriplett.org, boqun.feng@gmail.com,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

> Suppose that the scheduler-clock interrupt invoking rcu_sched_clock_irq()
> happened just before the lock was acquired in rcu_report_qs_rdp().
> Suppose further that the RCU grace-period kthread started a new grace
> period just before that interrupt occurred.  Then mightn't that interrupt
> notice the new grace period and set ->cpu_no_qs.b.norm to true before
> fully returning?

IIUC, RCU grace-period kthread couldn't start new grace period
because the interrupted cpu don't report qs to rnp  via rcu_report_qs_rdp.
That situation is listened like new gp could be started thou all cpus
doesn't enter yet.
That's is the reason why it's better to use WARN_ON_ONCE as you suggest
to notice if the buggy situation happens

Am I missing something or wrong?

Thanks.

--------
Sincerely,
Levi.
