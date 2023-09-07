Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9133797CC2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 21:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbjIGTbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 15:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245495AbjIGRrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3061FD3;
        Thu,  7 Sep 2023 10:47:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2A4C433CA;
        Thu,  7 Sep 2023 16:28:27 +0000 (UTC)
Date:   Thu, 7 Sep 2023 17:28:25 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio-mmio: fix memory leak of vm_dev
Message-ID: <ZPn6KZpdPdG2LQqL@arm.com>
References: <20230907141716.88863-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907141716.88863-1-mheyne@amazon.de>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:17:16PM +0000, Maximilian Heyne wrote:
> With the recent removal of vm_dev from devres its memory is only freed
> via the callback virtio_mmio_release_dev. However, this only takes
> effect after device_add is called by register_virtio_device. Until then
> it's an unmanaged resource and must be explicitly freed on error exit.
> 
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

-- 
Catalin
