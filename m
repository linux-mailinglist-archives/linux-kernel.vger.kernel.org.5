Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79277CBDF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbjHOLlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236900AbjHOLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:40:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44F61984;
        Tue, 15 Aug 2023 04:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692099611;
        bh=yHEMXtdURLy+wUfMMqAfQCip6KzpfNWGsRc4wSefEns=;
        h=Date:From:To:Cc:Subject:From;
        b=KnwTht9f1yUz3Kd8atGjJMkVViuTUE7RqEpTNDF1YghKfsa7F9hDj1nf6OI3vIqwO
         zFQZU6Uvn8j8dcIeEbP4LAr7GYH5DHMLjDlloQlz+UTb25F6Uf7DVAiTDnn/3adu5f
         Guz6/+OcC+MJaC/gjlLI/mesfdS7GTONEeZjslm9ZePIWJm+Z5hUH3ejGo+aUldp0z
         2sEis91H1qsEeTUJzqhoPHV4Dioyu1u0KlKo63HFDcBVRKjVLYehJXbIwmvrZirh1H
         xNLbBskTJKcxj5ZU7Wh8RSbQtSPfUut3kyyDlNjk7NfVe4TeDr7vfAhAvd7b/wO9/X
         1gmH11+oO5Yvg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RQ8T70Nh1z4wbP;
        Tue, 15 Aug 2023 21:40:11 +1000 (AEST)
Date:   Tue, 15 Aug 2023 21:40:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the fsi tree
Message-ID: <20230815214010.712651b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SJ5Ar.X+KG+Rir3FemKw+Le";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SJ5Ar.X+KG+Rir3FemKw+Le
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the char-misc tree as different
commits (but the same patches):

  2ecbdc7eea63 ("dt-bindings: fsi: Document the IBM I2C Responder virtual F=
SI master")
  366b119391d1 ("fsi: Add IBM I2C Responder virtual FSI master")
  5b4ffc4030fb ("fsi: Add I2C Responder SCOM driver")
  83ec2bf4d7d2 ("docs: ABI: fix spelling/grammar in SBEFIFO timeout interfa=
ce")
  c0d1c32d8bcb ("fsi: master-ast-cf: Add MODULE_FIRMWARE macro")
  f432b1cf7820 ("fsi: fix some spelling mistakes in comment")

--=20
Cheers,
Stephen Rothwell

--Sig_/SJ5Ar.X+KG+Rir3FemKw+Le
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTbZBoACgkQAVBC80lX
0GyxJwgApUBGdJj6uLY7pirlKzB7XB18wsAGkO6nnrQzP6/l3vH5Fzgwkw7pmdbE
wBmmxYQOQMFuXs3/W3jRnvkrYlOlpOrwHTqlmSN0Qx6Q2419znK8DAxSsVfQFkmN
qxzIM/QNj3jw0HEkz5EariP36ZT9q7MLQTa4NiyT6gezNObGGT7JxfdGXYtikQk6
HtrCEYcpat6NE6DrckE4wpWXS97K5cJ6NbuWOWMFrolya/8VPSlxFXLsrjCoxwgZ
BMyfAHQmH8fmbNlfuXsVNWo2FGPRYMX6wu7QsIihT1doevW0OrBzfO49AKmr5XgN
0glE0LhV1W+aEdncchdoM/YrOmmf2A==
=H5pX
-----END PGP SIGNATURE-----

--Sig_/SJ5Ar.X+KG+Rir3FemKw+Le--
