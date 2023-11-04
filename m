Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57FA67E0CF9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 02:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjKDBAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjKDBAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:00:48 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9B1E3
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:00:45 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231104010044euoutp012ae2820a101934f25309d479c67208d7~URb6Tnk9q2259822598euoutp01E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 01:00:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231104010044euoutp012ae2820a101934f25309d479c67208d7~URb6Tnk9q2259822598euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1699059644;
        bh=FSfu3VIgYlelBUabVns28tD9SOY5isCdTKAtLtrt1Go=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Bjdl3r12Mzx/uVpRe8Lz8CeLnrP6ELLYLY4DPoUU/hRBY8YZArFqUyZC0zNx4gyzO
         YZbpx4JjeSU1KNBCIxeMHHVg66KSwio+R4buPDkom0q2Xoeex1sVf/nfyDK+5k73Zg
         A7etxKXUIIL8rx9t7Niz4TapW0jicPLlUcGkOaAE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231104010043eucas1p232ef4a8af3460370e079d84a119aa31e~URb5UtJn71175811758eucas1p2o;
        Sat,  4 Nov 2023 01:00:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 05.01.11320.AB795456; Sat,  4
        Nov 2023 01:00:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231104010041eucas1p2369aea5ef1182bea53989b43ea07049e~URb4FVa8x1422314223eucas1p2G;
        Sat,  4 Nov 2023 01:00:41 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231104010041eusmtrp2b4e6a0fa0b6269cf1442ebdbceafd9bb~URb4E12tj0448904489eusmtrp2D;
        Sat,  4 Nov 2023 01:00:41 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-9c-654597ba315b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D3.08.25043.9B795456; Sat,  4
        Nov 2023 01:00:41 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231104010041eusmtip1c148440ee14cb3f5f163ee99fa761a11~URb33BOgG2932029320eusmtip1x;
        Sat,  4 Nov 2023 01:00:41 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Sat, 4 Nov 2023 01:00:40 +0000
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 4 Nov
        2023 01:00:40 +0000
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "willy@infradead.org" <willy@infradead.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH 0/2] XArray multi-index tests
Thread-Topic: [PATCH 0/2] XArray multi-index tests
Thread-Index: AQHaDrnumPQICHUIPEiQzctipV++ibBpVzIA
Date:   Sat, 4 Nov 2023 01:00:40 +0000
Message-ID: <20231104010038.cdtyty5mpn2fxmrz@sarkhan>
In-Reply-To: <20231104005747.1389762-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45F23D0FF5F6ED4FAEE0D6FA0FF7331F@scsc.local>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzned3d011TDb59Zra4vGsOm8WNCU8Z
        LX7/mMPmwOyxeYWWx6ZVnWwenzfJBTBHcdmkpOZklqUW6dslcGV8XLWNpeA9d8XbE4uZGhhP
        cXYxcnJICJhI9Fx4yNbFyMUhJLCCUeLquzYWCOcLo0TzovtQzmdGiT9H7jPDtHzZeYwNxBYS
        WM4osbJXHq5o+edeqFmnGSXevH/NClEFNPhVvx+IzSagKbHv5CZ2EFtEQF9i5aWzjCANzAKH
        GSVmLtzAApIQFjCUmDP9M5DNAVRkJLH3qDVEvZHEs6/nwDazCKhITGxfD3YRr4CpxMRFnUwg
        NqeAjcSe1evB5jMKyEo8WvkLzGYWEJe49WQ+E8QHghKLZu+B+kZM4t+uh2wQto7E2etPGCFs
        A4mtS/exQNhKEn86FjJCzNGRWLD7ExuEbSnR9bEXytaWWLbwNdQ9ghInZz4BB52EwHJOiY/f
        +1ghBrlIbJ7wG2qxsMSr41vYJzDqzEJy3ywkO2Yh2TELyY5ZSHYsYGRdxSieWlqcm55abJSX
        Wq5XnJhbXJqXrpecn7uJEZhkTv87/mUH4/JXH/UOMTJxMB5ilOBgVhLhdfR2SRXiTUmsrEot
        yo8vKs1JLT7EKM3BoiTOq5oinyokkJ5YkpqdmlqQWgSTZeLglGpgmpJddL219ePl2qtVS/qC
        /s+eK/5fYVrz3neGDyuXOzA2Lr/Kq3vsemLcrg93a5/4/g8IsZUXKZ41w03XNmHu1q/8Txkj
        nk+J3FMy1W/3N3E7l6brGabTfQpi3p4JkSuIYus5vvuco8q2KY2K1+P4CmYvjede+dT203OJ
        v+ft75iE7D57XTf3qsj2wNKXko9fZf29u+utcPca5cbjNg0LGxQ4rvS16k8+c8y+c/kUS3Gu
        P+6lPRIbP3/Unv+810H/+vZanUnm3EufLD68RpFjk56k7+xbvZe6DW7fm/7R1iPxkLnj8V8s
        +br6O5dIpIaqh+vP/7AziTO6fPcCj/MKGe2ViSvWsIUrLgk6sUvrlhJLcUaioRZzUXEiAJjb
        vWyhAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsVy+t/xu7o7p7umGpx7pmNxedccNosbE54y
        Wvz+MYfNgdlj8wotj02rOtk8Pm+SC2CO0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2
        j7UyMlXSt7NJSc3JLEst0rdL0Mv4uGobS8F77oq3JxYzNTCe4uxi5OSQEDCR+LLzGFsXIxeH
        kMBSRokHJ98yQyRkJDZ+ucoKYQtL/LnWBVX0kVHiyulbTBDOaUaJeds6mUCqhARWMEpsbsoD
        sdkENCX2ndzEDmKLCOhLrLx0lhGkgVngMKPEzIUbWEASwgKGEnOmfwayOYCKjCT2HrWGqDeS
        ePb1HBuIzSKgIjGxfT3YRbwCphITF8Hsspb43n4AzOYUsJHYs3o92C5GAVmJRyt/gdnMAuIS
        t57MZ4L4QEBiyZ7zUJ+JSrx8/A/qMx2Js9efMELYBhJbl+5jgbCVJP50LGSEmKMjsWD3JzYI
        21Ki62MvlK0tsWzha6jbBCVOznzCMoFRZhaS1bOQtM9C0j4LSfssJO0LGFlXMYqklhbnpucW
        G+kVJ+YWl+al6yXn525iBCaQbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4Hb1dUoV4UxIrq1KL
        8uOLSnNSiw8xmgLDbiKzlGhyPjCF5ZXEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRmp6YW
        pBbB9DFxcEo1MAU25KUqn05Qs38w63XdNKPotRarJrUk22Vr2fjN0rWszZyw18z0zHPdvtkF
        dvszJ+5lK5E7vrxsmgAHf63p/sU6K5T3LzVOvJPu+EOSQVtV/vPHX5Mje3maFLzOvbgT/uqb
        71JJQcVfHnYLEp9e/8fknDjNqeHu1i1sey1nbplw7ca5jw+Pcm5TXlpk0BdmzdY0OdF/6VX/
        sDcmrz+94FLia+M+8/bnatewK9v/3pgp+kJzrfqi2iB/9slKTqeKrf7EfcjzOpQxKXW1DZ8D
        08GZ87ddqJXZcU58c5zETpUnNivnuOy9mb5pk+/0W1vN1faoG+RFSl2e/y+0mEX8fPYHnp5H
        vpFhG7e66Z38yaXEUpyRaKjFXFScCADwqvu2qQMAAA==
X-CMS-MailID: 20231104010041eucas1p2369aea5ef1182bea53989b43ea07049e
X-Msg-Generator: CA
X-RootMTR: 20231104010041eucas1p2369aea5ef1182bea53989b43ea07049e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231104010041eucas1p2369aea5ef1182bea53989b43ea07049e
References: <20231104005747.1389762-1-da.gomez@samsung.com>
        <CGME20231104010041eucas1p2369aea5ef1182bea53989b43ea07049e@eucas1p2.samsung.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2023 at 01:57:45AM +0100, Daniel Gomez wrote:
> Add multi-index XArray tests.
>
> Tests were first introduced as part of '[RFC PATCH 00/11] shmem: high
> order folios support in write path' [1]. I've created this new series wit=
h
> Matthew Wilcox's feedback [2] regarding test 'XArray: add cmpxchg order t=
est'.
>
> [1] https://lore.kernel.org/all/20231028211518.3424020-1-da.gomez@samsung=
.com/
> [2] https://lore.kernel.org/all/ZT68dBiJKNLXLRZA@casper.infradead.org/
>
> The full node is lost (not only the order) when using xa_cmpxchg with NUL=
L
> entry. Adding another (FIVE) entry at '1 << order' with the order informa=
tion
> does not keep the original node but duplicates it. I'm not sure if that's
> the intention from the proposal you mentioned in [2] but please, let me k=
now
> your comments.
>
> Changes since RFC:
> * Update cmpxchg test to include another entry at 1 << order that
> 'keeps' the node around and order information.
> * Update cmpxchg test to verify the entries and order in all tied
> indexes.
> * Drop previous Luis Chamberlain's review as changes are significant
> from the RFC.
* Make cmpxchg_order test conditional to CONFIG_XARRAY_MULTI.

>
> Daniel
>
> Daniel Gomez (1):
>   XArray: add cmpxchg order test
>
> Luis Chamberlain (1):
>   test_xarray: add tests for advanced multi-index use
>
>  lib/test_xarray.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 188 insertions(+)
>
> --
> 2.39.2=
