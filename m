Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDF57FEEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345281AbjK3MKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345269AbjK3MKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:10:01 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152D3C1;
        Thu, 30 Nov 2023 04:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2TjoRav92l6lGBHcgQ1IFwrVpqblxm0gDdEjjO9i59E=; b=GbSXqQ+vl+tK08waHI4y515wqP
        Q86qDI1AgJw1pLC5ZapIOzsHoJpbnsFqID0QXfxFNjS8NE1MxyGJvaPAqP8UXgXPG+OkIiwqvFlE5
        DgMw0T2oet8bb4vL8QGSd9PVtRm2H4WDDGvigxdO5dtwqWYIgGY2ZdIGbI4X/r0gW1UEzOMr2Dmde
        viBSuF8wOnZothwOKj7mlCWoQjHiCqAqz6lM/4ThVWLIR5o09TLvAb3QvQ8+pRelrxSE2XAmAfbqe
        GcIF1ksl2SBgzx/SYAZ9ZHOSd1E0v1qAotFN0UA7XzmyxTTFDemZpu8Qw++hpXqEzqrc9ikD4vd5b
        kcwkIMUQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51064)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r8frh-0001gG-1i;
        Thu, 30 Nov 2023 12:09:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r8frg-00050Q-P4; Thu, 30 Nov 2023 12:09:56 +0000
Date:   Thu, 30 Nov 2023 12:09:56 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH RFC 14/22] arm64: convert to arch_cpu_is_hotpluggable()
Message-ID: <ZWh7lA9+goBzAprN@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLq-00CTxq-CF@rmk-PC.armlinux.org.uk>
 <20231128151115.00007726@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128151115.00007726@Huawei.com>
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

On Tue, Nov 28, 2023 at 03:11:15PM +0000, Jonathan Cameron wrote:
> On Tue, 07 Nov 2023 10:30:30 +0000
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Convert arm64 to use the arch_cpu_is_hotpluggable() helper rather than
> > arch_register_cpu().
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Ah. Or previous patch needs a forwards reference to the tweaking
> of it it here.
> 
> Maybe just smash the 2 together with a Co-developed: ?

I wanted to keep the two separate to preserve the authorship of the
individual patches, so I'll take the former. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
