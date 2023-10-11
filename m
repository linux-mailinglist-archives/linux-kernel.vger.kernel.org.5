Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA77C57DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbjJKPNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjJKPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:13:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0ACA9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Vtq/79nvIAkJ7o/SDdhrTtQ1zrLjJjxzEtrU/BQDk5M=; b=dDDez4NJ9I7o6PXrtM0n7qNPXa
        KTmWT7xDfKu+m4bPvBodYYICloshm0a+chq44zKQm0zffB/tOm1b7ShAKOd2HGUIt76odcZAAwnzI
        ID1bxduEzjzy0srEqu0jD8/F/yaS5f4tDbb1Bli9fYcqz7nT/WLF9aAVsVT8rWHOFX+mMld2lMYrg
        8ARrBGqOVb/rJa102xMOnODCXQ6l5b0fyg+9TxGRUa49SI3j8qBCbddRuBuReDqbz5cNGiHDcC8gj
        9UbDzFAT7tplJYqllGDDox1NRjo+I6cr531QvDmzMWjSUAdXQq3YyVeQGYr5kpSKEA2HuP1xqCZTa
        z8TXlCLA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqau6-00GAQR-1L;
        Wed, 11 Oct 2023 15:13:42 +0000
Message-ID: <c7debd36-a934-42b6-834d-d21f4a0d8f7d@infradead.org>
Date:   Wed, 11 Oct 2023 08:13:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] kernel/reboot: document function parameter
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
References: <ZSaCRLZDkOknRTDg@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZSaCRLZDkOknRTDg@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/23 04:08, Matti Vaittinen wrote:
> The hw_failure_emergency_poweroff() has been documented using kernel
> doc. The documentation omits description of the function parameter
> 'int poweroff_delay_ms' - which seems like self-explatonary.
> 
> However, the build bot is nagging about the missing parameter
> documentation, so add the trivial documentation to shut the bot up.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309040349.HLOK1O5I-lkp@intel.com/
> Fixes: dfa19b11385d ("reboot: Add hardware protection power-off")

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  kernel/reboot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 3bba88c7ffc6..c7790711242d 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -940,6 +940,7 @@ static DECLARE_DELAYED_WORK(hw_failure_emergency_poweroff_work,
>  
>  /**
>   * hw_failure_emergency_poweroff - Trigger an emergency system poweroff
> + * @poweroff_delay_ms: Time after which the system is rebooted. In milliseconds.
>   *
>   * This may be called from any critical situation to trigger a system shutdown
>   * after a given period of time. If time is negative this is not scheduled.
> 
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d

-- 
~Randy
