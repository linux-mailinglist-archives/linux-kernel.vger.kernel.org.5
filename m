Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3387D8016EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 23:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjLAW4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 17:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 17:56:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2F91712
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 14:56:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A08C433C8;
        Fri,  1 Dec 2023 22:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701471371;
        bh=GVeXptVzISkp+LH6rP7ABvt7j/9kuofhAXSzf6mU7l8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZlTyL5Navjtt+nMUpk0afajOVeVQDR77Pt7SGMWB4Q7v/stMRvKg3qER0HZe0B/tB
         SOc6ksiIaqIceMMqt2hyLiNeFTVS4WRQ3p6fUsddPqqsV5Bh0BeNEoKk9OKPGDaMlf
         Wuu/Guum7yPnLVyDB3umrP6cNa74sdsmvkBuxIXV8c9f4XyuMby/fN5k0ejxocAJ/9
         bGSWcZEPs0mAZucGyrGTFJxwRtOoRXK2dy8JGsNNXP5tQcE59nU3vgWcvPx+tuPqe3
         SCsPX4Z13RNDe+WXBEL70a7MB7WnSEc7eNxEq/3d9IAffSRPCTblWTd57tl+pLeO78
         uYLdLsWN9Nviw==
Date:   Fri, 1 Dec 2023 16:56:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/6] x86: Use PCI_HEADER_TYPE_* instead of literals
Message-ID: <20231201225609.GA534714@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231201204447.GA527927@bhelgaas>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+cc scsi, powerpc folks]

On Fri, Dec 01, 2023 at 02:44:47PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 24, 2023 at 11:09:13AM +0200, Ilpo Järvinen wrote:
> > Replace 0x7f and 0x80 literals with PCI_HEADER_TYPE_* defines.
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> Applied entire series on the PCI "enumeration" branch for v6.8,
> thanks!
> 
> If anybody wants to take pieces separately, let me know and I'll drop
> from PCI.

OK, b4 picked up the entire series but I was only cc'd on this first
patch, so I missed the responses about EDAC, xtensa, bcma already
being applied elsewhere.

So I kept these in the PCI tree:

  420ac76610d7 ("scsi: lpfc: Use PCI_HEADER_TYPE_MFD instead of literal")
  3773343dd890 ("powerpc/fsl-pci: Use PCI_HEADER_TYPE_MASK instead of literal")
  197e0da1f1a3 ("x86/pci: Use PCI_HEADER_TYPE_* instead of literals")

and dropped the others.

x86, SCSI, powerpc folks, if you want to take these instead, let me
know and I'll drop them.

> > ---
> >  arch/x86/kernel/aperture_64.c  | 3 +--
> >  arch/x86/kernel/early-quirks.c | 4 ++--
> >  2 files changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
> > index 4feaa670d578..89c0c8a3fc7e 100644
> > --- a/arch/x86/kernel/aperture_64.c
> > +++ b/arch/x86/kernel/aperture_64.c
> > @@ -259,10 +259,9 @@ static u32 __init search_agp_bridge(u32 *order, int *valid_agp)
> >  							order);
> >  				}
> >  
> > -				/* No multi-function device? */
> >  				type = read_pci_config_byte(bus, slot, func,
> >  							       PCI_HEADER_TYPE);
> > -				if (!(type & 0x80))
> > +				if (!(type & PCI_HEADER_TYPE_MFD))
> >  					break;
> >  			}
> >  		}
> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > index a6c1867fc7aa..59f4aefc6bc1 100644
> > --- a/arch/x86/kernel/early-quirks.c
> > +++ b/arch/x86/kernel/early-quirks.c
> > @@ -779,13 +779,13 @@ static int __init check_dev_quirk(int num, int slot, int func)
> >  	type = read_pci_config_byte(num, slot, func,
> >  				    PCI_HEADER_TYPE);
> >  
> > -	if ((type & 0x7f) == PCI_HEADER_TYPE_BRIDGE) {
> > +	if ((type & PCI_HEADER_TYPE_MASK) == PCI_HEADER_TYPE_BRIDGE) {
> >  		sec = read_pci_config_byte(num, slot, func, PCI_SECONDARY_BUS);
> >  		if (sec > num)
> >  			early_pci_scan_bus(sec);
> >  	}
> >  
> > -	if (!(type & 0x80))
> > +	if (!(type & PCI_HEADER_TYPE_MFD))
> >  		return -1;
> >  
> >  	return 0;
> > -- 
> > 2.30.2
> > 
