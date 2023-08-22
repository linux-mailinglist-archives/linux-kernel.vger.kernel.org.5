Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBDE784351
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 16:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbjHVOHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 10:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjHVOHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 10:07:47 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAD5E42
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:07:23 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-56e99f97f0fso2543878eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692713183; x=1693317983;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x0GIc82FQ8pRqPHwhaCl7OoSHr/0L8bu2OoU4MGFCuc=;
        b=jJfQh1lOSZ525yjv8rIb1ikUFQID7CoA4PS6VjcGZ4wDSOtKTOUe3U+l1/xFaPJtqi
         y+Kcak7jvFDg5z86+Z6FSNfUGriXPOT9iMl/TrfsxBF5TU0vynjIXwZotK7B8HfiDUfT
         G7MVC0fTPadgbvfYa069m4FIKXFTcQVQ66GEfNbH69ruDWXQektFUTzikD9FZyXQOVFV
         K4B6snN+2fz+PhS9HkA0+VxLH6JFqQ7Xi0DxFHszO+O7RbUF8ae/g+XLoDBtTkCIGPPU
         01dDS7nCpIyl6JxRo5Gm9A0KmHMtdTdGCoJNp1OWx7I9NBc1Ah54zJ4IG59MdKfLcTw+
         AHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692713183; x=1693317983;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0GIc82FQ8pRqPHwhaCl7OoSHr/0L8bu2OoU4MGFCuc=;
        b=GAhvNt2SE422wcYAB4LZMNU4E/QQ2cZ92DdOM3HCbWZ11D6BA7wMgSA7kEjJ88cvpW
         ZxuTb1vivmLjGlCv/qYbHHB/7C/MtUmfI5KKQYllFtAstkHhZ7o42pPl+nrF7E1Sjd/a
         qL3SBtKJTYS/Fphd4iC/aas2/SudikBwpn6DacRJFzGoqea7gydDLiP3HNqEPK4CkzhI
         u4aDH25OKYyqo/ePg+DE6DSM+MklTNY04YvuNTGPcZsVZcgzXKxTYodIrHLjh7f12ul1
         lPbAZRataP+qOFC25IMvJuGbCGfn56jMlBU1rZ0cdyIH9A2e+K/48dOsqbrk3gwQQO9Q
         spOQ==
X-Gm-Message-State: AOJu0YxRfKzhZ1XZ/iZJGM4Oihx7Arzi9ChZYccwn+LTMS9lfSiHZuQv
        3+ZZfKO4G5xgGLVLI++pO6QvvK44qNhX5q6sT/Q=
X-Google-Smtp-Source: AGHT+IFnKO7eXAdo9UIr+jyQDrLzwsDW953+I/ef3r7+/3FY5d6jyUqkU9BrrclZIcIyfDnkkpSpX+z7hhwIX4PhGd4=
X-Received: by 2002:a4a:654e:0:b0:566:ed69:422d with SMTP id
 z14-20020a4a654e000000b00566ed69422dmr10109935oog.7.1692713183150; Tue, 22
 Aug 2023 07:06:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6647:0:b0:4f0:1250:dd51 with HTTP; Tue, 22 Aug 2023
 07:06:22 -0700 (PDT)
In-Reply-To: <cb996bf1-8074-09a0-4fab-dcc243f45878@oracle.com>
References: <20230821202829.2163744-1-mjguzik@gmail.com> <20230821202829.2163744-2-mjguzik@gmail.com>
 <cb996bf1-8074-09a0-4fab-dcc243f45878@oracle.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 22 Aug 2023 16:06:22 +0200
Message-ID: <CAGudoHFj2fPUAJvW6=yB9=XjMcwpQ=rcd77=-+4_o_EP3aYdZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] pcpcntr: add group allocation/free
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     linux-kernel@vger.kernel.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, shakeelb@google.com,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/22/23, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>
> Testing out a review style with very detailed comments. Let me know if
> you hate it. Review notes:
>

I do, very noisy and I don't think it adds any value. ;)

If something like this becomes the norm I'm confident people are going
to start skimming responses to their mail, as opposed to reading them.

But then again, I had serious disagreement with review folk in the past, so...

> On 8/21/23 22:28, Mateusz Guzik wrote:
>> +	counters = __alloc_percpu_gfp(sizeof(*counters) * count,
>> +				      sizeof(*counters), gfp);
>
> The second argument here is the alignment. I see other callers using
> __alignof__(type), which is what alloc_percpu_gfp() does as well. In
> practice I think it shouldn't matter, but for clarity/consistency maybe
> this should be __alignof__ as well?
>

Ye, I neglected to patch it up after a whipping out a PoC.

> Presumably multiplication overflow is not an issue here as it is with
> kmalloc and friends since the count can't be controlled by userspace.
>

I wanted to assert on the count being sensible to begin with, but
there is no general "only assert with debug enabled" macro. Perhaps a
warn_once + bail out would be preferred?

>> +	if (!counters) {
>> +		fbc[0].counters = NULL;
>>   		return -ENOMEM;
>> +	}
>
> Checked that __alloc_percpu_gfp() returns NULL on failure.
>
> Checked that nothing else before this in the function needs cleanup.
>
> In the old code, fbc->count would have gotten initialized but it
> shouldn't matter here, I think, as long as the counter is never activated.
>
> I'm not sure why only fbc[0].counters is set to NULL, should this happen
> for all the "count" members? [PS: percpu_counter_destroy_many() below
> has a check for fbc[0].counters]
>

Consumers looked fishy to me with zeroing the counter prior to calling
the init func.

I added the NULL assignment so that a call to destroy does nothing.

> In summary, my only slight concern is sizeof(*counters) being passed as
> the alignment to __alloc_percpu_gfp() when maybe it would be more
> appropriate to pass __alignof__() -- not that it makes a difference at
> runtime since both are 4 for s32.
>

Agreed, will patch later.

> One other thing: I find it a bit odd that the "amount" parameter
> (initial value) is s64 when the counters themselves are s32. Maybe just
> a leftover from an old version?
>

I don't know the reasoning by the authors, but seems a clear case to
me that the per-CPU counts were left int-sized to reduce memory usage
and reduce deviation between the central counter and the real state.

-- 
Mateusz Guzik <mjguzik gmail.com>
