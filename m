Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE1879D534
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjILPng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:43:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A510DE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:43:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E95C433C8;
        Tue, 12 Sep 2023 15:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694533410;
        bh=hj0RC1WXc1DnjIlLTA7SyBZ02s+JLUdYH29vAGditPo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VwYFCPHWIBC0kH4kkwXXOjfI9Ei6Nduu4v1Nu+IiNRiGR5oheUxCJ2zDnNTvF+CvB
         uD1A6knRj8t7yiSzhVLcFAZalTcuDUnqI6usAswJl6MFhlJWeFl3RKF+BQcaLvCSFf
         sOEFCVKXXuFFgfQ64I53CRmeqLyxbNRnjI5+u16xJxWw+jw9OIuv43njJJQugfAsQV
         cLQLE8YiYvtZkMzLpyw3wuFB2Y7revjkr4OL7hZ65n+SeaB5d+k17Hmx/Dnq2GSAjf
         /K+3IsB8qNaahy8cVHwVoLitM3HmdErv+PO9AvaJ/NTo+Y7dszYlEaWDkpHy3X5yy5
         v+fnix8iqTSWA==
Message-ID: <4c8ce973-15fb-1e25-7ec2-049336ed7f2b@kernel.org>
Date:   Tue, 12 Sep 2023 09:43:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv6: mcast: Remove redundant comparison in
 igmp6_mcf_get_next()
Content-Language: en-US
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230912084100.1502379-1-Ilia.Gavrilov@infotecs.ru>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912084100.1502379-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/23 2:42 AM, Gavrilov Ilia wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
> Repost according to https://lore.kernel.org/all/cdc2183a-c79a-b4bd-2726-bd3a2d6d5440@kernel.org/
>  net/ipv6/mcast.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


