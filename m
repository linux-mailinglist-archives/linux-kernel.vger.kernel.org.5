Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEF07A50F9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjIRR2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIRR2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:28:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B797101;
        Mon, 18 Sep 2023 10:28:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D89C433C7;
        Mon, 18 Sep 2023 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695058085;
        bh=eyW6d2pjl5JU+Oz+ApgrqSfhAmLNl4BcssGT7YSphc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbB1z5mkBAWHsfRvsZjvsxYzLRw0rJ3dlSLzqGZnFL0OiHGKU3XT0Ar4D1kXG4XD7
         xFhrMDdEpKDXiHg6+K0ZGUdAZluvjGTxJrf3FHpDD+OP0fVavsq2DCxh7xTcgDg7Gg
         u1DgU/jXP8TnhGe7nQ4bpE9xGBEeqxo2+lypfx/Dhk3H3XXNSwQ3ZrQHscqeavAkXl
         nPz4N6yoaiRK/1ob/iNTjYnWCI7Th9DJdC/D+JtX3EbwSSrstUNkWdFe3gVdWSwv+z
         nSoOBPoE+Cc3NjcINchZDJ9IUvvPlk9+ByFtJVC0QGLh1UyAlAZiRmAVMrvMqezNZJ
         XnVkn/8Z+6KEA==
Date:   Mon, 18 Sep 2023 13:28:02 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, anarsoul@gmail.com,
        tiny.windzz@gmail.com, rafael@kernel.org, wens@csie.org,
        samuel@sholland.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH AUTOSEL 6.5 6/6] thermal/drivers/sun8i: Free calibration
 nvmem after reading it
Message-ID: <ZQiHrd0BH9f8OAQa@sashalap>
References: <20230909011254.3581788-1-sashal@kernel.org>
 <20230909011254.3581788-6-sashal@kernel.org>
 <ZPxm/xjvsI24JWkB@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZPxm/xjvsI24JWkB@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 01:37:19PM +0100, Mark Brown wrote:
>On Fri, Sep 08, 2023 at 09:12:54PM -0400, Sasha Levin wrote:
>> From: Mark Brown <broonie@kernel.org>
>>
>> [ Upstream commit c51592a95f360aabf2b8a5691c550e1749dc41eb ]
>>
>> The sun8i thermal driver reads calibration data via the nvmem API at
>> startup, updating the device configuration and not referencing the data
>> again.  Rather than explicitly freeing the nvmem data the driver relies
>> on devm_ to release it, even though the data is never referenced again.
>> The allocation is still tracked so it's not leaked but this is notable
>> when looking at the code and is a little wasteful so let's instead
>> explicitly free the nvmem after we're done with it.
>
>This is a minor cleanup which as with so much of what's come in today's
>backports seems very questionable for stable.

I'll drop this, thanks!

-- 
Thanks,
Sasha
