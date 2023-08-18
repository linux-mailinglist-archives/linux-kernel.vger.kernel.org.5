Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE10780E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377856AbjHROuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377867AbjHROuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:50:05 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E9413D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:50:02 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230818144959euoutp014fb4080c55931923d5e87220e7b35404~8gbrYsYW-3134831348euoutp01R
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 14:49:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230818144959euoutp014fb4080c55931923d5e87220e7b35404~8gbrYsYW-3134831348euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1692370199;
        bh=CjU/qhQTydOUlHI0j/2uUeyBVLOWcIBmKDq9tXn1+xs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M1DdXyTzLV7Dvnbn7KJJqNLYszhqL7blODuiYDt8VZBGLBLst5mIMCfcT83/rscac
         1mrZd7VgXPQZD0PSmKPcpCZjRZR4vm4wIDkgxrmMF9BIJwupk3QnCF+0sCjjfSPmyx
         9zllGf5fdWlhGFinVpkf1zQVqTY6tyk0qrDoDhYQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230818144959eucas1p24aa8654603e8c7b03864c2ef8aece9a8~8gbrPMgiJ2361823618eucas1p2L;
        Fri, 18 Aug 2023 14:49:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id DA.24.37758.7158FD46; Fri, 18
        Aug 2023 15:49:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230818144959eucas1p1c654a17ef88c942ee94a84b610254395~8gbq-JB572094420944eucas1p1E;
        Fri, 18 Aug 2023 14:49:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230818144959eusmtrp14472e0e118ffe2ae9811e9f04578693e~8gbq_ce0I2952629526eusmtrp1d;
        Fri, 18 Aug 2023 14:49:59 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-d3-64df8517f8ec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 96.F1.14344.6158FD46; Fri, 18
        Aug 2023 15:49:58 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230818144958eusmtip1da1902e3a7075681c754041b10735a9c~8gbq0hB540871208712eusmtip1q;
        Fri, 18 Aug 2023 14:49:58 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Fri, 18 Aug 2023 15:49:58 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Fri, 18 Aug
        2023 15:49:58 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "Kuan-Ying.Lee@mediatek.com" <Kuan-Ying.Lee@mediatek.com>
Subject: Re: [PATCH] scripts/gdb: fix usage of MOD_TEXT not defined when
 CONFIG_MODULES=n
Thread-Topic: [PATCH] scripts/gdb: fix usage of MOD_TEXT not defined when
        CONFIG_MODULES=n
Thread-Index: AQHZ0eNBX9rllwM+iECjsV0fQmcfpg==
Date:   Fri, 18 Aug 2023 14:49:57 +0000
Message-ID: <ea2xhwnafvuozg2nolqipz66g7eoin4xji5ns3fx5lmlmp64qg@qsbdi2bodulc>
In-Reply-To: <20230801125715.139721-1-cleger@rivosinc.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.67]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <11391DDD29CED24E9F10A87334243533@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djP87rirfdTDDZOELBYeDLZ4t7Nm8wW
        p7o3M1k83tvHbnF51xw2ixsTnjI6sHlsWtXJ5tFycj+Lx41ZER7bT05i8vi8SS6ANYrLJiU1
        J7MstUjfLoEr4+PaPWwFkwUrZrx8x9rAuIKvi5GTQ0LARKLnzmP2LkYuDiGBFYwSU3c2M0M4
        Xxgl9jX3Q2U+M0p0rNzFCtOyad9fRojEckaJvt+LWOCqlmy4zQThnGGU6FmzgwmkRUhgJaPE
        5HfZIDabgKbEvpObwOaKCNxikpjW0McOkhAWiJY49XYbC4gtIhAjcfDdIyYIW09i+aKjYDaL
        gKrEuXnPGEFsXgFfiYn/G8Bu4hSwkrh1bS+YzSggK/Fo5S+wmcwC4hK3nsxngrhbUGLR7D3M
        ELaYxL9dD9kgbB2Js9efMELYBhJbl+5jgbAVJTqO3WSDmKMncWPqFCjbUuLY1i/MELa2xLKF
        r5kh7hGUODnzCTgoJAT2c0pMfPsL6CAOIMdFYv6mZIiZwhKvjm9hh7BlJE5P7mGZwKg9C8mp
        s5Csm4Vk3Swk62YhWbeAkXUVo3hqaXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYFo6/e/41x2M
        K1591DvEyMTBeIhRgoNZSYTXguleihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6Ykl
        qdmpqQWpRTBZJg5OqQYmxWcbe6bvvtlRzN8/Za7Mby+zH50TXfdvDbge+3n7Ey87gWOBLQuV
        lbjiL2h+6m+Yd5n99+a+3fmPTySxlgiwPPb9XfXhaacMg07yBm/pLa/nGy0zuO63mTGlIeeN
        tbmmY8l79R3t7YUXRdZrOh964ycz/0751+6FBt43/y9frLrp+reFARf2uIvoT02onGG2W1Mx
        9Fl+7szm7/fvZl/p8q2qur1Q9Nasa5FrLLN4Ei3cV312+e77deOb5fwHTX+3X76dKLDjWqWk
        4ELeRrG2c0drHmelndwml+hnKJifOPPOzqe/rqfZ3FiZ4PB6zvPtZQFrnCdO+vagoNnc3sz6
        9SyXlRqnH/Tt2vi7cfbPECWW4oxEQy3mouJEAHnQX866AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsVy+t/xu7pirfdTDOb/t7ZYeDLZ4t7Nm8wW
        p7o3M1k83tvHbnF51xw2ixsTnjI6sHlsWtXJ5tFycj+Lx41ZER7bT05i8vi8SS6ANUrPpii/
        tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEv4+PaPWwFkwUr
        Zrx8x9rAuIKvi5GTQ0LARGLTvr+MXYxcHEICSxkl/l27ygSRkJHY+OUqK4QtLPHnWhcbRNFH
        RomdT14zQzhnGCWu905kh3BWMkocvjQJrIVNQFNi38lNYAkRgVtMEtMa+thBEsIC0RKn3m5j
        AbFFBGIklkw4DGXrSSxfdBRsN4uAqsS5ec8YQWxeAV+Jif8bwIYKCVhKzJ47EayeU8BK4ta1
        vWBxRgFZiUcrf4HNZxYQl7j1ZD7UDwISS/acZ4awRSVePv4H9Y+OxNnrTxghbAOJrUv3sUDY
        ihIdx26yQczRk7gxdQqUbSlxbOsXZghbW2LZwtfMELcJSpyc+YRlAqP0LCSrZyFpn4WkfRaS
        9llI2hcwsq5iFEktLc5Nzy020itOzC0uzUvXS87P3cQITC7bjv3csoNx5auPeocYmTgYDzFK
        cDArifBaMN1LEeJNSaysSi3Kjy8qzUktPsRoCgy7icxSosn5wPSWVxJvaGZgamhiZmlgamlm
        rCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAZP12haD4J6OQKR+qZizi3Llr6cTTL/i2zEuy
        kZp93kbx8tsE1Q7TWTzW+j/XpZRN9VquWPTe75zCmmfKk2e+3uW2o/hZgW66cUSw+dtTLrqb
        Xrz1ba7ft+WsgeDGHR4vxeRMJLonXVO6H5LUfEHrDY+D5DPPT6771i1gfBKwx+w1c/WLt7vZ
        Hlk7/f+m4sV06+y2z7ySqTMnvzz6fsGdqcHnmB8ouB/6f3H5Qsc6+ckhuhP6HUI3GTjMFzh8
        KWGpq7SiwHqTV/4+BedCGhdbzzzmYeNx4b/RWUHjKY//1e06/fzTasECHdV25TB21bKK1k+3
        FwTW/919ZFmS0ctO44SiDRN/tF3iO2rXGCz4X0iJpTgj0VCLuag4EQDrbK16twMAAA==
X-CMS-MailID: 20230818144959eucas1p1c654a17ef88c942ee94a84b610254395
X-Msg-Generator: CA
X-RootMTR: 20230818144959eucas1p1c654a17ef88c942ee94a84b610254395
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230818144959eucas1p1c654a17ef88c942ee94a84b610254395
References: <20230801125715.139721-1-cleger@rivosinc.com>
        <CGME20230818144959eucas1p1c654a17ef88c942ee94a84b610254395@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Aug 01, 2023 at 02:57:15PM +0200, Cl=E9ment L=E9ger wrote:
> MOD_TEXT is only defined if CONFIG_MODULES=3Dy which lead to loading fail=
ure
> of the gdb scripts when kernel is built without CONFIG_MODULES=3Dy:
>
> Reading symbols from vmlinux...
> Traceback (most recent call last):
>   File "/foo/vmlinux-gdb.py", line 25, in <module>
>     import linux.constants
>   File "/foo/scripts/gdb/linux/constants.py", line 14, in <module>
>     LX_MOD_TEXT =3D gdb.parse_and_eval("MOD_TEXT")
>                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> gdb.error: No symbol "MOD_TEXT" in current context.
>
> Add a conditional check on CONFIG_MODULES to fix this error.
>
> Fixes: b4aff7513df3 ("scripts/gdb: use mem instead of core_layout to get =
the module address")
> Signed-off-by: Cl=E9ment L=E9ger <cleger@rivosinc.com>

I've hit the same issue. After rebasing onto next-20230818 we'd need:

diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constant=
s.py.in
index e3517d4ab8ec..04c87b570aab 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -66,10 +66,11 @@ LX_GDBPARSED(IRQD_LEVEL)
 LX_GDBPARSED(IRQ_HIDDEN)

 /* linux/module.h */
-LX_GDBPARSED(MOD_TEXT)
-LX_GDBPARSED(MOD_DATA)
-LX_GDBPARSED(MOD_RODATA)
-LX_GDBPARSED(MOD_RO_AFTER_INIT)
+if IS_BUILTIN(CONFIG_MODULES):
+    LX_GDBPARSED(MOD_TEXT)
+    LX_GDBPARSED(MOD_DATA)
+    LX_GDBPARSED(MOD_RODATA)
+    LX_GDBPARSED(MOD_RO_AFTER_INIT)

 /* linux/mount.h */
 LX_VALUE(MNT_NOSUID)

Tested-by: Daniel Gomez <da.gomez@samsung.com>

> ---
>  scripts/gdb/linux/constants.py.in | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/consta=
nts.py.in
> index 50a92c4e9984..866015547b38 100644
> --- a/scripts/gdb/linux/constants.py.in
> +++ b/scripts/gdb/linux/constants.py.in
> @@ -63,7 +63,8 @@ LX_GDBPARSED(IRQD_LEVEL)
>  LX_GDBPARSED(IRQ_HIDDEN)
>
>  /* linux/module.h */
> -LX_GDBPARSED(MOD_TEXT)
> +if IS_BUILTIN(CONFIG_MODULES):
> +    LX_GDBPARSED(MOD_TEXT)
>
>  /* linux/mount.h */
>  LX_VALUE(MNT_NOSUID)
> --
> 2.40.1
>
>=
