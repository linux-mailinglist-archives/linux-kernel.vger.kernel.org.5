Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548167D1350
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377826AbjJTP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJTP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:58:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD583D60
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:58:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0708AC433C7;
        Fri, 20 Oct 2023 15:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697817482;
        bh=95Ls7CeVdFQSjPfOngpnPXjenZMzg1jn2SvA01CRo0U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J5TYyZ8Br1Uf9km3+TnTsSMPgGz/XWRFk4NyqV9uEvxmhXzADnctACOmn5FOQDtU0
         7q6TUt2H3U8Z9HWvDNGSPiG8XRAtYZYQhpNZYN3xU7OKuhPRk4O2wuGIDMYpejDFxV
         ZrHR0/sZEyCmwzx5EWIX/HPIl1AdkVz1jennrb79yH4ZoT9aFS0oRYypvV3wG4ZjQx
         0RZEUnSSIk+JSga/I2kNS+z0zpPuNiMYLQEHMCg9/feC6iBvGMQi8i4aX5mrfF4CQV
         N5GJ9SubDKmtHAVw3jhHBK8e1SDRlJVGctDhL6jh0Vs3UzoPOVppGzAbH4lzPErtHX
         kUlkA/zpktc0A==
Message-ID: <ae9c237e-6a56-578c-f5fa-b93d07ab7c08@kernel.org>
Date:   Fri, 20 Oct 2023 09:58:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 5/5] vxlan: use generic function for tunnel IPv6
 route lookup
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231020115529.3344878-1-b.galvani@gmail.com>
 <20231020115529.3344878-6-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-6-b.galvani@gmail.com>
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
> The route lookup can be done now via generic function
> udp_tunnel6_dst_lookup() to replace the custom implementation in
> vxlan6_get_route().
> 
> This is similar to what already done for IPv4 in commit 6f19b2c136d9
> ("vxlan: use generic function for tunnel IPv4 route lookup").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 136 ++++++++-------------------------
>  1 file changed, 30 insertions(+), 106 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


