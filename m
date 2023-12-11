Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D29880D085
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjLKQGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344632AbjLKQF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:05:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD32198E;
        Mon, 11 Dec 2023 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MO8te+CcZhuqh9lyi6N+6OpnOSi5nFlWtax3fsNSytk=; b=y2MkADK4CsUrTrRfEeLVo69I26
        XGJJPYgXVKpIpPYUV+5CJE2s241GM5VyUiBDUCk17cKRUQuKsPma5DgB0ZsZRa/Ixj/507F0O34iq
        GXKpirxPm23nbHyhgtnjiU0VmzeC64y7b9uFE6auvqLAkNuYntKnzbmp+lNx3WiCyvdTuFHOVUBRd
        bWHefEf15J+Tm4W4MQjC0AE0hmFJSMeY1M1LzWMmQPxG1oCIgmMSoIwjsu1+DKFlMS3yCpRmhGZ+S
        mqVPY7PuJqBG4LFCyUYYdA9UYo01SjP5q1DHxWK2K24NTg30TuUrdS4ThieLbUPuQVCXE1GPAA7Ng
        TeoO3row==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCilh-005dP1-2k;
        Mon, 11 Dec 2023 16:04:29 +0000
Date:   Mon, 11 Dec 2023 08:04:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 03/12] ARM: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXczDXH6KZWwcWLQ@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-4-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208055501.2916202-4-samuel.holland@sifive.com>
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

On Thu, Dec 07, 2023 at 09:54:33PM -0800, Samuel Holland wrote:
> Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
> tree, use it instead of duplicating the flags here.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
