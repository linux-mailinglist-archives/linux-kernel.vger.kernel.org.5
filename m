Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162B67A0183
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbjINKT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbjINKT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:19:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD4B1BE3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:19:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E03C433C7;
        Thu, 14 Sep 2023 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694686792;
        bh=YCNn/tftIIYVmh85nuACsWJJWr1SgTpaADdxerbE3jo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQKcOVXnYoyDU+CmvlXYfl75Hq+KlaF/D5GfPs23cv2tHs89jVNLTqO5wL/8efOHK
         V/hvIWyrlu8rvSjoaB3s+0LskoYUQoLXnR6lnvyM6lz4YJL85LX1y/Ifr7GpdMeOHX
         Cs/qG+mjWFZ+u0PKwBQ85511LS/x0SG5e7OS7vkeLFfi48Yd6n9CupMrG/uK5Ha1Ed
         iDL7PrHJ2q/Km2JI1NLJ5RHXzNrfwfc998Of2AXzS/4d3S6zuKDfIUKQQvDwFK5dmo
         G29HWttxY38t54lMszTsRlAU6YQBbuSZWotU3cvX2SjbdS1npkw+o2y5oi67QCXlU5
         qcN0LW0vrI2Cw==
Date:   Thu, 14 Sep 2023 11:19:47 +0100
From:   Lee Jones <lee@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH] mfd: cs42l43: Use correct macro for new-style PM runtime
 ops
Message-ID: <20230914101947.GM13143@google.com>
References: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
 <20230904144008.GG13143@google.com>
 <87zg20cfkm.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg20cfkm.fsf@mail.lhotse>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2023, Michael Ellerman wrote:

> Lee Jones <lee@kernel.org> writes:
> > On Tue, 22 Aug 2023, Charles Keepax wrote:
> >
> >> The code was accidentally mixing new and old style macros, update the
> >> macros used to remove an unused function warning whilst building with
> >> no PM enabled in the config.
> >> 
> >> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
> >> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >> ---
> >>  drivers/mfd/cs42l43.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> >> index 37b23e9bae823..7b6d07cbe6fc6 100644
> >> --- a/drivers/mfd/cs42l43.c
> >> +++ b/drivers/mfd/cs42l43.c
> >> @@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
> >>  }
> >>  
> >>  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
> >> -	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> >> -	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> >> +	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
> >> +	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
> >>  };
> >>  
> >>  MODULE_DESCRIPTION("CS42L43 Core Driver");
> >
> > Acked-by: Lee Jones <lee@kernel.org>
> >
> > If anyone wants to submit this directly to Linus before -rc1, please, be
> > my guest.
> 
> But you're the MFD maintainer, aren't you? So I think everyone is
> expecting you to send it to Linus.

And I will.  The offer was in case anyone (with more spare time than I)
wanted to send it before I had a chance.

-- 
Lee Jones [李琼斯]
