Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B6878E38A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbjH3XxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjH3XxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:53:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52719CC;
        Wed, 30 Aug 2023 16:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693439599;
        bh=rmE3bYoZQwbV4e4pcm7x0OPaiSbVU4DIydrmIoyceUQ=;
        h=Date:From:To:Cc:Subject:From;
        b=tzXRsNOyUVRneqedHHJLADwZ3FI149Kj6pg1MVkPmMaCD3LN8xSTmx0ceJOiLfNld
         UOYrBcRaymteHI63gAWYoLgo7O7rpNKOzelVcUSPyDvVFYjFAxAEyafiilzDZRC86m
         f05Nd5CNCaBB7Jhm7cY39TBi8b+DZ87Y5qovsorBGZRfXqVdtrbZglLYd5vd/skWhW
         vU1KktHId65EWgGZJF3Gt2Epz+p71GqLngQapIbYh7e94xecWMpSc5xA0X1azHAz/w
         b6gZE+ni6BnroHRQCxlr4crXiYEqFbAjB/91QkPFQbnHl6eVRvn3KeQN98237LrPLr
         r3qSMHbwu9Stw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rbh264QR2z4wbP;
        Thu, 31 Aug 2023 09:53:17 +1000 (AEST)
Date:   Thu, 31 Aug 2023 09:53:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Evan Green <evan@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with the risc-v tree
Message-ID: <20230831095315.7a171be8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eYPlNMXd4wQBt0A10dS_Z.f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eYPlNMXd4wQBt0A10dS_Z.f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/riscv/hwprobe.rst

between commit:

  b98673c5b037 ("RISC-V: Probe for unaligned access speed")

from the risc-v tree and commit:

  d56b699d76d1 ("Documentation: Fix typos")

from the jc_docs tree.

I fixed it up (I just used the former) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/eYPlNMXd4wQBt0A10dS_Z.f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTv1msACgkQAVBC80lX
0GxpqQf/a1hPWq+8UjakgTTBhTfAGfCUnUuGjT7n8+oKHq+kMZ5+C/wQodCyh8t0
A6FKzSQJNoLTfuJl79LC2t65W/Mkw6xNZixHgT8dcxVfDSd2NuaMxhoFYSW7T7k8
+qzZBUArmQXwFSELpg7t/KelcNEX2uihe2oOWEet35JuHemfjqsD7t1y6c48gIir
qCm4KairM+3qedGyGhwuXvi16KJMqSrNCXQoCGmOnKZs8MQXro5KfS1qFLPqBhfp
+4udD4tmiJcR0SiHC5BLL5ZXe5NrtHKkVlMmC/hxK3ADlp1b0fRGh3NDcEnvYkhz
/ldaKslsyU1A+uw9s7P5dtOpUay52Q==
=pS/J
-----END PGP SIGNATURE-----

--Sig_/eYPlNMXd4wQBt0A10dS_Z.f--
