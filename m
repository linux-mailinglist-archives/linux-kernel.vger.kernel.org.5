Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4F784BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjHVVBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjHVVBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:01:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF681B0;
        Tue, 22 Aug 2023 14:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=A8/vJDmnxqneK9l/E7LtDD+PprhiMBOzpHX1desAXDs=; b=aBdwc+wnbyM/Fbk0LQyrKzXMtO
        6tDJZHqjzVKT0VdJP9YIltqPeMY4fECpuun6hwyMP1yi2Q3ShUFBfCgaEZEmhjhU1vZQ+mKRD6WWh
        Qh1OBEcVDn84gf7XQQ9iwYkn94NTL2sXtPaxk9+LyNW1M81F5gHgN019Xdzz5GbB0kL2snueS6rtG
        7/W8oWx9DdTlJmmlAZNccAfQaT+SbimsKC0M8WSGi5PM8GXnKLqmWsd0lTygMcB7RjnQbO7xmdLeZ
        oLNduG1TEBMXPmfxLvWqQbbRjwofYF2BXbx6uZQWAD8xNUd9kGEHW06ABDwOAf4dVWs63GJDrLjuo
        EAzE937g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qYYV3-00GnT7-0l;
        Tue, 22 Aug 2023 21:01:17 +0000
Message-ID: <1812e39f-ddbc-d655-5d04-0a13d04437ab@infradead.org>
Date:   Tue, 22 Aug 2023 14:01:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] media: via: Use correct dependency for camera sensor
 drivers
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     hverkuil@xs4all.nl, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230822081034.3869843-1-sakari.ailus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230822081034.3869843-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/23 01:10, Sakari Ailus wrote:
> The via camera controller driver selected ov7670 driver, however now that
> driver has dependencies and may no longer be selected unconditionally.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/media/platform/via/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/via/Kconfig b/drivers/media/platform/via/Kconfig
> index 8926eb0803b2..6e603c038248 100644
> --- a/drivers/media/platform/via/Kconfig
> +++ b/drivers/media/platform/via/Kconfig
> @@ -7,7 +7,7 @@ config VIDEO_VIA_CAMERA
>  	depends on V4L_PLATFORM_DRIVERS
>  	depends on FB_VIA && VIDEO_DEV
>  	select VIDEOBUF2_DMA_SG
> -	select VIDEO_OV7670
> +	select VIDEO_OV7670 if VIDEO_CAMERA_SENSOR
>  	help
>  	   Driver support for the integrated camera controller in VIA
>  	   Chrome9 chipsets.  Currently only tested on OLPC xo-1.5 systems

-- 
~Randy
