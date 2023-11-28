Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1E47FC8D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjK1VxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjK1VxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:53:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921AA18F;
        Tue, 28 Nov 2023 13:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701208395;
        bh=KO5V6pbvlN0x2mJFnkJQlZa+zZOJEiVHRwjRN/9mI7A=;
        h=Date:From:To:Cc:Subject:From;
        b=sadRXjrv8ZUFmQsAB/olrq/FUo/SqVRnPZxRfspL2K6vKEGrCb2vFZBI0CLL+xuG/
         lv2+03+R6pDHAUfZPEz2CRM8nZSsmPOAR5FoHynTV7l2gnv89rlHPFnfkkj3A0Rbu2
         O/mUE/ODjgLM1Oa47wvlkqRa4vx4O+J+XRnjQ7JbN/9S1XAVvbdl3owZWRvO2VxVb/
         3K9TAJjr+xZrDHbMhgXdgCtVckV6a4Dip+FhocrG+iTfyPqa+/MxYJ3bQDm0lEhWXl
         cR86QrzFruLtJ3xpq5OM11aJUyFIUadZh0nxLMvEUHvrLTWHjrrvX3JOrnOq042aht
         X2sJZTlH0JwqQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sfx625QrNz4wc6;
        Wed, 29 Nov 2023 08:53:14 +1100 (AEDT)
Date:   Wed, 29 Nov 2023 08:53:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: linux-next: manual merge of the perf tree with Linus' tree
Message-ID: <20231129085314.50306434@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HwCPpO2ITtrp5X1cfHT9ZVs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HwCPpO2ITtrp5X1cfHT9ZVs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the perf tree got a conflict in:

  tools/perf/Makefile.perf

between commit:

  e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to incl=
ude path")

from Lius' tree and commit:

  1638b11ef815 ("perf tools: Add perf binary dependent rule for shellcheck =
log in Makefile.perf")

from the perf tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/perf/Makefile.perf
index 058c9aecf608,824cbc0af7d7..000000000000
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@@ -1150,7 -1151,8 +1168,8 @@@ endif # CONFIG_PERF_BPF_SKE
  bpf-skel-clean:
  	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 =20
 -clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-c=
lean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresi=
ght-targets-clean
 +clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-c=
lean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf=
-skel-clean tests-coresight-targets-clean
+ 	$(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
  	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive=
 $(OUTPUT)perf-iostat $(LANG_BINDINGS)
  	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delet=
e -o -name '\.*.d' -delete
  	$(Q)$(RM) $(OUTPUT).config-detected

--Sig_/HwCPpO2ITtrp5X1cfHT9ZVs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVmYUoACgkQAVBC80lX
0GzwHgf9FleqT7MMh5KhBBfDJtFdimuTA1owuafutlCBkA5PWwYGr+X3QsrRRRXe
BbB26uskBLFZ9d4li8gSAbtqocL6ioPkTe9jzY63giVamNPmuya2mptish9R8QSv
7FolC2WiS2j1HpAQO+ge3P5uHTFBgtidN0aMmJzCzdPg17xfUI+McK4zvqV/++/L
IsjiHEZoO/vs19vPf9M773SPvYiMYyG4jbBMtBkRDSn6BISTpcr7dv/7f3481cfQ
BXPmEHSpkk14LDYlDOopJGZBJCLOedWYSkyST3tsN4JpvzQcoypfyTcEMgjAOEX1
OAnblEz7evVVg9sUXD0zzyx9Q/FqsA==
=dD0H
-----END PGP SIGNATURE-----

--Sig_/HwCPpO2ITtrp5X1cfHT9ZVs--
