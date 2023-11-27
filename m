Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB69D7F9D4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjK0KSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjK0KSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:18:04 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 745DBC0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:18:11 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 69D241A6E90;
        Mon, 27 Nov 2023 11:18:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701080290;
        bh=+9XZsv2MkSw2ep1fiHnmE+Po3/h00hYAxkvBiSQeloM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=4YRrXkYsLXB/rmy11VvYsY25P6pCK+6+3Ojbhgxhg6yTy/v6TkybXY0SdX6BCgdRh
         8rrpUJL6ZIB/CqY1o+pRDED2bhBhRHRJBP23HHKhg558PYeKkEr10gqtbPn+zyqMZM
         mJL8Bukn/4rgHn/qhAxi57iov5BKqBJ1rLW5sqoaN0psxHPl/gSsdKWIHlAVuCQ0CD
         4bzApBKojQ0a58dFXER37NOtMLculE+C9Wkzg6DBnE0uJ4HWmIyz2UMJV0Aiii/vnL
         NFRcD9u1dqhy9SOYz/bIHesVLkxNwvqha3JgvF5GTwb5QTygTnAJM2SNRNLggNfsAz
         PZ+amGWVqZQaQ==
Date:   Mon, 27 Nov 2023 11:18:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Hector Martin <marcan@marcan.st>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: dart: Use readl instead of readl_relaxed for
 consistency
Message-ID: <ZWRs4Cq_X8Bm3btp@8bytes.org>
References: <20231126162009.17934-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126162009.17934-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 05:20:09PM +0100, Sven Peter wrote:
> While the readl_relaxed in apple_dart_suspend is correct the rest of the
> driver uses the non-relaxed variants everywhere and the single
> readl_relaxed is inconsistent and possibly confusing.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/iommu/apple-dart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

In the future, can you please use "iommu/apple-dart:" as the prefix for
you patch subject-lines? That fits better into the overall convention in
the iommu-tree, thanks.

Regards,

	Joerg
