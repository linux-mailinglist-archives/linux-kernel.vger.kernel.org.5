Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831187B9F54
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjJEOVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjJEOTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:19:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F5A1FD5;
        Wed,  4 Oct 2023 20:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696478218;
        bh=Y8WYWvEKLvGitXN7cKGVj7fz0TaJkMvFxctxC2itPMw=;
        h=Date:From:To:Cc:Subject:From;
        b=fJvDsH9x6NPnQ4CS5mkRxr/jG7jFy68X7IxFQ9jqpnsPqJutwBPfhS9QsDazSbImR
         sAou1b2gLrdY9etnccEY7o2Zi63zLmKcSPD/4nwlm5mbqR3dEwdtJG49NQEzhEPy2l
         Q4jn6ctAt8KL+pe87lN419sRqaTy+PkXjrr0/zX/4DwQ0+cSt5weMNA+oc+o7tvrXz
         BaGy6mDB3zqqKCtqWj9/BukUK4nhpSuMFqxIzyrXQp/OwD/QvcWv6kRJTWdeM9vvPg
         DyEV3+LUs7J0v+rGv0piKsRxH3pdKY9TX8Av7w/ph+1oyJQPiRdpDNgt3yuTRp9uXj
         wmM9zitquD/kA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1Hn50GTKz4xVl;
        Thu,  5 Oct 2023 14:56:56 +1100 (AEDT)
Date:   Thu, 5 Oct 2023 14:56:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20231005145655.1be26501@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v.g1oC3UHeTqCPfYy_=JChq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v.g1oC3UHeTqCPfYy_=JChq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/gpu/panfrost.rst: WARNING: document isn't included in any toc=
tree

Introduced by commit

  f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")

--=20
Cheers,
Stephen Rothwell

--Sig_/v.g1oC3UHeTqCPfYy_=JChq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUeNAgACgkQAVBC80lX
0Gx+rQf/be1YeBjQboBa32eEz0zXSNs60u0GoGTX97AyaS+M4ryys17EsnNVGYTP
UOYOtiFCu+5L1OSHECcX4AFi1CTd+JRQIgcaNS+flOfpkNWwun+6Hew/c6n0Ysgb
tk7mymKqC1xyOFltFjtfiO1bW3J8kzJFRCPUX95Yolk9sL+4qezDZuQJ5nXnYCYu
mZGb2rSBWXeSCrVivR2Xdkqk/ohuGFKU0tLbD2Bxqt7zUxQuX0I1WMChqnz1J7QH
g7v4HfQ1Ty0yhdt3+MfQOx7JFKJdPKqkxtQaJ8oBgy2ZVJtrbJGsnl3/lilWfL//
rX5KXZzl9mMj0k0ZGVEcnHATpZ6Xog==
=jOvX
-----END PGP SIGNATURE-----

--Sig_/v.g1oC3UHeTqCPfYy_=JChq--
