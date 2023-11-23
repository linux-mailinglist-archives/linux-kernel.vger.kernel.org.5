Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479957F5C99
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344727AbjKWKjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjKWKjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:39:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38103D4E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:39:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729FDC433C8;
        Thu, 23 Nov 2023 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700735950;
        bh=V8QlEn1tY3YvzwuTK49GT3h8aeTQCvMtxhMSaCgWClk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqIm9pmM3F/b/jxXxLJElshcaHgClNYbZt3mJ2gBxmGQnlqYalp/F0AIV0SGbwoqS
         3xh2DhJnCWYbsf4/bLwj2OmdQq/6rsPhS4XyKAbmcTHSUsWGZ/Do/ygrojCFu6m5f6
         mEQB4khLIXD+iTxSU3Na+u+0YmiIKfbVKwYqlakSRDKz8k3S5vKgnvMdJ/IkITLvG3
         sWO7jv+kIIQc5vLuks1VZJpk+o+tKNcGh+yxn63IEJEAQgT5ORC6Q481mamyJqeHv9
         8FiZIyj7Wyl2gTM+yt3VvPhh/lhiOrmugacrlTbnOc47hy4AOPSvWxGBAdAsEqH/0z
         qP0pZ98ZZoP8w==
Date:   Thu, 23 Nov 2023 10:39:06 +0000
From:   Lee Jones <lee@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     tony@atomide.com, robh@kernel.org, wens@csie.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl4030-power: Revert to use of_match_device()
Message-ID: <20231123103906.GE1184245@google.com>
References: <20231029114909.15652-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231029114909.15652-1-peter.ujfalusi@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2023, Peter Ujfalusi wrote:

> The core twl chip is probed via i2c and the dev->driver->of_match_table is
> NULL, causing the driver to fail to probe.
> 
> This partially reverts commit 1e0c866887f4.
> 
> Fixes: 1e0c866887f4 ("mfd: Use device_get_match_data() in a bunch of drivers")
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> ---
>  drivers/mfd/twl4030-power.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Rob, does this work for you?

-- 
Lee Jones [李琼斯]
