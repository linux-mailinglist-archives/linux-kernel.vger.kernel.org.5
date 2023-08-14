Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B10277C3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjHNW6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjHNW5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:57:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF69127;
        Mon, 14 Aug 2023 15:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692053862;
        bh=14INDazTUYUFWzV9WtQoTUDyMCvY1+63nIUTqw2FnSw=;
        h=Date:From:To:Cc:Subject:From;
        b=Nuxq3F+iYB4FxAy48OYBhJnP/k78ytutmpTadkp4xGSFhOPlJSdDhKSbw0ylNpISY
         0mv51DSIdNcpaLPoI43MpKKCvpGX68pdi9SKGdvJZ8SAdhvfUqrhli/wML2sPrc9dt
         ZHN1zTuvYOrTHitAUym3p0Hp52hqxuHSH7an0vBwzbg6yuKvpB8AIXUiy9FRVW4Jpz
         GEU1cOlnaEJlCZG7OoReWVMqOyu3pGe+RTnrBalIiFK+zP8lWLbs0dmIUqZrwqNVmr
         EOXgtm2R3iyKBmZRwscJghzpCm+bzvkTg+N90ww4kG4jnhfnT0NCHweYy966V4SFh5
         YUQTQZkKNuvMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPqYL2Kc2z4wxQ;
        Tue, 15 Aug 2023 08:57:42 +1000 (AEST)
Date:   Tue, 15 Aug 2023 08:57:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the vfs-brauner tree
Message-ID: <20230815085741.6d4ccca5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2v/V+.+Oq5d3ZFqjJFn7xzH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2v/V+.+Oq5d3ZFqjJFn7xzH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  4b4fb74b1aa1 ("vfs, security: Fix automount superblock LSM init problem, =
preventing NFS sb sharing")

Fixes tag

  Fixes: 779df6a5480f ("NFS: Ensure security label is set for root inode)

has these problem(s):

  - Subject has leading but no trailing quotes

--=20
Cheers,
Stephen Rothwell

--Sig_/2v/V+.+Oq5d3ZFqjJFn7xzH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTasWUACgkQAVBC80lX
0GxcLQgAjJPO0W7U40ph8bCEql4Af0ndafRs0zrje2EFUmm+A0AyHHZruBlmS32f
tiohvBeDalsGSdKU/lcFJJBKnUvX4V/Rcv+AZDtHwRzPc5K4rU2a2H+TFF5W479u
hoEZmbzoqqmVZB+KjB0FH7gXWrakmvf4oH8Y5RUnV0KZLqVjvodean4To7WpD5S7
7c9Z5rOM07KKCP+FeeA/CxrUZu4p8zBjWnSDkHHp9hezy41he/j1S2C0CG8pCztB
semBB6NWJw+rsTIeiuwtp2b9CUVNWJRMcXDgZu5mSZ9FgYpj2q+90AovK6stI/bm
nKyrIa/tgl0kXcFcMBp5incLUSbenQ==
=U+fJ
-----END PGP SIGNATURE-----

--Sig_/2v/V+.+Oq5d3ZFqjJFn7xzH--
