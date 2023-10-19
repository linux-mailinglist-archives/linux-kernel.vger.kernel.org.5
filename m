Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAE7CF88B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbjJSMRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjJSMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:16:59 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C2C134
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:16:56 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019121654epoutp010338f5c1c1ba6b3a2bc01925ddbad8cc~PgVtsBgGd0330903309epoutp01P
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 12:16:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019121654epoutp010338f5c1c1ba6b3a2bc01925ddbad8cc~PgVtsBgGd0330903309epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1697717814;
        bh=z6vk067XJq61wl6yvblxMhA8AYM9NixgY5wMH/CqLmg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=PLYrut9lE1/NBjN/7KWK9NGGzueTXJetaY5Z1+NVSIxzeyo6TeSb5sOBZLYLMT1w0
         mcMNK7xn/TWWiCWjq6Qp/hmhVdl4NVYHG4ergnJcuIJPunU2e0SgNy+wbCFnTYRNKj
         Z/5mgvmGxkHkIsL6XHt4o9/KrzxIKDKj6FsVfbYY=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231019121653epcas1p2bf01f7721c890b54282000545b7723b4~PgVtE-8ZZ0490604906epcas1p2V;
        Thu, 19 Oct 2023 12:16:53 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.36.134]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4SB6CS48ftz4x9Pr; Thu, 19 Oct
        2023 12:16:52 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.8F.19104.43E11356; Thu, 19 Oct 2023 21:16:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20231019121652epcas1p49d8b24067b72808a0a23bea64f14173f~PgVrvlvwV0634506345epcas1p4N;
        Thu, 19 Oct 2023 12:16:52 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231019121652epsmtrp2222eb153520ed7a60b195929f1e6d677~PgVrtkVQP2185621856epsmtrp2L;
        Thu, 19 Oct 2023 12:16:52 +0000 (GMT)
X-AuditID: b6c32a4c-559ff70000004aa0-0a-65311e34e14d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.B9.07368.33E11356; Thu, 19 Oct 2023 21:16:51 +0900 (KST)
Received: from cw00choi03 (unknown [10.113.111.106]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20231019121651epsmtip182e19a7b45c9232e47e8f9aef6d1844b~PgVrW_h0I0851508515epsmtip1O;
        Thu, 19 Oct 2023 12:16:51 +0000 (GMT)
From:   "Chanwoo Choi" <cw00.choi@samsung.com>
To:     "'Sascha Hauer'" <s.hauer@pengutronix.de>,
        <linux-rockchip@lists.infradead.org>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        "'Heiko Stuebner'" <heiko@sntech.de>,
        "'Chanwoo Choi'" <chanwoo@kernel.org>,
        "'Kyungmin Park'" <kyungmin.park@samsung.com>,
        "'MyungJoo Ham'" <myungjoo.ham@samsung.com>,
        "'Will Deacon'" <will@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>, <kernel@pengutronix.de>,
        "'Michael Riesch'" <michael.riesch@wolfvision.net>,
        "'Robin Murphy'" <robin.murphy@arm.com>,
        "'Vincent Legoll'" <vincent.legoll@gmail.com>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        "'Conor Dooley'" <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        "'Sebastian Reichel'" <sebastian.reichel@collabora.com>
In-Reply-To: <20231019064819.3496740-1-s.hauer@pengutronix.de>
Subject: RE: [PATCH] PM / devfreq: rockchip-dfi: Add perf support
Date:   Thu, 19 Oct 2023 21:16:51 +0900
Message-ID: <002901da0286$2450cfc0$6cf26f40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQJJLo5n4Y1C3K94xQ3Q2txgQ8G2QQLxgVKlAgrg2OWvSsqGIA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxTO7WsfrVL3LEwvNWG1SJxslBZa9kBqhBF5Zow0I/wxRsZq+wYM
        aLv+2JxuGYKAGCk/HJlWEHFUGIEQkPBDKbNAZLqJdDUwBmxsoBOKaIoIyCprebjx33fOd757
        znfuvUyE8xTlMjNUelKrkmfx0S309r59gmCxv4gU9qz542W/3qPjjZZBGl7dP8jA1/5yMPCG
        ii46bnz4J4LfyZ3zwlunhhm4/Volii8U9wPcObmG4OYRGw231uzBx07Uo3i+pd8Ltz6ZZuCu
        jlY6PuFIwAeaHqD4yXHJQV+i8WIjIDonagHRZZrwIlobilBifLgbJa7Wfk2UuISEsa0BEB3D
        FxFiodWfqF6dArKtyZlR6aRcSWp5pEqhVmao0qT8dxJT306VhAtFwaII/C0+TyXPJqX82HhZ
        8KGMLLdBPu8zeZbBnZLJdTp+yIEordqgJ3npap1eyic1yiyNRCPQybN1BlWaQEXqI0VCYajE
        XfhRZnrZyH5NcdDRy852NAcs7z4NWEyIiWFVz03aabCFycG6Acy938fwEBzMCeDjuyhFPAPw
        qnXZ66XCdvcXBkVYAGzJzfWighkA8x4NuRkmE8XehJeWkzwCXywJlvzYSfNgBHvGgE/WDntK
        WNgBuPJTrCftg0XDBaMN9WA6Fgid8zPr5WwsAj5oa9jA2+Gt89N06pjXYMejSoSahwdX7l9h
        UHlfeKGoAKHaxkDj5cX1OSFWzYI3zv3GoASx0DjXTaewD5wdaNswxoUL8xaUEpwF0OZwIFTQ
        7Hb5/cmNdmHwB/NZmscBgu2DzddCqPRu2LVaBagptsH5xTPre4AYG54q4FAlAdA+OUGjsB/8
        rrAILQV80yZvpk3eTJv8mP5vdgnQGwCX1Oiy00iFSCMKVpGf/3ffCnV2K1h//kHxnWCp2SXo
        BTQm6AWQifB92YGEkOSwlfIvjpFadarWkEXqeoHEvfEyhPuqQu3+Pyp9qkgcIRSHh4aJcVG4
        iL+TneIsVHKwNLmezCRJDal9qaMxWdwcWqK8pmZ68r2Eg6N7LbEhO6w7x0oPn49x1p07lGrL
        cZz56sNieyBLnJ+yTV/14lvtdludZe168vvS+L03rM3mklU7cCroPVyD65jhSmSc692h51Jp
        4PWxWv++JnEAc2Y40MG4M5WHg+dHOiNP2W8nsZfKF1HGDlWT101B3ArsdFVUPJwN/2Ck40vF
        SiGWaMrd9fc3r1ecsM4OGWPsNoEsbqG4xRzNujcrHJy+bYj2Kz/yyfHw5f08s+xTWb3faH37
        47oSPXjF29L11HuXJCA4rMo2jSa3zCmBNO9oqLl8IKMu/+cCUUJK0gUj6vMi6o3SpVtbo71H
        /9lT+fH47+D4H3y6Ll0uCkK0Ovm/5YtCgYcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSnK6xnGGqwe47FhYTb1xhsViz9xyT
        xfwj51gt/j96zWqxaupOFou+Fw+ZLc42vWG32PT4GqvF5V1z2Cw+9x5htPj04D+zxdLrF5ks
        Di5UsbjduILNonXvEXaLgx+esFr83b6JxeLuaz+L42ufsVm03DF1EPFYM28No8eOu0sYPXbO
        usvusWlVJ5vHnWt72Dw2L6n36P9r4NG3ZRWjx/Zr85g9Pm+S85j/+zFjAHcUl01Kak5mWWqR
        vl0CV8bE69YFvVoViz5tY2tg/KHYxcjJISFgInHx/CXWLkYuDiGB3YwSpzYvY4FISEpMu3iU
        uYuRA8gWljh8uBii5jmjRO+bJlaQOJuAjsSCH6Eg5SICoRL9J3YwgdQwC7SwSexa9pkNouEQ
        o8SViX1gDZwCdhI/T7uANAgLOEp87rvIBmKzCKhKfHr3kgnE5hWwlHi2ZRWULShxcuYTFpBW
        ZgE9ibaNjCBhZgF5ie1v5zBDnKkg8fPpMlaIuIjE7M42Zoh7nCT6Fn1lncAoPAvJpFkIk2Yh
        mTQLSfcCRpZVjJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjBsa+lsYPx3vx/eocYmTgY
        gT7kYFYS4VX1MEgV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoRTJaJ
        g1OqgYnn8P8w/YhVW+3aWBLLZwj+d0s2enRvt6jGeadbTPIbvmmtOpW1letG52vWdy+mO3Mz
        eRy6JSKU7m2fuGeL3tJVFie+l11qf7Tm3CSvGjY/lz06GX6rTR1qa5aYH3yU37+4WkCvxsOT
        ic/3LsvT6zeF+ioq/IMun10csbdyidH0zztYuVg2bv8Y/avQcKLgZDYVhlmH16ZWON88fkbj
        WLxr4AO1Lz6t106bXff+orNvUnjMRv2l4g8f+ifq/Pha7bSfj2m2dtXphM6+iCfPHtjHGPfM
        atxQIqBl0hzmEL/ZnzOKef3XR9LvnFgiO6aHPN55errsUaf1ASwPY96KvjyrcGnT/587f6aq
        nl1231yJpTgj0VCLuag4EQBKQbIYbAMAAA==
X-CMS-MailID: 20231019121652epcas1p49d8b24067b72808a0a23bea64f14173f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019064915epcas1p4851c400613e6857f85683520e5ee7caf
References: <20231018061714.3553817-17-s.hauer@pengutronix.de>
        <CGME20231019064915epcas1p4851c400613e6857f85683520e5ee7caf@epcas1p4.samsung.com>
        <20231019064819.3496740-1-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Sent: Thursday, October 19, 2023 3:48 PM
> To: linux-rockchip@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> linux-pm@vger.kernel.org; Heiko Stuebner <heiko@sntech.de>; Chanwoo Choi
> <chanwoo@kernel.org>; Kyungmin Park <kyungmin.park@samsung.com>; MyungJoo
> Ham <myungjoo.ham@samsung.com>; Will Deacon <will@kernel.org>; Mark
> Rutland <mark.rutland@arm.com>; kernel@pengutronix.de; Michael Riesch
> <michael.riesch@wolfvision.net>; Robin Murphy <robin.murphy@arm.com>;
> Vincent Legoll <vincent.legoll@gmail.com>; Rob Herring
> <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> devicetree@vger.kernel.org; Sebastian Reichel
> <sebastian.reichel@collabora.com>; Sascha Hauer <s.hauer@pengutronix.de>;
> Chanwoo Choi <cw00.choi@samsung.com>
> Subject: [PATCH] PM / devfreq: rockchip-dfi: Add perf support
> 
> The DFI is a unit which is suitable for measuring DDR utilization, but so
> far it could only be used as an event driver for the DDR frequency scaling
> driver. This adds perf support to the DFI driver.
> 
> Usage with the 'perf' tool can look like:
> 
> perf stat -a -e rockchip_ddr/cycles/,\
> 		rockchip_ddr/read-bytes/,\
> 		rockchip_ddr/write-bytes/,\
> 		rockchip_ddr/bytes/ sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>         1582524826      rockchip_ddr/cycles/
>            1802.25 MB   rockchip_ddr/read-bytes/
>            1793.72 MB   rockchip_ddr/write-bytes/
>            3595.90 MB   rockchip_ddr/bytes/
> 
>        1.014369709 seconds time elapsed
> 
> perf support has been tested on a RK3568 and a RK3399, the latter with
> dual channel DDR.
> 
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v8:
>     - Move rockchip_ddr_perf_counters_add() inside #ifdef
> CONFIG_PERF_EVENTS
>       to avoid unused function warning with CONFIG_PERF_EVENTS disabled
> 
>     Changes since v7:
>      - rename variable 'c' to 'count'
> 
>     Changes since v5:
>      - Add missing initialization of &dfi->last_perf_count
> 
>     Changes since v4:
> 
>      - use __stringify to ensure event type definitions and event numbers
> in sysfs are consistent
>      - only use 64bit values in structs holding counters
>      - support monitoring individual DDR channels
>      - fix return value in rockchip_ddr_perf_event_init(): -EOPNOTSUPP ->
-
> EINVAL
>      - check for invalid event->attr.config values
>      - start hrtimer to trigger in one second, not immediately
>      - use devm_add_action_or_reset()
>      - add suppress_bind_attrs
>      - enable DDRMON during probe when perf is enabled
>      - use a seqlock to protect perf reading the counters from the hrtimer
> callback modifying them
> 
>  drivers/devfreq/event/rockchip-dfi.c | 440 ++++++++++++++++++++++++++-
>  include/soc/rockchip/rk3399_grf.h    |   2 +
>  include/soc/rockchip/rk3568_grf.h    |   1 +
>  3 files changed, 438 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c
> b/drivers/devfreq/event/rockchip-dfi.c
> index 3d5c6d737ccd9..a7d7b61518fec 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -16,10 +16,12 @@
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/list.h>
> +#include <linux/seqlock.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
> +#include <linux/perf_event.h>
> 
>  #include <soc/rockchip/rockchip_grf.h>
>  #include <soc/rockchip/rk3399_grf.h>
> @@ -41,19 +43,39 @@
>  					 DDRMON_CTRL_LPDDR4 | \
>  					 DDRMON_CTRL_LPDDR23)
> 
> +#define DDRMON_CH0_WR_NUM		0x20
> +#define DDRMON_CH0_RD_NUM		0x24
>  #define DDRMON_CH0_COUNT_NUM		0x28
>  #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
>  #define DDRMON_CH1_COUNT_NUM		0x3c
>  #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
> 
> +#define PERF_EVENT_CYCLES		0x0
> +#define PERF_EVENT_READ_BYTES		0x1
> +#define PERF_EVENT_WRITE_BYTES		0x2
> +#define PERF_EVENT_READ_BYTES0		0x3
> +#define PERF_EVENT_WRITE_BYTES0		0x4
> +#define PERF_EVENT_READ_BYTES1		0x5
> +#define PERF_EVENT_WRITE_BYTES1		0x6
> +#define PERF_EVENT_READ_BYTES2		0x7
> +#define PERF_EVENT_WRITE_BYTES2		0x8
> +#define PERF_EVENT_READ_BYTES3		0x9
> +#define PERF_EVENT_WRITE_BYTES3		0xa
> +#define PERF_EVENT_BYTES		0xb
> +#define PERF_ACCESS_TYPE_MAX		0xc
> +
>  /**
>   * struct dmc_count_channel - structure to hold counter values from the
> DDR controller
>   * @access:       Number of read and write accesses
>   * @clock_cycles: DDR clock cycles
> + * @read_access:  number of read accesses
> + * @write_acccess: number of write accesses


Need to change it to 'write_access' from 'write_acccess'.
When I merge it, I fix it by myself.

And,
Applied it with "Acked-by: Heiko Stuebner <heiko@sntech.de>"
according to https://lore.kernel.org/all/27832786.gRfpFWEtPU@diego/.

If you have other opinion, please let me know.

Best Regards,
Chanwoo Choi







