Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C837B5C5F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbjJBVHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjJBVHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:07:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF08EA;
        Mon,  2 Oct 2023 14:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696280865;
        bh=95oVmibtNe89rFCe1kmkrQ54XgVNgGgAPEGkAgBRX+o=;
        h=Date:From:To:Cc:Subject:From;
        b=ewQXwSXGA7Ooie5ZlwMoanzWZxLNA0xPIjSuYjdT12WS0YSgdb1uSG5JPS65Ul+dI
         IyO5en0KiNNX2iMToyIzB8d7UjO4QEO/AUF4SI0pI7j9kYeFA4slqKsZ2WUyT35nHn
         kxAyYEF0EDfzHEUy4A0aYMyXoALQjWuOfG8wAHt/1bQONDbj/vl/26SBFmMk/w+wxA
         X0zOn/m1myrkOTTikpbEqw8CV5euMUn7ogoC2bqBppR4SB3nw6hTdjG3doZ99DHkqa
         GTfT2n3NsZN4W6VfrssYg39Kp7Ev1Af8za5R8Li0CtVtMaj5AbAnZsCWbcX9cM3p+l
         b2nQDu7fMjNOg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rztns5cLWz4xPL;
        Tue,  3 Oct 2023 08:07:45 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 08:07:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the libata tree
Message-ID: <20231003080744.69ca4ed0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QaorJh+iemfgFlv2sz4gWty";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QaorJh+iemfgFlv2sz4gWty
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  0e23330fccd4 ("ata: libata-scsi: Disable scsi device manage_system_start_=
stop")
  1cf14228f460 ("scsi: sd: Differentiate system and runtime start/stop mana=
gement")
  540bd522a82e ("ata: libata-scsi: link ata port and scsi device")
  54e5c956a103 ("scsi: sd: Do not issue commands to suspended disks on shut=
down")
  6d62f34a6741 ("ata: libata-core: Fix ata_port_request_pm() locking")
  7c412cfbeecf ("scsi: Do not attempt to rescan suspended devices")
  9459518aba7b ("ata: libata-scsi: Fix delayed scsi_rescan_device() executi=
on")
  cb37013b985e ("ata: libata-eh: Fix compilation warning in ata_eh_link_rep=
ort()")
  e4bfeedb3b50 ("ata: libata-core: Fix port and device removal")
  f215cc816f8f ("ata: libata-core: Do not register PM operations for SAS po=
rts")
  fdd57890e769 ("ata: libata-core: Fix compilation warning in ata_dev_confi=
g_ncq()")

--=20
Cheers,
Stephen Rothwell

--Sig_/QaorJh+iemfgFlv2sz4gWty
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbMSAACgkQAVBC80lX
0GzLcAgAhzQVl3Y45s//Rq+NfW5IP0+YfeRLUBPvEwugVDDnSerd357y097nYpVR
xryx2T5ORFmypoAxpkxaa5GLyMlguKRQgUFL/gHrIT1hCjaRfdymnLCIxpPXCM2O
jHYjHLn2OdoYtEFsDSow9OT00+W1fSVyCravsChvhUPHT5dJQPy1ilVruMq4QhrG
6d4D4AqSBMOVJyhoecfvVPoaC3EjDatrsHKFdF1p03XjWedjvEMPbEYMsMuKwfsS
/TOiJSQkaA4gVWaRvyeiTlJsysGnschZXwxljukWyLNjSf7K1AggSLO4bUBsSyKF
DNAKFX+VXb/pYl5sQc4dPwrUlm3BTQ==
=mSv2
-----END PGP SIGNATURE-----

--Sig_/QaorJh+iemfgFlv2sz4gWty--
