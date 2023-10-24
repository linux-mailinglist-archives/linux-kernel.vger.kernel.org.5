Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F157D4766
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjJXGYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJXGYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:24:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532B4C0;
        Mon, 23 Oct 2023 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698128651;
        bh=XWTOulYzbrGm7RV+HC0GyI+nA503F7VFD39wzfI+WLI=;
        h=Date:From:To:Cc:Subject:From;
        b=p9zWqjAiXtdg5sniLPt4/gBOILoLPDjvbT4LaoKpGZgVy/ejznFt1gwAk/RArQaIP
         FGeAYWqnrgi5rla59Z77PhX95SB/NbaRB5hbNvnrxdPbTsMy7FjRrJLgNlbVl3clAU
         SU90vPpQOU/QFpK1qv83DFUnuDho8ER2sLAAWbfDyTfdKBR41QIkGb0ojLEoXN7fya
         r/2+2IX7hKWQmbzk6I59nr4cruOZEiO0p/HHX6kdpMwY5rlRVAYXlqHMsMQz1IK6yD
         Whg8M/AVVyVp+2kT5WAfxZ5vbpU7k3X0amoJJMN42g3B3/OGZsdZ9Ka7/5y3kOuexG
         wIElvwnH8GRmw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SF28C563Jz4wdB;
        Tue, 24 Oct 2023 17:24:11 +1100 (AEDT)
Date:   Tue, 24 Oct 2023 17:24:09 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm64 tree
Message-ID: <20231024172409.7b519868@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ebK1CJpvmdvJFpMxCsIQqpo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ebK1CJpvmdvJFpMxCsIQqpo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm64 tree, today's linux-next build (arm64 defconfig)
produced this warning:

WARNING: modpost: vmlinux: section mismatch in reference: __pi_$x+0x38 (sec=
tion: .text) -> __pi_map_range (section: .init.text)

I don't know what caused this.

--=20
Cheers,
Stephen Rothwell

--Sig_/ebK1CJpvmdvJFpMxCsIQqpo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU3YwoACgkQAVBC80lX
0GzPJAf2NofqIfW5IKJHoEaF3+N85UtsHc6B/+S1ASPR7O/JMMcwDUrqw8z4B4yg
9r2x+T8FvfjWvCoFMcsDUVxcFPVYDKYEJ8hDdy+u7DZXLFwdgUz8BkbGqU3HguNS
XjIgVIO5S5/stB9cvMIpByXT42ST6IY9KtjoTWYZ4B6ekjoM08zt/M29LZPW4ts5
l29KkdAFzIDpLBPELA3U+DZzMzdKry4kQHEmaNsMYYww11JNlmvCvb5jWqdMoMO0
UjSwNdXDKvVTz8Yg40btAGd41lI0jnjzGXsDL31xH2ENh5F2gq3yrHrjNUgnMIn/
xN+CJm9PYiuoeKG8DK9NV2VGKh0L
=1jub
-----END PGP SIGNATURE-----

--Sig_/ebK1CJpvmdvJFpMxCsIQqpo--
