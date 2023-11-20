Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3B37F0F00
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjKTJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjKTJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:26:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9218E85
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 01:26:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF53C433C9;
        Mon, 20 Nov 2023 09:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700472396;
        bh=aOxpQAtChyjTZEv09tF1ryBfUJPyxBj6YGIQUqKs6tw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=uJU9w/zjkHoV/sLrwdRnJ1BvRC0CNl0GMTEC7BRmOgsWOm0I3np8JThlOAd0qfPIP
         pcpihy954oxJWJ2acLGs5x2XdAG8qFazI+v4ZW715Me6qRkAoc7SwCIRh1mAmbFB1M
         D1Jw4xPsiI9+MeduSR8dxGdFcWdhyBUXYQbLrjnwKgNHUGZfUMBwpoY08ngVOu96Gk
         pSDzEsWMsl/5LcdWGep80gGit+EOLUCQu6HFGR96Fr9kLmD0nCK6i4pzrlNRVrU1yg
         6kSLZC67OZ6XYyh3WaeF21MEAShv++AWktEUA/BHMKltPBOdCncSKDLcOC1dK2Te30
         93Jl0/jKp1/2A==
Message-ID: <3d72e17b-aa8d-4611-996e-4a4adc7a2fdd@kernel.org>
Date:   Mon, 20 Nov 2023 10:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] w1: ds2433: add support for ds28ec20 eeprom
Content-Language: en-US
To:     marc.ferland@gmail.com, krzysztof.kozlowski@linaro.org
Cc:     gregkh@linuxfoundation.org, marc.ferland@sonatest.com,
        jeff.dagenais@gmail.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20231117192909.98944-1-marc.ferland@sonatest.com>
 <20231117192909.98944-6-marc.ferland@sonatest.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20231117192909.98944-6-marc.ferland@sonatest.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2023 20:29, marc.ferland@gmail.com wrote:
> From: Marc Ferland <marc.ferland@sonatest.com>
> 
> The ds28ec20 eeprom is (almost) backward compatible with the
> ds2433. The only major differences are:
> 
> - the eeprom size is now 2560 bytes instead of 512;
> - the number of pages is now 80 (same page size as the ds2433: 256 bits);
> - the programming time has increased from 5ms to 10ms;
> 
> This patch adds support for the ds28ec20 to the ds2433 driver. From
> the datasheet: The DS28EC20 provides a high degree of backward
> compatibility with the DS2433. Besides the different family codes, the
> only protocol change that is required on an existing DS2433
> implementation is a lengthening of the programming duration (tPROG)
> from 5ms to 10ms.
> 
> Tests:
> 
> dmesg now returns:
> 
>     w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000478756 crc e0
> 
> instead of:
> 
>     w1_master_driver w1_bus_master1: Attaching one wire slave 43.000000478756 crc e0
>     w1_master_driver w1_bus_master1: Family 43 for 43.000000478756.e0 is not registered.
> 
> Test script:
> 
>     #!/bin/sh
> 
>     EEPROM=/sys/bus/w1/devices/43-000000478756/eeprom
>     BINFILE1=/home/root/file1.bin
>     BINFILE2=/home/root/file2.bin
> 
>     for BS in 1 2 3 4 8 16 32 64 128 256 512 1024 2560; do
>         dd if=/dev/random of=${BINFILE1} bs=${BS} count=1 status=none
>         dd if=${BINFILE1} of=${EEPROM} status=none
>         dd if=${EEPROM} of=${BINFILE2} bs=${BS} count=1 status=none
>         if ! cmp --silent ${BINFILE1} ${BINFILE2}; then
>     	    echo file1
>     	    hexdump ${BINFILE1}
>     	    echo file2
>     	    hexdump ${BINFILE2}
>     	    echo FAIL
>     	    exit 1
>         fi
>         echo "${BS} OK!"
>     done
> 
> Test results (CONFIG_W1_SLAVE_DS2433_CRC is not set):
> 
>    $ cat /proc/config.gz | gunzip | grep CONFIG_W1_SLAVE_DS2433
>    CONFIG_W1_SLAVE_DS2433=m
>    # CONFIG_W1_SLAVE_DS2433_CRC is not set
> 
>     # ./test.sh
>     1 OK!
>     2 OK!
>     3 OK!
>     4 OK!
>     8 OK!
>     16 OK!
>     32 OK!
>     64 OK!
>     128 OK!
>     256 OK!
>     512 OK!
>     1024 OK!
>     2560 OK!
> 
> Test results (CONFIG_W1_SLAVE_DS2433_CRC=y):
> 
>     $ cat /proc/config.gz | gunzip | grep CONFIG_W1_SLAVE_DS2433
>     CONFIG_W1_SLAVE_DS2433=m
>     CONFIG_W1_SLAVE_DS2433_CRC=y
> 
>     # create a 32 bytes block with a crc, i.e.:
>     00000000  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
>     00000010  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|
> 
>     # fill all 80 blocks
>     $ dd if=test.bin of=/sys/bus/w1/devices/43-000000478756/eeprom bs=32 count=80
> 
>     # read back all blocks, i.e.:
>     $ hexdump -C /sys/bus/w1/devices/43-000000478756/eeprom
>     00000000  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
>     00000010  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|
>     00000020  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
>     00000030  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|
>     ...
>     000009e0  31 32 33 34 35 36 37 38  39 3a 3b 3c 3d 3e 3f 40  |123456789:;<=>?@|
>     000009f0  41 42 43 44 45 46 47 48  49 4a 4b 4c 4d 4e ba 63  |ABCDEFGHIJKLMN.c|
>     00000a00
> 
> Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
> ---
>  drivers/w1/slaves/w1_ds2433.c | 84 +++++++++++++++++++++++++++++++----
>  1 file changed, 75 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_ds2433.c b/drivers/w1/slaves/w1_ds2433.c
> index 04c3eee9e5d7..69bdf3dba573 100644
> --- a/drivers/w1/slaves/w1_ds2433.c
> +++ b/drivers/w1/slaves/w1_ds2433.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - *	w1_ds2433.c - w1 family 23 (DS2433) driver
> + *	w1_ds2433.c - w1 family 23 (DS2433) & 43 (DS28EC20) eeprom driver
>   *
>   * Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
> + * Copyright (c) 2023 Marc Ferland <marc.ferland@sonatest.com>
>   */
>  
>  #include <linux/kernel.h>
> @@ -23,6 +24,7 @@
>  #include <linux/w1.h>
>  
>  #define W1_F23_EEPROM_DS2433	0x23
> +#define W1_F43_EEPROM_DS28EC20	0x43
>  
>  #define W1_PAGE_SIZE		32
>  #define W1_PAGE_BITS		5
> @@ -45,10 +47,16 @@ static const struct ds2433_config config_f23 = {
>  	.tprog = 5,
>  };
>  
> +static const struct ds2433_config config_f43 = {
> +	.eeprom_size = 2560,
> +	.page_count = 80,
> +	.tprog = 10,
> +};
> +
>  struct w1_data {
>  #ifdef CONFIG_W1_SLAVE_DS2433_CRC
> -	u8	*memory;
> -	u32	validcrc;
> +	u8		*memory;
> +	unsigned long	*validcrc;

Why do you change it? This is actually candidate for its own patch with
its own justification (not "groundwork" but a reason why such code is
better).


Best regards,
Krzysztof

