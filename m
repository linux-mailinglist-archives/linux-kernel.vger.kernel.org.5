Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EBD774901
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjHHTq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbjHHTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:46:06 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DBF4A044;
        Tue,  8 Aug 2023 09:50:23 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686e0213c0bso4253024b3a.1;
        Tue, 08 Aug 2023 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513422; x=1692118222;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m86pfXXuQMAMRz51pUxOAytG4Ja5agUvJe7SSaobTsg=;
        b=lbfB0HwgDOICfiD5Jx2dkcibdBn+BBpeqM+H7RPgRY7cOdP26E6zPQQ/VzPdtli3Rs
         H8w9FmyUeXjNXMVSuBwJhXEMVH/hWu8C6ivoumSXYOcEdxCGtQri1jpZhcf3PVCoMEI1
         8fWiHdHnnrduzt9GRtvZTs/6VicmpvNtp03t+a463gRi33+3jnBMaJPoxjAFxMaBT7/L
         aFhfeDd/ISRwUsDu8gnfocajpdroNsI0ihXQDqjN7bRi9SpbQdtuVmDjPt6W5L1kygFe
         oc2wap/sNggfuHJSdB8rVwlThAl5+6mQ64Of3dAhYaiA/Z2+P3VEtDXZtKZnUnvTdUMV
         t1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513422; x=1692118222;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m86pfXXuQMAMRz51pUxOAytG4Ja5agUvJe7SSaobTsg=;
        b=fwXTYNG1VgDfihfZO3Ho76o+VaHB4UIbHDujYrTtk0fjr0hevs+w3vxOLkPH5Ec4Bw
         JuQ4thAQ+S1YqAPY7vMfDPwzhFc0L49UnM/hjdOmsagxPm7CjDRzg0o989XMnMJbRrhb
         38AO8nam7jUN4NGRdKBpEtkT2ZAZRjdsXjfrlucm0LKSCExVaEj6gnWDbC5x8RgHg6nt
         JRfvF2FLyGjt9UdkAYj7IgQoQZuuzPB9XFg+EB8OeRbWNOjpXZ8PE+U83k5BBH+3mwRN
         f7Tk0/Xp2bExh7+koM6/lDHz0+fc1GtkouZFCrp/wrnZrHRTV9xWBnnLLSFqg3OKJFkH
         KtIA==
X-Gm-Message-State: AOJu0Yx/Bd6IzmwhgTbHrU+5P1DnzP1BBXpSeosVg1JZNJqRMlqVsQ0R
        FJDajfO+E+g2nrbHH/DQr/O4ndMRgG8=
X-Google-Smtp-Source: AGHT+IExw3PsoAFt7iUN1CtlVmtBWxSm6CiZ27g8sCTwbosvnsXuzLew22DanAUYdLPQltuAGYVbjQ==
X-Received: by 2002:a17:902:c409:b0:1bc:5b36:a2df with SMTP id k9-20020a170902c40900b001bc5b36a2dfmr8343835plk.1.1691502291367;
        Tue, 08 Aug 2023 06:44:51 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id z11-20020a170902ee0b00b001bb7a736b4csm9066071plb.77.2023.08.08.06.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 06:44:50 -0700 (PDT)
Message-ID: <97224321-c839-c0a7-52dd-3fb6e52fc15e@gmail.com>
Date:   Tue, 8 Aug 2023 20:44:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        TatriX <tatrics@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Bluetooth LE scan doesn't show device name
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> Hi!
> At some point after kernel 5.9 I started having issues with LE device scanning.
> Here's how it used to work:
> 
>     $ bluetoothctl
>     # power on
>     # scan on
>      ...
>     [NEW] Device 68:71:DD:73:97:D5 Playfinity-2
> 
> It successfully finds my device and it's name.
> On a newer kernel instead I'm getting no name:
> 
>     [NEW] Device 4D:18:19:A8:63:B5 4D-18-19-A8-63-B5
> 
> Here's corresponding btmon logs. First from kernel 5.9.12 that can see device's name:
> 
> ```5.9.12
>> HCI Event: LE Meta Event (0x3e) plen 33                  #118 [hci0] 5.607028
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x0013
>             Props: 0x0013
>               Connectable
>               Scannable
>               Use legacy advertising PDUs
>             Data status:  [0;32mComplete [0m
>           Legacy PDU Type: ADV_IND (0x0013)
>           Address type: Random (0x01)
>           Address: 68:71:DD:73:97:D5 (Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: No packets
>           SID: no ADI field (0xff)
>           TX power: 127 dBm
>           RSSI: -54 dBm (0xca)
>           Periodic advertising interval: 0.00 msec (0x0000)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x07
>         02 01 06 03 02 f0 ff                             .......
>         Flags: 0x06
>           LE General Discoverable Mode
>           BR/EDR Not Supported
>         16-bit Service UUIDs (partial): 1 entry
>           Unknown (0xfff0)
>> HCI Event: LE Meta Event (0x3e) plen 49                  #119 [hci0] 5.608029
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x001b
>             Props: 0x001b
>               Connectable
>               Scannable
>               Scan response
>               Use legacy advertising PDUs
>             Data status:  [0;32mComplete [0m
>           Legacy PDU Type: SCAN_RSP to an ADV_SCAN_IND (0x001b)
>           Address type: Random (0x01)
>           Address: 68:71:DD:73:97:D5 (Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: No packets
>           SID: no ADI field (0xff)
>           TX power: 127 dBm
>           RSSI: -54 dBm (0xca)
>           Periodic advertising interval: 0.00 msec (0x0000)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x17
>         0d 09 50 6c 61 79 66 69 6e 69 74 79 2d 32 02 0a  ..Playfinity-2..
>         00 05 12 50 00 68 00                             ...P.h.
>         Name (complete): Playfinity-2
>         TX power: 0 dBm
>         Peripheral Conn. Interval: 0x0050 - 0x0068
> ```
> 
> And from 6.4.8:
> 
> ```6.4.8
>> HCI Event: LE Meta Event (0x3e) plen 33                  #130 [hci0] 9.180207
>       LE Extended Advertising Report (0x0d)
>         Num reports: 1
>         Entry 0
>           Event type: 0x0013
>             Props: 0x0013
>               Connectable
>               Scannable
>               Use legacy advertising PDUs
>             Data status: �[0;32mComplete�[0m
>           Legacy PDU Type: ADV_IND (0x0013)
>           Address type: Random (0x01)
>           Address: 4D:18:19:A8:63:B5 (Resolvable)
>           Primary PHY: LE 1M
>           Secondary PHY: No packets
>           SID: no ADI field (0xff)
>           TX power: 127 dBm
>           RSSI: -53 dBm (0xcb)
>           Periodic advertising interval: 0.00 msec (0x0000)
>           Direct address type: Public (0x00)
>           Direct address: 00:00:00:00:00:00 (OUI 00-00-00)
>           Data length: 0x07
>         02 01 06 03 02 f0 ff                             .......
>         Flags: 0x06
>           LE General Discoverable Mode
>           BR/EDR Not Supported
>         16-bit Service UUIDs (partial): 1 entry
>           Unknown (0xfff0)
> ```
> 
> I've tried compiling 5.9.12 to see if I can bissect, but it fails to compile with gcc12..
> 
> Is it expected that newer kernels can't get device name? Perhaps some additional action is needed fetch it?
>  
> Thanks!

See Bugzilla for the full thread.

TatriX: Can you also attach dmesg output to your Bugzilla report?
Since you also have kernel build problem, can you also attach build
log (``make 2>&1 | tee build.log``)?

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v5.9..v6.4 https://bugzilla.kernel.org/show_bug.cgi?id=217773

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217773

-- 
An old man doll... just what I always wanted! - Clara
