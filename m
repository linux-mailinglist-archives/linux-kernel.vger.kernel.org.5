Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 687CB7B7671
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 04:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbjJDCAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 22:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJDCAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 22:00:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25080A7;
        Tue,  3 Oct 2023 19:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696384835;
        bh=OYwuO+L2Qg7Tzeggc39l+CyC2BYsYQ2kidiuBqWOV8Q=;
        h=Date:From:To:Cc:Subject:From;
        b=sVozHDImVZuon2+wdzT2jfr6p2eOywX3H/CZr8YiH4IsWYhY/ZI8jwlWi7G+fNVxt
         lJEfiessyjfMjCrlQyuDyiqtz9AC4IhgMPob5/3G25bT2fsRIqPFZ/DlPzjPq8V/dj
         UQmOiSdkWKKDtNx+nvj2L9KV169bW3bMR3+YVT2u6azorLX6nFPuI1ic4JOlvvUw41
         sPJ7AQUmKUSJPc+q8TFd6B/eds/CDr/VyJxJZrT5S+bAyq1asuAHh2eoo6LGl5VIHR
         ZPqD3nN1i79GxYpBP5K8q7p7LctATO1uszFUlWQeq1lsoUVPZW45GIvUv9+3w1OMuF
         SYbU43ltry5kQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S0dFH0ptjz4xQX;
        Wed,  4 Oct 2023 13:00:35 +1100 (AEDT)
Date:   Wed, 4 Oct 2023 13:00:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Greg KH <greg@kroah.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: linux-next: manual merge of the phy-next tree with the usb tree
Message-ID: <20231004130034.7b1c5b89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y3J+i5H.APdc/1GimyGA2.1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y3J+i5H.APdc/1GimyGA2.1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml

between commit:

  df55d4f814f9 ("dt-bindings: phy: qcom,qmp-usb: Add SDX75 USB3 PHY")

from the usb tree and commit:

  15c83637402c ("dt-bindings: phy: migrate QMP USB PHY bindings to qcom,sc8=
280xp-qmp-usb3-uni-phy.yaml")

from the phy-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-=
phy.yaml
index d58dd744d5d2,bbdb28cd8029..000000000000
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.=
yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.=
yaml
@@@ -20,8 -24,14 +24,15 @@@ properties
        - qcom,qcm2290-qmp-usb3-phy
        - qcom,sa8775p-qmp-usb3-uni-phy
        - qcom,sc8280xp-qmp-usb3-uni-phy
+       - qcom,sdm845-qmp-usb3-uni-phy
+       - qcom,sdx55-qmp-usb3-uni-phy
+       - qcom,sdx65-qmp-usb3-uni-phy
 +      - qcom,sdx75-qmp-usb3-uni-phy
        - qcom,sm6115-qmp-usb3-phy
+       - qcom,sm8150-qmp-usb3-uni-phy
+       - qcom,sm8250-qmp-usb3-uni-phy
+       - qcom,sm8350-qmp-usb3-uni-phy
+=20
 =20
    reg:
      maxItems: 1
@@@ -75,10 -87,17 +88,18 @@@ allOf
          compatible:
            contains:
              enum:
+               - qcom,ipq6018-qmp-usb3-phy
+               - qcom,ipq8074-qmp-usb3-phy
                - qcom,ipq9574-qmp-usb3-phy
+               - qcom,msm8996-qmp-usb3-phy
+               - qcom,msm8998-qmp-usb3-phy
+               - qcom,sdx55-qmp-usb3-uni-phy
+               - qcom,sdx65-qmp-usb3-uni-phy
 +              - qcom,sdx75-qmp-usb3-uni-phy
      then:
        properties:
+         clocks:
+           maxItems: 4
          clock-names:
            items:
              - const: aux

--Sig_/Y3J+i5H.APdc/1GimyGA2.1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUcx0IACgkQAVBC80lX
0Gw1xQgAiB3AkuboEx/mJcMqr10UKljRaa8sUUoM4ZaGk8u3+POVfkM/Fml5q4Q+
kbLksVJrjrBFHa2+faywkkH8NSRjLwFtHcMGqrd30YE5muAx5W6/QHb9Ji2bWY8W
CxohfOZA2sxVj+lR4D/2lbeGGIoIIfInDoPeBN+J0eNoKOHSHNVBsShwnuBmFExV
mul1AedhZ00oOcVfTUt/uBJykxhbYspljoOVrIDosvqD4FqNPHH8EYeQgMZw/nQz
x5XPs9ycUv6YvQyzykGSAjXW8vqvkOYTy6KQYScfnpy+sRxTYIjneYcfkc1rrg4y
PK+mfyzLkxXOuCtBzEbhUxWMRcTffg==
=ai3w
-----END PGP SIGNATURE-----

--Sig_/Y3J+i5H.APdc/1GimyGA2.1--
