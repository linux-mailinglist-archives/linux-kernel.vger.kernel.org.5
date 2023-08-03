Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3F76EEF5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbjHCQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbjHCQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:03:06 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24A81BD9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:03:04 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9cdbf682eso17561941fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691078583; x=1691683383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6fPXN1Y9yrLJWUvpQ1dOJ0f2gtTCyYtwPND4T/OOXc=;
        b=wZVUnlR9atwhT2lwA8w6dmGtQ8WIMlp3Hi6kFog+Pr+p1TstbIMmbmHwGeD4NFCisN
         MDC5zDueHnTxhPfEszdNtSZYvbym+BMFnqLvfV6VAA0dby1toFrYaykLzA+qSetOjMBk
         iJ6+NJBBMp61taEtgQcv5YWfhVRSaYhqsmpXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691078583; x=1691683383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6fPXN1Y9yrLJWUvpQ1dOJ0f2gtTCyYtwPND4T/OOXc=;
        b=MPTaJspKq54pq5jbFgPEDiJLT8mQRQeO7l7bqWOMm7TB5+mdZ6nt82Sh9glRuKIUJc
         zLu0NanlQjasicPLrtF7Uikfrdf/ednXXPAbeh0GXH8D8kzmFzvMlgefhxa3kpOBRtoC
         Km/x8+9g810WLPnc7QaZFa/5LeRvJ+/6pobcoxAZr+LH/DNyrA9IfoWLkQXCk4nYl2rn
         KdYPjZP+8pD8gDLkW/XJVRIkqxMl+A9DuQMkb7miuoq9ABWQpBzQYVjONeNHyFr/FSn5
         KdwltIHAvpAEkxpQXV7wZ/BAv3BWTwx3JmfjU/gsFRL8+tTN6DrFQCzoW5nfwlwDkvBH
         QDBg==
X-Gm-Message-State: ABy/qLZqYftq7IYvzb2y1eEIKqILgig2xaHJosaSMBsOTLhqkvvOKUHW
        Y80e/ZoLzAU+9Pi6yJyCWT5hulJAWWH80qQNn1dkNw==
X-Google-Smtp-Source: APBJJlHPWxX3W6bfNKfEv1Mj86REh38AnPaJ8howZb3wlsyQXhcPnxN2zR/W+dNw7SUae3Z9mZCz611xVpac2siIMcc=
X-Received: by 2002:a2e:3502:0:b0:2b9:4aa1:71e1 with SMTP id
 z2-20020a2e3502000000b002b94aa171e1mr7187847ljz.50.1691078582873; Thu, 03 Aug
 2023 09:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230803144025.14023-1-arnd@kernel.org>
In-Reply-To: <20230803144025.14023-1-arnd@kernel.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 3 Aug 2023 12:02:52 -0400
Message-ID: <CAEXW_YQSO_OZ5MCT6kaTHLV7SgBWyiu8ATfcU7fsCdO=GwiQ9Q@mail.gmail.com>
Subject: Re: [PATCH] rcu: include torture_sched_setaffinity() declaration
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 10:40=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The prototype for torture_sched_setaffinity() moved to a
> different header, which needs to be included from update.c
> to avoid this W=3D1 warning:
>
> kernel/rcu/update.c:529:6: error: no previous prototype for 'torture_sche=
d_setaffinity' [-Werror=3Dmissing-prototypes]
>   529 | long torture_sched_setaffinity(pid_t pid, const struct cpumask *i=
n_mask)
>
> Fixes: 521ec59e5453e ("torture: Move rcutorture_sched_setaffinity() out o=
f rcutorture")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

- Joel


> ---
>  kernel/rcu/update.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 0533b510f0a8..c534d6806d3d 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -25,6 +25,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/debug.h>
> +#include <linux/torture.h>
>  #include <linux/atomic.h>
>  #include <linux/bitops.h>
>  #include <linux/percpu.h>
> --
> 2.39.2
>
