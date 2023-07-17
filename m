Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4606F7566DF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGQOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjGQOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:54:29 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B66E60
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:54:28 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7835ae70e46so206336239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689605668; x=1692197668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=csVGB2yTlENFqwIyjRsSQ8nMzGX8m4o3gR5+YTnVXNY=;
        b=dHsucCp3pyz4vWwfgVkq99hhWIShvj2tLIGUejSGFC81+YH0T09D3f6UlxJJP+vUIl
         0IQnJbV+Xq0stQWpyg0XVRlMRvA5Cr9jND/Qer0oGNNK2YB1VagsmvFU9h3GMh22uLf1
         lUcEJ1C4dmmjj4pZ2DwFClIEKKp8a8JUasrO/vzmSrho6LoG767IEOxD2PFBR/H7WwyC
         VZAO6FyN/dBN5VrszFs68ZWs7CJSjzVnvT7XVt9vlfzbD9Kr+wf6pwAo4AsDQfEBVkq6
         HUsovbFQkIBtZPpwF8TktJTGsvHjdWk8ptDU2Sd77iqtzvpqta9yBGR+vaOnJ+0x/xps
         bacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689605668; x=1692197668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=csVGB2yTlENFqwIyjRsSQ8nMzGX8m4o3gR5+YTnVXNY=;
        b=YvXKAZh9LES2EQnnFcqc/dPwgFfUXhPMQJtrfq46OjGwsRmbHTHyYhHFbqRGkABafD
         Tc6yS1u0fhNY3lqbRnc0NLjCAxC8mVx6+171aoOdOkt18mw0jI1HfOuiYVprbouM0UIV
         M3K82SjYCNknVqJ6AY2UXjAuyDEJ28qlByZx08eWI4LJqhju9KEQzYaUi0Fjb6TrbPne
         eYjGuVnCkwvPXYlKOWBhn+rYnzi31nhXtMQ3V5GxfJVe4QXgJfVAEmgRzRUucmK5ONNT
         Q+QetYct6osRtoxY93p/xsFk6zF8UNaCWG5jbyOuAP/O2M28hwkkQMHJW6sQMEZwRYc3
         Sb6g==
X-Gm-Message-State: ABy/qLYQoVYTLDVlpfuLaGiTuuNb3xaDTplLESTE5vR7hpUxqe1JFENw
        5fzS59968IvAXN+SmJq9+OpPHoOh7wWI2NCAvMNgCg==
X-Google-Smtp-Source: APBJJlEcrQnrJyQT3B05vHJDqGJN37AsfFo4smPvmib1VevffovCA3RTTZt489i7kRAM8gk32f0QId3ubr/Dzw0HJ54=
X-Received: by 2002:a6b:a0d:0:b0:786:25a3:ef30 with SMTP id
 z13-20020a6b0a0d000000b0078625a3ef30mr41841ioi.7.1689605667889; Mon, 17 Jul
 2023 07:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230717113709.328671-1-glider@google.com> <20230717113709.328671-2-glider@google.com>
 <ZLU7mkhUiDQodaw1@smile.fi.intel.com> <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
In-Reply-To: <CAG_fn=XNYQC8gKKQr3Mz7CVw8H=Ubmr+QaUu-jraoT4sN550rA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 17 Jul 2023 16:53:51 +0200
Message-ID: <CAG_fn=Ufo8sWbdtPyaXhvUddRG3k9E+btFVVLTn5Tk91cwAwLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] lib/bitmap: add bitmap_{set,get}_value()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
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

> >
> > I remember that this construction may bring horrible code on some architectures
> > with some version(s) of the compiler (*).
>
> Wow, even the trunk Clang and GCC seem to generate better code for
> your version of this line: https://godbolt.org/z/36Kqxhe6j

Oh wait.
First, my Godbolt reproducer is incorrect, it is using sizeof(unsigned
long) instead of 8 * sizeof(unsigned long) for BITS_PER_LONG.

>
> > To fix that I found an easy refactoring:
> >
> >                 map[index] &= ~(GENMASK(nbits, 0) << offset));
> >

Second, the line above should probably be:
  map[index] &= ~(GENMASK(nbits - 1, 0) << offset));

, right?
