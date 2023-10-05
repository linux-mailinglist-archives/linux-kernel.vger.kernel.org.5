Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B727BA5F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242749AbjJEQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241314AbjJEQQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260593F1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:31:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8121FC43391;
        Thu,  5 Oct 2023 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696516273;
        bh=PFjqfxHz1axufGhNaauK3zpHZx5oVEDTMQRFxAN+0xg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIaAqstQdbs3z+EZ0Jpt0Burvo005Fp2Jxy2pTcnjjx0T90MbZakHTxfHK00hmEUr
         EKvvCfg/Rh1lf8bMtpoBtrJWLv5PLj47uZ2HasMrxqhnPSpkHJ10QBHTwU6fPc0AsI
         Yu/W87cDXHwmLoIbfZl4D2FuoW7YPrMDHGbKNc/Kx1ijkXzWylOgisS7XRokw0zOri
         0jN8z3vZdg060iWd1noZNdG71pg9eIEU4XkRm6579MpUYUr8whyaG/ZYGBOhOZNXEy
         tc927VsL4DSPNU16NkzjcUUk6eVm3y+BVWiyMzZlYVz6rWH9gFybZC1u905/bGj6FN
         ES1iA+1/IDH0w==
Date:   Thu, 5 Oct 2023 15:31:09 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: (subset) [PATCH] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
Message-ID: <20231005143109.GH681678@google.com>
References: <20231002083344.75611-1-jarkko.nikula@linux.intel.com>
 <169651386914.775665.8508120735864164763.b4-ty@kernel.org>
 <ZR7AkFUoB1PkCkeg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZR7AkFUoB1PkCkeg@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023, Andy Shevchenko wrote:

> On Thu, Oct 05, 2023 at 02:51:09PM +0100, Lee Jones wrote:
> > On Mon, 02 Oct 2023 11:33:44 +0300, Jarkko Nikula wrote:
> > > Add Intel Lunar Lake-M SoC PCI IDs.
> > 
> > Applied, thanks!
> > 
> > [1/1] mfd: intel-lpss: Add Intel Lunar Lake-M PCI IDs
> >       commit: ae1fbe1b021a3075020856b2717fd971a72f9429
> 
> Just a side note, are you sure the word 'subset' makes sense when you take
> _all_ patches?

It doesn't.

It happens when there is only one patch in the set and is an artefact of:

  `b4 -P _`  # Cherry-pick the msgid specified

Man:

  -P CHERRYPICK, --cherry-pick CHERRYPICK
                        Cherry-pick a subset of patches (e.g. "-P
			1-2,4,6-", "-P _" to use just the msgid
			specified)

-- 
Lee Jones [李琼斯]
