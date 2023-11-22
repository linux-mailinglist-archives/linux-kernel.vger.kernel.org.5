Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0807F3E83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjKVHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbjKVHAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:00:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E05D47
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=38yfeYGGIhQE7SMv/R6/plOSGW
        l9qczmYaH5DMCKBHs7GhUk2Mu3TOKUkdwtoE1CA0YwtVXzY87o9UEYESgpOoQ+wkFW5+eABH/WkHr
        OuGrjIXzhtBW3884xq2HoSqYetwCtMxT6KCX7u2BHWGRy9Elc/buBH5+vzdEVyy+tIvF8gZjKaIQQ
        OPq9ij5C5aanVIjFV4Eozw9FDuK5NYNK6x9ybMJleySZdEKfTm4gR4Ioy5Xitr0WFchvG+/C6nB2a
        ITs6CuwD8VsWpD5XQUDSFaNUYaN7R9kkFsAcRsmme9QU08XLKP3qo8R9y9R7UnesOOZuJUwr7JNxY
        EIOiLSVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r5hDT-000s2J-2w;
        Wed, 22 Nov 2023 07:00:07 +0000
Date:   Tue, 21 Nov 2023 23:00:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: mm: implement pgprot_nx
Message-ID: <ZV2m92lOpRgRFfRk@infradead.org>
References: <20231121160637.3856-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121160637.3856-1-jszhang@kernel.org>
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
