Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3143A7805BE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 07:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357508AbjHRFkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 01:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357976AbjHRFks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 01:40:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452F326AD;
        Thu, 17 Aug 2023 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692337245;
        bh=IZ4ALpwGSUwvfluVCVwFYoSU51B/kQ1CHixWYtppBu0=;
        h=Date:From:To:Cc:Subject:From;
        b=lXbMPisJ3IRqNInEodOy2C/zzv1lUoRRJWjPSqFLVf0f4E4fW0iHe0N68oU/urxR4
         Qn9hc+spBovX3gXcxEt8RijMMRvXnGb2m0H3m1BMXOraRLvtH+dUPSX3mTH9z2qMEl
         I75IGMoJrnjfw6vy/K7zjPQ+firCBU2je7PScYt4DeJ3+UcSSH0Qjp9ppdKNPSjFOd
         C5cer/laFYs+A6itFPH1yi84WizTQdtb5ABbNhSmocOItcQC/98zewUTuNi3MTSNB9
         heU2SAnRqWW5AbiS34ZIuhPwoXO+2iKr+MYEXeg+dSzIM9/H3NPtVdzZYCVA6SNIL4
         X9Ii+I3mqH8RA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRrM13qPxz4wxm;
        Fri, 18 Aug 2023 15:40:45 +1000 (AEST)
Date:   Fri, 18 Aug 2023 15:40:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the phy-next tree
Message-ID: <20230818154044.33b443a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/T_4W.DiZ+oWmr52VkM0iFMD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/T_4W.DiZ+oWmr52VkM0iFMD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the phy-next tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/phy/qualcomm/phy-qcom-qmp-pcie.c:2378:38: error: redefinition of 'q=
mp_pcie_offsets_v5_20'
 2378 | static const struct qmp_pcie_offsets qmp_pcie_offsets_v5_20 =3D {
      |                                      ^~~~~~~~~~~~~~~~~~~~~~
drivers/phy/qualcomm/phy-qcom-qmp-pcie.c:2357:38: note: previous definition=
 of 'qmp_pcie_offsets_v5_20' with type 'const struct qmp_pcie_offsets'
 2357 | static const struct qmp_pcie_offsets qmp_pcie_offsets_v5_20 =3D {
      |                                      ^~~~~~~~~~~~~~~~~~~~~~

Caused by commits

  a05b6d5135ec ("phy: qcom-qmp-pcie: add support for sa8775p")
  64adc0bf06ad ("phy: qcom-qmp-pcie: populate offsets configuration")

I have used the phy-next tree from next-20230817 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/T_4W.DiZ+oWmr52VkM0iFMD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTfBFwACgkQAVBC80lX
0GxxaAf/QrwjYk+Ir8kI9GWtWZX8jGRcdtu6EcahSyKNiQJrpGri9qcWrI25gnJO
Q4fiuZ0ks49aUIIBcm4eFieLIxY1q13Woky1BpRTVX9nU8flJQRK8wEymGd2K+F9
z5gT9BmX4uPyzHduKFFgfbbDCnZxiPIwXbIM5j9zjBsXMLX3BoE4jntbh8lPsb72
+ZctfIDg8ggsTvW8ui6ZNNVaEgq011ZZV8aVAfqEPiofxFbF/sr5rdcmOQ1bhgL7
keqWVJ6oo735QqejElAJq+Vgd/ww0zb65s2/c+yCOf8XFd6rHZAUPcth4z8p41lz
IQDrq0kiPoU2Vs+nXU2BFtZ2cH4PFw==
=WAlO
-----END PGP SIGNATURE-----

--Sig_/T_4W.DiZ+oWmr52VkM0iFMD--
