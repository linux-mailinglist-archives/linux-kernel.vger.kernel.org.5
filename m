Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB8D7AAE6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjIVJl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIVJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:41:25 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA1394;
        Fri, 22 Sep 2023 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codethink.co.uk; s=imap4-20230908; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lu0ragu9njIWkwjYInfzfJMShGYH9itXl0arckB59I4=; b=AVK3i7Gnj8vrP3ODfaNSbz2/iT
        5N97Ep3ypZjTKYMj/YOuCPzp1aR+ZtoydUkZ2cBWb9tG34RjTfBlDjMeNV1odS1j6F2GEkQ+VpcS7
        WG7iunBRr5njaBq1AG069VWZtFakknKyAZUTzDghq9xkxcN37LDKioxDSBdENkiQhTKsJvbj4F0ty
        8rwaVproLUfX+QCmlY3/2NUIgEYPJV77ZHnsftrsnUK39FUzOoQxYEyntAimHYTluJXWwX2sk5BlL
        r1qFnUOX4vW9zdKS4zw3As2kyabk2A7mY7KHtaWjMVplRsG7Gcp6NQStaKOSHnnA+WV45VVbNeKE7
        joMqH99A==;
Received: from [134.238.52.102] (helo=[10.8.4.124])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qjcep-00CYxl-Di; Fri, 22 Sep 2023 10:41:07 +0100
Message-ID: <bcdc4623-a37e-455b-8f10-c539e2b04554@codethink.co.uk>
Date:   Fri, 22 Sep 2023 10:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] serial: 8250_dw: Add Sophgo SG2042 support
Content-Language: en-GB
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org, devicetree@vger.kernel.org,
        emil.renner.berthing@canonical.com, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com
Cc:     Chen Wang <wangchen20@iscas.ac.cn>
References: <cover.1695189879.git.wangchen20@iscas.ac.cn>
 <888d57a2d5e62affb8e29e0098402e428facd969.1695189879.git.wangchen20@iscas.ac.cn>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <888d57a2d5e62affb8e29e0098402e428facd969.1695189879.git.wangchen20@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 07:40, Chen Wang wrote:
> From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> 
> Add quirk to skip setting the input clock rate for the uarts on the
> Sophgo SG2042 SoC similar to the StarFive JH7100.

I'd love an actual explanation of why this is necessary here.

> 
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Chen Wang <wangchen20@iscas.ac.cn>
> ---
>   drivers/tty/serial/8250/8250_dw.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
> index f4cafca1a7da..6c344877a07f 100644
> --- a/drivers/tty/serial/8250/8250_dw.c
> +++ b/drivers/tty/serial/8250/8250_dw.c
> @@ -770,7 +770,7 @@ static const struct dw8250_platform_data dw8250_renesas_rzn1_data = {
>   	.quirks = DW_UART_QUIRK_IS_DMA_FC,
>   };
>   
> -static const struct dw8250_platform_data dw8250_starfive_jh7100_data = {
> +static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
>   	.usr_reg = DW_UART_USR,
>   	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
>   };
> @@ -780,7 +780,8 @@ static const struct of_device_id dw8250_of_match[] = {
>   	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
>   	{ .compatible = "marvell,armada-38x-uart", .data = &dw8250_armada_38x_data },
>   	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
> -	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_starfive_jh7100_data },
> +	{ .compatible = "sophgo,sg2042-uart", .data = &dw8250_skip_set_rate_data },
> +	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
>   	{ /* Sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, dw8250_of_match);

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

