Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CA7776454
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbjHIPr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjHIPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:47:26 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81E992111
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:47:25 -0700 (PDT)
Received: from 8bytes.org (pd9fe94eb.dip0.t-ipconnect.de [217.254.148.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 49BEF280529;
        Wed,  9 Aug 2023 17:47:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1691596044;
        bh=c9q4+LkZCmEYpPrz6nZsIMTUQoOd94ugzaMoSeUMz0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdwpCAptFG7WCj5g6w/Aze4sgRW/QgYuuOgC5A9jOijeWFmRTeXeaGH8aYy6Tmhos
         hYzYMuaAyseXYSZEGnBWm5iSHJwzSU6Cd5RHdRr+xIh0ZhgMWHckoGjhPx9pnp3iwR
         KYGc4QrOmGoBM1WJNDHmH7lUslVuLVK0HzOIkAWbIOHaFJJhPXGQm2QKOEfSdm9/h8
         1Jw8Gm6S/Gd1wkySXLNi8TYWWWrvh40G2Ge+GQcCFLERXFGD5FvgPoVhC+pGMBK6l/
         mYp/ldrmnKIhQOfijSMKBb/hPSHEAVKWIH/OJMtlfe+LqKW3U85/sYsAJhwOJS5YPf
         VWa6fogpE3kLQ==
Date:   Wed, 9 Aug 2023 17:47:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Yanfei Xu <yanfei.xu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] [PULL REQUEST] Intel IOMMU updates for Linux v6.6
Message-ID: <ZNO1Cp2rmsxYhsPG@8bytes.org>
References: <20230809124806.45516-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809124806.45516-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:47:53PM +0800, Lu Baolu wrote:
> This includes patches queued for v6.6. They aim to:
> 
>  - Enable idxd device DMA with pasid through iommu dma ops.
>  - Lift RESV_DIRECT check from VT-d driver to core.
>  - Miscellaneous cleanups and fixes.
> 
> All patches are based on top of the next branch and vt-d patches can
> apply to v6.5-rc5 as well.

Pulled, thanks Baolu. There was a minor conflict with the differences
between next and v6.5-rc5, but I resolved that.


Joerg

