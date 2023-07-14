Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A7A753D31
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 16:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbjGNOX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 10:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjGNOXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 10:23:53 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1167F1727;
        Fri, 14 Jul 2023 07:23:47 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.15]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MoNy4-1paGPu1VcG-00or2a; Fri, 14 Jul 2023 16:16:46 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id F180F3E8BE; Fri, 14 Jul 2023 16:16:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1689344205; bh=Mw7jZhNZnvr2+e5xTUOaEHo78NFCUZeNOfrupTgSEr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvPlJEUiU7dl79ktIf68zpcKzerfhQGufISsEMBp61SHCEWj+KYqffb/lpk8nD5i1
         zroK/TxGL1SXTiB7LT3HPl5I+5ldreZboXoy8p8NqSwNqA+LZE+tSg8au9z47Jp+um
         1YQA9tz4kp5cACVW9ZE7hEe5WGxY+WlvreD6JHoI=
Date:   Fri, 14 Jul 2023 16:16:44 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v2 2/4] libkmod, depmod: Load modprobe.d, depmod.d
 from $prefix/lib.
Message-ID: <ZLFYzDyjP8sQPQOy@fjasle.eu>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230712140103.5468-2-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712140103.5468-2-msuchanek@suse.de>
X-Provags-ID: V03:K1:R/9mvZrizSzhd/VHQQL6gjrId/AnCEZ7HVV+Pnd2yK1fFFQS6iD
 bBB88Iaku+uTXL2ulN+pUKOMFnsMC4xGqJXrxrB6FA/wYfNgttP9h494yXT9WV9xdI325+r
 R2JcekaBPBUeyJVUJrZBgyOwsL89QLN/IBNkvThiuR2YrtGEIllRekatRMmkeVGPVg0d/nB
 trKNFprhIF73g1ceIAeVg==
UI-OutboundReport: notjunk:1;M01:P0:vAV7WWtxIFc=;2ksf4WeptNTO/ZGiRorapF1+hgq
 k3pSDnyNM55xw42ut2lziBRtQ5z0sbSf5M9jljLe1KLkbKp4zz5jMtyuflrDH/78dxkzE1FiJ
 kyGyug9OPAEXZwF3UTucONz6CKKjQ3cDuDi7CGdEdCndUE3Tc0nRBxOTTCdZ3h6nfef1lk1E7
 LKiJiuTTGYzBOx4x1JHkGcdflRYGNAApX1cLu5FWoPXr4SjyLnuOd01uN/EhCJzjFDFhFqMXy
 LeJ4CaxBc/PLtiRnbXK25MG9A97iKe0pw1x6K8O14GUxJNp0zc4WkYMnGb14dUWTwCeN22vsE
 1CqeCeJokA21UggqYDBPUabqcHwL6UEvINBj3F9BbOOHhFnyc5/b8ntEfWJtPALXaVXZ71vQr
 fNBBKMzdp2sHoj+u4EPTrKX46maNCVLMdUSkAP/f7W/PGyKHXzGujNHHej8PXooKZRdQMSz10
 9dGgS3TTpSbob+5qlhHEmMCq4Obces+OGkctJW3pZoOFSiUVhUISn6K6pHA7jyoFIGh26ltC2
 mTIe9l3o3V6tCn5HGryCHXP7Av6gnPHe9E8D4QxukiDafHslb9SFsvCk76/U4pFk/SrpWmWYT
 i1/65V1NSaHW5yOaQyNWp7XIXXdB68wX502Ij7eyDlXx42jmvWIA6ePjedF+V6R667VbN+5tf
 GZgM+atsoTnagT+DoAcjWJJvmRI9N35iwb0rwS6Awg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 04:00:46PM +0200 Michal Suchanek wrote:
> There is an ongoing effort to limit use of files outside of /usr (or
> $prefix on general). Currently all modprobe.d paths are hardcoded to
> outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> 
> On some distributions /usr/lib and /lib are the same directory because
> of a compatibility symlink, and it is possible to craft configuration
> files with sideeffects that would behave differently when loaded twice.
> However, the override semantic ensures that one 'overrides' the other,
> and only one configuration file of the same name is loaded from any of
> the search directories.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: Fix commit message typo
> ---
>  Makefile.am        | 1 +
>  libkmod/libkmod.c  | 3 ++-
>  man/Makefile.am    | 9 +++++++--
>  man/depmod.d.xml   | 1 +
>  man/modprobe.d.xml | 1 +
>  tools/depmod.c     | 1 +
>  6 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 8ba85c91a0f3..7aa5bfa5638d 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -19,6 +19,7 @@ AM_CPPFLAGS = \
>  	-include $(top_builddir)/config.h \
>  	-I$(top_srcdir) \
>  	-DSYSCONFDIR=\""$(sysconfdir)"\" \
> +	-DPREFIX=\""$(prefix)"\" \
>  	${zlib_CFLAGS}
>  
>  AM_CFLAGS = $(OUR_CFLAGS)
> diff --git a/libkmod/libkmod.c b/libkmod/libkmod.c
> index 2670f9a4611a..13c82b069e84 100644
> --- a/libkmod/libkmod.c
> +++ b/libkmod/libkmod.c
> @@ -65,6 +65,7 @@ static const char *const default_config_paths[] = {
>  	SYSCONFDIR "/modprobe.d",
>  	"/run/modprobe.d",
>  	"/usr/local/lib/modprobe.d",
> +	PREFIX "/lib/modprobe.d",
>  	"/lib/modprobe.d",
>  	NULL
>  };
> @@ -237,7 +238,7 @@ static char *get_kernel_release(const char *dirname)
>   *                to load from user-defined configuration parameters such as
>   *                alias, blacklists, commands (install, remove). If NULL
>   *                defaults to /etc/modprobe.d, /run/modprobe.d,
> - *                /usr/local/lib/modprobe.d and /lib/modprobe.d. Give an empty
> + *                /usr/local/lib/modprobe.d and PREFIX/lib/modprobe.d. Give an empty

In the chunk above, there still is /lib/modprobe.d included in the
default_config_paths array.

Kind regards,
Nicolas


-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
