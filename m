Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A4779663
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbjHKRoa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 11 Aug 2023 13:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbjHKRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 13:44:28 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F2F106
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:44:24 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6b9cd6876bbso493242a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 10:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691775864; x=1692380664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dzDksfI10UdHU3LpXm7ofBC5e1PZoH4rn/+h5rhdlA=;
        b=kiDaHTdSDq44Qk3St1jm2Z3jY9WkUg/kgW1m8ogklN+g7O8COaqW3G/oLtbSj7Trj9
         QGLU7spVQTef+Xsy9dmhIYk3p2T5ZmVpEkyyhbWRy/NQ6LwmW9Ai5twgg2iUIYx/katl
         bZxfwWx/dSZZAvKePZVSnyUMGShJNKDdpjcNKcsr794jAMlaz1qCnTQCPotysuAGymDa
         0+0oKw4w76y7ENdweryUC272JhN8rDhbIUUme34F9w9jvof20+tkcLkic4iVZSZZHAe1
         EhX5wtsLGZgbh0LdYeqLmqrLHq9uEf02VUbVSqaIlFxjhaUCyXW3UME4smvrkre+XeVz
         linw==
X-Gm-Message-State: AOJu0YzKpvKIsQKnzb009571flAPPBb5Xj6Js0SJ3rvqkmPL5Gzq6+vo
        CCzhA3rZLOvChTQTjNw/5nVCvbB/ulnPelLsHz4=
X-Google-Smtp-Source: AGHT+IEeo4ttiJmsfTrMYiVVN9EnCniqPhgCcnKtlu0AS/uejaSHJCCf/LlcqHSwVPSb3on5OpVoG79QzRW5li41Ph0=
X-Received: by 2002:a05:6820:2018:b0:56d:6bd4:4db5 with SMTP id
 by24-20020a056820201800b0056d6bd44db5mr2055655oob.0.1691775864198; Fri, 11
 Aug 2023 10:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230811170049.308866-1-frederic@kernel.org> <20230811170049.308866-2-frederic@kernel.org>
In-Reply-To: <20230811170049.308866-2-frederic@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Aug 2023 19:44:13 +0200
Message-ID: <CAJZ5v0ga+x5w87KktirdVLw4yMT97AEgsZeoQBKZHMWovxZd3Q@mail.gmail.com>
Subject: Re: [PATCH 01/10] x86: Add a comment about the "magic" behind shadow
 sti before mwait
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 7:00 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> Add a note to make sure we never miss and break the requirements behind
> it.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  arch/x86/include/asm/mwait.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/include/asm/mwait.h b/arch/x86/include/asm/mwait.h
> index 778df05f8539..341ee4f1d91e 100644
> --- a/arch/x86/include/asm/mwait.h
> +++ b/arch/x86/include/asm/mwait.h
> @@ -87,6 +87,15 @@ static __always_inline void __mwaitx(unsigned long eax, unsigned long ebx,
>                      :: "a" (eax), "b" (ebx), "c" (ecx));
>  }
>
> +/*
> + * Re-enable interrupts right upon calling mwait in such a way that
> + * no interrupt can fire _before_ the execution of mwait, ie: no
> + * instruction must be placed between "sti" and "mwait".
> + *
> + * This is necessary because if an interrupt queues a timer before
> + * executing mwait, it would otherwise go unnoticed and the next tick
> + * would not be reprogrammed accordingly before mwait ever wakes up.
> + */
>  static __always_inline void __sti_mwait(unsigned long eax, unsigned long ecx)
>  {
>         mds_idle_clear_cpu_buffers();
> --
> 2.34.1
>
