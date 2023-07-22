Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B753975DB4D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjGVJXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjGVJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:23:39 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B45730D7;
        Sat, 22 Jul 2023 02:23:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-403f3890a8eso23211711cf.3;
        Sat, 22 Jul 2023 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690017817; x=1690622617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I6DTPMDQWxvWH6aA+hzwj6+6idbMjoto1k2QaylevWs=;
        b=HwOIDTe75yrN8gXMugJWa4Q3vrk4OoSvRMRj4M6oHHki5f8hLANW7r1+yO3FgxtOJv
         s4FGyUEXAAlK4UCRAz06fB3thOpIbo4gDoH3m5IVJ4cjrf4u1igjUqRe2yy8ohR03g2X
         skLBF6dVGWZnZUO2O4MC3iC93Q1LFDKkCYw07LUYXaGWA93H2ve3lJ+ahHh4Jg47UOAi
         77KM4u3Z9FFr0+Viw0UeqHhQwDFL2M2lnyjk9HQmlsXTOC8IQF04qOESmQ12tG6u6Ijw
         JhdPiRrALwlT8vrJLriATpDM8iKdOa6+dlHZUMlT1ocletCN9aY5I3Pbmm6H5Zno5I12
         z1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690017817; x=1690622617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6DTPMDQWxvWH6aA+hzwj6+6idbMjoto1k2QaylevWs=;
        b=RYIkNAeVXylNHNkXHDrcRsyVGvoQ8eQQTDaAHkYUx2mzN6055Bz/NDGU+BC/ca5AAv
         C2LJn9qRE3aMUtGDaw1S5fiBa8olVxYktf2lAAAVyUknP++ConUNWOjkzIJPG4Uc1Ubb
         iUF3JIghkU6sbCkW4U38HGI0fYDp+3v4ZXaqVjFc1BAkv9fkQ8TeWVe8kPKceCQpPkWO
         vEfawGloYSJS7JyN9/I2zhd6rYJY4ZRZUUX65qulPSGjPoOkIEO9lBIedyNRjRClZ3jG
         P8G6ha5mLYhcUmI5+wzqyb1bKVsyl2u7wEEiND3sTfHAiu4FgtH0KP4HrmzWYrBocJP5
         3XVA==
X-Gm-Message-State: ABy/qLbOvzvCkrplwSHe4XgF8uewgI9C/sq5GzEpBTkot0CFfxqVfk4g
        i9zd3iXoGYkuirt37GtNpgdv9dFu/+nFVCZe3Wc=
X-Google-Smtp-Source: APBJJlH0wADI4NX2eX1T1k6ifLjoVg16GejAaqJVpRT20F2AkwKd8WvbsUKnVN3wam8zE7LrJ95f1n6BJ/U+gpL5QqE=
X-Received: by 2002:a05:622a:1705:b0:403:c6b1:7b96 with SMTP id
 h5-20020a05622a170500b00403c6b17b96mr3212555qtk.38.1690017817366; Sat, 22 Jul
 2023 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230721121534.44328-1-ppbuk5246@gmail.com> <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
In-Reply-To: <05e98227-77f4-4918-8f8e-2170a158e350@paulmck-laptop>
From:   Yun Levi <ppbuk5246@gmail.com>
Date:   Sat, 22 Jul 2023 10:23:26 +0100
Message-ID: <CAM7-yPRc4Z0siaiWf+fK2GEfjPMq5UaY13F4o19rU6NNUS5fNg@mail.gmail.com>
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

Hi, Paul.

Thanks for looking into this :)


> Except that rcu_report_qs_rdp() is invoked with interrupts enabled,
> which means that there is some possibility of state changes up to the
> raw_spin_lock_irqsave_rcu_node(rnp, flags) statement.
>
> So, did you check whether RCU's interrupt paths change this state?

In my narrow view,
only a new gp started, cpu_no_qs.b.norm changes as true in the path of
rcu_sched_clock_irq.
But in that case, rcu_report_qs_rdp isn't called.

Did I understand your question well and are there any missed paths I didn't see?

> Why not start with something like this?
>
>         if (!WARN_ON_ONCE(!rdp->cpu_no_qs.b.norm) ||
>             rdp->gp_seq != rnp->gp_seq || rdp->gpwrap) {
>

Yes. but with different message
