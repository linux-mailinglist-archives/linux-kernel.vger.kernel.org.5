Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E672F779291
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbjHKPLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjHKPL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:11:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A822F171F;
        Fri, 11 Aug 2023 08:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691766688; x=1723302688;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cjpcej3exmxfLa8oaOup6NX7xPqbLEY+b/Fz8WNpEn0=;
  b=ifYAl46JNZNadbffRsn+AIr7NmlL4HRgMKu1pNPf/mvhTsiWXkrTXZ40
   f2JTUWfJUfUySyRn1ciFoJfcOXqWXgbjQDEY8Yci6Z9awtwyZWI+16262
   qZISMKLi6FHYlUqhDvZ+3B5wPPGgMsUCPO5/zihybcnPMvWvouMnjd4um
   ByyA4xu5n5iFPr/aJGW4ZTn9h9tiVmQXJieHJOfIImH7t6mqAgICSphcJ
   JCJmCgg2BLf2PQ5/unzIFlsGCrku16rEGRUX8OolCIJUplKT4QAgoKeJM
   bmiIO4WRSv4Y3T/0pAR9Sgp/H6YI7R8YQRBBfTiYHJBG+OJhvZXFkxzDu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="370595516"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="370595516"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 08:11:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="682574137"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="682574137"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 08:11:25 -0700
Date:   Fri, 11 Aug 2023 23:09:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/3] fpga: bridge: make fpga_bridge_class a static
 const structure
Message-ID: <ZNZPGa8u43v6UKsI@yilunxu-OptiPlex-7050>
References: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811073043.52808-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-11 at 11:30:41 +0400, Ivan Orlov wrote:
> Now that the driver core allows for struct class to be in read-only
> memory, move the fpga_bridge_class structure to be declared at build
> time placing it into read-only memory, instead of having to be
> dynamically allocated at boot time.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied this series.
