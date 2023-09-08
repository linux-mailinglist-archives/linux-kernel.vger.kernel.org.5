Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC21798A1F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 17:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244733AbjIHPlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 11:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239384AbjIHPlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 11:41:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781EC1BC1;
        Fri,  8 Sep 2023 08:41:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95ADDC433CB;
        Fri,  8 Sep 2023 15:41:12 +0000 (UTC)
Date:   Fri, 8 Sep 2023 16:41:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-mmio: fix memory leak of vm_dev
Message-ID: <ZPtAljIVLvOiliDN@arm.com>
References: <20230907141716.88863-1-mheyne@amazon.de>
 <ZPn6KZpdPdG2LQqL@arm.com>
 <20230908113840.GA19696@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908113840.GA19696@dev-dsk-mheyne-1b-c1362c4d.eu-west-1.amazon.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 11:38:40AM +0000, Maximilian Heyne wrote:
> On Thu, Sep 07, 2023 at 05:28:25PM +0100, Catalin Marinas wrote:
> > On Thu, Sep 07, 2023 at 02:17:16PM +0000, Maximilian Heyne wrote:
> > > With the recent removal of vm_dev from devres its memory is only freed
> > > via the callback virtio_mmio_release_dev. However, this only takes
> > > effect after device_add is called by register_virtio_device. Until then
> > > it's an unmanaged resource and must be explicitly freed on error exit.
> > >
> > > This bug was discovered and resolved using Coverity Static Analysis
> > > Security Testing (SAST) by Synopsys, Inc.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> > > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Who would apply this patch?

The virtio maintainers (Michael, Jason).

> Something seems to have choked my patch so it didn't
> reach lore.kernel.org (message couldn't be delivered due to timeout). Should I
> try to send it again?

You can send a v3 with the added acks. It's strange that it didn't make
it to lore. I got it as I was cc'ed but checking the archives, it's not
there.

-- 
Catalin
