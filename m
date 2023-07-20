Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4AE75A6DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjGTGsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjGTGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:48:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519810A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:48:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5217bb5ae05so475235a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1689835687; x=1690440487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YY8m5/XDAUcgHKbAHc0qRAbGRanXhW3GiGRR/skqG2g=;
        b=bToRzJRlXY0VUn2QctmDXk+OuwTIG0h1pb7aqSD2bTZXmX5PW3qdNi9lrYF02VzM6v
         xRIGX8K3Vb/NXJUd00YI6ntCZ9eSvvmAuq/qEn05qEJLjrwtQVDgIIAk4hzPAE2i+ptH
         d7u5qUgh2cUvI4tc49Jmuc2tngAuHOP4G79IhOvJur38SYjXJnghkOLBhcf9GQh0AGog
         TPfzl5gtGknX1co0U81Nut3sj+rbmL03Kz7I/2ql1asJ+GYUNaGcP51Agf9iIKlfE3fj
         qgzS4tvSU264KPwRMxdpiVbjx3UEpJqAk5LjNlguVZGbIGPvy+ybz1Z9OUTtWHP8qT0X
         Dxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689835687; x=1690440487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YY8m5/XDAUcgHKbAHc0qRAbGRanXhW3GiGRR/skqG2g=;
        b=XXUlI2O37tXpgJ6vkYWNpRmcPu8wOwQVuHfXlUqAwM7LePFEtgSKfcS/nZfhvZhG+I
         tkYccVlAuAT7tO0ijDDfqanv/TSCMknWUZ08+SWklEOuMK+Hr6Y59W+O6Dbc5ihxKc7z
         7uDU0gtSjeIiM+yYNhnORn88r4bfnxEY3dPOMaeVd801iv+gPbVIYjdDWepKmAVEVKtH
         hXPx1fJzMYlKW5DqzoNGDYFkhKnNe2yQlOGkQ8rDCgLMldUN/7DSHI0L5BXpqQj26qcN
         r7UUyeTl99oxZ5SzSftIEQjEgfwIePGlZ9PjzERjbQXmJDhQBYazH8NZaOLRjogNM59q
         mFTA==
X-Gm-Message-State: ABy/qLY7jD7odUFfHTPjjXiONIdQz/7TuS58u8X7nhYJ2+vFQYgbUNLM
        tlOwVOFE58SlMPzFrvRzWDvoUg==
X-Google-Smtp-Source: APBJJlGP0/CbRA6tz6PlhVcCHbt6ilna6EIOtA8YnS/sjAkB+d44JIWZZ+NJJArT/iAPBOzXujloYg==
X-Received: by 2002:a05:6402:1806:b0:521:aa4b:24f3 with SMTP id g6-20020a056402180600b00521aa4b24f3mr1193627edy.24.1689835686733;
        Wed, 19 Jul 2023 23:48:06 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id f15-20020aa7d84f000000b0051de2455041sm303663eds.24.2023.07.19.23.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 23:48:06 -0700 (PDT)
Date:   Thu, 20 Jul 2023 08:48:04 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Woody Zhang <woodylab@foxmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: add SBI SUSP extension support
Message-ID: <20230720064804.byexbnbknadets62@kamzik>
References: <tencent_B931BF1864B6AE8C674686ED9852ACFA0609@qq.com>
 <20230720-speller-suffocate-29ee7cc0b1f6@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720-speller-suffocate-29ee7cc0b1f6@wendy>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 07:31:42AM +0100, Conor Dooley wrote:
> Hey Woody,
> 
> On Thu, Jul 20, 2023 at 08:23:19AM +0800, Woody Zhang wrote:
> > RISC-V SBI spec 2.0 [1] introduces System Suspend Extension which can be
> > used to suspend the platform via SBI firmware.
> > 
> > This patch can be tested on Qemu with recent OpenSBI with
> > `system-suspend-test` enabled like [2] in DTB.
> > 
> > [1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> > [2] https://github.com/woodyzhang666/qemu/commit/e4a5120133c1dc354e6ac437ec1f870f6c0f6d05
> > 
> > Signed-off-by: Woody Zhang <woodylab@foxmail.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 10 ++++++++++
> >  arch/riscv/kernel/sbi.c      | 26 ++++++++++++++++++++++++++
> 
> There's prior art here, that is seemingly more complete:
> https://lore.kernel.org/all/20230118180338.6484-2-ajones@ventanamicro.com/
> IIRC, the reason it is still in RFC status is that the 2.0 SBI spec is
> not yet frozen, so this cannot be merged.

Yup, I'll repost with the RFC dropped as soon as 2.0 is frozen.

Thanks,
drew

> 
> Thanks,
> Conor.
> 
> >  2 files changed, 36 insertions(+)
> > 
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 5b4a1bf5f439..3b04016da671 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -30,6 +30,7 @@ enum sbi_ext_id {
> >  	SBI_EXT_HSM = 0x48534D,
> >  	SBI_EXT_SRST = 0x53525354,
> >  	SBI_EXT_PMU = 0x504D55,
> > +	SBI_EXT_SUSP = 0x53555350,
> >  
> >  	/* Experimentals extensions must lie within this range */
> >  	SBI_EXT_EXPERIMENTAL_START = 0x08000000,
> > @@ -236,6 +237,15 @@ enum sbi_pmu_ctr_type {
> >  /* Flags defined for counter stop function */
> >  #define SBI_PMU_STOP_FLAG_RESET (1 << 0)
> >  
> > +enum sbi_ext_susp_fid {
> > +	SBI_EXT_SUSP_SYSTEM_SUSPEND = 0,
> > +};
> > +
> > +/* SBI suspend sleep types */
> > +enum sbi_susp_sleep_type {
> > +	SBI_SUSP_SLEEP_TYPE_SUSPEND = 0x0,
> > +};
> > +
> >  #define SBI_SPEC_VERSION_DEFAULT	0x1
> >  #define SBI_SPEC_VERSION_MAJOR_SHIFT	24
> >  #define SBI_SPEC_VERSION_MAJOR_MASK	0x7f
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index c672c8ba9a2a..9a68959f9f18 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -9,8 +9,10 @@
> >  #include <linux/init.h>
> >  #include <linux/pm.h>
> >  #include <linux/reboot.h>
> > +#include <linux/suspend.h>
> >  #include <asm/sbi.h>
> >  #include <asm/smp.h>
> > +#include <asm/suspend.h>
> >  
> >  /* default SBI version is 0.1 */
> >  unsigned long sbi_spec_version __ro_after_init = SBI_SPEC_VERSION_DEFAULT;
> > @@ -520,6 +522,26 @@ static void sbi_srst_power_off(void)
> >  		       SBI_SRST_RESET_REASON_NONE);
> >  }
> >  
> > +static int sbi_system_suspend(unsigned long arg,
> > +		unsigned long resume_entry, unsigned long context)
> > +{
> > +	struct sbiret ret = {0};
> > +
> > +	ret = sbi_ecall(SBI_EXT_SUSP, SBI_EXT_SUSP_SYSTEM_SUSPEND,
> > +			SBI_SUSP_SLEEP_TYPE_SUSPEND, resume_entry, context, 0, 0, 0);
> > +	return ret.error;
> > +}
> > +
> > +static int sbi_system_suspend_enter(suspend_state_t state)
> > +{
> > +	return cpu_suspend(0, sbi_system_suspend);
> > +}
> > +
> > +static const struct platform_suspend_ops sbi_suspend_ops = {
> > +	.valid          = suspend_valid_only_mem,
> > +	.enter          = sbi_system_suspend_enter,
> > +};
> > +
> >  /**
> >   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> >   * @extid: The extension ID to be probed.
> > @@ -624,6 +646,10 @@ void __init sbi_init(void)
> >  			sbi_srst_reboot_nb.priority = 192;
> >  			register_restart_handler(&sbi_srst_reboot_nb);
> >  		}
> > +		if (sbi_probe_extension(SBI_EXT_SUSP)) {
> > +			pr_info("SBI SUSP extension detected\n");
> > +			suspend_set_ops(&sbi_suspend_ops);
> > +		}
> >  	} else {
> >  		__sbi_set_timer = __sbi_set_timer_v01;
> >  		__sbi_send_ipi	= __sbi_send_ipi_v01;
> > -- 
> > 2.39.2
> > 



> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

