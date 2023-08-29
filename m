Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720278BD81
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjH2EU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjH2EUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:20:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65EC10E;
        Mon, 28 Aug 2023 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693282845;
        bh=LCTwsLZO/y9qXqqJiawbsMLmw2FhrAQ1ReUUz+MpY78=;
        h=Date:From:To:Cc:Subject:From;
        b=GrZFCm9XjjKYh/fR3sKAQal7sQ/+NIpfE4QPChSvNaxQ73qZPS+btAR1TmItLxP5P
         BYht1sSbLjjY+vBFF0Cr3RWF/puJx7GCNJtD83JINLHqmq8cvv/GlRSm6S90R7Zqez
         yFeePIJvTdjpHZPyX/+QB3gCibYBOyQE0kX5p/GpLJt59IWv/vbP7Y+uDPIZkD0alV
         XYaiXJu3Ug+l5PKRz28d1McV+BDIlNkKK1jcO77WAriEmf60jbMX3GtMHhq/uaoALt
         8sHQBdgyXr3owyqfUxyhCNOY56v50vEwvLY/CIbSoqwz6FW0txiGrSbQIsoXQdW8iM
         yRMJKplgSHbWQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RZZ3d3Gg4z4wy0;
        Tue, 29 Aug 2023 14:20:44 +1000 (AEST)
Date:   Tue, 29 Aug 2023 14:20:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>
Cc:     Donald Hunter <donald.hunter@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20230829142043.02a8416a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XAX+jcOo1g04j+hU4K6pv9E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XAX+jcOo1g04j+hU4K6pv9E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/userspace-api/netlink/netlink-raw.rst:14: WARNING: undefined =
label: 'classic_netlink'

Introduced by commit

  2db8abf0b455 ("doc/netlink: Document the netlink-raw schema extensions")

--=20
Cheers,
Stephen Rothwell

--Sig_/XAX+jcOo1g04j+hU4K6pv9E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTtchsACgkQAVBC80lX
0GzX5wf/ay9V4mN/wHWjhMnplOJf8UTF3CJ11glffrJuCeR0yEuRyxJkxV3S00AX
Rz1vuVUJPwecZICfyPGLQmOU3zgey2973j2FpK18qbWw1M6Zrxx6KKK1QFVVvphz
q7mH69JWWS2UKfJJVAbWpjeFB3qwbLN76p6H/8wTkHjBK1QXdO1SJ+ogPjZboO1L
TWcMYKMmSerjqU+8RJgoDbzVpFJdiDUM0/ixJ4RdHPtdzuR+yvPBT0UzFvYVOhKa
1omg1h3BVpPdaIKCk5ohBmgdX1m9dYmIL92xKw2SLI5tkODT52EfP8t7iZJ+v44H
7huSuUz4xw1g85YLYHOV5woR/aK6ig==
=0ITU
-----END PGP SIGNATURE-----

--Sig_/XAX+jcOo1g04j+hU4K6pv9E--
