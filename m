Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69B7A3FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbjIRDPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238769AbjIRDPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:15:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF64DB;
        Sun, 17 Sep 2023 20:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695006924;
        bh=Kk50pYcLTlngGrdL0h16hr1fAf7+mrFbwW9o2c1D6Gk=;
        h=Date:From:To:Cc:Subject:From;
        b=F58GNttAB5zYcVqjz6feGTHuDCiKOa1eRymqoCKFIB6Vtm+RzR/+zhYhh/V2cJn+J
         0z1XqJQldtz73px1rycZ1P0HYGHzwAVTYb5JWZCiOpFz1zAojQMmm1X8ZBg5snm5WY
         bmvZpF78/Ye3YRF64/C2ezWlo3JwgS1MTtprYdiisNV4a3eK7GteYMu+6iSbnNI1iz
         kRpm7AjNxOG09c4vAB93A5vN4O9t/notgkezXp5MSpolRq8aHknVBRucBNJTGpvPtY
         UgxVl9Qct15rq+AS8zLEl9zCBU63HmSJm7UVKv4Vw4dOg1nlaKQdfNieanhiv/B+5l
         hkqCoNfFcaWPQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rpqfz2yPMz4x3j;
        Mon, 18 Sep 2023 13:15:22 +1000 (AEST)
Date:   Mon, 18 Sep 2023 13:15:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>
Cc:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the net-next tree
Message-ID: <20230918131521.155e9e63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oJybR7iLzfRy+h7=4M4CEBz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oJybR7iLzfRy+h7=4M4CEBz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (htmldocs)
produced these warnings:

Documentation/driver-api/dpll.rst:427: ERROR: Error in "code-block" directi=
ve:
maximum 1 argument(s) allowed, 18 supplied.

.. code-block:: c
        static const struct dpll_device_ops dpll_ops =3D {
                .lock_status_get =3D ptp_ocp_dpll_lock_status_get,
                .mode_get =3D ptp_ocp_dpll_mode_get,
                .mode_supported =3D ptp_ocp_dpll_mode_supported,
        };

        static const struct dpll_pin_ops dpll_pins_ops =3D {
                .frequency_get =3D ptp_ocp_dpll_frequency_get,
                .frequency_set =3D ptp_ocp_dpll_frequency_set,
                .direction_get =3D ptp_ocp_dpll_direction_get,
                .direction_set =3D ptp_ocp_dpll_direction_set,
                .state_on_dpll_get =3D ptp_ocp_dpll_state_get,
        };
Documentation/driver-api/dpll.rst:444: ERROR: Error in "code-block" directi=
ve:
maximum 1 argument(s) allowed, 21 supplied.

.. code-block:: c
        clkid =3D pci_get_dsn(pdev);
        bp->dpll =3D dpll_device_get(clkid, 0, THIS_MODULE);
        if (IS_ERR(bp->dpll)) {
                err =3D PTR_ERR(bp->dpll);
                dev_err(&pdev->dev, "dpll_device_alloc failed\n");
                goto out;
        }

        err =3D dpll_device_register(bp->dpll, DPLL_TYPE_PPS, &dpll_ops, bp=
);
        if (err)
                goto out;

        for (i =3D 0; i < OCP_SMA_NUM; i++) {
                bp->sma[i].dpll_pin =3D dpll_pin_get(clkid, i, THIS_MODULE,=
 &bp->sma[i].dpll_prop);
                if (IS_ERR(bp->sma[i].dpll_pin)) {
                        err =3D PTR_ERR(bp->dpll);
                        goto out_dpll;
                }

                err =3D dpll_pin_register(bp->dpll, bp->sma[i].dpll_pin, &d=
pll_pins_ops,
                                        &bp->sma[i]);
                if (err) {
                        dpll_pin_put(bp->sma[i].dpll_pin);
                        goto out_dpll;
                }
        }
Documentation/driver-api/dpll.rst:474: ERROR: Error in "code-block" directi=
ve:
maximum 1 argument(s) allowed, 12 supplied.

.. code-block:: c
        while (i) {
                --i;
                dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pi=
ns_ops, &bp->sma[i]);
                dpll_pin_put(bp->sma[i].dpll_pin);
        }
        dpll_device_put(bp->dpll);


Introduced by commit

  dbb291f19393 ("dpll: documentation on DPLL subsystem interface")

--=20
Cheers,
Stephen Rothwell

--Sig_/oJybR7iLzfRy+h7=4M4CEBz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUHwMkACgkQAVBC80lX
0Gz4nQgAnH/pfGUbQTwpsidwENNf+2C3XY5xqeRAY+bSeWGRBqGT9kMEP1wx5E70
rqIIF0vA6jZ56ohiY82jH2hLPQqOUw+lSJSPsufxjNogGw5xM9eDMIrCpFpqKqID
bmAzx7sgyfMsqLXZaR6tHm/QQDiQ52dAyr508J16pKH7HLLdlZZXL9DA/tp0KETS
qnv68HDcWHCGv8I+2Ifv6SUfSFPMZVOND0M0gyxGaD0kLwnJhVWYiP2LC8PoUHH+
a5Rtz29p000UQk29MjR0vRzbPvyX3dpPEc370Gw0x1Ecptkvy4fHH2RlvQfWQVLF
tmpF8/fTzKQsWIrvEPLq6iXWLMsRoQ==
=Z1pU
-----END PGP SIGNATURE-----

--Sig_/oJybR7iLzfRy+h7=4M4CEBz--
