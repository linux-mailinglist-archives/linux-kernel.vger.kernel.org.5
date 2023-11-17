Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEB17EEA8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 02:04:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjKQBEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 20:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQBEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 20:04:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F83129;
        Thu, 16 Nov 2023 17:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700183085;
        bh=Na1rTytPUSHgw/q6Ndtj6R6gwB8w0Yak/IZmxMVeEuU=;
        h=Date:From:To:Cc:Subject:From;
        b=BWtZWneAMVuSknzpms6+iOrffjWu5uwbNTFvEYVv137/cM1/PTVVoeFCeVyZmW1uW
         Xc7FVNiiJm256vA34K+M0tCDtxKCSVpIWfDG0VD8uUSUfS97RNkW5isixzR8gT64dg
         S42rsVxs3pkzF9672desoK14tanSyZD2xjqUBrg+SpeD8phkMBJtBjrsqNm4IxRx7o
         fTo8ekaLlrTmi1WIY9bFK0labbVXdAdhHMCOJuPAxmwMRdY21HFma0O5KwFykle66s
         ElIDiYIWX0KsgwLCSimnqPEEEAkfMI40beaiH1jl9AIfsXaA60SNPSNR0dHW8zmjTj
         DXs3oOh7e+o/g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SWdwX6k8qz4wbk;
        Fri, 17 Nov 2023 12:04:44 +1100 (AEDT)
Date:   Fri, 17 Nov 2023 12:04:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     =?UTF-8?B?R8O8bnRoZXI=?= Noack <gnoack@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the landlock tree
Message-ID: <20231117120442.5132a15e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I969V7naf+DX.Qv09REMZR8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/I969V7naf+DX.Qv09REMZR8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the landlock tree, today's linux-next build (htmldocs)
produced this warning:

security/landlock/ruleset.h:287: warning: This comment starts with '/**', b=
ut isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Returns @access with the synthetic IOCTL group flags enabled if necessar=
y.

Introduced by commit

  f3672f581e95 ("landlock: Add IOCTL access right")

--=20
Cheers,
Stephen Rothwell

--Sig_/I969V7naf+DX.Qv09REMZR8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVWvCoACgkQAVBC80lX
0GxsLQf+MEFxfnIfmO93asLEfTyr9bDX1G+X4isC7ZHgtXLds88WCx4gnQyew3Xv
D/hkUCtYa+92zpmwp9mU+KVgA0oN6KZlspPM+RASB5lS+Ks3Si5byJTpC2K20fk1
NTsXuHDEPgjsXx4TeoKWK9BWPWpGdS4i1Bl4NxYNi2Z1rTlfuNC0Xjfeupp9aLn8
angxHOpsj3EcR7wsb0vwoLhWg3Rtfh5HOvlpj+6x5h0JOjLJmzaepdeinPp6tFvJ
4CbG5A1IoqrzspK1+O/KlHoz1U2zwbxfxa5iMM0MK9qOtfkbIaV7akXe2Gbfz1T+
Xopv4Re9k98BJ0k+PLtxWXZet3+uRw==
=xlxh
-----END PGP SIGNATURE-----

--Sig_/I969V7naf+DX.Qv09REMZR8--
