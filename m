Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF778DA10
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235477AbjH3SfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243708AbjH3Leg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB7132;
        Wed, 30 Aug 2023 04:34:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6A9362947;
        Wed, 30 Aug 2023 11:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B934C433CD;
        Wed, 30 Aug 2023 11:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693395273;
        bh=8PWPyT185nAtNOY9ZfIuQmYypEHvEnAKXob/fzJFzmU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UFbSR3+TrzjNWYwzynS+zz3AR+ROQkYYb8Jc1Y3bhCI9RN14hL/dH0F7/VtbK/2sd
         nHJ9bzuvjxVaFEPH82m7v9FlnhBCfRob3tlO07d2X5eK1wQqxLxTmbenus8BSKxe5v
         lXi8V++xXhIAW0v381yj8wDgiMu2o9AuQE/wMwXFmMLIo4N0Shf2xyriNS3mquojQ4
         hivIeh4RBAP7sSL1+gU4F6vURm+zhixSZcW22i3G9LgKv6XQ4asQvHmVgX8v6BLL+z
         hGTeSQXJGbLUViQ2bW6BbibUcjPyz/jd+ylMS/csxK6gsPw0x9Aos8OP4tosjJFP7x
         OZAFbwz2RLmtg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a9f87adfe1so133853b6e.1;
        Wed, 30 Aug 2023 04:34:32 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy5xBhoPz0onTjIEIyUNCbOILHqjOkaztGvOu83Fjlw4sliMfu1
        BMYt7f+EwDc8CY7mkl2oLzE8k4FwRmeBUqpZARY=
X-Google-Smtp-Source: AGHT+IGGq5Rqco8PApfnoN6MY05uD7oJkUFoXYsw6ftS35VEXOIjGOHW2RlK6KWUSGFFkiYpsLeyv5+GV14iOu/km8A=
X-Received: by 2002:a05:6808:a09:b0:3a8:1012:89d6 with SMTP id
 n9-20020a0568080a0900b003a8101289d6mr1682501oij.34.1693395272281; Wed, 30 Aug
 2023 04:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230829113531.4004730-1-masahiroy@kernel.org> <ZO3d7DrfKfsDXqa5@bergen.fjasle.eu>
In-Reply-To: <ZO3d7DrfKfsDXqa5@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 30 Aug 2023 20:33:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvUo7gKFG9NjtJarTBM508ntf2v6yo5tXsmDoMcUrJVA@mail.gmail.com>
Message-ID: <CAK7LNATvUo7gKFG9NjtJarTBM508ntf2v6yo5tXsmDoMcUrJVA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: single-quote the format string of printf
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 10:00=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> On Tue 29 Aug 2023 20:35:31 GMT, Masahiro Yamada wrote:
> > Use single-quotes to avoid escape sequences (\\n).
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> Is this really necessary?  Testing w/ GNU Make 4.3, bash 5.2.15 or
> dash 0.5.12-6 and a stupid Makefile snippet I cannot see any difference
> between these three:
>
> print:
>         @printf "hello med single-backslash and double quotes\n"
>         @printf 'hello med single-backslash and single quotes\n'
>         @printf "hello med double-backslash and double quotes\\n"
>
> Only double-backslash+n in single-quotes does not work, for obvious
> reasons.


You are right.

I was misunderstanding the backslash-escaping in double-quotes.

I always used single-quotes when I wanted to avoid
escape sequences.

The following POSIX spec applies here:


  2.2.3 Double-Quotes

  The <backslash> shall retain its special meaning as an escape character
  (see Escape Character (Backslash)) only when followed by one of the
  following characters when considered special:

  $   `   "   \   <newline>




https://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html


All of "\\n", "\n", '\n' are the same.



--=20
Best Regards
Masahiro Yamada
