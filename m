Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A98114E8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442016AbjLMOlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441994AbjLMOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:41:49 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D56B0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:41:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c66e7eafabso5740305a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702478515; x=1703083315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti4WWgukFD9JVeDjV7lFsBG44Mu7OstpF0433QBdo70=;
        b=e6dNv0U0zyGfzRgX1MVlgtOeX6pIzmVt3lwdd+HfLaUOEmYJ5OL/uh2y1tdLZe9mAi
         ahnHmUcQKlyNrSODG/Q98wPhn7fibVJJd16N2IrXNvvp3Wa0HBBLOYg/qMW9dGsP0RPI
         fN9LamdFCo6rA3O1p3WFzwgJ69XfRC5OLrBLwh15HzDoDV/tGYeC5PeW3IQG4NTWFxVO
         +i3dfAfwP1hcypyTGsB8BnWRXUHGdl37nAvXHXxGz3SN0aHy6WSxe1CErsO/AcE/eyv6
         oJRk1gBlwHYnzzW9nUqvc3VopJvtprVv+KYuuJO+7jNAUfOWX+iVB8ysVRZzkds5ktSc
         6mUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702478515; x=1703083315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti4WWgukFD9JVeDjV7lFsBG44Mu7OstpF0433QBdo70=;
        b=N2RM7Kl3/++a/bChABC8D3h/cQIn0jC1VQIu8GfaA6+mBI/ugA554/harmzBKuW75f
         wB5N6anpy7bz6FBVmXn+aK2U88QBS373g9x2UBdyCZgV2zeZUyk45OhLWynfnZy/7ZW7
         T+q2IYG+R//dQeSsKb+EeMSH0t/+Eia/QMI8JYLh/W3jF8Tj9GLdQH5h/3zbKjHXrQjk
         TyB/5OC/B2K7lsCvdAaj+1zfJIyUW3h//umUJQgvEyFlgUeennA9GYE0tuUKyVEAaQVw
         PePFrGYij6dLhAnSWppdosyfcaP2+OpZoqQVc6Zj2Qvi+ovkUNYW/w20zvDzDdvu58yi
         2jsQ==
X-Gm-Message-State: AOJu0YwjQ6MqOE7w+NOh+jwEzRDpqJHFmjoTH4E38YVVJNg8zTeoGv8F
        qVSOJEmcfATFU8kA2MbFXnn7M8syIgJQjEWNIpY=
X-Google-Smtp-Source: AGHT+IHrfU+uljWMKsJP4r9Y6j8of4YygdL0gChR4SfRHkHP7ldH7o9FG4rZYsnJqwOKzNQbU3GjbGIXVkcS8MvVcQo=
X-Received: by 2002:a05:6a20:9706:b0:18a:e86f:f246 with SMTP id
 hr6-20020a056a20970600b0018ae86ff246mr7813053pzc.10.1702478515453; Wed, 13
 Dec 2023 06:41:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1702339432.git.andreyknvl@google.com> <6c38c31e304a55449f76f60b6f72e35f992cad99.1702339432.git.andreyknvl@google.com>
 <CANpmjNNXiRxwTk4wGHL3pXmXo5YUY=VNLCf+g+kB6inXJnC2YA@mail.gmail.com> <20231212125728.1a275e704db4a5f5ca30e15c@linux-foundation.org>
In-Reply-To: <20231212125728.1a275e704db4a5f5ca30e15c@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Dec 2023 15:41:44 +0100
Message-ID: <CA+fCnZf85vFovXaxCuxTDCEQtMZMFKeKvo8UZ_9j8uhPEnqb+Q@mail.gmail.com>
Subject: Re: [PATCH mm 1/4] lib/stackdepot: add printk_deferred_enter/exit guards
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marco Elver <elver@google.com>, andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 9:57=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Tue, 12 Dec 2023 19:59:29 +0100 Marco Elver <elver@google.com> wrote:
>
> > On Tue, 12 Dec 2023 at 01:14, <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Stack depot functions can be called from various contexts that do
> > > allocations, including with console locks taken. At the same time, st=
ack
> > > depot functions might print WARNING's or refcount-related failures.
> > >
> > > This can cause a deadlock on console locks.
> > >
> > > Add printk_deferred_enter/exit guards to stack depot to avoid this.
> > >
> > > Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > > Closes: https://lore.kernel.org/all/000000000000f56750060b9ad216@goog=
le.com/
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> >
> > Doesn't need Fixes, because the series is not yet in mainline, right?
>
> I've moved the series "stackdepot: allow evicting stack traces, v4"
> (please, not "the stack depot eviction series") into mm-nonmm-stable.
> Which is allegedly non-rebasing.
>
> So yes please, provide Fixes: on each patch.

Sure, I'll add them when I mail v2 after we figure out what to do with
patch #2. Thanks!
