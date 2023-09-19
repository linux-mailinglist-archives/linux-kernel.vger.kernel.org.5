Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42277A5930
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 07:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjISFIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 01:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjISFIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 01:08:46 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D0FD
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 22:08:40 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230919050836epoutp011d0164fff5fefc6208cb272c6735ca58~GNJMyMo-e0270402704epoutp01j
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:08:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230919050836epoutp011d0164fff5fefc6208cb272c6735ca58~GNJMyMo-e0270402704epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695100116;
        bh=MOWzOcLyGe3ASu3GVGlOZqaHzTzcWNGNyO93peZAlvo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=uL8WZvHE6OgTum7k/RGhu97K6VR+ehXMVRdt2U+vQBJTMNx+a5HPKhO63aTaS3u2L
         j6xjKeNlvDU+gJv61eLXgxs9fcFF8n7ZqGyg4bL5KkuyGNen1ahgQedqfY+iiXwBfE
         LA7EpapMxL4dBuE3nBr+2wCigmJzP/ux1xfS2uE4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20230919050835epcas1p3b32b45a0d2ebdbdb1ee492ab0b72de68~GNJL8wfZT1572715727epcas1p3c;
        Tue, 19 Sep 2023 05:08:35 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.133]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RqV7624lcz4x9Q1; Tue, 19 Sep
        2023 05:08:34 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.95.08657.2DC29056; Tue, 19 Sep 2023 14:08:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20230919050833epcas1p4b5ea1035d03df587f072f45233663261~GNJKKKS9E2757527575epcas1p4r;
        Tue, 19 Sep 2023 05:08:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230919050833epsmtrp1be15abd8ed4a45de199d0c83a0fb9dee~GNJKJa4Gr0049500495epsmtrp1k;
        Tue, 19 Sep 2023 05:08:33 +0000 (GMT)
X-AuditID: b6c32a33-4e9ff700000021d1-a2-65092cd23513
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.EA.08788.1DC29056; Tue, 19 Sep 2023 14:08:33 +0900 (KST)
Received: from kson001 (unknown [10.102.7.58]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230919050833epsmtip1100c84b749de8162a481ba74f101605c~GNJJ2DC-21075910759epsmtip1T;
        Tue, 19 Sep 2023 05:08:33 +0000 (GMT)
From:   "Kwanghoon Son" <k.son@samsung.com>
To:     "'Conor Dooley'" <conor@kernel.org>
Cc:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jszhang@kernel.org>, <guoren@kernel.org>, <wefu@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <inki.dae@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
In-Reply-To: 
Subject: RE: [PATCH v3 1/3] dt-bindings: reset: Document th1520 reset
 control
Date:   Tue, 19 Sep 2023 14:08:32 +0900
Message-ID: <005301d9eab7$5688c920$039a5b60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGA88MHphYB2H/uDBHue9ViU8X2awGBaA+GAbT+P64CTt+43rCnIi0wgAA4BwA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUZRztu/fu3bvUym1d6wsZXa44DhSwK7vLXYSkhFxxNczRppqRbnDd
        RfY1e5ce9gcyCAMMuWhpsouDWC1BDQwrD1MWpxUIpagBih5UlpCsEMSrUVFql4vFf+f85pz5
        nfM9CFQyiIcROWY7azMzRgoPwVqvRMXG9D8lYuXvjIrplgWnkP7U24fQdSfrcbq6s09Aj3kL
        MPrErxUYXdjdiNPHxn5D6YGLVTjdOnsUp3/+pQej/QPlKF3sDKWLvJ1C+ujl97CUUO2E349p
        r5TMCbWe+lJcO/xdO649/2G+1nFfrp3q+BbXHmuuB9r+wiGhdtazLiPk5dwkA8tkszYZa86y
        ZOeY9cnUzr2Z2zJVarkiRqGhEyiZmTGxyVSqLiPmuRxjoAQle50x5gVGGQzHUXFPJ9kseXZW
        ZrBw9mSKtWYbrSprLMeYuDyzPtbM2hMVcvlmVUD4aq6hfdyFW+cFb9bW1uJHgBsrAyICkko4
        23FfWAZCCAl5AcDi3904T2YAvDRYiQZVEvJvAMtc+ANHR/m1ZYcXwAa3H+HJDQA9x4NEROBk
        FKzpWwBBLCU3wWHfOBoUoeRdBF6qagrYCUJEimHF4pagZjX5PGw5PS4IYozcCOd95UteMamB
        85/zWcXko/Bq5cgSRsn1sO3PKpRPJIN3Rt0Cfi6FrtJilN+7G3aOdIDgXkjeJqDjGxfgDamw
        qb5ZwOPV8NYXzUIeh0G/o3gZ58Kuae9yZTsccp5b1sfDyx+9iwTzo4GSjRfj+HEE/GzhDOAz
        rIKT8+WCoAQGKpYUS3i4Hv5Y+gavXgO/HJ3GKwDlXFHMuaKYc0UZ5/+7zgKsHjzGWjmTns1S
        WBX/3XWWxeQBS887Ov4CGKhejPUBhAA+AAmUkoorFTgrEWczbx1mbZZMW56R5XxAFTjq42jY
        mixL4H+Y7ZkKpUauVG+OV9IKtYJ6XBxR4cqWkHrGzuayrJW1PfAhhCjsCCIP16UgPQOr9oOz
        WPNCw75n/wmbPrU13ii47ol+21rQ7ulOsJ8qj7yO7BmCU+yGxj0TXcPrXhkoiI275d4rYrxr
        dz6kSxp3hCe/Xy1tek1XtDFux9BPIelsyu2p1gPYB73eQw3CnvTIJ8XbinQ1fxw8sT/pk8SI
        me+Vz4TWpUyX3NStVb7wtVOzY+s9R2TCSGdcr7ntDvQMh284M1nD9d5Ln1Dnz4193HKTelF9
        cnK366WZfrTNcJeQ1k7vqig8p/mLmsk9PIjOp6q6VPiB7VL84U1zW64t3sAio75KS8upbkhr
        rPN370Ke+MH0yL6DCdE+uyVRNbnQcEhlSryamq8XnKcwzsAoolEbx/wLGYlwaWcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnO5FHc5Ug7vHNS22/p7FbrFm7zkm
        i5VTV7FZzD9yjtXixd5GFotJ9yewWDQfW89m0ffiIbPF5V1z2Cy2fW5hs7h77wSLxcvLPcwW
        bbP4LVr3HmG3aNk/hcWB3+PNy5csHoc7vrB7bFrVyeZx59oeNo/NS+o9+v8aeLzfd5XNo2/L
        KkaPS83X2T0+b5IL4IrisklJzcksSy3St0vgytjzejZbwVfWiuXLl7M1MC5j6WLk5JAQMJHY
        13OKvYuRi0NIYDejxP23H1khEqISHZcbGbsYOYBsYYnDh4shah4ySnw+tQ+smU1AU2Lhud+M
        ILaIgLrEnUOvmUGKmAW6mCV2vNzBBJIQEnjMKLG+RQ9kEKcAr8SEf9YgYWEBX4kNl48xg9gs
        AqoSXw/1gM3hFbCU+HoQ4jheAUGJkzOfsIC0MgvoSbRtBCthFpCX2P52DjPEmQoSP58uY4WI
        i0jM7mxjhjjHT+LIk32MExiFZyGZNAth0iwkk2Yh6V7AyLKKUTK1oDg3PbfYsMAoL7Vcrzgx
        t7g0L10vOT93EyM4irW0djDuWfVB7xAjEwfjIUYJDmYlEd6ZhmypQrwpiZVVqUX58UWlOanF
        hxilOViUxHm/ve5NERJITyxJzU5NLUgtgskycXBKNTC1sT2dbGbyTdNxR0r08qjrdhPbfvWI
        PZdJ9UosVd4fM/lCpckbH87M32HZdscX7S7xDOYMPR+wxizw98FAlp9nL27fsuAQk8bMeRM+
        Zb1PqbBd/042lf+bwvZ80SgPwz2bo7v5zJ5WbDjLkrKtclqqbkKnwhf/2epLbYPPucXyqG+9
        HqJ9p/beMi8zThOVCPUPzHNkl5zziBfceUvvzll72dTjfku2P9M7vNfkvNmtBa9DY/ZUS+XZ
        Ln5xnD9yTazI5xhf3pS2GY+4b5kKrrBu1GG111/zRHbV1ZeT1xgwbpfJvPRx+9OEPoevzQcm
        sHy7w/lI4ta1D9oLHvWppJv/fJqbGKx/NqZ3C5/NOjslluKMREMt5qLiRACIP9urUQMAAA==
X-CMS-MailID: 20230919050833epcas1p4b5ea1035d03df587f072f45233663261
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50
References: <20230918045125.4000083-1-k.son@samsung.com>
        <CGME20230918045134epcas1p1b80b338b66512a976c3783cd0e51da50@epcas1p1.samsung.com>
        <20230918045125.4000083-2-k.son@samsung.com>
        <20230918-4ef7f52da269f3a7e4023bb3@fedora> 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +      - const: thead,th1520-reset
> > > +      - const: syscon
> >
> > iDumb question perhaps, but why is this a syscon?
> 
> This is good point.
> In fact, I took it from the vendor kernel, and I tried to keep it as same as I could.
> Vendor also followed drivers/reset/reset-imx7.c
> As Rob said, if don't need it, I'll change it.
> 
> Regards,
> Kwang.
> 
I have investigated vendor kernels, but it is still not sure reset information.
I thought this is about sys_reg, but without datasheet, can't tell.
Therefore, should be stopped patch for a while until knows better comes out.

Kwang.

> > Cheers,
> > Conor.
> >
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#reset-cells':
> > > +    const: 1


