Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69F67FE413
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbjK2XK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbjK2XKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:10:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0054E10DF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:10:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2C4C433C8;
        Wed, 29 Nov 2023 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701299458;
        bh=3DUY32anruoKX0hBLF8yOSnm4ahLIBTQIQv35W8gZa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jy1w8B14QuOTO1AMypKe8etpTizWLEb/pRWR0wuvxyEKA7/lHqA6ICHAyPgRHHVlF
         OAPA2Cmnm2NALY3D48utcazWNPDfa8Me6OJpRd5XtdFs+/zvQEqxXh15xkWdB5GGZL
         R1j+yBP5qYfP4yyxpZsZHsVYBQVuluqU1e0TuHgpaF3/vbEnPJ1tiDNGG1lb+xdE03
         BfjOc7pfIH1hOOAgTuYMr8GHc2fFZQGjHZj746MlRYqWXnJHKkVsvlRg3LBDDRuDGE
         3Nzl7kBuA6iYTqGmtDAdm2faHa0FvtmtA1l0PgPoL8qU8y+Tcf4bFCjrwEdo1WXPot
         0H62JLZEM7Piw==
Date:   Thu, 30 Nov 2023 00:10:53 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH v4 21/24] i2c: designware: Use pci_get_drvdata()
Message-ID: <20231129231053.mlas3vd7wxhkd6wy@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-22-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-22-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 20, 2023 at 04:42:03PM +0200, Andy Shevchenko wrote:
> Use the wrapper function for getting the driver data using pci_dev
> instead of using dev_get_drvdata() with &pdev->dev, so we can directly
> pass a struct pci_dev. This is a purely cosmetic change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
