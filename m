Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414D07C645D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376996AbjJLFKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJLFKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:10:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984D790;
        Wed, 11 Oct 2023 22:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697087447; x=1728623447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C4mBv6RqE4nLejofYaR49afEkLr26oKjpLoELOOXaCQ=;
  b=Y84ifWIrI0cCLFDFWhhu7WdVh+PK1Ea7k9AQIaAxxSM/vLBYoQYnTl9s
   KmdaaF3U6aBg6/NbnjMtC1WKsC6xs3eyyy2T+muNOw53I9pcASGbgMee+
   oIMZwJlF0RN0MZHk7c400An9qNHFS7dW/+qUXs6nrckiP9yJxEUMwHF/9
   7BRj5nP1MXzdAN1D3OVg2w2LmtV83SyRkz7BBUAWiroMeBjdM/qNUMuIu
   8WUzY1dQRmQcjg9d7UFff4GAj/RR14v/u9h2R6HNXu0fmXEgKbq6WVgpZ
   rzk5hHn7xQCehJA0nA9VovpvDTqhjBkMJYIDScVXStL1pFtGYXlOoIBmP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="387670808"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="387670808"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 22:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="897939060"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="897939060"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga001.fm.intel.com with ESMTP; 11 Oct 2023 22:08:57 -0700
Date:   Thu, 12 Oct 2023 13:09:48 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "yilun.xu@intel.com" <yilun.xu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH] fpga: versal: Add support for 44-bit DMA operations
Message-ID: <ZSd/nI/HWEYxcm5a@yilunxu-OptiPlex-7050>
References: <20231003071409.4165149-1-nava.kishore.manne@amd.com>
 <ZSEF1TOpd13BkCXL@yilunxu-OptiPlex-7050>
 <DM6PR12MB3993439C9BE6F52664D9C394CDCDA@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3993439C9BE6F52664D9C394CDCDA@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 05:37:43AM +0000, Manne, Nava kishore wrote:
> Hi Yilun,
> 
> 	Thanks for providing the review comments.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Xu Yilun <yilun.xu@linux.intel.com>
> > Sent: Saturday, October 7, 2023 12:47 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> > trix@redhat.com; linux-fpga@vger.kernel.org; linux-kernel@vger.kernel.org;
> > Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > Subject: Re: [PATCH] fpga: versal: Add support for 44-bit DMA operations
> > 
> > On Tue, Oct 03, 2023 at 12:44:09PM +0530, Nava kishore Manne wrote:
> > > The existing implementation support only 32-bit DMA operation.
> > > So, it fails to load the bitstream for the high DDR designs(Beyond 4GB).
> > > To fix this issue update the DMA mask handling logic to support 44-bit
> > 
> > This is the HW defined DMA addressing capability. Does the device only
> > support up to 44 bits DMA? Any Doc?
> > 
> The versal platform supports a maximum physical address size is 44-bit in AArch64.
> For more details, please refer the Versal TRM (Memory space- section):
>  https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/Memory-Space

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.

> 
> Regards,
> Navakishore.
> 
