Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B6B7BC5B4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 09:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbjJGHog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 03:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343715AbjJGHoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 03:44:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AAFBF;
        Sat,  7 Oct 2023 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696664673; x=1728200673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sRng9T4/el7qzEq59uhXR9KsL4yghIT/iUgkp07WwMA=;
  b=IFRTYhnQWdq5vUq1WLYzIO/BG98iDrFQ9X/wbIy8bnyrQCVtn8zu7UqW
   LxY4UTJsuRLPQNtl0Wr1MmjFixnpphr7jzsCBlivWnsbsu4nuLKcF9JIt
   BlMXyL5X3PsWwTIlGsvloVJOJgu9W8M4NIAqur+K1LifOL56TttGufyH9
   JOKpPIvx2Skrfw87lY4ZkQsfYcPofy1N8NNTtAIzkcKS8kH+QZgUx9A7P
   4edhXNShGzAOj7VwU8b3k31DciFJJ0hE5kJBKcPsQ72AFzmexl57pyLMO
   cJNysxboI6N9IJx81FYu4jvgk7bEgvEa42R4vDiTpPz1iwk2PfiDKRS28
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386742001"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="386742001"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 00:44:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="702316267"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="702316267"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2023 00:44:30 -0700
Date:   Sat, 7 Oct 2023 15:43:41 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-ps-spi: Use spi_get_device_match_data()
Message-ID: <ZSEMLQS+9gFEAX89@yilunxu-OptiPlex-7050>
References: <20231006224624.444857-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006224624.444857-1-robh@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 05:46:24PM -0500, Rob Herring wrote:
> Use preferred spi_get_device_match_data() instead of of_match_device() and
> spi_get_device_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> ---
>  drivers/fpga/altera-ps-spi.c | 44 ++++--------------------------------
>  1 file changed, 5 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
> index 5e1e009dba89..6be7410e4f09 100644
> --- a/drivers/fpga/altera-ps-spi.c
> +++ b/drivers/fpga/altera-ps-spi.c
> @@ -18,8 +18,7 @@
>  #include <linux/fpga/fpga-mgr.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
>  #include <linux/spi/spi.h>
>  #include <linux/sizes.h>
>  
> @@ -72,12 +71,6 @@ static struct altera_ps_data a10_data = {
>  	.t_st2ck_us = 10, /* min(t_ST2CK) */
>  };
>  
> -/* Array index is enum altera_ps_devtype */
> -static const struct altera_ps_data *altera_ps_data_map[] = {
> -	&c5_data,
> -	&a10_data,
> -};
> -
>  static const struct of_device_id of_ef_match[] = {
>  	{ .compatible = "altr,fpga-passive-serial", .data = &c5_data },
>  	{ .compatible = "altr,fpga-arria10-passive-serial", .data = &a10_data },
> @@ -237,43 +230,16 @@ static const struct fpga_manager_ops altera_ps_ops = {
>  	.write_complete = altera_ps_write_complete,
>  };
>  
> -static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
> -{
> -	kernel_ulong_t devtype = id->driver_data;
> -	const struct altera_ps_data *data;
> -
> -	/* someone added a altera_ps_devtype without adding to the map array */
> -	if (devtype >= ARRAY_SIZE(altera_ps_data_map))
> -		return NULL;
> -
> -	data = altera_ps_data_map[devtype];
> -	if (!data || data->devtype != devtype)
> -		return NULL;
> -
> -	return data;
> -}
> -
>  static int altera_ps_probe(struct spi_device *spi)
>  {
>  	struct altera_ps_conf *conf;
> -	const struct of_device_id *of_id;
>  	struct fpga_manager *mgr;
>  
>  	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
>  	if (!conf)
>  		return -ENOMEM;
>  
> -	if (spi->dev.of_node) {
> -		of_id = of_match_device(of_ef_match, &spi->dev);
> -		if (!of_id)
> -			return -ENODEV;
> -		conf->data = of_id->data;
> -	} else {
> -		conf->data = id_to_data(spi_get_device_id(spi));
> -		if (!conf->data)
> -			return -ENODEV;
> -	}
> -
> +	conf->data = spi_get_device_match_data(spi);
>  	conf->spi = spi;
>  	conf->config = devm_gpiod_get(&spi->dev, "nconfig", GPIOD_OUT_LOW);
>  	if (IS_ERR(conf->config)) {
> @@ -308,9 +274,9 @@ static int altera_ps_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id altera_ps_spi_ids[] = {
> -	{ "cyclone-ps-spi", CYCLONE5 },
> -	{ "fpga-passive-serial", CYCLONE5 },
> -	{ "fpga-arria10-passive-serial", ARRIA10 },
> +	{ "cyclone-ps-spi", (uintptr_t)&c5_data },
> +	{ "fpga-passive-serial", (uintptr_t)&c5_data },
> +	{ "fpga-arria10-passive-serial", (uintptr_t)&a10_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, altera_ps_spi_ids);
> -- 
> 2.40.1
> 
