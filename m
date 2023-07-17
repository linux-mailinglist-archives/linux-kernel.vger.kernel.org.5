Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5013755B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjGQG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjGQG0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:26:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E781700
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6466860F29
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:25:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB085C433CD
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689575102;
        bh=M+aBIDk8gF9TbKt2VjchGrvQUvaXF0DLEWlmQmRl5Y0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Lt79vDcBB8Bf9FDm1uMDifduuXtDspDZPNuAzdr3trzr8ZYcsf8DDnQIUuu8s0+NF
         EfcXhUU0uejFc4HfhLID39hEwvl0s93zDUdPW3dcy3Bd7inmIP0Qv7l4Nn5cViMFCG
         IEbel2jura9yKSYbf3A+H2tpeME7/Z/68+C15fJ79MKF/iKk5kfL+onjwTqeA/N012
         hBmX48I0A7jbuPI31RHSchmZx9yEVRPa+ilg4p1efgzGWCJnmnPvnhV1BTSCciovPw
         qX4jMxtd1Iwf+uPE5h8lLzrleA/RAYgXtDclgkViyCyhkjU5bKro6gkKHCmcDucUuL
         AOZFRqeIqXyEw==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51e5e4c6026so5794985a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:25:02 -0700 (PDT)
X-Gm-Message-State: ABy/qLbpvyrAfQqUEidvsZoCfxCEm7G2WUKkQLYnuMYXIFW9NrwzaJiO
        WHt5tuO0b+Y+/bahnYKIRiIIu1Nywvo+SJmsPKE=
X-Google-Smtp-Source: APBJJlF7jp28QiMSJoC7yf4/D47I4DGMgHllA94w9S0ZyKFkA74MgLbMr5DjNXkOGr/E4tdsv2yDmefglgeWteKKEAM=
X-Received: by 2002:a17:906:51dd:b0:965:ff38:2fbb with SMTP id
 v29-20020a17090651dd00b00965ff382fbbmr10011057ejk.1.1689575100962; Sun, 16
 Jul 2023 23:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <MEYP282MB2597514C7A4697A72F829B78D93BA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2597514C7A4697A72F829B78D93BA@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 17 Jul 2023 14:24:48 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6u5WBVC36OyNsFZVfmZ9_Nk+_ASFrYyxd5fsEEdNRaMQ@mail.gmail.com>
Message-ID: <CAAhV-H6u5WBVC36OyNsFZVfmZ9_Nk+_ASFrYyxd5fsEEdNRaMQ@mail.gmail.com>
Subject: Re: [PATCH v4] LoongArch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
To:     Dong Zhihong <donmor3000@hotmail.com>
Cc:     kernel@xen0n.name, ardb@kernel.org, tangyouling@loongson.cn,
        zhoubinbin@loongson.cn, yangtiezhu@loongson.cn, tglx@linutronix.de,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 12:09=E2=80=AFPM Dong Zhihong <donmor3000@hotmail.c=
om> wrote:
>
> Make CONFIG_CMDLINE work with CONFIG_CMDLINE_EXTEND and
> CONFIG_CMDLINE_BOOTLOADER. The touched function is bootcmdline_init()`.
> There's already code handling CONFIG_CMDLINE_FORCE, which replaces
> `boot_command_line` with CONFIG_CMDLINE and immediately`goto out`. It'd b=
e
> similar way to handle CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER=
,
> so some code is added after OF_FLATTREE part to handle them.
>
> Signed-off-by: Dong Zhihong <donmor3000@hotmail.com>
> ---
>
> v4 -> v3: Make CONFIG_CMDLINE appended to the end of command line (Huacai=
);
>         Removed unnecessary #ifdef since CONFIG_CMDLINE is always a strin=
g on
>         loongarch
> v3 -> v2: Reworded the commit message again to make it imperative (Ruoyao=
)
> v2 -> v1: Reworded the commit message so it's more imperative (Markus);
>         Added `goto out` to FDT part (Huacai)
>
>  arch/loongarch/kernel/setup.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 78a00359bde3..3cafda1a409e 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -332,7 +332,24 @@ static void __init bootcmdline_init(char **cmdline_p=
)
>                         strlcat(boot_command_line, " ", COMMAND_LINE_SIZE=
);
>
>                 strlcat(boot_command_line, init_command_line, COMMAND_LIN=
E_SIZE);
> +               goto out;
> +       }
> +#endif
> +
> +#ifdef CONFIG_CMDLINE
> +       /*
> +        * If CONFIG_CMDLINE_BOOTLOADER is enabled then we use thei built=
-in
> +        * command line if no command line given, or we append given comm=
and
> +        * line to the built-in one if CONFIG_CMDLINE_EXTEND is enabled.
> +        */
> +       if (IS_ENABLED(CONFIG_CMDLINE_EXTEND)) {
> +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
> +               strlcat(boot_command_line, " ", COMMAND_LINE_SIZE);
> +               strlcat(boot_command_line, init_command_line, COMMAND_LIN=
E_SIZE);
>         }
> +
> +       if (IS_ENABLED(CONFIG_CMDLINE_BOOTLOADER) && !boot_command_line[0=
])
> +               strscpy(boot_command_line, CONFIG_CMDLINE, COMMAND_LINE_S=
IZE);
>  #endif
???What is the difference between V3 and V4?
And the title can be "LoongArch: Fix CONFIG_CMDLINE_EXTEND and
CONFIG_CMDLINE_BOOTLOADER handling"

Huacai

>
>  out:
> --
> 2.25.1
>
