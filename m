Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332877CEF07
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjJSFdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJSFdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:33:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249A5AB;
        Wed, 18 Oct 2023 22:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697693592;
        bh=eUs3FYSpJHv4seH/J80hx7LD97ssYiiLFe/yAcaVbjA=;
        h=Date:From:To:Cc:Subject:From;
        b=FjlqFeSTI/ePyjxPEST/tTpgK32mEpcOd1nvANMIdfsxOvkeSivTzddjNqGEX98dm
         miVVJbtkXDBwUuHg+KnxrkZMuoQKaSJIwNf3W4uQkG82j8RtLDVj6G5abDKRTQFCzQ
         QSnn70M9+BdZTU6zxanRrlB2IXeF7rqBjJ+OXq5FmnNzabNVAQNzw7MGQHHJIRJ02+
         oJeMq7CqnBaduNJOg5Xp4SkOhCNh8J2zk6q5AYtCh+x8XHHu9AoNUNn8lL4TBnWPNB
         KIu98efpe6HksjzZiKlZFyy06bR5zg/pXPy+QIOZBUfOABgy7SWmTOxpzKcU+cdeOP
         nzncxCMTvGjzg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9xFg6bkbz4xbP;
        Thu, 19 Oct 2023 16:33:11 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 16:33:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: linux-next: manual merge of the kselftest tree with the mm-hotfixes
 tree
Message-ID: <20231019163310.6c24d6ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4ZotJJH.AwTb8QrpvvtBbOe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4ZotJJH.AwTb8QrpvvtBbOe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kselftest tree got a conflict in:

  tools/testing/selftests/clone3/clone3.c

between commit:

  fc7f04dc23db ("selftests/clone3: Fix broken test under !CONFIG_TIME_NS")

from the mm-hotfixes tree and commit:

  34dce23f7e40 ("selftests/clone3: Report descriptive test names")

from the kselftest tree.

I fixed it up (I used this files form the latter commit) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/4ZotJJH.AwTb8QrpvvtBbOe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwv5YACgkQAVBC80lX
0GwTJAf8CMiAzguvf8PPbTCw46IuQvy+fyxmoovHqDSvKBbsdPkUHIUdxL7nBH85
ePkTRSd2u2sQQwGOIz8l+fUx2GEDQaoflSMtzFSDqWLOwds4vVE1jfi7tZP86LNm
bSDPcNbhm9TZSvgMrr+VcXmo6Ykfw1eRbESiXcVxfAjFed/mpcYJi5h9ACvwtme+
l8HTAXStB4Id/YruNbK6l2oUWPZE4J95iv15Mc+ZMMBzQ07QNaqbXfONcGydVMht
SEkWNVCJQtCVrEeSMGGdYA6ynhAl5qDrxL9MUZ/D90Quekc4H174jGCJ2o5qp+k3
2IrdOP0HN81QzMaNDGVAl5aZkNhPkg==
=th37
-----END PGP SIGNATURE-----

--Sig_/4ZotJJH.AwTb8QrpvvtBbOe--
