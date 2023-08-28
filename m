Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1443578B66F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbjH1R3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjH1R3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:29:00 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C765E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:28:58 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44e8fc5dc63so981370137.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 10:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693243737; x=1693848537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ROVqh1j31/yDGoQGEjD+ZgYxpbyP+vRNz9MgEfFrbg=;
        b=dVyIJcluND5u7f/Z7guGu6XMhsqMokcZcJKcAeZ1Zst6e0U7coWVrIuTnDa4bj63+u
         MoTtcjp2J98tkyFqszvPZCjt5kA3Gt7RYWvHGp/vZ1WTtwgmZAIBqz8fx7D/3AFf6fZr
         i0QDTBgZQOQgbr8KyqBnJAbmJT1E0ftAnxKkAS8Kxxe0d4zGpRzmjY+1ZFOMDJ8M5oLy
         39BhK45TqHCs8kMhPT1IisvhFSL6K8Dq3iRaeNvjUQWuzrg20W2xgkF8ZwujHJ38FDG5
         AQmv6nqdiN4LvdauAm2TfEbPq6NzMUvsY/Mc2/oOp7AVUjTrRduedkdwGtXsHNCvZuDm
         su8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693243737; x=1693848537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ROVqh1j31/yDGoQGEjD+ZgYxpbyP+vRNz9MgEfFrbg=;
        b=SPr1HwvT9EWCE2Tlyg1ziY559WY0JDMnI+fRLlzY6qo8RGmTPiwvNtAzrtFnzZsGlK
         Y54gzI0otyUqmuerulyoAUQLkngmbGZ3Bx8LWqeM8eZhXYggXoUHaOe5ZIMORSk3M9cO
         sr5Eqrj9VodEn+4EQ8QD6zsenXZwGKwdAeLTw29dKDBZLQopdEzOMV1vGnbszgLaMyor
         VkBZZ+uDKN8xCkDQH90gSxuOqwrDUBYi+cd5IDC9Ve1IBTOy52u5THOraukA5nIlhENo
         NJdLx4f6aa6t2Srq1fKLw+j7h9eUdetkVvNjA8fluUKCpz74/Dsx1b2ZLQCYU71ifhbL
         FyCw==
X-Gm-Message-State: AOJu0YyFS6PXCwnnAMuNVePb9Q4CcGxLcdASD7ot3Twn7Ip4Y7bcVbij
        ilRcgbq7XYQGmgzqxniNso5oQVhqwlTUuF/iFjtyBA==
X-Google-Smtp-Source: AGHT+IFyIHIZIR/85snzj7o3/qdZ+zqzzm7B7WPWqfAfLUvy19QYleCGvQPodVs1Bc2aZHxXjIcYeubJXbgU0cTA0pA=
X-Received: by 2002:a67:eb06:0:b0:44d:5298:5bfc with SMTP id
 a6-20020a67eb06000000b0044d52985bfcmr14248099vso.17.1693243737352; Mon, 28
 Aug 2023 10:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230828145737.6ff53bc9@canb.auug.org.au>
In-Reply-To: <20230828145737.6ff53bc9@canb.auug.org.au>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 28 Aug 2023 10:28:46 -0700
Message-ID: <CAKwvOdms3YEsJ=buMvMbEK5yDqWwJO2LPmeJr+RP=SkP6h33fA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 9:57=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the kbuild tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/kbuild/llvm.rst:127: ERROR: Unknown target name: "reprocibl=
e_builds".
>
> Introduced by commit
>
>   bda09c0e14a4 ("Documentation/llvm: refresh docs")

Sorry about that; thanks for the report:
https://lore.kernel.org/llvm/20230828-docs_fixup-v1-1-cc78af124667@google.c=
om/
--=20
Thanks,
~Nick Desaulniers
