Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDDE762977
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 05:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjGZDuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 23:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjGZDuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 23:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC32697;
        Tue, 25 Jul 2023 20:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32D7D611CA;
        Wed, 26 Jul 2023 03:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0ACC433C8;
        Wed, 26 Jul 2023 03:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690343416;
        bh=ftcsCLg9opVFQHziuDWuK9Vb2WB4UKQzFSr8yuWJn+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UapXkKZWjB5irsf6WvxvkX0NxSOH8OxcvH33it7pEs+5uhDVMfMhCagyW4tz4giqF
         8F1BRl81hoBX7zabo/6LlCebQQbH5ocfRU6vzgwd7JqVSgHttTKVU75niVKUa1yMjk
         LzBzzKZkKBl73T59+35uzhHskhG/+jYXuA19usbjQ9y9urUI7x7Fq9EYE+hFqIFvVA
         pZN7xONXstZnPTh6+8OkBw/Zouh+akDslk6ta3f/mZGEwB8SlGInrRIh7McBit9eqJ
         nMDoyyyOK0zAZU/de0k+LkAPAsr1cM6uf985ELbQUXmbpzqdCJHcvGShTYmOr2WzwN
         fpr38k32ZvgTA==
Date:   Tue, 25 Jul 2023 20:50:14 -0700
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
Subject: Re: [PATCH v11 07/10] net: ti: icssg-prueth: Add ICSSG Stats
Message-ID: <20230725205014.04e4bba3@kernel.org>
In-Reply-To: <20230724112934.2637802-8-danishanwar@ti.com>
References: <20230724112934.2637802-1-danishanwar@ti.com>
        <20230724112934.2637802-8-danishanwar@ti.com>
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

On Mon, 24 Jul 2023 16:59:31 +0530 MD Danish Anwar wrote:
> +	/* Rx */
> +	ICSSG_STATS(rx_packets, true),
> +	ICSSG_STATS(rx_broadcast_frames, false),
> +	ICSSG_STATS(rx_multicast_frames, false),

There is a standard stat for mcast.

> +	ICSSG_STATS(rx_crc_errors, true),
> +	ICSSG_STATS(rx_mii_error_frames, false),
> +	ICSSG_STATS(rx_odd_nibble_frames, false),
> +	ICSSG_STATS(rx_frame_max_size, false),
> +	ICSSG_STATS(rx_max_size_error_frames, false),
> +	ICSSG_STATS(rx_frame_min_size, false),
> +	ICSSG_STATS(rx_min_size_error_frames, false),
> +	ICSSG_STATS(rx_over_errors, true),
> +	ICSSG_STATS(rx_class0_hits, false),
> +	ICSSG_STATS(rx_class1_hits, false),
> +	ICSSG_STATS(rx_class2_hits, false),
> +	ICSSG_STATS(rx_class3_hits, false),
> +	ICSSG_STATS(rx_class4_hits, false),
> +	ICSSG_STATS(rx_class5_hits, false),
> +	ICSSG_STATS(rx_class6_hits, false),
> +	ICSSG_STATS(rx_class7_hits, false),
> +	ICSSG_STATS(rx_class8_hits, false),
> +	ICSSG_STATS(rx_class9_hits, false),
> +	ICSSG_STATS(rx_class10_hits, false),
> +	ICSSG_STATS(rx_class11_hits, false),
> +	ICSSG_STATS(rx_class12_hits, false),
> +	ICSSG_STATS(rx_class13_hits, false),
> +	ICSSG_STATS(rx_class14_hits, false),
> +	ICSSG_STATS(rx_class15_hits, false),
> +	ICSSG_STATS(rx_smd_frags, false),
> +	ICSSG_STATS(rx_bucket1_size, false),
> +	ICSSG_STATS(rx_bucket2_size, false),
> +	ICSSG_STATS(rx_bucket3_size, false),
> +	ICSSG_STATS(rx_bucket4_size, false),

Are the bucket sizes configurable? Can we set the bucket sizes
to standard RMON ones and use ethtool RMON stats?
