Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980D17F51C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbjKVUg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVUg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:36:27 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA81F9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:36:23 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7ba9bd62fdfso56408241.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700685383; x=1701290183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vkfEHr78Ys9Zl8oeeDr7y3wj216XnJVscyV3Cx1FHDQ=;
        b=MQ8l00dM2/Itf7Ookpx8wtNASI7+PcC0hVzT3uLckQp6aMh2Tlq/ixTbpUXRBOUr2J
         +xFFDQXm3RX17PXKPXbm2DL2qnaCFHViY8jwjGpNByUPrJfyDFatnZUNIGyRjAwoERGy
         9T5sMMLsCLI/CoYjDnjV3cEEw2qHiibn7DqIgFfZGQ8ivzsRUmkixPKOPdZzpUfAcyWa
         lxtm9/IBVs7LIWzTE7WE5VLpvlg8RFdoYn6EOUd43B7/AuWIcAwHTpyg2v+d5S7bbZuc
         Jmqwq0/GnN0Omgk4+XNxbUP9aJg+Z6NsQtZIFatNqj1fHLCwKftN/RMmBYvLCXK7QsRz
         Koqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685383; x=1701290183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vkfEHr78Ys9Zl8oeeDr7y3wj216XnJVscyV3Cx1FHDQ=;
        b=NXgcdko7OFt91k0dpawIZA3GOW7ECxpdmzsA17oHsfJWhrmiHmejJETKEty6u0YxAU
         NTir2FqCyKOEYuxxW9aR/K71G0qJ2vCXTX+2YPl5rxoA2eM/utzOfKSjeRM/8hBrqAMp
         9Wl+8ocGaPz3M15KG0UtDDMp3i0y/tJkJ53+HbYZtk2wdjp3J1oz/YDHJ3mMkwxQtQMI
         rbPJx3j/kKL0QvWmFb4e7FEKckirjcR8WegcLOfwhlSlbGL4Rn0rmQYxETuN6VJf7LEe
         uGaEqan9YDm/uqt2ZBOgqWfiZQcohkd68BOyYhkUr+K0QTeUmfX4oT93R2dklL5+hEzD
         2ykA==
X-Gm-Message-State: AOJu0YyWnWTyU51DYfRSvvcKQ1fjFNOmAc26Mx1vkkkd1QM/3msfQ+Ca
        gniC+u55nK+N+w7l+lncLcYYYmTQtmapwjLQS8SkHg==
X-Google-Smtp-Source: AGHT+IEaacdnUa59qnize/3QcKbGSEsX/+QaFt9aREFTu+hko0hMQ/cZ5K0QHHgTXpOhmPH20kWi4VltLof9HqTi4Bs=
X-Received: by 2002:a1f:4c04:0:b0:4ac:c52d:70f9 with SMTP id
 z4-20020a1f4c04000000b004acc52d70f9mr3579163vka.10.1700685382734; Wed, 22 Nov
 2023 12:36:22 -0800 (PST)
MIME-Version: 1.0
References: <VI1P193MB0752A2F21C050D701945B62799BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
In-Reply-To: <VI1P193MB0752A2F21C050D701945B62799BAA@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Marco Elver <elver@google.com>
Date:   Wed, 22 Nov 2023 21:35:44 +0100
Message-ID: <CANpmjNPvDhyEcc0DdxrL8hVd0rZ-J4k95R5M5AwoeSotg-HCVg@mail.gmail.com>
Subject: Re: [PATCH] kfence: Replace local_clock() with ktime_get_boot_fast_ns()
To:     Juntong Deng <juntong.deng@outlook.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 21:01, Juntong Deng <juntong.deng@outlook.com> wrote:
>
> The time obtained by local_clock() is the local CPU time, which may
> drift between CPUs and is not suitable for comparison across CPUs.
>
> It is possible for allocation and free to occur on different CPUs,
> and using local_clock() to record timestamps may cause confusion.

The same problem exists with printk logging.

> ktime_get_boot_fast_ns() is based on clock sources and can be used
> reliably and accurately for comparison across CPUs.

You may be right here, however, the choice of local_clock() was
deliberate: it's the same timestamp source that printk uses.

Also, on systems where there is drift, the arch selects
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK (like on x86) and the drift is
generally bounded.

> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  mm/kfence/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 3872528d0963..041c03394193 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -295,7 +295,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
>         track->num_stack_entries = num_stack_entries;
>         track->pid = task_pid_nr(current);
>         track->cpu = raw_smp_processor_id();
> -       track->ts_nsec = local_clock(); /* Same source as printk timestamps. */
> +       track->ts_nsec = ktime_get_boot_fast_ns();

You have ignored the comment placed here - now it's no longer the same
source as printk timestamps. I think not being able to correlate
information from KFENCE reports with timestamps in lines from printk
is worse.

For now, I have to Nack: Unless you can prove that
ktime_get_boot_fast_ns() can still be correlated with timestamps from
printk timestamps, I think this change only trades one problem for
another.

Thanks,
-- Marco
