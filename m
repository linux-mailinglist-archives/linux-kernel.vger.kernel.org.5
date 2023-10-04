Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B207B78CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbjJDHes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241495AbjJDHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:34:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8783AC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:34:41 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231004073438epoutp01d73d1f905cb2e866a82e6934b2946225~K1z_w8Uzp1054210542epoutp015
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:34:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231004073438epoutp01d73d1f905cb2e866a82e6934b2946225~K1z_w8Uzp1054210542epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696404878;
        bh=ijI6ldLxMVsnkVyv7irebtA3Q9901IfdS55IxS0QIBE=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WyFECOgAOljXhIhci3og2v+1+V1BzhewKv+l0miEhuHFXDsS3c7TNG2iR7KoGWwRA
         Et1SCrIR4t10PeTOncU5nGBeGSnahb5G+2YBiL/YAtsP6210mpDHMUz1YfCFlByEM9
         Z9j4sKaCNEfCEgdCLbj7sJC42xAb3IZcNNf3PjCQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20231004073437epcas1p4887af4518251ad861e7a05b8cd418a05~K1z_gMebm2633626336epcas1p4R;
        Wed,  4 Oct 2023 07:34:37 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.36.226]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4S0mfj5xB4z4x9Q1; Wed,  4 Oct
        2023 07:34:37 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        5C.AA.10163.D851D156; Wed,  4 Oct 2023 16:34:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231004073437epcas1p206e1516eaea07bad34854c99fcdc3025~K1z_J0Cs52617026170epcas1p2S;
        Wed,  4 Oct 2023 07:34:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231004073437epsmtrp2e9a6a42b583e30d9d45f43207ce0333a~K1z_JB8fK3200632006epsmtrp2V;
        Wed,  4 Oct 2023 07:34:37 +0000 (GMT)
X-AuditID: b6c32a38-4dbf8700000027b3-e3-651d158db476
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.D1.08788.D851D156; Wed,  4 Oct 2023 16:34:37 +0900 (KST)
Received: from wookwanglee02 (unknown [10.253.100.52]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231004073437epsmtip2a98ae000471e02cb41c34281eb4e5d52~K1z9-h5OI1536015360epsmtip2J;
        Wed,  4 Oct 2023 07:34:37 +0000 (GMT)
From:   "Woo-kwang Lee" <wookwang.lee@samsung.com>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <sj1557.seo@samsung.com>
In-Reply-To: <2023100411-duckling-tibia-398a@gregkh>
Subject: RE: [PATCH] usb: core: add bos NULL pointer checking condition
Date:   Wed, 4 Oct 2023 16:34:37 +0900
Message-ID: <007e01d9f695$3a8d9ea0$afa8dbe0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4ktvx1bQoFTuKvuL3rpp4W8lh6wDTwCDRAk7sf+IBqjJOwwKQ6a6ZrcEVBQA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmvm6vqGyqwbZv+hbNi9ezWVzeNYfN
        YtGyVmaLLf+OsFos2PiI0YHVY//cNewefVtWMXp83iQXwBzVwGiTWJSckVmWqpCal5yfkpmX
        bqsUGuKma6GkkJFfXGKrFG1oaKRnaGCuZ2RkpGdqFGtlZKqkkJeYm2qrVKEL1aukUJRcAFSb
        W1kMNCAnVQ8qrlecmpfikJVfCnKnXnFibnFpXrpecn6ukkJZYk4p0Agl/YRvjBnT/m9gKdjL
        VvHo4WbGBsbFrF2MnBwSAiYSk++uYeti5OIQEtjBKPH36iVGCOcTo8SmzrNQzjdGieMfpzLD
        tDw5spkVIrGXUeLQ6n5mCOc1o8SEdz+ZQKrYBAwkNrVfYQOxRQR0JDrOnGABsZkFSiV+3+kD
        W84JNGnhgSdgU4UF3CXWv7wOZrMIqEg87vnFDmLzClhK/Jh8kgXCFpQ4OfMJ1Bx5ie1v50Bd
        pCDx8+kyVohdfhIHNq9jh6gRkZjd2QZ2nIRAL4fEgT9P2SEaXCTO/NkGDQFhiVfHt0DFpSQ+
        v9vLBtHQzCjx8uYnFginBxgADzcxQVQZS3z6/BkYMhxAKzQl1u/ShwgrSuz8PZcRYjOfxLuv
        PVALBCVOX+tmBimXEOCV6GgTggirSaw+u4htAqPyLCS/zULy2ywkP8xCWLaAkWUVo1hqQXFu
        emqxYYEJcpRvYgSnUy2LHYxz337QO8TIxMF4iFGCg1lJhDe9QSZViDclsbIqtSg/vqg0J7X4
        EGMyMLQnMkuJJucDE3peSbyhmZmlhaWRiaGxmaEhYWETSwMTMyMTC2NLYzMlcd5jr3pThATS
        E0tSs1NTC1KLYLYwcXBKNTBNjQ763B+mvjnbxrLU5UmP7hOdhybCL3eJtnUKH/04STzZJVyW
        1/r0zVc3F9yd/5yv+dFe1ti0uKCgDx/CWQVCDT96F9l132OK7F3o7rp+367lG3Qne7HfPFo6
        U0R+g+uhXXbLTNd7b0+2TU5pmf+uz/Vs/Ir9s+ZvN6ueYapj+GTiMcnWKcx7PDcI83ILMW3h
        FPrYvWhTVslp28qDzxmbsq7OOuZocHbCvjO3Xr8Vbz+4NO+A3C1Zl1bpS+XvQ3g/r3m68ezZ
        uln9MwpXGwguC5v2bH5f+D/ZKzyK3/bv1Vmz+eHaA9MDE9+cceJV29zz8rv2yw3vZRwkxU4l
        Rsznv+yZ93bvz/PnLrxsLluRq8RSnJFoqMVcVJwIALZBowBeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXrdXVDbVoO2ajEXz4vVsFpd3zWGz
        WLSsldliy78jrBYLNj5idGD12D93DbtH35ZVjB6fN8kFMEdx2aSk5mSWpRbp2yVwZUz7v4Gl
        YC9bxaOHmxkbGBezdjFyckgImEg8ObIZyObiEBLYzShxaNlfRoiEjMTu5X/Yuhg5gGxhicOH
        iyFqXjJKPPy4hhmkhk3AQGJT+xU2EFtEQEei48wJFhCbWaBS4u73L1BDu5gkJi3qAdvGCbRt
        4YEnYM3CAu4S619eB7NZBFQkHvf8YgexeQUsJX5MPskCYQtKnJz5hAXkCGYBPYm2jYwQ8+Ul
        tr+dwwxxp4LEz6fLoJ4Rlnh1fAs7hG0m8WdfNwvEbX4SBzavY4foFZGY3dnGPIFRdBaSDbMQ
        NsxCsmEWko4FjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCY0pLawfjnlUf9A4x
        MnEwHmKU4GBWEuFNb5BJFeJNSaysSi3Kjy8qzUktPsQozcGiJM777XVvipBAemJJanZqakFq
        EUyWiYNTqoEpxvG2fWOpzmnPosn5O2dVZX6JVZTK+Kf1+6Tdi+eyMe/fSM6NPF45y+hMxzzz
        I7Hno8/ZiHzXeunSt+Je9fsGHp3ctvVCs389/LL82UvH5HPMn+ybw6JSngT8+afiI7RLUvbl
        DYtKS2b9H5PN727Os7kte1ygLPlmYk2cUpkOa3HkxFcuRh2lZieE3+6+Uu3Y4nSs12fD1aMu
        7iv/KBp+PMbbxacW2Xi155rt3sMhC4/s63/KZmIq/Kl5UU24XeGti5c2XrwaeiJtM6vuvBVf
        GHz29XYn7srdxWhp17WGL+GoUXWAu8H0gktpJYvSq1OafE+6Nc36f37bjrCdUxavO9WuafbS
        I9A7vjsx6YcSS3FGoqEWc1FxIgCMpHBpGAMAAA==
X-CMS-MailID: 20231004073437epcas1p206e1516eaea07bad34854c99fcdc3025
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231004062700epcas1p16fe36bf6b6a6e5d9d4adeaef32937480
References: <CGME20231004062700epcas1p16fe36bf6b6a6e5d9d4adeaef32937480@epcas1p1.samsung.com>
        <20231004062642.16431-1-wookwang.lee@samsung.com>
        <2023100439-king-salute-5cd5@gregkh>
        <000101d9f691$4513da00$cf3b8e00$@samsung.com>
        <2023100411-duckling-tibia-398a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Grek.
It means that this is not needed.
Commit id f74a7afc224a already has hub_is_superspeedplus modification.
I'm sorry for the confusion.
Thank you.

Woo-kwang Lee

> -----Original Message-----
> From: 'Greg KH' <gregkh@linuxfoundation.org>
> Sent: Wednesday, October 4, 2023 4:22 PM
> To: Woo-kwang Lee <wookwang.lee@samsung.com>
> Cc: linux-usb@vger.kernel.org; linux-kernel@vger.kernel.org;
> stable@vger.kernel.org; sj1557.seo@samsung.com
> Subject: Re: [PATCH] usb: core: add bos NULL pointer checking condition
> 
> On Wed, Oct 04, 2023 at 04:06:17PM +0900, Woo-kwang Lee wrote:
> > Hello. I think I missed the patch.
> 
> I do not understand, does that mean that you have tested the patch (and
> which one, please do not top post), and that this is not needed?
> 
> confused,
> greg k-h

