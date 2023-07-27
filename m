Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054B5765575
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjG0N7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbjG0N7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACABE4D;
        Thu, 27 Jul 2023 06:59:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB87761E92;
        Thu, 27 Jul 2023 13:59:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 699AAC433C8;
        Thu, 27 Jul 2023 13:59:05 +0000 (UTC)
Date:   Thu, 27 Jul 2023 14:59:02 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com,
        alikernel-developer@linux.alibaba.com, will@kernel.org
Subject: Re: [PATCH v3] ACPI/IORT: Remove erroneous id_count check in
 iort_node_get_rmr_info()
Message-ID: <ZMJ4JnlVlqkO3E0P@arm.com>
References: <1689593625-45213-1-git-send-email-guanghuifeng@linux.alibaba.com>
 <ZMJzj2oe0B2Qp8vp@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMJzj2oe0B2Qp8vp@lpieralisi>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 03:39:27PM +0200, Lorenzo Pieralisi wrote:
> On Mon, Jul 17, 2023 at 07:33:45PM +0800, Guanghui Feng wrote:
> > According to the ARM IORT specifications DEN 0049 issue E,
> > the "Number of IDs" field in the ID mapping format reports
> > the number of IDs in the mapping range minus one.
> > 
> > In iort_node_get_rmr_info(), we erroneously skip ID mappings
> > whose "Number of IDs" equal to 0, resulting in valid mapping
> > nodes with a single ID to map being skipped, which is wrong.
> > 
> > Fix iort_node_get_rmr_info() by removing the bogus id_count
> > check.
> > 
> > Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
> > Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> > ---
> >  drivers/acpi/arm64/iort.c | 3 ---
> >  1 file changed, 3 deletions(-)
> 
> Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> 
> Catalin/Will,
> 
> can you pick this up please ?

Would you like it merged in 6.5 or 6.6 is fine?

Thanks.

-- 
Catalin
