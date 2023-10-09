Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB617BD7DF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346020AbjJIKDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346010AbjJIKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:03:04 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7879C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:03:01 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231009100300euoutp02e4c10ff30dafb40e60f807f9125070a8~MaD82rG5A2272022720euoutp029
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:03:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231009100300euoutp02e4c10ff30dafb40e60f807f9125070a8~MaD82rG5A2272022720euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1696845780;
        bh=bbOD6dpPMgs4sWcIym/2jiGXCUrUE/V/IlZWnS2scoI=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=OnnbStIBmz5/1m0uz577OY/4bkvob+VOlQ9ZjZRtvilhYD4EOStsnkW0Tn93P2GJ7
         XEqLm29x3s3+JSqeA4CiMhwqMjhvqjIbaV6aIAefW3l2FjUy99E4XRvSdcfuRZDYTS
         2OxKpaCxjFNULaV0jAauhUyFXmMveD4BSRJIQcMk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231009100259eucas1p2cc0f287ca4c5d07b144fdb7e5cf8f893~MaD8fPRNw2404224042eucas1p2-;
        Mon,  9 Oct 2023 10:02:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E3.AD.11320.3DFC3256; Mon,  9
        Oct 2023 11:02:59 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231009100259eucas1p1721989d67fce38fb2706c38d7c68e594~MaD8FE42F0941209412eucas1p1I;
        Mon,  9 Oct 2023 10:02:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231009100259eusmtrp19534086f81a0bfd93347b0b7e91ba0a9~MaD8ELFSf2365623656eusmtrp1W;
        Mon,  9 Oct 2023 10:02:59 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-24-6523cfd36d60
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.F9.10549.3DFC3256; Mon,  9
        Oct 2023 11:02:59 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20231009100258eusmtip27832a1b676606d808cc3350bc4f95bae~MaD7ONnP-1545515455eusmtip2r;
        Mon,  9 Oct 2023 10:02:58 +0000 (GMT)
Message-ID: <c15cb2ef-81b4-4a07-94a1-4312e7886f4b@samsung.com>
Date:   Mon, 9 Oct 2023 12:02:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/4] Fix Samsung pinctrl driver static allocation of
 GPIO base warning
To:     Mateusz Majewski <m.majewski2@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Language: en-US
In-Reply-To: <20231006125557.212681-1-m.majewski2@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djP87qXzyunGjxuMLJ4MG8bm8Xe11vZ
        Lab8Wc5ksenxNVaLzfP/MFpc3jWHzWLG+X1MFhOPTWa2OPymndVi1a4/jA5cHjtn3WX3uHNt
        D5vH5iX1Hn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJVx4t1LloJOzorVR88zNjCuY+9i5OSQ
        EDCR+DzjOJDNxSEksIJRYl3zXUaQhJDAF0aJ+c/jIBKfGSUWr/7JBNPx4dwxJojEckaJxqtr
        GSGcj4wSLWv+gs3lFbCTeLT/H5jNIqAisfT9ASaIuKDEyZlPWEBsUQF5ifu3ZoDVsAkYSnS9
        7WIDsYUFYiQ+TNrGDGKLCGxllLhwLAVkAbPAQ0aJ83OWgBUxC4hL3HoyH2woJ9CypuffWSDi
        8hLb385hBmmQEPjAIbH8/09GiLtdJLoOLYb6Wlji1fEtULaMxOnJPSwQDe2MEgt+32eCcCYw
        SjQ8vwXVbS1x59wvoNUcQCs0Jdbv0gcxJQQcJbo+mkOYfBI33gpC3MAnMWnbdGaIMK9ER5sQ
        xAw1iVnH18FtPXjhEvMERqVZSMEyC8lns5B8Mwth7QJGllWM4qmlxbnpqcVGeanlesWJucWl
        eel6yfm5mxiBCer0v+NfdjAuf/VR7xAjEwfjIUYJDmYlEV7dUoVUId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBiYP+ym/4iwUzMQPmV6bomdY8KY3dNk7
        +QtNS+NW3Ndx1OxfV8KVHn7ZRyd9nt1F6QmpRVP4DkZOtXie5uQXfuNfbSf7wrZqRdekqqSp
        Qq7b5/wqWvwx7XxLfO+B/9NlVuYb3//3QWvffiMb9c+L1C7o7/I9LruovHLHSfZd38SKE5vD
        LX6Xv2he5H9+Z+UTtXRevpwo5SM8n2rb/G7qaqmoGsyv+6GZ8zz+3kKNl0XTZr4+Whsu9WTe
        s5d/GF41B9u9tbpbbHLBM1ZpeaX4B/0LB9livY+Vse9b4vP8/sWf52b4dyRLC6ntEmy4En7j
        bPUFh+73KsadJufy+u/tOXf0Saiy4j7PjdV832wXByuxFGckGmoxFxUnAgAxfkPyvwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7qXzyunGux/JGHxYN42Nou9r7ey
        W0z5s5zJYtPja6wWm+f/YbS4vGsOm8WM8/uYLCYem8xscfhNO6vFql1/GB24PHbOusvucefa
        HjaPzUvqPfq2rGL0+LxJLoA1Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ
        384mJTUnsyy1SN8uQS/jxLuXLAWdnBWrj55nbGBcx97FyMkhIWAi8eHcMaYuRi4OIYGljBLn
        9jSxQiRkJE5Oa4CyhSX+XOtigyh6zyix+n83G0iCV8BO4tH+f2CTWARUJJa+P8AEEReUODnz
        CQuILSogL3H/1gywGjYBQ4mut11gvcICMRL9C6axgAwVEdjKKLHm4EUwh1ngMaPElJcPwVYL
        CUxklNh3NRnEZhYQl7j1ZD7YBk6gzU3Pv7NAxM0kurZ2MULY8hLb385hnsAoNAvJIbOQtM9C
        0jILScsCRpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgVG57djPzTsY5736qHeIkYmD8RCj
        BAezkgivbqlCqhBvSmJlVWpRfnxRaU5q8SFGU2BoTGSWEk3OB6aFvJJ4QzMDU0MTM0sDU0sz
        YyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGJr+NAZlOmV86uoKrsxQc7ivMFH05IfIEU1u5
        xokdSfwzHZUfvFFpLN737Lrmr3tLuNu9ck48j5C0vlt69qjuiRd2B7r+X/UL1pjxS9WyyHRq
        8euwkDtVG+ar5pz0/O8WPPXJ/jT/597VsR3rtU+FXFp/5ebl0EjdC48Nu669Pr/f/R/vipK/
        Srlq6x7LxRtOlytsSVdizT8vtEvi0wO/c46c6QVJUit+d/T3KT7Q7rPjmN669nJf2ua3+rOi
        bf/Jaemf+Cf0ZJmWVcB0+5knV2W+nLXmw5cpE49NeVr3Nc/v9ic2mxKZFw4dMQdljPalXWG7
        /tdYm3n++QjHjI1TP5lYSszYVGN9pvGX9L1nT5VYijMSDbWYi4oTAftRI41TAwAA
X-CMS-MailID: 20231009100259eucas1p1721989d67fce38fb2706c38d7c68e594
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3
References: <CGME20231006130032eucas1p18c6f5c39614768911730fa6ed0201ee3@eucas1p1.samsung.com>
        <20231006125557.212681-1-m.majewski2@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.10.2023 14:55, Mateusz Majewski wrote:
> The object of this work is fixing the following warning, which appears
> on all targets using that driver:
>
> gpio gpiochip0: Static allocation of GPIO base is deprecated, use dynamic allocation.
>
> This needs a small refactor to how we interact with the pinctrl
> subsystem. Finally, we remove some bookkeeping that has only been
> necessary to allocate GPIO bases correctly.
>
> Mateusz Majewski (4):
>    pinctrl: samsung: defer pinctrl_enable
>    pinctrl: samsung: use add_pin_ranges method to add pinctrl ranges
>    pinctrl: samsung: choose GPIO numberspace base dynamically
>    pinctrl: samsung: do not offset pinctrl numberspaces
>
>   drivers/pinctrl/samsung/pinctrl-samsung.c | 56 ++++++++++++-----------
>   drivers/pinctrl/samsung/pinctrl-samsung.h |  4 +-
>   2 files changed, 31 insertions(+), 29 deletions(-)

Just to let everyone know - I've tested this patchset on our test farm 
and found no regressions on various Exynos based boards.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

