Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B87AE1BB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjIYWfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYWfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:35:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8056C9C;
        Mon, 25 Sep 2023 15:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695681304;
        bh=db0Kj0KWi2yzXIrxR7OyuKUBHapZmkNCu6E7HfARs0c=;
        h=Date:From:To:Cc:Subject:From;
        b=tYqZjabo+PinucRfeh96FQMmXP7A7wIrCwCfJJtEm6Y6jNpOMbem8IwnO7p4saKzC
         rKAYdFBucytypoRh8J6eXUdj9T9ozTUnKoju95+usyfisEPQbfpELubuWLev/l3eVd
         b8wPl/ukSOQcmQNLddK4uaNl4Z+UxmObKzGbJ/W83t3ZuSWflR4hpQpFwBzK2GdMkM
         QmFBvrXaynNzoHg1Lq2lLRuscXVnf29j9tjB6G19TZ3HRq0nwF7vF4KNdpPNvGGDhV
         zlQw9a+e4SMP/CUNChve7l7BdZtmZ+jrAYeWDwGI7bMNoAhKof/Ix3jbFZ8gUXeJZO
         tC3WyLG4M+eSQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rvd3r3DNhz4xPM;
        Tue, 26 Sep 2023 08:35:04 +1000 (AEST)
Date:   Tue, 26 Sep 2023 08:34:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the nvmem tree
Message-ID: <20230926083446.1c3d9914@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/v42/i6=4VbzPEwmiy1Bd0qP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v42/i6=4VbzPEwmiy1Bd0qP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0991afbe4b18 ("nvmem: core: Notify when a new layout is registered")
  b8257f61b4dd ("nvmem: core: Do not open-code existing functions")
  6c7f48ea2e66 ("nvmem: core: Return NULL when no nvmem layout is found")
  104af6a5b199 ("nvmem: core: Create all cells before adding the nvmem devi=
ce")
  c32f2186acc9 ("nvmem: u-boot-env:: Replace zero-length array with DECLARE=
_FLEX_ARRAY() helper")
  0a9ec38c47c1 ("nvmem: sec-qfprom: Add Qualcomm secure QFPROM support")
  050cd7f49580 ("dt-bindings: nvmem: sec-qfprom: Add bindings for secure qf=
prom")
  4b71b2a44d7d ("dt-bindings: nvmem: Add compatible for QCM2290")
  9d53d595f688 ("nvmem: Kconfig: Fix typo "drive" -> "driver"")
  3e0558db94db ("nvmem: Explicitly include correct DT includes")
  c8efcf7a86eb ("nvmem: add new NXP QorIQ eFuse driver")
  0401edffa338 ("dt-bindings: nvmem: Add t1023-sfp efuse support")
  8fd85ce6cfdf ("dt-bindings: nvmem: qfprom: Add compatible for MSM8226")
  97edd4c6ba34 ("nvmem: uniphier: Use devm_platform_get_and_ioremap_resourc=
e()")
  431f08ed0ba5 ("nvmem: qfprom: do some cleanup")
  77803ef86379 ("nvmem: stm32-romem: Use devm_platform_get_and_ioremap_reso=
urce()")
  e75d23cf347d ("nvmem: rockchip-efuse: Use devm_platform_get_and_ioremap_r=
esource()")
  ad065ae27bd1 ("nvmem: meson-mx-efuse: Convert to devm_platform_ioremap_re=
source()")
  67f919120705 ("nvmem: lpc18xx_otp: Convert to devm_platform_ioremap_resou=
rce()
")
  5f41033e4154 ("nvmem: brcm_nvram: Use devm_platform_get_and_ioremap_resou=
rce()")
  6870b4a37343 ("nvmem: sunxi_sid: Convert to devm_platform_ioremap_resourc=
e()")
  31c8217bc34a ("dt-bindings: nvmem: fixed-cell: add compatible for MAC cel=
ls")

--=20
Cheers,
Stephen Rothwell

--Sig_/v42/i6=4VbzPEwmiy1Bd0qP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSCwYACgkQAVBC80lX
0GyOEAf+Kj6FuVuipf1+R3SwOQ4k/Cwr/3PsrSJye1xOLHvgb8G7S0lYlASt4CVt
yVl62F62H7WZPOCNRJ51vMy16EHrx7LQmJ1nv3JLmfBwuHQguhNkqoBjoBt+pNPV
k6FetO577W7Suk/dkKMW8T75pzxlU0vUhJbOUEqIr0UVI0E+4P7ZwVBLVfalA18u
i+w5a/yAgS08lBL8tLwuWRZDXm+YwR/0srREEL0rI/OJdi0kXyWv2NlmELRLZXUE
xm2w1losQ9C/VgGbYpSBPML9eAEN4RaLfAHQ0dEwxGRptolKGa1PWh8zUrEhA+sD
kOJsmbAgPCEFS4NN6VgGxYXgg9reOA==
=+emQ
-----END PGP SIGNATURE-----

--Sig_/v42/i6=4VbzPEwmiy1Bd0qP--
