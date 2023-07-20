Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E76075A8D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGTIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGTINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:13:25 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0142684;
        Thu, 20 Jul 2023 01:13:24 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id 6B344166DED;
        Thu, 20 Jul 2023 10:13:21 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1689840801; bh=TdK9jcZL8v/p/laoEmi/zALu74q142SxfjUGyouwpT0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ep2iGtb9XwwVXdW8lVyOJuD+PoVmPwq3KvBPAUvyUMDZA5m9uc+OP56Pme9dHmPf9
         LHSbVYWT2DwuGrfqg10tpCg+WHOsEUxLlBHB4rejKgW1xDrQmwKxTdgmNua/ZkIyCH
         xxGsUJzTMkwUtfhkUvu+WUcF93Rn0u2BhomMyok4HopTRqI6aPHQIsiOePlRk5yWQs
         0rokk+4IQ42uMfAuxqVoxMGN1xbcL2Wy/NC1Kaac/sy0+W5qWYGX9kVu6KE8SRnLaq
         uU+Ds0EbmORD13mcMi4lyS/k6NmlLzUQvS2oeGXNiOQkSfvv6GsyoshWbeWeP6p6QB
         9UMlHjGDhJ+XA==
Date:   Thu, 20 Jul 2023 10:13:20 +0200
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Seo <james@equiv.tech>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "moderated list:XEN HYPERVISOR ARM" <xen-devel@lists.xenproject.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "open list:XEN SWIOTLB SUBSYSTEM" <iommu@lists.linux.dev>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 0/8] Allow dynamic allocation of software IO TLB
 bounce buffers
Message-ID: <20230720101320.72bbd2fc@meshulam.tesarici.cz>
In-Reply-To: <20230720065216.GB4395@lst.de>
References: <cover.1689261692.git.petr.tesarik.ext@huawei.com>
        <20230720065216.GB4395@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 08:52:16 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Just to add a highlevel comment here after I feel like I need a little
> more time to review the guts.
> 
> I'm still pretty concerned about the extra list that needs to be
> consulted in is_swiotlb_buffer, but I can't really think of
> anything better.  Maybe an xarray has better cache characteristics,
> but that one requires even more allocations in the low-level dma map
> path.
> 
> One thing I'd like to see for the next version is to make the
> new growing code a config option at least for now.  It is a pretty
> big change of the existing swiotlb behavior, and I want people to opt
> into it conciously.  Maybe we can drop the option again after a few
> years once everything has settled.

Fine with me. I removed it after all my testing showed no performance
impact as long as the size of the initial SWIOTLB is kept at the
default value (and sufficient for the workload), but it's OK for me if
dynamic SWIOTLB allocations are off by default.

OTOH I'd like to make it a boot-time option rather than build-time
option. Would that be OK for you?

Petr T
