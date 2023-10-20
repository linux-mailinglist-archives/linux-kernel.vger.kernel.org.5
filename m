Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92047D1347
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377736AbjJTP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377676AbjJTP4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:56:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0032BF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:56:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B51C433C7;
        Fri, 20 Oct 2023 15:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697817405;
        bh=R6WXWf2U9PhFFtx/uOATxce8vfrGvQFpSyZOtJdAxr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DQIPUoz9meDLqmycvoJTtR/MPQql0wfDQMYwdhxDEIVbMW5nooQJq7Us7Q2QyKtKW
         KGZNRc5kIzK/o3HI3q+fCs5yt9mU/xD5P8xvR1/3ahXr5vxg0zgo1qsPusAEusnlAr
         nq5MGRYaENATQdetc27rzl1WSuati/CWsuFUG03eeFIQ1fHrmc0He0jT36K4uDvaHC
         UEFGloKW/psOFx6rxAz12I6oI4jQfwhSMKnGe2X9RoMgNfvY+EhACunzqjY4/wznOc
         2TGDv0zfJFw5G8NR1dx+vCUE/RYNKRG3WPynbcgQzFRntz74e6UshhRzdvuxzEat74
         g8lO04fxzYtnw==
Message-ID: <e4291747-cb1f-ce81-cc86-83bb6790e1af@kernel.org>
Date:   Fri, 20 Oct 2023 09:56:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/5] geneve: use generic function for tunnel IPv6
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
 <20231020115529.3344878-5-b.galvani@gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <20231020115529.3344878-5-b.galvani@gmail.com>
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
> geneve_get_v6_dst().
> 
> This is similar to what already done for IPv4 in commit daa2ba7ed1d1
> ("geneve: use generic function for tunnel IPv4 route lookup").
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/geneve.c | 96 ++++++++++++++------------------------------
>  1 file changed, 31 insertions(+), 65 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


