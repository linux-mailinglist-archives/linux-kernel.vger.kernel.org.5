Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5C78CC4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbjH2SkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237734AbjH2Sj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:39:57 -0400
X-Greylist: delayed 2344 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 11:39:54 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5FE1A3;
        Tue, 29 Aug 2023 11:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=2+jBhh7Rm5fk+KUZId5RowKc48zMaqxcyc5fMnT6rjs=; b=EQMhJaEPh4eZSoIViWn5ncDFVT
        8SJgW06gpvqJWzlNPCuIla5/zuu3oN/cKoaW0VCwzTdq0JCEQM9TC4nKGzwVe0u9uCglc6ze5jf0G
        ZUs4odvkJE+PE8qOBa7dyNQM5cPEkzIdJQCrl3MzmGT+hDzRvG/oqi1gGYwHXG1ogURefnAxmmnK8
        nqj/hmsLxQk7kLAB0iri1CXVYtQf3LJWlG7kmUq+Z20viASkUPcm+IfhNF+gZfg8GIcFZGW9iRm8f
        wyqGtd1Y5yl7PHH+Jnu/9PuQKKhSnQu2hzlQgcdrNaI3sYI9ZXoD9NtajLn2o5TZkLVDwLolkmeCp
        bjY/9VQg==;
Received: from [2a01:e34:ec5d:a741:9a7b:5831:531:65c9] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1qb31C-00EvrU-1Y; Tue, 29 Aug 2023 20:00:46 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.96)
        (envelope-from <aurelien@aurel32.net>)
        id 1qb31B-00CxEV-1G;
        Tue, 29 Aug 2023 20:00:45 +0200
Date:   Tue, 29 Aug 2023 20:00:45 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: dt-platdev: Support building cpufreq
 platdev driver as module
Message-ID: <ZO4yTQAV9EYA4erZ@aurel32.net>
Mail-Followup-To: Zhipeng Wang <zhipeng.wang_1@nxp.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
 <20230524153417.2738448-2-zhipeng.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524153417.2738448-2-zhipeng.wang_1@nxp.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023-05-24 15:34, Zhipeng Wang wrote:
> Make the cpufreq platdev driver as tristate so that it can be built
> as loadable module.
> 
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> ---
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c839bd2b051..dda3a78bfd5c 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -218,7 +218,7 @@ config CPUFREQ_DT
>  	  If in doubt, say N.
>  
>  config CPUFREQ_DT_PLATDEV
> -	bool
> +	tristate "Generic DT based cpufreq platdev driver"
>  	help
>  	  This adds a generic DT based cpufreq platdev driver for frequency
>  	  management.  This creates a 'cpufreq-dt' platform device, on the

It seems that this new module is missing support for autoloading,
causing issues with CPUFREQ_DT=m.

Before that change, CPUFREQ_DT_PLATDEV ended up selected as =y. Now,
CPUFREQ_DT_PLATDEV ends up selected as =m. As it is not autoloaded, it
means that cpufreq-dt is not working anymore unless manually running
"modprobe cpufreq-dt-platdev".

Could you therefore please add support for autoloading?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                     http://aurel32.net
