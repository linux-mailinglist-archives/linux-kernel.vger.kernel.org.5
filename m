Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C5576A85D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 07:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjHAFb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 01:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjHAFbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 01:31:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AC81FEE;
        Mon, 31 Jul 2023 22:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=YWQyeeI0dgsh9BoI95IqY8St3ayAwC7ynd//yjkbluY=; b=NEUe+kUpvAtG16P/9InHgKqGu0
        AUYOLe/g7IFU13jJhhKVjGx5N7NhOwLG0DKs+u3ElqFarhHQOlC3sDbxvHYCYgRljZDhd2/QRk86p
        C8d4VTR4hOlS737/1hktRsUUiruqWBNrIcObkr1rhZn4T0btVs3d/a90Lh/Wx13KLd6JRKlAVMP4W
        wngb5eo1UiZQ4qr51Ufjct0uZRG8QbfiHh0cySGybspscck6ssCqW/XaknVdbwVMrp/skdf8NFanF
        izTnWvKmTZEB+OsirvvUlZHj1gNnzxxmP92wCLGfjMhxElJjd8lfQDpKA572TAnFwgoe+00QSKgHX
        VLprpXJA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQhyF-000OHn-0y;
        Tue, 01 Aug 2023 05:30:59 +0000
Message-ID: <58f88e11-9292-5eca-a4d6-e72d4124078a@infradead.org>
Date:   Mon, 31 Jul 2023 22:30:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Documentation: devices.txt: reconcile serial/ucc_uart
 minor numers
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Timur Tabi <timur@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Kumar Gala <galak@kernel.crashing.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20230724063341.28198-1-rdunlap@infradead.org>
 <dc334e93-1487-8058-195d-e90db7bdb53f@csgroup.eu>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <dc334e93-1487-8058-195d-e90db7bdb53f@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 7/31/23 22:21, Christophe Leroy wrote:
> 
> 
> Le 24/07/2023 à 08:33, Randy Dunlap a écrit :
>> Reconcile devices.txt with serial/ucc_uart.c regarding device number
>> assignments. ucc_uart.c supports 4 ports and uses minor devnums
>> 46-49, so update devices.txt with that info.
>> Then update ucc_uart.c's reference to the location of the devices.txt
>> list in the kernel source tree.
> 
> Devices ttyCPM* belong to cpm_uart driver. As explained in the comment 
> you have modified in UCC uart driver, UCC uart borrows those devices and 
> shall not be considered as the reference. But the lines you modify in 
> device.txt doesn't mention QE UCC, it mentions CPM SCC and CPM SMC.
> 
> CPM uart driver supports up to 6 ports (4 SCC and 2 SMC).
> 

Thank you for replying.

Does this mean that the patch should be reverted?

> On one of my boards which has a powerpc mpc866 CPU, I have:
> 
> [    2.393872] ff000a80.serial: ttyCPM0 at MMIO 0xfff00a80 (irq = 19, 
> base_baud = 8250000) is a CPM UART
> [    2.411899] ff000a90.serial: ttyCPM1 at MMIO 0xfff00a90 (irq = 20, 
> base_baud = 8250000) is a CPM UART
> [    2.430352] ff000a00.serial: ttyCPM2 at MMIO 0xfff00a00 (irq = 30, 
> base_baud = 8250000) is a CPM UART
> [    2.448944] ff000a20.serial: ttyCPM3 at MMIO 0xfff00a20 (irq = 29, 
> base_baud = 8250000) is a CPM UART
> [    2.467435] ff000a40.serial: ttyCPM4 at MMIO 0xfff00a40 (irq = 28, 
> base_baud = 8250000) is a CPM UART
> [    2.485924] ff000a60.serial: ttyCPM5 at MMIO 0xfff00a60 (irq = 27, 
> base_baud = 8250000) is a CPM UART
> 
> # ll /dev/ttyCPM*
> crw-------    1 root     root      204,  46 Jan  1 01:01 /dev/ttyCPM0
> crw-------    1 root     root      204,  47 Jan  1 01:00 /dev/ttyCPM1
> crw-------    1 root     root      204,  48 Jan  1 01:00 /dev/ttyCPM2
> crw-------    1 root     root      204,  49 Jan  1 01:00 /dev/ttyCPM3
> crw-------    1 root     root      204,  50 Jan  1 01:00 /dev/ttyCPM4
> crw-------    1 root     root      204,  51 Jan  1 01:00 /dev/ttyCPM5

I don't see minors 50-51 allocated in devices.txt for use by this device/driver.
Am I overlooking that allocation somewhere?

Thanks for your help.

> 
> # cat /proc/tty/drivers
> /dev/tty             /dev/tty        5       0 system:/dev/tty
> /dev/console         /dev/console    5       1 system:console
> /dev/ptmx            /dev/ptmx       5       2 system
> ttyCPM               /dev/ttyCPM   204 46-51 serial
> pty_slave            /dev/pts      136 0-1048575 pty:slave
> pty_master           /dev/ptm      128 0-1048575 pty:master
> pty_slave            /dev/ttyp       3 0-4 pty:slave
> pty_master           /dev/pty        2 0-4 pty:master
> 
> Christophe
> 
> 
>>
>> Fixes: d7584ed2b994 ("[POWERPC] qe-uart: add support for Freescale QUICCEngine UART")
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Timur Tabi <timur@kernel.org>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: linux-serial@vger.kernel.org
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> ---
>>   Documentation/admin-guide/devices.txt |    2 +-
>>   drivers/tty/serial/ucc_uart.c         |    2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff -- a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
>> --- a/drivers/tty/serial/ucc_uart.c
>> +++ b/drivers/tty/serial/ucc_uart.c
>> @@ -59,7 +59,7 @@ static int firmware_loaded;
>>   /* #define LOOPBACK */
>>   
>>   /* The major and minor device numbers are defined in
>> - * http://www.lanana.org/docs/device-list/devices-2.6+.txt.  For the QE
>> + * Documentation/admin-guide/devices.txt.  For the QE
>>    * UART, we have major number 204 and minor numbers 46 - 49, which are the
>>    * same as for the CPM2.  This decision was made because no Freescale part
>>    * has both a CPM and a QE.
>> diff -- a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
>> --- a/Documentation/admin-guide/devices.txt
>> +++ b/Documentation/admin-guide/devices.txt
>> @@ -2691,7 +2691,7 @@
>>   		 45 = /dev/ttyMM1		Marvell MPSC - port 1 (obsolete unused)
>>   		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
>>   		    ...
>> -		 47 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
>> +		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 3
>>   		 50 = /dev/ttyIOC0		Altix serial card
>>   		    ...
>>   		 81 = /dev/ttyIOC31		Altix serial card

-- 
~Randy
