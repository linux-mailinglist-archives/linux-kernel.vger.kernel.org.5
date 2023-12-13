Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11A81130A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379273AbjLMNgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379267AbjLMNgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:36:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CA5DC;
        Wed, 13 Dec 2023 05:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702474570; x=1734010570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NEtuRYz798pOKaCZjGgcl/J6ODZ0hj92ozwgXCg6Ui0=;
  b=XdTk2gEk9pM5AuOBhy/TaqmUbuUVM1J/QiwqV/b3E3dNK+1DvbvykoHD
   ie+cnsiYARFD0/Re77n3pl5XqxNsk6PjH5gbjYE0nFFQ0ZHObJF3GFa5G
   YiBEgDUOxt7n4NZ425PLnZ9NTVgz8arXIiTBQTBbsBSML/J/JIJII9GTN
   tHRyhGo0I2kaaolzWAwRVmMwKNZpRLBzy2ZrlXK6c2JpIYSpMvoUv19ws
   98lblFJDIfDudk8JJeeNcZYr+nXAFqSYvILWXvyCY8iJb/d8HRLh4Ac99
   hzU5ulMYjB9YGtBGx8mhlHNSUTnza16kWgIO8gsncql7REoNyQX/JXXN1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="8354476"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="8354476"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 05:36:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="750108795"
X-IronPort-AV: E=Sophos;i="6.04,272,1695711600"; 
   d="scan'208";a="750108795"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga006.jf.intel.com with SMTP; 13 Dec 2023 05:36:06 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Dec 2023 15:36:05 +0200
Date:   Wed, 13 Dec 2023 15:36:05 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <ZXmzRWDHsBwvUL7v@kuha.fi.intel.com>
References: <c7b99c4f52649ce6405779fbf9170edc5633fdbb.1702229697.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7b99c4f52649ce6405779fbf9170edc5633fdbb.1702229697.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2023 at 06:36:15PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 8 ++++----
>  drivers/usb/typec/pd.c    | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 16a670828dde..5fe01bf795b9 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -476,7 +476,7 @@ static int altmode_id_get(struct device *dev)
>  	else
>  		ids = &to_typec_port(dev)->mode_ids;
>  
> -	return ida_simple_get(ids, 0, 0, GFP_KERNEL);
> +	return ida_alloc(ids, GFP_KERNEL);
>  }
>  
>  static void altmode_id_remove(struct device *dev, int id)
> @@ -490,7 +490,7 @@ static void altmode_id_remove(struct device *dev, int id)
>  	else
>  		ids = &to_typec_port(dev)->mode_ids;
>  
> -	ida_simple_remove(ids, id);
> +	ida_free(ids, id);
>  }
>  
>  static void typec_altmode_release(struct device *dev)
> @@ -1798,7 +1798,7 @@ static void typec_release(struct device *dev)
>  {
>  	struct typec_port *port = to_typec_port(dev);
>  
> -	ida_simple_remove(&typec_index_ida, port->id);
> +	ida_free(&typec_index_ida, port->id);
>  	ida_destroy(&port->mode_ids);
>  	typec_switch_put(port->sw);
>  	typec_mux_put(port->mux);
> @@ -2297,7 +2297,7 @@ struct typec_port *typec_register_port(struct device *parent,
>  	if (!port)
>  		return ERR_PTR(-ENOMEM);
>  
> -	id = ida_simple_get(&typec_index_ida, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&typec_index_ida, GFP_KERNEL);
>  	if (id < 0) {
>  		kfree(port);
>  		return ERR_PTR(id);
> diff --git a/drivers/usb/typec/pd.c b/drivers/usb/typec/pd.c
> index 85d015cdbe1f..7f3d61f220f2 100644
> --- a/drivers/usb/typec/pd.c
> +++ b/drivers/usb/typec/pd.c
> @@ -571,7 +571,7 @@ static void pd_release(struct device *dev)
>  {
>  	struct usb_power_delivery *pd = to_usb_power_delivery(dev);
>  
> -	ida_simple_remove(&pd_ida, pd->id);
> +	ida_free(&pd_ida, pd->id);
>  	kfree(pd);
>  }
>  
> @@ -616,7 +616,7 @@ usb_power_delivery_register(struct device *parent, struct usb_power_delivery_des
>  	if (!pd)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = ida_simple_get(&pd_ida, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&pd_ida, GFP_KERNEL);
>  	if (ret < 0) {
>  		kfree(pd);
>  		return ERR_PTR(ret);
> -- 
> 2.34.1

-- 
heikki
