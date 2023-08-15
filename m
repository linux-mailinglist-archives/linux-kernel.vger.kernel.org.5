Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BB577C95D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbjHOI2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjHOI1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:27:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FBF19B1;
        Tue, 15 Aug 2023 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692088059;
        bh=ILe/KQxl3q9H0isMqnRIm/TMdvbDqFmbkajIGHLtdzg=;
        h=Date:From:To:Cc:Subject:From;
        b=pf4l3dd9TwFJO4JYG8kJ9olltVKzLENjdgh6ixHTo61EDrhePDQpSdxdPkylcliix
         Waq6r0Bxb4KkS6R6r3T65ZlGOtriH/1fqTXR95rpOLBcV74pE0WAFlZfuk3IdRM6t1
         rgvgi/r3wratJd/REvnLmRpuPzSUzMQq9w+KqzLTB2iz63RbjLM0GM/6a5plMNlLf4
         GObNfdT+w+r86EBqwJKWQ3l1rX1EjsugExBULfzrWo+UYM7IIxGS1/aQzQNvWCeJp6
         gqAxiVDLbGgp7yxOCan56tvGOnfepw/RQ79nTz/QPguWqcrTz0rESrYD8FkPbxh12M
         Er0gLj2MEgLpA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ4By1K6xz4wqX;
        Tue, 15 Aug 2023 18:27:38 +1000 (AEST)
Date:   Tue, 15 Aug 2023 18:27:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the fsi tree with the char-misc tree
Message-ID: <20230815182737.534f4ec2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Nc3hkoqBVTTm2D7H7kOZnll";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nc3hkoqBVTTm2D7H7kOZnll
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fsi tree got a conflict in:

  drivers/fsi/fsi-core.c

between commits:

  adde0e112c63 ("fsi: Improve master indexing")
  b1d3a803acfa ("fsi: Lock mutex for master device registration")

from the char-misc tree and commit:

  4ecd69609bc0 ("fsi: Improve master indexing")

from the fsi tree.

I fixed it up (I used the char-misc tree version as it seems to be newer)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Nc3hkoqBVTTm2D7H7kOZnll
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbNvkACgkQAVBC80lX
0Gyc0wgAgKeXl3cCxmXfsHWWoreHaYSLtfppOZ1WwYjgqhR4nzjBDYNMLCLa2cB7
1jT7IOOAZowOWaXOPhc4P7npJDOpz41FEdKIXL6p6iTQpgVcEb+O3ZxZNwX4ZcbT
yW8U16zihEoPgADK/5+FI6L1zIKswWo7EOqCRTGd30JWP68TEPEg05jD8ms9kWb3
z8qgFTHtcTgU+VTGWim202exVlRDkvWDW7whePT+k1kkTUqQZwJTD97OaPF3CT9M
g3ji7pQ5p6l4e6+q/Lpdj4RCD0lBAegaW7IaZWZMA5KnIVmFp7YrhuyszMcq9uWi
BRW0SyIfFjp1sYR2sYNCV+CRGBM11A==
=2Vn/
-----END PGP SIGNATURE-----

--Sig_/Nc3hkoqBVTTm2D7H7kOZnll--
