Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D37E2E66
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjKFUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFUqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:46:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C92910A;
        Mon,  6 Nov 2023 12:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hSnj/mFuGgrQUOLsjQk08q0jexZjMGNOYi/PaMiXeoA=; b=Y9KimkO3wL+3x+Eqdi9EOLe1W3
        bBWlN3hF8iV1zhnGhz4DYE/aUButatnO4bdWGhkWIWU5w3WVjwwFYlR94yIgZXpBg+y83WWqOA29h
        jwctEylS6lX0w1+UtLrtu5Chyx7P1Erd/ywIwUIZm0HQTZOeBhuccrIaryO0Qfz9hxHml6oSfzsWX
        3KVL37f0IJMWLC1GOj1YPqAee83K2DDJDVHKfRpuxdXYxxNHUyDBwTH/Yt2eNH9BuB+6450Msrd8i
        Rt8ora+9RKyJmP/TVrv4FRPO2wY8cfQCqcbtoALwgqW8wfGzVKWoo9+z0BrZqW4ZWuMabOnyNXx1d
        JaqqttpQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r06Tq-00HWwj-2B;
        Mon, 06 Nov 2023 20:45:54 +0000
Message-ID: <dc85784d-c96c-45a4-bbfa-036f535b048f@infradead.org>
Date:   Mon, 6 Nov 2023 12:45:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: serial: uartlite: Document uartlite_data in
 kernel-doc style
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>,
        kernel test robot <yujie.liu@intel.com>
References: <20231106152428.3641883-1-sean.anderson@seco.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231106152428.3641883-1-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/23 07:24, Sean Anderson wrote:
> Use @ and - to conform with kernel-doc style.
> 
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

Greg will probably just wait to apply it sometime after the current
merge window closes. At least that's been my experience.

> ---
> I have no idea what phase of release the kernel is in. If it is too
> late/early in the cycle, please just review this at the appropriate
> time. This patch is unlikely to need rebasing, and I am unlikely to
> remember to send it later.
> 
>  drivers/tty/serial/uartlite.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
> index 404c14acafa5..e586d7aeac98 100644
> --- a/drivers/tty/serial/uartlite.c
> +++ b/drivers/tty/serial/uartlite.c
> @@ -62,11 +62,11 @@ static struct uart_port *console_port;
>  #endif
>  
>  /**
> - * struct uartlite_data: Driver private data
> - * reg_ops: Functions to read/write registers
> - * clk: Our parent clock, if present
> - * baud: The baud rate configured when this device was synthesized
> - * cflags: The cflags for parity and data bits
> + * struct uartlite_data - Driver private data
> + * @reg_ops: Functions to read/write registers
> + * @clk: Our parent clock, if present
> + * @baud: The baud rate configured when this device was synthesized
> + * @cflags: The cflags for parity and data bits
>   */
>  struct uartlite_data {
>  	const struct uartlite_reg_ops *reg_ops;

-- 
~Randy
