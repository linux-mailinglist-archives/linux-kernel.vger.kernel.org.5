Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E027B99A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244416AbjJEBcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244140AbjJEBcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:32:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A1CE;
        Wed,  4 Oct 2023 18:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696469523;
        bh=y1eMOoLeYppE5pX7hDk7NP14cMMkS/wykgND0TrNVhM=;
        h=Date:From:To:Cc:Subject:From;
        b=fNuqnL7YgGFQi2wv0htaLnnNclKUKjZYjg++AlJdgWozTQJKIDFCzgDKiZc+b3U0I
         2QhY6clQb9gSd8DFtLYz+1YXXOnMTbedIvGuBiagJj89BHkMzNf39RBrhO+WYbRxKr
         gG7GCoP3+ywZ4nWb83aKCA4mPvqL8n2r64XUPuUWoKZGRAmmvLkWyPCjsH7oVFzjJN
         3Hurp4ucEBher7yvx1caXbC1ph1CrP6w/vVqFiMhBaCe7pEBX21FjP9ZO5C2fstwK/
         8uV2ZAmLxe+LNwoaI84A/aF46V2ZwjhiVHKkWvgJCgGVj0PFaqtgzbaVCqbgjeAVHO
         ayDmJ9LXgX4Qw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1DYv1MHxz4xRj;
        Thu,  5 Oct 2023 12:32:02 +1100 (AEDT)
Date:   Thu, 5 Oct 2023 12:31:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Jing Zhang <jingzhangos@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kvm-arm tree
Message-ID: <20231005123159.1b7dff0f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ow4ufp2gWy0/6aojL0/C.Xm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ow4ufp2gWy0/6aojL0/C.Xm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kvm-arm tree, today's linux-next build (native perf)
failed like this:

In file included from util/../../arch/arm64/include/asm/cputype.h:201,
                 from util/arm-spe.c:37:
tools/arch/arm64/include/asm/sysreg.h:132:10: fatal error: asm/sysreg-defs.=
h: No such file or directory
  132 | #include "asm/sysreg-defs.h"
      |          ^~~~~~~~~~~~~~~~~~~

Caused by commit

  6a4c6c6a56c1 ("KVM: arm64: selftests: Import automatic generation of sysr=
eg defs")

I have used the kvm-arm tree from next-20231004 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/ow4ufp2gWy0/6aojL0/C.Xm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUeEg8ACgkQAVBC80lX
0Gy8tQf/Q6kfCJxOrrQygnAll8STrulpSFdtxYQZQb5xOLWAsTaHIkYlQLvICO2y
wBCB+FnBzP1JaySmACkco/G700H4FroKP/NBsxZcqWMal3qTTucwcYIt6wR2Y//6
VhWAhFWoV8ul++ZjTE2TeiHt7yGXLS3SE2SNO7Zacv7QW6jHIWRSZxqvbYoubs6z
JeeJfC/4dyu59ulfTJuBeVXwFGN5XLLrU4DUpUumpma92IifdQTORC8y7VwZhVPy
Kmcwfdih2JuDRqe1hFS7PCFHqmwMJ/5M3GBxeE//SyTM1nZ8QfM7mJYmUBUHVa9y
KyvTJrLokXb6sYdJbizRmdkpL/t7cg==
=bXnH
-----END PGP SIGNATURE-----

--Sig_/ow4ufp2gWy0/6aojL0/C.Xm--
