Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A77F959B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjKZVsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:48:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D112DF0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:48:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9CCC433C8;
        Sun, 26 Nov 2023 21:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701035329;
        bh=V+EAygX9A+oQQ8gRy4ING6DnIoldEnMq2NRFb/sGfhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TU7Tc3BeNEogOEUoqEkSJcNpK/FpZ1eQFLbKgFA8XDoJ1sqbaQGryH1kkk+0WDGuJ
         ckbt4dqYCNPpiPulzFcRYNTbOOCaHrE26SAAUGFUw4b+DY7nLj+K5Cpvm/tmWCY7HH
         tDIdluTprCQDgnWudW9hizgmvMf9z8Ip6y0UKI5zUXIjkM1RLS9ti4dG4BXIJU/vQ+
         XZ5ro3+1vWMh9hH51q5C/EgVqz2dtlA7WGNBmwjjjndfsL8FWkuD47JXIQHyiN1Zc6
         bzdQlSzNIOXgqiahwem8D5ivwbzzHXdQ5KHb67RZ+fVb02DArq0YEEcdzTOhyNZz9W
         BZUuP++E9fdsw==
Date:   Sun, 26 Nov 2023 22:48:45 +0100
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
Subject: Re: [PATCH v4 01/24] i2c: designware: Fix PM calls order in
 dw_i2c_plat_probe()
Message-ID: <20231126214845.d5egybp4dk7mf2i6@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Nov 20, 2023 at 04:41:43PM +0200, Andy Shevchenko wrote:
> We should not mix managed calls with non-managed. This will break
> the calls order at the error path and ->remove() stages. Fix this
> by wrapping PM ops to become managed one.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
