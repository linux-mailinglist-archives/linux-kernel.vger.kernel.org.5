Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F7A7FD2C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjK2Jaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjK2Jab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:30:31 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915962D75
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:29:46 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231129092944epoutp04f2ed96aa64e3eb848f235c9bc218d1a2~cDgd_nOLL3171731717epoutp04-
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:29:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231129092944epoutp04f2ed96aa64e3eb848f235c9bc218d1a2~cDgd_nOLL3171731717epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701250184;
        bh=FHvSR/hYOGJJkx3HUz9cuc3ozsOZ6u4idcxy8RtY3ek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uv56qPD+l3e2Z5W0lKtubPM87dE3u4JY363KS2Q0qL/6WR4tvLEHlumasMHg9UxDL
         +LLwe2PVcxGusEiZwfOReufcbTKXV7EpO1uvDwQ7xvG+sA/XCmiBTYZCZGW8XrA0eU
         B2zEhnmsbXZB4NgKLXm3swnSBXn1BbA9rVf826MY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20231129092944epcas2p48dd26563bb461298f3467b73415a494e~cDgdlzJnu1311413114epcas2p4Z;
        Wed, 29 Nov 2023 09:29:44 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.69]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SgDYg3rW4z4x9Pt; Wed, 29 Nov
        2023 09:29:43 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.78.08648.78407656; Wed, 29 Nov 2023 18:29:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20231129092942epcas2p1c4305207c4c3d3701e7ff6757f7a2b4f~cDgcJFYlJ0737107371epcas2p1g;
        Wed, 29 Nov 2023 09:29:42 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231129092942epsmtrp13fa7b91dd84632b400609f49cb4e84bd~cDgcII0pu3031930319epsmtrp1k;
        Wed, 29 Nov 2023 09:29:42 +0000 (GMT)
X-AuditID: b6c32a43-4b3ff700000021c8-23-6567048740ae
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1A.EE.07368.68407656; Wed, 29 Nov 2023 18:29:42 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231129092942epsmtip233070651858a9e02b1227e78ed12d3f1~cDgb3wbsf0969709697epsmtip2i;
        Wed, 29 Nov 2023 09:29:42 +0000 (GMT)
Date:   Wed, 29 Nov 2023 19:04:47 +0900
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        alim.akhtar@samsung.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, semen.protsenko@linaro.org
Subject: Re: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non
 wake up external gpio interrupt
Message-ID: <ZWcMv8Bg12vqBCUm@perf>
MIME-Version: 1.0
In-Reply-To: <f814a1f4-2e3d-4946-949a-8ddac5e30d5f@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmhW47S3qqwba5MhYP5m1jszh/fgO7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdfxgduDx2zrrL7rFpVSeb
        x51re9g8Ni+p9+jbsorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sL
        cyWFvMTcVFslF58AXbfMHKDLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6
        xYm5xaV56Xp5qSVWhgYGRqZAhQnZGSc+nWQpOCpUceywUwPjN74uRk4OCQETiRMvz7N0MXJx
        CAnsYJS4d/okG4TziVHiyoWPTBDON0aJO08OscC0tN+7CdWyl1Hi5qz9zBDOQ0aJ/vkX2EGq
        WARUJWZfvgHWwSagK7HtxD9GEFtEQFPi+t/vrCANzAKdTBLTt89kBUkIC2RJ3NnYDdbAK6As
        8XfnOXYIW1Di5MwnQHEODk4BO4nJ8+pBeiUEOjkkFu6ZzwhxkovEue8roc4Tlnh1fAs7hC0l
        8bK/DcrOllj96xKUXQH0Qg8zhG0sMetZO9gcZoEMiQ1HJrGC7JIAuuHILRaIMJ9Ex+G/7BBh
        XomONiGITjWJX1M2QF0gI7F78QqoiR4SzyZvYocGI7PEnFt32Ccwys1C8s0sJNsgbB2JBbs/
        sc0CWsEsIC2x/B8HhKkpsX6X/gJG1lWMYqkFxbnpqclGBYbwCE7Oz93ECE6oWs47GK/M/6d3
        iJGJg/EQowQHs5IIr97H5FQh3pTEyqrUovz4otKc1OJDjKbAuJnILCWanA9M6Xkl8YYmlgYm
        ZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTCFN/IuC6i9+c30MsflY2q8266L
        Zf/656b50Clj243XpybN+yjgcXeJ2C7lmSt33LCJ+F2/9PIcG23rCwv8LnL0FeRaBNxQn/U9
        ONheOvjGpNDjPpKqhrX8Zfb+Sg2zzL/3Hr/guj7MnXmPeYCE/3ppje0mp497VGqxHVu0fdrR
        WUmKJexXVRXNmPY1HnyZn8KbtvDTs8554XHT1845W1Xd6uijHvbo6oQnX9b8jEwU4rRZ8mZe
        byazyeaTR/k1DkZKTI6XFVp73e/sZC8LJtdE+Y0HhH4m1c3cea9n+wOvz1w6x001+nqSv0k0
        Ta7ptO96o3p+anTUs1QlOVn+SfcKVtS2+ZS26fBqKKfGhSuxFGckGmoxFxUnAgBvbNQXMQQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSvG4bS3qqwfp3UhYP5m1jszh/fgO7
        xZQ/y5ksNj2+xmqxef4fRovLu+awWcw4v4/J4vCbdlaL531A1qpdfxgduDx2zrrL7rFpVSeb
        x51re9g8Ni+p9+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Mc39YC1oFKpb8esHWwHiep4uR
        k0NCwESi/d5Nli5GLg4hgd2MEgunPmODSMhI3F55mRXCFpa433KEFaLoPqPEibVv2UESLAKq
        ErMv32ABsdkEdCW2nfjHCGKLCGhKXP/7HayBWaCTSWL69plgk4QFsiQePjwPtoFXQFni785z
        7BBTfzBLLFy9jAkiIShxcuYTsKnMAloSN/69BIpzANnSEsv/cYCYnAJ2EpPn1U9gFJiFpGEW
        koZZCA0LGJlXMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefnbmIER4SWxg7Ge/P/6R1iZOJg
        PMQowcGsJMKr9zE5VYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZ
        Jg5OqQam5OcuL9IX+13LSta7HLnn9leL2IgNSX1PC+qs3v9nWHL0pOS/qzln5XYJR2x/PitH
        ZYL74xrz5iWHlrtI/vqasbT9iS/3p/wjOgXMs06se5OcME2olTdsb3XJuerQ/Qzq97T95txT
        e3/4ZqXYulah1P2VwkmHWzqypi6z4z315H15TBDDtjVr2281rhXxZTrEVhgvL7Vc6ttMqwvT
        r7nn5P+JY9hrvOxz56rbm4JMf81acND+eUJ5xS8rEZ2Atom3XqyrqxUqtE5eojzfe/Fu3QCt
        l9W5XvevnzXanSbwaXFMPPfMa5daVijrHT/Sl3VrvZqzoKT9qw81fF0M3p7iN+3DFmVzLk2c
        Uv+004xXiaU4I9FQi7moOBEA0CLvT/cCAAA=
X-CMS-MailID: 20231129092942epcas2p1c4305207c4c3d3701e7ff6757f7a2b4f
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_37ba7_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38
References: <CGME20231126091120epcas2p4a1320e3b0f9be8f8a0f575a322981d38@epcas2p4.samsung.com>
        <20231126094618.2545116-1-youngmin.nam@samsung.com>
        <bb738a6b-815d-4fad-b73f-559f1ba8cd68@linaro.org> <ZWU75VtJ/mXpMyQr@perf>
        <1fd55b36-0837-4bf7-9fde-e573d6cb214a@linaro.org>
        <CAPLW+4n0SAOTb6wocY-WjkxgSFMbx+nVuqdaPcNYVDsbfg+EfA@mail.gmail.com>
        <ZWbjPIydJRrPnuDy@perf> <a0ac295b-ea96-475c-acde-5a61de8ca170@linaro.org>
        <ZWb6cyTgyEcee7DZ@perf> <f814a1f4-2e3d-4946-949a-8ddac5e30d5f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_37ba7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Nov 29, 2023 at 09:39:45AM +0100, Krzysztof Kozlowski wrote:
> On 29/11/2023 09:46, Youngmin Nam wrote:
> >>> I couldn't find out a pin for the test on E850-96 board yet.
> >>> We can test if there is a usage of *Non" Wake up External Interrupt of GPIO
> >>> on E850-96 board.
> >>>
> >>> Do you have any idea ?
> >>
> >> Please test on any upstream platform or upstream your existing platform.
> >> I hesitate to take this change because I don't trust Samsung that this
> >> was tested on mainline kernel. OK, for sure 100% it was not tested on
> >> mainline, but I am afraid that differences were far beyond just missing
> >> platforms. Therefore the issue might or might not exist at all. Maybe
> >> issue is caused by other Samsung non-upstreamed code.
> >>
> >> Best regards,
> >> Krzysztof
> > 
> > Sure. Let me find how to test on upstreamed device like E850-96 board.
> 
> There are many reasons why companies using Linux for their products
> should be involved in upstreaming their devices.
> 
> The one visible from this conversation: Whatever technical debt you
> have, it will be only growing because upstream might not even take
> simple patches from you, until you start contributing with the rest.
> Samsung's out-of-tree kernels are so far away from the upstream, that
> basically we might feel that contributions from Samsung are not
> addressing real problems. This will affect your Android trees due to GKI.
> 
> That's one more argument to talk to with your managers why staying away
> from the upstream is not the best idea.
> 
> Second argument is look at your competitor: Qualcomm, one of the most
> active upstreamers of SoC code doing awesome job.
> 
> Best regards,
> Krzysztof

Thank you for your opinion.
By the way, this patch is not related with GKI and I just thought this work
would be helpful to all exynos platform.

But it seems that changing affinity of any irqs including gpio is not allowed
on exynos platform. So we need to debug by adding some logs.

> 
> 

------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_37ba7_
Content-Type: text/plain; charset="utf-8"


------beKDcrNeaD4oBIFRuchmvdVAwfnDGI5TYPt7fforSuRq9wgD=_37ba7_--
