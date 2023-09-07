Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50ADD7979AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjIGRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjIGRSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:18:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089E61FFD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:18:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73CC43395;
        Thu,  7 Sep 2023 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694106681;
        bh=WV4Py0hrKsYJ5YuvXOJr89R6yNHUMJy3lSQ0F64mriM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SfhLXvred1rxlSf8SQWcbPjbGhptNWzXi/KGC42x9ZjEjFjYMoKZDD+npIJdmleQc
         j90ahKEPtTFIGbzbt+SOS76LPXv+lPA1cjIhQzHsSTov0bj14LntnG9H6xgVIvvF6y
         CUgWUPO/Lgdu1c6dUxrrWzwwyKLkIC2KfhTrmygqG4LaTqr242/KNfsNAiPWiI+5sw
         NXBbfo/J+ebojlsUkIOh8YiUAruuXrNnN7hO4l7vmwMzkx/9Jhqq0SkjrPcmdpVaGt
         ZG0MpKy9CsIoEG8UZZKGdHvW2V6i+30Bay6vBwvhxDRg92kxm15xZzkrprI+97NxxY
         4hLODE177TnUQ==
Date:   Thu, 7 Sep 2023 10:11:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     <piergiorgio.beruto@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>, <andrew@lunn.ch>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
        <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2] ethtool: plca: fix plca enable data type while
 parsing the value
Message-ID: <20230907101119.3e5a5dc0@kernel.org>
In-Reply-To: <20230908140346.40680-1-Parthiban.Veerasooran@microchip.com>
References: <20230908140346.40680-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sep 2023 19:33:46 +0530 Parthiban Veerasooran wrote:
> The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
> value from the attribute, nla_get_u32() is used in the plca_update_sint()
> function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
> with some garbage value instead of 0 or 1 and always enables plca even
> though plca is disabled through ethtool application. This bug has been
> fixed by parsing the values based on the attributes type in the policy.
> 
> Fixes: 8580e16c28f3 ("net/ethtool: add netlink interface for the PLCA RS")
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks!
