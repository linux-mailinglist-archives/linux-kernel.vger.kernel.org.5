Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400957C88D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjJMPip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJMPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:38:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00C2B7;
        Fri, 13 Oct 2023 08:38:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C564C433C8;
        Fri, 13 Oct 2023 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697211522;
        bh=lVnd1G0BacgAj5hg/niS/IrsOZDEG8FKK2/F3/5ctjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzoAOWaRK2AJhRD1gIPgUsyoKp18HiPtgGvYc8ueGj5iyieVvth8Z2imW0lv6Lde2
         nXBvADKYObTTkCnn+tVNA2XzyUzJfX+/WyEohwtUB9sSi9BPJZlWIWALflkblVPQFr
         vYmfPbs54+336BbPs7m0e1fcy6C/Susc+Rl4xVVGSbK1JmJgtsjmPuJ5+sP5KI8dfG
         6WSECSRW4hHHmKxZNUZIGmzERbMB7Jo0JFvzEub6vWnICQ2VK4nD+fvJaUsxlHXfPI
         85X4P5YvnqEYCOvCbTpCjabaGttaM6d7OrE2q427NWUS38c6CrU4HEF6+NUKpuBxZp
         EPRL8GFxi1Fbw==
Date:   Fri, 13 Oct 2023 17:38:38 +0200
From:   Simon Horman <horms@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] appletalk: remove special handling code for ipddp
Message-ID: <20231013153838.GN29570@kernel.org>
References: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:34:43AM +0200, Lukas Bulwahn wrote:
> After commit 1dab47139e61 ("appletalk: remove ipddp driver") removes the
> config IPDDP, there is some minor code clean-up possible in the appletalk
> network layer.
> 
> Remove some code in appletalk layer after the ipddp driver is gone.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks,

CONFIG_IPDDP is gone so this code doesn't do anything.

Reviewed-by: Simon Horman <horms@kernel.org>

As a further follow-up should we consider dropping CONFIG_IPDDP*
from various defconfigs it appears in?
