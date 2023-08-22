Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0922B783A31
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjHVGyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjHVGyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:54:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F38710E;
        Mon, 21 Aug 2023 23:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692687236;
        bh=Ah62AUrzjKq+nEpeEC2KEKP4jJvhJf3LyI0rXXoFvmQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OzwNnR5x/pk4kVsnXRGcWOY3XDdnJJWAAUoKBD6i3RWzliZugkq2rVZlA3tZuIfEr
         G10fV524KzvBZ9xmf7Uf0G+QL9mYwzLJxslEcVqWR6Tzq/W4ZVWhFELXJt1ql6qdfG
         ICjpB4jkUiUbYBELkto6/bBIEbUBf9xQXnOtMUMTC7rYmWGgchfrhc7BOAWbZwWuc6
         Cf7Cqtfhyc/HW/l55natXHIyybSStrTiUHawZGdTfp/Dmr5t99mvSjYNCjvnMTYJOg
         xP6KDVxLiQellSHITBGindAd79syGSJrNQ9vOs8a3nwvSKlsCEfAQL4p192gcJV96F
         nOKJARykannqw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVKnc3fWXz4wxR;
        Tue, 22 Aug 2023 16:53:56 +1000 (AEST)
Date:   Tue, 22 Aug 2023 16:53:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm-stable tree
Message-ID: <20230822165355.5eb8cac1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iOukjq7rF7T1aEe16dY45In";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iOukjq7rF7T1aEe16dY45In
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm-stable tree, today's linux-next build (htmldocs)
produced this warning:

mm/hugetlb.c:1: warning: no structured comments found

Introduced by commit

  9c5ccf2db04b ("mm: remove HUGETLB_PAGE_DTOR")

--=20
Cheers,
Stephen Rothwell

--Sig_/iOukjq7rF7T1aEe16dY45In
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkW4MACgkQAVBC80lX
0GwoFgf/RZq0OlnqFn312IPySBoVhGruoQq/AMGTzrKK6JgWzab5tO0qhaIU/bQq
qe7Bm9NqEYmjrE34OwpHVy5iwhUMV6KHmxYvYIPEc8ZJSCshgdCVZSqzmdFi4NXi
HSkZ9yz98fudu7SW1mLSQdhASidKT5Agtlg12V/DsakzAEwote7jwyEVLqlU6Tjn
7zZF0xgeKusV2gjAvxjqIBNqvT9zEYDO4HvZvFNhMbgzKUitcHiE2G8sSxnzuznW
0QYj5tD3UVgs3tSuLvSfYgNwJPWue+Hh48SFsY6/Dgnqiv/bSM5gm+kHK/xZXBQl
xLxWaBcuMHZV12RmhJEoBhqS8H1xVQ==
=Cvw9
-----END PGP SIGNATURE-----

--Sig_/iOukjq7rF7T1aEe16dY45In--
