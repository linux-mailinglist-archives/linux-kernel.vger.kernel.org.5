Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD27B34C6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjI2OVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjI2OVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:21:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE85DB;
        Fri, 29 Sep 2023 07:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695997291; x=1727533291;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YLWrl7KU2ghuHqMWHl0Ai0ZSxj6kqlnsHwadzBYe/54=;
  b=ASw0O87mwd9rb3U/4qn4Cji9Lj2d0VX92NWTMCHD1jU9TlbHk5Thb3ww
   0V+iI5V2gxczpBot9l3PNWp5UaMoSt1P701lL7fe/S7MESGzDxDd9A3Ci
   w2cIeojcj8G9KCXOLpSpSIIPzX4mLUs9S+chY2ZJ18jQdxq+tbP3lcqGy
   gYrwKbnPuzDDZVxzdJBqNyxiLtEWohuvF4Selpzml/rspdveiDkqq3En9
   3s8k7q1G85w3+tz55RRyAGOPlfmN1DvLeGpoWQkcy2dt2CKE9Lw54FE/Y
   5h5sjAzlAwjh3L9hHpZXZeuDEK7KC7yaBZZOzb9hHf+xyDVpzfiHk6tUm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="367365274"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="367365274"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:21:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743454993"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="743454993"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:21:28 -0700
Date:   Fri, 29 Sep 2023 17:21:25 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] platform/x86: intel_speed_select_if: Remove
 hardcoded map size
In-Reply-To: <20230926175349.989618-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <44e9e292-694d-727e-858-328d22c5d11@linux.intel.com>
References: <20230926175349.989618-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1948979147-1695997290=:1989"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1948979147-1695997290=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Tue, 26 Sep 2023, Srinivas Pandruvada wrote:

> The driver is using 256 as the size while calling devm_ioremap(). The
> maximum offset can be obtained from isst_mmio_range. Add a field "size"
> to the isst_mmio_range and use it instead of hardcoding.
> 
> No functional impact is expected.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Changes:
> As per Andy's comments pre calculate size
> 
>  .../x86/intel/speed_select_if/isst_if_mmio.c     | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
> index ff49025ec085..13e068c77d50 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_mmio.c
> @@ -18,16 +18,17 @@
>  struct isst_mmio_range {
>  	int beg;
>  	int end;
> +	int size;
>  };
>  
>  static struct isst_mmio_range mmio_range_devid_0[] = {
> -	{0x04, 0x14},
> -	{0x20, 0xD0},
> +	{0x04, 0x14, 0x18},
> +	{0x20, 0xD0, 0xD4},
>  };
>  
>  static struct isst_mmio_range mmio_range_devid_1[] = {
> -	{0x04, 0x14},
> -	{0x20, 0x11C},
> +	{0x04, 0x14, 0x18},
> +	{0x20, 0x11C, 0x120},
>  };
>  
>  struct isst_if_device {
> @@ -114,13 +115,16 @@ static int isst_if_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	pcu_base &= GENMASK(10, 0);
>  	base_addr = (u64)mmio_base << 23 | (u64) pcu_base << 12;
> -	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr, 256);
> +
> +	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
> +
> +	punit_dev->punit_mmio = devm_ioremap(&pdev->dev, base_addr,
> +					     punit_dev->mmio_range[1].size);
>  	if (!punit_dev->punit_mmio)
>  		return -ENOMEM;
>  
>  	mutex_init(&punit_dev->mutex);
>  	pci_set_drvdata(pdev, punit_dev);
> -	punit_dev->mmio_range = (struct isst_mmio_range *) ent->driver_data;
>  
>  	memset(&cb, 0, sizeof(cb));
>  	cb.cmd_size = sizeof(struct isst_if_io_reg);
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1948979147-1695997290=:1989--
