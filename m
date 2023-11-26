Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0BD7F95A0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjKZV56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZV54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:57:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20FED
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 13:58:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A2AC433C7;
        Sun, 26 Nov 2023 21:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701035883;
        bh=baUZoNh2JMvbytQ1QkvNeal4oXmaY+syquDQSd8t/Wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wq9/AmsXFK+XG2Jaz4dCyjC4QXtD4a+IPfwgO/4qJHq0zCWkr3QSBjJdQefhl/Cso
         hyRyQcHRux8UCjU42vFx38d7dWsHXu4pugYmlleTCGdkISx0b6iw/OykXS8l8gD4GN
         bKdW3nGZIRSuiu0fQ1RCqUk3T+NE/Z7qAalf16a3ziVaLbouuPE8c81s5lFL51mZdJ
         jLp8KA7SKvKbdrblVVQk76+iNl/HhKrSvLWtsSaBKn5XGhdoiZ1wg7vzXNDl8Zdba7
         bI4ocLvGYlKwrO1BAy7DR6KnKX7ZcAum1lpkGF2ZDQDR0ry2jKw5uxZVMTrYYNKhpr
         B3YeDMdNrqZOQ==
Date:   Sun, 26 Nov 2023 22:57:59 +0100
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
Subject: Re: [PATCH v4 02/24] i2c: designware: Fix reset call order in
 dw_i2c_plat_probe()
Message-ID: <20231126215759.6huodkf3xanvfupd@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-3-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:41:44PM +0200, Andy Shevchenko wrote:
> We should not mix managed calls with non-managed. This will break
> the calls order at the error path and ->remove() stages. Fix this
> by wrapping reset control to become managed one.
> 
> With that start checking the rerurn code from reset_control_deassert()
> as it may fail and calling assertion in that scenario is not always
> a good idea.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
