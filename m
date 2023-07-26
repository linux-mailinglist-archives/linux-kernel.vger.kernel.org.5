Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F7763E24
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 20:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjGZSGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 14:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjGZSF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 14:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8312727;
        Wed, 26 Jul 2023 11:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C523B61C2F;
        Wed, 26 Jul 2023 18:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C603C433C7;
        Wed, 26 Jul 2023 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690394756;
        bh=AEPtmDO63l60QJhXsd4SYCRUNeIj+/oodVwfUeY8hjE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQ7uyeNfjzdSkK3fLIdbMd7Fers9YmFeTfAkvTOqDrtr4zv978agpsWYC+IRx4OIr
         fpD/P7lJm3jD+as8EMSrA8J1zsYlOErJerkW6jgX6SRQIvGLABQdTpUJ5j+30yiXh5
         E09qCqcta9cG92MCuoWUWh+Wl7g2osDEMN8gw9JIf8xz2il6D5hgP3ioQLJEdue1UD
         nmpHuGAEcg2mDkdzPkN6WCJ6yjb2zdvO9sGXF8In5iQIptg8XceRvMKK46Y2HVz7KM
         Zno6Aw/OQAQZaj6n7kwCLoAPgRPQD2jbOxrhXmoxH7gjC0h06aDXLV2IPMpR4vpD4j
         x1WqjrLttkNRg==
Received: (nullmailer pid 1730126 invoked by uid 1000);
        Wed, 26 Jul 2023 18:05:54 -0000
Date:   Wed, 26 Jul 2023 12:05:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v1 1/6] gpio: ge: Add missing header
Message-ID: <20230726180554.GA1725541-robh@kernel.org>
References: <20230724161320.63876-1-andriy.shevchenko@linux.intel.com>
 <20230724161320.63876-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724161320.63876-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:13:15PM +0300, Andy Shevchenko wrote:
> Add missing platform_device.h that used to be implied by of_device.h.
> 
> While at it, sort headers alphabetically for better maintenance.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: e91d0f05e66a ("gpio: Explicitly include correct DT includes")
> Closes: https://lore.kernel.org/r/65b4ac1a-1128-6e2a-92c0-9bbcca4b760a@infradead.org
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-ge.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Thanks for fixing.

Reviewed-by: Rob Herring <robh@kernel.org>
