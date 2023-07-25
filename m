Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED667610F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjGYKd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjGYKd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:33:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEBD10CC;
        Tue, 25 Jul 2023 03:33:53 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d10354858e8so2186530276.2;
        Tue, 25 Jul 2023 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690281233; x=1690886033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBf0AFzrkBKK62xa2+Pk3Zqv2kq6MRjCO1z0Xr7zjbs=;
        b=VTyjbD6uQSqHq1w83I0uPKS8J/aZEY3vIpSwTGuJjdhJNYnrtgKi+v81MBUbQExYxI
         aK+CiLYBsEH1LLI/0ZCpRYADgB24Q10fuvrgLQQc6B042pz29SyAjk6Ck0KFpoP9Piaw
         oL/dY453TYsSx5yINPWqhGaUtFYeNNFd621M9WPKUKL7q8bZ9UAoOSG7lEbEtYIC7b7h
         u0NPbWC81O/CBwJqyaE39PkZeTITabZCwOYG95MeSPU9r8843p6hWoRxQjAFU7J6pfwk
         ozWaOvqKMC0aUI2SE7XOp7gx8V2lRWwgPcOOASBFqhorBYcbUr4fGoC1fzO8WM474sKx
         owGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690281233; x=1690886033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBf0AFzrkBKK62xa2+Pk3Zqv2kq6MRjCO1z0Xr7zjbs=;
        b=IxUS9k9YO6yTB5ASgQu0+AbfvFhfmyNEkstKP6btoZI2acW0PJhlL2WKRrW9cxuWSj
         MN3Obz1MvkGiruI0WHkaQWFCXgM/qcG/SVctAEoXlLv/qaSki3Ehh8EvDH2w3qcfh8ig
         krgQUXlQtC4r5LOcerOaIN+b3VPv9+1AGjeN9HrkJTDltZFxtJ8XZgMjM5F8zbrR44ZB
         11vzR/l2zVHWZMSKmRGmN27hc+9ae77boSAd+bYJhuI5D2soB4ZltJ3QUz1xHEi2kzeL
         BU9NYO0ffG3O+JbMR0rVcV1mGebgjhOoT6bajAg1gDg0IKRIf1WLgrLYVgN3TKYfEzAd
         S7Sg==
X-Gm-Message-State: ABy/qLbABvWT+gCpaVZHCGUpUAKxLabCKsLvNW1pW5mTlamc8YaztLIG
        SdDGKNKBbc863RO4ZBwe2pw4tc1nEC3uKgdn2co=
X-Google-Smtp-Source: APBJJlEtHSmrzSE407F1F+wP6SW3uI04+fKfwmuoPdla8VrlolU4zp6lKRWpDsPyTkMfV9Y+yokd7Cs0KXaV7I8/jok=
X-Received: by 2002:a25:9101:0:b0:cad:347e:2c8f with SMTP id
 v1-20020a259101000000b00cad347e2c8fmr9071132ybl.39.1690281232968; Tue, 25 Jul
 2023 03:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230724131741.954624-1-james.clark@arm.com> <CANiq72nJP+i10CZysua0QU=V=Cn=jdnLuV8KOqm6_NNFdg9S3w@mail.gmail.com>
 <6c99392f-6189-1835-3090-d5c7f95edaf9@arm.com>
In-Reply-To: <6c99392f-6189-1835-3090-d5c7f95edaf9@arm.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 25 Jul 2023 12:33:41 +0200
Message-ID: <CANiq72nPxb8p5YCTohGg5e3c4gPTYsfh8fB182D_SwO-rQm9pg@mail.gmail.com>
Subject: Re: [PATCH] scripts/kallsyms: Fix build failure by setting errno
 before calling getline()
To:     James Clark <james.clark@arm.com>
Cc:     linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Nicolas Schier <n.schier@avm.de>
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

On Tue, Jul 25, 2023 at 10:55=E2=80=AFAM James Clark <james.clark@arm.com> =
wrote:
>
> But I just checked now and it's just bear [1] that causes the issue.
> Maybe it sets errno before forking and that persists in the child
> processes? Not 100% sure how it works. I did debug scripts/kallsyms and
> errno was already set on the first line of main(), so it's not some
> other library call in kallsyms that is setting it but not being checked.

I think this is https://github.com/rizsotto/Bear/issues/469: bear
preloads a library which was setting it to non-zero.

Now, even if bear was breaking a guarantee C programs have (`errno`
for the initial thread at program startup is meant to be 0 according
to the C standard), it is still a good idea to set `errno` to zero
here in case something else happens to change `errno` within
`kallsyms` in the future.

With the repro and the `bear` link issue added:

    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
