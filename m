Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D387FE425
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjK2XVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjK2XVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:21:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD074A2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:21:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BF4C433C8;
        Wed, 29 Nov 2023 23:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701300114;
        bh=PYzACPIE8RGmG59RoMprAZsHsC9zrxefFFB60TgKGw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuopeACdSOBtuBSGbIR09hxnq9lEFOpTcZdYCuxqEPy5zDCboXLAFeu/ocXorLQeL
         j3GVVVlMt+ZvTN9Qsirsl4kPruWPlrNz2Pmsdui03WxNdWOexMlHRWix1OXHWQkU7o
         n46Jf36iKKZlddoHaSl1U6bi5Gl+P8jectgorjm0EcUzepkIHKmQbRUbjdoHv0/eeR
         DCRo/m3mFkN+M4jzWOJfn1EC/dwf9HsN2DLDbGqxsiky6p3qIfWsiK0zDyBM3ebHoe
         dpCA9p+pssFm6PR6ctb3iSM2ov87vUNXTIPPYaXxGgENxSKSCROVSq9L5nbIlawJOC
         Mjontb8Zsj49g==
Date:   Thu, 30 Nov 2023 00:21:51 +0100
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
Subject: Re: [PATCH v4 19/24] i2c: designware: Uninline i2c_dw_probe()
Message-ID: <20231129232151.ueum2axn74qzuzes@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-20-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-20-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:42:01PM +0200, Andy Shevchenko wrote:
> Since i2c_dw_probe() is going to be extended, uninline it to reduce
> the noise in the common header.

where is it going to be extended? It's not in thie series. I'm
fine with the patch anyway as it cleans up the header file.

Thanks,
Andi
