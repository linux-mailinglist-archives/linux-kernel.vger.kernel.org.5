Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9AE7561B8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjGQLif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjGQLid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:38:33 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EB1716
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:38:06 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230717113758epoutp04a5eaf3bce8b79ed547839b7b069d3e75~ypK427ntu3057830578epoutp04U
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:37:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230717113758epoutp04a5eaf3bce8b79ed547839b7b069d3e75~ypK427ntu3057830578epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689593878;
        bh=+14wjOmfGISgMaiKf6FTdHxcFzhaPxAZxa4WsygZgG0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=eyZoQ68YuhTE4U/KFgJH7FWiFcy8p9/NLWX7lz7OaDLckJFyRtHHcuep2We1y/7T1
         38trx77gwPsh7UMzw8xly1lnfHC98ACE5oyuDvHtEEIjvWJkWrK/q9svjvTsP8QMIc
         SI1WRtP1VPY+aL7CNxq4+zOs+2wM/nE61I/YTV6A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230717113758epcas5p1cfeb3845c81781bc26eea4a544acdf7b~ypK4ocJr60921709217epcas5p1f;
        Mon, 17 Jul 2023 11:37:58 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4R4Knw06Hxz4x9Pq; Mon, 17 Jul
        2023 11:37:56 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.EA.44250.31825B46; Mon, 17 Jul 2023 20:37:55 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230717113755epcas5p2c474d62544126f79dac38e6514961ec3~ypK2Z76FI0932109321epcas5p2v;
        Mon, 17 Jul 2023 11:37:55 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230717113755epsmtrp24d7903f66b3800cbf0341ae463e73218~ypK2ZRNxG2324923249epsmtrp2r;
        Mon, 17 Jul 2023 11:37:55 +0000 (GMT)
X-AuditID: b6c32a4a-c4fff7000000acda-60-64b52813ebb0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.77.64355.31825B46; Mon, 17 Jul 2023 20:37:55 +0900 (KST)
Received: from alimakhtar04 (unknown [107.122.12.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230717113754epsmtip2229a9ca8ff5d6544a45b645362f09243~ypK1VMqXx0308203082epsmtip2C;
        Mon, 17 Jul 2023 11:37:54 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Rob Herring'" <robh@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>
Cc:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20230714175147.4068046-1-robh@kernel.org>
Subject: RE: [PATCH] soc: samsung: Explicitly include correct DT includes
Date:   Mon, 17 Jul 2023 17:07:53 +0530
Message-ID: <001d01d9b8a3$20bd7ed0$62387c70$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQFvrXnpEE06/lEBy1HujFZ2/GC4HQLREcuCsHtiWfA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTU1dYY2uKwculVhbzj5xjtdj7eiu7
        xabH11gtLu+aw2Yx4/w+Jov/e3awO7B5bFrVyeZx59oeNo/NS+o9Pm+SC2CJyrbJSE1MSS1S
        SM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqtpFCWmFMKFApILC5W
        0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjO+P9qPlvBPrGK
        fT+mMzcw/hXqYuTkkBAwkXhyeRtTFyMXh5DAbkaJjicrGCGcT4wSfza+YoJzdr/7zgTTMufz
        TRaIxE5GifkfPjCDJIQEXjJKNK/UALHZBHQldixuYwOxRQQSJVruPwYbyyzQzyix4csLVpAE
        p4C5xN+3F9hBbGEBT4lbP54DNXBwsAioShzu1AYxeQUsJQ6/B9vLKyAocXLmExYQm1lAXmL7
        2znMEPcoSPx8uowVIi4u8fLoEXaItVYSF3d+ZwNZKyHQySHRfOQm1AMuEo2nTzJC2MISr45v
        YYewpSQ+v9sLdoKEgIfEoj9SEOEMibfL10OV20scuDKHBaSEWUBTYv0ufYi1fBK9v58wQXTy
        SnS0QQNXVaL53VUWCFtaYmJ3NyuE7SHxqXke+wRGxVlIHpuF5LFZSJ6ZhbBsASPLKkbJ1ILi
        3PTUYtMCo7zUcnhsJ+fnbmIEp0strx2MDx980DvEyMTBeIhRgoNZSYT3+6pNKUK8KYmVValF
        +fFFpTmpxYcYTYFhPZFZSjQ5H5iw80riDU0sDUzMzMxMLI3NDJXEeV+3zk0REkhPLEnNTk0t
        SC2C6WPi4JRqYBKLmRV6cc6KyXvN5xktPMf67aGv0YQa68N3dFcomrerZv8zsFJS3scx1UE+
        Y+LGevHw1fsMfzY9l+H/9N4/bu6SKlbXe263ZW3DFrw+vrqlplB/n4y88aUtzy5kb7gkMkHk
        vVrqXLaFn6SY2cWrjwoadWxLSJAJ9d0g6FyTruN30eLZ5JaOIBaphttt0ad2uhUkyjhMcXHp
        K/S6lrJt6+rVJez8OyQNInM+nVPZbzd/o3vKeX62roJNc5vnWzm6LvrWVzn79IOOW1/VVVvX
        r1JTYLncuiAs8YWO8qcH3+4ofb+wSd5JcZGCm07a7j3lt9bHfzvTs2fPvhXuTRIlu2t9b5ZN
        dJyx0DhvowePhRJLcUaioRZzUXEiAL0+IHcgBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK6wxtYUg627NSzmHznHarH39VZ2
        i02Pr7FaXN41h81ixvl9TBb/9+xgd2Dz2LSqk83jzrU9bB6bl9R7fN4kF8ASxWWTkpqTWZZa
        pG+XwJXx/9V8toJ9YhX7fkxnbmD8K9TFyMkhIWAiMefzTZYuRi4OIYHtjBK7tp1gh0hIS1zf
        OAHKFpZY+e85O0TRc0aJ5if3mUASbAK6EjsWt7GB2CICiRIX/z1jBCliFpjMKPH9wFomiI4O
        Ronnc++DVXEKmEv8fXsBbKywgKfErR/PgeIcHCwCqhKHO7VBTF4BS4nD78Hm8woISpyc+YQF
        JMwsoCfRtpERJMwsIC+x/e0cZojbFCR+Pl3GChEXl3h59Ag7xDlWEhd3fmebwCg8C8mkWQiT
        ZiGZNAtJ9wJGllWMoqkFxbnpuckFhnrFibnFpXnpesn5uZsYwdGiFbSDcdn6v3qHGJk4GA8x
        SnAwK4nwfl+1KUWINyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomD
        U6qBSVonhTtd+9NbFqnG22wXpDb+1Pbq2pw9/cKPy0YLbes/R71hm5G4PrWY+dDFewIbbYtW
        Lvaa1puWZ33zkdbZafondx6e+GN/4NP6jbo+IQH8k3u1/pmp8hpn1VRkfrs7cfamh6kJ+Rse
        TVK6HXdnshWrbMjuS8skZx16/f+GcUTckTTHB4uUKhlfTr/1kun5wh8705geOP9WEJu/hWX7
        bN7NWQIfFZ+12fxu31yZHcpyas98yykP4514uNTFZdz+3niR0bh0Qb+Om1/nE5tFa9VSNizr
        WOJeVF5+/2rQjx/9tss3rDHawRxZbZqVMHmbx7v4zAslAcufLkldPMH1cOULpntpEzrX/tJ9
        +OFo9nslluKMREMt5qLiRAAbijVLBQMAAA==
X-CMS-MailID: 20230717113755epcas5p2c474d62544126f79dac38e6514961ec3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230714175226epcas5p2957137e6e0b4a69efb913fe744be827a
References: <CGME20230714175226epcas5p2957137e6e0b4a69efb913fe744be827a@epcas5p2.samsung.com>
        <20230714175147.4068046-1-robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, July 14, 2023 11:22 PM
> To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Alim Akhtar
> <alim.akhtar@samsung.com>
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
linux-
> samsung-soc@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] soc: samsung: Explicitly include correct DT includes
> 
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
"temporarily"
> include each other. They also include platform_device.h and of.h. As a
result,
> there's a pretty much random mix of those include files used throughout
the
> tree. In order to detangle these headers and replace the implicit includes
with
> struct declarations, users need to explicitly include the correct
includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/soc/samsung/exynos-chipid.c | 1 -
>  drivers/soc/samsung/exynos-pmu.c    | 2 +-
>  drivers/soc/samsung/pm_domains.c    | 3 ++-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/samsung/exynos-chipid.c
b/drivers/soc/samsung/exynos-
> chipid.c
> index 0fb3631e7346..7ba45c4aff97 100644
> --- a/drivers/soc/samsung/exynos-chipid.c
> +++ b/drivers/soc/samsung/exynos-chipid.c
> @@ -17,7 +17,6 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> diff --git a/drivers/soc/samsung/exynos-pmu.c
b/drivers/soc/samsung/exynos-
> pmu.c
> index 5b2664da9853..250537d7cfd6 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -7,9 +7,9 @@
> 
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_device.h>
>  #include <linux/mfd/core.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/delay.h>
> 
> diff --git a/drivers/soc/samsung/pm_domains.c
> b/drivers/soc/samsung/pm_domains.c
> index d07f3c9d6903..9b502e8751d1 100644
> --- a/drivers/soc/samsung/pm_domains.c
> +++ b/drivers/soc/samsung/pm_domains.c
> @@ -11,11 +11,12 @@
> 
>  #include <linux/io.h>
>  #include <linux/err.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/pm_domain.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
>  #include <linux/of_address.h>
> -#include <linux/of_platform.h>
>  #include <linux/pm_runtime.h>
> 
>  struct exynos_pm_domain_config {
> --
> 2.40.1


