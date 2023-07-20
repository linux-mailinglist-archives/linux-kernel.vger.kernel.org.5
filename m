Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9681075A47D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGTCqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTCqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:46:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666242107;
        Wed, 19 Jul 2023 19:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689821173;
        bh=KLt45UftaDK5xXeUexcCo/cM0mNO1qMvkAGi3RBfN2U=;
        h=Date:From:To:Cc:Subject:From;
        b=WyhkCo3yS8twb5+PqD3d5sxIBNFh+EXEPIeN5lxAErOGw0NJpaNf1bAoaE33hgGgi
         pF5TAw1UW4lX8/vDUMiabvAci51azMG1eoQPuaCuVDeNCt/zENjcJXEKDK075vVesG
         KRlf+6HwQ3R7l8BO0saMIG9IAX0JXz9SZeqsVPcsHKbeD08AcfAlCHYF2H8GW+FcA6
         kT+lgwQ2aVVs7ONhNrhCRBGDXoXQ2CdzduxDBFQNt4RVlb/X22mm8pDg0eQhXqHK5V
         IlQD9r1C5hU7O+lNJukSYlfFrvnfooRRdbAOArkNietk8uZH+XrJRmOlQLKGyQLNCr
         ZTKajXFilBXBw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5xs06Dmxz4wy7;
        Thu, 20 Jul 2023 12:46:12 +1000 (AEST)
Date:   Thu, 20 Jul 2023 12:46:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Benson Leung <bleung@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Barnes <robbarnes@google.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the chrome-platform tree
Message-ID: <20230720124611.45b25256@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OJvLbQ1zF7KRrGSzvHnDbl1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OJvLbQ1zF7KRrGSzvHnDbl1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the chrome-platform tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "emergency_sync" [drivers/platform/chrome/cros_ec_lpcs.ko] =
undefined!

Caused by commit

  a6edd5f5d9cc ("platform/chrome: cros_ec_lpc: Emergency sync filesystem on=
 EC panic")

I have used the chrome-platform tree from next-20230719 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/OJvLbQ1zF7KRrGSzvHnDbl1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4n/MACgkQAVBC80lX
0Gyrawf+JRvRu8eIfRxmYgv9l53kN0k1dmqDRmhmUl8rmAGDeZLFfOazJmUXEuF/
W2fw8ykXlpnZgTFqFHEnUtYSrODxJ/gs3UpawM/OCV6lgG0wLFkP43GenEXlpOi5
t4yghw2tgP/+d899wygOgKbp09Wn39YRYOGfkNxckr0LU/7JOhdLEPxxh3pxcFkp
c3Lj+Ka9RfF2dDToK9rJpbKhkXxzFlbx/FHIn2Lz3BGnT0zVfIxHnnzBKrkQpAwI
9aVLQeBdj1BIDga/M6zFFgwVK56EJ8l1Ku8HFIlNUoBz4/7dgDZSAPfDRFR/EHNx
jGr7gDipRhJWvPaYDKNgR8Pq2feU4A==
=tL48
-----END PGP SIGNATURE-----

--Sig_/OJvLbQ1zF7KRrGSzvHnDbl1--
