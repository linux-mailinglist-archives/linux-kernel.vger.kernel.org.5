Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42227CE145
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjJRPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjJRPef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:34:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC372120
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:34:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45075C433C8;
        Wed, 18 Oct 2023 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697643273;
        bh=cYGyeDp5SnBhcx1NT6F6sYg9klshD6wB8OfpbqvYTUU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FCcjdnigmwW0UUMzK0/4ubBjxcwykgfdDQ8WXtCtoqRvTwX4lXh0RNMjnIj/cJFEc
         yBUdqscgPg2gHCnabbCcoJmicjUkip12We9fDr1N8P3szNGXaBVDc7E0OgWOJfeniB
         xpSFQtsjAnk5I9D2pm6dfa7doFVlC5JiFaaJQCDMhi51pXqvSos6FanXTBHpM0HZHF
         UFq2pZqmhdnpDkdApqMQLgHMW3X958vu5IQSOVAe1l0894t9+etJwJWi4prH/b+1oM
         kvLreUfWTc91yHmIYmF0ivBSKlyMEpYD3m60LFpseMSbeJwP6amEEmVKQtNMlqLJrv
         f8iLMVDqsBneQ==
Message-ID: <675c05a6-4568-4b53-ba1b-83b4b8c70382@kernel.org>
Date:   Thu, 19 Oct 2023 00:34:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] mfd: Use i2c_get_match_data()
To:     Rob Herring <robh@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20231017203603.2700864-1-robh@kernel.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
In-Reply-To: <20231017203603.2700864-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 10. 18. 05:36, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() and
> i2c driver_data to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/mfd/lochnagar-i2c.c |  9 ++-------
>  drivers/mfd/lp87565.c       |  9 +++------
>  drivers/mfd/max14577.c      | 14 +++-----------
>  drivers/mfd/rn5t618.c       | 11 ++---------
>  drivers/mfd/wm831x-i2c.c    | 16 ++++------------
>  drivers/mfd/wm8994-core.c   | 11 +----------
>  6 files changed, 15 insertions(+), 55 deletions(-)
> 

For max14577 mfd,

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

