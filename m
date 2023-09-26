Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905C97AF411
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbjIZTXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjIZTXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:23:01 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D65411D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 12:22:55 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 8CE9F1820AC;
        Tue, 26 Sep 2023 21:22:53 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1695756173; bh=MXZZPvWBYrRdnVtDy0NSVMWn0yB2k/fF634A/Y0Nhvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XEO3TAJzMJJQZcOY+p9BZosiitw+bixBdP2sPB/lfqP+XTTQz9tKskBTYt98x9/AE
         KEmEMJbd3lxuMjYziNPa/rQyXfXsTYEEcH9pMKfm3mUke+5h7r2K/2FRaF6yLFr7Hy
         9YMqDvOlxZC7ZNh5q8UH8NFDyXK3hl0NB3ywYzEPuug2JeV/11OzhiMTjibUHIuABQ
         ia3k9kisPYU0ag12u/qSrzU/4LlwvmXTcaV1vZ49XuqMmFEB+H1bmfV6HNzXRD40aE
         137lYdRrpPoDjaXXkhxC3ApBx+WhMcPkIAll9YkUd+J+YZrC3VfmuLNdIBTy54sd29
         tlkJ8DUzmwBdQ==
Date:   Tue, 26 Sep 2023 21:22:52 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] checkpatch: warn about multi-line comments without an
 empty /* line
Message-ID: <20230926212252.3e44bd22@meshulam.tesarici.cz>
In-Reply-To: <20230926192006.18351-1-petr@tesarici.cz>
References: <20230926192006.18351-1-petr@tesarici.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V Tue, 26 Sep 2023 21:20:06 +0200
Petr Tesarik <petr@tesarici.cz> naps=C3=A1no:

> According to Documentation/process/coding-style.rst, the preferred style
> for multi-line comments outside net/ and drivers/net/ is:
>=20
> .. code-block:: c
>=20
>         /*
>          * This is the preferred style for multi-line
>          * comments in the Linux kernel source code.
>          * Please use it consistently.
>          *
>          * Description:  A column of asterisks on the left side,
>          * with beginning and ending almost-blank lines.
>          */
>=20
> Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> ---
>  scripts/checkpatch.pl | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7d16f863edf1..0fc3427a9ec9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4006,6 +4006,14 @@ sub process {
>  			     "networking block comments don't use an empty /* line, use /* Co=
mment...\n" . $hereprev);
>  		}
> =20
> +# Non-networking without an initial /*
> +		if ($realfile !~ m@^(drivers/net/|net/)@ &&
> +		    $prevrawline =3D~ /^\+[ \t]*\/\*.*[^ \t]$/ &&
> +		    $rawline =3D~ /^\+[ \t]*\*/) {
> +			WARN("MULTILINE_BLOCK_COMMENT_STYLE",

Oops. This should be just BLOCK_COMMENT_STYLE, without MULTILINE; v2 is
on the way...

Petr T

> +			     "multi-line block comments should start with an empty /* line\n"=
 . $hereprev);
> +		}
> +
>  # Block comments use * on subsequent lines
>  		if ($prevline =3D~ /$;[ \t]*$/ &&			#ends in comment
>  		    $prevrawline =3D~ /^\+.*?\/\*/ &&		#starting /*

