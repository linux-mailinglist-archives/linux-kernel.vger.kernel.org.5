Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5C87512CE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjGLV7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGLV7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:59:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D51FCC;
        Wed, 12 Jul 2023 14:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689199155;
        bh=EmdN9jzbnWt6IczW9ctyLJW03/xKF9yTDLV//giOgPo=;
        h=Date:From:To:Cc:Subject:From;
        b=bXt9fcWZHXVqDV1eDLHM34wdxoMDBJmV7gPrlWE/jajEDjIdSl73VVUWMDcDpiW6o
         eXaVbsjuD1RJv840OlLg701jfaPSbrW/jd46wsu2Zwa+MTx706jpAC/vcmAsvfbUyL
         g/QV6z0RRD2TfpYjdsOAuGgCrfQLXryRck2H0RqdqpvxhCzF0Cbes3iGf5ZepSGb3k
         qL7u7mjCtqAnCrodeDXL2rvrstl25YEjs0rppJiHMV7ytXKKLj3MhV7G9h2V7zLyhW
         HZ2LZhZGmHn6xhXGnxulKxWwRj9OdatTnRPrdLDgVkRhKqLsAEvSJZxkjt9uoB8J91
         Bcvz/FCOI39Yg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R1Wq731gXz4wb8;
        Thu, 13 Jul 2023 07:59:15 +1000 (AEST)
Date:   Thu, 13 Jul 2023 07:59:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the soundwire-fixes tree
Message-ID: <20230713075901.758e1b65@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/q_vexaMkvmVF4ZOdaFLB5Jg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/q_vexaMkvmVF4ZOdaFLB5Jg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bfb4da9c536e ("soundwire: amd: Fix a check for errors in probe()")

Fixes tag

  Fixes: a673a8dfc214 ("soundwire: amd: Add support for AMD Manager driver")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/q_vexaMkvmVF4ZOdaFLB5Jg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmSvIiUACgkQAVBC80lX
0GxG3QgAnx6JeZIFvbhNTlQi4O3udPpSCm2jFVgJ83G/hGSNgq6iYaHtu0/O/4d4
i4w2wxZH2HiZTfnuw0qtEScI7Bx0OkrHPn7w7EJvb2/DHewdpweOrPO326NvHeuz
9IvZYiPjiOftcmQRrTUwfZsXqAxjE5AnUjLEwj8Zn3fs58EuDXeIYR9k/Z6mMT+G
6BbEDoGqBDSijxtWk0loyCztctBTPwAW2O3kT98/SbHLjyxwUnNNPWL7+X3Cu+N4
8z32qvOHKWJ411fC6ZTKftTakBYSHZ2C66/GQFc0Ega1kgdPxhIiDcMK6YY9uP3K
clBFNcJwiU07meaEVEsd5qPFTih25A==
=PdzM
-----END PGP SIGNATURE-----

--Sig_/q_vexaMkvmVF4ZOdaFLB5Jg--
