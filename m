Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC77D235B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjJVOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjJVOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 10:32:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A80F3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:32:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9be1ee3dc86so349512166b.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697985140; x=1698589940; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dZX41vcGZiltzB8LzTi24NnB45xpP9Gd2/KAsXXU0T4=;
        b=TVVt/6NzFokoeRT/wMi3AJHqYzo+OLTn6kv5C5XPWyR8hmGgqvNcMuHTiYFGiOc4vV
         b054Q1uXpCp/hW4eF4QQ+My6O5crxRcbcMwA4X/UNol8ImE+nVVghSpGxlllNM9XTl+r
         AKqTPMUAgxtCuAZZoc4yDwaReo0WBkIeKFUho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697985140; x=1698589940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZX41vcGZiltzB8LzTi24NnB45xpP9Gd2/KAsXXU0T4=;
        b=YP2uvVH0F4YfbhvBAJb7dVQOf7LIuSuZEOROMCbCjzypwg27FVLBJNMfIbUutN9SIL
         YDSQWMGCEfCBywjU9rOA1A5G9eQ/4bPgxd2Atjod3jbYuqTH49/zaGHqF+tpFRjdEUz0
         Yoe768NYhevyaCoX4SKgDIa+/jlOLGF5OohbGIQZupfp000GWyHMjX1XvEf5hAPO/emj
         L2as5gEUy43Yc8vcSiCsVCy29uFcw5lFFLxezJ5qT+IDhTsMetyCLOBR9jAJihuN9ZxF
         q62Fx4GIHVIU77bVCoWYxRsRGvpgBVKedlyWqxGAF2KYruFFMWDK+K7Ahq2KuAwrpMqN
         l+nA==
X-Gm-Message-State: AOJu0Yx9vbQ3qoAn4g8YeM7yfgW2sK8xWizbS/X5bKv3BsctFO/zxrXs
        oVQ1v0YK78Be2kgVVvho6XOP6qNhSwtPsbhN32qwpQ==
X-Google-Smtp-Source: AGHT+IHCvE6zgMz5VFgzCnvSRA6w8gUN+SFp4UaRLgis+pi5DQ+96pkaTKVEV/K7ntAOsOG06S0zeA==
X-Received: by 2002:a17:906:da8c:b0:9ae:52fb:2202 with SMTP id xh12-20020a170906da8c00b009ae52fb2202mr5119741ejb.40.1697985140107;
        Sun, 22 Oct 2023 07:32:20 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906171a00b009c921a8aae2sm1270109eje.7.2023.10.22.07.32.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 07:32:19 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so3569691a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 07:32:19 -0700 (PDT)
X-Received: by 2002:a50:9f83:0:b0:53d:be55:5fc with SMTP id
 c3-20020a509f83000000b0053dbe5505fcmr3807228edf.27.1697985138915; Sun, 22 Oct
 2023 07:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231021183925.22831-1-brgl@bgdev.pl> <CAHk-=wiOJO8nfcDeUMwYXPQHLtTnngSDd4ieUWegW1Aru8TbnQ@mail.gmail.com>
 <CAMRc=Mc-oz4e4d9pJbvki3kGgMj1DzSS1EDKcycswJKCNAbqOQ@mail.gmail.com>
In-Reply-To: <CAMRc=Mc-oz4e4d9pJbvki3kGgMj1DzSS1EDKcycswJKCNAbqOQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Oct 2023 07:32:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVNOFP1dzKdCqXvoery5p8QoBB5THiJUMbZ1TxJb7FhQ@mail.gmail.com>
Message-ID: <CAHk-=wiVNOFP1dzKdCqXvoery5p8QoBB5THiJUMbZ1TxJb7FhQ@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.6-rc7
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2023 at 06:12, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> I have diff.algorithm = patience in my gitconfig. Typically this
> results in better diffs but not this time for some reason.

Yeah, that picks a really odd diff in this case.

May I actually suggest the 'histogram' diff algorithm to you? It's
kind of a "smarter patience" version, and at least for me it's been
the best of the choices.

Of course, there's always going to be some odd case where for one
reason or another one of the diff algorithms does better than the
others, but histogram does seem to result in good diffs most of the
time.

              Linus
