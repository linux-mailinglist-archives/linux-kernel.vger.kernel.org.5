Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0080BAB7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjLJMhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:37:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435BC102
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:37:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77346C433C7;
        Sun, 10 Dec 2023 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702211828;
        bh=pRBeoq0i5wdIAoj64UnUDaiei1SKdwmcYgCs6WKw67s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=siLUPEh+g1d5hTqWbpQ0jYVZKFMXNeYUvAuGg3f2A+aw5FOgAZC3Amtf2qDAs+0KG
         nFMQPcMPCTNO3VcNjFpN2jCrdOdoe0SQ3gM3Gtjwmv/6o/HSOLy4R0k0pb797cxNw1
         Hh/kEaGHPy3XBDS5TPGIZD6iYKnizqVf3dnpMS/8rs16B3QFN73H+adkpY1j7rcveu
         xDaWJwggp9s/o3SA93bwdwu9xSrAzUXgXVntANdVvjvwf5+HUyOU1Vh+PEh/Sa26p8
         QnC73fxI0JHIc47R4ifPdP8WX4jHnla/8z3gGINU6jGKYRjne656/ZGyAsgJcayZ/P
         053jZCyjbaPQQ==
Date:   Sun, 10 Dec 2023 12:37:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] iio: light: isl76682: remove unreachable code
Message-ID: <20231210123704.4be7087e@jic23-huawei>
In-Reply-To: <20231208021715.32450-1-jiapeng.chong@linux.alibaba.com>
References: <20231208021715.32450-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Dec 2023 10:17:15 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> The function isl76682_read_raw cannot execute return -EINVAL up to 145
> lines, delete the invalid code.
> 
> drivers/iio/light/isl76682.c:145 isl76682_read_raw() warn: ignoring unreachable code.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7698
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/light/isl76682.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> index 0a7c3b09c3c0..cf6ddee44ffc 100644
> --- a/drivers/iio/light/isl76682.c
> +++ b/drivers/iio/light/isl76682.c
> @@ -142,7 +142,6 @@ static int isl76682_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		return -EINVAL;
>  	case IIO_CHAN_INFO_SCALE:
>  		for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
>  			if (chip->range != isl76682_range_table[i].range)

