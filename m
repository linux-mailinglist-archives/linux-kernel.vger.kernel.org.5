Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D27758F85
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGSHth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjGSHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AF6E47;
        Wed, 19 Jul 2023 00:49:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0F2D612FD;
        Wed, 19 Jul 2023 07:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F0C433C7;
        Wed, 19 Jul 2023 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689752974;
        bh=1zOWfoVfKouN8tvks/W7q/hVbzBVs4kCKqkHfZw/oUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fv6ZXHMq0/cagd0E39Guglbanq3MndEWkr9RE5Xomw77dFQZZhhiRB5Mzg9WYyUAq
         uo38hUAK2n9X5uE3RW99bmdUbNjaWiu+BM+rxfcRBfj2Rfz6HEEeKrZRKjiutv/xIU
         3S9Qro7Ka1lb/ZG6kf7QgT6+yvqCwDt05NrCN4vF474YvRIL9qGt6BPzyG3MQ7EJqG
         yhEiPxtOxgNxi0d1L8JEv1TmfdLJivb/fyS75ygPPyPzS11dAuRa3A+mjJPV74ryys
         lXTU1y2jAEr6Rk0IA0rcHLzYXWcLwaxhiV8Twpvk9SlPseg14v7QMA9TnzGTn5JuzY
         zD0KgPdMvvs1A==
Date:   Wed, 19 Jul 2023 15:49:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: add TQMa93xxLA SOM
Message-ID: <20230719074920.GM151430@dragon>
References: <20230718085722.1198862-1-alexander.stein@ew.tq-group.com>
 <20230718085722.1198862-2-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718085722.1198862-2-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 10:57:20AM +0200, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> TQMa93xxLA is a SOM variant in the TQ-Systems GmbH TQMa93xx series using
> NXP i.MX93 CPU on an LGA type board.
> MBa93xxCA is a starterkit base board for TQMa93xxLA on an adapter board.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
