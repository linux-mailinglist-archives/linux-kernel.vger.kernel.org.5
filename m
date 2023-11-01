Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B117DE331
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbjKAObk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 10:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjKAObi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 10:31:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DD5118;
        Wed,  1 Nov 2023 07:31:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDE2C433C7;
        Wed,  1 Nov 2023 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698849093;
        bh=S3QnZ5TLVGUDyUEnC8ZSxV6bintznPVwiXrtpENX4kk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rQuJq07sv+PfdvWLN44YdKyEL6wCflUbM5/TZ3B5jcrMso4+U/ZyHsv8FeCCjnpe4
         MuVCOCmuV5m0ZVa2Te+iwRkfo1yFJU2OgGgEHl2V3xTJc0J4tEqLMRv+wTPSrdKuvk
         YTEKMEhOhIJycU2UlGI6ZcdgpyEYO9KDj5mxHrgxVDc6BjC1DSaZT+uVD2buHy1Hw+
         qMMAZRYT3feZIljbISqCzhaCQOFTWxVtqJQPpJVLZz29JZnVL2xffF2XBV5qKXj8Sq
         PqFiE73TKdDlxAFpNgA3r22hhy2s1SaBkdvVlnRTIJpJiU+4wUpNExWSSEyRproy4F
         Yyn/oCDVbuWuQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1c0fcbf7ae4so4862635fac.0;
        Wed, 01 Nov 2023 07:31:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YzTWSos6NMU3a3ZvEaZ09FkGESDcehHWieAZ/mJhu6JH1R2RfCZ
        9FPdpCzQIIudM491NLoF3ZNZrUm8AUiQE3VkkGI=
X-Google-Smtp-Source: AGHT+IHqRO7Wo4Mu7rwxew/JPOMjW0zRH1eip+uTa8iUOPpJNc9wAAOWT6Dv3jAxrN/rfK8/HMgXCAox07bvKd9SX/s=
X-Received: by 2002:a05:6870:709c:b0:1d5:a17e:f62 with SMTP id
 v28-20020a056870709c00b001d5a17e0f62mr20914715oae.24.1698849093164; Wed, 01
 Nov 2023 07:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231030113416.5208-1-jirislaby@kernel.org>
In-Reply-To: <20231030113416.5208-1-jirislaby@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Nov 2023 23:30:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2y9v3+VDdz5jYrd69bDfWoS-dOk-G8DRMhkx-==9Ung@mail.gmail.com>
Message-ID: <CAK7LNAS2y9v3+VDdz5jYrd69bDfWoS-dOk-G8DRMhkx-==9Ung@mail.gmail.com>
Subject: Re: [PATCH] kbuild: dummy-tools: pretend we understand -fpatchable-function-entry
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 8:34=E2=80=AFPM Jiri Slaby (SUSE) <jirislaby@kernel=
.org> wrote:
>
> Commit 0f71dcfb4aef (powerpc/ftrace: Add support for
> -fpatchable-function-entry) added a script to check for
> -fpatchable-function-entry compiler support. The script expects compiler
> to emit the section __patchable_function_entries and few nops after a
> function entry.
>
> If the compiler understands and emits the above,
> CONFIG_ARCH_USING_PATCHABLE_FUNCTION_ENTRY is set.
>
> So teach dummy-tools' gcc about this.
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: linux-kbuild@vger.kernel.org
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---


Applied to linux-kbuild.
Thanks.




--=20
Best Regards
Masahiro Yamada
