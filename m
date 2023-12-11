Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1BC80D099
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344261AbjLKQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344235AbjLKQIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:08:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9A10E0;
        Mon, 11 Dec 2023 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rJnz7vJXFXZ+s+GFQzKJTUyedjcYLhX/g9SREbHLG/g=; b=uiSOGsUEndY59UZcDr2nsLhwOC
        xvo3UYY9rZM2tEcqicOJ3+pK/HBNuqe8cRF/YePTNrlnG4zEVCdK0AQjLk3MzTpYv281FU9lszRTk
        qm6YETmBLeEz0F19k0Zqua9SNRnhKuRhLxo46IPt3fYZDgibBA6L+ErLtap/OcZnqgF1BlymMVgOc
        cqM3QsrC/ZEXXIn0sLxNA0LePNNoq3DFdu9Wg+6cZzvuax1t/aFd+/trtecIfsjyJsWT61Bg62uor
        t9PGL3ktjHrepi3yXR3LcVqoyoHO4LJKUBN/egey8BXily4PDedmA4YzBp/8DmxqoVw7capk9MQAX
        jCcMos6g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCioq-005epY-0W;
        Mon, 11 Dec 2023 16:07:44 +0000
Date:   Mon, 11 Dec 2023 08:07:44 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 06/12] LoongArch: Implement
 ARCH_HAS_KERNEL_FPU_SUPPORT
Message-ID: <ZXcz0NVitD1pQJ5V@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-7-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-7-samuel.holland@sifive.com>
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

On Thu, Dec 07, 2023 at 09:54:36PM -0800, Samuel Holland wrote:
> LoongArch already provides kernel_fpu_begin() and kernel_fpu_end() in
> asm/fpu.h, so it only needs to add kernel_fpu_available() and export
> the CFLAGS adjustments.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
