Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F178FA19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbjIAIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjIAIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:41:11 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0715AE7C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:41:04 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230901084101euoutp016957d85c50ce7d23f0cca3065be181a6~AubhxBMhH0675706757euoutp01B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:41:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230901084101euoutp016957d85c50ce7d23f0cca3065be181a6~AubhxBMhH0675706757euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1693557661;
        bh=CGfcHhAknNmRLRtPsz9TJ84qeZVwd/lWgrb2qjzXDUA=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=h3PLZqSk1FZjWyqnBQZ+fOGFgpNvmOvefhqRibwsf3/mNIm0q+6+qNVS2eBIiQ7nX
         7CYkxA7217X7Zgmowy7onwPXWaxJnYZU75U7TdPkg06GXAj6fb5khLJ1A8lwY6H5V8
         SzDYxnKzXEsYpvBb9Cro2fmop/lwSfdz3Qc4K5YA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230901084101eucas1p28d9fe4bd0bfc538ff17143f2f82973f5~AubhVgbcR1920219202eucas1p23;
        Fri,  1 Sep 2023 08:41:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 38.68.42423.D93A1F46; Fri,  1
        Sep 2023 09:41:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230901084100eucas1p294e4cb447d47c67f8be4387702b07dc0~Aubg68mPS1944719447eucas1p2E;
        Fri,  1 Sep 2023 08:41:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230901084100eusmtrp1a277e2397ac5a4ecdedd98eb6e4d8c87~Aubg6OM7r2289322893eusmtrp1U;
        Fri,  1 Sep 2023 08:41:00 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-35-64f1a39d17ea
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.6D.14344.C93A1F46; Fri,  1
        Sep 2023 09:41:00 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230901084059eusmtip1ef23d736e24bafeb4760f3a7876badb8~Aubf_4Cj02170521705eusmtip1Q;
        Fri,  1 Sep 2023 08:40:59 +0000 (GMT)
Message-ID: <afbdce92-beb9-cb7f-305f-968c71dde838@samsung.com>
Date:   Fri, 1 Sep 2023 10:40:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 04/11] thermal: exynos: remove fine-grained clk
 management
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mateusz Majewski <m.majewski2@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <a3b9ff0f-fff9-9439-5ec9-95a4de9bdfaa@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7djP87pzF39MMWhdyWXxYN42NovD8yss
        pj58wmbxfct1Jos1e88xWcz7LGsx/8g5Vou+Fw+ZLfa+3spu8e1KB5PFpsfXWC0u75rDZvG5
        9wijxYzz+5gsJh6bzGwx98tUZovWvUfYLZ487GNzEPLYOesuu8fiPS+ZPDat6mTzuHNtD5vH
        5iX1Hn1bVjF6fN4kF8AexWWTkpqTWZZapG+XwJWxcNdG9oJHXBVzm44xNjA+5uhi5OSQEDCR
        uH50K3sXIxeHkMAKRolNZ6+zQDhfGCW2Pb7FBOF8ZpS423WFEaZl1r1djBCJ5YwSc55/Y4Nw
        PjJKzDyyjA2kilfATuLAwmdgNouAisSaCTtZIOKCEidnPgGzRQVSJZ7dmsMOYgsLBEjcuzUL
        bAOzgLjErSfzmUBsEYF2Jonb1zlAFjALHGKW+LQRYhCbgKFE19susAWcQMsW/PrODNEsL7H9
        7RxmkAYJge2cEtdmTmOBuNtF4tSvJ8wQtrDEq+Nb2CFsGYnTk3tYIBraGSUW/L7PBOFMYJRo
        eH4L6mtriTvnfgGt4wBaoSmxfpc+RNhR4k7zY1aQsIQAn8SNt4IQR/BJTNo2nRkizCvR0SYE
        Ua0mMev4Ori1By9cYp7AqDQLKVxmIfl/FpJ3ZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0
        L10vOT93EyMwCZ7+d/zTDsa5rz7qHWJk4mA8xCjBwawkwhtr9i5FiDclsbIqtSg/vqg0J7X4
        EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA1Ndq9jzt8/3/pN8oDPF3XeFsvaeLMkr
        837LxwTYNe7abKVY53f0VtDp/l9J9evWhzS0W9nt2Ffb+GRyydl/74siWpu4jBb0tzgmFByp
        eVR8Y9+cHwcrN7Our7ydPG3d59nFv/grXf6e3vH39dSbByfsVesWvK62U9tp2pQN9yfMNTyg
        9yr5lGPAH2Onq1NzTkw4Y5nRwKvN8K00SG+B+SfPevlKX/HYBhvHL+x/+3xDu9bZHU3pOr71
        bM2O5P4pyZ7bO26GB1Z85jj73JUpoJnjcMXRabMiC7b+DH+4UrnKcY/TSa8WjSWXem+E/vIw
        +//kxdUT/zQPXl1f/LWLz8ria+utFW8D5i9cHWTf9O+MEktxRqKhFnNRcSIAlpoClfEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7pzFn9MMfgwS8PiwbxtbBaH51dY
        TH34hM3i+5brTBZr9p5jspj3WdZi/pFzrBZ9Lx4yW+x9vZXd4tuVDiaLTY+vsVpc3jWHzeJz
        7xFGixnn9zFZTDw2mdli7pepzBate4+wWzx52MfmIOSxc9Zddo/Fe14yeWxa1cnmcefaHjaP
        zUvqPfq2rGL0+LxJLoA9Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384m
        JTUnsyy1SN8uQS9j4a6N7AWPuCrmNh1jbGB8zNHFyMkhIWAiMeveLkYQW0hgKaPEmv+OEHEZ
        iZPTGlghbGGJP9e62LoYuYBq3jNKTD6zDSzBK2AncWDhMzYQm0VARWLNhJ0sEHFBiZMzn4DZ
        ogKpEt9v7QOrERbwkzi98j7YMmYBcYlbT+YzgQwVEWhnkji8/wqYwyxwhFni+MsjjBDrfjJK
        NLyaxwzSwiZgKNH1tgtsFCfQ6gW/vjNDjDKT6NraBTVWXmL72znMExiFZiG5ZBaSjbOQtMxC
        0rKAkWUVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYNRvO/Zzyw7Gla8+6h1iZOJgPMQowcGs
        JMIba/YuRYg3JbGyKrUoP76oNCe1+BCjKTA4JjJLiSbnA9NOXkm8oZmBqaGJmaWBqaWZsZI4
        r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDkx3ruk/+F/0WSyZ8P8xx+MBW5itRyaEM5lNUOLN6
        7A6/1r3dqVL/m8nWI5XBVyOzqP7c4kfin89IvEk/JfOqxPmTBEM8zx9t9rpHu4p3NKutTfm2
        ZdnhO9zbcvymTHglsefRiWf7v8Q5f3hx8lOKx4cLAZsOZ30LnSGxM/Taq+2TI9+y8oe9l27h
        YP8n9O9C42R+3XV7l97g4XxRfkJQN+Mj233tev8ZqZlSKnuSZ9Y90flwqTnMM+tf+X6uB0yH
        l319FfpUcIbDao6f8QfCFmxt4nBt4k5uUMm3zdufaSKWGf4nqbzHvpQh/unn3mP55kpdjr+c
        Fq31FpgwK3ZXPffN+Vpm10v4F953WbTMRImlOCPRUIu5qDgRALBmaHuDAwAA
X-CMS-MailID: 20230901084100eucas1p294e4cb447d47c67f8be4387702b07dc0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6
References: <20230829091853.626011-1-m.majewski2@samsung.com>
        <CGME20230829092412eucas1p2b79a6f90b9077a3a5486845b7e68bbc6@eucas1p2.samsung.com>
        <20230829091853.626011-5-m.majewski2@samsung.com>
        <a3b9ff0f-fff9-9439-5ec9-95a4de9bdfaa@linaro.org>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2023 11:56, Krzysztof Kozlowski wrote:
> On 29/08/2023 11:18, Mateusz Majewski wrote:
>> This clock only controls the register operations. The gain in power
>> efficiency is therefore quite dubious, while there is price of added
>> complexity that is important to get right (as a register operation might
>> outright hang the CPU if the clock is not enabled).
> So once it is done right, this stops being argument. The benefit is to
> keep this clock disabled most of the time, which now we lost.
>
> I don't find this patch correct approach.

I've suggested this change while playing with this driver.

For me turning AHB clock on/off during normal driver operation seems to 
be over-engineering and really gives no real power saving benefits, 
especially if thermal driver is the only one that does such fine-grained 
clock management (none of the Exynos supported in mainline does that). 
Removing it simplifies code and makes it easier to understand or read, 
as the current code already was somehow problematic to understand and 
unintuitive:

https://lore.kernel.org/all/c3258cb2-9a56-d048-5738-1132331a157d@linaro.org/

Taking into account that the driver is not really maintained, making it 
simpler without noticeable feature loss counts as a benefit for me.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

