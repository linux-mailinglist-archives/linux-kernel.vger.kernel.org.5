Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA60B79C633
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjILFNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjILFNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:13:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212BE5A;
        Mon, 11 Sep 2023 22:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694495587;
        bh=HfiZAz+w66EKMAZj2PZeFB26LwsjBHKhBlPSW4GHYJo=;
        h=Date:From:To:Cc:Subject:From;
        b=Z7MWMTGO1utR7qSZPh+Oc/c29u0uzy66l4813nnYH35S9aDx1mc1ZdGefXzG3LtB8
         9nQ/Hu45SqBAxhmzpHaqLeoe65AYXSUuq69m9QGq3zKbChqV2Ljh06p3xGoBitDQkB
         aXpAHerfhw03XdYW4llkYF0e0MQRz6jvSZ6p9+KVHWSc/Lm9yRaDL/AXX2+yDys8z2
         LrYzRlfiPuzJbmIIN2dCsXtzHqee3KZovIoK7eaTtbQaHGUmIvH74sXOUQvyXFNCFE
         wQCS5ss1WhOSgaI25JrrKWLlihAFhYKR2S/u0/XZ9Uzp5XL0ljKr2jQqsMGITgnn7h
         JkBTtfpnZF11w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlBYb09nJz4wxQ;
        Tue, 12 Sep 2023 15:13:06 +1000 (AEST)
Date:   Tue, 12 Sep 2023 15:13:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless tree
Message-ID: <20230912151306.51ee11ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9w2Asq+r+R6SZqQn.btwC=z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9w2Asq+r+R6SZqQn.btwC=z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:6134: warning: Function parameter or member 'cqm_rss=
i_work' not described in 'wireless_dev'

Introduced by commit

  37c20b2effe9 ("wifi: cfg80211: fix cqm_config access race")

--=20
Cheers,
Stephen Rothwell

--Sig_/9w2Asq+r+R6SZqQn.btwC=z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/82IACgkQAVBC80lX
0GyxRAf/YmPvXZYQ/Mg9AlKop5rNle6grhU2XhZ8l7PXZS96WcnMpd2AVXVm2E+T
mT70/SIr8C3M0MfTaZo2OHAWXeNGw3iOktu8en5rqWHDGinCw2mdJvM3S8BfMb43
RQwLEmOPAq3brgAtRNhzgOHdJrP268VvBjeHv+Xb53+BvQQC09c3h5FFwGB1JgFG
pFOLwNLyvbF6wCKkTFy16ma1ntcgDVGHwwq+EvcDYdDhCHPo+rTjyzdWQX6N2INO
UsMmGCtyT0qcDQZyC+ilqoht18Yn+yUEe9SxIXt/v2GKme5o6e4AAYGF4cqN50sZ
wJCZ4suMsNbFRFcwTrvwwE4OwIcilA==
=zm0O
-----END PGP SIGNATURE-----

--Sig_/9w2Asq+r+R6SZqQn.btwC=z--
