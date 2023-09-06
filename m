Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC17933B3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbjIFCTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjIFCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:19:20 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050851A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 19:19:16 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230906021911epoutp04f8bccc2efb59adca75ff03c9332572e1~CLckyAwhO0592405924epoutp04q
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:19:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230906021911epoutp04f8bccc2efb59adca75ff03c9332572e1~CLckyAwhO0592405924epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693966752;
        bh=FcJBi9rHHQS0PibJX6niGmezArkc4jnoWMaw+AO0YsM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=l7U1/LcDlU2DmJSYnbrqhniMWhp+v1+DdBjaddNOW5oyXqbN0jhsBK98sWfhHmYOs
         finWOZ/SWMArzE0JJVEx2HuR2dBAtt4hg3grbu2VMtAg28KQpMzQjP8NPLkO7KVQ//
         imC5zzKm/J3XlIFTdLknDz8T2ruaZWz1BzFnSAwk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230906021911epcas1p256d36f11583a7c74c5bed56214fadf93~CLcj7DaPd3265332653epcas1p2Q;
        Wed,  6 Sep 2023 02:19:11 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.136]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RgQzf1Vvnz4x9Ps; Wed,  6 Sep
        2023 02:19:10 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.DD.09567.D91E7F46; Wed,  6 Sep 2023 11:19:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230906021909epcas1p2050b0564283dbfa7a5b8dd8398c6a6e6~CLcikxwHv3245032450epcas1p2P;
        Wed,  6 Sep 2023 02:19:09 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230906021909epsmtrp1ca7319375b81a521ab9081c268ff1d64~CLcij6HHR0132301323epsmtrp1e;
        Wed,  6 Sep 2023 02:19:09 +0000 (GMT)
X-AuditID: b6c32a39-955f97000000255f-4f-64f7e19d0bdb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.B0.08649.D91E7F46; Wed,  6 Sep 2023 11:19:09 +0900 (KST)
Received: from kson001 (unknown [10.102.7.58]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230906021908epsmtip2dbebd06b7dfd1939a173b253df7c77a9~CLch8jm5q1902919029epsmtip2w;
        Wed,  6 Sep 2023 02:19:08 +0000 (GMT)
From:   "Kwanghoon Son" <k.son@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jszhang@kernel.org>, <guoren@kernel.org>, <wefu@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <inki.dae@samsung.com>
Cc:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
In-Reply-To: <a19f9b10-f65f-6719-635f-06bc10b79c61@linaro.org>
Subject: RE: [RFC PATCH 2/3] reset: Add th1520 reset driver support
Date:   Wed, 6 Sep 2023 11:19:08 +0900
Message-ID: <000001d9e068$84cabcc0$8e603640$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIKln6jBiI8NctqyBug/lhtZHj/zgHJqwAgAquW57cCUmlUDq91ZLCg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmvu68h99TDOa1Mlts/T2L3WLN3nNM
        FvOPnGO1eLG3kcVi0v0JLBbNx9azWfS9eMhssff1VnaLy7vmsFls+9zCZnH33gkWi5eXe5gt
        2mbxW7TuPcJu0bJ/CosDv8ebly9ZPA53fGH32LSqk83jzrU9bB6bl9R79P818Hi/7yqbR9+W
        VYwel5qvs3t83iQXwBWVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtq
        q+TiE6DrlpkD9ISSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8C0QK84Mbe4NC9d
        Ly+1xMrQwMDIFKgwITujf8IStoLjLBXXJu5naWDczdzFyMkhIWAi0b1zPmMXIxeHkMAORomr
        3zYxQzifGCXOPH3OCuF8Y5RYOaWTFaal49J1JojEXkaJy6smM4IkhAQeM0pcX2kAYrMJaEos
        PPcbbK6IwGUmick9H1lAEswCqRJHL89jA7E5Bewk5p5qBNrHwSEs4Cwx72IVSJhFQEXix4T7
        YPfxClhKTP5xnhXCFpQ4OfMJ1Bh5ie1v50D9oCDx8+kysBoRATeJJzfamSFqRCRmd7aBvSMh
        8IZD4s6ijSwQDS4SDz59gfpGWOLV8S3sELaUxMv+Nig7W+Lox71sEHaJxPVZi6DqjSX2L53M
        BHIzM9CT63fpQ4QVJXb+nssIsZdP4t3XHlaQEgkBXomONiEIU17iVmc5RLUoMGw/sk1gVJqF
        5LFZSB6bheSBWQi7FjCyrGIUSy0ozk1PLTYsMIXHdXJ+7iZGcPLWstzBOP3tB71DjEwcjIcY
        JTiYlUR438l/SxHiTUmsrEotyo8vKs1JLT7EaAoM6onMUqLJ+cD8kVcSb2hiaWBiZmRsYmFo
        ZqgkznvubW+KkEB6YklqdmpqQWoRTB8TB6dUA5Pu3BX7JDXkT077ka8g/f3gj31hk9ctcV/4
        cpfjSbbnInPvqvs8yLu97C7jIUvewuc7Jd80G1ZqfJN6+/Tfwy/KM/wjg2/em76oo+bvudNp
        YRVZDHEbvviejTohuN37oez/n9PVTe4e/G+4Yf0Kv39L/14zMfeM/B7wnWtxvdbeT8vzE7Pq
        X9n71M3sbbxdMOmYn170zlO3A2vfyTx6zZV4VvHzGYEvxoemzbb4keJ5NGDRa2EG+XO/W2Ke
        LDVz3/fiTMh8V728H/pKhpsnTfXk1I252Gqsmh14qk3Ncue++gNcDWLXhFk+nEw/aKb43YEt
        ID3Yeanxvuhzj1MsaxgkPGLKWfNLBab8/akXm/xLiaU4I9FQi7moOBEAxWEyhmcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvO7ch99TDC7ulrbY+nsWu8WaveeY
        LOYfOcdq8WJvI4vFpPsTWCyaj61ns+h78ZDZYu/rrewWl3fNYbPY9rmFzeLuvRMsFi8v9zBb
        tM3it2jde4TdomX/FBYHfo83L1+yeBzu+MLusWlVJ5vHnWt72Dw2L6n36P9r4PF+31U2j74t
        qxg9LjVfZ/f4vEkugCuKyyYlNSezLLVI3y6BK6N/whK2guMsFdcm7mdpYNzN3MXIySEhYCLR
        cek6UxcjF4eQwG5GifttB1ggEqISHZcbGbsYOYBsYYnDh4shah4ySvx6tZURpIZNQFNi4bnf
        YLaIwH0miXs340FsZoF0iVuvz7BCNLxklLh+5hPYUE4BO4m5pxqZQYYKCzhLzLtYBRJmEVCR
        +DHhPthBvAKWEpN/nGeFsAUlTs58wgIxU1vi6c2nULa8xPa3c6AeUJD4+XQZK8QNbhJPbrQz
        Q9SISMzubGOewCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc5MNCwzzUsv1ihNzi0vz0vWS
        83M3MYIjWUtjB+O9+f/0DjEycTAeYpTgYFYS4X0n/y1FiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBqa4lp+qr1T72zTD/z3njXzwytxEji/WUFm3WHiH
        W498le6TK52usm+rFzOu9zecaPlEoWlSkQdLi85/bbvJFWeCPI6Ezpq45rsX8821M+8+CZK+
        G7mW1ffA/vJlN2dOERb28TP9JFL8uaLVJ3Ljhb5ZmTtzj9VuTLyzR38Db1LVo9iSuBUzWjSz
        v/unhomp7ezn2XK4Juxp2SNe7d7AhjOBCxcxzWSKZGzm6bzRKfgvbZIIs1X1jvV+T/e/nJ7Q
        yKQsvtjN0lsmW/L/k3/Fd7pe9bd3rIlvX3/sVYt7dJXE/KtK3UlN9TvkvaYvnzXJX6buaYrO
        ucsVflpuxnbH5F8Jhe5iCbyaoq3ZzLlRiaU4I9FQi7moOBEA3nIEGVMDAAA=
X-CMS-MailID: 20230906021909epcas1p2050b0564283dbfa7a5b8dd8398c6a6e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230904042603epcas1p2ae04f309c60dde70a0b254287f61dfb1
References: <20230904042559.2322997-1-k.son@samsung.com>
        <CGME20230904042603epcas1p2ae04f309c60dde70a0b254287f61dfb1@epcas1p2.samsung.com>
        <20230904042559.2322997-3-k.son@samsung.com>
        <a19f9b10-f65f-6719-635f-06bc10b79c61@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  drivers/reset/Kconfig                    |  10 +++
> >  drivers/reset/Makefile                   |   1 +
> >  drivers/reset/reset-th1520.c             | 109 +++++++++++++++++++++++
> >  include/dt-bindings/reset/th1520-reset.h |   9 ++
> 
> Bindings are always separate patches. In this case, all bindings should
> be together. Also you clearly forgot one step:

Thanks for the feedback. Does it mean 2 files
`include/dt-bindings/reset/th1520-reset.h`, `Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml`
Should be one patch first together?

Kwnag.

