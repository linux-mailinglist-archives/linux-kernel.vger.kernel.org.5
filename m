Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13DF80D09A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344058AbjLKQIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbjLKQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:08:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF01712;
        Mon, 11 Dec 2023 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7/9PVAoW+mQkYndhB1mGTPqj7a0+NR0wxr/3ILbUkfI=; b=TeWHg8VZSEjB97ULraUC03LR2V
        9GC7hrJ0A2gqejqPepZpofgeBkUk0EVbz/vD0fh6fK/Pusr93obgkapD9TgcuvEfVgLqAQyhawo1/
        QPRqUA+ePWr2UqnfeEquAZ6BVqZqgaTn3YvcN9HdTFXdhb/6CADXiwbbw1vcgtF2p9HTQXlKVlqSM
        eyF/Q02AbITgCJ7jsrkAJcFCeERnZF8MxEjneMz/1yh8P8Ty73TErCHiYVQIIlTHviIQXJooTFonT
        hJXhhHFfFXybb/NYo+IqCrGs2rePIPKcPL+CZA/221GjtLICb55HO+UalInlQyqUmSHQgFSksIjFb
        gemr5Klw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCipZ-005fBl-02;
        Mon, 11 Dec 2023 16:08:29 +0000
Date:   Mon, 11 Dec 2023 08:08:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 07/12] powerpc: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXcz/Bi6xP1CYK60@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-8-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-8-samuel.holland@sifive.com>
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

On Thu, Dec 07, 2023 at 09:54:37PM -0800, Samuel Holland wrote:
> PowerPC provides an equivalent to the common kernel-mode FPU API, but in
> a different header and using different function names. The PowerPC API
> also requires a non-preemptible context. Add a wrapper header, and
> export the CFLAGS adjustments.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
