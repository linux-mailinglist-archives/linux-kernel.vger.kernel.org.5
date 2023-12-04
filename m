Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D3B803998
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbjLDQF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLDQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:05:23 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5445109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:05:28 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231204160526euoutp014b34789b7e5e0bd31e24dd3d1c781bce~drIZJ9eCJ1209312093euoutp01H
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:05:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231204160526euoutp014b34789b7e5e0bd31e24dd3d1c781bce~drIZJ9eCJ1209312093euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1701705927;
        bh=zz9G4y0Ud8vpL8Bnr2P+LIokVoL00b4XUpKl0V85uqQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=pI+V+vGs6cNzxTKm7NBsepYJfMd8YTL/nFmd7v2ZzYNUh7a+plokBrOhp5ro1/LJi
         jpMhw6Y4T16QHjN0uUYzvYxUShd9OGnIBxv2bCiO64Tn5ipKWw+KmzNka1REef+2JR
         Vrt+bqmjWt9Don1LevT+8ZQiDTTKnyQWqk11At7k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20231204160526eucas1p1478a32a0ccae9240a65108463d885d4d~drIYtSIWV0069400694eucas1p1g;
        Mon,  4 Dec 2023 16:05:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 35.E2.09814.6C8FD656; Mon,  4
        Dec 2023 16:05:26 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20231204160526eucas1p2b1d07c5b37dd9b9f4c794238bcbc286d~drIYTC4LN3259832598eucas1p2Z;
        Mon,  4 Dec 2023 16:05:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20231204160526eusmtrp1f14a5f0eee14984c2e74e8f80d6dfb02~drIYSTJbi2558925589eusmtrp1H;
        Mon,  4 Dec 2023 16:05:26 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-34-656df8c6cab1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 58.71.09274.5C8FD656; Mon,  4
        Dec 2023 16:05:25 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231204160525eusmtip142eb77296bf5de4ee75f514252538524~drIXpuWh91831518315eusmtip1M;
        Mon,  4 Dec 2023 16:05:25 +0000 (GMT)
Message-ID: <8e84e9dc-c02c-4164-9c71-0e5cdb379cdb@samsung.com>
Date:   Mon, 4 Dec 2023 17:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/panfrost: Add gpu_irq, mmu_irq to struct
 panfrost_device
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, steven.price@arm.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, krzysztof.kozlowski@linaro.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20231204114215.54575-3-angelogioacchino.delregno@collabora.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7rHfuSmGhz9L2px4voiJotLKyUs
        Tp85xWTxf9tEZosrX9+zWWw+18Nqsff1VnaLy7vmsFks/LiVxaKtcxmrxf89O9gtGo8AlWx5
        M5HVgddjzbw1jB477i5h9Nj7bQGLx85Zd9k9Nq3qZPO4c20Pm8e8k4Ee97uPM3lsPl3t8XmT
        XABXFJdNSmpOZllqkb5dAlfGv4sbmQo+slWsvHyTsYHxAWsXIyeHhICJRNPHFcxdjFwcQgIr
        GCWub9jODuF8YZRYP2MBlPOZUeLfv/fsMC3nrk9igkgsZ5Q4//c7G4TzkVHi7LpOFpAqXgE7
        iQmrLzGC2CwCKhIrf26CigtKnJz5BMwWFZCXuH9rBthUYYEoic9Lz4PFmQXEJW49mc8EYosI
        ZEo8mvES7AxmgWlMEnsPPQYbyiZgKNH1tosNxOYU8JVoWPKcCaJZXmL72zlgH0kIrOaUeLd/
        PZDDAeS4SGxY7gPxgrDEq+NboN6RkTg9uYcFor6dUWLB7/tMEM4ERomG57cYIaqsJe6c+8UG
        MohZQFNi/S59iLCjxOYbL1gg5vNJ3HgrCHEDn8SkbdOh1vJKdLQJQVSrScw6vg5u7cELl5gn
        MCrNQgqWWUjen4Xkm1kIexcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITHen/x3/
        soNx+auPeocYmTgYDzFKcDArifDOu5WdKsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUgg
        PbEkNTs1tSC1CCbLxMEp1cA0/eg7Lwv92YlzGu7V3/OpOa159aa99YknLL2r3obsupb4Rlef
        P+3No/VXw6/aLyw98Xeh1i7DajO71uWLPRa9/6l9NTopo/SO9aGwDWVfZNympbhyfOwNZy88
        I1fkNuvov0f3JM5+v+3ye4mMS/0MmVm/5nK+s54p/VH99faHXZqGqzceeMRwbuYe5iQDtzrD
        zNdrckQe7JO1Cc2UzMgS4uC//bUg77wMd+2ONdt/WFwU1E/dyHLi1cdf55fbnL36bYdSWWD4
        g/Yj51ans3ixXXmkYK1yhClId0vSq40ZXjFXGqafsVISctfece1EgfMZy5v1JTUFFV/WFhRP
        ktvaNnF93a4FM/f9kjza1MuorcRSnJFoqMVcVJwIAGzHbhHmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsVy+t/xu7pHf+SmGpy6Y2Nx4voiJotLKyUs
        Tp85xWTxf9tEZosrX9+zWWw+18Nqsff1VnaLy7vmsFks/LiVxaKtcxmrxf89O9gtGo8AlWx5
        M5HVgddjzbw1jB477i5h9Nj7bQGLx85Zd9k9Nq3qZPO4c20Pm8e8k4Ee97uPM3lsPl3t8XmT
        XABXlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G
        v4sbmQo+slWsvHyTsYHxAWsXIyeHhICJxLnrk5i6GLk4hASWMkq8OtHNBpGQkTg5rQGqSFji
        z7UuNoii94wSb9s/M4IkeAXsJCasvgRmswioSKz8uYkFIi4ocXLmEzBbVEBe4v6tGewgtrBA
        lMTnpefB4swC4hK3nsxnArFFBDIlXk6/xg6ygFlgCpPEox1vmSG2PWaU+LP/C9gZbAKGEl1v
        u8DO4xTwlWhY8pwJYpKZRNfWLkYIW15i+9s5zBMYhWYhOWQWkoWzkLTMQtKygJFlFaNIamlx
        bnpusZFecWJucWleul5yfu4mRmCEbzv2c8sOxpWvPuodYmTiYDzEKMHBrCTCO+9WdqoQb0pi
        ZVVqUX58UWlOavEhRlNgaExklhJNzgemmLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU
        7NTUgtQimD4mDk6pBiaD66KJ9jtZTFb3JSWYXI98e8DVRVw80I9hc7IzA+/TMzZOGhFPGTjt
        3rr+37Z5yufF4c/su0vdFlZuTJeaWPHvdPRF55+vq38ue8g0o/W64YxgEf4T3C+Tdqi43TD0
        nMisdTNwbfrqYmvt2eJyLJNOyNx4croofJvA9lvybxN8RUrWHcnruz3dIZdZxn/FxBVzVEPc
        nSVfTTmfoN4oUDL31V7p/j/LVgby5+3cZadg5JyVJrd27oeEk99W2jYI6WjM57DubTtvu+mZ
        QWRb6O4e5+ds/h8aprPZCrvfE/pkkn9/Wu3ZtEPVp9fvqj+58sZviYp9J9/XbptsGTZVsa5d
        bYbMwlseH5x2dG/4qKXEUpyRaKjFXFScCADnMCIceQMAAA==
X-CMS-MailID: 20231204160526eucas1p2b1d07c5b37dd9b9f4c794238bcbc286d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231204114226eucas1p21aed28946037714e187011e4ea17838d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231204114226eucas1p21aed28946037714e187011e4ea17838d
References: <20231204114215.54575-1-angelogioacchino.delregno@collabora.com>
        <CGME20231204114226eucas1p21aed28946037714e187011e4ea17838d@eucas1p2.samsung.com>
        <20231204114215.54575-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.2023 12:42, AngeloGioacchino Del Regno wrote:
> In preparation for adding a IRQ synchronization mechanism for PM suspend,
> add gpu_irq and mmu_irq variables to struct panfrost_device and change
> functions panfrost_gpu_init() and panfrost_mmu_init() to use those.
>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>


> ---
>   drivers/gpu/drm/panfrost/panfrost_device.h |  2 ++
>   drivers/gpu/drm/panfrost/panfrost_gpu.c    | 10 +++++-----
>   drivers/gpu/drm/panfrost/panfrost_mmu.c    | 10 +++++-----
>   3 files changed, 12 insertions(+), 10 deletions(-)
>
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

