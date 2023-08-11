Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F365A778D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbjHKLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbjHKLXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:23:53 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7844171D;
        Fri, 11 Aug 2023 04:23:33 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E89EA40E0194;
        Fri, 11 Aug 2023 11:22:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F0-DLhc1lZum; Fri, 11 Aug 2023 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691752966; bh=h/v55CWAwzTy+KrxdcUWkvzhq3Ar1s60l7WUk5aCdxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ngm2EUFx70cJ1VJpTqYKAbdQ27g25CIXKcjK0kYaxbWZLruz79Eedfj1ireUU9ykY
         NBgdYWeXnSQmgMch7n3MzmG47tAYmRwLLxujOdtc5wi9pJH6ziJQiX/eDmE2BB1j2U
         EXWUi16cH3YCC8TO+4PMD9J2P1XJVtdaE5g56DJqG/aNbFl1cMWPmehW8Aj4/h0vzs
         4y8+rArAcns7Lf9/VM2Y1RN4empcmb/sAgLMH6sP8lBOO6I6E4J5t+KHhks5FPqjAO
         KqqdjTGIpTu1tpN2g31sD6uWRB32SyEXSxvRISjPE8wtLFPk855/862ijBZX57PGQs
         L/fSn7wY9x+hDsW/aOJtFzrJDrvpU4JgaX/ZaXUbnoG7fD2QbH7xGWy+iAjqWJb4lJ
         sbQpoLXESRAUxPu8URYysjsb53iuwjeqgj5qdx1UXNl7fiHgeRGYz1RM4nx2lue2je
         9u+TSVhgJNmOmuuGUU8igCoS0WQf109cjRqZLPYNZ2v153iD60X6qIHJG83XgluaN2
         /oYmE36Dto0zLjyZzjUra62s9y7sCLHIdCtBrVFTEtaJtbAadEnck7uUwWHyjRjxpW
         K/NXx5ZS+xyVjUDQakPY0WY6tBY+V+GgPF05pnC9Cb2ckcfEvLLWIqY1Y72uERgRl7
         iboTXn9Sj08+ge6eVJ/D2kvk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C87D540E01A1;
        Fri, 11 Aug 2023 11:22:40 +0000 (UTC)
Date:   Fri, 11 Aug 2023 13:22:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>, initramfs@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [patch 02/30] x86/microcode: Hide the config knob
Message-ID: <20230811112236.GFZNYZ/Ndw1/Us+X2e@fat_crate.local>
References: <20230810153317.850017756@linutronix.de>
 <20230810160805.081212701@linutronix.de>
 <ZNVLh38eq8TWHFra@araj-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNVLh38eq8TWHFra@araj-mobl.amr.corp.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ dracut ML (I hope this is the right one).

Dracut folks, you can drop this check soon - microcode loader will be
unconditionally built in.

On Thu, Aug 10, 2023 at 01:41:43PM -0700, Ashok Raj wrote:
> On Thu, Aug 10, 2023 at 08:37:29PM +0200, Thomas Gleixner wrote:
> > In reality CONFIG_MICROCODE is enabled in any reasonable configuration when
> > Intel or AMD support is enabled. Accomodate to reality.
> > 
> > Requested-by: Borislav Petkov <bp@alien8.de>
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  arch/x86/Kconfig                       |   38 ---------------------------------
> >  arch/x86/include/asm/microcode.h       |    6 ++---
> >  arch/x86/include/asm/microcode_amd.h   |    2 -
> >  arch/x86/include/asm/microcode_intel.h |    2 -
> >  arch/x86/kernel/cpu/microcode/Makefile |    4 +--
> >  5 files changed, 8 insertions(+), 44 deletions(-)
> > 
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1308,44 +1308,8 @@ config X86_REBOOTFIXUPS
> >  	  Say N otherwise.
> >  
> >  config MICROCODE
> > -	bool "CPU microcode loading support"
> > -	default y
> > +	def_bool y
> >  	depends on CPU_SUP_AMD || CPU_SUP_INTEL
> 
> Seems like there is a dracut dependency that checks for either of these to
> be present.
> 
> dracut: Generating /boot/initrd.img-6.5.0-rc3-ucode-minrev+
> dracut: Disabling early microcode, because kernel does not support it. CONFIG_MICROCODE_[AMD|INTEL]!=y
> 
> Just a tool fix. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
