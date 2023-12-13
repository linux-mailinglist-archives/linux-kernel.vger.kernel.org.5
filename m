Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9988811B83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbjLMRqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjLMRqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:46:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950399
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:46:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF299C433C7;
        Wed, 13 Dec 2023 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702489569;
        bh=X3fZW1ftoAwjxfIDgegK09VezD4UiqgtwXe9IKxubq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/3dmiHc6DO0k/nqHigU6D0v9tb8kZ+4qgetXpz4BvSpBhA7GBt2O7mXiX0qyq74c
         m/0cuyYUWwZsnQYwuLxrOIu/brlRi6cP8J0JZUrQD1KhmLj9SkpbCHRpXpWhmr6erD
         oo4rDkawuACkX/zkGNc5b2ylziR6R7PAn/NOkvBy57KQogt22Tf/VKr8x39YyYlu2d
         tG4hOvczRzzYG3QgtgZtOKKYanwpSdiTeWttrm9bBLN8M/DuZjXk1QrW+wnkBjkvaa
         V3JcAUnH17+QbFFuV6Su0+5XRMuCVNTlTYG3ZLYLPk+BpmjKn2FvrmJnOEeSLS1uwM
         bxc/WMEcDU45Q==
Date:   Wed, 13 Dec 2023 17:46:05 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Vinarskis <alex.vinarskis@gmail.com>
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Fix the fractional clock divider
 flags
Message-ID: <20231213174605.GS111411@google.com>
References: <20231211111441.3910083-1-andriy.shevchenko@linux.intel.com>
 <20231213161352.GQ111411@google.com>
 <ZXnZDjnor8oQNo2g@smile.fi.intel.com>
 <20231213161854.GR111411@google.com>
 <ZXnbGbjm-i7n4qU3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXnbGbjm-i7n4qU3@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023, Andy Shevchenko wrote:

> On Wed, Dec 13, 2023 at 04:18:54PM +0000, Lee Jones wrote:
> > On Wed, 13 Dec 2023, Andy Shevchenko wrote:
> > > On Wed, Dec 13, 2023 at 04:13:52PM +0000, Lee Jones wrote:
> > > > On Mon, 11 Dec 2023, Andy Shevchenko wrote:
> 
> ...
> 
> > > > >  	tmp = clk_register_fractional_divider(NULL, name, __clk_get_name(tmp),
> > > > > +					      0, lpss->priv, 1, 15, 16, 15,
> > > > >  					      CLK_FRAC_DIVIDER_POWER_OF_TWO_PS,
> > > > > -					      lpss->priv, 1, 15, 16, 15, 0,
> > > > >  					      NULL);
> > > > 
> > > > What an ugly interface.  Intel-only too, right?
> > > 
> > > Nope, de facto way how custom clocks are being introduced.
> > > See clk-provider.h for several similar APIs (that require an
> > > additional, custom, flags to be supplied).
> > 
> > This call only has 2 call-sites, both Intel.
> 
> Yes, but the clock fractional divider is used wider.
> 
> And again, it's not related to Intel, as this how clock framework
> does the custom clocks. I don't know how to say this clearer.

I'm not sure how you can say that.  Intel were the authors, hold the
_only_ copyright and are the _only_ users.  If it were to be removed,
there is only a single entity that would even notice.

Anyway, it was just a passing comment.  Not positive, not negative.

-- 
Lee Jones [李琼斯]
