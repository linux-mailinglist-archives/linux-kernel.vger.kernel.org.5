Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83EA78737A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 17:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbjHXPDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 11:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242099AbjHXPD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:03:28 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E1FD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:03:12 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so79268791fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692889391; x=1693494191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eEJlYjwGomwXZdEpT8mD7Dn7+6hWc/jr3IMn6AI62Cg=;
        b=PvUX2u24+vOy96ADf5UdOLSIS//Ev7/7KWq7m0IbITM5ulkLHoN4iQqy5vjM08aMvo
         IwwAqXjH3CFVmxhVhioLB+WRDzLO0PS+LX+op6u13VXf0uNh+XzdcoFEwMGZzjLTvVrJ
         Pt5KKlpQyY8MJ4hXX5seWpALUadSw3RBUPV1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692889391; x=1693494191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEJlYjwGomwXZdEpT8mD7Dn7+6hWc/jr3IMn6AI62Cg=;
        b=YtrnEFd+6TVQKO/bz7/i6utsu3A7LloKJWaNUvejTZeG7AfFIb4TGAuay4zPf5wAJI
         0HoAdK9fMSPoT1sQkBC6tbAmLYxtNGy1GXp8XavnbLHUQb88hRk51g697VBUUMFsSuIS
         y7mcgX2BAZHv67+TcgG24ej93Z/5Vhh/YQiFXN2pSgLBCZKQlEzuw752LmVicWE3jP8g
         2BJoqgBiQjXsrDB6ttXHRTFwgc28HLt4f9X2K9qgwthr4PyLPwjs/t00uftJXOZROkp8
         91GrPF8J9rMWZFBmh7itTwIhm6lCHhtYkxastkYRFyJ858W+etzODdKisid45yfNryuX
         JcPQ==
X-Gm-Message-State: AOJu0YyvAzWzQYKLLvXYirPeVXVjm51rhqU/HCGYBS88OSgEIGYQuMX+
        b7X349ahycKCkue8TXY1PMd017iWhMBfKsY780Ys0kjt
X-Google-Smtp-Source: AGHT+IE3gd++UqViV+gTHzzx0VS77wHTe98jPnkOdrGwkORo+muIbA5Qhvzm5uagc1+jC6QTvdSKnA==
X-Received: by 2002:a2e:7e06:0:b0:2b9:b27c:f727 with SMTP id z6-20020a2e7e06000000b002b9b27cf727mr11735719ljc.8.1692889390941;
        Thu, 24 Aug 2023 08:03:10 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l1-20020a2e8681000000b002b70aff9a97sm3814729lji.16.2023.08.24.08.03.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 08:03:10 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50079d148aeso7737809e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 08:03:09 -0700 (PDT)
X-Received: by 2002:a05:6512:2314:b0:4ff:8d2c:751b with SMTP id
 o20-20020a056512231400b004ff8d2c751bmr12966275lfu.43.1692889389504; Thu, 24
 Aug 2023 08:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230824143112.GA31208@redhat.com>
In-Reply-To: <20230824143112.GA31208@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Aug 2023 08:02:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
Message-ID: <CAHk-=whB2Cnmr2u8g5h57i8JfUoS3Qe=Pz7Bd8or3=ndJnQaWw@mail.gmail.com>
Subject: Re: [PATCH 0/2] introduce __next_thread(), change next_thread()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, peterz@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Aug 2023 at 07:32, Oleg Nesterov <oleg@redhat.com> wrote:
>
> After document-while_each_thread-change-first_tid-to-use-for_each_thread.patch
> in mm tree + this series

Looking at your patch 2/2, I started looking at users ("Maybe we
*want* NULL for the end case, and make next_thread() and __next_thread
be the same?").

One of the main users is while_each_thread(), which certainly wants
that NULL case, both for an easier loop condition, but also because
the only user that uses the 't' pointer after the loop is
fs/proc/base.c, which wants it to be NULL.

And kernel/bpf/task_iter.c seems to *expect* NULL at the end?

End result: if you're changing next_thread() anyway, please just
change it to be a completely new thing that returns NULL at the end,
which is what everybody really seems to want, and don't add a new
__next_thread() helper. Ok?

              Linus
