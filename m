Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5867F95CD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjKZW1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKZW1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:27:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8647ED
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:27:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB71CC433C8;
        Sun, 26 Nov 2023 22:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701037672;
        bh=vWbSX32odQjp/d/idEt8zwF9Zy5oAJlF1CorJpW4uw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yzyx3XhUv8CVZShbuwX4R+uFDMebpWtbA94ZcWfBD4yEFTN4phpSkK0sX7Oyfqv4O
         c1WmBAHWeBjsWIWe3gOYZxGLvMrIhJ0X9qxistHqe+dBZVDbO3XJXNq1czLuMUAxze
         La6V3A32DpHmN22yUwK/wqWw3aTmTcE6QRNIvfV3VDHCH4voAmtwiLj/cgu3/siw9k
         W6+7C1YLZpRgMH5KKYDbWjkbGU5ogmQrNMtgcQCNPin6XOqolFu8+01qH4dqZ/EXUf
         e/6cRR/3D5hjpgIf1povezK4I1moToQFTpK2XThGejp1NvIWv4AqIoeJp+g5ebxy10
         mYHwYoIQH4QMA==
Date:   Sun, 26 Nov 2023 23:27:49 +0100
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
Subject: Re: [PATCH v4 05/24] i2c: designware: Replace a while-loop by
 for-loop
Message-ID: <20231126222749.bruquaub2rrtbr7d@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-6-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-6-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:41:47PM +0200, Andy Shevchenko wrote:
> Replace a while-loop by for-loop in i2c_dw_probe_lock_support() to
> save a few lines of code.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
