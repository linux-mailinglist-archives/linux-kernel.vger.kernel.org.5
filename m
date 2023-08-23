Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6BA784FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjHWExR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 00:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjHWExP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:53:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699BBE4A;
        Tue, 22 Aug 2023 21:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692766392;
        bh=E7PrlwfvcfbsSkpNfyrhBUILcTKGUVyXB8IxDFYJh3g=;
        h=Date:From:To:Cc:Subject:From;
        b=b2Oi7GxcpgEggkyGSYEXABG3C8k2YGJc8N3VC8lB0laDkdwef1IUbBhH8cwK6V5w3
         i1VQjmxDdO5wJR4XKowo7vMqK75HrXU3TbnfR+mHK+th2H12/1onlxRHBHfCkyIodv
         Kr/eC2IPaED9FfTQ49PFd5AnMbXVI1S0Uu8MaaYmt88Ok6vffmGQuWdlxYEGK8yglr
         WDDs4ruk4TnRiFOEmBXcqyRVls2PVx4xu8kaP98IHP2dqFZax5NcIQM8ObetEGu6PW
         jvlnzZKzS96wXjQSd35SVT/V6q3SMG5+Aj9Rx0Y9daR6sABxUkSIhR1tZVAiP7cQ/0
         Usqjx7YUZJJ1A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVv3q4nvdz4wxQ;
        Wed, 23 Aug 2023 14:53:11 +1000 (AEST)
Date:   Wed, 23 Aug 2023 14:52:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: linux-next: manual merge of the kselftest tree with the mm-hotfixes
 tree
Message-ID: <20230823145258.6fb2b8d8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/55h4r/lSXpA1HGfWzqvna+L";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/55h4r/lSXpA1HGfWzqvna+L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest tree got a conflict in:

  tools/testing/selftests/cachestat/test_cachestat.c

between commits:

  fbf31ed6e0f4 ("selftests: cachestat: test for cachestat availability")
  8d55633e168b ("selftests: cachestat: catch failing fsync test on tmpfs")

from the mm-hotfixes tree and commit:

  13eb52f6293d ("selftests: cachestat: test for cachestat availability")

from the kselftest tree.

I fixed it up (I just used the former version of the conflicting bits)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/55h4r/lSXpA1HGfWzqvna+L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTlkKoACgkQAVBC80lX
0GxZzwgAgtv0nteYhBoB1Hc+BEYfznW9x40Eef7yyOwDm7EKopeN9gvS3Z6mQVHx
G2eSKgVClmxALXtRxJEIS6NEEuKXMlCkKtTr9QnOR01kGh7lc5BOEhgGML7m/nuc
xm0l9auTogb5FKKwzkToO8ie2WjgqX3dRWgq8W5hEjLWIoT3CygQx6PEImxNFbLX
bB0bpj7xTWvzxj22GUoENqDiQdS9qH3L1bQVTirL3zXg3L46GoOq42zGYO8Tl6sE
myKhQyoJuvHUYEaLUJ41W8wNcnfhOnvxz4mkd1FeGJFUe6YHf2Ubc0KB5VaLR9x5
wR8kPizitzpw2hypIJxyHEgpvn57ww==
=8P/9
-----END PGP SIGNATURE-----

--Sig_/55h4r/lSXpA1HGfWzqvna+L--
