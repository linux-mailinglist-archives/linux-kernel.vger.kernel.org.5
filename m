Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395227A8F89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjITWnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITWnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:43:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65326CC;
        Wed, 20 Sep 2023 15:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695249775;
        bh=+1yEAV4I2/00XWXfaY3WZJuNSg0q/N9cTkGNr3C8bIY=;
        h=Date:From:To:Cc:Subject:From;
        b=mjXME4/Dyvd6guCaSMjP7/nq7ZSH6FzBuKASKekjY9jowWlqkGTy7Q4OiUgU9nI9a
         2RY+ChqugkPzODe4TqQZh4j8umomyMT8db45/8grOl+ACIup/xv8EREoxFXq4ReIyF
         6cX/eyFenLco7SeOUJxTCgFGirMVHy/XVEGyZUl7YvjMFr9iPP1SsU0CnlMhz71hSk
         +xIDqsHeVUfWpk4rkCVzcp7itBFVohw5yVBXNLQgQEkU05fjeGliC579gQjF5maB1Q
         Qze97RpXBC/67xpcuP/Ef61h6LxmiE/Du/KRXDMvYtvTxfwBIskVr53qdR7mcU7tl8
         Ax3+4V7qi+4iw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RrYTB19rwz4x2X;
        Thu, 21 Sep 2023 08:42:54 +1000 (AEST)
Date:   Thu, 21 Sep 2023 08:42:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the qcom tree
Message-ID: <20230921084252.3c5ab501@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MQUK_2f2BNxdFZXeQR4ZApT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MQUK_2f2BNxdFZXeQR4ZApT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the qcom tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

Error: scripts/dtc/include-prefixes/arm64/qcom/pm7250b.dtsi:44.10-11 syntax=
 error
FATAL ERROR: Unable to parse input tree

Caused (exposed) by commit

  eee9602ad649 ("arm64: dts: qcom: qcm6490: Add device-tree for Fairphone 5=
")

I have used the qcom tree from next-20230920 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/MQUK_2f2BNxdFZXeQR4ZApT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmULdWwACgkQAVBC80lX
0GwTPAf+NdR9K7T7hZAJHOc60EueZPUzxp/+RMX/VEK2h9fNCd/nUopJ+xvoloaT
6iJIytN0TQSjiufcWEFuQf1Nq5sq10Kc2mVAIjhMC44jKmcEiMEOXpUbjSX4eOK2
tDX46vaIQATiI6AnBzrS+/OVgeFyLn7UISGEZ7juL1Lr6KM0XRYOryTbnSUBX+ET
K5JgdJI7xMcZILIdCZY7CpWObZtwf24ErDEy9y9FSrA8yivloHwqNIbQKoShmEaa
kJwVo8osvAsgu2tvhz/EmnVQ8/+bUOzipMs0UQUsX9LU1a5Qt2vEeQqn8tFy7BWR
mX1a0h3tNnDiA87P5zE4q/PfLQUvmg==
=0kd/
-----END PGP SIGNATURE-----

--Sig_/MQUK_2f2BNxdFZXeQR4ZApT--
