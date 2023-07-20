Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9975B4ED
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGTQqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGTQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:46:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552EE123;
        Thu, 20 Jul 2023 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689871596; x=1721407596;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=mz5JTNmSYCHJWPQs4MIZxjkzaFRXYwYIWdDhNWmTAi4=;
  b=mEHdoDNDqspQ9oCQ8zykp4q/y29+R9xvtzVUNo53SpU6qQB80Rc1g9Jp
   8lUkM52UUOsEubiE6ihznQ86Eu7HBqkIxtwq5io8vw0rGdLfgcxWqhfdX
   PEDnN7QqT55jMariI2XUl0qHDOeAye1ZUB18mmOoOTtXV75zc8y3InVRE
   3izh6zEQnxkjMMmKsICcmnK9zhf7qNKPHlX/mdvBx87yw/PJBJETV2Dxf
   DaHIrFTV4J59aIZQyD37FPvcrEKGeacfMJRfR2xKstuAKO5iBHmAhTyKr
   H7mX51T9ckx/oxeqi9Bicgg1tba7/MUDnoCmM5phXJdmg1QOdtq0pwhuA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="370392706"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="370392706"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:46:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="724482139"
X-IronPort-AV: E=Sophos;i="6.01,219,1684825200"; 
   d="scan'208";a="724482139"
Received: from ofibrahi-mobl2.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.251.12.233])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 09:46:16 -0700
Message-ID: <e9befc235e14b8a8ca539c95eadcc4bff2d758d1.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Support more than 8
 sockets.
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Frank Ramsay <frank.ramsay@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Jul 2023 09:46:16 -0700
In-Reply-To: <20230720160803.1648970-1-frank.ramsay@hpe.com>
References: <20230720160803.1648970-1-frank.ramsay@hpe.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-07-20 at 11:08 -0500, Frank Ramsay wrote:
> MAX_PACKAGE_COUNT limits the intel-speed-select to systems with 8
> sockets or fewer.
> On a system with more than 8 sockets intel-speed-select silently
> ignores everything
> beyond the 8th socket, rendering the tool useless for those systems.
> 
> Increase MAX_PACKAGE_COUNT to support systems with up to 32 sockets.
> 
Thanks for the patch. I will queue this for the next release.

-Srinivas

> Signed-off-by: Frank Ramsay <frank.ramsay@hpe.com>
> ---
>  tools/power/x86/intel-speed-select/isst.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/isst.h
> b/tools/power/x86/intel-speed-select/isst.h
> index 54fc21575d56..8def22dec4a2 100644
> --- a/tools/power/x86/intel-speed-select/isst.h
> +++ b/tools/power/x86/intel-speed-select/isst.h
> @@ -79,7 +79,7 @@
>  
>  #define DISP_FREQ_MULTIPLIER 100
>  
> -#define MAX_PACKAGE_COUNT      8
> +#define MAX_PACKAGE_COUNT      32
>  #define MAX_DIE_PER_PACKAGE    2
>  #define MAX_PUNIT_PER_DIE      8
>  

