Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D762B7F95A8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKZWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:03:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B3FB6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:03:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AC0C433C7;
        Sun, 26 Nov 2023 22:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701036233;
        bh=NWeGXlDvgFIUVAoJZ5GS+vF5TfO+nSCEgC3q8n3U/Sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JctvLzOuE4eA2KY39vrsNyADJ16JfNAwzxTUxg0n7U0Yiw8sF6DSPC17UTdQa8P/7
         HV5ay1rjwkKTX7geADtkdj+W8nV5xmSNVRkMOH9HGWewh00rKVEvNFMPh0Az+sFsaP
         5jGr+weEztJLM9O1xKMFzw5ZcCpEnnFMy7RK72lmVTScP7yfdzo2dz81DoLd/YMJHi
         QRU9Iqgw5HL01vKHYiz4t5/TOg2dY6Qh/8eXfW+NOvQhdqajYsOJT9d3ARnuBd5XwJ
         Sk8qgasu5QToPJRRHxMnl6SQm2xaui+cmEQRkknwOd11c5lLfJHQked5VeizjM8wkk
         0uN6guONsXQoA==
Date:   Sun, 26 Nov 2023 23:03:49 +0100
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
Subject: Re: [PATCH v4 03/24] i2c: designware: Let PCI core to take care
 about interrupt vectors
Message-ID: <20231126220349.on6qy66ixzu2jmus@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-4-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:41:45PM +0200, Andy Shevchenko wrote:
> PCI core, after pcim_enable_device(), takes care about the allocated
> IRQ vectors, no need to do it explicitly and break the cleaning up
> order.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
