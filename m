Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939B2791144
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352316AbjIDGPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239873AbjIDGPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:15:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD0E6;
        Sun,  3 Sep 2023 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uqZIEVGX8LBl5LC04sUyJqXrXPJR+Rmg73potRiE+/Y=; b=HcPILUv1+vP6fX3zbOX+DKmVdq
        p+UYR5wX9iUtJb6xWDgvDxYnKzg8wuroCuEmyehA16TlrioqLQPpP/ub3Jr3x9ku0owVyQtm41XPR
        SnmpSXgfgbylyutHG2F75yKmfNi3ZxyeDCZemHfYi/ekU3s4J892TNYOvoTXuz+qxXW0QEZODqzJ6
        8Swy3YcRAdy8hTJIHctfIMyXlSXrhWUo61rarid9elWIta+s1fmw+Am64OC69Rc9BVCYEr2FzJhYV
        Pu2dk1eMhFaa+uO93v4Itgdb3ze9WK1436g6v6YMlJabm39++HUZtO4vgczpGU4GYphY++dQFahFH
        HisYklAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qd2rU-003OfB-1Q;
        Mon, 04 Sep 2023 06:15:00 +0000
Date:   Sun, 3 Sep 2023 23:15:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Chunhai Guo <guochunhai@vivo.com>
Cc:     axboe@kernel.dk, chao@kernel.org, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] block: export symbol blk_flush_plug
Message-ID: <ZPV15I09CTC/Dfww@infradead.org>
References: <20230904042243.820031-1-guochunhai@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904042243.820031-1-guochunhai@vivo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 10:22:43PM -0600, Chunhai Guo wrote:
> blk_flush_plug() can be used in a filesystem module, without it may cause
> a link failure, as shown in the reported test.

It should not be used by a file system, so please revert the change that
started using it despite it intentionally not being exported.

