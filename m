Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA87FF7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345346AbjK3RNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 12:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjK3RNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:13:47 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61710D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:13:54 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5cfc3a48ab2so12763527b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701364433; x=1701969233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSy2x0/A5lqgvXskOAf5WXZ0MEkLef5VOeP9wtqhR1I=;
        b=DabvQYVNoU/wp/XHwPyb/LjvPOu5iO5ocSw2fDsBuOGtbBpkrZVf4x22UkZZxy5q8h
         prDtpBFQzEQo6e50cAet7ohFvPpUVwGWIWGSYR6HFnqxuEg6+BnV3kD39swvH2LhG+xW
         n//zrxF0w3re3zGavUIE4FtG6tpSjuRcDTGy0rbjvRPzEMwXF3FWfwjVw0GNz4CTRMl8
         Dr63ypua9YWEHDAn50CUYvv/nelMoCP2Lvv7npgqrNSsail85JzbrqjTuUBUQnFBNAAX
         da56T0X9L+IKxT57J+3+UIJYxX88IZU73c4c5Z43bKYyJpTpxwvdhBoh35yW2h1BdFYp
         oQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701364433; x=1701969233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSy2x0/A5lqgvXskOAf5WXZ0MEkLef5VOeP9wtqhR1I=;
        b=addOKzr/8fP3W+b0WbW8yaONd8SXjqx5gISwXPiZxU04Ldv6T1JQJyqFiNkwRMJ+Jb
         ue03PhbqV113arcAJb6HS2X18KELFRkzJT7OByQmD1Qo4WGvrI+mj0vvGDPvdIydzDVM
         wl68sdTypvQO+OuMD2PmwQ8lM1RjiBnGF//ImKi1aLNfuJhrilFG1NrFfpoztgZ2tb0O
         b+bwCCnSlvpyLYUk3Ny+FO6uVJLHpLNmDlkZz+JMyODZPgVJyZoH9UGGFLIyBWZUWec/
         0qHw0UC4Nwk/0rTNk8CSSTulLk1PHmJdsRvYVuc943FYoQxgDEc8yAXCBExqIlIcV7Fq
         JNAA==
X-Gm-Message-State: AOJu0YydKyXvaMTXWqfUIoCoMaYWLM0k5bQdGfoVrFHnYH1YTTtHiAUP
        WC2p7Svw+P02pRL/ZrAQQ+ETFBgx93uutbkdgZg=
X-Google-Smtp-Source: AGHT+IFV2WyN3WyjJhhFvPWMcJOKlYDA/6booNfFgBcpq3mwpl+5QeTP7FYGdk5C43ro0E3JrJ9Td7JKLaAgB5+UkJs=
X-Received: by 2002:a81:b65f:0:b0:5d3:d439:aabe with SMTP id
 h31-20020a81b65f000000b005d3d439aabemr457865ywk.26.1701364433258; Thu, 30 Nov
 2023 09:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20231130143822.17173-1-2023002089@link.tyut.edu.cn>
In-Reply-To: <20231130143822.17173-1-2023002089@link.tyut.edu.cn>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 30 Nov 2023 18:13:42 +0100
Message-ID: <CANiq72nS9_uPXNXc6mORtWsBEUB7JBWeUW+aAQ0Osqnca3vaVA@mail.gmail.com>
Subject: Re: [PATCH] scripts/show_delta: reformat code
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, ndesaulniers@google.com, n.schier@avm.de,
        ojeda@kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Nov 30, 2023 at 3:49=E2=80=AFPM Hu Haowen <2023002089@link.tyut.edu=
.cn> wrote:
>
> -                               if string.find(rest, base_str)=3D=3D1:
> +                               if string.find(rest, base_str) =3D=3D 1:

If this is changed, shouldn't be others like:

>                 if arg=3D=3D"-b":
>                 elif arg=3D=3D"-h":

be changed too?

In other words, it seems this was done manually. Should we instead
introduce/use something like Black or Ruff if we are going to do this
sort of changes?

Thanks!

Cheers,
Miguel
