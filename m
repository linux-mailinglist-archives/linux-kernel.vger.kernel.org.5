Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8127628C4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 04:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjGZCco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 22:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjGZCcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 22:32:42 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772202688;
        Tue, 25 Jul 2023 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690338753;
        bh=YOAtrqVAX1aaGMpbauSR1cEA3NMyg0TYh3Ytu5ENrpg=;
        h=Date:From:To:Cc:Subject:From;
        b=KrWE4d6geROPmFJ1iWuRf1XtCPatOVHGMSCYt5PPhjyuOnwhjanCfTRZh9uhmfH7w
         wT+a7x2L53miL9hVkIPNtfWSLWrYRLEYSSVCQZA/ShkDIPoStAmvojR3Uo2c56QXVL
         UhubBpSI61WGv4G68Fc0xEnB+0pIZxJ4fAjco4dSD5AcPmzzWuisKfDQB1xAEL1ByT
         DPvXspQuykrITWKJf6v2pgjXF37gH7ezKOROGovI1WolXFvEFV1ZGjqIyIIaon61Fz
         nQkFaZGP0DKWFgM7s7UUsT5iY3TbyJ2xbbVbxDYyeLnRiLte6cdGu3lZw9QJMDYfLi
         Yq1Z9lXKy5lYg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R9dGS6Q3Gz4wxm;
        Wed, 26 Jul 2023 12:32:32 +1000 (AEST)
Date:   Wed, 26 Jul 2023 12:32:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the rcu tree
Message-ID: <20230726123230.525202b4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zRGpXJM2rSfSmX9QVvmYFLn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zRGpXJM2rSfSmX9QVvmYFLn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

WARNING: modpost: vmlinux: section mismatch in reference: cmdline_load_proc=
_show+0x22 (section: .text) -> boot_command_line (section: .init.data)

Introduced by commit

  cf9eca90a339 ("fs/proc: Add /proc/cmdline_load for boot loader arguments")

--=20
Cheers,
Stephen Rothwell

--Sig_/zRGpXJM2rSfSmX9QVvmYFLn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTAhb4ACgkQAVBC80lX
0Gyeggf+L1egGIyXFyMYi4Y2W9cDM8YoIORjxdZymTMOUbw5iLEIQo1Pc33iqGEC
S8V4FSPWBvCLVHXQQef9J8HbBy0/eog1x0vH8t0NGG+6QhsFnmB+pUMdigZZ03r5
IAmp6MXit+jE+mLDxKvdkO7MYna09XDEZaWKweoNzqWjFcwo61mXdIHnoWCJmpku
wu22sEtayN7Mva93mJrQ3sbXxbYoFNnWjmCg8RguiDcOISSpzCztMG6E7UYjhFIx
QiiH4kL+nhEMdtFu+zminqzLp9Hu6Hn9MRIMylAlj/1HTlrwaMpOLp+ypZjM9r6A
SvPy0j0pk3JzDiYTv6lwFi8kM1H4ew==
=bnPn
-----END PGP SIGNATURE-----

--Sig_/zRGpXJM2rSfSmX9QVvmYFLn--
