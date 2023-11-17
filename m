Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8F67EF69E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjKQQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjKQQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:40:41 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1ED4E;
        Fri, 17 Nov 2023 08:40:38 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so3291371a12.2;
        Fri, 17 Nov 2023 08:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700239237; x=1700844037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0y+U3exdKu+bPEqFoLrVI180ee3VjcW0CVcCQ7Q/FQA=;
        b=XS8WXVFPM/9QSIleFWu1u/JgfN8O97EV1+weGN3fCRUvA6qtZQKpwgTpWR5MUxbqm9
         yOOKTCt74uaSOPkl798j63MvuY0yoknMzTrsUt4TAPEJ35xsuqK7tGySsCGzbjFSdjE2
         zUZT1sf2t5PCHnvqtFUgtxl3tkYWWuKAGgK/RQd1vO6/6zAmGuaiEuNRr1+pEXAavxT+
         sR+HUVZL3ZIgoOjbNaiRaPmpfMjyoD2B2Wp4qCHPFhvxK+z55zfh+HOaOKAeIqevllTl
         mGzUAOhXzLWGdOI3Icm6XFjMWBGFStUUuDPJLkXhpVyQ+EDzumTs/7All+o8QDsJAvQ7
         qePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700239237; x=1700844037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0y+U3exdKu+bPEqFoLrVI180ee3VjcW0CVcCQ7Q/FQA=;
        b=wYkrWEl3ewjjHkOEYXNQE2kHfUgQw9Az7NocZVFOYksPlwNoHJ/01lVyLCJcyl2Pnd
         j6BralPfc86wSQ3/cMRKB+QSgYSw5YfKjhljXCkfTchU4JJ2GJLtku4DDklvB4pSXOjf
         3XtYzP0mSC++tJEozle5D79v65kAG6mG+fxOBy4adn47V+Q7f3nzW0IVuDXGDyP9gzMY
         OJqkU0C0SHcO2Nzrr+XEw4koBhAHKiV2tSU47hZOOkUv/gDsKZQtwrzPN9Yqkv0yleQj
         rwa43iKqcV/hJYg75bKa4DJZ3pDuhY0I+cK6joubhRjKUeiL9eLYi/+rD5LdZy9iUC9c
         uN0A==
X-Gm-Message-State: AOJu0YyXXJEqyvZpEgnAgublf1MrKcJ06JFk6tH814ALW0s8sZKQwwl1
        ujnlMFInJojTUnJCDyZsn3L+IzN6JvOeu71+Ts3WM4asoCc=
X-Google-Smtp-Source: AGHT+IFosc6dfaQi9LB55vnr/Ur7rkox2XlIFOIStxrbSdQT6Cy1BJ5lOYQODJEkfO17/vtN6rW3IThjBbWwKpiwUHA=
X-Received: by 2002:a05:6402:26cc:b0:548:4e53:99a7 with SMTP id
 x12-20020a05640226cc00b005484e5399a7mr1564420edd.23.1700239236796; Fri, 17
 Nov 2023 08:40:36 -0800 (PST)
MIME-Version: 1.0
References: <170023296234.391.6891224487945079423.tip-bot2@tip-bot2>
In-Reply-To: <170023296234.391.6891224487945079423.tip-bot2@tip-bot2>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 17 Nov 2023 17:40:25 +0100
Message-ID: <CAFULd4Z3G0h_0vptZOJFy+gD7vd6296V7hvuHfNH1A7FroKNNw@mail.gmail.com>
Subject: Re: [tip: x86/mm] x86/mm: Use %RIP-relative address in untagged_addr()
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradaed.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 3:56=E2=80=AFPM tip-bot2 for Uros Bizjak
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the x86/mm branch of tip:
>
> Commit-ID:     bc5607d7777423b742f5b0f7a760d074154c613f
> Gitweb:        https://git.kernel.org/tip/bc5607d7777423b742f5b0f7a760d07=
4154c613f
> Author:        Uros Bizjak <ubizjak@gmail.com>
> AuthorDate:    Thu, 16 Nov 2023 20:10:59 +01:00
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Fri, 17 Nov 2023 06:27:29 -08:00
>
> x86/mm: Use %RIP-relative address in untagged_addr()
>
> %RIP-relative addresses are nowadays correctly handled in alternative
> instructions, so remove misleading comment and improve assembly to
> use %RIP-relative address.
>
> Also, explicitly using %gs: prefix will segfault for non-SMP builds.
> Use macros from percpu.h which will DTRT with segment prefix register
> as far as SMP/non-SMP builds are concerned.
>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradaed.org>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Link: https://lore.kernel.org/all/20231116191127.3446476-1-ubizjak%40gmai=
l.com

I would just like to point out that this change depends on x86/percpu
branch in tip. So, the x86/mm has to come after x86/percpu.

Uros.
