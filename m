Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7C47644D9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjG0E3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjG0E2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:28:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8533D270F;
        Wed, 26 Jul 2023 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690432126;
        bh=InTA/u68k13US/kqkHBirKX2ptHbnR8hviE4ZLAKUMI=;
        h=Date:From:To:Cc:Subject:From;
        b=B3hdygXHuhJTqzvygGpVYO+s9GUcA87J/Tk24WYR14RFKcc3SQSrSoIM1EkFqp/A4
         uyE/l6wuYP9G8If9/yXnlaVnpCWJ5JNyHi7p4wVq5/P9voaJs6E4aTW+mJ5YLoQKh3
         rcdd00EodlBl6yQ6k92GBOdhzBD9NQmFjZ7QYJxCqPpxx8V9/PGVtaIc/IPleiu44K
         FHX25N4qtf049/Yd5qIDc0caVdXypExQBxU6b6EW/tA7ZdaV2jUtruC3m2J7e0wzSh
         8vVFO53WDkd3zE5KZmlmKuhmPBQv8Tsvb3lLOr8EhgYSfZu0HIaK5q7DVBD3GlsMQt
         kAdlZrglucpwQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBHp556BPz4wbj;
        Thu, 27 Jul 2023 14:28:45 +1000 (AEST)
Date:   Thu, 27 Jul 2023 14:28:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the mm tree
Message-ID: <20230727142844.5e00c84d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/knxf8bv5s9EVuVEhzHAGW14";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/knxf8bv5s9EVuVEhzHAGW14
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc allyesconfig)
produced these warnings:

WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+=
0x230 (section: .text.remove_pte_table) -> free_vmemmap_pages (section: .me=
minit.text)
WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+=
0x43c (section: .text.remove_pte_table) -> vmemmap_populated (section: .mem=
init.text)
WARNING: modpost: vmlinux: section mismatch in reference: remove_pte_table+=
0x4a4 (section: .text.remove_pte_table) -> free_vmemmap_pages (section: .me=
minit.text)

Introduced by commit

  25081814314b ("powerpc/book3s64/vmemmap: switch radix to use a different =
vmemmap handling function")

--=20
Cheers,
Stephen Rothwell

--Sig_/knxf8bv5s9EVuVEhzHAGW14
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTB8nwACgkQAVBC80lX
0Gz7Iwf/dVPr247KV/by56JhaTlDMFpCKRjEvLbbGdQsBFwCGhOF1w416pKTAOI5
W1wp7wcNTiZBB26MpBw9dyXyV3RJD44L/SIzYocvC2czRtLHD6k0X4HkwgWSlgH7
v9Qx+2BUpNgpwCLtUXt1Hz0H1e+NQcwnkqImsacbvhEvLD9tGsFf03DblJ43vg/k
E7VzqhOa/V2F5ysmGbNifFBbQIwAMl2NHz15VBtEW14lSpFJ4GLjgfgxEQ9M/zwQ
MrlzO18lY04XD13xRvQvXvOpoGg4MLR3BW4jPb4HLb12hZztQdh0//D6AWMXZVZo
0bD25+lpsG6SeszBbF4shFCHiGEUcw==
=JRLT
-----END PGP SIGNATURE-----

--Sig_/knxf8bv5s9EVuVEhzHAGW14--
