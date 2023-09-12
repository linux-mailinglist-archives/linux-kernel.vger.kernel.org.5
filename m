Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5E479C62F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 07:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjILFKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 01:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjILFKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 01:10:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A031D196;
        Mon, 11 Sep 2023 22:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1694495413;
        bh=glWOjUc0hn5q6xO6l8MkJNC9mO4fwGHMjXu78jbZalg=;
        h=Date:From:To:Cc:Subject:From;
        b=ELesDpI7LS+HdTYlW5pb8MIqhQGiL4b+3V5YLQ2Pfn82gpYiXeXNzRd0r1VUoBB5u
         XWiC59Uet2ux4fgyKak57Mweax2WadrT5Xz+75HFjarnPasL5IkWR65Ls1bl61SpUJ
         4fUyQ/D3RCzzDudS+THUN1Gvn3ZGq+SAVeeVapycSEdpCJkLWGtaAOLpIoVftkVSYj
         4ceQKaDY80gk1pCIPvnb3sq4o8HjklFKh9sO/Dy491wB1HLCOOhifxKEwFhPPyNqvo
         Rl3KK1yloynfYbwqPcnkWdTcm5mkq9Qohm+OW0QZstoyU9qw/mtK57AP8vtd5gVtRA
         zqIU8E9i4lufQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RlBVF1RTwz4wxQ;
        Tue, 12 Sep 2023 15:10:13 +1000 (AEST)
Date:   Tue, 12 Sep 2023 15:10:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the wireless-next tree
Message-ID: <20230912151012.6aceecfe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eyUR3_H9xTxVSKZhnnAcI2R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eyUR3_H9xTxVSKZhnnAcI2R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the wireless-next tree, today's linux-next build (htmldocs)
produced this warning:

include/net/cfg80211.h:5940: warning: expecting prototype for wiphy_delayed=
 work_flush(). Prototype was for wiphy_delayed_work_flush() instead

Introduced by commit

  56cfb8ce1f7f ("wifi: cfg80211: add flush functions for wiphy work")

--=20
Cheers,
Stephen Rothwell

--Sig_/eyUR3_H9xTxVSKZhnnAcI2R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmT/8rQACgkQAVBC80lX
0Gw7qwf+LwclGtSJCKkXXmgYKMQniwz1pMHtDQ3I1bkHmbJHDKfEKZbQP82qv0t4
y/pwZkLpr0y5S16vbaLcTfH8M7Bcyw8Pv91w9KUcg9QjVnaCSdl63fWkvQSOdnq0
qm8zuNGkXiX344pKJexSM7n/4MhRKAqE+qGDdAeYCbQNA0O6XqXCdVpkTZPXjlGA
5mzxbyaP7DjwM5R5E+d+QO9k5neW9crivL9Nbl3s5XJmYpAm+tG3d9UgOF2FNlqy
WgzCc3Fy4W78g4Ck1GYYBRF7CTAD9qKZv4HTAheOlYsLaSSmzD0AynlsKUBit1h2
GVvrinmS2mLF5LC98ikentg4LLGUYw==
=EvOi
-----END PGP SIGNATURE-----

--Sig_/eyUR3_H9xTxVSKZhnnAcI2R--
