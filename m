Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90E7F38FD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbjKUWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjKUWK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:10:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D92113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 14:10:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFB2C433C8;
        Tue, 21 Nov 2023 22:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700604655;
        bh=J/W5EGd0OsyI7D9gEbE2ntrabvODRH0rgEAh9iseBdg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JJI997RnOpQ30CdBHbSydQSyotpSkcfllhLASAeoy4UJEBx4sdEJGP/yTCi0r4ku7
         cdA3ABDw82oW9shYafjxTk4goQCu+GlX8+LVzOTE+7xQGf18B1nzbs/ItBEBLApqfF
         4V0GRKiMg7qHCEY3HGRMQbQufUB7KQf36Lre+DhBrSUdkvc33QhF9DyK9e6n/U5kk0
         TiRjt8LYq3ZuqtaoU4Lpx4lyi/VGt9ySlLs80/JJzph4xud3NT8zKdsXc3WfR/Y6K4
         s/thaocQwmyaDQgtrp7FXl/6jIOebcc80GpBaWuXJjakLJ48uwJRRIN1Crv3TOQI8j
         mTHSgWoEsayog==
Date:   Tue, 21 Nov 2023 14:10:53 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Saeed Mahameed <saeedm@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH V3 5/5] misc: mlx5ctl: Add umem reg/unreg ioctl
Message-ID: <20231121141053.6133e069@kernel.org>
In-Reply-To: <ZV0bRpnhu/zWieTT@x130>
References: <20231121070619.9836-1-saeed@kernel.org>
        <20231121070619.9836-6-saeed@kernel.org>
        <20231121124456.7a6388c6@kernel.org>
        <ZV0bRpnhu/zWieTT@x130>
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

On Tue, 21 Nov 2023 13:04:06 -0800 Saeed Mahameed wrote:
> On 21 Nov 12:44, Jakub Kicinski wrote:
>> On Mon, 20 Nov 2023 23:06:19 -0800 Saeed Mahameed wrote:  
>>> high frequency diagnostic counters  
>>
>> So is it a debug driver or not a debug driver?
> 
> High frequency _diagnostic_ counters are a very useful tool for
> debugging a high performance chip. So yes this is for diagnostics/debug.

You keep saying debugging but if it's expected to run on all servers in
the fleet _monitoring_ performance, then it's a very different thing.
To me it certainly moves this driver from "debug thing loaded when
things fail" to the "always loaded in production" category.
