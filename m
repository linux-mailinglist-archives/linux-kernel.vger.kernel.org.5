Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043CE76EF28
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjHCQL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbjHCQLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:11:54 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E37A1BF6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:11:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b703a0453fso18046111fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1691079112; x=1691683912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z59eNgn4M1iFIVPk3YUNjMH4Rw0H6AS/y6pnBDPk960=;
        b=uieyuRpvIvhpaHK7XMYzm19z9WHalOnZMeyPbAsA/kjFh2GQQfmE7FvpncdEYCj/Hm
         c7ePHemHtYA28LZmCAqy8FDb434onv5oPlpYyRsaXhKoMrWh0/EfO8dyUcpDT2hBFCpE
         ZjxZElQdag3CY/jzL8QSbms65RIh1GceIitOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691079112; x=1691683912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z59eNgn4M1iFIVPk3YUNjMH4Rw0H6AS/y6pnBDPk960=;
        b=X2bbg+WHtUoTqj1XbMfpEmFzNXOL9OPRLqHAIfSW0GKCOa1R/1ewsByOzjdlZs+eil
         ZC0wloTv4mUiKQv+/4bWU3w+QetDdHpAaVsRNRSBYmmHU2SJsA2+QApD4FvTPI3N3RmC
         /1nGCk0YSWsnx1EAtzwa8ZgKDmBcJbpkxA1JbUvZr0NSYVL2XyXhInC6jiB6OgFzaIt8
         Jd+iVmV/m5hhSFcPXxdW6HE63KpFq0OZl1Bzw+3qpA1U4Jger1E5SkuY3i/zngt6d6Gh
         aS29Uays5hfo601r8ffUf9/S/jlYMbugriWvHDt7FWo/xCEou0YsUD+L55ajZguxa2l0
         kf+A==
X-Gm-Message-State: ABy/qLaFHALou0LX4bbuqraq0a89YInV43/n79knlXdPQMHoqNy45CPJ
        ctg6nyLFhhj5x4HsHi2E81MqH2eaLNFxaCbarZNJcw==
X-Google-Smtp-Source: APBJJlFfkzN9nxgOgjC0G+jWV3FToU5x2MufRgLTNAU3DkE+ZzQKQBQ8sgMtfACyLmL1wKPIvS40NHn0ZSzdglyGJek=
X-Received: by 2002:a2e:9008:0:b0:2b9:7513:3596 with SMTP id
 h8-20020a2e9008000000b002b975133596mr7558095ljg.5.1691079111757; Thu, 03 Aug
 2023 09:11:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230803080659.99071-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230803080659.99071-1-jiapeng.chong@linux.alibaba.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 3 Aug 2023 12:11:41 -0400
Message-ID: <CAEXW_YRQkovToQJA1FuPDtfVx0-z=Mp29KZC3irCSd7jDeA35w@mail.gmail.com>
Subject: Re: [PATCH] rcu-tasks: make rcu_tasks_lazy_ms static
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, boqun.feng@gmail.com, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 4:07=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> The rcu_tasks_lazy_ms are not used outside the file tasks.h, so the
> modification is defined as static.
>
> kernel/rcu/tasks.h:1085:5: warning: symbol 'rcu_tasks_lazy_ms' was not de=
clared. Should it be static?
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D6086
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel


> ---
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 83049a893de5..ee1379671798 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1084,7 +1084,7 @@ void rcu_barrier_tasks(void)
>  }
>  EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
>
> -int rcu_tasks_lazy_ms =3D -1;
> +static int rcu_tasks_lazy_ms =3D -1;
>  module_param(rcu_tasks_lazy_ms, int, 0444);
>
>  static int __init rcu_spawn_tasks_kthread(void)
> --
> 2.20.1.7.g153144c
>
