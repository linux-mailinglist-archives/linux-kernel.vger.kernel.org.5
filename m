Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53F577B57E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjHNJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjHNJ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:28:25 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A3EC113;
        Mon, 14 Aug 2023 02:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
        Content-Type; bh=+FBhsj1NEHZh40veVLb6FpBaS4vsDDs+BM7lRp95dkM=;
        b=ReoRUyS+ApQYxrmE++ke8YAlfcNoXzoAtlUun+V75zLAAkF0lShGbLh7ccXwog
        un5m0zuHSHIjI+EdfPm8fhytp6g1K0wXQHm6QLBRyNuHfG5U8HrKh0Rfk79HIc/L
        INuQpEcTNXVEb65Rgulcp0LumTMrIACE2ZOcVGrgBNfkY=
Received: from [172.20.10.2] (unknown [39.144.139.60])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wB3egis6NlkQ7KZDA--.24646S3;
        Mon, 14 Aug 2023 16:41:18 +0800 (CST)
Message-ID: <a6c2f193-ef7c-54a0-dfbb-13915be259a1@163.com>
Date:   Mon, 14 Aug 2023 16:27:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] watchdog: simatic: add PCI dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Haeussler, Gerd" <gerd.haeussler.ext@siemens.com>,
        "Schaffner, Tobias" <tobias.schaffner@siemens.com>,
        "Wu, Xing Tong" <XingTong.Wu@siemens.com>
References: <20230814073924.1066390-1-arnd@kernel.org>
From:   "xingtong.wu" <xingtong_wu@163.com>
In-Reply-To: <20230814073924.1066390-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: _____wB3egis6NlkQ7KZDA--.24646S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF17Xr1kCry5Jw4Utr4rAFb_yoW8CFW5pa
        93tF10kw1UJr4UtF13A34xWFy5Z3Z3JFW3JF15C3s8ua909r18KF97tr98W3yDAwsrCr17
        KayrWry7Wa1DurUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaYLPUUUUU=
X-Originating-IP: [39.144.139.60]
X-CM-SenderInfo: p0lqw35rqjs4rx6rljoofrz/1tbiTBXL0GI0adrZ7AAAsS
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2023/8/14 15:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The simatic-ipc driver no longer depends on PCI, but its watchdog portion
> still needs it, otherwise P2SB runs into a build  failure:

If the simatic-ipc driver no longer depends on PCI, you can
delete the dependency here:
https://elixir.bootlin.com/linux/v6.5-rc6/source/drivers/platform/x86/Kconfig#L1079

> 
> WARNING: unmet direct dependencies detected for P2SB
>   Depends on [n]: PCI [=n] && X86 [=y]
>   Selected by [m]:
>   - SIEMENS_SIMATIC_IPC_WDT [=m] && WATCHDOG [=y] && SIEMENS_SIMATIC_IPC [=y]
> 
> drivers/platform/x86/p2sb.c:121:3: error: call to undeclared function 'pci_bus_write_config_dword'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>                 pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, 0);
> 
> Add back the minimum dependendency to make it build in random configurations
> again.
> 
> Fixes: b72da71ce24b0 ("platform/x86: simatic-ipc: drop PCI runtime depends and header")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 04e9b40cf7d53..09452384221a4 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1680,7 +1680,7 @@ config NIC7018_WDT
>  
>  config SIEMENS_SIMATIC_IPC_WDT
>  	tristate "Siemens Simatic IPC Watchdog"
> -	depends on SIEMENS_SIMATIC_IPC
> +	depends on SIEMENS_SIMATIC_IPC && PCI

The SIEMENS_SIMATIC_IPC_WDT does not depends on PCI directly,
it should depends on P2SB, then P2SB depends on PCI

>  	default y
>  	select WATCHDOG_CORE
>  	select P2SB

You can replace the "select" to "depends on" instead.

Reviewed-by: Xing Tong Wu <xingtong.wu@siemens.com>

--
Xing Tong

