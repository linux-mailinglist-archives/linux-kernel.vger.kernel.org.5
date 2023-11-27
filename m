Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE857F9D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjK0KIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjK0KIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:08:13 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38D1C0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:08:19 -0800 (PST)
Received: from 8bytes.org (p4ffe1e67.dip0.t-ipconnect.de [79.254.30.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 3F8271A4B43;
        Mon, 27 Nov 2023 11:08:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1701079699;
        bh=a5Q90jhb7WwY91YW7qzuQ3VTxn7Y9EAZQUEWt8Pn0Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/fJPukFYTdSfh9qO7Dw1Plj8ENkBKECGtTOBehE1t4uejf+u9sIURyDIwA03XjEg
         for+4tYl//BXuZn+dK8EfH37sUYtRc7DhaBPho9tW8/UH2YQqj04lVjtnk8uVyV76X
         N5itxVEBiVD7Hday8WP/i6pTrmtNoTGfAiydVfIj9bpRltcpD9MrQTreGsgng8MsZT
         2L04dpW8ndx3C1QpmUMwSgaqXuYiGRyO2iwx1p0qn6J9OkzTweYge1YAiQekWD0Wpy
         xj/EBMM5+vecwzFyzezxIVXNdJQ7Mz2F3sJDe3yJ04eL7CygWbGR2+gSdakkM1fyAw
         y4d0MQdSVQfxQ==
Date:   Mon, 27 Nov 2023 11:08:18 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     mohd.syazwan.abdul.halim@intel.com,
        Kunwu Chan <chentao@kylinos.cn>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] [PULL REQUEST] iommu/vt-d: Fixes for v6.7-rc3
Message-ID: <ZWRqkkHgdj9W_xlT@8bytes.org>
References: <20231122032608.165144-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122032608.165144-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:26:01AM +0800, Lu Baolu wrote:
> Abdul Halim, Mohd Syazwan (1):
>   iommu/vt-d: Add MTL to quirk list to skip TE disabling
> 
> Kunwu Chan (1):
>   iommu/vt-d: Set variable intel_dirty_ops to static
> 
> Lu Baolu (5):
>   iommu/vt-d: Support enforce_cache_coherency only for empty domains
>   iommu/vt-d: Omit devTLB invalidation requests when TES=0
>   iommu/vt-d: Disable PCI ATS in legacy passthrough mode
>   iommu/vt-d: Make context clearing consistent with context mapping
>   iommu/vt-d: Fix incorrect cache invalidation for mm notification

Applied for v6.7, thanks.
