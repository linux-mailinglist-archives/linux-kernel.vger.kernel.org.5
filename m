Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A0760351
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGXXuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGXXuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:50:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B861712;
        Mon, 24 Jul 2023 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690242649;
        bh=ewqqy/E3varcIRH9ZMMDvwqrstLYQS6pqj/BI3HcUSo=;
        h=Date:From:To:Cc:Subject:From;
        b=Fhk73u1yfHrJT/X6cAXX/8yJs7ApC1geIoNL4veZUIzcaKUMxmd/ZcSDwlndPc/YI
         NZJUCdqE0KQpT+Mvi7sLwtnJxieHsm6oasoH2Z+mDitbT5QGIGldTLZcXZFAy0MWzv
         wTYeu01nJEKciG9azKPVeVLJMZD3SjbiaByfsMFtXdLDejlGcxFNPJch9pEgTv1SHH
         +nrutyDA+44wBYOmlijYPEnZ12SNQ9LwJMcIls6EnUGl2MEoKXze/IuUODdxJREGnB
         eRQ1ZPmTsFHf7MFxew/vc2vEGJ/hsGlzvqO2Cp50eylEhBJJin71BUN8eCT9krGYN9
         pOU9B9lQkKIJg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8xkK3LN9z4wbP;
        Tue, 25 Jul 2023 09:50:49 +1000 (AEST)
Date:   Tue, 25 Jul 2023 09:50:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20230725095048.0a5ae656@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/olOUUSWx8F2ZAWjT8pz3Hyb";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/olOUUSWx8F2ZAWjT8pz3Hyb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

x86_64-linux-gnu-ld: vmlinux.o: in function `owl_sps_set_power':
owl-sps.c:(.text+0x16e259d): undefined reference to `owl_sps_set_pg'

Caused by commit

  930c9005ed9f ("soc: actions: Move power-domain driver to the genpd dir")

I have used the arm-soc tree from next-20230724 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/olOUUSWx8F2ZAWjT8pz3Hyb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS/DlgACgkQAVBC80lX
0GxM6wf/WAJ0l/ANlRZN6iNwWdv8I7g+B9qGTt5yxQEZ1TnsGMr6mTrCU0l9/zkF
zEa/ndyshhJSVKJkmVxvNCrXqT7G62rBZPRKqlXIrtIVUoTcEyQi2x+p/aiQSoUP
JSX3gGDePvxwLqk9kzpDGeQ98Z+KpHM5dGnsjARvRZoyqPc3Qd9mL+y+aJyCmu15
/lE94GI7wcjLKkfkscKDKyAHCZEnZY33GGKiSLvSicPRB5bj3wa0dixxx5TWF5QG
b8TWRas2swUIkkfkyU+8SU774dHl38K8q85crFLx0Li5otPjNOaog1newR09OIEq
RvJSsm+HQrCEFhcwhKItjWsTRrbLuw==
=5KwZ
-----END PGP SIGNATURE-----

--Sig_/olOUUSWx8F2ZAWjT8pz3Hyb--
