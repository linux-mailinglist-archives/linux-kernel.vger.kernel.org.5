Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B157BD9F1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbjJILdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346230AbjJILdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:33:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3199;
        Mon,  9 Oct 2023 04:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696851191; x=1728387191;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ddLtdcg2C5atzq5XJFTEOQpB6YaN3zWAVzub313Cm60=;
  b=Yh9qetHc6NJvt8358Ov0ByITYvnQhqq3ocHciRDS/uVQllgz2WQFZIE+
   2x3p1ttYpSpPfBSS4+Rhgk8KDWoo9oR7cxygyYPcdR7gxl6lRSkS85i2B
   ziEXkStkNDtXbxq4H1HEKQff5dJlu9ooziTRZETJ4sX7EzMC3u1np2aFW
   N+Flc3Sj8kCjKKPemjJ8rs3wZ6BwLU4jIIP9wOQzYvENCDIIE93VI0pne
   EawgQsDO54J8DuvcQmYI0hcaSrtQmXFr3LjWIGQB3uv9BujocFMO7EjvD
   Cw7IfF6AUp2C/yDsKXo9WH02Dabxaw8/8eNggp55m57Fivwus9BoF7ZeX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="386965747"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="386965747"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 04:33:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="1000173633"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="1000173633"
Received: from lshebash-mobl3.ccr.corp.intel.com ([10.252.57.254])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 04:33:08 -0700
Date:   Mon, 9 Oct 2023 14:33:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        =?ISO-8859-15?Q?Jo=E3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_device()
In-Reply-To: <20231007081230.3555681-1-andriy.shevchenko@linux.intel.com>
Message-ID: <73edfbd6-7119-7fb1-2e10-ac1546e1d4e@linux.intel.com>
References: <20231007081230.3555681-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2023, Andy Shevchenko wrote:

> Replace open coded acpi_match_device() in asus_wireless_add().

Could you update this and shortlog too to match the patch (the same 
applies also to the other similar patch you've inflight).

-- 
 i.

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v4: used proper API, added tag (Hans)
> v3: rewrote error path logic (Hans)
> v2: fixed compilation error
> 
>  drivers/platform/x86/asus-wireless.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index abf01e00b799..41227bf95878 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -148,16 +148,12 @@ static int asus_wireless_add(struct acpi_device *adev)
>  	if (err)
>  		return err;
>  
> -	for (id = device_ids; id->id[0]; id++) {
> -		if (!strcmp((char *) id->id, acpi_device_hid(adev))) {
> -			data->hswc_params =
> -				(const struct hswc_params *)id->driver_data;
> -			break;
> -		}
> -	}
> -	if (!data->hswc_params)
> +	id = acpi_match_acpi_device(device_ids, adev);
> +	if (!id)
>  		return 0;
>  
> +	data->hswc_params = (const struct hswc_params *)id->driver_data;
> +
>  	data->wq = create_singlethread_workqueue("asus_wireless_workqueue");
>  	if (!data->wq)
>  		return -ENOMEM;
> 

