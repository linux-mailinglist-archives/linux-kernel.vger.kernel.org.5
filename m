Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4658A77A6E9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjHMO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjHMO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:26:51 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A37D1707;
        Sun, 13 Aug 2023 07:26:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso5707100e87.2;
        Sun, 13 Aug 2023 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691936811; x=1692541611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nERYgavMyu53FpkZKPSvlBcif90SGUTbA9ZcD7rfnds=;
        b=KjW+M7pPBmLwPD8jjeoBohrQx9fcB6EJfpXSGIVG28P+hqFxd2D9L1DveW/HcH21r4
         3mIp3lA7+/ptCKJkgtM9utH4IQYfkOU8M6nrvmAmbPSMHDIKSJRBrolRD3/V8sE9AXfn
         1c2juWWlmVgagpw3yN8fv+XjSO+vQ5/bSGkE4OT1J7b5NkqyKcJNyM1X+Kn0LTFHmimX
         s70VYbAUIFm1RWCZPOpl270YK0FNTaNCtkhjj6nC7uww0x1ZBm8xM8E7vwRl6JjihpAx
         uvGj92Ae2xM0aZ989H/aKO9mIO+yi6ran5Dvu7iyc5+Fkh51UVQ8cnGAv6aJ6VUP0+xl
         yKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691936811; x=1692541611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nERYgavMyu53FpkZKPSvlBcif90SGUTbA9ZcD7rfnds=;
        b=hzGQz6DwFsevtmVaBwVxCNqz4+9yzpySvoaNwLEl7PGCJCPm0DaswAWXtAr3P2hmjs
         +Wkg2hkPcFvQShogQVMeGGY9+wyjlhqKY4vS9lnSIyXrIrLJdnWGFDr2fS7iw0fQNgNe
         +HpbGofLsQ7BhFSFtbsteTm8a+qfJgpluN0ypwG7iIpBH8sRwStJprKJ1wyKiEh/Yes0
         EqVdlVDH7F4GB3pYNc/V2Xc+KJG+0bpQ3E/zr8RfHnwwNth1Alp3ZPkGAsOPEPW5KvEG
         4jqoRI1C9wBJ5bDq5N83wXBWAqd9t0JhlzTESLY2E3K6E5mi2jpe5zAtFQsMToVtqLnA
         s4Rg==
X-Gm-Message-State: AOJu0Yw1Z/jen82seHlsfuDyXYENuqRKKxOYFpZJaRIEc6zzwujovgZd
        K2ermhB7Cw+BkrMkmY/tuMM=
X-Google-Smtp-Source: AGHT+IFE/4CHmeW1skmIqlUuH2txEv+dkkqkzOf3NxwkjM6snWr55prx7caz+p5YHxt0Aw0Chp3P+A==
X-Received: by 2002:ac2:5e32:0:b0:4fb:81f2:422b with SMTP id o18-20020ac25e32000000b004fb81f2422bmr3921887lfg.54.1691936810543;
        Sun, 13 Aug 2023 07:26:50 -0700 (PDT)
Received: from mobilestation ([109.194.233.135])
        by smtp.gmail.com with ESMTPSA id ep29-20020a056512485d00b004fb73bea65esm1555579lfb.25.2023.08.13.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 07:26:49 -0700 (PDT)
Date:   Sun, 13 Aug 2023 17:26:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        wangjianli <wangjianli@cdjrlc.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] irqchip: mips-gic: mark gic_irq_domain_free() static
Message-ID: <3airu2djxchrycegbfb6ijp6cjlxldybo6vzl7ncfwesuitm3e@uilhuqoa6okq>
References: <20230810123404.1222332-1-arnd@kernel.org>
 <20230810123404.1222332-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810123404.1222332-2-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 02:33:55PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This function is only used locally and should be static to avoid a warning:
> 
> drivers/irqchip/irq-mips-gic.c:560:6: error: no previous prototype for 'gic_irq_domain_free' [-Werror=missing-prototypes]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/irqchip/irq-mips-gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
> index 6d5ecc10a8703..76253e864f230 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -557,7 +557,7 @@ static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
>  	return gic_irq_domain_map(d, virq, hwirq);
>  }
>  

> -void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
> +static void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
>  			 unsigned int nr_irqs)

Right. Thanks! Note the descendant line should be aligned to the
function open parenthesis to preserve the coding style well
utilized in the driver. With that fixed feel free to add:

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

>  {
>  }
> -- 
> 2.39.2
> 
