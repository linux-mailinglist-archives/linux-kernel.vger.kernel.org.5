Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7FA7915DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348164AbjIDKu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjIDKuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:50:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C99EDD;
        Mon,  4 Sep 2023 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693824621; x=1725360621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WBXVQvn4cAjmdr8D6OmweKSu5H2pPRHiyJxB1xRH74o=;
  b=FnJVBIp4Gx8+F0dm3eu8cGTaZqasDgStsFNaTUJbPBRvA+m3/CAeICWv
   19q5pOCxaKRZNaR6fOip48kcPCoVRWiV+3aOxIeHl7JMjZH24ZOqo9Uvp
   rflkpztK8mduZ3DMy5Kr3JACNR1IL4s73lHkT/rSJBCRsSMMhhXw9eMO4
   bYZuzzZXryT61fDJaae+s3npO4AEKTB7eRFQGojCCX8wfxcwOOXws+c9c
   hzscy0garb9ADJxQ7Qi/ivjpAZNHUeYfkn+YzCpIBG8BpTCgPzDBRW5FR
   tIQylHBhY+ay377ToDXNHvJtVUesxhiuLo8VbSB1Hl9m8AxMgmc52TE10
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380372456"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="380372456"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 03:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="883992451"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="883992451"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Sep 2023 03:50:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Sep 2023 13:50:15 +0300
Date:   Mon, 4 Sep 2023 13:50:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Saravana Kannan <saravanak@google.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] device property: Clarify usage scope of some
 struct fwnode_handle members
Message-ID: <ZPW2Z7lRZTOhTU/m@kuha.fi.intel.com>
References: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904104046.1682875-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 01:40:46PM +0300, Andy Shevchenko wrote:
> Most of the struct fwnode_handle members are for exclusive use with
> device links framework. Clarify this by adding a respective comment.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Yes, this is important clarification.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  include/linux/fwnode.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 5700451b300f..2a72f55d26eb 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -41,6 +41,8 @@ struct device;
>  struct fwnode_handle {
>  	struct fwnode_handle *secondary;
>  	const struct fwnode_operations *ops;
> +
> +	/* The below is used solely by device links, don't use otherwise */
>  	struct device *dev;
>  	struct list_head suppliers;
>  	struct list_head consumers;
> -- 
> 2.40.0.1.gaa8946217a0b

-- 
heikki
