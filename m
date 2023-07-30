Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375747686FB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjG3SFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjG3SFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5FDE6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 11:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78D6260C95
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 18:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B4C433C8;
        Sun, 30 Jul 2023 18:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690740350;
        bh=JcmP0jZQuU7m7iyGqTMMeCJYBU3IouKkKwVIcw4W+A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ/f0JlHkBmgyEZOF1pj6vH3VJfaiZemWh5agS/RAXQxPeh/HeH6k/Rw3M2DsLIVx
         mnX2neqey9P6zcEsaRjHNtIsVsV/l8Yo8j6iQcdCs+6rYCPnOnVQUQuy4pqCATXhEV
         0ER2Cob/lhE5tSTe5i+7f5oQrG85b0XaZ07MISzUKsAm8w8+DHgjoFCPCecr5ANeJ0
         u59hLccXyyRqJ8Dm+mPi4ZbNYlYLoreAyBUnPgQry06c5q6Dgq/vZp9+rq7iathX6W
         313krYnxdk41TNyni8hv1dmvIM3EheLTOS4847Tuc+O1UliEgC05lsNMqciBX8k0Ne
         O1IdMYqhWTvCQ==
Date:   Sun, 30 Jul 2023 20:05:46 +0200
From:   Simon Horman <horms@kernel.org>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] tcp: Remove unused function declarations
Message-ID: <ZMamembdZQC1+F80@kernel.org>
References: <20230729122644.10648-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729122644.10648-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 29, 2023 at 08:26:44PM +0800, Yue Haibing wrote:
> commit 8a59f9d1e3d4 ("sock: Introduce sk->sk_prot->psock_update_sk_prot()")
> left behind tcp_bpf_get_proto() declaration. And tcp_v4_tw_remember_stamp()
> function is remove in ccb7c410ddc0 ("timewait_sock: Create and use getpeer op.").
> Since commit 686989700cab ("tcp: simplify tcp_mark_skb_lost")
> tcp_skb_mark_lost_uncond_verify() declaration is not used anymore.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

