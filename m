Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D07512A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGLVbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLVbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:31:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70EC1991
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C6BB6190E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482DFC433C7;
        Wed, 12 Jul 2023 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689197491;
        bh=g6kPIL4LCoQUHNeV9eXv2hIHMy3/xuBWDvTBuzux4CM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o4eUW5bDY674WXsroq750qA8F1XkxUKFeic+6TOj3uilDBhQ4UdOhzbcdbTw4m7Gu
         +v8rnRA5GeGqtBYXRIyOpeYzd0FNa3AgQZkUw08UGXuLZ5qSJwMqcfSY+mQ0oO/2XP
         mDyuGeftL2nuBAgyGPQ+eYMR5sgnfthGXSQIZa3f4T21BYb7c0FWhIxmX2rB4pn1AW
         Hb7BAlLzj7qSWgiHX6Bc94i2O/mvg4K7K/62TgCG3D8bgrGVxYaRC08gxEurkeoJXo
         5wx1QzXsOCErRMPiGKyE/HXlVxch3pgx6ENPPcRzHRJDjoa1Ntob21DUlRSFQu/GWs
         /A4aY6CM93jEw==
Date:   Wed, 12 Jul 2023 14:31:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sunil Kovvuri <sunil.kovvuri@gmail.com>
Cc:     Suman Ghosh <sumang@marvell.com>, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH] octeontx2-pf: Install TC filter rules in
 hardware based on priority
Message-ID: <20230712143130.483d1449@kernel.org>
In-Reply-To: <CA+sq2CdCw1OT_ChVg_95ALzPX-1LWyiHUSsThor7O3J7Jm3Nmw@mail.gmail.com>
References: <20230712184011.2409691-1-sumang@marvell.com>
        <CA+sq2CdCw1OT_ChVg_95ALzPX-1LWyiHUSsThor7O3J7Jm3Nmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 00:46:49 +0530 Sunil Kovvuri wrote:
> net-next is not yet open, please check the status here
> http://vger.kernel.org/~davem/net-next.html

A bit of a change in process, sorry for the confusion.
The vger server was giving us grief so we switched the link to:

https://patchwork.hopto.org/net-next.html

We updated the docs but it will probably take a couple more weeks
before they are rendered online.
