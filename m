Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641B27F95C4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjKZWXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZWXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:23:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D80ED
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:23:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4FC3C433C7;
        Sun, 26 Nov 2023 22:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701037429;
        bh=pfTsofaa4QprR278/y3czVdAOGvgumfdtsYbR8l/K4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NKP9/xaDc0JuMidlR6fhMtSVuPfGpU7ZVDTrtrBkQBAyte6w9mgVeoaltT+HEJzMH
         lo0zBYUHiZGtcbWdm570JDHkx31KgxRNQtChwSV5WFnuqqcZgP+Pyi/tzc7C2ezZzo
         DdWdW9Bj7Mrii+O+UX3svEpa0soPDrSVN4UzZIy07iLAhNrVHJIZG6sQxFgauy5CCx
         anyd3GIaMpSmAIKmkxcup4+uehDaPZEU+oHjq4azAP5G8n8P1p5QdZy4n/ONi3UHQp
         3Fmfm2DxKl71okkrw74vCRbVfwzHJ0M2R6GvpuafDBdWC5S3Gp/t4LAGcr+ZGqOKKC
         Yw96ezWa+GfjQ==
Date:   Sun, 26 Nov 2023 23:23:44 +0100
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
Subject: Re: [PATCH v4 04/24] i2c: designware: Fix lock probe call order in
 dw_i2c_plat_probe()
Message-ID: <20231126222344.xaci244buhwbn2v7@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-5-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:41:46PM +0200, Andy Shevchenko wrote:
> We should not mix managed calls with non-managed. This will break
> the calls order at the error path and ->remove() stages. Fix this
> by wrapping lock probe to become managed one.
> 
> Fixes: 78d5e9e299e3 ("i2c: designware: Add AMD PSP I2C bus support")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
