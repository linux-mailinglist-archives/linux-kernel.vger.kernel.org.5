Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9A80E628
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjLLIaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345816AbjLLI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:29:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8E31FDA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:29:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFA5C433C8;
        Tue, 12 Dec 2023 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702369776;
        bh=vHjfn2BQPRZ2rrdN6+fIB1WMP3nGWTkfEKZYxRvs6o4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=VPIgkCUSlJYWd6EVmfo6CLJ+RAW4I6rMQ63h0+7bn6w8odIKL6IGWMS1IPu45J4mP
         1m9xCm+QNxHv0FgqxP6yt7IT9BtwAeO4jTPvJTeuCDs4ayynDv7Ih0I8ao1NK4mafj
         zlIYlhTCNcYwbbSGPgMxxmvlaAw97EZoUuJm1VP9tGVR9jop623EVxNan9brDU7ELw
         73PxTLrjmeUuo+H+FJavHK+prWM2vWZM6HwQt8PTtwnCVkozOhM/BNOV42QSJ2AmhN
         cv4tLpaPx/61xDuxl16//iMww+UqGJuKsIbUISVQAS+9mIyiNoWm1SujwD5TrwV4qU
         SQonCo9AFgZ4g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Daniel Vacek <neelx@redhat.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231211130426.1500427-1-neelx@redhat.com>
References: <20231211130426.1500427-1-neelx@redhat.com>
Subject: Re: [PATCH 0/2] IB/ipoib fixes
Message-Id: <170236977177.265346.10129245400198931968.b4-ty@kernel.org>
Date:   Tue, 12 Dec 2023 10:29:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Dec 2023 14:04:23 +0100, Daniel Vacek wrote:
> The first patch (hopefully) fixes a real issue while the second is an
> unrelated cleanup. But it shares a context so sending as a series.
> 
> Daniel Vacek (2):
>   IB/ipoib: Fix mcast list locking
>   IB/ipoib: Clean up redundant netif_addr_lock
> 
> [...]

Applied, thanks!

[1/1] IB/ipoib: Fix mcast list locking
      https://git.kernel.org/rdma/rdma/c/4f973e211b3b1c

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>
