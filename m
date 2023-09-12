Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B431B79D5DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbjILQLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbjILQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:11:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2353E10E7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 09:11:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84930C433C7;
        Tue, 12 Sep 2023 16:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535073;
        bh=SjWTgNYQykSl5vqwrk7e1u9J/HugCNEPohbX17PekV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/t6axSqrjJvcM/XxM4caXNi9Togbc/FQxSEboDlZ8tz2UJPV/oXsxZNuJRn7c7KB
         5BWFl//ZDgLOmIpokerKhmEhs4xdfIo8cuurG4bY1bX+sfbFqK9FEHuBS9lgqNcJIE
         uiNHXuxIwvLRUI4BL1yZmvbfzEhuoUOCsf+Cvd0jlZ5WfpJVqG3S7bJnummRscNSZQ
         ZoRoh3tiT7o7ot4fDTEgFAn8rl7xSBCh92xJ4MyiS+HiJd3O+Wl6bcYVxyVg61cMN5
         R0OVOpiy9x4danWKk5sel0AnfQAxIj/flEmFoEiNYb+aKZwWwy5DVrHGQCdhCdGz3I
         71/8jnKufMlsQ==
Date:   Tue, 12 Sep 2023 09:11:11 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Pratyush Yadav <ptyadav@amazon.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: do not set the NUMA node of device if it
 has none
Message-ID: <ZQCNn99783AbnQ5O@kbusch-mbp.dhcp.thefacebook.com>
References: <20230912155249.113009-1-ptyadav@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912155249.113009-1-ptyadav@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 05:52:49PM +0200, Pratyush Yadav wrote:
> If a device has no NUMA node information associated with it, the driver
> puts the device in node first_memory_node (say node 0). Not having a
> NUMA node and being associated with node 0 are completely different
> things and it makes little sense to mix the two.

Applied for nvme-6.6. This overall makes sense, though I hope the patch
isn't just to work around xen's incompatibility with managed irqs :)
