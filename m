Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD897F9BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjK0Inm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbjK0Ini (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:43:38 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE3E10A;
        Mon, 27 Nov 2023 00:43:44 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a00cbb83c82so559603466b.2;
        Mon, 27 Nov 2023 00:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074623; x=1701679423;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13zvKBfMrPslSyZ9A5WHGuAiqVWAS+FTL0vv/kasVbY=;
        b=GTqlbA3fGzpPeGGo7CF/sV6fliM0mQJAwTBFAlcmNfz+bNTLMERTq8hqNKchNkOKoi
         JTvY+Y7YDwz9pV7bb3wbjxCg8pmV+pafHjAKvM1035Y7iSB6gpCNB/MZwPBn/mnwmuUR
         ksArPTPrHH92f6tzlbLW/JalbpvH1ncXu+go7M7Fu85N1/eWWLzUUD/oAxVmRxxuvKfE
         qb2ZElxUkhqFbWZqpiZQX8UtyQ6EsLIoLOo8G3WZrXjf6n2oSEC+TkPPZlXEcafLmjtf
         iVVt3cBRCCOZKkkMdPgCV66DR6IR4lhZZw2W+wqrEc+IuikGEIIPrE2ceJzGPhY38rsk
         bd1Q==
X-Gm-Message-State: AOJu0YzGzP4nqGyi8Mphrm/hiJDZ9Byc/kVO99dil99FUg9NO1HiOqXb
        f4LaDQtF7VVktLOuto/Efws=
X-Google-Smtp-Source: AGHT+IEi7NuhXNIr1gkwQXoSxGvS3qTNKp2jgt8pi1t44qCcRzFMp9abBebhwO5iYRMVKiZLDY+2mQ==
X-Received: by 2002:a17:906:99c7:b0:9ba:65e:7529 with SMTP id s7-20020a17090699c700b009ba065e7529mr9842163ejn.68.1701074622816;
        Mon, 27 Nov 2023 00:43:42 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id o11-20020a17090611cb00b00a0173cfaab6sm5415374eja.44.2023.11.27.00.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:43:42 -0800 (PST)
Message-ID: <087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org>
Date:   Mon, 27 Nov 2023 09:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING around serdev/bt/btnxpuart with 6.7-rc2
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Neeraj Kale <neeraj.sanjaykale@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <ZWEIhcUXfutb5SY6@francesco-nb.int.toradex.com>
 <ZWI4gMCoY_YzcH7f@livingston.pivistrello.it>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <ZWI4gMCoY_YzcH7f@livingston.pivistrello.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 11. 23, 19:10, Francesco Dolcini wrote:
> On Fri, Nov 24, 2023 at 09:33:09PM +0100, Francesco Dolcini wrote:
>> Hello all,
>> while doing some test with current [1] Linux mainline I randomly hit a
>> warning. It is not systematic and I cannot really tell when
>> it was introduced, posting here to collect some ideas.
>>
>> Amitkumar, Neeraj: to me the issue is around the bluetooth/btnxpuart
>> driver, however I could also be plain wrong.
>>
>> The issue was reproduced on a Toradex Verdin AM62 [2] that is based on a TI
>> AM625 SOC (arm64) running with a arm64 defconfig and built with GCC 9 [3].
>>
>> [    9.599027] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>> [    9.962266] Bluetooth: hci0: Frame reassembly failed (-84)
>> [    9.972939] ------------[ cut here ]------------
>> [    9.977922] serial serial0: receive_buf returns -84 (count = 6)
>> [    9.994857] WARNING: CPU: 0 PID: 37 at drivers/tty/serdev/serdev-ttyport.c:37 ttyport_receive_buf+0xd8/0xf8
>> [   10.004840] Modules linked in: mwifiex_sdio(+) mwifiex snd_soc_simple_card crct10dif_ce cfg80211 snd_soc_simple_card_utils k3_j72xx_bandgap rti_wdt rtc_ti_k3 btnxpuart bluetooth sa2ul ecdh_generic ecc sha256_generic tidss rfkill libsha256 drm_dma_helper snd_soc_davinci_mcasp authenc omap_mailbox snd_soc_ti_udma snd_soc_ti_edma snd_soc_ti_sdma atmel_mxt_ts ina2xx snd_soc_nau8822 ti_sn65dsi83 tc358768 ti_ads1015 tps65219_pwrbutton at24 m_can_platform industrialio_triggered_buffer drm_kms_helper m_can kfifo_buf rtc_ds1307 lm75 pwm_tiehrpwm can_dev spi_omap2_mcspi panel_lvds pwm_bl libcomposite fuse drm backlight ipv6
>> [   10.059984] CPU: 0 PID: 37 Comm: kworker/u4:2 Not tainted 6.7.0-rc2-00147-gf1a09972a45a #1
>> [   10.071793] Hardware name: Toradex Verdin AM62 WB on Verdin Development Board (DT)
>> [   10.082898] Workqueue: events_unbound flush_to_ldisc
>> [   10.091345] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [   10.101820] pc : ttyport_receive_buf+0xd8/0xf8
>> [   10.109712] lr : ttyport_receive_buf+0xd8/0xf8
>> [   10.117581] sp : ffff800082b9bd20
>> [   10.124202] x29: ffff800082b9bd20 x28: ffff00000000ee05 x27: ffff0000002f21c0
>> [   10.134735] x26: ffff000002931820 x25: 61c8864680b583eb x24: ffff0000002f21b8
>> [   10.145209] x23: ffff00000026e740 x22: ffff0000002f21e0 x21: ffffffffffffffac
>> [   10.155686] x20: ffff000000da5c00 x19: 0000000000000006 x18: 0000000000000000
>> [   10.166178] x17: ffff7fffbe0e7000 x16: ffff800080000000 x15: 000039966db1c650
>> [   10.176564] x14: 000000000000022c x13: 000000000000022c x12: 0000000000000000
>> [   10.186979] x11: 000000000000000a x10: 0000000000000a60 x9 : ffff800082b9bb80
>> [   10.197352] x8 : ffff00000026f200 x7 : ffff00003fd90080 x6 : 00000000000022e5
>> [   10.207680] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 : ffff7fffbe0e7000
>> [   10.218051] x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000000
>> [   10.228393] Call trace:
>> [   10.233989]  ttyport_receive_buf+0xd8/0xf8
>> [   10.241224]  flush_to_ldisc+0xbc/0x1a4
>> [   10.248117]  process_scheduled_works+0x16c/0x28c
>> [   10.255851]  worker_thread+0x16c/0x2e0
>> [   10.262673]  kthread+0x11c/0x128
>> [   10.268953]  ret_from_fork+0x10/0x20
>> [   10.275460] ---[ end trace 0000000000000000 ]---
>> [   10.294674] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   10.461657] Bluetooth: hci0: Frame reassembly failed (-84)
>> [   10.472025] Bluetooth: hci0: Frame reassembly failed (-84)
> 
> I think that what is happening is the following:
> 
>   -> serdev-ttyport.c:ttyport_receive_buf()
>     -> btnxpuart.c:btnxpuart_receive_buf()
>        -> h4_recv_buf() errors out
>        -> return -84
>     -> warn because ret is <0
> 
> Is this the desired behavior? If I understand correct recv_buf() is supposed to
> return how many bytes it has consumed, e.g. something from 0 to count.

You understand it correctly. serdev should adopt:
commit 0468a8071d7cfb0f5bc02b0888cec4525551299f
Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Date:   Thu Aug 10 11:14:44 2023 +0200

     tty: make counts in tty_port_client_operations hooks size_t

and propagate it further to its users. The commit was meant to exactly 
avoid these mistakes (but one layer upper).

btmtkuart_receive_buf is broken the same way.

Do you want to fix it yourself?

thanks,
-- 
js
suse labs

