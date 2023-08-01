Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3C76A810
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 06:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjHAEyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 00:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHAEyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 00:54:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6210FB;
        Mon, 31 Jul 2023 21:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=XPmq9nd4ncn+eEU5icBGK2Yzt52aidznqpSeFaNbngs=; b=UPDvoaAcf6gBLSfTO/nVMZjlQF
        oGZvRa2zxYQZEVRZkqF/CmIhRbObUPazHpkdWm6Hmi+ArNJRWuWNSoiPxKKXDfI86qmpJ+pqmwWBt
        fcVRKYwcP+Bk4u075dbKvbNsJoZrUCboizKh6sR7Bx7MmKXMNV08MKawuten1Es0TrioVUAHL8Jqm
        NPWafTHSE6eRzxYKD3wr5euu7WdEj1JdZCwAKZ1IrZtUIh6vW7mSNei1HA5d7qting85AAtCwAcf2
        RDqHe6jkDHAdwULwTt5DjieBA/bRK+APV8kRL1dAcD+dAUv5Y8XzkQ/iEN1Sep9cEy5ZHrETTcQhZ
        Pql7MlyQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQhOZ-000MQ1-24;
        Tue, 01 Aug 2023 04:54:07 +0000
Message-ID: <ec7616b0-706a-faa9-fc0b-ce6ae746137b@infradead.org>
Date:   Mon, 31 Jul 2023 21:54:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2 v10] Watchdog: Add marvell GTI watchdog driver
Content-Language: en-US
To:     Bharat Bhushan <bbhushan2@marvell.com>, wim@linux-watchdog.org,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com
References: <20230801044623.9275-1-bbhushan2@marvell.com>
 <20230801044623.9275-2-bbhushan2@marvell.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230801044623.9275-2-bbhushan2@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 21:46, Bharat Bhushan wrote:
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ee97d89dfc11..87ac222b436e 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1797,6 +1797,19 @@ config OCTEON_WDT
>  	  from the first interrupt, it is then only poked when the
>  	  device is written.
>  
> +config MARVELL_GTI_WDT
> +	tristate "Marvell GTI Watchdog driver"
> +	depends on ARCH_THUNDER || (COMPILE_TEST && 64BIT)
> +	default y
> +	select WATCHDOG_CORE
> +	help
> +	 Marvell GTI hardware supports watchdog timer. First timeout
> +	 works as watchdog pretimeout and installed interrupt handler
> +	 will be called on first timeout. Hardware can generate interrupt
> +	 to SCP on second timeout but it is not enabled, So second

	                                        enabled, so second

> +	 timeout is ignored. If device poke does not happen then system
> +	 will reboot on third timeout.

All Kconfig help text should be indented with one tab + 2 spaces
according to coding-style.rst.

-- 
~Randy
