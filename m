Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06437C5E48
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376319AbjJKUXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbjJKUXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:23:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6117090;
        Wed, 11 Oct 2023 13:23:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S5PJc0MPNz67VcY;
        Thu, 12 Oct 2023 04:20:00 +0800 (CST)
Received: from localhost (10.126.175.8) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 11 Oct
 2023 21:23:03 +0100
Date:   Wed, 11 Oct 2023 21:23:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jeongtae Park <jtp.park@samsung.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
Subject: Re: [PATCH v3 2/6] cxl/region: Fix a checkpatch warning
Message-ID: <20231011212301.000027e2@Huawei.com>
In-Reply-To: <20231010082608.859137-3-jtp.park@samsung.com>
References: <20231010082608.859137-1-jtp.park@samsung.com>
        <CGME20231010082321epcas2p13641bd794b1c26d2137bb51093fd49f7@epcas2p1.samsung.com>
        <20231010082608.859137-3-jtp.park@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.8]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2023 17:26:04 +0900
Jeongtae Park <jtp.park@samsung.com> wrote:

> WARNING: else is not generally useful after a break or return
> 
> Since cpu_cache_invalidate_memregion() already checks for
> support of invalidaton operation, it can be removed.
> This change would make more efficient or small codes
> when 'CONFIG_CXL_REGION_INVALIDATION_TEST' is not set.

Oddly short line wrap - aim for 75 chars ish.

> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>


> ---
>  drivers/cxl/core/region.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..0eb7a12badb9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -127,21 +127,15 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
>  
>  static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  {
> -	if (!cpu_cache_has_invalidate_memregion()) {
> -		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> -			dev_warn_once(
> -				&cxlr->dev,
> -				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> -			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
> -		}
> +	if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)
> +			&& cpu_cache_has_invalidate_memregion()) {
> +		dev_warn_once(
> +			&cxlr->dev,
> +			"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> +		return 0;
>  	}
>  
> -	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> -	return 0;
> +	return cpu_cache_invalidate_memregion(IORES_DESC_CXL);

This is an arch specific call.  Whilst today on x86 (only option) the only way to
return an error is if it's not supported, that's not necessarily going to be the
case for other architectures. So I'd prefer to keep the dev_err if this fails.

Jonathan

>  }
>  
>  static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)

