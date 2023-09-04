Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632E67911C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbjIDHH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIDHHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:07:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382D99;
        Mon,  4 Sep 2023 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693811271; x=1725347271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IvnFOhimnal3mNOSmqOjxgAv+PeikviZNBTJXA+jxqo=;
  b=En8CPyD0e6KZqVzphBJ3sda8to4HKNCGmv1vKOETz18uHMREpmmW5qPv
   irqeJDgntxc0qTdgIdvj4VEBCqlL2XNBEZLNjQOfSPbYxDZtEXPM7cF4z
   Gd9ERynQh+dVWgAgfJYOMRvYvaGBvngbjikhx971lNkyqQXf+JRk+L1U2
   fE5zsifmmfWSWTXhLbxJwmstB6u6Ngdd5c1d6vVy5lyrNhS9KJo/4WjLH
   7E8Q0lSScreVvQOsn3LLzEv+ZfTgI8i8ccZqv8iyMETXWw1/q1penL5PA
   RyUC2KVjaVHNQMcvLvgW/c8orbzFeGwtPQ8ilmFu898ZAPUDpRexXLR1/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="407530107"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="407530107"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 00:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="830807335"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="830807335"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by FMSMGA003.fm.intel.com with SMTP; 04 Sep 2023 00:07:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Sep 2023 10:07:44 +0300
Date:   Mon, 4 Sep 2023 10:07:44 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, chrome-platform@lists.linux.dev,
        andriy.shevchenko@linux.intel.com, bleung@chromium.org
Subject: Re: [PATCH v2 2/5] usb: typec: Add Active or Passive cable
 defination to cable discover mode VDO
Message-ID: <ZPWCQKgZUUITOUnW@kuha.fi.intel.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
 <20230830223950.1360865-3-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830223950.1360865-3-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 03:39:47PM -0700, Utkarsh Patel wrote:
> As per USB Type-C Connector specification v2.2 section F.2.6, BIT25
> represents Active or Passive cable. Added BIT25 defination to the
> Thunderbolt 3 cable discover mode VDO.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - This change is being added as new patch in this series.
>  
>  include/linux/usb/typec_tbt.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/usb/typec_tbt.h b/include/linux/usb/typec_tbt.h
> index 63dd44b72e0c..c7a2153bd6f5 100644
> --- a/include/linux/usb/typec_tbt.h
> +++ b/include/linux/usb/typec_tbt.h
> @@ -46,6 +46,7 @@ struct typec_thunderbolt_data {
>  #define TBT_CABLE_OPTICAL		BIT(21)
>  #define TBT_CABLE_RETIMER		BIT(22)
>  #define TBT_CABLE_LINK_TRAINING		BIT(23)
> +#define TBT_CABLE_ACTIVE_PASSIVE	BIT(25)
>  
>  #define TBT_SET_CABLE_SPEED(_s_)	(((_s_) & GENMASK(2, 0)) << 16)
>  #define TBT_SET_CABLE_ROUNDED(_g_)	(((_g_) & GENMASK(1, 0)) << 19)
> -- 
> 2.25.1

-- 
heikki
