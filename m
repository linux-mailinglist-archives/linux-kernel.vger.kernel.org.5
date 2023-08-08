Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01D773BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjHHP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjHHP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 11:57:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964685FD1;
        Tue,  8 Aug 2023 08:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691509444; x=1723045444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RZ4/MiSXawJbtf6Nv9QHvcNFvlpADKae6i7144hH2Mk=;
  b=D5tKoJ4L57M0Ecu5itDFD2xg6LZG4j5W+oZIhhpnH2aL+OGQjMYMXpkm
   qmmL+xhtlkcyonvWpVwWVfiif3UQcrbI6AdXadqxXDJZ06ruKF5PidsPO
   6wkcil22XXI95lZEG0p+icPwPWxWaIbIt5qU2p9FGIxZiBU4Tv4ZJQiki
   n/EaXKZGVPFwSG1TQtIEHSPVIBELhIFMVYV/YEkE124kOLtUyETC0AWSr
   4d9hLAT4hJ5vLKIMdfCxGCQ3smIaX09zG9ZyKqa4VlSZvg/rwYATnYqyb
   bEIJVidG4QpSvlQmGYg6R9yGca8tG9LqC88sX51DHUQvdoSMKZ7RWf3Gm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457209977"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457209977"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:38:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="905218195"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="905218195"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 08 Aug 2023 06:38:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id C830C2A6; Tue,  8 Aug 2023 16:41:42 +0300 (EEST)
Date:   Tue, 8 Aug 2023 16:41:42 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: baytrail: consolidate common mask operation
Message-ID: <20230808134142.GQ14638@black.fi.intel.com>
References: <20230808084901.18927-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230808084901.18927-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 02:19:01PM +0530, Raag Jadav wrote:
> Consolidate common mask operation outside of switch cases and
> limit IO operations to positive cases.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
