Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673857817AE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 08:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245508AbjHSGbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 02:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245090AbjHSGau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 02:30:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4122711
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 23:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1692426644;
        bh=1NjeSLQdeMsoj1eyDCSseNAPyJoFa4K6nn0or+ADByE=;
        h=From:To:Cc:Subject:Date:From;
        b=h2Blb2+QXoUcOt4Uuamm4WdcU+4D2bh+c3BtsVlPgNCo/9HrQoGYp4OdSp25Z6tK+
         Z1q/KSz+WaMXScwHLX/Hc/lyxb5pHdYdzE7lae4jukNKSwic2bqVM85ZsqIWtKclSx
         m5HAi4PXgaBEC9AFn/E94xdbRBRX3S4WOE0gf2SI4U9TeIuR4sUMTv+Ss7i0XnFeHJ
         3+DJ1fLoBDAbluJ84v9C335h4gj4j0Jairbu2kCfJmzy0/JNZUvde6Qsaj2SrY1/wK
         t74mBW9jWoHlDsBo3wJVm0nkzjWLPx2Gnndtj13dbqYpmAdzZT4DtGghGSmO3oyx3S
         OzoXVdeagn1/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RSTQD0bwCz4wb0;
        Sat, 19 Aug 2023 16:30:44 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathanl@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-6 tag
Date:   Sat, 19 Aug 2023 16:30:39 +1000
Message-ID: <87350fwnlc.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull another powerpc fix for 6.5:

The following changes since commit 86582e6189dd8f9f52c25d46c70fe5d111da6345:

  powerpc/powermac: Use early_* IO variants in via_calibrate_decr() (2023-08-02 22:57:22 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-6

for you to fetch changes up to 4f3175979e62de3b929bfa54a0db4b87d36257a7:

  powerpc/rtas_flash: allow user copy to flash block cache objects (2023-08-17 09:46:14 +1000)

- ------------------------------------------------------------------
powerpc fixes for 6.5 #6

 - Fix hardened usercopy BUG when using /proc based firmware update interface.

Thanks to: Nathan Lynch, Kees Cook.

- ------------------------------------------------------------------
Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects


 arch/powerpc/kernel/rtas_flash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmTgYVoACgkQUevqPMjh
pYCzLg//VBXyEY+oJw4Oo4WVWTAlfCTFMOm2LmF8WodgbupH/x2CUYtSENdIBpIc
Qx1gTLrxfm+MMl95itp2qJLXszTenWTKWw66oSTtcJeN44K//jWznXeQn2eCpXx2
dJuuiXX13TKb/i6IOjrhEYTAjfJgS3eU8bCrAhjXMc4l6Jcczox199t1uskpUpAV
l+J3n+tYT+1tOIMLKDp6Awc3U0sS/bvbEV6CQoTe7a5R6QzSiG+fKY5fowuO2von
rwsSpHujmBsZviitAOPLEhMT+NEuH2iBwKRQjR2NXAGujV5wqoHsOh11vjs/tsKw
oSdqmYcwOuvNKpud1V8yXDZjXvzcZJxtYNdOIg89IRN0MC/AeN6NfNc5m2z8duNU
DpGAi2F/v76uqICr2XXxMEbCd7Rz9GBsSOtFPfyUeE01r7c73OaRw92d9MWM/Jcf
DeVwVVm1XD3dMw7LY4e/OJTuBhXUSwMx5scexL49TBKQ7fIKc/+YdI/oMNoDXYGO
iubNpjZ/N05Yasj3teIIwGo4dA3kt58zfl8STj/EWisMDs8AARHpWwE65h96GsS5
xR4eQ9yUpk5F1eUozvKZDJgVDs97jF1bXuKtUhcKRZf6ZoFlqRozkmpxD2aO4qEu
e2vR3vKkciN4M5w7BuyMRWY3nc3l9F86DbQymLBQ4HkLHL2jWdw=
=pTpH
-----END PGP SIGNATURE-----
