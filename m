Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A707C6B7F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343805AbjJLKvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbjJLKvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:51:17 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E890
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:51:13 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231012105112euoutp016fb3c662d45cb85c504331e2e0dabbb5~NVp41Dn_F1006310063euoutp01X
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:51:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231012105112euoutp016fb3c662d45cb85c504331e2e0dabbb5~NVp41Dn_F1006310063euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697107872;
        bh=yM6GesTFGNN6wdIAfDvDUqkTsSxaBB0xHy+wg5fuqa8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Fs66bgOwXT0iqOrj66gar/Si1oEbFiXewEaPFQJj403u2CM2wpnpAvTmO41zTaWJD
         UE3oq1rM0YjdKyPDdG5yXWf7e5c4BFJJ4KrWFkfczbktjHY8Pkd5CfmwOuGP9/7IfK
         y5QeCiwDjLjaGZNFBlPNq1b+CLh64rgRDEOHVCQ8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231012105111eucas1p27c6f0c3c5d4a1aee82addf53ea79b070~NVp4e6oz80057000570eucas1p2U;
        Thu, 12 Oct 2023 10:51:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 1A.55.42423.F9FC7256; Thu, 12
        Oct 2023 11:51:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231012105111eucas1p237cf93ecbccf99b5360ca67caad1a59a~NVp4MQvns0074100741eucas1p2C;
        Thu, 12 Oct 2023 10:51:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231012105111eusmtrp1bcf19385802fd10df766d52131dde64f~NVp4Lt-FO3058330583eusmtrp1t;
        Thu, 12 Oct 2023 10:51:11 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-62-6527cf9fb3e6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3E.B4.25043.F9FC7256; Thu, 12
        Oct 2023 11:51:11 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231012105111eusmtip16fdf470ddaf0ef66f05476dff31274c1~NVp31gUEA2941729417eusmtip1p;
        Thu, 12 Oct 2023 10:51:10 +0000 (GMT)
Message-ID: <14c0a0b4-e752-4e6a-98d9-52f230060103@samsung.com>
Date:   Thu, 12 Oct 2023 12:51:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: cec: meson: always include meson sub-directory
 in Makefile
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <788e7ae5-1560-4f6f-b6b8-930ce6a9cedb@xs4all.nl>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned3559VTDZ4fU7e4OPMui8WC2dwW
        l3fNYbPo2bCV1WLZpj9MDqwem1Z1snlsXlLv8XmTnMepr5/ZA1iiuGxSUnMyy1KL9O0SuDJe
        35zJVrCXpeL12WbmBsabzF2MnBwSAiYSe7/dYuti5OIQEljBKHHl43Z2kISQwBdGiQM7iiES
        nxkl/l75yAbTsW/vQWaIxHJGiZmnFkI5HxklNkz8xAhSxStgJ7HrwTSwUSwCqhJf7/5lgYgL
        Spyc+QTMFhWQl7h/awZQDQeHsECExN6jiSBhZgFxiVtP5jOBzBQR6GWU+LLsGhtEQk/iXdMh
        JhCbTcBQouttFxtIL6eArcTpU2oQJfIS29/OAbtHQuAAh8Tz1z8ZIa52kfiz7QYThC0s8er4
        FnYIW0bi9OQeFoiGdkaJBb/vM0E4ExglGp7fguq2lrhz7hfYNmYBTYn1u/Qhwo4Sf9ZeZwUJ
        SwjwSdx4KwhxBJ/EpG3TmSHCvBIdbUIQ1WoSs46vg1t78MIl5gmMSrOQQmUWkvdnIXlnFsLe
        BYwsqxjFU0uLc9NTiw3zUsv1ihNzi0vz0vWS83M3MQITzOl/xz/tYJz76qPeIUYmDsZDjBIc
        zEoivI8yVVKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUa
        mGY1TYts7Ly+Te1EW8URBdbPufPPLNN/7hJnP/ngFb3j0zPFnc2Mpz3Rso7cPL/lnp5kgtHu
        qfp1h2uXp5ffebZ+zfQcc+nCtd+S7pSvZV1jd/pt1vq9TRkHO2dXTFfoUXyiPf2hYRVrhJmG
        56/bymcnVi2TK/vMYpTTMOGA8btfdV9vGE25dGyd1e6LHvfKPgiJeKhdXFkd27JB9/5Pyb7K
        TRMP1Jq+nblPvUHarYy5+O73iy+YtdZ118ll1bw42RHceqJ9snG/WIhQn/vung6rNj5VBbOk
        9YI1hqVicw7oub449O8Di/Wv+ffk5qQKRk/y8j+p96zn3cWDizfluAnpMH77HsTzbqNb2976
        N0osxRmJhlrMRcWJAEl/8AefAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xu7rzz6unGvS/E7a4OPMui8WC2dwW
        l3fNYbPo2bCV1WLZpj9MDqwem1Z1snlsXlLv8XmTnMepr5/ZA1ii9GyK8ktLUhUy8otLbJWi
        DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJe35zJVrCXpeL12WbmBsabzF2M
        nBwSAiYS+/YeBLK5OIQEljJKbDv3jQUiISNxcloDK4QtLPHnWhcbRNF7RonzTZ/BErwCdhK7
        HkxjB7FZBFQlvt79ywIRF5Q4OfMJmC0qIC9x/9YMsBphgQiJP0u7wHqZBcQlbj2ZzwQyVESg
        l1GivX05I0RCT+Jd0yEmiG3HGCW2tLwDm8QmYCjR9RbkDA4OTgFbidOn1CDqzSS6tnZB9cpL
        bH87h3kCo9AsJHfMQrJvFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMqm3H
        fm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeB9lqqQK8aYkVlalFuXHF5XmpBYfYjQFBsZEZinR5Hxg
        XOeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTAtceL8XhIofyTW
        6GbpMo+pvw1ntLwx7tgqpmCrq/xTtePl4obvB7wkXgZ1lUmLeOT937mxOt2+ofnTX5+UNk/p
        wlNZV403b9LL1tkapiSlOmf9jSJ3zq/mNdqzyr9mPLG4VZ+xNLjR9VaozM2j65iddXae0Nkt
        dbfySteb3rKY37ExWiEaV07yfluqfn6qPnN6WuK3XXdENn59ffWToP8RhttJ92T1kpL0Z8bc
        FyhO+FtudWbNsurOy2tkRFpMPV93TJQ3De7s2/4+83IVey3HpuUME6ZvVON5ZKaltoHxyyT5
        /4H3jszfNr/s3rHH52S09vSmNPvKJc9nWn498HLkyZz7OgZ/NhSaKsr0z1NiKc5INNRiLipO
        BABBGx0QMwMAAA==
X-CMS-MailID: 20231012105111eucas1p237cf93ecbccf99b5360ca67caad1a59a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b
References: <CGME20231012103531eucas1p1f370bddcb690aa421498e961f4081f2b@eucas1p1.samsung.com>
        <20231012103525.3381314-1-m.szyprowski@samsung.com>
        <788e7ae5-1560-4f6f-b6b8-930ce6a9cedb@xs4all.nl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.2023 12:42, Hans Verkuil wrote:
> On 10/12/23 12:35, Marek Szyprowski wrote:
>> 'meson' directory contains two separate drivers, so it should be added
>> to Makefile compilation hierarchy unconditionally, because otherwise the
>> meson-ao-cec-g12a won't be compiled if meson-ao-cec is not selected.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Does this need a Fixes tag?

Fixes: 4be5e8648b0c ("media: move CEC platform drivers to a separate 
directory")

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

