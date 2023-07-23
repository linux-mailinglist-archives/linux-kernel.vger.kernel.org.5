Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3307D75E5AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjGWWxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjGWWxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 18:53:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681B9BD;
        Sun, 23 Jul 2023 15:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690152824;
        bh=9eoTPsEKrVwmbUcpYsftF554HqPSRtaD6kSP64wjhus=;
        h=Date:From:To:Cc:Subject:From;
        b=k40doDYNnulZGND9tK6Ufx0/YIOkCELpopBt+hi+gyZ5DaspTCQ3mPbn3aD1xM+aW
         F7JKsFv92A+XNbIPQWR0xh0xZXEju0uhmWHXcd+cCl2iENNvMYNlI9tz/y5ae7kfaw
         k1PyuTYzfpv5jlsTWYRTMhLC+0H2xg/uldGzAL48SsolIZpiEaYm52Xfcy1am80Ih0
         V982UrNkaW4LWa9HfDhmzZjqn9X9tRd//ZyzxdulqDZcff/kybSQ9AhAYBmTMJwIdT
         RR8a7tvx/9SVZNjw1om1b6m7BQsp5kGajAlk5jGaB/G0sxPBLZNarz/Jkih9zV/FXb
         JRpUjHVtGY47w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8JVw3FD3z4wqW;
        Mon, 24 Jul 2023 08:53:44 +1000 (AEST)
Date:   Mon, 24 Jul 2023 08:53:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20230724085343.77bdefd6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5OopSN40.LPvg.z=8gGj.Au";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5OopSN40.LPvg.z=8gGj.Au
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  981be238e1d2 ("dt-bindings: arm: msm: kpss-acc: Make the optional reg tru=
ly optional")

Fixes tag

  Fixes: 12f40018b6a9 ("dt-bindings: arm: msm: Convert kpss-acc driver Docu=
mentation to yaml")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 4260ddfb6496 ("dt-bindings: arm: msm: Convert and split kpss-acc dri=
ver Documentation to yaml")

--=20
Cheers,
Stephen Rothwell

--Sig_/5OopSN40.LPvg.z=8gGj.Au
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS9r3cACgkQAVBC80lX
0Gx7iQgAlYIVkKPo4doqdJ7bHAbfJeQxB8yiMFHRF1CdQues/CGSeZTaiJfGibqg
HjoLQnQcD8GPddeG7WrfcwBG+yHN3nGVAGBnQhm3uxjvHyfUG2aVMtW37F963WcP
Hm7/L2Vpng+qWPaJapoBPFykcY1co5ufGbV/zIdByxHg/7bfeXA2ndZL6p4BGcY5
amZKU8+oXehR4DuMWu9dJ0/WqHi8Mys+4ySkVDNByC4D/Y9kFFFiFVFYkoAsF5mE
+IXMCUhDUeU0I5hOh7YCxnOIO/VSpiYaX7ooRZcHxCc/ZukNCVjU95kXC0sOMuZR
CD/Ngulaeyg/Pf100V+wWds3A8zNfQ==
=O45k
-----END PGP SIGNATURE-----

--Sig_/5OopSN40.LPvg.z=8gGj.Au--
