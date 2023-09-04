Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4057911C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352262AbjIDHIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjIDHIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:08:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027AA0;
        Mon,  4 Sep 2023 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693811323; x=1725347323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5GwBKbpmFr0aZ67umoUwgJSAFkhHEf+KcTKL1yUkqok=;
  b=XfsTIde9OuLcMLX4JXJXpJcI5ZoGrMwLJMM0H9swF4MmJLBZ5butFkEA
   K0Xhycgd7ovX8VxPk8GwIUrsR1pE0YIZV/183ppBsQAwxZ6Kx7SKU7Qu3
   3TT60gZpYNIDeI09bCcYyuEy4NDv0cV9tUVop/zsmwUB7sFdDAuCAN+Bt
   7QBifx+rKN4lKYL6jI7mWQ3sB2Hng8wK2v7Vq1Pw3EyyriMikyJC3UJQE
   i68zWZSKX/36AGqTZ8Po/i8VnlUK+x5HgW2uJrOt5BMUzLFyQqQangnxk
   GDtQOpju9hS/D+YDoHa0nYXiqWgAEYL7FDe05JFVMj7NvJ47Cue45LT69
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="376465301"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="376465301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 00:08:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="883933515"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="883933515"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 04 Sep 2023 00:08:34 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Sep 2023 10:08:38 +0300
Date:   Mon, 4 Sep 2023 10:08:38 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        pmalani@chromium.org, chrome-platform@lists.linux.dev,
        andriy.shevchenko@linux.intel.com, bleung@chromium.org
Subject: Re: [PATCH v2 3/5] usb: pd: Add helper macro to get Type C cable
 speed
Message-ID: <ZPWCdiSkeRA+CJ+i@kuha.fi.intel.com>
References: <20230830223950.1360865-1-utkarsh.h.patel@intel.com>
 <20230830223950.1360865-4-utkarsh.h.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830223950.1360865-4-utkarsh.h.patel@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 03:39:48PM -0700, Utkarsh Patel wrote:
> Added a helper macro to get the Type C cable speed when provided the
> cable VDO.
> 
> Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
> - This change is being added as new patch in this series.
> 
>  include/linux/usb/pd_vdo.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
> index b057250704e8..3a747938cdab 100644
> --- a/include/linux/usb/pd_vdo.h
> +++ b/include/linux/usb/pd_vdo.h
> @@ -376,6 +376,7 @@
>  	 | ((vbm) & 0x3) << 9 | (sbu) << 8 | (sbut) << 7 | ((cur) & 0x3) << 5	\
>  	 | (vbt) << 4 | (sopp) << 3 | ((spd) & 0x7))
>  
> +#define VDO_TYPEC_CABLE_SPEED(vdo)	((vdo) & 0x7)
>  #define VDO_TYPEC_CABLE_TYPE(vdo)	(((vdo) >> 18) & 0x3)
>  
>  /*
> -- 
> 2.25.1

-- 
heikki
