Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156C9757207
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 04:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGRC4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGRC4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 22:56:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3C19A;
        Mon, 17 Jul 2023 19:56:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7589b187so8325858e87.1;
        Mon, 17 Jul 2023 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689648978; x=1692240978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3rk58Psl7S27OHhby9JRH6L//IDEFzEiQ47i4U3yc4=;
        b=ncVOk5kYgL7+rcKlGpeTa1hll32+iLmlGddfvgYDOWLuC8JOE98muS4SCAsa37oVhx
         J9jU/aRpA37YOZR4ve+K1v7t9Kkno8TtArEwvypwK7jhJcj1FoE+qXabLRhO3obxmkg2
         +sWspyEBMQ/x3UGx/xQ8Yhb2LKo3/Ot8gNV8RGlUTswZZ9Z6i5W/EecorPVpq5Z+kDzO
         v00dx2HFFe6i4XnLPnQLJ3XxATCYaO4Z0hazhYDRlUFK5u9VegV8+vSNYwd821CO82Ym
         nMx9cVKJoeBTkZ716+pRwfquQpt7xUY3rl0suH0HeDdit1OvsjEF/sffForcFt9san3p
         Jqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689648978; x=1692240978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3rk58Psl7S27OHhby9JRH6L//IDEFzEiQ47i4U3yc4=;
        b=Uz3aWjYmY4D6nL1DuMH7n9GQwuOUZMe9TWtfZZl5nzvQWJICE0k0z0Tc4zdoirGhJx
         M5/T8GHiQGsakTb6j/PF77zS8FTsd9gJUPYJ7QS5Mty/dZUQcQ8AP9OxwAlYdM/mE23V
         +a4LQ15nKK42pSwwTwiTo3JaEifgYdazdCXDq4Xj3/Er1y5wKETTflhbdA7cNfvZjnLr
         Y7gb7MvgXcnnpq3XSbqWktQgddU+P06Zuw1zsDE+7gpHoWwoO2MnT8gCG4BaXW5PL6JF
         2UamT8yr9eGBAUIr10gBkv5WcSf+JAEU09MiF6jXfcR+7SRREbgiKC9IGXpFBwKoODcr
         GK+g==
X-Gm-Message-State: ABy/qLZ/AsmLIfGE0E6XKpJ3+EBm5CDNR7Mj3KBScbhGRLi9blBoQm7x
        fpsbZn4Q3ZzxyG8LZMnS9gHmnQKRvUN+U9shpxn+JHfI7Wz8Jw==
X-Google-Smtp-Source: APBJJlGgkMFAlkppJ+m7HuWzIJzEOQp9Zs3QTAsYqBgR62KQzgDr1tAOBnpNs608/lC/1KSmywjeialRqKx4EViQblA=
X-Received: by 2002:a05:6512:234a:b0:4f8:7617:6445 with SMTP id
 p10-20020a056512234a00b004f876176445mr9643132lfu.48.1689648978222; Mon, 17
 Jul 2023 19:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <d03c7482-acde-4f33-a7fb-fa7c58fdc9a2@paulmck-laptop> <20230717182337.1098991-15-paulmck@kernel.org>
In-Reply-To: <20230717182337.1098991-15-paulmck@kernel.org>
From:   Feiyang Chen <chris.chenfeiyang@gmail.com>
Date:   Tue, 18 Jul 2023 10:56:06 +0800
Message-ID: <CACWXhK=Vc0kKpnOLRxgw-oP+QDJYt3AqD-kvcA1QkUitiW2Jng@mail.gmail.com>
Subject: Re: [PATCH rcu 15/18] torture: Add init-program support for loongarch
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 2:23=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> This commit adds the __loongarch__, __loongarch_lp64, and
> __loongarch_double_float targets to rcutorture's mkinitrd.sh
> script in order to allow nolibc init programs for loongarch.
>
> Cc: Feiyang Chen <chenfeiyang@loongson.cn>
> Cc: Huacai Chen <chenhuacai@loongson.cn>
> Cc: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  tools/testing/selftests/rcutorture/bin/mkinitrd.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh b/tools/t=
esting/selftests/rcutorture/bin/mkinitrd.sh
> index 3af3a86a0091..e7e23615dbe3 100755
> --- a/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> +++ b/tools/testing/selftests/rcutorture/bin/mkinitrd.sh
> @@ -63,7 +63,8 @@ ___EOF___
>  # build using nolibc on supported archs (smaller executable) and fall
>  # back to regular glibc on other ones.
>  if echo -e "#if __x86_64__||__i386__||__i486__||__i586__||__i686__" \
> -           "||__ARM_EABI__||__aarch64__||__s390x__\nyes\n#endif" \
> +           "||__ARM_EABI__||__aarch64__||__s390x__"\
> +          "||__loongarch__||__loongarch_lp64||__loongarch_double_float\n=
yes\n#endif" \

Hi, Paul,

Thank you for the patch, but I believe adding only the __loongarch__
should be sufficient.

Thanks,
Feiyang

>     | ${CROSS_COMPILE}gcc -E -nostdlib -xc - \
>     | grep -q '^yes'; then
>         # architecture supported by nolibc
> --
> 2.40.1
