Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D7F80D096
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbjLKQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343941AbjLKQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:08:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50023A9B;
        Mon, 11 Dec 2023 08:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=voX1j54PoeLMwiQxMkFN5YaL2nBXSYPeTjd4yAFjCQA=; b=ifw6UNjUEDXllsbmZ4AL+dQpRW
        W7b4XK9Kv2/xZ1tcblE7ZfPY/0dMQS0FEvx+i2C6aAE7Zt7MP/UVmUe/mhIExmXNoeKSWR72X4ReC
        icB9zGsV3UObHyUoHkKwukaPk5sKzjyLMManm+Ed1NR3M9AXPCg7SGx6gNkh/lCOKPdmxYNuDiXKe
        +vPv++gGyb9vO0onHi8hOeAukUR55fcRtmV0/FupL1Zz4rC0EOk2DlmrIbKBCnZ1/X9rpJ8qxM7fL
        5WaQwgOsHX/LIFPFPmJ7abBBvtKt5+kdFvtLwoI1y1PYRxUnUZ4Uky9Byl+Nm//eqRAtc8ufLM3GM
        rJYlXhJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCioR-005edf-1j;
        Mon, 11 Dec 2023 16:07:19 +0000
Date:   Mon, 11 Dec 2023 08:07:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXczty+Y6dTDL4Xi@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-6-samuel.holland@sifive.com>
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

> +CFLAGS_REMOVE_neon1.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon2.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon4.o += $(CC_FLAGS_NO_FPU)
> +CFLAGS_REMOVE_neon8.o += $(CC_FLAGS_NO_FPU)

Btw, do we even really need the extra variables for compiler flags
to remove?  Don't gcc/clang options work so that if you add a
no-prefixed version of the option later it transparently gets removed?

Except for that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
