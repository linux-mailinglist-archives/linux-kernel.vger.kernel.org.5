Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE907791F90
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 00:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241525AbjIDWir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 18:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjIDWiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 18:38:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320769D;
        Mon,  4 Sep 2023 15:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693867121;
        bh=VsZaKdjiLp2o8KkwlQhb7LU1MNTcWZyPAyFueTEa8Tg=;
        h=Date:From:To:Cc:Subject:From;
        b=bgFE0eW9582N8MjKtPAK5Vqwvu4CkfhRNFypb3Vxtc2Xxj+jvLXBF4fdXmMzpAkwT
         aIrTsUnRJkYi6nsu2mY/BFrKk8JUHJOcsD47JQ1bFmsq25OE3dPThzkj6vwyQ4JeQX
         aBubE7LS05SqjrDBW/9fVzIIgM9XFrWEW9gekuy0CxDS6QxvAz3SD8VjZHPxHCmz9L
         wCb8ikVkPMlOa3GqXO0qGLD7NkTPKxFLUO6rR1K8JtNaw4Bx8ZCkjYYfMsq+OKqUIR
         ZrRS11C+3aojhSi+D7BRnX/xyOidGQ96t3Yblqsr+7cFddJxUgCtJIxnE7VSblks2R
         vSaGqZ0GHNJgw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rfk7j5mzkz4wb1;
        Tue,  5 Sep 2023 08:38:41 +1000 (AEST)
Date:   Tue, 5 Sep 2023 08:38:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the mm tree
Message-ID: <20230905083840.3048899b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r3PJ2XOhMitY7dTSUd2v.9f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r3PJ2XOhMitY7dTSUd2v.9f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the mm-stable tree as different
commits (but the same patches):

  b93868dbf9bc ("mm/kmemleak: move up cond_resched() call in page scanning =
loop")
  a9bfaccff9ea ("mm: page_alloc: remove stale CMA guard code")
  3b92a75cc2cb ("MAINTAINERS: add rmap.h to mm entry")
  5a0afb5af594 ("rmap: remove anon_vma_link() nommu stub")
  44265c75a6ca ("mm/hwpoison: rename hwp_walk* to hwpoison_walk*")
  490933119a41 ("mm: memory-failure: add PageOffline() check")

--=20
Cheers,
Stephen Rothwell

--Sig_/r3PJ2XOhMitY7dTSUd2v.9f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT2XHAACgkQAVBC80lX
0Gxt6gf/SUbLDv5aULzZyJsc0D3DEL8aAXKtVaZqqVn+PBTxmoXnTdM4xcKlrXgL
+YOf51Qp5o2mesRZW2xQdfpvg7EL44BZlUA9wjs2MjNAtw3EcnVwdX4UeWsL41MA
sK63AukyYsARdC9x6dqeh+UA8W1XH8D2Eg+fK2fr1rTEGMr3x1wSHilGx8lQ1kCa
jNZ81yShFXh8K/+VZBjvecnJcuu3pUpgO2Zq2oIcbr1Wfs6M8wU7LDM0N8d8qM4m
HNpn4k8i61Nq+xfVoCQNbS8eUBq7wvp2xNo+8A5MLUlg24gZAMYia5FNdEmost/I
s4DxZsCXWYmc2HxCkJ3VIjzevcOYdA==
=cccH
-----END PGP SIGNATURE-----

--Sig_/r3PJ2XOhMitY7dTSUd2v.9f--
