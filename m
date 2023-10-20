Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44407D1328
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377785AbjJTPwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377720AbjJTPwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:52:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3453FBF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:52:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54445C433C8;
        Fri, 20 Oct 2023 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697817151;
        bh=+yx/tmH5yW0oAyCTNoFQHXoiPxtokmxvoGUKDiF+kVk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j4fgf+oDTeZ+MeiOPVacRXf7dueEt4T7tPLUNkxVCnVG9iTFv2jsaSmX9dTzrlG9N
         EfNyn4CxV0rjVSSXyxkXI+xtJQrdhPkLQHQSgpLrR09pcI6967+Z41ANSucjB+iEwY
         P6XkDgaOjN9uMAquFfa/TxgAIxHJ02YoAZ6LM5VwkfW8Pv9CaVnYMCLbU3Zmpx1ris
         vt3W6EItqGtXOIM+CfEPGWkL0bVLjSRsOwF8+9utOxyWAS7lLMOcOU9sHgdQMA5wb4
         l7mCDCn8qXPWNSZbOyvdP9SFa87LGNpaX6BxiRU4opgO4uB5AGNxJlbMrfuDpkEMkU
         v/1nwkEPERksg==
Message-ID: <dc9f1c9d-d619-d2cc-5211-a3ffe4e8e3bf@kernel.org>
Date:   Fri, 20 Oct 2023 09:52:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/5] ipv6: rename and move
 ip6_dst_lookup_tunnel()
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-2-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-2-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/23 5:55 AM, Beniamino Galvani wrote:
> At the moment ip6_dst_lookup_tunnel() is used only by bareudp.
> Ideally, other UDP tunnel implementations should use it, but to do so
> the function needs to accept new parameters that are specific for UDP
> tunnels, such as the ports.
> 
> Prepare for these changes by renaming the function to
> udp_tunnel6_dst_lookup() and move it to file
> net/ipv6/ip6_udp_tunnel.c.
> 
> This is similar to what already done for IPv4 in commit bf3fcbf7e7a0
> ("ipv4: rename and move ip_route_output_tunnel()").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c     | 10 +++---
>  include/net/ipv6.h        |  6 ----
>  include/net/udp_tunnel.h  |  7 ++++
>  net/ipv6/ip6_output.c     | 68 --------------------------------------
>  net/ipv6/ip6_udp_tunnel.c | 69 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 81 insertions(+), 79 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


