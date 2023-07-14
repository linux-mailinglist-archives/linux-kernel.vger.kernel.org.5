Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43200752E63
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjGNBA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjGNBA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:00:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105C7211E;
        Thu, 13 Jul 2023 18:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689296453;
        bh=204eKKkvfxOud8alsz+lSTcyJXkBUvOZrJuqGNPMbd8=;
        h=Date:From:To:Cc:Subject:From;
        b=XZigd6RguT96WOlw1BL78n2uk2dgc7VLJCx1fqR/T/BZurKyvwcdQdpbZogJ490h6
         WDyLmB5YTkIi1ZD6qfYnarc8GaQSEIEhVt72pRY5hlh71N9Cu8wh0YUhJIyjYvu0jG
         gg4vxl8uMSJ9+UfIB0v2RktyMRSia2xWGrNFPE7nmCR9t39eL24QD0n8BPL54X8b0D
         qB+Hwo2JEnUAQjot3MZHWkCKOhxhBu89edkxYIT5bQhrhm7r3fR52pc0IAiD8sL1/8
         /trPuhpZVSFGfa6SzEX/00Fm5/8j9f+CT5z7KfW57KbHqqQT+qF8edXrD/ECcFyHiW
         PRIYnkZVDo56w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R2CpD710bz4wxx;
        Fri, 14 Jul 2023 11:00:52 +1000 (AEST)
Date:   Fri, 14 Jul 2023 11:00:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20230714110051.4575ffbe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bdr70Kux8x+bGrnEXC18N+8";
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

--Sig_/Bdr70Kux8x+bGrnEXC18N+8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from drivers/thermal/tegra/soctherm.c:36:
drivers/thermal/tegra/../thermal_core.h:18:2: error: #warning This header c=
an only be included by the thermal core code [-Werror-cpp]
   18 | #warning This header can only be included by the thermal core code
      |  ^~~~~~~

Introduced by commit

  bc1bb350b534 ("thermal/core: Hardening the self-encapsulation")

I have used the pm tree from next-20230713 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Bdr70Kux8x+bGrnEXC18N+8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSwnkMACgkQAVBC80lX
0GyiwQgApUANSf11j+EXDtiyZv3eCZYbhZLaaN8K2Sa5vJ4uDIhRvOaRBJBT2Avt
DTfAAMQIBkWL6LKAAP+xtz+SyPeYGnAwz+4kxMyeEWGVJcSX9CnWxYIVW13lDrsZ
acKd740RNbAdHCgzNetWlB4u5eeyvj721sQaxptpcGNE5oHDRhYqFvv0eNUaE39Y
ierDrSp11pbtZdU9eG4pXrak+dVT3/sVH1YbQTyq3BLUzIjE6HMj1aGYY8M/m1BP
I7MJEK/13DR+ayRT5fD/hrmc1nnU5SQjdVGWVgO3xV4L2icxheOndshQeL3K43fT
dV0sZClfxKIW2Sd77qCsUAoLPzXWxw==
=jO06
-----END PGP SIGNATURE-----

--Sig_/Bdr70Kux8x+bGrnEXC18N+8--
