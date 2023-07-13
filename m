Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE47518A1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGMGKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjGMGKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:10:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F04B1BC6;
        Wed, 12 Jul 2023 23:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689228641;
        bh=nJFfRdlNtRWuw5Mn/XIpKrk8YzXtuTCuIDKzUFJVOI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ES2gcs5ZOrz4O1PwvC8aJl3rMhJS58EBsNwluxcvXstSChwz6TMkVF/DyNjAadhIo
         sX+nsD2p1cC42LNU7MWhjCYeW8kTMH1wgSRhgTpOmaz/amA+os8Q23eY/MUC9910mk
         RdDwAIBS0DT1KeFOhTD0uvoJvHIDc5awmP6E5wT00wYLMUfrNIOSv5R0HZZVq8d9M+
         JhEO+jOp52u01Q9g7EFBeDm0IGjQL/hxZcTX33E6Lza4r2l0TADP6ZvUBGnmdXEbNN
         t4CMVVFhdNCyu1hO6dnhDoRAiUrV9RYVs9lJ5zwQfGYD2O5ghTh76VWoSfGaPqX2AI
         rOs3cLn4nlt6Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R1kk865zMz4wZw;
        Thu, 13 Jul 2023 16:10:40 +1000 (AEST)
Date:   Thu, 13 Jul 2023 16:10:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] of: fix htmldocs build warnings
Message-ID: <20230713161038.382b5e14@canb.auug.org.au>
In-Reply-To: <20230322180032.1badd132@canb.auug.org.au>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
        <20230310113258.463f836c@canb.auug.org.au>
        <20230322180032.1badd132@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nSp=zVsy1Oi_nsL+KUslpqT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nSp=zVsy1Oi_nsL+KUslpqT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Wed, 22 Mar 2023 18:00:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Fix these htmldoc build warnings:
>=20
> include/linux/of.h:115: warning: cannot understand function prototype: 'c=
onst struct kobj_type of_node_ktype; '
> include/linux/of.h:118: warning: Excess function parameter 'phandle_name'=
 description in 'of_node_init'
>=20
> Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node cre=
ation functions")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/of.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> Replaces "[PATCH] of: fix htmldocs build warning" and additionally
> fixes the new warning about phandle that Randy reported.
>=20
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 9b7a99499ef3..d55dab9ad728 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -100,10 +100,12 @@ struct of_reconfig_data {
>  	struct property		*old_prop;
>  };
> =20
> +extern const struct kobj_type of_node_ktype;
> +extern const struct fwnode_operations of_fwnode_ops;
> +
>  /**
>   * of_node_init - initialize a devicetree node
>   * @node: Pointer to device node that has been created by kzalloc()
> - * @phandle_name: Name of property holding a phandle value
>   *
>   * On return the device_node refcount is set to one.  Use of_node_put()
>   * on @node when done to free the memory allocated for it.  If the node
> @@ -111,9 +113,6 @@ struct of_reconfig_data {
>   * whether to free the memory will be done by node->release(), which is
>   * of_node_release().
>   */
> -/* initialize a node */
> -extern const struct kobj_type of_node_ktype;
> -extern const struct fwnode_operations of_fwnode_ops;
>  static inline void of_node_init(struct device_node *node)
>  {
>  #if defined(CONFIG_OF_KOBJ)
> --=20
> 2.39.2

Any chance if this patch being applied?

--=20
Cheers,
Stephen Rothwell

--Sig_/nSp=zVsy1Oi_nsL+KUslpqT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSvlV4ACgkQAVBC80lX
0Gy4ZQf/c24EkHWBvudYW8Q2yM4QxG17J87Ui/lIDc86WEyfHr/LmvFyX8Ltba0r
88HLIalV+X3VYpilSjy82V7YPxikZP8mFtQ3fgcy4HnIVkXFYzV4vCfYl8KwCSld
WtoZvFkctYeceHEVl4TmDMGyKvmZqvQ6DYrIJt09L+RwIf53V/Sp0+lJvZH7thFi
rFwNy9d4ypTjrRcEng0gQykE9/JxntbRABiGWTmNTn91MsZ6tu241SXPu20ewzIm
yyivVdIpymp13Y091FWiwgunsKyTh95he3alzCuUp8PH/e38brSemwYDOqkW8t3e
8Rs/1bZE9RLYigreKoLlJljo9w03CA==
=WbOq
-----END PGP SIGNATURE-----

--Sig_/nSp=zVsy1Oi_nsL+KUslpqT--
