Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F8774585
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjHHSnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjHHSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:42:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C953BF3A25
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5820612AF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 16:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B2AC433CC;
        Tue,  8 Aug 2023 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691512512;
        bh=slRe+YcmSjVv8ZknucHmwHHcyukV15brRp38+hWMYPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oL3b/v7HvDx5OsvmMW/AdrdKlmDTNbBfQ+peRkwbgc5jgfHNYfoBSsgHXUMuJNcWM
         gIcweqPc1H7XCUZItGu7/ZOh5novUh3aPTekz6KsAwQtjJHD/Sn2fJLHRXcbSqhEkz
         DTtjtYba92WkVTEicSVgdjG1kp3Wlcbxckxw+54F+tPxHe9PuDqXfFcmmCgiqnQZQV
         nwiq5LkP57BSrfqHRIMJ2UemP/vZkyxiwFIyRjWQRT9ejE9hCNgX1zjNObLW6xwgAx
         CEYoHnQUGoToiYtU7S9SgnevS1DMaUtoa+BOqP71JgvNlq6yT295a8Cw1/oijFTym8
         tC8/JUoaPTPGg==
Date:   Tue, 8 Aug 2023 10:35:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: do not set the NUMA node of device if it has
 none
Message-ID: <ZNJuvTvD4jhMGDdp@kbusch-mbp>
References: <20230726131408.GA15909@lst.de>
 <mafs0cz0e8zc6.fsf_-_@amazon.de>
 <ZMFHEK95WGwtYbid@kbusch-mbp.dhcp.thefacebook.com>
 <mafs08rb28o4u.fsf_-_@amazon.de>
 <ZMGddjINDt10BSvf@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0tttn7vs3.fsf_-_@amazon.de>
 <ZMQYURrKPqIyTkG7@kbusch-mbp.dhcp.thefacebook.com>
 <mafs0350y7tg7.fsf@amazon.de>
 <ZM0XEUw0xKgzXvi+@kbusch-mbp>
 <mafs0y1il5y8q.fsf_-_@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0y1il5y8q.fsf_-_@amazon.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 05:51:01PM +0200, Pratyush Yadav wrote:
> BTW, do you think I should re-send the patch with updated reasoning,
> since Cristoph thinks we should do this regardless of the performance
> reasons [0]?

Thanks for the investigation and finding the cause!

Yeah, we should go with your original patch as-is, just with an updated
changelog. While that may work around your immediate issue, I hope your
xen patches from this analysis will be considered for upstream as well :)
