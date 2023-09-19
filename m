Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A031E7A571C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 03:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjISBpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjISBpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 21:45:19 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6545126
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 18:45:07 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230919014504epoutp03a8346ef90eb31f4a1a726c80efa264da~GKXfbB5Gh0380503805epoutp03u
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:45:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230919014504epoutp03a8346ef90eb31f4a1a726c80efa264da~GKXfbB5Gh0380503805epoutp03u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695087904;
        bh=lLCM/8IqCpLa3dHvgEv+eegEJeJyfZcXheoJ8ZduPHg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WZYFvfox2sCEVWDw8aFyHGEOQjTU6x9fWC72SJsJidAKLxIMAutcrh99bUQE7p9Fq
         /VumpJrNt70r12wrXbNQ5cIe/uux0T0RC/VD7KStO1QM3gUtgYritLjBrfxO6pFePw
         NxA7dLNTytRe+jkhRKWmzYHgv0VvWNzF9rPVl0GI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230919014503epcas1p1dd162a1dbe841aa52e95b572903550ab~GKXeTCdjy1334213342epcas1p1j;
        Tue, 19 Sep 2023 01:45:03 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.133]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RqPcG0RYZz4x9QC; Tue, 19 Sep
        2023 01:45:02 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.F1.09567.D1DF8056; Tue, 19 Sep 2023 10:45:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230919014501epcas1p133aabaf86241af13cb425d1221969831~GKXcp98fv1066110661epcas1p1D;
        Tue, 19 Sep 2023 01:45:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230919014501epsmtrp231b7c3a0b2ea75a9b80fc21b7cc8cd52~GKXco217F2346623466epsmtrp2D;
        Tue, 19 Sep 2023 01:45:01 +0000 (GMT)
X-AuditID: b6c32a39-6ffff7000000255f-4b-6508fd1df48d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3E.11.08742.D1DF8056; Tue, 19 Sep 2023 10:45:01 +0900 (KST)
Received: from kson001 (unknown [10.102.7.58]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230919014501epsmtip1ae0b3469280481e6bf398b3e4057ad48~GKXcT4nNM2673426734epsmtip14;
        Tue, 19 Sep 2023 01:45:01 +0000 (GMT)
From:   "Kwanghoon Son" <k.son@samsung.com>
To:     "'Conor Dooley'" <conor@kernel.org>
Cc:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jszhang@kernel.org>, <guoren@kernel.org>, <wefu@redhat.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <inki.dae@samsung.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
In-Reply-To: <20230918-4ef7f52da269f3a7e4023bb3@fedora>
Subject: RE: [PATCH v3 1/3] dt-bindings: reset: Document th1520 reset
 control
Date:   Tue, 19 Sep 2023 10:45:00 +0900
Message-ID: <006501d9ea9a$e777c6b0$b6675410$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQGA88MHphYB2H/uDBHue9ViU8X2awGBaA+GAbT+P64CTt+43rCnIi0w
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmnq7cX45Ug1NBFlt/z2K3WLP3HJPF
        yqmr2CzmHznHavFibyOLxaT7E1gsmo+tZ7Poe/GQ2eLyrjlsFts+t7BZ3L13gsXi5eUeZou2
        WfwWrXuPsFu07J/C4sDv8eblSxaPwx1f2D02repk87hzbQ+bx+Yl9R79fw083u+7yubRt2UV
        o8el5uvsHp83yQVwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gD9oKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMC3QK07MLS7NS9fL
        Sy2xMjQwMDIFKkzIzpjRNout4DZzxf4Xz5kbGM8xdTFyckgImEhM+3qKuYuRi0NIYAejxMK+
        F2wQzidGiWu79rOAVAkJfGOU6H/H2sXIAdbxbrc7RM1eRonG869YIZzHjBJLpy9mBGlgE9CU
        WHjuN5gtIqAucefQa7AVzAK/mCR2z9nIDpLgFDCX+H5nNTOILSzgL7F1xmtWEJtFQFVi9tcl
        YHFeAUuJngt7WSFsQYmTM5+AXcQsIC+x/e0cZogfFCR+Pl3GChEXkZjd2cYMsdhNYteXX+wg
        iyUEfnBI/Fu5GeppF4mXJx+yQdjCEq+Ob2GHsKUkPr/bCxXPljj6EcYukbg+axErhG0ssX/p
        ZCZQUDADfbl+lz5EWFFi5++5jBA38Em8+9oDDS1eiY42IQhTXuJWZzlEtajEmacf2SYwKs1C
        8tgsJI/NQvLMLIRdCxhZVjGKpRYU56anFhsWmMLjOjk/dxMjOHVrWe5gnP72g94hRiYOxkOM
        EhzMSiK8Mw3ZUoV4UxIrq1KL8uOLSnNSiw8xmgKDeiKzlGhyPjB75JXEG5pYGpiYGRmbWBia
        GSqJ855725siJJCeWJKanZpakFoE08fEwSnVwLRkNf/R2zOmOz+sXFL6N5BpaeF5q8MMh+Sn
        T2apuDMv7S2HclscX0ZBvQZDmo3LleetZ54+cznMHqOxLd1hoZbonBMxPjtN1N4Zvf5nt2VV
        +hcjdQM1j008ar4Jk+4WLnf5u6CXrUtvI2PD0WgtsTMVPHOmJ/Af/3dqHuP2rjDBS6JyZeJi
        DZuLTzxLsV9x3G9mgYbK/KVSZW5PGjMUJHf6TksL+iimPPf+5bVn1mxJlYzeVfzblf1NEGO1
        0Qfu7oTJa+eaHqiaEhU6/4vc+0vRT+tN50hZO4gqzF+3cw3LfCEt/U//ZL7si59SJSVxpPSb
        OmfAxo1vOe+2uhc1tZudnt+yakPaJA+OXq9XuUosxRmJhlrMRcWJAAE6brtmBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSnK7sX45UgzN/JC22/p7FbrFm7zkm
        i5VTV7FZzD9yjtXixd5GFotJ9yewWDQfW89m0ffiIbPF5V1z2Cy2fW5hs7h77wSLxcvLPcwW
        bbP4LVr3HmG3aNk/hcWB3+PNy5csHoc7vrB7bFrVyeZx59oeNo/NS+o9+v8aeLzfd5XNo2/L
        KkaPS83X2T0+b5IL4IrisklJzcksSy3St0vgypjRNout4DZzxf4Xz5kbGM8xdTFycEgImEi8
        2+3excjJISSwm1Hi+3NbEFtCQFSi43IjI0SJsMThw8VdjFxAJQ8ZJb60r2cBqWET0JRYeO43
        I4gtIqAucefQa2aQImaBLmaJHS93MEF0PGKUeHn6NjtIFaeAucT3O6uZQWxhAV+JDZePgdks
        AqoSs78uAbN5BSwlei7sZYWwBSVOznzCAnIFs4CeRNtGsGXMAvIS29/OYYY4VEHi59NlrBBx
        EYnZnW3MEAe5Sez68ot9AqPwLCSTZiFMmoVk0iwk3QsYWVYxSqYWFOem5xYbFhjmpZbrFSfm
        Fpfmpesl5+duYgRHsZbmDsbtqz7oHWJk4mA8xCjBwawkwjvTkC1ViDclsbIqtSg/vqg0J7X4
        EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA5Nf75JE2d5nhZXNJ0XyplQGXVB27ttW
        Vvl6cWKOUe1m6SkZd/duan4XOVfszOGig6L5LGV+nDOvOPC+dn9z5khWdaJwVbk1y9sfnNPb
        9dyyNRkcNpof+fC8S4D97LqmaR3Ljc9o60w4zSezX7PR5+HJP4/m9EUukE5bbV21Vr+9dqfa
        3yYvQYXivvqinUFKRedvHl+Z7Tfp66vzjt6Hj1o3xYVP4hROuLOhKm/No0W7lthEHJtUOv3L
        NUarRSvlDy3bcXfPb0nv3T/+qcu4+R5b/FvvaMfcr7whL0/+2myfWzzxmuMrx//rp7QtU5y7
        eUXDie1BTnLyUbl3asMMJW2W7l4y68famMtGPEdz8/crsRRnJBpqMRcVJwIAbo1f/lEDAAA=
X-CMS-MailID: 20230919014501epcas1p133aabaf86241af13cb425d1221969831
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

> > +      - const: thead,th1520-reset
> > +      - const: syscon
> 
> iDumb question perhaps, but why is this a syscon?

This is good point.
In fact, I took it from the vendor kernel, and I tried to keep it as same as I could.
Vendor also followed drivers/reset/reset-imx7.c
As Rob said, if don't need it, I'll change it.

Regards,
Kwang.

> Cheers,
> Conor.
> 
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#reset-cells':
> > +    const: 1


