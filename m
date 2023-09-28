Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CA7B1EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjI1NiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjI1NiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:38:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00292;
        Thu, 28 Sep 2023 06:38:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7874BC433C7;
        Thu, 28 Sep 2023 13:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695908281;
        bh=tNJPrSt0EbpYHgUGMbTFOG600cX1nU2foR/sWCpczbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmPchohDyoQ6K0w5lf2CBErfA/MK9ZiuDsSClS02RQTKpm36prB0Afz4G9prWxgNa
         zgGeel0htRoZnDUpGT4kmqcI2+KZRs9cFvwT0ehSaIGNBeAW8Dc0bsBO3BQlkbatOT
         i4k/EEVwrJYA0nUP309m89dkrCztL/rL0tDyQhPfNkvWsANgU7Fh9lbCD8d/JiXsVW
         slyMxycwEMCZaz1BypRUfJMMjdsZT9zNTNky6UjK6O6cvdEhNEdjRkpkXAa30ZnQCt
         SRj1FE2QRYTSonX4Xp3UJTt6QdqRh4+cD3+XMupimFUtT8NVq38xwuDUBdeLE9m6KG
         IClVlEMWWIgFQ==
Date:   Thu, 28 Sep 2023 14:37:56 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chunyan Zhang <chunyan.zhang@unisoc.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] leds: sc27xx: Move mutex_init() to the end of probe
Message-ID: <20230928133756.GI9999@google.com>
References: <20230925032453.724518-1-chunyan.zhang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230925032453.724518-1-chunyan.zhang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, Chunyan Zhang wrote:

> Move the mutex_init() to avoid redundant mutex_destroy() calls after
> that for each time the probe fails.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
> V2:
> - Move the mutex_init() to the end of .probe() instead of adding
> mutex_destroy() according to Lee's comments.
> ---
>  drivers/leds/leds-sc27xx-bltc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Nice patch, but doesn't apply.

Please rebase (onto linux-next or for-leds-next) and resend.

-- 
Lee Jones [李琼斯]
