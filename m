Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F96A78B7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 21:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjH1TQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 15:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjH1TP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 15:15:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57516107;
        Mon, 28 Aug 2023 12:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ooda8mBwqQkqUo05ojJGGxNJRqv3rutra4bvHSUZszc=; b=hvVSqD3LgCl8YgZtqclszK7vWb
        DeEQqpGENNw89rbK+PgIokVnf2koY8K14Q/7KeK5NDXx0rQWoAa+asnrIyONbTP4DgROHwB6jt1AH
        Wlfn+Pl6jvnV6TIrjcNipEKcoi87kwgsavtEQkrvqY5TbG/B765PIJBpE5/3zRFgiF+RpnC+qpQEG
        v9tb3GzJ+Zp57MkzMIzeNbNoIvGHfWgwnUpc2PyyRC/1xHjioqp7tAg6FCJC0eHwwpFlJp0PNzbIP
        nrcX76OIanQfdgWcjiS2ICnNwY46miZO1vYgZob8eGdBLywixV9MxjkRUuRKz3+ikdYBTNa9NY0/O
        4+9Qxnng==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qahiI-00A8FW-1I;
        Mon, 28 Aug 2023 19:15:50 +0000
Message-ID: <59917723-6db4-8e81-88d9-b4c124914473@infradead.org>
Date:   Mon, 28 Aug 2023 12:15:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] media: ivsc: Depend on VIDEO_DEV
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-media@vger.kernel.org
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wentong Wu <wentong.wu@intel.com>
References: <20230828085718.3912335-1-sakari.ailus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230828085718.3912335-1-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/28/23 01:57, Sakari Ailus wrote:
> CONFIG_VIDEO_DEV is required by other selected symbols. Depend on it.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 29006e196a56 ("media: pci: intel: ivsc: Add CSI submodule")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/media/pci/intel/ivsc/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/pci/intel/ivsc/Kconfig b/drivers/media/pci/intel/ivsc/Kconfig
> index e9ecd0bd99bd..0acea4678fc0 100644
> --- a/drivers/media/pci/intel/ivsc/Kconfig
> +++ b/drivers/media/pci/intel/ivsc/Kconfig
> @@ -3,7 +3,7 @@
>  
>  config INTEL_VSC
>  	tristate "Intel Visual Sensing Controller"
> -	depends on INTEL_MEI && ACPI
> +	depends on INTEL_MEI && ACPI && VIDEO_DEV
>  	select MEDIA_CONTROLLER
>  	select VIDEO_V4L2_SUBDEV_API
>  	select V4L2_ASYNC

-- 
~Randy
