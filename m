Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E067686C8
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjG3RgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG3RgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D4590
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C48FA60C95
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 17:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3787AC433C8;
        Sun, 30 Jul 2023 17:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690738569;
        bh=7/RMvvZZ9pn9dgxF0AMTjJduZ/wUal5j5NPsWKqFDZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdvis+HXEgJbCSEe9NF6o6koxYgwI4OT+oJeEKCLEyGK+ou1v9o1tr1o43xtaS0vI
         o1ot7Sx2ZLvI+0xz4DPXGvujmqZpaIgnDZlrVUmFKZqCxqoZ4t+DhDrm4ALbn+7h79
         oomoPGVllAGJKIv0c0QLuM3JWEfdU+nAvcE16Rhp/xT3af/VVVNuziH9voZTLAIdcy
         mnU0UjvMjArpaWUBtsuMLVaVH/3rgkvLE5yAAdb+1ekMnVjKoE66bgWH0s6k/zuWAJ
         FPVJ9Tq6PllPYIqugIU1yzQW+B8VOtfBK61sRRCmbiqLtsUT7aGNE8h4xHxEdxAWcP
         Mmx+CwPapQA+Q==
Date:   Sun, 30 Jul 2023 19:36:05 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-afs@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] rxrpc: Remove unused function declarations
Message-ID: <ZMafhd5Wvichtco2@kernel.org>
References: <20230729122327.12668-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122327.12668-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:23:27PM +0800, Yue Haibing wrote:
> commit 3cec055c5695 ("rxrpc: Don't hold a ref for connection workqueue")
> left behind these declarations.

It may bot be important, but the while above commit seems for
rxrpc_put_client_conn, perhaps for rxrpc_accept_incoming_calls it should
be:

248f219cb8bc ("rxrpc: Rewrite the data and ack handling code")

Patch looks otherwise fine by me.

Reviewed-by: Simon Horman <horms@kernel.org>
