Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A1B75EA49
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjGXDzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXDzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:55:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC7D7;
        Sun, 23 Jul 2023 20:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690170916;
        bh=1O9veABFuWEkzULx1hz8w11nCNSgdrxGO+rHILRsC0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EOgqsgJNXyat/NFshfTdGBEP3OtXREIhy+InJyW25sZANRaKdpy92hnyxNw2J3s2u
         /o9bMq56fjUr4wB/eaoAgQUX6lfdWI+MEj/Df5RwvizWW0a5Tlc7soiev+GmcNPvbm
         0XNbsldgJpqCbUlQaODJiBSBZFzuW72jpAGy2mA2DxTqdlbLt8oLOs6QKUHC3+F7xw
         l9Q2zr13OJaSX80gDM3EQ9dRw4d7AD7nF4ZO4gh0zLLQE9AtSNYsd+AMazumoobuxJ
         1BQGNWI53SvPcVOyvgFFbKnm7aWSCGlupWmnitZ0WLIArAOiIJVVeekxwbQ+hUrw2H
         ZKHxq9JFwkHpg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8RBq6PyCz4wy1;
        Mon, 24 Jul 2023 13:55:15 +1000 (AEST)
Date:   Mon, 24 Jul 2023 13:55:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] of: fix htmldocs build warnings
Message-ID: <20230724135513.3773f184@canb.auug.org.au>
In-Reply-To: <20230713161038.382b5e14@canb.auug.org.au>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
        <20230310113258.463f836c@canb.auug.org.au>
        <20230322180032.1badd132@canb.auug.org.au>
        <20230713161038.382b5e14@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1a4j_oBF+fVe6xjvNiDxNmv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1a4j_oBF+fVe6xjvNiDxNmv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 13 Jul 2023 16:10:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Wed, 22 Mar 2023 18:00:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Fix these htmldoc build warnings:
> >=20
> > include/linux/of.h:115: warning: cannot understand function prototype: =
'const struct kobj_type of_node_ktype; '
> > include/linux/of.h:118: warning: Excess function parameter 'phandle_nam=
e' description in 'of_node_init'
> >=20
> > Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node c=
reation functions")
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  include/linux/of.h | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > Replaces "[PATCH] of: fix htmldocs build warning" and additionally
> > fixes the new warning about phandle that Randy reported.
> >=20
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 9b7a99499ef3..d55dab9ad728 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -100,10 +100,12 @@ struct of_reconfig_data {
> >  	struct property		*old_prop;
> >  };
> > =20
> > +extern const struct kobj_type of_node_ktype;
> > +extern const struct fwnode_operations of_fwnode_ops;
> > +
> >  /**
> >   * of_node_init - initialize a devicetree node
> >   * @node: Pointer to device node that has been created by kzalloc()
> > - * @phandle_name: Name of property holding a phandle value
> >   *
> >   * On return the device_node refcount is set to one.  Use of_node_put()
> >   * on @node when done to free the memory allocated for it.  If the node
> > @@ -111,9 +113,6 @@ struct of_reconfig_data {
> >   * whether to free the memory will be done by node->release(), which is
> >   * of_node_release().
> >   */
> > -/* initialize a node */
> > -extern const struct kobj_type of_node_ktype;
> > -extern const struct fwnode_operations of_fwnode_ops;
> >  static inline void of_node_init(struct device_node *node)
> >  {
> >  #if defined(CONFIG_OF_KOBJ)
> > --=20
> > 2.39.2 =20
>=20
> Any chance if this patch being applied?

Is there something wrong with the patch?

P.S. Rob, should I use your kernel.org address as your linux-next
contact?
--=20
Cheers,
Stephen Rothwell

--Sig_/1a4j_oBF+fVe6xjvNiDxNmv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS99iIACgkQAVBC80lX
0GwUjgf/ZLyWdLI8NGli3RmCOslcvCkMO1wrOinImDrfrn5yZnstdgdBmNUObUTD
4Xghp0pi6sbYyn4WVBuf3JKL4XrPMt8rJ47O4Nid8PcKfbsONDgIhRlbWBNHRHM5
PGvNuMMSr9/M4qNFCFDe2D1XLa5HouiTOGVNw+sR0fBkOBu7UHawNmC1PrBn+zcv
voCgjQbL9J1Czmpresx8q8H/Oz+apSVSv5xpOb3REFsmvt2Xih3xal00iinS9o53
ZbmMkDyUUjt9O85XM8LXTCJhL3j39c5NDCW0Bz+eh+VugL0T+24Ky+JnzoPKTx5V
gyy6QSd0ED+tYp5jfWJzZNpTC4swwg==
=R8n4
-----END PGP SIGNATURE-----

--Sig_/1a4j_oBF+fVe6xjvNiDxNmv--
