Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F907FECAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjK3KTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjK3KTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:19:40 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3910C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:19:45 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bbb78efb5so1106196e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701339583; x=1701944383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k8UQb25ZCpcw6Z79V6XyuEVHM1dfOywe6SGyX+g3qNY=;
        b=Vf72haQcFOQ2a9O6O4MLGFrWRKrLtq0w8AlNdb9+qIk7vUSsVeqctbXcywgI8mOxJ8
         8FtafobjRqrhQOc0Dm0tfVnyh5Gam2J4IbQQFKwcWyqh3Cfbh/a6Ha7M0nMkjpBQuykG
         WCLORM3CIKRPDT9O7o4N+tbRpDkK4z6LErNRp+skRdE/x3Y2+ClGHfdEMj5uc0qZV5Z5
         PSlHUFg+3OG3WqQ33SCODRy6T2px2vSkaUN88P2KjJalU/LufQPk5yFss/i9Us1YoRxJ
         fRzvTmOEL+hf4J89q5yVo2p7Y+sIwySWXkUMHJyMmgBW9YDOoEtI3VleWjSrxgfhEQN7
         V2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701339583; x=1701944383;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k8UQb25ZCpcw6Z79V6XyuEVHM1dfOywe6SGyX+g3qNY=;
        b=mcTsuhLhEMdMcJrjwMUfwEL5m7R7DqX6qSAprOU55pVin6f2PbsIgQmgmV2FlEwq+Q
         77lxX9qwarZCKTxw8OI12po6QEv5feSv6YEkJ/KWwY6xaSGQrzuxadexNtMs5LuHiCsh
         t9wsQUQFPjw1C4n84lDK8bWNpSGq4KYWu328Q5SWFuX41KqA7WCI151GHiHpiGxiKiMc
         Og8Td2I3hj7iiioC68FDFoKQu2w03Po03N5kxnXL38+cjgTecAkAGZ8wGani9FBEIge0
         KLrHCpRkCzT4odIKhY5bRFvdkzfBr/7dlfvXCgO+Y6a7eBX1XveIpz8aDjjP/TUd7E5Z
         sddw==
X-Gm-Message-State: AOJu0YycNSD5sm5ETrXQVjuJGRevx6oF5VMWg/hl2wdItB3maj/OYXvq
        W7gL9r4Z+UmVnPHp5VdTQZHLyw==
X-Google-Smtp-Source: AGHT+IFicDS5nZRdVyEjLR/yDXZjHP6zAHJnWPPNMwUq5JEBOXe2iFZJ/RCR5kwlmJeqdFPrc6ZorA==
X-Received: by 2002:a05:6512:3b87:b0:50b:c6c7:1e60 with SMTP id g7-20020a0565123b8700b0050bc6c71e60mr3769644lfv.29.1701339583276;
        Thu, 30 Nov 2023 02:19:43 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id m40-20020a05600c3b2800b004042dbb8925sm5190871wms.38.2023.11.30.02.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 02:19:42 -0800 (PST)
Message-ID: <3e3a39eb-edb5-4d5d-bd30-d447e7605049@linaro.org>
Date:   Thu, 30 Nov 2023 10:19:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] tty: samsung_tty: 32-bit access for TX/RX hold
 registers
Content-Language: en-US
To:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, sbeom.choi@samsung.com
References: <20200506080242.18623-1-hyunki00.koo@samsung.com>
 <CGME20200506080258epcas2p4f242fb66a2145f76b0e108014ee351fb@epcas2p4.samsung.com>
 <20200506080242.18623-3-hyunki00.koo@samsung.com>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
        willmcvicker@google.com
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20200506080242.18623-3-hyunki00.koo@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying my luck on a 3 year old patch, fingers crossed :).

On 5/6/20 09:02, Hyunki Koo wrote:

Hi, Hyunki!

> Support 32-bit access for the TX/RX hold registers UTXH and URXH.
> 
> This is required for some newer SoCs.

Is the 32-bit access mandatory for the newer SoCs? I'm asking because I
see a SError Interrupt when using 8-bit accesses on gs101 (pixel6). Can
you confirm if gs101 USI UART is restricted to only 32 bit data width
accesses?

If 32-bit accesses are mandatory, we should impose this restriction so
that we avoid crashing the kernel on wrong user configuration. I have
some patches ready, waiting just for a confirmation.

Below is the crash that I see. Thanks!

[    1.215459] SError Interrupt on CPU6, code 0x00000000be000411 -- SError
[    1.215464] CPU: 6 PID: 1 Comm: swapper/0 Not tainted
6.6.0-rc1-00021-g31831088e862-dirty #88
[    1.215468] Hardware name: Oriole DVT (DT)
[    1.215470] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[    1.215473] pc : s3c24xx_serial_console_putchar+0x1c/0x90
[    1.215487] lr : uart_console_write+0x50/0x6c
[    1.215491] sp : ffff80008007b6c0
[    1.215492] x29: ffff80008007b6c0 x28: 0000000000000000 x27:
ffffc0ec2c855900
[    1.215498] x26: ffffc0ec2bdee008 x25: 0000000000000000 x24:
ffffc0ec2c529a40
[    1.215501] x23: ffff80008007b830 x22: ffffc0ec2c9578b9 x21:
ffffc0ec2c9b8330
[    1.215504] x20: ffffc0ec2aa0d684 x19: ffffc0ec2c95788a x18:
0000000000000006
[    1.215507] x17: 0000000000000000 x16: 0000000000000001 x15:
ffff80008007b460
[    1.215510] x14: 0000000000000000 x13: 64656c62616e6520 x12:
5d30434153797474
[    1.215513] x11: 5b20656c6f736e6f x10: 63203a6b746e6972 x9 :
656c62616e65205d
[    1.215515] x8 : 304341537974745b x7 : 205d303534353132 x6 :
322e31202020205b
[    1.215518] x5 : ffffc0ec2c9b82f0 x4 : ffffc0ec2b5bc1c0 x3 :
ffff800080061000
[    1.215521] x2 : 0000000000000111 x1 : 0000000000000020 x0 :
ffffc0ec2c9b8330
[    1.215526] Kernel panic - not syncing: Asynchronous SError Interrupt
[    1.215528] CPU: 6 PID: 1 Comm: swapper/0 Not tainted
6.6.0-rc1-00021-g31831088e862-dirty #88
[    1.215531] Hardware name: Oriole DVT (DT)
[    1.215532] Call trace:
[    1.215533]  dump_backtrace+0x90/0xe8
[    1.215542]  show_stack+0x18/0x24
[    1.215547]  dump_stack_lvl+0x48/0x60
[    1.215555]  dump_stack+0x18/0x24
[    1.215559]  panic+0x31c/0x378
[    1.215565]  nmi_panic+0x8c/0x90
[    1.215569]  arm64_serror_panic+0x6c/0x78
[    1.215571]  do_serror+0x3c/0x70
[    1.215574]  el1h_64_error_handler+0x30/0x48
[    1.215581]  el1h_64_error+0x64/0x68
[    1.215583]  s3c24xx_serial_console_putchar+0x1c/0x90
[    1.215588]  s3c24xx_serial_console_write+0xb8/0xfc
[    1.215593]  console_flush_all.isra.0+0x168/0x3ac
[    1.215600]  console_unlock+0x58/0xdc
[    1.215604]  vprintk_emit+0x1a8/0x2b0
[    1.215608]  vprintk_default+0x38/0x44
[    1.215613]  vprintk+0xbc/0xd0
[    1.215617]  _printk+0x5c/0x84
[    1.215621]  register_console+0x2a0/0x400
[    1.215625]  serial_core_register_port+0x61c/0x658
[    1.215630]  serial_ctrl_register_port+0x10/0x1c
[    1.215634]  uart_add_one_port+0x10/0x1c
[    1.215639]  s3c24xx_serial_probe+0x360/0x6fc
[    1.215644]  platform_probe+0x68/0xc8
[    1.215650]  really_probe+0x148/0x2b0
[    1.215653]  __driver_probe_device+0x78/0x12c
[    1.215656]  driver_probe_device+0x3c/0x15c
[    1.215658]  __driver_attach+0x90/0x19c
[    1.215661]  bus_for_each_dev+0x78/0xd4
[    1.215668]  driver_attach+0x24/0x30
[    1.215670]  bus_add_driver+0xe8/0x1f8
[    1.215672]  driver_register+0x5c/0x124
[    1.215675]  __platform_driver_register+0x28/0x34
[    1.215678]  samsung_serial_init+0x30/0x8c
[    1.215687]  do_one_initcall+0x7c/0x1c0
[    1.215689]  kernel_init_freeable+0x1bc/0x284
[    1.215695]  kernel_init+0x24/0x1dc
[    1.215697]  ret_from_fork+0x10/0x20
[    1.215701] SMP: stopping secondary CPUs
[    1.215708] Kernel Offset: 0x40ebaa200000 from 0xffff800080000000
[    1.215710] PHYS_OFFSET: 0xffffc18980000000
[    1.215711] CPU features: 0xc0000001,70020143,1000720b
[    1.215714] Memory Limit: none
> 
> Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> Tested on Odroid HC1 (Exynos5422):
> Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 62 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
> index 326b0164609c..6ef614d8648c 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -154,10 +154,33 @@ struct s3c24xx_uart_port {
>  #define portaddrl(port, reg) \
>  	((unsigned long *)(unsigned long)((port)->membase + (reg)))
>  
> -#define rd_reg(port, reg) (readb_relaxed(portaddr(port, reg)))
> +static u32 rd_reg(struct uart_port *port, u32 reg)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		return readb_relaxed(portaddr(port, reg));
> +	case UPIO_MEM32:
> +		return readl_relaxed(portaddr(port, reg));
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
>  #define rd_regl(port, reg) (readl_relaxed(portaddr(port, reg)))
>  
> -#define wr_reg(port, reg, val) writeb_relaxed(val, portaddr(port, reg))
> +static void wr_reg(struct uart_port *port, u32 reg, u32 val)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		writeb_relaxed(val, portaddr(port, reg));
> +		break;
> +	case UPIO_MEM32:
> +		writel_relaxed(val, portaddr(port, reg));
> +		break;
> +	}
> +}
> +
>  #define wr_regl(port, reg, val) writel_relaxed(val, portaddr(port, reg))
>  
>  /* Byte-order aware bit setting/clearing functions. */
> @@ -1974,7 +1997,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	struct s3c24xx_uart_port *ourport;
>  	int index = probe_index;
> -	int ret;
> +	int ret, prop = 0;
>  
>  	if (np) {
>  		ret = of_alias_get_id(np, "serial");
> @@ -2000,10 +2023,27 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
>  			dev_get_platdata(&pdev->dev) :
>  			ourport->drv_data->def_cfg;
>  
> -	if (np)
> +	if (np) {
>  		of_property_read_u32(np,
>  			"samsung,uart-fifosize", &ourport->port.fifosize);
>  
> +		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
> +			switch (prop) {
> +			case 1:
> +				ourport->port.iotype = UPIO_MEM;
> +				break;
> +			case 4:
> +				ourport->port.iotype = UPIO_MEM32;
> +				break;
> +			default:
> +				dev_warn(&pdev->dev, "unsupported reg-io-width (%d)\n",
> +						prop);
> +				ret = -EINVAL;
> +				break;
> +			}
> +		}
> +	}
> +
>  	if (ourport->drv_data->fifosize[index])
>  		ourport->port.fifosize = ourport->drv_data->fifosize[index];
>  	else if (ourport->info->fifosize)
> @@ -2587,6 +2627,18 @@ module_platform_driver(samsung_serial_driver);
>   * Early console.
>   */
>  
> +static void wr_reg_barrier(struct uart_port *port, u32 reg, u32 val)
> +{
> +	switch (port->iotype) {
> +	case UPIO_MEM:
> +		writeb(val, portaddr(port, reg));
> +		break;
> +	case UPIO_MEM32:
> +		writel(val, portaddr(port, reg));
> +		break;
> +	}
> +}
> +
>  struct samsung_early_console_data {
>  	u32 txfull_mask;
>  };
> @@ -2612,7 +2664,7 @@ static void samsung_early_putc(struct uart_port *port, int c)
>  	else
>  		samsung_early_busyuart(port);
>  
> -	writeb(c, port->membase + S3C2410_UTXH);
> +	wr_reg_barrier(port, S3C2410_UTXH, c);
>  }
>  
>  static void samsung_early_write(struct console *con, const char *s,
