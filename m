Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D080D082
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344011AbjLKQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjLKQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:05:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7092B3244;
        Mon, 11 Dec 2023 08:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NZSOK9WEf75MklfPNXGRllooeOJSKTH5cik2mcCApGk=; b=RjcBeA1PdEk2uyx9kR1h0vqfX4
        d+Yc1bRexIwPfEwXg3ATjowaawQ6wbOG4OgsjFrzg9fZZ0zJjukp6Imd5SFfd6ha0kA/qXRd422Fj
        Nhph1TZ3Pc+KZkOBqTAhjpSdNUTZ4lvJm4jQdxcrZ6EH/+7GL/IpZ/YGrUXp0g36nBp1dXbu+km6G
        +7cIhUBiolRpN6/Ql8tIJaxRM6dJVqbtp3VdZ9gpozS3qBe5ggNJiOclYFTG63FNxCesa9LKP1zlK
        A4pSdsV8BAmR9z2J4zu5mvlp3sRTQk30uEx9FjlxHopEq0ezrXH5BU7JQ5+CFAnadouB17RK0IYsz
        HlvRlvVw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCilJ-005dCw-1o;
        Mon, 11 Dec 2023 16:04:05 +0000
Date:   Mon, 11 Dec 2023 08:04:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 02/12] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXcy9YUWrC586RX+@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-3-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-3-samuel.holland@sifive.com>
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

> --- /dev/null
> +++ b/arch/arm/include/asm/fpu.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * linux/arch/arm/include/asm/fpu.h

Please don't add the file name to top of the file comments.  It serves
no purpose and easily gets out of date.

Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
