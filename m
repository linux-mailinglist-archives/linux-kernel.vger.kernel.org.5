Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D25C776AFE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 23:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjHIVcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 17:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjHIVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 17:32:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AB710DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 14:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691616772; x=1723152772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YHb8Cp56jyZYNVtS3IY5otBMco1m0Bx1xThJXquC5qE=;
  b=mHMxrDIuRjJWvB3yltZaW1bsVbS1c5xTtH+U/sYe3MSoBddMJHh4mo1L
   2gSZlEJ6/D2KQRDpMxyxBEtX6kYSx0QSzzDzYRKDoNqlk14YnENReV9PF
   VSgKvymRJOu1uBRFcu6HCWW8Ci7zgu80U0wlV5bPjRxnbbdbI1AaP7Vr3
   FEXW4HKKUQ5RWBblvTusui+TbkkK50tzvi0uutSdsd1hZ4UktpmJkODHS
   Kt1XUvZtDhVSOc9Oc7m/K4ghNh6dGRx2PFRoTlyDaGj6+QK32DdNLv69O
   MwiuiU8d3FuBk6i5wUb+k1mul9huMIMFPGBjuJsDQ4oI0spGAVTaQw2Im
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350814258"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="350814258"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:32:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="1062642092"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="1062642092"
Received: from brentchi-mobl.amr.corp.intel.com (HELO desk) ([10.212.254.92])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 14:32:35 -0700
Date:   Wed, 9 Aug 2023 14:32:14 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/3] Documentation/hw-vuln: Unify filename specification
 in index
Message-ID: <20230809213214.ns7t2enjrgnms2ee@desk>
References: <20230809102700.29449-1-bp@alien8.de>
 <20230809102700.29449-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809102700.29449-2-bp@alien8.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:26:58PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Most of the index.rst files in Documentation/ refer to other rst files
> without their file extension in the name. Do that here too.
> 
> No functional changes.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/admin-guide/hw-vuln/index.rst | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
> index a7d37e124831..aeee8bff5f82 100644
> --- a/Documentation/admin-guide/hw-vuln/index.rst
> +++ b/Documentation/admin-guide/hw-vuln/index.rst
> @@ -13,11 +13,11 @@ are configurable at compile, boot or run time.
>     l1tf
>     mds
>     tsx_async_abort
> -   multihit.rst
> -   special-register-buffer-data-sampling.rst
> -   core-scheduling.rst
> -   l1d_flush.rst
> -   processor_mmio_stale_data.rst
> -   cross-thread-rsb.rst
> +   multihit
> +   special-register-buffer-data-sampling
> +   core-scheduling
> +   l1d_flush
> +   processor_mmio_stale_data
> +   cross-thread-rsb
>     srso
>     gather_data_sampling.rst

While at it could you please also change this? Else, I will send another
patch.
