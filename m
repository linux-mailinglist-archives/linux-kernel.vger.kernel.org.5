Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE57F6A98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjKXCRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXCRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:17:14 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B510D3;
        Thu, 23 Nov 2023 18:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700792238;
        bh=hVLznh1N/6w00XZWPeXHTEO2orW7OEONxjkwEONOiOQ=;
        h=Date:From:To:Cc:Subject:From;
        b=pcZOQSMQDRl/XIhLufCTaMrUfvYhta8I1mDlKR12veDD6pptND11R90w6DylFfhJ8
         KcNKFH3jAKfOiRtmDYN4INYdWL7hC6RzZohlQwMMEmUVRIkogh6KGn1ZzBByLmGhwj
         io/7eTtVbj6RAkanGS7H7EYHOMjNFbs3TArkCJZBs7mcpJXejrG8IetIY7OrV8iQnN
         xmJrVRZUKdZqvSXs/ZP6Dp3TXxj+pUkedd6WnurUj1oPvEfr9b1KwVA1IiWr7R7gNy
         Fh5RJUxCE2zYjotDUDrYVr47Vevi7EMwZ5ub9e1Y+Wot3oBHp8XRBkuc1inKUadDEf
         vNJ614CL5z4Nw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbzC15Zkrz4wx7;
        Fri, 24 Nov 2023 13:17:17 +1100 (AEDT)
Date:   Fri, 24 Nov 2023 13:17:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@redhat.com>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Donald Robson <donald.robson@imgtec.com>,
        Matt Coster <matt.coster@imgtec.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sarah Walker <sarah.walker@imgtec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm tree
Message-ID: <20231124131716.13f6ec45@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iHKHr_3h.2UX98t0oNV=g3P";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iHKHr_3h.2UX98t0oNV=g3P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/gpu/imagination/uapi.rst:124: WARNING: Title underline too sh=
ort.

CREATE_HWRT_DATASET and DESTROY_HWRT_DATASET
--------------------------------------

Introduced by commit

  815d8b0425ad ("drm/imagination: Add driver documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/iHKHr_3h.2UX98t0oNV=g3P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVgB6wACgkQAVBC80lX
0GzDKgf+IX4nKfbuqQG7jQERrxtwKtKeBdKnPIhO6UDc+IMWRbySt4rEZy3Jm/oD
Gy9/85oEQg2E4aXjpCVcYjZ5JG8iGwjWV8l21jVfomMAZg8IfVzIh+C9g9IlcsC+
KlGjgdY6R84kct8ycKyWvBU0lwNuxm6NxRhkftABxjk6IEP52a72O1vpl1bd7+i0
uWhwfcO2n3MZ3RZTwLJ0BIV+Rbdc0Ex3s2hmXTUyYsGWHTA/OySVSJNVcOJvmMEu
lSFjOjYlm4X0mbYJaINpB6ut+0+hYTF6y3ESZ+JwR8hj2T9SiyozjjkipxmNzEqc
RjXrzigw+Q0YANLzE1zXA5qpJIyyww==
=o6i3
-----END PGP SIGNATURE-----

--Sig_/iHKHr_3h.2UX98t0oNV=g3P--
