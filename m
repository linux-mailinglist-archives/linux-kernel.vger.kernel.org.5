Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CFD79F681
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjINBuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjINBun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:50:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FD2E3;
        Wed, 13 Sep 2023 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694656237;
        bh=/t4JC7x6meOZo5gysmAG4fnMPuQklgT+8nfdeodh7Is=;
        h=Date:From:To:Cc:Subject:From;
        b=CAXVcDlaLnZnTziVl+Vi4lqDRZkuymY1oLVsZJGIVislKYHc4htA2Q53N0Y6y0mw6
         ZKOZ5480D71px+D6VwHRc2rkr36aLNn1/o/hzdD8CiXgpVkOFNs3TpvawI/xMSEbAD
         65VTcD2IZFbjFy7E7MK7ZvlFwSAUCo5k8DqinBsshlT8GtvQl6kKewJjEFM/E3eA0N
         oJtlS1Gh2JaygMNNhp/0s1HWX6HkR0kHcqp3L1YZo/teMhhNwqacRgw+mNC+UDYtDE
         +jcH2q1ueNxelvDe5KKUGkZSljFeJ249t6Dvh0AH3OecxKX08sPKX1urB7rSF7NLeg
         76JfPUnGhqf9w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RmKz15bc6z4wxh;
        Thu, 14 Sep 2023 11:50:37 +1000 (AEST)
Date:   Thu, 14 Sep 2023 11:50:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the kspp tree
Message-ID: <20230914115036.78ee9e94@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eCLs8QLU9EYBBikhGkOvFLM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eCLs8QLU9EYBBikhGkOvFLM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the kspp tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from security/selinux/include/initial_sid_to_string.h:3,
                 from scripts/selinux/genheaders/genheaders.c:19:
include/uapi/linux/stddef.h:59:2: error: #endif without #if
   59 | #endif /* _UAPI_LINUX_STDDEF_H */
      |  ^~~~~

Caused by commit

  366c47121bf6 ("uapi: stddef.h: Fix header guard location")

I have used the kspp tree from next-20230913 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/eCLs8QLU9EYBBikhGkOvFLM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUCZuwACgkQAVBC80lX
0Gyc4ggAnMah//Fq7CDd4yaUHkxhKqoVoZQaF7WKFWpocrR5mHVPb814vsltiX9F
4tC8oo08AChEdxI6gBnye7/+CoTyZ7XBkSEaAEXJaLVqM+uXrI/s5LAFZbKkjJra
XNI4H7SeQV+4QUKeN376CLwc6jPGeBwi1AEcNhR4vXEZijAv8dzxLFoNSc2gvity
DeG6xIIxmwBztj11fWBkEZyP8ui6LrRFNW5ZY9h8lLKgNo1KBUaBXKiViiGFQ49S
jpZkFN+pm1Kxs2diqGzLH+rR17UIRHrUYN9vl45iYGuAM7FGQbqi7XQQg6rJVl47
anRitRrehxHfetVpVKNTh3GGreXh1w==
=iiH+
-----END PGP SIGNATURE-----

--Sig_/eCLs8QLU9EYBBikhGkOvFLM--
