Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91D07B5B52
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbjJBT1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbjJBT1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:27:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0B9B4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 12:26:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DB5C433C8;
        Mon,  2 Oct 2023 19:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696274817;
        bh=nRW3Rb+hh8App8mzBJQvJUN6fwaqhgkEIqttHuRs99w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T6E5SrPq7TT5aKK7dGkXijR1QESDpWQzlkG3pRseXw/fw6CUbAySPl31VFLyXqjr4
         KMAnPPZJUb7XwvoHXzA91mmC7HCMVWKFUQo+JFPH3UMFJjn4U0SabVd+O+pde9Y3JR
         +7s0nhn3BxKn+20LPlAtOMc3b5MVkemmXEx4aIt75W0eSjuS759St+hQg348LoD1lQ
         uVbGf7TqcGX0532AXGuxcNosJWpi/sAUnQZt9vcOenkL5pPZLmK3op+j2WhhX+07s/
         I7fs2s+Lfep2A5l32Yqz9Lz+QJ0bKcMeJzP8Qzm9IwiLCFm/xoCvh6YxiEFEli2nOD
         RyC9FfoPp3vYQ==
Date:   Mon, 2 Oct 2023 12:26:55 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: lan743x: also select PHYLIB
Message-ID: <20231002122655.530c9d82@kernel.org>
In-Reply-To: <20230927042523.7707-1-rdunlap@infradead.org>
References: <20230927042523.7707-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2023 21:25:23 -0700 Randy Dunlap wrote:
> Since FIXED_PHY depends on PHYLIB, PHYLIB needs to be set to avoid
> a kconfig warning:
> 
> WARNING: unmet direct dependencies detected for FIXED_PHY
>   Depends on [n]: NETDEVICES [=y] && PHYLIB [=n]
>   Selected by [y]:
>   - LAN743X [=y] && NETDEVICES [=y] && ETHERNET [=y] && NET_VENDOR_MICROCHIP [=y] && PCI [=y] && PTP_1588_CLOCK_OPTIONAL [=y]

Hi Randy!

Could you resend CCing netdev@ ? 
It's necessary for the patch to get into our patchwork instance.
