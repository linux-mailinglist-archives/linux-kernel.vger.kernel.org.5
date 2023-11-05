Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D017E17E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjKEXWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEXWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:22:15 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06270CC;
        Sun,  5 Nov 2023 15:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699226531;
        bh=lHq2yBVx2PRPUkReEuYgqvnzXGUDwT03Ph9QcnzcWv8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EeqeRSvYpZqCRnmfBdE0l6CPQzKlidBtsWLsHia+dihBX1EupMHsGJCl/SpT2F5lN
         LDPke2/tNchc12J8uApvhiJ2rJ6q6x/IRqGvwpYJ77DLi0o8ZRVJz915jv0kej1d3P
         dvrqHOtcxn+rVG63QCDUiDFYim7SBp+7QEmp3K4A4e3QdWZYU/4EjfIs4GQ/2IC7KW
         tDfr/vEOolDE0+7NLw4bEuMRQN8NYNu8llZGxWiqQl/N+Nm0xYwXmpAhrJkkKEJzNa
         7rJVzbAAQbDvcEAqv+hfasH1u5T8I+nZ9No6RDPY+fsGtqj8uZdmaZdWFWvj963Lns
         bSrWfKgjuU2Kg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SNr9H0QQwz4x5m;
        Mon,  6 Nov 2023 10:22:10 +1100 (AEDT)
Date:   Mon, 6 Nov 2023 10:22:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the landlock tree
Message-ID: <20231106102209.4b07d7e7@canb.auug.org.au>
In-Reply-To: <20231027163400.5764d549@canb.auug.org.au>
References: <20231027163400.5764d549@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L4WbjisVULi66lxp_lEZC4x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L4WbjisVULi66lxp_lEZC4x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Oct 2023 16:34:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the landlock tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> In file included from security/landlock/net.c:14:
> security/landlock/net.c: In function 'landlock_add_net_hooks':
> security/landlock/common.h:12:23: error: passing argument 3 of 'security_=
add_hooks' from incompatible pointer type [-Werror=3Dincompatible-pointer-t=
ypes]
>    12 | #define LANDLOCK_NAME "landlock"
>       |                       ^~~~~~~~~~
>       |                       |
>       |                       char *
> security/landlock/net.c:199:28: note: in expansion of macro 'LANDLOCK_NAM=
E'
>   199 |                            LANDLOCK_NAME);
>       |                            ^~~~~~~~~~~~~
> In file included from security/landlock/setup.h:12,
>                  from security/landlock/cred.h:17,
>                  from security/landlock/net.c:15:
> include/linux/lsm_hooks.h:120:53: note: expected 'const struct lsm_id *' =
but argument is of type 'char *'
>   120 |                                const struct lsm_id *lsmid);
>       |                                ~~~~~~~~~~~~~~~~~~~~~^~~~~
>=20
> Caused by commit
>=20
>   fff69fb03dde ("landlock: Support network rules with TCP bind and connec=
t")
>=20
> interacting with commit
>=20
>   9b09f11320db ("LSM: Identify modules by more than name")
>=20
> from the security tree.
>=20
> I have applied the following merge resolution patch.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Fri, 27 Oct 2023 16:13:32 +1100
> Subject: [PATCH] fixup for "landlock: Support network rules with TCP bind=
 and
>  connect"
>=20
> interacting with "LSM: Identify modules by more than name"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  security/landlock/net.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index aaa92c2b1f08..efa1b644a4af 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -196,5 +196,5 @@ static struct security_hook_list landlock_hooks[] __r=
o_after_init =3D {
>  __init void landlock_add_net_hooks(void)
>  {
>  	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
> -			   LANDLOCK_NAME);
> +			   &landlock_lsmid);
>  }
> --=20
> 2.40.1

This is now a conflict between the security tree and Linus' tree.
--=20
Cheers,
Stephen Rothwell

--Sig_/L4WbjisVULi66lxp_lEZC4x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVII6EACgkQAVBC80lX
0GxX6gf/Traap0Ho5WqkzDsT4PKC5irgj6MhkN1wWCxfABSHc8sqOlRNKIMD1Jpj
3pk2irkl86l5AL9pUwmtSMPUZkSjhYMM7X87Bj8QCDy6mIa8xiQ1ExQ+WFzA9s9K
O9Y3WM7OB2vGonkFV/MRAk5RIbOogSI88s8ygomu2rw6n4BEJJvr7qtsQIoS+mhD
bmtxz3j3UhpZrjjciNJw9+76IAEVnyw0PrwgftAZjCHg5OkwtlsFY7CNschjprG3
7erw3YZPR3X6tPsfRbs9FveAWrCBpTa6SDubFuRppkzQFEmHVcpDGX7AzKe5xL4y
cUXj7Qt/4/GVrOvg2ZP/B8hxFiDY6Q==
=0F30
-----END PGP SIGNATURE-----

--Sig_/L4WbjisVULi66lxp_lEZC4x--
