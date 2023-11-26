Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9BF7F95DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 23:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjKZWiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 17:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjKZWiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 17:38:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CE7E3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 14:38:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2169C433C7;
        Sun, 26 Nov 2023 22:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701038299;
        bh=ZzkvqZAA0BbxPb51CfXzZIVh5Y99x58F1kl3CaI11Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZehqyCw3CFvJKr92+RJKcX6cOp1Jol0QkdkQZOY8T358YlX96JP8C9wImjcaM6Yi
         kUdxPkPTYxKNz4AYzluU4udsMvQkcf3y7R+0C3zhT3eERPnahCHnGUOoqh/t0Bb7rR
         VVjKrmxCqa2JYJtBftwdRA5I9d0O6He8wCavRRJAeOy/azXMY+JOTAp/AfGkZVr2YY
         j5JLFLg4RyPG4PHQa39oWGn3E9RSx1XCm0VBMewSjSTmY46H2lahurpwcj/AzOIp3y
         kqVmZ6Ep0elFr8MgoSYyKr5KYWn4V1rCLFby/26QpRXmyWN7NCZEZ6IH8MHZbhpc84
         knq48crREG0KA==
Date:   Sun, 26 Nov 2023 23:38:15 +0100
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
Subject: Re: [PATCH v4 06/24] i2c: designware: Save pointer to semaphore
 callbacks instead of index
Message-ID: <20231126223815.vpqxfahxw7avrscr@zenone.zhora.eu>
References: <20231120144641.1660574-1-andriy.shevchenko@linux.intel.com>
 <20231120144641.1660574-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120144641.1660574-7-andriy.shevchenko@linux.intel.com>
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

On Mon, Nov 20, 2023 at 04:41:48PM +0200, Andy Shevchenko wrote:
> Instead of saving index and do an additional level of referencing,
> save just a pointer to the semaphore callbacks directly. It makes
> code cleaner.
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi
