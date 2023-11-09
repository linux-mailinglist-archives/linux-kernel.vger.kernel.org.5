Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ED67E7475
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbjKIWmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjKIWma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:42:30 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBDB4206;
        Thu,  9 Nov 2023 14:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=CltTL1Rex0kaIFRKfLiha4ilf787I7h9sGObtQ4O5Ok=; b=C5EGz8Ixx0AakG1ZcQPhEWLqKv
        8QORt9/zAZ9U2rgOi0dc7hmZrgfzAl1/V2FdVugFiykdYGNPV7BaxaMmKZ6yeXFZyoGRxaWm5grYe
        X96PWoVPXW1h1tSsyxx2y/qRu9kFk0ZPhA6OSDYqiNH8xEOjdF/FUewszYk50PAdBF9yysZ5Zk+xc
        1lSHT8snQ6rFCFAcS9iHVoOhaFFgiA6rEpf632EWlu2fWXQnFF3Mv4VPF7OFYhF8yOkTZpYGlsabN
        3RM0hnb+Q+dGd0qP5dgPVIvv/I/Tbgz3FhRhFkufSM3BIT2sHO1HGth00wDoOavArT2w4tlhDZ6Tm
        fCHbQ8FA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r1DjG-007Md1-0u;
        Thu, 09 Nov 2023 22:42:26 +0000
Message-ID: <3024abdf-e7e1-4063-a0ba-ed415317c200@infradead.org>
Date:   Thu, 9 Nov 2023 14:42:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: samsung: Fix kernel-doc comments
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231109190925.2066-1-semen.protsenko@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231109190925.2066-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/23 11:09, Sam Protsenko wrote:
> Fix some issues found in kernel-doc comments in Samsung CCF framework.
> It makes scripts/kernel-doc happy, which can be checked with:
> 
>     $ find drivers/clk/samsung/ -name '*.[ch]' -exec \
>       scripts/kernel-doc -v -none {} \;
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> Fixes: ddeac8d968d4 ("clk: samsung: add infrastructure to register cpu clocks")
> Fixes: 721c42a351b1 ("clk: samsung: add common clock framework helper functions for Samsung platforms")
> Fixes: 3ff6e0d8d64d ("clk: samsung: Add support to register rate_table for samsung plls")
> ---
>  drivers/clk/samsung/clk-cpu.h | 2 +-
>  drivers/clk/samsung/clk.h     | 9 ++++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
> index fc9f67a3b22e..103f64193e42 100644
> --- a/drivers/clk/samsung/clk-cpu.h
> +++ b/drivers/clk/samsung/clk-cpu.h
> @@ -11,7 +11,7 @@
>  #include "clk.h"
>  
>  /**
> - * struct exynos_cpuclk_data: config data to setup cpu clocks.
> + * struct exynos_cpuclk_cfg_data: config data to setup cpu clocks.

Hm, OK, the ':' separator works. '-' is the documented separator here,
but it's not worth updating the patch for that.

>   * @prate: frequency of the primary parent clock (in KHz).
>   * @div0: value to be programmed in the div_cpu0 register.
>   * @div1: value to be programmed in the div_cpu1 register.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

thanks.

-- 
~Randy
