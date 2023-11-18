Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0B77F03B5
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 01:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjKRX7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 18:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKRX7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 18:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1AE6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 15:59:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6081CC433C8;
        Sat, 18 Nov 2023 23:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700351979;
        bh=A5eYIpo9nw6P9JOIqKyEJq1aT2EBOd0qD0hr9BR4N8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oBUdeo1klbXcTrHTYDEVainAaFMfwsd/6QKTALINg5d7lfMpvydF/V3VfK+nIC/95
         UiNMKmAY1IoTeL0g0I3IFBpvWBlrWFbCAyoB/0+3SEby7LoVnYQgL26moEI5oUrDzG
         2PTr9uIePPbTgSwJr4OZEN1bmURc6IBEpOYmfVLI9Y8U/cMYDjApQ7NngEtmkCMCrl
         L1J8ZU6a3Pihn6Fkj12mx/VsZW1a4YUM5v/OKJVUKn8KOGpSkDgfR5nu3Ngi2PkvFM
         k9umNY4Q9dL4zJ9vCiehrqCxTIJsI102jxGJxpoy9NzfBUkQXmhSWbNfdcpYUn/ejQ
         HGpzOsgXeRBDw==
Date:   Sat, 18 Nov 2023 15:59:37 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russ.weight@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 0/9] net: Add support for Power over Ethernet
 (PoE)
Message-ID: <20231118155937.4c297ddb@kernel.org>
In-Reply-To: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
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

On Thu, 16 Nov 2023 15:01:32 +0100 Kory Maincent wrote:
> This patch series aims at adding support for PoE (Power over Ethernet),
> based on the already existing support for PoDL (Power over Data Line)
> implementation. In addition, it adds support for one specific PoE
> controller, the Microchip PD692x0.
> 
> In detail:
> - Patch 1 to 6 prepare net to support PoE devices.
> - Patch 7 adds a new error code to firmware upload API.
> - Patch 8 and 9 add PD692x0 PoE PSE controller driver and its binding.

You haven't CCed Oleksij or am I blind?
