Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A97C9F4C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 08:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjJPGLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 02:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPGLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 02:11:00 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CDAD9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 23:10:52 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231016061048epoutp03f6842584e80e985daec4a632d779d868~OgaN1EpUU3052530525epoutp03L
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:10:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231016061048epoutp03f6842584e80e985daec4a632d779d868~OgaN1EpUU3052530525epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697436648;
        bh=FgxNYSSeGvlU+AaHBZbNV92eyyDkZgy9stIj+3PKOsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X4whoqlaABfCS9waM7H/+vSMVzeChK4xY5Qjk1/fUELc3vIsL8JQVrCI4zTOaPMla
         YNm2jvJnMsi7sQhntH6INg5cu898iSSqp46Y08R/QjBo1rwfa8M0HcwAGf3xz2twZP
         JUN6ZD0SkgLbGfm2GP7mfdDgBjUtpRBj+n+eLy98=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20231016061048epcas5p1d6c33706134827eed6e1e1284c6153f0~OgaNbFJGQ2961229612epcas5p1T;
        Mon, 16 Oct 2023 06:10:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4S86DQ6mjYz4x9Q2; Mon, 16 Oct
        2023 06:10:46 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.A9.09672.5E3DC256; Mon, 16 Oct 2023 15:10:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20231016060514epcas5p2ab38287c243a9539736453b4cb34e447~OgVWhTVjQ1821118211epcas5p21;
        Mon, 16 Oct 2023 06:05:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231016060514epsmtrp1f7b32ea1f5bc7a03f359f8575fcc9222~OgVWgjHMm1604916049epsmtrp1W;
        Mon, 16 Oct 2023 06:05:14 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-fb-652cd3e5dec7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.6C.08755.A92DC256; Mon, 16 Oct 2023 15:05:14 +0900 (KST)
Received: from ubuntu.. (unknown [109.105.118.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20231016060513epsmtip2096c73e8a0eba6304e4f7bff8f2f8e56~OgVVTnw5k1727517275epsmtip2g;
        Mon, 16 Oct 2023 06:05:12 +0000 (GMT)
From:   Min Li <min15.li@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, dlemoal@kernel.org
Cc:     gregkh@linuxfoundation.org, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        min15.li@samsung.com, stable@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH v5] block: add check that partition length needs to be
 aligned with block size
Date:   Mon, 16 Oct 2023 14:03:11 +0000
Message-Id: <20231016140311.32367-1-min15.li@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629073322.GB19464@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmuu7TyzqpBg9Oa1usvtvPZvFgv71F
        8+L1bBZzX19isVi5+iiTxdOrs5gs9t7Stri8aw6bxfJVHUwWZyd8YLVYsPERo8XvH3PYHHg8
        Nq/Q8rh8ttRj06pONo/9c9ewe+y+2cDm0dv8js2jb8sqRo/Pm+QCOKKybTJSE1NSixRS85Lz
        UzLz0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOATlVSKEvMKQUKBSQWFyvp29kU
        5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGdcP2ZbIFTRss+ngZG7
        i5GTQ0LARGLp3U3sXYxcHEICuxklzr9/wAzhfGKUOPt6IxuE841R4sHc1cwwLddu/oOq2sso
        senAMqj+54wSk24+BcpwcLAJKEtsW+oD0iAiYCzx/+0kVpAaZoENjBLz7vxnAkkIC6RIXP76
        lRXEZhFQlWj7/4kRxOYVsJSYte8nI8Q2eYn9B8+CbeYU0JHo+X+PDaJGUOLkzCcsIDYzUE3z
        1tlQ183kkDgzRxnCdpHYcvkfK4QtLPHq+BZ2CFtK4mV/GzvInRICxRIvf4RBhGskdn+7zQRh
        W0tsW7+OCaSEWUBTYv0ufYiwrMTUU+uYILbySfT+fgJVziuxYx6MrSTx98I5qOslJBbvfwh1
        gYfExf5esIuFBOol1v5oY5zAqDALyTOzkDwzC2HzAkbmVYySqQXFuempxaYFxnmp5fD4Tc7P
        3cQITrha3jsYHz34oHeIkYmD8RCjBAezkghverBOqhBvSmJlVWpRfnxRaU5q8SFGU2BoT2SW
        Ek3OB6b8vJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamPrN78zt
        ubXjwQTWIpHdCfqbd8ndPmP7K+rjOYdrLP+5DFZHPQk3ef6nMuyB1tuJKccXsFb68Cbm+WiL
        FG/cVHTr+MKDfO1/nHhO69syzWgrz/K/rXC9fE7hjMIz//ekandcMJ260WTb+jklxWzP9Er1
        NTfcYG6tsprQ4nnoRMP1w2qOxz7k3Fp8MnHK9kvVEnxvLPX/fNM+wfJuj8aTR/NuMXOu7K34
        0Py8esNZpzTr04fSfZ+vMVN/9Y+nJmQJh++k667W0yv37bzZ+83R37TibBznw7OvNQuWfGEx
        4E9oW9b9K+971PXgv0ZJyhEV6Ql3ZnK8U9RoTT0fXy3Z4iW+XH3u502p66KKi5dwdSmxFGck
        GmoxFxUnAgBYKN0fQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsWy7bCSvO6sSzqpBkve81msvtvPZvFgv71F
        8+L1bBZzX19isVi5+iiTxdOrs5gs9t7Stri8aw6bxfJVHUwWZyd8YLVYsPERo8XvH3PYHHg8
        Nq/Q8rh8ttRj06pONo/9c9ewe+y+2cDm0dv8js2jb8sqRo/Pm+QCOKK4bFJSczLLUov07RK4
        Mq4fsy0QqmjZ59PAyN3FyMkhIWAice3mP+YuRi4OIYHdjBLfPk1khEhISJyf94sNwhaWWPnv
        OTtE0VNGiYd/JzB1MXJwsAkoS2xb6gNSIyJgLnFl121GkBpmgR2MEm/WbWEBSQgLJEnM+dkK
        NohFQFWi7f8nsAW8ApYSs/b9hFomL7H/4FlmEJtTQEei5/89sHohAW2J1/O7WSDqBSVOznwC
        ZjMD1Tdvnc08gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxguNC
        S3MH4/ZVH/QOMTJxMB5ilOBgVhLhTQ/WSRXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VI
        ID2xJDU7NbUgtQgmy8TBKdXA5Jo59TTnI8kJE5Q5RTaIRM48r57fnLS8ksVospoOj25I+4qI
        h9pLdljtnLb5y1pN8T/ODipqx57nX+01Snr89E3G1dP6N23FmBmnx6w0uj3p5QwTZvXnom03
        ubLfP3Ke5h+rcmj69G0XNv0XPlgl4RjP2ac+de7WRabPo8/JHJ8m7Ri4bv+KmMx/3N9/d3zz
        kHohlNbtsP/SvkkFKQb7Z+wrfKKm9n3PzpLpPbcXHI5Y0PJSkkN5y2W5Za8erPWKDtxd4RHg
        k29wpGzWbf6YEsZD0TNMMtiSXU2u7n0cv3/u/wMdydElSl/K+pdan5+Szdi08VdGXt2sZ19v
        3EwwfFL83mnjH7endUtka8IZFZVYijMSDbWYi4oTAfyIjkP6AgAA
X-CMS-MailID: 20231016060514epcas5p2ab38287c243a9539736453b4cb34e447
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231016060514epcas5p2ab38287c243a9539736453b4cb34e447
References: <20230629073322.GB19464@lst.de>
        <CGME20231016060514epcas5p2ab38287c243a9539736453b4cb34e447@epcas5p2.samsung.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks

Min li
