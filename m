Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49F7C5C57
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjJKSvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbjJKSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:50:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49EAFD
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 11:50:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06861C433C7;
        Wed, 11 Oct 2023 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697050252;
        bh=UTCJ1j77RuDBtnV4MCOBXYUf1NV64XfcqaKiT9tsfcU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HasVr1m3rievP5O80exQ54SWlnPhjun+rzRSvHrDiMkaICdi7S6gPDI33ZOm8ZObq
         +YIjdryv8NI+Ln7u/mqhE5qfBCxPVBa/pM2L45QLXJOVvKrgYAM/TNGTYiiEft3HEs
         36EyynFja0KI0mlE2QDuTah4D4fbiI8Wn5EScgXWX3PaAZmLcsZVhgxAtRYNMJTy/z
         HGNREPozNv4+iWiqE9QegMUm/tGIbKRPMWOyufdQoxv4UdRonWf/rwkjP7SiHDFfEY
         ka4vNHQ7Y94zqZgkGU1MQVdMUZtbeofMDHkJn3HU8WRFE7gnPrfJmV2Ibj5MyrxnqG
         FyEYO7yATGepQ==
Message-ID: <e175ed90-ac45-bae0-b04c-9603c8ac795d@kernel.org>
Date:   Wed, 11 Oct 2023 12:50:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/7] ipv4: rename and move
 ip_route_output_tunnel()
Content-Language: en-US
To:     Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-2-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-2-b.galvani@gmail.com>
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
> At the moment ip_route_output_tunnel() is used only by bareudp.
> Ideally, other UDP tunnel implementations should use it, but to do so
> the function needs to accept new parameters that are specific for UDP
> tunnels, such as the ports.
> 
> Prepare for these changes by renaming the function to
> udp_tunnel_dst_lookup() and move it to file
> net/ipv4/udp_tunnel_core.c.
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c      |  8 +++----
>  include/net/route.h        |  6 -----
>  include/net/udp_tunnel.h   |  6 +++++
>  net/ipv4/route.c           | 48 --------------------------------------
>  net/ipv4/udp_tunnel_core.c | 48 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+), 58 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


