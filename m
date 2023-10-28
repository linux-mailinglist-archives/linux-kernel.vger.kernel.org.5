Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5D97DA977
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 23:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjJ1VPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 17:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjJ1VPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 17:15:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5CD3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 14:15:45 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231028211541euoutp02f1dc9bf1023b37670a2e824c588a4497~SYfts7iri0890208902euoutp02B
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 21:15:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231028211541euoutp02f1dc9bf1023b37670a2e824c588a4497~SYfts7iri0890208902euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1698527742;
        bh=KNdASYDMYBghyPawUeQa4sXu1VB/4Vbh5nAWx6WaBVc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZLWeBmucv0Oqp5FVNZ1256i7Nau+MKaSRCmVJEvIN4n1DmLuzP3y+mJ1Qzs2ef7Ba
         hRaanL6Rh48FJR005wLAKdyE1x1cENtE3OJ9Wau4AEd2jD8dn9f6HMEdO8OjX3IzLm
         9fnXU9R7QOJIw5xEfP/e+YmKw9aA10dB5vLEH6gY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231028211541eucas1p2956f217a1965e3854c430386af01e412~SYfs9xZLz1224812248eucas1p24;
        Sat, 28 Oct 2023 21:15:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 2B.81.42423.DF97D356; Sat, 28
        Oct 2023 22:15:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad~SYfslkcX60616106161eucas1p1P;
        Sat, 28 Oct 2023 21:15:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231028211540eusmtrp2885c51cf5903a19a29a6bef124f4dabc~SYfslCIHP1141411414eusmtrp2a;
        Sat, 28 Oct 2023 21:15:40 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-be-653d79fdc682
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EC.F0.25043.CF97D356; Sat, 28
        Oct 2023 22:15:40 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231028211540eusmtip266e8e32a92786e265d14e5903bc6464c~SYfsYR64B1182011820eusmtip2o;
        Sat, 28 Oct 2023 21:15:40 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) by
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) with Microsoft SMTP
        Server (TLS) id 15.0.1497.2; Sat, 28 Oct 2023 22:15:40 +0100
Received: from CAMSVWEXC02.scsc.local ([::1]) by CAMSVWEXC02.scsc.local
        ([fe80::3c08:6c51:fa0a:6384%13]) with mapi id 15.00.1497.012; Sat, 28 Oct
        2023 22:15:39 +0100
From:   Daniel Gomez <da.gomez@samsung.com>
To:     "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hughd@google.com" <hughd@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
Subject: [RFC PATCH 03/11] shmem: drop BLOCKS_PER_PAGE macro
Thread-Topic: [RFC PATCH 03/11] shmem: drop BLOCKS_PER_PAGE macro
Thread-Index: AQHaCePme5B6ldUfmUi6e3JGjkM9rA==
Date:   Sat, 28 Oct 2023 21:15:39 +0000
Message-ID: <20231028211518.3424020-4-da.gomez@samsung.com>
In-Reply-To: <20231028211518.3424020-1-da.gomez@samsung.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [106.110.32.103]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djP87p/K21TDU7tYLeYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/gEpvTHjKaLHs63t2i90bF7FZ/P4x
        h82B12N2w0UWjwWbSj02r9DyuHy21GPTqk42j02fJrF7nJjxm8Xj8ya5AI4oLpuU1JzMstQi
        fbsErowT+zkLfrJWnJw+kamB8RtLFyMnh4SAicSLF4/YQWwhgRWMEvuOpXYxcgHZXxglrh6Z
        xwbhfGaUWPPoGzNMR8uvfVCJ5YwSNxa1s8JVNRyYwQ7hnGGUuPLxKNTglYwS8x5EgNhsApoS
        +05uAisSEZjNKnF4cQcjSIJZoE5izbNZQFdxcAgL2Egc3GYGEhYRcJR4en4RO4StJ/H15A8m
        EJtFQFXi99yVTCDlvALWEpPXSoCEOYE673/bzgZiMwrISjxa+YsdYrq4xK0n85kgPhCUWDR7
        D9Q3YhL/dj1kg7B1JM5ef8IIYRtIbF26DxpGShJ/OhZCXakncWPqFDYIW1ti2cLXYHN4gWae
        nPmEBeQtCYF/nBINa+9CNbtIXFn1BMoWlnh1fAs7hC0j8X/nfKYJjNqzkNw3C8mOWUh2zEKy
        YwEjyypG8dTS4tz01GLDvNRyveLE3OLSvHS95PzcTYzAtHb63/FPOxjnvvqod4iRiYPxEKME
        B7OSCC+zo02qEG9KYmVValF+fFFpTmrxIUZpDhYlcV7VFPlUIYH0xJLU7NTUgtQimCwTB6dU
        A5P9jDmlq4+837ha/eB1m4PF6iKbuHkWFNexrXP3Z8wtsTeSKZ+/zU5SSqfFdu7qRvdwR7M0
        M6OYuxlPlOVe+T19+2QhR07OKw5urZUKNktXp/y96zb1sljVDHXZ52aX3wizGZTVn/2zZMbR
        e2fnLtwzUXPZg8XCPF5frqlPYdiQ+5qb7cKtTRMn6zR/+pu35NjfiJvnxISentZ/p65gueiY
        V5Gowr8Wpx52/h6eMNO7jMZm9wOmTDI+dLt+9t2X5+66zHti6VUz74L6fab5dhmdZ8793H8/
        e2GtQsjWHGmZ2x1VIZHfvi6ZFPT61eZoO1v5nlndRyZuMrmtKSRYO0V73e6vGXZbJgtXHN1Z
        oZauxFKckWioxVxUnAgApQsA0toDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsVy+t/xe7p/Km1TDR5sU7eYs34Nm8Xqu/1s
        Fpef8Fk8/dTHYrH3lrbFnr0nWSwu75rDZnFvzX9Wi11/drBb3JjwlNFi2df37Ba7Ny5is/j9
        Yw6bA6/H7IaLLB4LNpV6bF6h5XH5bKnHplWdbB6bPk1i9zgx4zeLx+dNcgEcUXo2RfmlJakK
        GfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZJ/ZzFvxkrTg5fSJT
        A+M3li5GTg4JAROJll/72LoYuTiEBJYySry/NY8dIiEjsfHLVVYIW1jiz7UuqKKPjBJLWx6x
        QjhnGCUOX2xihnBWMkqcmrYJrJ1NQFNi30kQm4tDRGA2q8ThxR2MIAlmgTqJNc9mAS3n4BAW
        sJE4uM0MJCwi4Cjx9PwidghbT+LryR9MIDaLgKrE77krmUDKeQWsJSavlQAxhQRyJfrbMkEq
        OIGG3P+2nQ3EZhSQlXi08hc7xCJxiVtP5jNBPCAgsWTPeWYIW1Ti5eN/UI/pSJy9/oQRwjaQ
        2Lp0HzRUlCT+dCyEOlhP4sbUKWwQtrbEsoWvwebwCghKnJz5hGUCo/QsJOtmIWmZhaRlFpKW
        BYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQJT07ZjP7fsYFz56qPeIUYmDsZDjBIczEoi
        vMyONqlCvCmJlVWpRfnxRaU5qcWHGE2BITSRWUo0OR+YHPNK4g3NDEwNTcwsDUwtzYyVxHk9
        CzoShQTSE0tSs1NTC1KLYPqYODilGpjanh3aXWR/1vyIa8aCFQWvODaEeT03c1qTtiH4vPMW
        rjtHjl1Q/ldeGmXc+3enwCFH38jZUfM1BFJvejecLP7woI+FWZqjMCH1S2PZNlZpL7c+jud+
        JpW+vdveB4S7Np4tauIp40kpZJocnR/Gd8laT2itR6Ob/UEtgcveSV2LTmd9MM4NMOJ2DwnN
        CZ6dPVFXbMEp9RmvhGKCPBu6/0x0Dc80TdZPbXiqGbJ7vc5bG5/nMfr6+7vfZzYs9xIwFAxQ
        nbFtc85Mw6+Hbl4W5G8oXPxrfvDhreF1/oFnfod13DmZuW+l5Ld57JW6OnOOvPvWppnGlhvA
        HRHjuCWzvHsOR/6/1p1RUSnmO3cosRRnJBpqMRcVJwIAW8mX/9YDAAA=
X-CMS-MailID: 20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad
X-Msg-Generator: CA
X-RootMTR: 20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad
References: <20230919135536.2165715-1-da.gomez@samsung.com>
        <20231028211518.3424020-1-da.gomez@samsung.com>
        <CGME20231028211540eucas1p1fe328f4dadd3645c2c086055efc872ad@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit [1] replaced all BLOCKS_PER_PAGE in favor of the
generic PAGE_SECTORS but definition was not removed. Drop it
as unused macro.

[1] e09764cff44b5 ("shmem: quota support").

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/shmem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0d1ce70bce38..a2ac425b97ea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -84,7 +84,6 @@ static struct vfsmount *shm_mnt __ro_after_init;
=20
 #include "internal.h"
=20
-#define BLOCKS_PER_PAGE  (PAGE_SIZE/512)
 #define VM_ACCT(size)    (PAGE_ALIGN(size) >> PAGE_SHIFT)
=20
 /* Pretend that each entry is of this size in directory's i_size */
--=20
2.39.2
