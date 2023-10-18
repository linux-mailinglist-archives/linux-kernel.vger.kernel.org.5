Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998E17CD9F4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjJRLAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjJRLAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:00:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EEEA
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697626813; x=1729162813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=COxJInCL0jGxY7ESovjNwogq2qyUcFkuDBB6vSCiReM=;
  b=jVSML2za00uHck8vBTUxp3NjWh246+iV0BuwH7yYyGkR90Oqt8O3SBiD
   sWX0J/aBq6eS0rHG910eUC3phCSIBr0Nxb8gFKsUGM3oNF95iGqf5zNdl
   wjX5mSIcB5meLhNLdKelEA0aLfKNK/M4uOdDExSAM9aibJ505GFSbRFEY
   YMpXta/nJBn/LGjXFxrxmaEsnbvUCpm8ayKoMCupeF4r31XKdlkmNY2K6
   Mu9TRIN2HOzVXE3UtfdPnu0+zfjJcDMRDSM4q9SsfF81ZYx15X4yeZCDC
   Jb5tKFdvwv/X2bd6Z13b3x6iiSVLTEnC9ymnXAsnqZEIo9CgcRIKLIuH0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365338340"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="365338340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 04:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900303900"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="900303900"
Received: from nurfahan-mobl3.gar.corp.intel.com (HELO intel.com) ([10.213.159.217])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 03:58:05 -0700
Date:   Wed, 18 Oct 2023 13:00:01 +0200
From:   Andi Shyti <andi.shyti@linux.intel.com>
To:     Soumya Negi <soumya.negi97@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: vme_user: Use __func__ instead of function
 name
Message-ID: <ZS+6sTNNZ5KUzpd4@ashyti-mobl2.lan>
References: <cover.1697601942.git.soumya.negi97@gmail.com>
 <c553e5901f16b78681e74b2d77796f8fc102b602.1697601942.git.soumya.negi97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c553e5901f16b78681e74b2d77796f8fc102b602.1697601942.git.soumya.negi97@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soumya,

On Tue, Oct 17, 2023 at 09:36:33PM -0700, Soumya Negi wrote:
> Replace function names in message strings with __func__ to fix
> all checkpatch warnings like:
> 
>     WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
>              this function's name, in a string
> 
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/staging/vme_user/vme.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
> index e8c2c1e77b7d..11c1df12b657 100644
> --- a/drivers/staging/vme_user/vme.c
> +++ b/drivers/staging/vme_user/vme.c
> @@ -422,7 +422,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
>  	image = list_entry(resource->entry, struct vme_slave_resource, list);
>  
>  	if (!bridge->slave_get) {
> -		dev_err(bridge->parent, "vme_slave_get not supported\n");
> +		dev_err(bridge->parent, "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -572,7 +572,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
>  	image = list_entry(resource->entry, struct vme_master_resource, list);
>  
>  	if (!bridge->master_set) {
> -		dev_warn(bridge->parent, "vme_master_set not supported\n");
> +		dev_warn(bridge->parent, "%s not supported\n", __func__);

I wouldn't disagree if you made this dev_err() instead of
dev_warn(). The reasoning behind is that if it's a warning you
should not fail. But beacuse you are returning -EINVAL it means
that you are failing, therefore you should use dev_err().

Others might object that the change I'm suggesting sohuld go in a
different patch, which is also OK.

>  		return -EINVAL;

... or, if you want to keep the dev_warn(), whou can consider
removing the "return -EINVAL;". But this is an evaluation you
should make in a different patch and mainly evaluate if it's
OK to remove the error here.

>  	}
>  
> @@ -1565,7 +1565,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_set) {
> -		dev_err(bridge->parent, "vme_lm_set not supported\n");
> +		dev_err(bridge->parent, "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1601,7 +1601,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_get) {
> -		dev_err(bridge->parent, "vme_lm_get not supported\n");
> +		dev_err(bridge->parent, "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1638,7 +1638,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_attach) {
> -		dev_err(bridge->parent, "vme_lm_attach not supported\n");
> +		dev_err(bridge->parent, "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1671,7 +1671,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
>  	lm = list_entry(resource->entry, struct vme_lm_resource, list);
>  
>  	if (!bridge->lm_detach) {
> -		dev_err(bridge->parent, "vme_lm_detach not supported\n");
> +		dev_err(bridge->parent, "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}
>  
> @@ -1738,7 +1738,7 @@ int vme_slot_num(struct vme_dev *vdev)
>  	}
>  
>  	if (!bridge->slot_get) {
> -		dev_warn(bridge->parent, "vme_slot_num not supported\n");
> +		dev_warn(bridge->parent, "%s not supported\n", __func__);
>  		return -EINVAL;
>  	}

Nothing wrong with the patch itself. But imagine if we end up in
one of those printouts and, as a user, you read something like:

   ... vme_slot_num not supported

The message itself doesn't say much to the user. The perfect fix
would be to re-write all these error messages with a proper
meaningful sentence, like, e.g.:

   Can't retrieve the CS/CSR slot id

(don't even know if it's fully correct). Anyway, I understand
you don't have much time for such fine changes, so whatever you
decide to do:

Acked-by: Andi Shyti <andi.shyti@linux.intel.com> 

Andi
