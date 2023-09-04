Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747E79124C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352446AbjIDHfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjIDHfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:35:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCC138;
        Mon,  4 Sep 2023 00:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aj8qo65bU9+mObJsa0GmTKTXcbZTLq6HKVwPVvIb458=; b=uLHk0cttdKdc3VVr2kuWKKTOLI
        H4q7opcGxAM0tMrjuTt1+soalH1wXjJGj3VBxaTqisVHXtAu3silsMNYE8/UxNt8xjPyHJqwKi5L+
        hUC8gGPzYdBVdMMMzAXAvADgNZIti5ZiiDeiwbPJiGX05L591lSyKAwEO4czNkFD47m+jIFCTcbOA
        2X45kXwqYSPxDrF5pCzoYY27LvCnyd1fiXz+zTAlYjdXom+WWyHPnMfeLD+yBIygT92aXxPeJ8yRZ
        /Tj1O93wZhWHHRscS4JuM69SQmAL2fKjwR/7fJaQtV2ByAL7S6+kl/yOl/KYY91mhcjCEMbXEWpAF
        p5PETuAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qd46i-003UWO-2y;
        Mon, 04 Sep 2023 07:34:48 +0000
Date:   Mon, 4 Sep 2023 00:34:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chunhai Guo <guochunhai@vivo.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "chao@kernel.org" <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] block: export symbol blk_flush_plug
Message-ID: <ZPWImKGXZbz6HUJs@infradead.org>
References: <20230904042243.820031-1-guochunhai@vivo.com>
 <ZPV15I09CTC/Dfww@infradead.org>
 <08d3c0a5-7f5d-4054-8bfb-7767aacd47c3@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d3c0a5-7f5d-4054-8bfb-7767aacd47c3@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 03:24:10PM +0800, Chunhai Guo wrote:
> Could you please detail why blk_flush_plug() can not be used by a file
> system?

Can you detail why it is a good idea to use it?  Beause you nee to make
the argument why something should be exported.
