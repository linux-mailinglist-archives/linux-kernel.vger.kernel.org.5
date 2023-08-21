Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FBC783171
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHUTR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjHUTR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:17:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08427E47
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:17:20 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-59205f26e47so18653817b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692645440; x=1693250240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6WN3DCNO0zBtBrLem2uFNaX453NTVZRXkQjbDwp+UE=;
        b=2CjN166zZBzxws6nG1EdC27HLn5WtSdOmyf92tSUcWpfWuXmIWc4LJDek7zU/OW4Wk
         L66eQ83b99FPWly/mSj+N/F6XWyxQNs1cvHM4YAl1PDpxge6aAgD8ajIhmQATeLeIf+m
         AKFdyNgegn61Kb2wFa+InPr4kcC8M7urv1+cCmlSGPBd23ivAl7FYnKqqSWSe0nxAf1m
         MuB1pZN6R3JVFP2M3ujAIcolOwGmzFSUzABi5nPW7wEVBnN173C82jO3UM12qpF51Vx8
         SRIHcERRRjMF9SAhdOlJ9HTvniXU8NGoRD2cW1FlTlKcghHBC+dXl4f36vDHQD5S4pWj
         yr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692645440; x=1693250240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6WN3DCNO0zBtBrLem2uFNaX453NTVZRXkQjbDwp+UE=;
        b=Kguw1WzUOSMDPQpzX4jgO0uSUgwWgTNCPPbMqfnRiHt/SccFpB8+bd22nUTNY/3fkG
         r/DoGi4hvXIs6gXHFXztxKLxHtIxs3/YbuNgzeCwsopmPSOurq+d8R28UP+iCxjWOzU8
         5VVhhxewfPsHvgVcW1GjPGwCJJUcrnLp9UaNJCDxRG9KkE8bMoQiBr0cEzlI1Q1dVR2k
         ev+KjJMaPOcF53gRcT9g29da6GJohOJxEOTLi8fzZ6gN1ek47dGG1H/ohPRWjmtsfgBe
         uHH1QkMMKP5HIrA6MHL2soHRbCAg8KqR0GgxXncRDxZ8oU5I3YFVsWhSRKIhdk3Z+ynN
         sLzQ==
X-Gm-Message-State: AOJu0YxNCwTDDGhIk1wNF4hbcNdjqb0GsH/RosecgNuoRpAfJe/20Pjh
        6hqnBWvRLWzsJG1LwVHJwo26BvzeXF6MRfsKJLcnzWD5kUs6tyYLttE=
X-Google-Smtp-Source: AGHT+IGJYSZf1l0UJ0KSgxHAtOtmYq2E8CygBXeo6QYQKiG+p9L5bzR88fmYhCm7vChNHQ9vokZaZVqsyBeX/0JBpw8=
X-Received: by 2002:a05:6870:d113:b0:1bf:df47:7b5d with SMTP id
 e19-20020a056870d11300b001bfdf477b5dmr7201694oac.24.1692643242106; Mon, 21
 Aug 2023 11:40:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230819114301.3505878-1-masahiroy@kernel.org>
In-Reply-To: <20230819114301.3505878-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 21 Aug 2023 11:40:31 -0700
Message-ID: <CAKwvOd=bRs-YGfOcgzJ8WUPdP6hRr5ENX0seg0SSmdCktxAKJw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove include/ksym from CLEAN_FILES
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2023 at 4:43=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> This is a remnant of commit 5e9e95cc9148 ("kbuild: implement
> CONFIG_TRIM_UNUSED_KSYMS without recursion").
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch! I didn't see any more references to include/ksym
after this commit.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 4425d87dd2fa..f451241d0feb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1596,7 +1596,7 @@ endif
>  # make distclean Remove editor backup files, patch leftover files and th=
e like
>
>  # Directories & files removed with 'make clean'
> -CLEAN_FILES +=3D include/ksym vmlinux.symvers modules-only.symvers \
> +CLEAN_FILES +=3D vmlinux.symvers modules-only.symvers \
>                modules.builtin modules.builtin.modinfo modules.nsdeps \
>                compile_commands.json .thinlto-cache rust/test rust/doc \
>                rust-project.json .vmlinux.objs .vmlinux.export.c
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
