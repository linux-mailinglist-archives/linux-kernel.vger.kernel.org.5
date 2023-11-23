Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEDC7F5C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbjKWKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:15:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2959F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 02:15:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20063C433C7;
        Thu, 23 Nov 2023 10:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700734539;
        bh=gL4xFcxmYSSh7kOgDS87FN5NgH0x5Jtwcq7nF4+rREM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h1Zdc31yNztmTAbJjB1MoYlplWFujXy+xSZ4Fau875psGogC/LQdTAJx0lMBirJXd
         LX8IF4gocWJwnQJDcfOC4Txuyzk5v3KvC7u/AhnXJLG0ic59OFEJCxLpmpHTWAx+DB
         NHYfsu1ohIg/HsoRrpPMuaW0SsUaX6mBit2Ko7ozGvmZ/jwqv/FH2FJ4zhCiH7L5Ku
         RF7t+3pdP8exkNe2GPWkbFxmf2TpdpCh0XhkidqUqYCqr+RCzk9QceY4eCW+5KuPA7
         EQgVztpU/Fpe+oHlumhI5R0/HHLBzwLd9ltRQc9+E5LajGwDG+qqrde+gj6x9pt7jY
         acBV9lv+RN+ug==
Date:   Thu, 23 Nov 2023 10:15:34 +0000
From:   Simon Horman <horms@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Michal Simek <michal.simek@amd.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] net: can: Use device_get_match_data()
Message-ID: <20231123101534.GC46439@kernel.org>
References: <20231122180140.1432025-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122180140.1432025-1-robh@kernel.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:01:39AM -0700, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Error checking for matching and match data was not necessary as matching
> is always successful if we're already in probe and the match tables always
> have data pointers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>   - Drop calling "platform_get_device_id(pdev)->driver_data" in c_can
>     and flexcan as device_get_match_data() already did that. The logic
>     was also wrong and would have resulted in returning -ENODEV.
>   - Drop initializing devtype in xilinx_can

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>
