Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79575A524
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 06:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjGTEft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 00:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGTEfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 00:35:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649CF1FD5;
        Wed, 19 Jul 2023 21:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C5A61711;
        Thu, 20 Jul 2023 04:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA84C433C7;
        Thu, 20 Jul 2023 04:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689827745;
        bh=d9AKXeTNlZzlG6Phg9AfyhYmnmjPYT0tp1CULN8PnW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tdUV0RbGmzIwaSAjaKh1P8L51/7NeYy5KHuzTpZOA8DKcu95ZMO98l2AIdF8ssFLk
         +hVY7sxUBU/CPgVDRlj7bhcDWQYwSu/XTdzZsWv/KpW+U6zSZeTsp/odnEpgJdJy3m
         Flr51URsP0sXic6+U+vwqDFj66/q5UwK5ABjyJJw+97lIBIT7cDvifPW8b0mqXUltF
         c6+YbvPcUBNLp2j1AlRGARLJwSBrUC/2pL4IMfUbkkhqCnAsdNT41rT0DKRb5DHCYM
         4OEypzDEWCnyRuqkLiy550qt/hqle4rqyVOq8AM9GP3IL+LLyMw0u81HBR3bQCkcaF
         5oQssBwS6uE2A==
Date:   Wed, 19 Jul 2023 21:35:43 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10 2/2] net: ti: icssg-prueth: Add ICSSG ethernet
 driver
Message-ID: <20230719213543.0380e13e@kernel.org>
In-Reply-To: <20230719082755.3399424-3-danishanwar@ti.com>
References: <20230719082755.3399424-1-danishanwar@ti.com>
        <20230719082755.3399424-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

The patch is too big to review.

Please break it apart separating into individual features, targeting
around 10 patches in the series. That will make it easier for reviewers
to take a look at the features in which they have expertise.

See two things which jumped out at me immediately below:

On Wed, 19 Jul 2023 13:57:55 +0530 MD Danish Anwar wrote:
> +	ICSSG_STATS(rx_crc_error_frames),

> +	ICSSG_STATS(rx_max_size_error_frames),
> +	ICSSG_STATS(rx_frame_min_size),
> +	ICSSG_STATS(rx_min_size_error_frames),
> +	ICSSG_STATS(rx_overrun_frames),

> +	ICSSG_STATS(rx_64B_frames),
> +	ICSSG_STATS(rx_bucket1_frames),
> +	ICSSG_STATS(rx_bucket2_frames),
> +	ICSSG_STATS(rx_bucket3_frames),
> +	ICSSG_STATS(rx_bucket4_frames),
> +	ICSSG_STATS(rx_bucket5_frames),
> +	ICSSG_STATS(rx_total_bytes),
> +	ICSSG_STATS(rx_tx_total_bytes),
> +	/* Tx */
> +	ICSSG_STATS(tx_good_frames),
> +	ICSSG_STATS(tx_broadcast_frames),
> +	ICSSG_STATS(tx_multicast_frames),
> +	ICSSG_STATS(tx_odd_nibble_frames),
> +	ICSSG_STATS(tx_underflow_errors),
> +	ICSSG_STATS(tx_frame_max_size),
> +	ICSSG_STATS(tx_max_size_error_frames),
> +	ICSSG_STATS(tx_frame_min_size),
> +	ICSSG_STATS(tx_min_size_error_frames),
> +	ICSSG_STATS(tx_bucket1_size),
> +	ICSSG_STATS(tx_bucket2_size),
> +	ICSSG_STATS(tx_bucket3_size),
> +	ICSSG_STATS(tx_bucket4_size),
> +	ICSSG_STATS(tx_64B_frames),
> +	ICSSG_STATS(tx_bucket1_frames),
> +	ICSSG_STATS(tx_bucket2_frames),
> +	ICSSG_STATS(tx_bucket3_frames),
> +	ICSSG_STATS(tx_bucket4_frames),
> +	ICSSG_STATS(tx_bucket5_frames),
> +	ICSSG_STATS(tx_total_bytes),

Please use standard stats:
https://docs.kernel.org/next/networking/statistics.html

And do not duplicate those stats in the ethool -S output.

> +static const char emac_ethtool_priv_flags[][ETH_GSTRING_LEN] = {
> +	"iet-frame-preemption",
> +	"iet-mac-verify",
> +};

What are these? We have a proper ethtool API for frame preemption.
-- 
pw-bot: cr
