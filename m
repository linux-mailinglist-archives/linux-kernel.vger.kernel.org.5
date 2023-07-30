Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444C1768660
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 18:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjG3QRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 12:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG3QRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 12:17:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF56310D7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 09:17:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44BB060C94
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 16:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2BEC433C7;
        Sun, 30 Jul 2023 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690733839;
        bh=LtRI832gyIYu/qcJ+wjkvVdT8FFjcWSt8xXU7OGyoS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CooAZJGiMMBFMdqGtCR9L0N5bQXg3qva6MJqDpnhvuZnGj1fGgFmyGd2su8O3TA6C
         80ATMmVJRhSf6xcCqXjHDSTPRKOufCK6qiV84mr3btY3sXp12ltv9MfzeEoabmYFH0
         Ez5FXFxdFTD3Dbp81wAutggX6a2xMrjSMOzxqhGx1uKbUwNRmPy74XhckU8uzz3Qd+
         C7lq+tbYyJRAwkmiuUXhnN9p3VJTsZCu4gNLkEZ70gzzu3b4K+V6nWfq/J3xQE5e7z
         o49cSuNiIFMSKiPpZm+T41unmC+nkpiwodgtHpTAcUlxoP8OYQs32qFG12FUXBUj7T
         WJSSs2E5oGDXQ==
Date:   Sun, 30 Jul 2023 18:17:15 +0200
From:   Simon Horman <horms@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: netsec: Ignore 'phy-mode' on SynQuacer in DT mode
Message-ID: <ZMaNC+tTV+tX44qz@kernel.org>
References: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728-synquacer-net-v2-1-aea4d4f32b26@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 11:51:03PM +0100, Mark Brown wrote:

...

> diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
> index 2d7347b71c41..cdb05db3d6ac 100644
> --- a/drivers/net/ethernet/socionext/netsec.c
> +++ b/drivers/net/ethernet/socionext/netsec.c
> @@ -1851,6 +1851,17 @@ static int netsec_of_probe(struct platform_device *pdev,
>  		return err;
>  	}
>  
> +	/*
> +	 * SynQuacer is physically configured with TX and RX delays
> +	 * but the standard firwmare claimed otherwise for a long

nit: firwmare -> firmware

...
