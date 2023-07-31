Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52776A42F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 00:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjGaW3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 18:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjGaW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:29:19 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9861BE7;
        Mon, 31 Jul 2023 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690842556; x=1722378556;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=leP0Lsh2oZjINqhY07RoUkoTTGnDfpaMDoYbYdZ1TC0=;
  b=dOqXYIrn68zMbv6xlzE1HvRD/Wl+DVlO16UIm2nmss9bqFQAv8JdeN9i
   vka7z1KtRajis4IhdERbZG7s9HWKeRgL54Pl6HiOZcEPmuUphRCTFy77S
   kpNKfxGURD8wxLpuN+0/UcJ+UurG/SLI5dbXSbgqLMFfWzaNRIxpuemfl
   dx9MEuRD7qvhQ+AEonNxNXdHcwEAXV2+0sju1f+O90E0hMcIz4Pcy3/vl
   b/7UG2hY7UOg68T8hnPXOIoj4n6BvKWBkT1oK3gsyVK4yDUcyvcMb8Y0X
   NxMBr3zjzB/yguiR10Za0xh+hotDAG3Pq06hbpwGEE3x9STxLlM7VhHJf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="368045388"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="368045388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 15:29:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="871828031"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 15:29:15 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id D315111F9B6;
        Tue,  1 Aug 2023 01:29:10 +0300 (EEST)
Date:   Mon, 31 Jul 2023 22:29:10 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the v4l-dvb-next tree
Message-ID: <ZMg1tmx5bvFPsWgm@kekkonen.localdomain>
References: <20230731075552.52fbe351@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731075552.52fbe351@canb.auug.org.au>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Jul 31, 2023 at 07:55:52AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   7581c293584f ("media: adv748x: Return to endpoint matching")
> 
> Fixes tag
> 
>   Fixes: ("media: v4l: async: Simplify async sub-device fwnode matching")
> 
> has these problem(s):
> 
>   - No SHA1 recognised
> 
> Maybe you meant
> 
> Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")

That would work for me, yes.

The patch that broke adv748x driver had no stable commit ID at the time the
fix was merged.

-- 
Kind regards,

Sakari Ailus
