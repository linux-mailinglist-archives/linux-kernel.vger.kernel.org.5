Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C38D7CA108
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjJPHxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJPHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:53:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB07E3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:53:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20845C433C8;
        Mon, 16 Oct 2023 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697442828;
        bh=KF7D0pIBDOxA7uck8YbnsFpvaMwPZcCiwhgXetehI8s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cW7oJxlw7jT0mjJ9A5c3LvEm5pJWddC0dtA6gD6wvMcf950TMmh2x0IqpVn5thbhh
         4ndvEmunybX+P9s6AbKWHkxvtvHWQy6RwUGJjl0zRYcUGJznbnGHXK/RuUy0yQ2BsG
         hAuMn4RAWCaLp/NQPjuicSZlUTP+QSvQko16GoLDLQF1HR8Bxje9hgnKerAUBU7Bd0
         x6NicFwJn9BLBJfofkqhNqOIRwdmwmOSz3p7nJL6VAlTfi7t17FvESqR4UfBBdjCVU
         eKZJCyCewWfxBIWjprt56hjKhTL9rLjOeK6sNFxNSAZYblI5NUH/q0olehi5uvdDUk
         x9x+1HUEA5TcQ==
Message-ID: <34cdc4d2-166d-b41d-bc20-55fc749f9ea4@kernel.org>
Date:   Mon, 16 Oct 2023 15:53:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up zones when not successfully
 unmounted
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231010193628.2629168-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231010193628.2629168-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/11 3:36, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We can't trust write pointers when the previous mount was not
> successfully unmounted.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
