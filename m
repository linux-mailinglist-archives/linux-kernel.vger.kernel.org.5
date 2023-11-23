Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2537F563E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 03:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjKWCCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 21:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbjKWCCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 21:02:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F74197
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 18:02:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E3AC433C7;
        Thu, 23 Nov 2023 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700704952;
        bh=OImsWoDCM9k5QBfPOzcccsAYXqLYofeIqJCqGz2sIGE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RSdHxVQvZHc4YAk80/G787C8uTOh+tyzjg6xqROwCxE3i+mRw8ehnqzDDxNdnn4Gy
         ph4G3kfjvYrS88x8KWNR62cshDgCgqj419zuvEVZGLyFmA6r+MCcQV7F6J4xfbhPLc
         zJcrMRZ+/ACjIDmQZpcnD8K2/40rssktQmySi6x9wviOyeTzwD/lDY2eG++W+CWeHX
         YUW2YTzGRUtG0qP7xZVso1PEJuIUDlxMu9vO+QxDFvT+hBu1vxKuAAjWDIzjVRictS
         Y0aARZOFGKv5BsjZYWoiJ2W0xTXUS1aSrFnnduLyO1mN65pF5fOb/0/FCy7JFY/9oR
         yOjOfZHcM/p9Q==
Date:   Wed, 22 Nov 2023 19:02:29 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-nvme@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Message-ID: <ZV6ytebPTC11Patu@kbusch-mbp.dhcp.thefacebook.com>
References: <20231122224719.4042108-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:47:16PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are still a couple of link failures that I tried to address
> with a previous patch. I've split up the missing bits into smaller
> patches and tried to explain the bugs in more detail.
> 
> With these applied, randconfig builds work again. Please either
> merge them or treat them as bug reports and find a different fix,
> I won't do another version.

Jens is taking these directly, but for the record: looks good to me and
thanks for the fixes.

Acked-by: Keith Busch <kbusch@kernel.org>
