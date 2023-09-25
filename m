Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41F7AE28D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjIYXkr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 19:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIYXkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:40:45 -0400
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15213101
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:40:39 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2c147b96af8so85122881fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 16:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695685237; x=1696290037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEGdQY58MLjo6bmyJyv9Nv2293rXNv4YwTeFa0jHyGc=;
        b=VYFURh1H+8KRPuVMn44dJF+qrwFBYkhM0f8xXUxylKATRRjzcyFpSLXnn+8bVMflXQ
         mTvZGbnaJjqWsPEHih2jzRrwDrcIy8Wc5XXWcm31ALhHL4MbkUTf2q0DTeO0as8weNxU
         RC7YtTOsufv2tR9Uy8bjJcvdTWN+/eBkp0RgTwTqndSbVL3WuznbqYXPWk0GxNRHClIi
         GFHj6VMlJKiDdy2yD2CRg61OQJMNDbXvtlnGJFdBOp/7C1vv7qXo5Dam5kG6/CkHxUC8
         8tYKLO2NOkQaObGvjGm9lQqoTJog6nY4jRY1GDI231gJatoYtkK2yufYImmkMM55Gy1v
         GsTg==
X-Gm-Message-State: AOJu0Yxl2Mh903/3YGtDYHQyixbgvLOidGM+qf4ToGTh6KBRZ0mRXoU6
        HGbo7QxGGJUbXwX9Aini/M7MQC4OlizZNF7bN0I=
X-Google-Smtp-Source: AGHT+IHWPoMWxjSO7XspPvi2m68UinSXGicw6NAqOrkRy8ZqRTi0YxBwDyG6JWjwcxrooS+4Lu7E2aFbgyDrtCYeJaY=
X-Received: by 2002:a2e:8906:0:b0:2bc:eb95:15c7 with SMTP id
 d6-20020a2e8906000000b002bceb9515c7mr6282014lji.49.1695685236853; Mon, 25 Sep
 2023 16:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAAi7L5c+7UoCOmKHAY4E1w_pwDS=qVOGsO+tfx6e3Zu+kyxHig@mail.gmail.com>
In-Reply-To: <CAAi7L5c+7UoCOmKHAY4E1w_pwDS=qVOGsO+tfx6e3Zu+kyxHig@mail.gmail.com>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Mon, 25 Sep 2023 16:40:25 -0700
Message-ID: <CANaxB-xTsazz+zj803UHH=3Q8pYDbfqwKR4MEdTTq6Bop1jNvQ@mail.gmail.com>
Subject: Re: Loosening time namespace restrictions
To:     =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>
Cc:     linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 5:51 AM Michał Cłapiński <mclapinski@google.com> wrote:
>
> Hello,
> I faced a problem with the current implementation of time ns while
> using it for container migration. I'd like users of CLOCK_MONOTONIC to
> notice as small of a jump as possible in the clock after migration,
> since according to the documentation "this clock does not count time
> that the system is suspended". In that case the formula for clock
> monotonic offset is "m1_monotonic - m2_monotonic - migration_downtime"
> where m<n>_monotonic is clock monotonic value on the n-th machine.
> Unfortunately due to time ns restrictions, I have to set the offsets
> before putting any process in the namespace. I also can't move
> multithreaded processes between namespaces. So I would have to know
> the migration downtime before the migration is close to done, which
> seems impossible. For that reason I'd like to drop the requirement of
> having to set the offsets before putting any processes in the
> namespace. What do you think? Is it possible to implement this and get
> it merged or should I forgo it? If you think it's possible, I'd
> appreciate any pointers on how to get this done (or how to solve my
> problem in another way).

It was one of the requirements to disallow offset changes if there are
tasks in a target namespace. I didn't remember who made it up, but it
looks reasonable to me even now. The main idea of it is to minimize side
effects and to make the code as simple as possible.

If we want to change this, we need to think about a few things:
* what should we do with timers when offsets are changed?
* synchronization. Right now, when offsets are changed, there are no
  readers, so we don't need to use any locks, atomics, etc. The
  performance of vdso clock_gettime was one of the major concerns.
  In this case, we need to think about it too.
* when offsets are changed, monotonic clocks can jump backward for
  processes inside a namespace.
* There may be a few other things that I missed.

Thanks,
Andrei
