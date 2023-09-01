Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAFA78FC3E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 13:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349145AbjIALYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 07:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349162AbjIALYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 07:24:15 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD4FC;
        Fri,  1 Sep 2023 04:24:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50078e52537so3402897e87.1;
        Fri, 01 Sep 2023 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693567450; x=1694172250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MZUtundwqHcO4yCQ3S4Jr20+yx6rxfd+e7HUjYqbiyg=;
        b=KqIT4TbTBxVT8guyuXQVHP1FaIlScXoI0XdtCxZkfXxtXE5pQxLLLj1X93zf+cikB6
         I0VH7+F5o10D4Ia+SgdpDNeMe+/k3qnVlrBv2hpgBV34rIQk/nvjjchqbhz3lCzWWuKf
         sEWhV3USsTB6S7koM9jbIIxCzGZ22HwjWRZMFd4ncSCmNC6wa7pFAiHtKIsMZaVh8NWt
         eps4a/LtacyP40t8Vu2tX41OGdovt6wDpFYDQkQpWjbEFBmarm1QyRDW5nRUrkdwVqqA
         Uvd3PCnCyzguEXHotdtMFHGFAhVwkFXddSsede3QW0YX1S+00ZFZuHAGy9TeW3+BsCPT
         H8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693567450; x=1694172250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZUtundwqHcO4yCQ3S4Jr20+yx6rxfd+e7HUjYqbiyg=;
        b=DgYdZKgVuYNEr9BzUaEGiN3boybaO4zjndA+Afz7YkUcjbIjuVmFdPjj9SI2qrWKqh
         kttDPPytYWhFEVyyCbW8Dm2muy9lHjFncXF3+7kiWx2SUwvOYKjOFOQND9dzOYHXZk8x
         wBEJrh7g2R/9biY09UGbJme0Sm6QH59Stg4p0YjRdOX4rgrVcQszJR0CtjncKxH1h8KN
         4CfqcIgYTCzfdmHb274OQMGRpq6t7yGD19bLuc8VQ1algK77BPTu6156Ob/Z5DUKst1E
         stfl5jdIto2IjNv7g11bfgtv4GDFy/kp5ACeb4AOTHBPSmIz3ahVFJWl6KVkJQe04XmN
         uo4Q==
X-Gm-Message-State: AOJu0Yw8Zvm7/+6CMlVd1CxpRwodjju6BJPm97xctBDK7Kx5rWQXTIiA
        T1IT8Os6V5u5afkiACMRgGo=
X-Google-Smtp-Source: AGHT+IHOxz6+aE164dg8a+0ql62e3eQ9Ve7lbF9ka5qZ5UXbS6VpLXkAl1QyNpKNQibZEpC4RRFY7A==
X-Received: by 2002:a05:6512:748:b0:500:94c3:8e3b with SMTP id c8-20020a056512074800b0050094c38e3bmr1304072lfs.57.1693567450134;
        Fri, 01 Sep 2023 04:24:10 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id i11-20020a056512224b00b0050085eaa79esm621912lfu.61.2023.09.01.04.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:24:09 -0700 (PDT)
Date:   Fri, 1 Sep 2023 14:24:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Michal Simek <michal.simek@amd.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sherry Sun <sherry.sun@nxp.com>,
        Shubhrajyoti Datta <Shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH RESEND v3 01/17] EDAC/synopsys: Fix native uMCTL2 IRQs
 handling procedure
Message-ID: <huufbexe3cc5kungc7nrcc7gmdkfm4w3r45sv5v3wc2o44fqdp@woz3jbdujm7h>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-2-Sergey.Semin@baikalelectronics.ru>
 <Y2AE5A74TIZwJ/7Q@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2AE5A74TIZwJ/7Q@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav

Thank you very much for all the useful notes. I've updated the series
in accordance with your comments. It will be submitted for review when the
merge window is open. Answers to some of your questions are below.

On Mon, Oct 31, 2022 at 06:24:52PM +0100, Borislav Petkov wrote:
> On Fri, Sep 30, 2022 at 02:26:56AM +0300, Serge Semin wrote:
> > The generic DW uMCTL2 DDRC v3.x support was added in commit f7824ded4149
> > ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR"). It
> > hasn't been done quiet well there with respect to the IRQs handling
> > procedure. An attempt to fix that was introduced in the recent commit
> > 4bcffe941758 ("EDAC/synopsys: Re-enable the error interrupts on v3 hw").
> > Alas again it didn't provide quite complete solution.
> 
> Because?
> 
> Btw, for the future, you should make sure you add those commit authors
> to Cc so that they can get a chance to comment. Adding the folks from
> that commit to Cc.

At least the authors are Cc'ed actually.

> 
> > First of all the commit f7824ded4149 ("EDAC/synopsys: Add support for
> > version 3 of the Synopsys EDAC DDR") log says that v3.80a "has UE/CE auto
> > cleared". They aren't in none of the IP-core versions.
> 	    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> What does that sentence mean exactly? The UE/CE auto clearing
> functionality is not in that silicon?
> 
> > The IRQ status can be cleared by means of setting the ECCCLR/ECCCTL
> > register self-cleared flags 0-3.
> 
> I'm guessing that's this reg:
> 
> /* ECC control register */
> #define ECC_CTRL_OFST                   0xC4
> 
> ?
> 
> > The pending IRQ clearance is done in the respective get_error_info()
> > method of the driver. Thus defining a quirk flag with the
> > "DDR_ECC_INTR_SELF_CLEAR" name was at least very inaccurate if not to
> > say misleading.
> >
> > So was adding the comments about the "ce/ue bits automatically
> > cleared".
> 
> Aah, you mean that the ->get_error_info() functions are doing the
> clearing even if something should be doing self clearing. And that
> DDR_ECC_INTR_SELF_CLEAR thing is queried when enabling the error
> interrupt which is just bad naming because it looks like that quirk
> controls what register to write/read.
> 
> > Second, disabling the being handled IRQ in the handler doesn't make sense
> > in Linux since the IC line is masked during that procedure anyway. So
> > disabling the IRQ in one part of the handler and enabling it at the end of
> > the method is simply redundant. (See, the ZynqMP-specific code with the
> > QoS IRQ CSR didn't do that originally.)
> 
> So what is this commit message of
> 
>   4bcffe941758 ("EDAC/synopsys: Re-enable the error interrupts on v3 hw")
> 
> then talking about:
> 
> "Then the interrupt handler will be called only once."
> 
> How is that interrupt supposed to be reenabled?
> 
> > Finally calling the zynqmp_get_error_info() method concurrently with the
> > enable_irq()/disable_irq() functions causes the IRQs mask state race
> > condition. Starting from DW uMCTL2 DDRC IP-core v3.10a [1] the ECCCLR
> > register has been renamed to ECCCTL and has been equipped with CE/UE IRQs
> > enable/disable flags [2].
> 
> Aha, that sounds like the right thing to toggle.
> 
> > So the CSR now serves for the IRQ status and control functions used
> > concurrently during the IRQ handling and the IRQ disabling/enabling.
> > Thus the corresponding critical section must be protected with the
> > IRQ-safe spin-lock.
> 
> > So let's fix all the problems noted above. First the
> > DDR_ECC_INTR_SELF_CLEAR flag is renamed to SYNPS_ZYNQMP_IRQ_REGS.
> 

Seeing you've got so many questions I guess the text has turned to be
a bit hard to comprehend. I'll update the patch log to having less
history insides but being more oriented towards the actual problem.
Sorry for the inconvenience.

> "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy to
> do frotz", as if you are giving orders to the codebase to change its
> behaviour."
> 
> In this case, pls formulate it something like this:
> 
> "So fix all these problems noted above: rename DDR_ECC_INTR_SELF_CLEAR
> to SYNPS_ZYNQMP_IRQ_REGS to denote that, ..."
> 
> And so on.

Got it. The entire series of the patchsets will be fixed in accordance
with your request.

> 
> > Its semantic is now the opposite: the quirk means having the ZynqMP
> > IRQ CSRs available on the platform.
> 
> Yes, that makes more sense.

I'll move this change into another patch. The described problem can be
fixed with no need in this modification. Thus the patch will get to be
simpler for review. 

> 
> > Second the DDR_UE_MASK and DDR_CE_MASK macros
> > are renamed to imply being used in the framework of the ECCCLR/ECCCTL CSRs
> > accesses. Third all the misleading comments are removed. Finally the
> > ECC_CLR_OFST register IOs are now protected with the IRQ-safe spin-lock
> > taken in order to prevent the IRQ status clearance and IRQ enable/disable
> > race condition.
> > 
> > [1] DesignWare Cores Enhanced Universal DDR Memory and Protocol
> > Controllers (uMCTL2/uPCTL2), Release Notes, Version 3.91a, October 2020,
> > p. 27.
> > [2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2),
> > Databook Version 3.91a, October 2020, p.818-819.
> 

> If those are not publicly accessible, then there's no point to put them
> in here.

IMO it's better to have some links than not to have them at all and say
something like "Synopsys databook claims it differently". At least
they will be useful for the developers who have those documents.

> 
> > Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Does this need to go to stable@ and thus older kernels?

Yes it was the original intention - to get it backported, but it's up
to the stable tree maintainers to decide. The problem is real but very
much rare to be actually spotted especially seeing nobody has reported
about it yet.

> 
> > ---
> >  drivers/edac/synopsys_edac.c | 76 +++++++++++++++++++++++-------------
> >  1 file changed, 48 insertions(+), 28 deletions(-)
> 
> > @@ -300,6 +299,7 @@ struct synps_ecc_status {
> >  /**
> >   * struct synps_edac_priv - DDR memory controller private instance data.
> >   * @baseaddr:		Base address of the DDR controller.
> > + * @lock:		Concurrent CSRs access lock.
> >   * @message:		Buffer for framing the event specific info.
> >   * @stat:		ECC status information.
> >   * @p_data:		Platform data.
> > @@ -314,6 +314,7 @@ struct synps_ecc_status {
> >   */
> >  struct synps_edac_priv {
> >  	void __iomem *baseaddr;
> > +	spinlock_t lock;
> 

> That lock needs to be named properly and have a comment above it what it
> protects.

I'll rename it to reglock. The structure already has it documented in
the above kdoc.

> 
> >  	char message[SYNPS_EDAC_MSG_SIZE];
> >  	struct synps_ecc_status stat;
> >  	const struct synps_platform_data *p_data;
> 
> ...
> 
> > @@ -516,24 +523,42 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
> >  
> >  static void enable_intr(struct synps_edac_priv *priv)
> >  {
> > +	unsigned long flags;
> > +
> >  	/* Enable UE/CE Interrupts */
> > -	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
> > -		writel(DDR_UE_MASK | DDR_CE_MASK,
> > -		       priv->baseaddr + ECC_CLR_OFST);
> > -	else
> > +	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
> >  		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
> >  		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
> >  
> > +		return;
> > +	}
> > +
> > +	/* IRQs Enable/Disable feature has been available since v3.10a */
> 

> How does this comment help here?
> 
> If it is available since a version number, why doesn't the below check a
> version number? IOW, what is the relevance of that comment here?

This comment will be added with a statement that the operation below
is "noop" for the older devices. Moreover the comment will be helpful
for the future driver hackers who would wish to add the DW uMCTL2
IP-core versions detected and utilized it in the driver. In none of
the my changes it was needed, so I didn't provide such functionality.

> 
> In any case, I need to hear from this driver's maintainer too.

I have much doubt we'll hear out anything from the original
driver authors. Hopefully Michal and Alexander (in Cc-list) will help
us out with reviews and testing.

-Serge(y)

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
