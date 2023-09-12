Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558A879D532
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbjILPm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:42:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511CA10EA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 08:42:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996DCC433C8;
        Tue, 12 Sep 2023 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694533374;
        bh=x5skFNfGsM7GjFcIrdwY3QQ1EP2LKjWHy0pgga2Jc68=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EktgWKbYC+8UJsdJH/pQSLRhIf9lCQDtl4aoUhIn4l0c3EQCtiJk1J7TmWwq1V1AY
         3vc/4HvNM2K8QYRHj5UJdO4xgFs0URykfdkqRtNsL3PoEa+vI9S4ECive0W5g+NVYD
         IcTjl4qkXNTCU5bmyrlpvbJdYHFuRicdREeRwXvazEdAkzPNadpi/xY1SrDbcVy8Go
         Jdv44TTQmIepXjZjwmAtPNIePSLfV0nbauYusmro+/83gz3waFnok4R7TCPMC/f+PQ
         A5GChJrPYgbcYeax1HrMQYHyWMqA07nnzMht9nFcPq4MGaiDqcN1W2BG3dq0yp/O/V
         bmOhs6WPnjGFg==
Message-ID: <195d6e8f-c305-da4a-baa5-7997c236aac4@kernel.org>
Date:   Tue, 12 Sep 2023 09:42:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Content-Language: en-US
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230912084039.1501984-1-Ilia.Gavrilov@infotecs.ru>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912084039.1501984-1-Ilia.Gavrilov@infotecs.ru>
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
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
> Repost according to https://lore.kernel.org/all/fea6db56-3a01-b7c8-b800-a6c885e99feb@kernel.org/
>  net/ipv4/igmp.c | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


