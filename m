Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44357D132A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377809AbjJTPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377790AbjJTPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:52:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B364D4C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:52:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166EC433C9;
        Fri, 20 Oct 2023 15:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697817160;
        bh=RQbAD0w6npd/FFPPPsOmLmBAxljIFEFg4+88J7KQD74=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZK2wqGMgpq9AYh5ih48qeGf7JCJQjX9jJa15JKgcrmGobaokWzX0MrfKAVmiKkR3u
         nF9/YKkWfFx7iMxW3aArxMcWC1pFlJv3t/zkdxEd8PIRpjHpPmWeyBAr3nCbBYiBKN
         Dj2jt8R9N09k3pyEti6mKoCS2hvenl09N83fIbmlZJAvFfiAoMhVKLuavcYdBHq4GR
         bZMNxYHH+gT72u315aOAaJlF/3ahjGYmrFXPs7QXy018M73GwgiMPZU8xH/6PqY9lo
         RgOrTxaNUrsYijldQF6lA7DYKsJLSwy5hUC4NBnlCtmICUSKzGimXAXx7ulTn9Daw8
         WFcUjVEtD+U+w==
Message-ID: <a702a703-badd-cfa7-6963-54830a0570ea@kernel.org>
Date:   Fri, 20 Oct 2023 09:52:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/5] ipv6: remove "proto" argument from
 udp_tunnel6_dst_lookup()
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-3-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-3-b.galvani@gmail.com>
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
> The function is now UDP-specific, the protocol is always IPPROTO_UDP.
> 
> This is similar to what already done for IPv4 in commit 78f3655adcb5
> ("ipv4: remove "proto" argument from udp_tunnel_dst_lookup()").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c     | 5 ++---
>  include/net/udp_tunnel.h  | 2 +-
>  net/ipv6/ip6_udp_tunnel.c | 4 +---
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


