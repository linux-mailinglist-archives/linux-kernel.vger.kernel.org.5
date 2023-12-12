Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E880E4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjLLHLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbjLLHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:11:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5350DC;
        Mon, 11 Dec 2023 23:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3ses/ZsQ18kkMwgX82j0GHRHgEu7yezobRPEQDwOeVE=; b=loj03fvm+MJwW7UkZI87OSv2dM
        qeINzFTWACJoUVBnZlcSrmQkrWLr5xuEsDdRgvb5xBuN1aE/bWKNEgWHFUlBi/ZV9SF22qyvnJGUA
        DZ68pilvL8lEA0iIGTlXV2zGf7lHqaMbEX21rfTXZE6tuqmlioNpEuuuLEimLtiwvnN/Y7QaN0miK
        8Pw/X9MRFAr9i/CbFXHP2hssmAw31NucyJ04pGVjNFulPJR0JNcg2RsF/iul5D+xi4/72npQbSeXG
        AMPg9usdCOgER055N5knKYZHyWtjFPb5xvlUOXsPtI+/8n7GRnUxeWFCsRjRL0cG2Zs0GDs92YoTC
        1eySzcnA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCwv4-00AuEj-0x;
        Tue, 12 Dec 2023 07:11:06 +0000
Date:   Mon, 11 Dec 2023 23:11:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 05/12] lib/raid6: Use CC_FLAGS_FPU for NEON CFLAGS
Message-ID: <ZXgHisDUsJMw7z3N@infradead.org>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
 <20231208055501.2916202-6-samuel.holland@sifive.com>
 <ZXczty+Y6dTDL4Xi@infradead.org>
 <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c40dfe8-f245-413f-a424-bde52ce21b6a@sifive.com>
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

On Mon, Dec 11, 2023 at 10:12:27AM -0600, Samuel Holland wrote:
> On 2023-12-11 10:07 AM, Christoph Hellwig wrote:
> 
> Unfortunately, not all of the relevant options can be no-prefixed:

Ok.  That is another good argument for having the obj-fpu += syntax
I proposed.  You might need help from the kbuild maintainers from that
as trying to understand the kbuild magic isn't something I'd expect
from a normal contributor (including myself..).

