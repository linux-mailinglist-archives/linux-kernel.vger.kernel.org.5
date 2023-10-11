Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9047C5C58
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjJKSvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbjJKSvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:51:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5765C9E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:51:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4F7C433CB;
        Wed, 11 Oct 2023 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697050261;
        bh=8PENQpkW9ys3s72+iK3X9odKCSmYXkhRr1UXf42h6/w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=B/tDw4wS7Kl9JcDfS8FHqvZ7Wtc/DsvFwRrSjK1gZcSkoCjGA+cqtYwCV7VjYWT1p
         hkzTPvH+rqNZBFCP4WN20rCg5jgj+NVE9n59AVLOgm/XwNcHCGCQnv8t1eWkNdnFxM
         3hy4Xjb9cNX7XyJKxpE1icIVRbCHwcs2pkOKXqynNgS7ImdhUlhukRJ1niexxJl7md
         Ce3NbPi//VgbUnlBms0h2B2bqXZTQ1j3k7yjootp5oHO0h9PaEB00wjK1P7SdL+8Bm
         KBbqvc3jhsHcI3k15bB6Lv9qWIRfzzt08MHXY0fP6V2WciktmpthFF5pFTHlOzUFg3
         XFo6FQ9Rkstcg==
Message-ID: <64abbd6d-7ce7-c054-366a-8cac757852df@kernel.org>
Date:   Wed, 11 Oct 2023 12:51:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 2/7] ipv4: remove "proto" argument from
 udp_tunnel_dst_lookup()
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-3-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-3-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 10/9/23 2:20 AM, Beniamino Galvani wrote:
> The function is now UDP-specific, the protocol is always IPPROTO_UDP.
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c      | 4 ++--
>  include/net/udp_tunnel.h   | 2 +-
>  net/ipv4/udp_tunnel_core.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


