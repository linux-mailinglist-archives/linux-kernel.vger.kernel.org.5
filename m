Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561857AD98F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjIYNvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjIYNvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:51:19 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1FD19A;
        Mon, 25 Sep 2023 06:51:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230925135109euoutp0299c3011b0cca9e6e2e2fb86b0f57fae0~IKJKFWApT3185031850euoutp02G;
        Mon, 25 Sep 2023 13:51:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230925135109euoutp0299c3011b0cca9e6e2e2fb86b0f57fae0~IKJKFWApT3185031850euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695649869;
        bh=EPOLYQG8jgxiyRlhsiVPOJllFsGe8d/gNd6w6Dh7vp4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=B3OhQx0BklXMhq+BlKMS/3zUq6wwer/ft3FE0afTbJ1fChCR9W+0+KOQUVvULHnbg
         i1UG4rtXYXiTzXVcsVCit+sWYkP/Xx36Dae35YwHcqP0YKA3X/IQa9ZprjAeLxCQvu
         bpWu591/Rhz05gBAUCl42eWKr4MCqfAOIXkSGkx4=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230925135109eucas1p1af38580534e7b9527cba0bfba564c665~IKJJ4PyJH0750107501eucas1p10;
        Mon, 25 Sep 2023 13:51:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DC.EC.11320.D4091156; Mon, 25
        Sep 2023 14:51:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230925135108eucas1p11c3f859adc220afa3145df0344c96b12~IKJJkBJVJ1563815638eucas1p1c;
        Mon, 25 Sep 2023 13:51:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230925135108eusmtrp2bc170023cc09e3752711d82c2b97cf02~IKJJjdRM52909529095eusmtrp2k;
        Mon, 25 Sep 2023 13:51:08 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-9b-6511904dcf4d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E1.AD.14344.C4091156; Mon, 25
        Sep 2023 14:51:08 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230925135108eusmtip1bfde61e75be71535d0a048cedaee0001~IKJJYi0bU2516725167eusmtip13;
        Mon, 25 Sep 2023 13:51:08 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 25 Sep 2023 14:51:08 +0100
Date:   Mon, 25 Sep 2023 15:51:31 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the sysctl tree with the
 asm-generic tree
Message-ID: <20230925135131.6nbgnahnlm2vttc4@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="qxu3dkszgsgmsktm"
Content-Disposition: inline
In-Reply-To: <20230921115034.5461f62f@canb.auug.org.au>
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87q+EwRTDTYf5bL4+eU9o8XfScfY
        LS7vmsNmcXBhG6PFjQlPGS227r3K7sDm8fvXJEaPxhs32Dw2repk8/i8SS6AJYrLJiU1J7Ms
        tUjfLoErY8naH0wFu/kr2jfcZWpgnMfbxcjJISFgIjHn+l42EFtIYAWjxPrXsRD2F0aJtj9M
        EPZnRokrt9lg6r+82QVkcwHFlzNKfFi4EaHo12YDiMQWRomp546ygCRYBFQl7nycwQxiswno
        SJx/cwfI5uAQEdCWOPBbAKSeWeA+UP3K6WAbhAVCJB69egs2lFfAXKKxYz0rhC0ocXLmE7CZ
        zAIVEgevTmIBmcMsIC2x/B8HSJgTqLzl9BRmiEOVJL6+6WWFsGslTm25xQSyS0KgnVNi1/HZ
        TBAJF4m7s3qgbGGJV8e3sEPYMhL/d86HapjMKLH/3wd2CGc1o8Syxq9QHdYSLVeesINcISHg
        KHHrliCEySdx460gxJ18EpO2TWeGCPNKdLQJQTSqSay+94ZlAqPyLCSfzULy2SyEzyDCOhIL
        dn9iwxDWlli28DUzhG0rsW7de5YFjOyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPW
        6X/Hv+xgXP7qo94hRiYOxkOMKkDNjzasvsAoxZKXn5eqJML76xlfqhBvSmJlVWpRfnxRaU5q
        8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5OqQYmcyHpU3pZSypizbf8njxBWE55D/93
        5zC38/bJhoyimyKzZrBkNLGpRAr4L2oLyWxXefI85trjoL2sERdf982+uJmjN5JFf8bFBrmY
        S/8ClfPfnDhaX6GyYoUTz/n83JZTx4L/3eOVjwope7Xo116J5SI3Rbm1hRdv++ryvKnqyLmf
        oa1XDmSf3uytX3T5I8PinUY/rvzwPGSgPX16wttjkSaGtRd8w7sLDEvYrE4faa4zuq6WHSEa
        9IZb5lvJp7+dalulD9xzjSk7I8BUciB1190Xf3ckm/W3vbmxtqPXPXviUr5fc/yDsw1OuWh9
        vMnHOuvu1a/T1zmYtV40P8N1+clvU51esaC703O9S6SUWIozEg21mIuKEwE+oMuq0wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsVy+t/xu7o+EwRTDZ5eNbL4+eU9o8XfScfY
        LS7vmsNmcXBhG6PFjQlPGS227r3K7sDm8fvXJEaPxhs32Dw2repk8/i8SS6AJUrPpii/tCRV
        ISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvY0/LOvaCnfwV/5+X
        NjDO4e1i5OSQEDCR+PJmF1sXIxeHkMBSRoldk2awQSRkJDZ+ucoKYQtL/LnWBVX0kVHi4YRW
        RghnC6PE4SmvwDpYBFQl7nycwQxiswnoSJx/cwfI5uAQEdCWOPBbAKSeWeA+o8SedQfB6oUF
        QiTaDs8Ds3kFzCUaO9azQgztYpRY+nEPVEJQ4uTMJywgNrNAmcS+L41sIEOZBaQllv/jAAlz
        AvW2nJ7CDHGpksTXN71QV9dKfP77jHECo/AsJJNmIZk0C2ESRFhL4sa/l0wYwtoSyxa+Zoaw
        bSXWrXvPsoCRfRWjSGppcW56brGRXnFibnFpXrpecn7uJkZg9G479nPLDsaVrz7qHWJk4mA8
        xKgC1Plow+oLjFIsefl5qUoivL+e8aUK8aYkVlalFuXHF5XmpBYfYjQFhuJEZinR5HxgWskr
        iTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCKjF0v/G6dr+1HpVPL
        l9xdrPA8oPJcaKOURzCHPB9/7ibXD/HLDuR9W5qactBL4gPXDIHQP3Y7a778TQt3YO4ym+8z
        6Ynep9c9T+oeLJNrY3Vm+XW21mfOWdkbUjzF155dLJ59Q3uj5nnlvEu8kVc0T9acZY94fPd9
        mouTYt2s5w2hHNyX3DsjtPceNmgLZTrluHid+BaXlXPLpm+++ZRfkm1H4m+R1WLJqy8W8Wco
        zu2c/WfFeiuppluxrwp3eb4KEiu/zj7ZMXvxO1dlj+vKis9SAi0dX2TPc07Yc9f6XszzrEcd
        jm+3ltp9TQ3u6VBlCH+ym1NL9MIL7U9t3T1BEncufbmzymT2612a5qpKLMUZiYZazEXFiQC6
        d5u3cwMAAA==
X-CMS-MailID: 20230925135108eucas1p11c3f859adc220afa3145df0344c96b12
X-Msg-Generator: CA
X-RootMTR: 20230921015042eucas1p1f8658fd99d9e7befc3926bb71d917c86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230921015042eucas1p1f8658fd99d9e7befc3926bb71d917c86
References: <CGME20230921015042eucas1p1f8658fd99d9e7befc3926bb71d917c86@eucas1p1.samsung.com>
        <20230921115034.5461f62f@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--qxu3dkszgsgmsktm
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 11:50:34AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the sysctl tree got a conflict in:
>=20
>   arch/ia64/kernel/crash.c
>=20
> between commit:
>=20
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>=20
> from the asm-generic tree and commit:
>=20
>   d2f2ef357794 ("ia64: Remove now superfluous sentinel element from ctl_t=
able array")
This is part of the sysctl work to remove sentinel. I wont take any
actio as Luis has already removed it.

Best

>=20
> from the sysctl tree.
>=20
> I fixed it up (I removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell



--=20

Joel Granados

--qxu3dkszgsgmsktm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmURkGMACgkQupfNUreW
QU9xcwwAjJUpi9vqmuyGpjFq95neNtVUwpYtVXBHHWpMXmcQw/TJf2KKjrhqxsua
3vvST1I2YCNPzZfT7tJsUOd5wnGJnd+0EO2lZNMwyOPgZ2oftkdUZ5963XqWb6jW
KXW06FHpLybw2hFicj6bm2MRDL2PorxKXJBppayjhsuCGi+sRv3f6vEpDZwINp9S
XSyz9u56jAiITD31EgzYE6oz/S/XgVuUbkVX9IgdDrq0wJBz3B4smNl9YuEaKuXL
crkDSXQlRMvBMgYOK0vvINNJnHNwOvE8ekEHiz6gRbWSIIRUm+Q9B73dzCs/Fzkh
pIuV1wrN5zY02hObRA9cTTwKkewOGweQBF41eC/qRfgwSQjtQi5QkgsarNuW+ro3
bmfPjQUZESVyDuFC9HRF9o/N2dE2NBf7l6l4p/SVXD3tuwMXdDJeInSGANbMfpnb
veOZK30PL1UTqXHttJEs71tywIFduvlTP16OhtrmAJCBggzaUWNWgkViHi69XBQg
45GCuh1u
=uRHJ
-----END PGP SIGNATURE-----

--qxu3dkszgsgmsktm--
