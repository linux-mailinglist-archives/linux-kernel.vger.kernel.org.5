Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D117FCC76
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjK2B6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2B6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:58:23 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C810E2;
        Tue, 28 Nov 2023 17:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701223107;
        bh=KTkRAxQEjyPl5jlXQA3vSJp+2tyKvgM6H5lB1U5MB1s=;
        h=Date:From:To:Cc:Subject:From;
        b=Ez2eEtX2z0QWAPcG0tIu676o5KeoreIHy+fbWPGfoSFV0T02Byib5Rp+/jBhvlW++
         +h+8bXlKLJ3edK2NcgeEnr3XKaDVaH7d0mB54fEKLXpQDq9GOzoorUjX9J8AaCs3Y2
         DvWe8JjZ7aFYgwmg4TatuDG5pcCo1QBUJDPSOtpZqtiCrOMRPz9R/9woRXYMd1LZGD
         EiNufjivHrVVWk8QlPR372rIcpFs+jFA8nH4ThIMIaomDivKXrOYD9tCt8QxlhS8Ex
         oomJubsSh2v5uE0mznJtqD27NKU1PFqguyp1vTJxwuIsPFhNSeQlAxI9nciSY4udBn
         99bdGWZ72xXUQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sg2Xz1NYnz4wx5;
        Wed, 29 Nov 2023 12:58:27 +1100 (AEDT)
Date:   Wed, 29 Nov 2023 12:58:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the pwm tree
Message-ID: <20231129125826.08d7d178@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9l/B7hyCt9u=elJ63TYlxsy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9l/B7hyCt9u=elJ63TYlxsy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pwm tree, today's linux-next build (htmldocs) produced
this warning:

include/linux/pwm.h:304: warning: Function parameter or member 'id' not des=
cribed in 'pwm_chip'

Introduced by commit

  c572f3b9c8b7 ("pwm: Replace PWM chip unique base by unique ID")

--=20
Cheers,
Stephen Rothwell

--Sig_/9l/B7hyCt9u=elJ63TYlxsy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVmmsIACgkQAVBC80lX
0GxHIwf/fVBbAvvYCncIufkKbQFacKc6xyIgd05waO3RuEFiKP1p6RkLJIAnA+SX
BHvhd3FQp3akwVxw1pX4uk/e1Q/AmxFADDoJyD1qLiGJoPePKOs0Un8neGwmnbiA
LMLuIcDnQBOfCfXKTNWPUiFMQU4Ys8kQAYNuGUAvJAA3NTlKVTRPULI03lh+RFHG
ZkjgCo3p/EAYEbd2xRmjV5Xazw8BwYmKLx1uVSlzOpZ9TatwSNtkeD9pU6d2qCkz
gcumrLp+U30UkBeYOcsHLyDRj9OfCSlwaUpnJRGKItIygXdbMprokTrV1ARsDJU2
QVrdOXFAf+TxHj2/ksJTKVd+qpn2FQ==
=8f+g
-----END PGP SIGNATURE-----

--Sig_/9l/B7hyCt9u=elJ63TYlxsy--
