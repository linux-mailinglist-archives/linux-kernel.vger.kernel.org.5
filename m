Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE2280FA5D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 23:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377826AbjLLWaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 17:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377804AbjLLWap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 17:30:45 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AF5D3;
        Tue, 12 Dec 2023 14:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702420245;
        bh=3m6qWgRvFfWpBwh+CbM5Cq4Yh6DC3FfK3uAYreYmoDo=;
        h=Date:From:To:Cc:Subject:From;
        b=Wh4rFSFyzyoED3FLRQ4W2eJMHrSjlPtQLr89ohdI/25cIWv0s56NpUf96F3l9RZrD
         yKIDMFOsO65tbo6esnQbpmf8GKPLyZn8/GsF2DKKaQTIbZtdJ9NaQvQOttgK+jgieD
         qUMiPc4qwp0ckGno+LepSxXXcjqoDGeb7yRzevNdOJxiNToIfNbvOE3CMty/JgVMga
         aVQBcvM+NPgQCVR6O67iYXxJYDuFvuYLAo85L87p3CmUHh7xCLVjKjt1q9SgU3XHq1
         2nFB1gj8MPErtPVIr4F9iYhf2siTasdU05U9RVV2n2+gjuaH3FBoMHPkxmdwZy/Bf8
         mYr1JJryXx1QA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SqYGs4Xchz4wdC;
        Wed, 13 Dec 2023 09:30:45 +1100 (AEDT)
Date:   Wed, 13 Dec 2023 09:30:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Peter Yin <peteryin.openbmc@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the aspeed tree
Message-ID: <20231213093044.2fc89781@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/sZhqC1X3hlz1Zq+/ApiS5iR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/sZhqC1X3hlz1Zq+/ApiS5iR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the aspeed tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

make[4]: *** No rule to make target 'arch/arm/boot/dts/aspeed/aspeed-bmc-fa=
cebook-harma.dtb', needed by 'arch/arm/boot/dts/aspeed/'.  Stop.

Caused by commit

  70fe22dd623e ("ARM: dts: aspeed: Harma: Add Meta Harma (AST2600) BMC")

I have used the aspeed tree from next-20231212 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/sZhqC1X3hlz1Zq+/ApiS5iR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV43xQACgkQAVBC80lX
0Gz8VQf9GA9wE8GZqAiKiqk9hBOxcUZZEoA6cu4puSuLmMJB6mHcXJc1YjpZuuDY
AX+BVqbIerUN5Pnh3WKxrLKNDA9iHmZvKyM2SQb5ZeE+WY6e3qp+ZYIDSyDJFFLU
tL7MlS5ZFDmG8TrnXY1izYj2Qw2d2ORulL9Yko5ll2dGQLr3ZlA4UYp3uEMoptJb
W/R8DHZmJJPfFgy0yQ6C8XiKdmpsioUrIUWjt9UwVJleQoOT4VbGZBf9XJNr+pW0
D6NiZ7W4SQ7/P90zRMumctGjJBsSjWc2jQxaQZjFEqU/IsYJrT8BVZB+3hdwWEQJ
bp6RxrYbTNqKasceufKp0bH0Oedxlg==
=0qM0
-----END PGP SIGNATURE-----

--Sig_/sZhqC1X3hlz1Zq+/ApiS5iR--
