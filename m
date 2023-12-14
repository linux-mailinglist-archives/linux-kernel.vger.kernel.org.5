Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2520C81392F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjLNR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNR5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:57:17 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC1A6;
        Thu, 14 Dec 2023 09:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L5kH8hIOwqwSSDYrxYuLkFSUt4lz/pRwIQ1vDoFypus=; b=bOgj+hxbflOy6cpdwb0AvqLThn
        fosBo2pgUtid/Btg47D1Tr3fCNbhKvXDaFyqcQYQOH+89NazR4QJ+nEdeEWaM9Zg8F7j05T5cdfgY
        VM0/6oQ5Ia3iYudlE0F/bur8gqKg6jOipwcfxclKO24mpPwoNEGS+tH8oMOIY0M/Mu+mNs52+wi+F
        lm2Ni4mV9JyW5Xe5z2A66vskhG5XC6BjK4hHnl/tR3bWJCTUoI5s6XIt40Rmf7oAfWwyL5XMzUAT4
        /eBXYVzBh9GeGUvZJBlu9nSJESu+sZ6JrCvtRt5k+bC7E6cUZkcVRSXfwHypdgwrPjdz2GiqQfqO/
        Cgy7guXg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38096)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1rDpxV-0001oM-19;
        Thu, 14 Dec 2023 17:57:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1rDpxX-0002km-Ed; Thu, 14 Dec 2023 17:57:19 +0000
Date:   Thu, 14 Dec 2023 17:57:19 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, acpica-devel@lists.linuxfoundation.org,
        linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 02/21] ACPI: processor: Add support for processors
 described as container packages
Message-ID: <ZXtB/+2kDtaz1Zf4@shell.armlinux.org.uk>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
 <E1rDOfx-00Dvje-MS@rmk-PC.armlinux.org.uk>
 <20231214173626.00005062@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214173626.00005062@Huawei.com>
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

On Thu, Dec 14, 2023 at 05:36:26PM +0000, Jonathan Cameron wrote:
> On Wed, 13 Dec 2023 12:49:21 +0000
> Russell King (Oracle) <rmk+kernel@armlinux.org.uk> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
> > ACPI has two ways of describing processors in the DSDT. From ACPI v6.5,
> > 5.2.12:
> > 
> > "Starting with ACPI Specification 6.3, the use of the Processor() object
> > was deprecated. Only legacy systems should continue with this usage. On
> > the Itanium architecture only, a _UID is provided for the Processor()
> > that is a string object. This usage of _UID is also deprecated since it
> > can preclude an OSPM from being able to match a processor to a
> > non-enumerable device, such as those defined in the MADT. From ACPI
> > Specification 6.3 onward, all processor objects for all architectures
> > except Itanium must now use Device() objects with an _HID of ACPI0007,
> > and use only integer _UID values."
> > 
> > Also see https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#declaring-processors
> > 
> > Duplicate descriptions are not allowed, the ACPI processor driver already
> > parses the UID from both devices and containers. acpi_processor_get_info()
> > returns an error if the UID exists twice in the DSDT.
> > 
> > The missing probe for CPUs described as packages creates a problem for
> > moving the cpu_register() calls into the acpi_processor driver, as CPUs
> > described like this don't get registered, leading to errors from other
> > subsystems when they try to add new sysfs entries to the CPU node.
> > (e.g. topology_sysfs_init()'s use of topology_add_dev() via cpuhp)
> > 
> > To fix this, parse the processor container and call acpi_processor_add()
> > for each processor that is discovered like this. The processor container
> > handler is added with acpi_scan_add_handler(), so no detach call will
> > arrive.
> > 
> > Qemu TCG describes CPUs using processor devices in a processor container.
> > For more information, see build_cpus_aml() in Qemu hw/acpi/cpu.c and
> > https://uefi.org/specs/ACPI/6.5/08_Processor_Configuration_and_Control.html#processor-container-device
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Tested-by: Miguel Luis <miguel.luis@oracle.com>
> > Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> > Tested-by: Jianyong Wu <jianyong.wu@arm.com>
> > ---
> > Outstanding comments:
> >  https://lore.kernel.org/r/20230914145353.000072e2@Huawei.com
> Looks like you resolved those (were all patch description things).
> 
> So I'm happy.
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Great, I wasn't sure if I had resolved them to your satisfaction, so I
kept the reference to your original review. I've now removed it and
added your r-b. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
