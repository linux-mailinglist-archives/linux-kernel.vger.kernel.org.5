Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053C07F3ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjKVHXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbjKVHXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:23:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED3312C;
        Tue, 21 Nov 2023 23:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=bak1w5nmTqdapVHUeSibvY0xrs
        OlQyOW/ViYQDVXErcrqszBMwuSPgWgHpP69c3vDSYbXqkU0MYp/PpcLf2o8L9lqQMkWccOg0eBBhz
        I6WEmC44Gu9TfE/WfkjC9qvUy0gKMTRM/uU/hGL4viYxwWTV+dUAXFPHSS8Gju1DpaMadabZZW+1i
        FEndiipvl3BL3kjDCGs6FxYbEwZcN612+CpqOYAU0yGQRb0cMYWI3MeikHgy+uL9kezd/QfIrJpTH
        B8RUwnlGPzXexFIJNFCTc4yA1zWgNeTM/kniZ89jvNogtUY4BNRsBGiJCO43zY7X8C0V6vTE69/ZF
        TjDDCmOA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5ha9-000tul-2L;
        Wed, 22 Nov 2023 07:23:33 +0000
Date:   Tue, 21 Nov 2023 23:23:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     ming.lei@redhat.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 1/3] block: move .bd_inode into 1st cacheline of
 block_device
Message-ID: <ZV2sdZjvqPXH5T9f@infradead.org>
References: <20231122103103.1104589-1-yukuai1@huaweicloud.com>
 <20231122103103.1104589-2-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122103103.1104589-2-yukuai1@huaweicloud.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
