Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580C1787F46
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbjHYFad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjHYFaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:30:08 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C1B1BE2;
        Thu, 24 Aug 2023 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692941399;
        bh=koD08kXsND19LIl+BR8O6YAgNUZiqvdi7U/T0JbZEQU=;
        h=Date:From:To:Cc:Subject:From;
        b=ItWR/uJmFezwbqNfjteGnHIeX8DtqOL1uEfdexRXmTqkS++J+IJ1MSIBe5FLJJany
         PcbwIzTvo2c66ybFbYGRnyfr41nPNDDNL9Nhp0HQhHJfqikvYtF86tRdsNUejNuGFR
         OP6tSk6w3Qwprszl8ujw8ZOLUYTNDjIQsUJ1pbso+2hY0b5XGLst1YNRf2rdOCl8DQ
         WNSRrrRjiu0WMXuGgMmkzOWk2oeyLitCh/flw/TkaTOjk97tqhnNLkM8iNHv/0ZzV/
         og1L39VePj+Mn5bHTy90h6qk3KkbDAeEWOXEho6ezXJ+DS4OhN/NixcrDm8fXhs7RM
         zmJThmpnXMCvA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RX7nM1YzSz4wb0;
        Fri, 25 Aug 2023 15:29:58 +1000 (AEST)
Date:   Fri, 25 Aug 2023 15:29:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the sound tree
Message-ID: <20230825152957.18c54ae2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aQ8gV_Y91n+Ky1_AMLPNlWQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aQ8gV_Y91n+Ky1_AMLPNlWQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/sound/designs/midi-2.0.rst:517: WARNING: Inline interpreted t=
ext or phrase reference start-string without end-string.

Introduced by commit

  e240cff9e6e9 ("ALSA: documentation: Add description for USB MIDI 2.0 gadg=
et driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/aQ8gV_Y91n+Ky1_AMLPNlWQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmToPFUACgkQAVBC80lX
0Gz7qwgAmRttHSU6miA2HvL2RWdEAqeCMA72GYfBKdU11aKGrZUK6Y6Y1lViOKX5
GQHMZoKxUnjxyZvOSoCd9uJqMowtJCcZK+tOScvjPRCmOMEQnrQVJcz0NEFmHtw4
tqid9+uLxSgiaCPvtZnyccjpj6wwD3ctpRbdiHbvuml/UzOt64ozmfp9zzbpG+eb
FWG7ijntGJGsosCwnm67Q0TRvL5HZt+99U7BGwSOsNRFqqdgvg3s185r8fJ5yNfz
t032bujg4HabzOaOg9YQEjdmhSBJkdmgSDYbz1X4TfC1j2cOeoZFpLA05vexNYF1
QiAjb/kVaS3vGt5Hyl423QTpaJ7fbw==
=D70W
-----END PGP SIGNATURE-----

--Sig_/aQ8gV_Y91n+Ky1_AMLPNlWQ--
