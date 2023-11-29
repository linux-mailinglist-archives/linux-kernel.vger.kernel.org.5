Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F87FD06B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjK2ILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK2ILj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:11:39 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C6C19BB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:11:43 -0800 (PST)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231129081139epoutp030b59dce741340895ceb47388daae4318~cCcS3-VoL1435614356epoutp03d
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:11:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231129081139epoutp030b59dce741340895ceb47388daae4318~cCcS3-VoL1435614356epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701245499;
        bh=ZsnlkJe58yX5RXB5ZD8t4M6Ua2BJjjBj9mFjfRMfBec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fTsFwG7turQZhfkTmyJF/IieTNe8TppqPQXHD+9EZXLO1P4Cvt+fa7g094KlPU568
         x2ldpoSMdVh6E0NlXMyiAv8fafto9vkbsTHP7ZO9t3RssfFZ8WR/y+KNI/jE3We6Xw
         3sQhN/Ticm9eEM5F2cUpemRZDrienAP+UOn5gcao=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20231129081139epcas2p192dfa2419ca81108b0d0c7e0d9ad053c~cCcSp8lXf1568515685epcas2p1O;
        Wed, 29 Nov 2023 08:11:39 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4SgBqZ6Dvjz4x9Q3; Wed, 29 Nov
        2023 08:11:38 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.DD.10022.A32F6656; Wed, 29 Nov 2023 17:11:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
        20231129081138epcas2p2ba1f0c83f896f36d03110535a1623109~cCcRX2iNg0345603456epcas2p2N;
        Wed, 29 Nov 2023 08:11:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231129081138epsmtrp210c155f374c3126daad7227894adea89~cCcRXHyTQ1662616626epsmtrp2T;
        Wed, 29 Nov 2023 08:11:38 +0000 (GMT)
X-AuditID: b6c32a47-bfdfa70000002726-77-6566f23a96b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.0E.08755.932F6656; Wed, 29 Nov 2023 17:11:38 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231129081137epsmtip2331aa65c12c8e99d2a46b92b8aef9791~cCcRJ8Wsx3218932189epsmtip2l;
        Wed, 29 Nov 2023 08:11:37 +0000 (GMT)
Date:   Wed, 29 Nov 2023 17:46:43 +0900
From:   Youngmin Nam <youngmin.nam@samsung.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        alim.akhtar@samsung.com, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, semen.protsenko@linaro.org
Subject: Re: [PATCH v2] pinctrl: samsung: add irq_set_affinity() for non
 wake up external gpio interrupt
Message-ID: <ZWb6cyTgyEcee7DZ@perf>
MIME-Version: 1.0
In-Reply-To: <a0ac295b-ea96-475c-acde-5a61de8ca170@linaro.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmqa7Vp7RUgyNrDC0ezNvGZrH39VZ2
        iyl/ljNZbHp8jdVi8/w/jBaXd81hs5hxfh+TxeE37awWz/uArFW7/jA6cHnsnHWX3ePOtT1s
        HpuX1Hv0bVnF6PF5k1wAa1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5i
        bqqtkotPgK5bZg7QUUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE3OLS
        vHS9vNQSK0MDAyNToMKE7IzXt5axFfwUr7j++wxrA+MU4S5GTg4JAROJDVeWs3cxcnEICexg
        lJj4dAkjhPOJUWJBz0kWCOcbo0TjvVUsMC1nFz9mhkjsZZRo2b8dynnIKPHv1QW2LkYODhYB
        VYnJk6JBGtgEdCW2nfjHCGKLCFhILN6wkBWknlmgk0li+vaZrCAJYYEsiTsbu8E28AooS0x6
        1A9lC0qcnPkEzOYUsJNo/zODCaRZQmAih8TLl1/YIE5ykbj+uIkJwhaWeHV8CzuELSXx+d1e
        qJpsidW/LkHFKyTa7/UwQ9jGErOetYNdxyyQIdH2aC7YAxJARxy5xQIR5pPoOPyXHSLMK9HR
        JgTRqSbxa8oGRghbRmL34hVQEz0knk3eBA3TZcwSt+4/Z53AKDcLyTuzkGybBTSWWUBTYv0u
        fYiwvETz1tnMEGFpieX/OJBULGBkW8UollpQnJueWmxUYAyP7OT83E2M4PSq5b6DccbbD3qH
        GJk4GA8xSnAwK4nw6n1MThXiTUmsrEotyo8vKs1JLT7EaAqMponMUqLJ+cAEn1cSb2hiaWBi
        ZmZobmRqYK4kznuvdW6KkEB6YklqdmpqQWoRTB8TB6dUA9NK+4dW2xOusOtFb37z/rHk7n+n
        Ds+amRu7TH2V9TS+26uSHuVGLlrG+Xjzg7PtdSqb/FRKFrq/uRzFc5Lr8kEN/19B1e5/ew64
        sV4V3aiqm+zLNsOYJ1rQ6Esf5+4zc8w1b7oHPdOuv7D4qc2c28pszzOq9YQKK94X/taxVmqV
        23otsOrjgeaVs5msf+wN+795PeeyJVv6edmVVJ4bCDtNv2Mg8T7edGOUg41Qm2HY+/U7vQ70
        aRVcvGr7tmArw4S7iwW4PENlF+0J/X3kQK/wzmVLbYuOcV6btdjk0oP3nN2fX93Tmv6J6fps
        bR/NL8v00mwU67hU3ONWlbW9DlQN/en38rMsj7mTfaBE8ColluKMREMt5qLiRADUkReOOAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvK7Vp7RUg1cJFg/mbWOz2Pt6K7vF
        lD/LmSw2Pb7GarF5/h9Gi8u75rBZzDi/j8ni8Jt2VovnfUDWql1/GB24PHbOusvucefaHjaP
        zUvqPfq2rGL0+LxJLoA1issmJTUnsyy1SN8ugSvj5+JzbAWzRSsav5xjbGC8JNDFyMkhIWAi
        cXbxY2YQW0hgN6NEW58QRFxG4vbKy6wQtrDE/ZYjQDYXUM19Rond5y6wdTFycLAIqEpMnhQN
        UsMmoCux7cQ/RhBbRMBCYvGGhWD1zAKdTBLTt88EGyQskCXx8OF5NhCbV0BZYtKjfhaIxauY
        JXZNUICIC0qcnPkELM4soC7xZ94lZpBdzALSEsv/cUCE5SWat84Gu5lTwE6i/c8MpgmMgrOQ
        dM9C0j0LoXsWku4FjCyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1kvNzNzGCY0ZLcwfj9lUf
        9A4xMnEwHmKU4GBWEuHV+5icKsSbklhZlVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZq
        akFqEUyWiYNTqoFpb+LDI9eO3o+dxvjGeYXixys7vzztSHCbyLplV/hPo8hpqqVc/0ulnNPZ
        qqvtre91um2yvMYWk9iWedHmeP/upgv/y6Ma3++3/LkmvGIJC5OMZhErt8OBI78tLgm8lVg4
        6zi/WZSHhJXAlKr9ynyNH7kqJzf8vPOr6+RN/Y8y30U36hzOFbt18MrOP0zCmSrOF8KOSxwS
        a+78K73yKpfwNl+1U7e2z23cun/O/LsFy3Y8OzM7UmrbySnVz+/NZSmKurri2QeflJ4Tv71j
        Yq5r/lQ37ld08rQ5nHN5jx2rltnDtAUKuaEsOTca3t0XCWT9cOujYO9nux73A9UX+l5aPGxb
        zM5hVr3xwNki359xSizFGYmGWsxFxYkA8nIVvAgDAAA=
X-CMS-MailID: 20231129081138epcas2p2ba1f0c83f896f36d03110535a1623109
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_36ec1_"
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

------xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_36ec1_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Nov 29, 2023 at 09:00:04AM +0100, Krzysztof Kozlowski wrote:
> On 29/11/2023 08:07, Youngmin Nam wrote:
> > On Tue, Nov 28, 2023 at 03:35:53PM -0600, Sam Protsenko wrote:
> >> On Tue, Nov 28, 2023 at 1:29 AM Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 28/11/2023 02:01, Youngmin Nam wrote:
> >>>> On Mon, Nov 27, 2023 at 10:54:56AM +0100, Krzysztof Kozlowski wrote:
> >>>>> On 26/11/2023 10:46, Youngmin Nam wrote:
> >>>>>> To support affinity setting for non wake up external gpio interrupt,
> >>>>>> add irq_set_affinity callback using irq number from pinctrl driver data.
> >>>>>>
> >>>>>> Before this patch, changing the irq affinity of gpio interrupt is not possible:
> >>>>>>
> >>>>>>     # cat /proc/irq/418/smp_affinity
> >>>>>>     3ff
> >>>>>>     # echo 00f > /proc/irq/418/smp_affinity
> >>>>>
> >>>>> Does this command succeed on your board?
> >>>>>
> >>>> Yes.
> >>>
> >>> Hm, fails all the time one mine.
> >>>
> >>
> >> I tried to test this patch on E850-96, and an attempt to write into
> >> smp_affinity (for some GPIO irq) also fails for me:
> >>
> >>     # echo f0 > smp_affinity
> >>     -bash: echo: write error: Input/output error
> >>
> >> When I add some pr_err() to exynos_irq_set_affinity(), I can't see
> >> those printed in dmesg. So I guess exynos_irq_set_affinity() doesn't
> >> get called at all. So the error probably happens before
> >> .irq_set_affinity callback gets called.
> >>
> >> Youngmin, can you please try and test this patch on E850-96? This
> >> board is already supported in upstream kernel. For example you can use
> >> "Volume Up" interrupt for the test, which is GPIO irq.
> >>
> > 
> > I intened this affinity setting would work only on *Non* Wakeup External Interrupt.
> > The "Volume Up" on E850-96 board is connected with "gpa0-7" and
> > that is Wakeup External interrupt so that we can't test the callback.
> > 
> > I couldn't find out a pin for the test on E850-96 board yet.
> > We can test if there is a usage of *Non" Wake up External Interrupt of GPIO
> > on E850-96 board.
> > 
> > Do you have any idea ?
> 
> Please test on any upstream platform or upstream your existing platform.
> I hesitate to take this change because I don't trust Samsung that this
> was tested on mainline kernel. OK, for sure 100% it was not tested on
> mainline, but I am afraid that differences were far beyond just missing
> platforms. Therefore the issue might or might not exist at all. Maybe
> issue is caused by other Samsung non-upstreamed code.
> 
> Best regards,
> Krzysztof

Sure. Let me find how to test on upstreamed device like E850-96 board.
> 
> 
> 

------xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_36ec1_
Content-Type: text/plain; charset="utf-8"


------xhiRNYr7C6p2kRFttE2KPojvpONXRQ6l4raSmD__Jn20cHwF=_36ec1_--
