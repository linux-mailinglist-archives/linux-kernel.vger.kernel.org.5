Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA457EC04F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 11:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjKOKLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 05:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbjKOKLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 05:11:50 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252539C;
        Wed, 15 Nov 2023 02:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J+m5Wux4gCeZ5VbKE22zSD3h2vqCToIPoOglMpcMB98=; b=WMk7AaLVtN5GRy7VHSplvABKOr
        OXRc47CE5LjYfVL1I4G9BmL9nkSst8Vh0ERKHmS8MJxRSPLKDFvaYbEeA1sMiDIYtcRhNQa/pnlI8
        PkqOB9knMX2YL+uvuraKATTscnDpMYKl3cLLR36pzK4yKmNHGHEjAw7PZ395B53vvUhyuWvtelDyB
        r5XhCGNIJB9iBgYQiuOIDQBOPCIGnr+az2tu1OpmA6+1stGbOEb7mZfrcCgopQw9ZYDmB/DHKIyAH
        MGihds8I0ekCwC2YQuqoXNHvkOJ31Wt+yTJ713pnOPmQLGMyMGfLqHWpB6tvMEThA4WWseIPd1uBc
        ry+LnBrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56952)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r3Crx-0000WK-1q;
        Wed, 15 Nov 2023 10:11:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r3Crw-0006Uz-QI; Wed, 15 Nov 2023 10:11:36 +0000
Date:   Wed, 15 Nov 2023 10:11:36 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 11/22] drivers: base: remove unnecessary call to
 register_cpu_under_node()
Message-ID: <ZVSZWK+OmZWEce33@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLa-00CTxY-Uv@rmk-PC.armlinux.org.uk>
 <955f2b95-76e4-4e68-830b-e6dd9f122dc1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <955f2b95-76e4-4e68-830b-e6dd9f122dc1@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 02:04:32PM +1000, Gavin Shan wrote:
> On 11/7/23 20:30, Russell King (Oracle) wrote:
> > Since "drivers: base: Move cpu_dev_init() after node_dev_init()", we
> > can remove some redundant code.
> > 
> > node_dev_init() will walk through the nodes calling register_one_node()
> > on each. This will trickle down to __register_one_node() which walks
> > all present CPUs, calling register_cpu_under_node() on each.
> > 
> > register_cpu_under_node() will call get_cpu_device(cpu) for each, which
> > will return NULL until the CPU is registered using register_cpu(). This
> > now happens _after_ node_dev_init().
> > 
> > Therefore, calling register_cpu_under_node() from __register_one_node()
> > becomes a no-op, and can be removed.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >   drivers/base/node.c | 7 -------
> >   1 file changed, 7 deletions(-)
> > 
> 
> __register_one_node() can be called in memory hot add path either. In that path,
> a new NUMA node can be presented and becomes online. Does this become a problem
> after the logic of associating CPU with newly added NUMA node?

I guess this is where ordering matters.

As mentioned in the commit message, register_cpu_under_node() does
this:

        if (!node_online(nid))
                return 0;

        obj = get_cpu_device(cpu);
        if (!obj)
                return 0;

get_cpu_device() will return NULL if the CPU is not possible or is out
of range, or register_cpu() has not yet been called for this CPU, and
register_cpu() will call register_cpu_under_node().

I guess it is possible for a CPU it be present, but the node its
associated with would not be online, which means we end up with
register_cpu_under_node() returning on !node_online(nid) but we've
populated the CPU devices (thus get_cpu_device(cpu) would return
non-NULL).

Then when the numa node comes online, we do still need to call this
path, so this change is incorrect.

It came about trying to address Jonathan's comment for this patch:

https://lore.kernel.org/r/20230913163823.7880-7-james.morse@arm.com

I think my response to Jonathan is still correct - but didn't need
a code change. I'm dropping this patch.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
