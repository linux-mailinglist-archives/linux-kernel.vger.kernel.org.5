Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742247F2E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 14:27:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjKUN1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 08:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUN1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 08:27:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AC11A3;
        Tue, 21 Nov 2023 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rH4XXg0XG5JBDQqriE53B4ksPcxyNMkV8utydydYqlE=; b=GptbOphakDgWkgtVyn9kVmSZut
        2zdws9QRSTONl2GEr2a+OIBZrE3jJeI0D17zlWvHurC71V/x0OEPF6ffv784k7DLlc2aBOLE19Z4o
        c0tv6/9S+iTe2UkhfYWBVaiamG9EJTPv9gb0UnQ2E+mlufTRS4ZpZA3hqA7HZlRX89aSKzHu3MJ1l
        WcQbFRHumzI7PayZveu3slicUkYT4CsYU60SPqpcv75Ku2ucJtsjbZP45akWiW287IkZ3VbUy79a4
        0dZN0gESalrlMs8ThicaN1EXR0io2uxwvg6b/yBrH8ePzb7FDP5MvhbzHS0L7bDI0qET3jb0ExwyI
        bdYgIQPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33300)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r5QmU-00073r-1c;
        Tue, 21 Nov 2023 13:27:10 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r5QmS-0004DC-UA; Tue, 21 Nov 2023 13:27:08 +0000
Date:   Tue, 21 Nov 2023 13:27:08 +0000
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
Subject: Re: [PATCH RFC 10/22] drivers: base: Move cpu_dev_init() after
 node_dev_init()
Message-ID: <ZVywLPwhILp083Jk@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLV-00CTxS-QB@rmk-PC.armlinux.org.uk>
 <095c2d24-735b-4ce2-ba2e-9ec2164f2237@redhat.com>
 <ZVHXk9JG7gUjtERt@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVHXk9JG7gUjtERt@shell.armlinux.org.uk>
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

On Mon, Nov 13, 2023 at 08:00:19AM +0000, Russell King (Oracle) wrote:
> On Mon, Nov 13, 2023 at 10:58:46AM +1000, Gavin Shan wrote:
> > 
> > 
> > On 11/7/23 20:30, Russell King (Oracle) wrote:
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > NUMA systems require the node descriptions to be ready before CPUs are
> > > registered. This is so that the node symlinks can be created in sysfs.
> > > 
> > > Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
> > > are registered by arch code, instead of cpu_dev_init().
> > > 
> > > Move cpu_dev_init() after node_dev_init() so that NUMA architectures
> > > can use GENERIC_CPU_DEVICES.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > > Note: Jonathan's comment still needs addressing - see
> > >    https://lore.kernel.org/r/20230914121612.00006ac7@Huawei.com
> > > ---
> > >   drivers/base/init.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > 
> > With Jonathan's comments addressed:
> 
> That needs James' input, which is why I made the note on the patch.

I'm going to be posting the series without RFC soon, and it will be
with Jonathan's comment unaddressed - because as I've said several
times it needs James' input and we have sadly not yet received that.

Short of waiting until James can respond, I don't think there are
any other alternatives.

I do hope we can get this queued up for v6.8 though.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
