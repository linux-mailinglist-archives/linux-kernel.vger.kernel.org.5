Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4C7546F4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 07:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjGOFkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 01:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 01:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB893A9E;
        Fri, 14 Jul 2023 22:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F6D602DE;
        Sat, 15 Jul 2023 05:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BA8C433C8;
        Sat, 15 Jul 2023 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689399620;
        bh=EAL17cAw4V35DWAkUTEzrz4O8Jfxf/ncW1164/QpSe4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FmFrahlGdBnNpVp8+uTaOXsgxTffyDsWnk6nsUEnnlngLtu6IN8nzZqUlsu2Z3Kn2
         Z8CKXxs4RC7fUommyYID/T4BER4UUM61yYwzBO1xsINiIBCL+QWNH74lBK5gWU/8LG
         zwopUkTcQqcExK2JrAXVggN7TsR6IQZBd3AoKfA1tkLtRHuxgys2zM86vmLjchK8iO
         QYHJ5X7ofn8yJ7aMaRNcR07OIWfE0byKCN1DIDwdzVpQ/HwMwzrCBicv6DD+39qyZj
         cttN0no/82Cj1BQIbZX4VqfKJAbrPoEqTTYoRJQBvN7SPYJOCm2ZR5OXQpEVu+o+dP
         8xhiCm1+vje9Q==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5633b7e5f90so1796640eaf.1;
        Fri, 14 Jul 2023 22:40:20 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ+LkJjFeQxrjqMXlUK976VzPpZPNHLC68k7zDAs2XUhaFezWfG
        qFcO+S5PKpG2rinnIs1ecxnHVb5ygUqh56GSMkA=
X-Google-Smtp-Source: APBJJlGVhDGcPhnXqm7PrAnRyZNY/VVT+YH/LPgawJ5N6Kw2bdP5TxWjIUBWbmOi/KfP94O0atj8uxP3IR/QaUT9F7E=
X-Received: by 2002:a4a:9019:0:b0:563:49fd:e772 with SMTP id
 i25-20020a4a9019000000b0056349fde772mr630122oog.4.1689399619489; Fri, 14 Jul
 2023 22:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230711042859.17927-1-rdunlap@infradead.org>
In-Reply-To: <20230711042859.17927-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 15 Jul 2023 14:39:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQO7oB9vkW+T1EdhZ7Q43Uo5s02FgGDN6fr2nv+-RZcXA@mail.gmail.com>
Message-ID: <CAK7LNAQO7oB9vkW+T1EdhZ7Q43Uo5s02FgGDN6fr2nv+-RZcXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: gconfig: drop the Show Debug Info help text
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 1:29=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> The Show Debug Info option was removed eons ago. Now finish the job
> by removing the help text for it also.
>
> Fixes: 7b5d87215b38 ("gconfig: remove show_debug option")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org
> ---


Both applied.
Thanks.


>  scripts/kconfig/gconf.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff -- a/scripts/kconfig/gconf.c b/scripts/kconfig/gconf.c
> --- a/scripts/kconfig/gconf.c
> +++ b/scripts/kconfig/gconf.c
> @@ -647,10 +647,7 @@ void on_introduction1_activate(GtkMenuIt
>             "Although there is no cross reference yet to help you figure =
out\n"
>             "what other options must be enabled to support the option you=
\n"
>             "are interested in, you can still view the help of a grayed-o=
ut\n"
> -           "option.\n"
> -           "\n"
> -           "Toggling Show Debug Info under the Options menu will show \n=
"
> -           "the dependencies, which you can then match by examining othe=
r options.";
> +           "option.";
>
>         dialog =3D gtk_message_dialog_new(GTK_WINDOW(main_wnd),
>                                         GTK_DIALOG_DESTROY_WITH_PARENT,



--=20
Best Regards
Masahiro Yamada
