Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914C37EB7A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 21:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjKNUQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 15:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbjKNUQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 15:16:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209F7124
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 12:16:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87C1C433C7;
        Tue, 14 Nov 2023 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699993011;
        bh=8mmL3I3erEwwdl8wOfZypEEHw8UywftF8yDJWg/57kM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M3p2RH03l1i6INY0wbihE+Jde/WWCLYu7RCYouEgYsVe8pqVXx5qbivbIlnThfgNs
         c2e8Le2gNfZXZHHcM2JhmuWOhMsCKu2nx6MGLyWjYkDOpNo3ABSu7YQeF4yGTyWTcu
         O45GOQUnyunGrJVcutsbdFGm9a063bhoEmVBQ9WMtC6thEf9WU4pSUL4BYy4Fmzav7
         2TFh0x/NyFFi3FWq2RWoyBsNRb/6iIQV5RMcf7D6605ezwP4kLfJxrLHhi+1eVIzH4
         nLaleIpKIcY9B6OZ93ZiCFqMowPzecuinhoS7JGc0UFmAMMtgClWD62JFFMdPdr7L0
         fPh9wHDHn1t9Q==
Message-ID: <0fe29f0c-5418-49a6-ab62-f210f8f7e765@kernel.org>
Date:   Tue, 14 Nov 2023 22:16:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] net: ethernet: am65-cpsw: Set default TX
 channels to maximum
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pekka Varis <p-varis@ti.com>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-3-rogerq@kernel.org>
 <20231114121343.o3nk3lddzy57mqgw@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231114121343.o3nk3lddzy57mqgw@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2023 14:13, Vladimir Oltean wrote:
> On Mon, Nov 13, 2023 at 01:07:07PM +0200, Roger Quadros wrote:
>> am65-cpsw supports 8 TX hardware queues. Set this as default.
> 
> Motivation? Drawbacks / reasons why this was not done from the beginning?

Motivation was to get the "kselftest -t net/forwarding:ethtool_mm.sh" test to work
without requiring additional manual step of increasing the TX channels.

Another issue is that all network interfaces (can be up to 4 on some devices) have to be
brought down if TX channel count needs to change.

I am not aware why this was not done from the beginning.

-- 
cheers,
-roger
