Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA494757F06
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjGROIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjGROIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:08:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76A2AC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689689289; x=1721225289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YhzlfQtbZbvU7crsK9NP3Zkf40qmEHwn35CPkp07c3s=;
  b=G2/VPPOUI0gjKrOtr0TG6TGnq/KKz7ElYco+8bzjXszC1CioSJZkS3Wb
   9Mv4aFVvFVF6oCPkg4T+MI3BEwEFHngDPLXSAJg+lktDqQ/HCfWZO1M4G
   /UjRDfPDT12C+8US9xECXRpGkzUekTZbxffGdrIi+mv3xcI61rrwzF3/h
   TT+R0se+lYTIDCJdMz7xov//vEavOaCjwGtukVHIFpvue+LiGO+TAiyk8
   lScFuU/Z2JFm75XOI3UUPzDVN/N7wMdsos1cpxqKMsRey0iAl65bXwUDk
   yKzXH1GiyLgCf0rchdG/Sz3yw72425FiSVVCUuXCzzWtW2PShN7VeZwSp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="397053551"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="397053551"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 07:08:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="758804280"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="758804280"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 18 Jul 2023 07:08:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qLlMy-00GQUQ-0w;
        Tue, 18 Jul 2023 17:08:04 +0300
Date:   Tue, 18 Jul 2023 17:08:04 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     hanyu001@208suo.com
Cc:     agust@denx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, bhelgaas@google.com, kw@linux.com,
        mika.westerberg@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platforms: 52xx: Remove space after '(' and before ')'
Message-ID: <ZLacxHz/IGgketWx@smile.fi.intel.com>
References: <tencent_ADAD5C6DD5F9824047356B25D53801910A06@qq.com>
 <c5c33e6e390f6784b5599b8ea13b8e01@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c33e6e390f6784b5599b8ea13b8e01@208suo.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 05:02:39PM +0800, hanyu001@208suo.com wrote:
> The patch fixes the following errors detected by checkpatch:
> 
> platforms/52xx/mpc52xx_pci.c:346:ERROR: space prohibited after that open
> parenthesis '('
> platforms/52xx/mpc52xx_pci.c:347:ERROR: space prohibited after that open
> parenthesis '('
> platforms/52xx/mpc52xx_pci.c:348:ERROR: space prohibited before that close
> parenthesis ')'

First of all, your patch is mangled and may not be applied.
Second, we usually don't do this kind of patches at all.
Besides the fact that we don't run checkpatch on the files
which are already in upstream (esp. so-o-o old as this one).

NAK.

...

> +    if ((dev->vendor == PCI_VENDOR_ID_MOTOROLA) &&
> +         (dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200
> +          || dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200B)) {

Also note, you can move this to use pci_match_id().
That kind of patch might be approved.

-- 
With Best Regards,
Andy Shevchenko


