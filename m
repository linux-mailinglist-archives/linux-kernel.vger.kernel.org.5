Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F77D8A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 23:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjJZVOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjJZVOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 17:14:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A954A10E;
        Thu, 26 Oct 2023 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=STBT4USV80X7xjDyPQBrhAt8zpR20Z1FI+DoegQb6k0=; b=hi92sel8fx6a1xWS0qj0ZTLs/C
        aBvXQcKQ5GoQ5MvYk1e7qacr3FeQXgWQK63i1ubM4FgoNQlD17p7gmdLEtJ4/YE8q4tv7UU8xvLyS
        CUyB/qwwB6tcIYmvkc4s7TuS0yfKgaJOaF2tiTLw6PHrxCoGabYCD5BGbhJkHQHHQwtTm5mY/hmVL
        ZDkSBZphBgFjFVDpGGFoQEQjNy1VJHGMyGdfLiKiGwIW1Y7gMwWwLLiP/K9vW8+nU2eccdpNv6XZt
        3CjL14h0Oda8aQA6e4Zt7gCu5CKzSvd4eqmSnzkhoDF1QAjfpdzkft9JkoLqCx6pgNtO5Ac6nihTW
        z4xJgRJA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qw7gZ-00FA7v-32;
        Thu, 26 Oct 2023 21:14:35 +0000
Date:   Thu, 26 Oct 2023 14:14:35 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     axboe@kernel.dk, hare@suse.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongjinghua@huawei.com,
        yi.zhang@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH] block: Set memalloc_noio to false in the error path
Message-ID: <ZTrWu2v6Qp0QVCYw@bombadil.infradead.org>
References: <20231025075436.2212468-1-zhongjinghua@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025075436.2212468-1-zhongjinghua@huaweicloud.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 03:54:36PM +0800, Zhong Jinghua wrote:
> From: Zhong Jinghua <zhongjinghua@huawei.com>
> 
> In del_gendisk, memalloc_noio is set to false, so it would be better to do
> the same thing in the error path.

The commit does not mention what happens if this is not done.

  Luis
