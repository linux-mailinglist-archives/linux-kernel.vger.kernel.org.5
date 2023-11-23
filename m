Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0457F61DF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345870AbjKWOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345905AbjKWOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:47:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82BBD4F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:47:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BAE1C433C7;
        Thu, 23 Nov 2023 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700750859;
        bh=+th0nIoDm1aaTnqJ4eM6ZXTyefMOYaMLSlSeSUCjtjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hZo0f+CLMFYCcBTjYTUawrekLzgsPKFVVK7dGUuLcztUIWJoYKIV31J/zWOdbqLLj
         +6xJAATodTiRJJy+Ll3TQBa8GaOyS+88QHHEM+Umo985t4LWSqucNd9buqN5s+F0qS
         d6EFak9zGW7Q2FpFVu1ZI80EbL8iKJYTv1vYpmKAEpFT14Az+2xWh8HY6nbEAkKy77
         lfolfJ+gtBOxKChZ03O3eZKtLzn+aQ4Gm3i92Ohi4b8MYhUe1ZkeKd5RaiEc1ZaB72
         uo8luPBhZPDY/Gb/gR5fz1DN4o/m0GHjHEIBoqOnHyNDD+nxnDwcKhJ2QSJnaKXGR+
         2So+TMpaoW6sw==
Date:   Thu, 23 Nov 2023 14:47:35 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 2/4] leds: trigger: gpio: Convert to use kstrtox()
Message-ID: <20231123144735.GB1354538@google.com>
References: <20231103195310.948327-1-andriy.shevchenko@linux.intel.com>
 <20231103195310.948327-2-andriy.shevchenko@linux.intel.com>
 <20231123110538.GA1243364@google.com>
 <ZV9dd6khfmWmj6D_@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZV9dd6khfmWmj6D_@smile.fi.intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023, Andy Shevchenko wrote:

> On Thu, Nov 23, 2023 at 11:05:38AM +0000, Lee Jones wrote:
> > On Fri, 03 Nov 2023, Andy Shevchenko wrote:
> 
> ...
> 
> > > -	ret = sscanf(buf, "%u", &desired_brightness);
> 
> "%u" (see man sscanf() for the details)
> 
> ...
> 
> > > +	ret = kstrtou8(buf, 10, &desired_brightness);
> > 
> > Where does 10 come from?
> 
> See above.

Hmmm ...

I see that this is generally accepted.  Although is looks like a recipe
for bugs to me.  It's a shame we don't have something that can take a
variable, derives its type, then calculates the maximum length if
converted to a string.

Anyway, I'm probably babbling now ...

-- 
Lee Jones [李琼斯]
