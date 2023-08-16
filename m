Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9473C77DB8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242650AbjHPIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbjHPIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:00:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FECFAB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:00:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4ff72830927so4831183e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692172836; x=1692777636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g5kcMN1+qCSswLvMXMXnzHKTH4qhkS/GEJTR22lyI8Y=;
        b=bGaVdRi93AA0VFJATlPolvwqdqnNxjiys8O2Ah3bypeQSCdvuo5Acz9Lscdk7kB4Qu
         G7gwHoddzXRsxgE2004BLFF2ap7SvJdrSrXoqE4hLw5b2KO4WnY8YBGwcYGFj9p04ObK
         F00dUFl6VoLvFqZtil6GBGzjfJVe4Bz72eg+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692172836; x=1692777636;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g5kcMN1+qCSswLvMXMXnzHKTH4qhkS/GEJTR22lyI8Y=;
        b=CFVfnx3ET8/5ionTlgBfWgzOxZLWxMlhDJDQoN9aDbL5NAon+m6FBNBVK+3teDOepV
         d62uduik/Qm9hJ9mZj3SrBoAIRQ15r9P7fNw/IiR72drKlvOFgeqln2vR9YQb2ZFHSc6
         J1G0d+O7Qu8z7k1EIFg+v/LxDY3co4CEbUsLZGRrCyCJnNijxDStyC7xGT+D7xyJADQq
         qAl7KlXnUZNG1cOQHdVc613ofFuWjM/a1KnCHX+2k4Kklb3uNg/FjstOsWZ/bjSW+xaT
         6zvipleAa1eXtqQbSYv219hdJzn9agdU/+Hk2GpfL5VQf1nDRgf/J7c9ygYVMY33KCLn
         +8cw==
X-Gm-Message-State: AOJu0YxpO5dJBXi5Wo+a5lF9fO087qbdxl+5/HPSVzFri7Oe7FZW8Urj
        Z/FccdvHPjXuarOyIO4qefJbsj719mGJKXBphKsvqS0Q
X-Google-Smtp-Source: AGHT+IHavtBsMzfGlBSTzB+rRgG9ic+9O2bdH39H8XKdhGGdI9niyHKf1kbICJ6jCdI3yaPcmbumIA==
X-Received: by 2002:a05:6512:3d0f:b0:4f8:680a:68f8 with SMTP id d15-20020a0565123d0f00b004f8680a68f8mr1292884lfv.41.1692172835983;
        Wed, 16 Aug 2023 01:00:35 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id v26-20020a056402185a00b0052565298bedsm3877298edy.34.2023.08.16.01.00.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 01:00:35 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5234f2c6c1dso8455984a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:00:35 -0700 (PDT)
X-Received: by 2002:a05:6402:150d:b0:523:363e:f6e3 with SMTP id
 f13-20020a056402150d00b00523363ef6e3mr1188614edw.15.1692172834788; Wed, 16
 Aug 2023 01:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
 <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk> <20230815135339.GA966323@hirez.programming.kicks-ass.net>
 <a68424ff-b5e5-4dab-5705-5b63084c98eb@rasmusvillemoes.dk>
In-Reply-To: <a68424ff-b5e5-4dab-5705-5b63084c98eb@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 16 Aug 2023 08:00:17 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiOXePAqytCk6JuiP6MeePL6ksDYptE54hmztiGLYihjA@mail.gmail.com>
Message-ID: <CAHk-=wiOXePAqytCk6JuiP6MeePL6ksDYptE54hmztiGLYihjA@mail.gmail.com>
Subject: Re: cleanup: Make no_free_ptr() __must_check
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2023 at 07:23, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>
> Ah, ok, I thought the purpose was to ensure the p expression gets
> evaluated. Well, we can still do without the temp var and weird comma or
> statement expressions:

Well, the statement expression version with that types temporary
pointer was much better than yours, which just randomly returns 'void
*' and then lets the user assign it to any random pointer with no
warning.

But I think you can add just a 'typeof(p)' cast to it and that should
work out ok. I do absolutely hate how

But all of those macros seem to be fundamentally buggy because 'p'
gets evaluated twice. It could have side effects, even when just
having its address taken.

At that point the whole "comma or statement expression" discussion is
entirely immaterial.

So I think it needs to be something like

  #define __get_and_free_ptr(p) \
      ({ __auto_type __ptr = &(p); \
         __auto_type __val = *__ptr; \
         *__ptr = NULL;  __val; })

to deal with the "assign NULL and return old value without double evaluation".

And then you can have a wrapper macro to do the __must_check part,
something like

  static inline __must_check
  const volatile void * __must_check_fn(const volatile void *val)
  { return val; }

    #define no_free_ptr(p) \
        ((typeof(p)) __must_check_fn(__get_and_free_ptr(p)))

the above is entirely untested. Of course.

               Linus
