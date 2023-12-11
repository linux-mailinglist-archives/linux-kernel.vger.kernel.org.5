Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E464680D2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344865AbjLKQtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjLKQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:49:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A568E;
        Mon, 11 Dec 2023 08:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KGk0p455n9Qyqg3jYMqF3nY83oslNnD+prahsS3y2tg=; b=rJhP3hWgktnDzGJNYm2tJw4xI7
        TDqg7sdHNEg15rTEfZGNJ8HQ0/9cuVFcZD0RzxDoqN9E3H2U4t2h0p0f1s6cuMj0fIbvlWFrtREe0
        ScIHQItSJyoiH/7RD5UvqgRXQlE/MgoIQOaectiMLWiOerK2qa82ed1qeyDVR9n0vVZCTrL++gnZz
        m5ay27K3W+82SGtrMP2rKybQGP6h0rhma6nk3TsKnrv+H7nMYlCUfsdrcqO7bD2gua1ZPaQs/eeDK
        wqwZhkEnqXbYKWKF6nSJv+T2mKJTiFwscPwOeE1mh5EqSHSZPmOqHv13b5lJk2CaiSUwVq1Vs498I
        lGQaaG8Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCjT4-005xZv-26;
        Mon, 11 Dec 2023 16:49:18 +0000
Date:   Mon, 11 Dec 2023 08:49:18 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     linan666@huaweicloud.com
Cc:     axboe@kernel.dk, akpm@linux-foundation.org, ming.lei@canonical.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] block: Set memalloc_noio to false on device_add_disk()
 error path
Message-ID: <ZXc9jphAnYnwPnwm@infradead.org>
References: <20231211075356.1839282-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211075356.1839282-1-linan666@huaweicloud.com>
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

On Mon, Dec 11, 2023 at 03:53:56PM +0800, linan666@huaweicloud.com wrote:
> From: Li Nan <linan122@huawei.com>
> 
> On the error path of device_add_disk(), device's memalloc_noio flag was
> set but not cleared. As the comment of pm_runtime_set_memalloc_noio(),
> "The function should be called between device_add() and device_del()".
> Clear this flag before device_del() now.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
