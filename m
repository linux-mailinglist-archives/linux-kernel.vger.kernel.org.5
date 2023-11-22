Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336397F3F51
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKVHxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbjKVHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:53:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27929D;
        Tue, 21 Nov 2023 23:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J+bePWMprDbaGsnpRV9f2P2ovME7LDOe2qhgN0MMut8=; b=sO/L2q4OqAtZKvjVdg9fs0cQ+4
        9UGXKrFzl23cuOIY/lrbPdm8CXVzgeG5spD5qeMYMOwMfgsIIDzLSjy6x5T2rfI59pv3duwvH9YX1
        4pVFrQDr94qRX8uVU0RoE/GnpB6oC/4pi+d3I+WkexzTywPUPMzSfQ+n2hCmD3ZTwLX6QCYR5q1SF
        +gYo03A0NYe5hgUgq3ecCMVJggOSzg98WzZb53qCIDM9/+PcRi45e24yn/i0qv3bu74H/nZygXx+8
        3Lxa8eQx2ZpVwvcV77rienMmpWSHIxB9JGagtw6Z93JmrmFXvkMqkM//vvNWM87dQhX/ckUKt54Ur
        Z2QhLx8g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5i2v-000y8k-38;
        Wed, 22 Nov 2023 07:53:17 +0000
Date:   Tue, 21 Nov 2023 23:53:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] block: introduce new field bd_flags in
 block_device
Message-ID: <ZV2zbTPTZ0qC2F1U@infradead.org>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-3-yukuai1@huaweicloud.com>
 <ZV2tuLCH2cPXxQ30@infradead.org>
 <ZV2xlDgkLpPeUhHN@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZV2xlDgkLpPeUhHN@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 03:45:24PM +0800, Ming Lei wrote:
> All the existed 'bool' flags are not atomic RW, so I think it isn't
> necessary to define 'bd_flags' as 'unsigned long' for replacing them.

So because the old code wasn't correct we'll never bother?  The new
flag and the new placement certainly make this more critical as well.

