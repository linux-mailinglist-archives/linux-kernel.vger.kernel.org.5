Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8E27F1B3A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbjKTRnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjKTRmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:42:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028AD4D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:42:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193BAC433C7;
        Mon, 20 Nov 2023 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700502155;
        bh=VYsVMb7dTZSeGCIvqAHMIHrNGYFSYLbLSCW2ZnJAC2o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aRoVhwIZzsovcUht4xexdrGQy1sY4u1raQytjdoBKYogoR7+Ksy32OmeKkb1yg8iU
         d7DdalH5URIptKGMKEgvgXuvLVNCA0DqZ8XwO/IgeoA+/qwAg0TuOrsqUCqcKMH3Wf
         2dMVb//32yoT65XNhOJiE8NXaNxvu7OWMsRRxnEr4xtLkTtOIJrReh58SdYABbi0ZW
         KLVlpgSRUNhHIv8UmrqQuFaEpTEwKU4m0WlM0jNMx9m4NOwsBB9V2cyGMPg3zJ32EV
         NGSflUAmBj/tjylbccffM11JtPeJMT+pPN1fTZgisAmtAQm83ufWaO25XlpFxve5ZS
         SP8xddyEtuY1Q==
Date:   Mon, 20 Nov 2023 09:42:34 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] net: phy: correctly check soft_reset ret ONLY
 if defined for PHY
Message-ID: <20231120094234.1aae153e@kernel.org>
In-Reply-To: <20231120131540.9442-1-ansuelsmth@gmail.com>
References: <20231120131540.9442-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 14:15:40 +0100 Christian Marangi wrote:
> Luckly nothing was ever added before the soft_reset call so the ret
> check (in the case where a PHY didn't had soft_reset defined) although
> wrong, never caused problems as ret was init 0 at the start of
> phy_init_hw.

not currently a bug => no Fixes tag, please
-- 
pw-bot: cr
