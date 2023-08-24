Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02571786AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 11:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbjHXJAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 05:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240564AbjHXJAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 05:00:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781521988;
        Thu, 24 Aug 2023 02:00:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc83a96067so40895225ad.0;
        Thu, 24 Aug 2023 02:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692867610; x=1693472410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHww7gHnzJH5T/R7CVu+HoKk8GHpP1uT7YjjaTP4GEQ=;
        b=cM3pMmd4RUTX2C74H62W+tpAzfL6baAMvl9ukjz4ZeNrWCxKZka5BXRgI6YMFHR/LP
         dEeHCyLFJDfSVjVFC4SytxALn/ESdObobHo4L0c8ytF9IFvhNe5pc+kTi66YU9wV7sfZ
         Lb3Z+bFePWYh/Y8u+6ldDLe5DkMQ9lW+lFjgXXX/JO9U6/bWQiUaP9dJoLbCGooCRDKD
         8keRotg83Cn7hFtqzoGocga7nJUT0fW2I+S6oH5e0sgshAyz1YVfh5O5/LNFWkk7Qiyf
         uoJye2IbnJeWDQOMZcfwGyv01PKgMqDLwV2uwuPdc20UfRLq+hdDHtlsog/raOlqN/R7
         kpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692867610; x=1693472410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHww7gHnzJH5T/R7CVu+HoKk8GHpP1uT7YjjaTP4GEQ=;
        b=YyQtfDABz850j1w111IMYZA0nVLR1BRa33kh6uCOWT1i6RVqX7/XkqiWJrH9sPTGf2
         pozkD+anIazV715T1bD7c4UqqU3wGDiZRoxVi83G7NolGfaPjBckOVbROsPnkS9/PgA9
         AO4nmda0fD1cLIPgQmCh4cwC26W03ex9LxbbYJwv1lHQZbhhVaJ5SKv7x16fu6UllIDU
         35v2HwX/wFlouYADRabcJINVIxVaPVvy9Z3mBCDhEWBm1HcleiJqCILCra0MnaeihUT9
         i/Ydb4jEbvr7Tmgnz2SsWKRqVMVRS7zYvsHnriNti7FsVzxKzaI2o9/eykV5h18JKAhL
         Ay5Q==
X-Gm-Message-State: AOJu0Yy1h9NfCLdXrdfn9aBbIUkxzrikK7dw3OP2I+/WwPNWa5/1Zyyg
        BgR+Xsuv9Pe5u9PYR9N+YytfL9hV6xJwQpgw3ECptr1ksvQ=
X-Google-Smtp-Source: AGHT+IEsIf2f9snwNFWOGfQZTjLcEqWnhl0ShdCoaxbyUXv6PApZv5+bOcC2LKFRGa3QGC2UGBScPQXlqbDYLIgZgzA=
X-Received: by 2002:a17:90b:1011:b0:268:38f5:86ac with SMTP id
 gm17-20020a17090b101100b0026838f586acmr10715666pjb.24.1692867609885; Thu, 24
 Aug 2023 02:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
In-Reply-To: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
From:   Z qiang <qiang.zhang1211@gmail.com>
Date:   Thu, 24 Aug 2023 16:59:58 +0800
Message-ID: <CALm+0cU9HbhCj0rc=-Cf9j3KUFjHRw2giMLV3+t_JrBTMCAaDA@mail.gmail.com>
Subject: Re: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the repeat sending.


>
> Currently, the maxcpu is set by traversing online CPUs, however, if
> the rcutorture.onoff_holdoff is set zero and onoff_interval is set
> non-zero, and the some CPUs with larger cpuid has been offline before
> setting maxcpu, for these CPUs, even if they are online again, also
> cannot be offload or deoffload.
>
> This commit therefore use for_each_possible_cpu() instead of
> for_each_online_cpu() in rcu_nocb_toggle().
>
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/rcutorture.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index a58372bdf0c1..b75d0fe558ce 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
>         VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
>         while (!rcu_inkernel_boot_has_ended())
>                 schedule_timeout_interruptible(HZ / 10);
> -       for_each_online_cpu(cpu)
> +       for_each_possible_cpu(cpu)
>                 maxcpu = cpu;
>         WARN_ON(maxcpu < 0);
>         if (toggle_interval > ULONG_MAX)
> --
> 2.17.1
>
