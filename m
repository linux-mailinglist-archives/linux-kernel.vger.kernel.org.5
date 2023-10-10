Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3284E7BF36B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442359AbjJJG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442330AbjJJG5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:57:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4291D99;
        Mon,  9 Oct 2023 23:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N9lyzBuGVFsluWswLnugelQJSaPXpLcK/NSvWYovKbM=; b=aXzxtZMjpR1hc2S/g4dNCWmaUG
        hgXjDjz9IVZkWN75AZBV7PDW470NonaVTsLok/Qzg8k5yjO+dyKtGIKt32FBfskvAgYUqkYoWM2IJ
        08o8uKXx5ulsVmYu+7gBdGUT/dvsfDVFHKd/Tm9HIxYXinr/CXtflaR7tvvRgBoV5oWM0H2w1Z83p
        OgS9f0pri7x0Eq7GNcVXis5cM3selvpgRnQjsqNYvC1+u0CUBTlplx4rbetzvVc9hi2kCHr3/3uBq
        RPQ3zOe8vENF2h+c6F+PWwE6aPoTFuLinigJeDtT9FqYsUZNAiRklOte/ghEVJft20HzwC2x1DiIn
        zE7RR65Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qq6gJ-00CeK8-2r;
        Tue, 10 Oct 2023 06:57:27 +0000
Date:   Mon, 9 Oct 2023 23:57:27 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     cheng.lin130@zte.com.cn
Cc:     david@fromorbit.com, djwong@kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiang.yong5@zte.com.cn,
        wang.liang82@zte.com.cn, liu.dong3@zte.com.cn
Subject: Re: [PATCH v6] xfs: introduce protection for drop nlink
Message-ID: <ZST117zXotVPXGEQ@infradead.org>
References: <202310101009011817522@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310101009011817522@zte.com.cn>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 10:09:01AM +0800, cheng.lin130@zte.com.cn wrote:
> From: Cheng Lin <cheng.lin130@zte.com.cn>
> 
> When abnormal drop_nlink are detected on the inode,
> return error, to avoid corruption propagation.

I know this has been through a few cycles, but wouldn't it be useful
to have at least a little description here how that case could happen?

