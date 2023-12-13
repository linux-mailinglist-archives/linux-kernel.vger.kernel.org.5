Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BCA810CD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjLMIxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 03:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjLMIxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 03:53:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE8B7;
        Wed, 13 Dec 2023 00:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5X2SvqPtWo7gdK+k/g7tSjg+ZxJIl7QEcfpBU4ieBtM=; b=2ke4ezuCb59ti/+WxgLBeNXl2P
        LveYl5CDnfVWE1Q/vO5SBOt8KtB5XZ01MZS9Zrx+liAyCk/X1L2UmSLzlUsW4QzEDjxRUiHstzV79
        O1edyIh/fCuAZQS+qdL/0yUSROjsVffBTciCD0Qt9oDosBxsprTQdP6tBA7TTceFFd9N2n69SQEyB
        2jBx5Z+wBenMvvEtqpFC8ttaxdkDzAAQ2+rOFEneEePJYr6T6t//cxCKbdFPQdu06lqQeJc+uvzi6
        QqWptSQh7e3eLUgU3gs7sJoXiNZ9+yETXms48+8EZS8NsrLSMhMzqKFI3TcLgHfB9QdapTKViqtZL
        pO57hZ0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDKzt-00E5d1-10;
        Wed, 13 Dec 2023 08:53:41 +0000
Date:   Wed, 13 Dec 2023 00:53:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] btrfs: untagle if else maze in btrfs_map_block
Message-ID: <ZXlxFdqVZEfWSQe8@infradead.org>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-10-b2d954d9a55b@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-btrfs_map_block-cleanup-v1-10-b2d954d9a55b@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Might be worth mentioning that you're using a switch statement :)

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
