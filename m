Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57C97B64B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbjJCIwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjJCIw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:52:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04F4A9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696323146; x=1727859146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zhcWgFLMNyXFJZkcZf3suC/60ANCId4w8ZT0ekq8xNs=;
  b=Bd1S1Rzppxytj1xKt59OrdhlHVx94LXUcwhcO6yIBA85+kOPVx8Zx+4w
   FjIANRoRtW/QvXLdAK6GNTdsRbHZOGzmN/BGZDyNElfp3K9sZx5UO4Y7n
   IWwde0d/X5ihSVevU8PsphsGfER+QeLBba73i6PoOieWkVCg66FXMcU4C
   AsXt+4wGX8F+AvhS2NKQVdkw+OnS1415ns9VX4xkvymeT3j8+urZWNGcl
   KXnQ5kgzs3FJNUEMDdBvv3ONw/PfONa+MrGcTABjCww0/WYCBZgXwQcCT
   BJA3QxDTVQkX5mjHYOwozqg3xVKTc1oalMWZYi/CGa3mvP2hQowm0x4Iu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="363093971"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="363093971"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:52:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="700630131"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="700630131"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 01:52:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnb8b-00000002RBx-33f0;
        Tue, 03 Oct 2023 11:52:17 +0300
Date:   Tue, 3 Oct 2023 11:52:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, broonie@kernel.org,
        robh+dt@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        tiwai@suse.de
Subject: Re: [PATCH v1] ASoC: tas2781: fixed compiling issue in m68k
Message-ID: <ZRvWQQzrvtzkJ/UV@smile.fi.intel.com>
References: <20231002090434.1896-1-shenghao-ding@ti.com>
 <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdXr5oRgkFqYZnPe3Xdyq_QjtzhfL8Wa_e9JA0S1XhEhWw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 09:24:21PM +0200, Geert Uytterhoeven wrote:
> On Mon, Oct 2, 2023 at 4:38 PM Shenghao Ding <shenghao-ding@ti.com> wrote:

...

> Gr{oetje,eeting}s,
> 
>                         Geert

I believe patch is already in the Mark's tree, so we now ought to live with it.

-- 
With Best Regards,
Andy Shevchenko


