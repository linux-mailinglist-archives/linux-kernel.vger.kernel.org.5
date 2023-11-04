Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17627E0FD5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjKDOK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 10:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjKDOK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 10:10:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E447B19D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 07:10:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784BBC433C7;
        Sat,  4 Nov 2023 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699107054;
        bh=QcrpWMqDIyHMzeyBl7hc5a/1oRjJDGQtzMIi4g/TNE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7kNPVoMpHSsV2EIUVa/D6X6kO71kPVD20JIvUPtwnhcyjmCFUDR6cMwA9aUG3JhD
         2P5vMzwHudkFqBLeLEHe5MEyEJrvtxhTkGXpydnfB/2duGsVVETisorc7uAM99STci
         dQh3J5+uBZ5X9g7HJYmTw/j+A0Xe1I3cdivR6ulpJdHxu2RVWfEketvtg9A+88MVyz
         5XSvvmlq4g/9ZJk6ykaA0vAEXlt358HldwwoauvZQu59F2bNbsxskQk7cZFd7W5ZiH
         NgfINZxF9k6gjQrVXMO+Wo6zsEmkPd70o6m3jPqfBTRMx3DfegTrPMm4us8eEFa1zZ
         D4pynNKAlWf1w==
Date:   Sat, 4 Nov 2023 10:10:31 -0400
From:   Simon Horman <horms@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: dsa: tag_rtl4_a: Bump min packet size
Message-ID: <20231104141031.GF891380@kernel.org>
References: <20231031-fix-rtl8366rb-v3-1-04dfc4e7d90e@linaro.org>
 <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdYiZHXMK1jmG2Ht5kU3bfi_Cor6jvKKRLKOX0KWX3AW9Q@mail.gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 09:18:47PM +0100, Linus Walleij wrote:
> On Tue, Oct 31, 2023 at 11:45 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > It was reported that the "LuCI" web UI was not working properly
> > with a device using the RTL8366RB switch. Disabling the egress
> > port tagging code made the switch work again, but this is not
> > a good solution as we want to be able to direct traffic to a
> > certain port.
> 
> Luiz is not seeing this on his ethernet controller so:
> 
> pw-bot: cr
> 
> (I've seen Vladmir do this, I don't know what it means, but seems
> to be how to hold back patches.)

Hi Linus,

In this case it may not have activated the automation, but
I do see that the patch is now marked as "Changes Requested"
in patchwork, so all is well.

  https://patchwork.kernel.org/project/netdevbpf/list/?series=798030&state=%2A

FWIIW, pw-bot is (slightly) documented here:

  https://docs.kernel.org/process/maintainer-netdev.html#updating-patch-status


