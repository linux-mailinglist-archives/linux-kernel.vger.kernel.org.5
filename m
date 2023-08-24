Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2A5786D29
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 12:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240875AbjHXKww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 06:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbjHXKwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 06:52:25 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC1219A2;
        Thu, 24 Aug 2023 03:52:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-565334377d0so4605087a12.2;
        Thu, 24 Aug 2023 03:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692874339; x=1693479139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d7nxjeS3WZdw5LaFifW0FnOpPpqfiReWalyBVKERMWI=;
        b=ZAJY4arpvZW+lXJXdLpnGRLbb+4/rlQUOVmhfIWKBxOyBfvCMoZdxEa6VA8CnUqq2P
         qMOPo+WeShVWRYMwoDphUtRN0JrPsSZfHOz10M8z+hcUp4FE7YldQirjQVqWYTHpvjsh
         jyhf5o/4omKrsVc2iewf+u28lluF4QMY38KhnOuXXSkeOumUH/6ixCzGYwMtTwGrUaSS
         8DTMEohbykpWxdrC3YDTtjOylNBrndGPJDgGFtRhE2Ee40dLhEadSHfyBgmlaWuVz8WH
         B8BoXf7NY/dPaburrW7c9je/BNFL8NmKSqBtcoCFY9zwK3YaMXXJsyEDl1edqJfLuPRD
         Og3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692874339; x=1693479139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d7nxjeS3WZdw5LaFifW0FnOpPpqfiReWalyBVKERMWI=;
        b=YjTeFQ6n339bCo2JwzHbCc5U4kHclYoWnLOUSd/Slp0hQBQY7QdEjU3NwQ4vfcwlN2
         LyPrfpMwCPk20c8asXI8sXxwwGBUo+3n6tl4eqVB5CfGznqKbvPDP4g0VbLjqiUXnv1H
         5IcsiPERhvFwqlC0KJzHy3dvLBF5coO9e1Fx7pywJiMCgBosPvJg46DbwtlNTh2tIJXJ
         kQauCQmHZxGS2gl7pImt1PbVF/+r8Gx3DjpXQH2FGZBKh2zuvuLGwpRudGeMyCMfTrQh
         RwN6vZ1++baWGjjf+V/m5vHSNMYy1eLCGezywut5ddy8WfkuC6RrmcH5BlDLz8JinyUg
         Sllw==
X-Gm-Message-State: AOJu0Yx4Mr3QsfpMXNaelroS9jS8TCJLerC4TG+fPzsdg293wYzECWbs
        JyH0fZvnkTYmVmC+QMLiL3Y=
X-Google-Smtp-Source: AGHT+IEoJwQzgfRgxl+6DVfSVQzok7+JyAKrTEwiXy/GdImmlHw6WjFoJPvm7/EZ/xFH4TbtGZK1vg==
X-Received: by 2002:a17:90a:e28d:b0:26d:43f0:7ce4 with SMTP id d13-20020a17090ae28d00b0026d43f07ce4mr14434458pjz.8.1692874338373;
        Thu, 24 Aug 2023 03:52:18 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090ae00400b00262d079720bsm1302511pjy.29.2023.08.24.03.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:52:17 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     Niklas.Cassel@wdc.com, dlemoal@kernel.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
Subject: Re: Re: [PATCH] ahci: libahci: clear pending interrupt status
Date:   Thu, 24 Aug 2023 18:51:59 +0800
Message-Id: <20230824105159.12384-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/22/23 16:41, Niklas Cassel wrote: 
>
>On Mon, Aug 14, 2023 at 12:17:20PM +0800, Szuying Chen wrote:
>> On 8/10/23 17:59, Damien Le Moal wrote: 
>> >On 8/10/23 18:31, Szuying Chen wrote:
>> >>> On 8/10/23 14:12, Damien Le Moal wrote: 
>> >>>    On 8/10/23 14:05, Szuying Chen wrote:
>> >>>    > When ISR handle interface fatal error with error recovery after clear PxIS
>> >>>    > and PxIE. Another FIS(SDB FIS with err) that set PxIS.IFS to 1 is recevied
>> >>>    > during error recovery, which causing the HBA not issue any new commands
>> >>>    > after cmd.ST set 1.
>> >>>
>> >>>    This is not very clear. If there was a fatal error, the drive should be in
>> >>>    error state and no other SDB FIS can be received as the drive does absolutely
>> >>>    nothing while in error state (it only waits for a read log 10h command to be>
>> >>>    issued to get it out of error state). So if you are seeing 2 SDB FIS with
>> >>>    errors one after the other, you have a buggy device...
>> >>>
>> >>>    However, I may be misunderstanding your issue here. Could you provide more
>> >>>    details and a dmesg output example of the issue ?
>> >> 
>> >> According to AHCI 1.3.1 specification ch6.1.9, when an R_ERR is 
>> >> received on an H2D Data FIS in normal operation, the HBA sets 
>> >> PxIS.IFS to 1 (fatal error) and halts operation. Referring to SATA 
>> >> 3.0 specification we know the device will halt queued command 
>> >> processing and transmit SDB FIS to host with ERR bit in Status field set to one(set PxIS.TFES to 1).
>> >
>> >Sure, but that SBD FIS should be completely ignored by the adapter 
>> >since it stopped operation. If you see it, then it means that the 
>> >handling of the first error was incomplete.
>> >
>> The SDB FIS  happens between pxIS.IE was cleared and PxCMD.ST not 
>> cleared to 0. Because the PxCMD.ST still setting, so the SDB FIS can't ignored.
>> 
>> >> In our case, the ISR handles fatal errors(PxIS.IFS) and enters 
>> >> error recovery after cleaning up PxIS and PxIE. Then a SDB FIS is 
>> >> received with interrupt bit(PxIS.TFES) set to 1. According to AHCI 
>> >> 1.3.1 specification ch6.2.2, HBA can't issue(cmd.ST set to 1) any 
>> >> new commands under PxIS.TFES alive during error recovery.
>> >
>> >But how come you see a new command being issued ? This entire 
>> >situation should result in a port reset with the first error. I do not see how this is possible.
>> >Are you saying that the port reset is not cleaning things up properly 
>> >? Could you share the dmesg output of this case ?
>> >
>> >
>> dmesg:
>> [  654.244958] nouveau 0000:09:00.0: AMD-Vi: Event logged 
>> [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  654.460522] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  656.180375] ata7.00: 
>> exception Emask 0x10 SAct 0x7c0 SErr 0x200100
>
>Hello Szuying Chen,
>
>From your logs we can see that SErr 0x200100:
>This means that PxSERR.DIAG.C was set.
>
>This means that:
>"Calculated Different CRC than Received: When this occurs, the HBA returns R_ERR and returns to idle."
>
>(Since PxIS.IFS is set, we know that it was a D2H Data FIS that had invalid CRC. (If it was a D2H non-Data FIS PxIS.INFS would have been set instead.))
>
>
>So your commit message is wrong. In your case it is the HBA that sends a R_ERR to the device, so you should look at "6.1.10 CRC error in received FIS" and not "6.1.9 Device responds to FIS with R_ERR".
>
>"When a CRC error occurs on a D2H Data FIS, the HBA sets PxIS.IFS to ‘1’.
>After a CRC error on a D2H Data FIS, the device may send a D2H Register FIS to indicate the reason for the error. The host should allow posting of non-Data FISes before PxCMD.ST is cleared to ‘0’."
>
>Looking at the state machine "5.3.11.2 DR:Receive" you will jump to state ERR:Fatal. (Meaning that we need to clear PxCMD.ST in order to issue new
>commands.)
>
>
>The HBA should this trigger an error irq when noticing the bad CRC.
>
>It is possible that the HBA triggers another error IRQ when receiving a D2H with TFES bit set, if it is received before PxCMD.ST is cleared to 0, see NDR:Accept:
>FIS Type is D2H Register and PxCMD.ST=0, jump to P:RegFISUpdate, which does not trigger any IRQ.
>If PxCMD.ST is set, the state machine will instead jump to RegFIS:Entry.
>
>
>So, in order to understand what is going on, can you please add unconditional prints in ahci_error_intr(), so we can actually see how many times this is called. (Right now it seems to only be called once). Please also print when PxCMD.ST is cleared to 0.
>(So that we can verify that ahci_error_intr() is never called after that). Also please remove all prints from other drivers, e.g. nouveau.
>
>
>Kind regards,
>Niklas
>
>
Hi Niklas,

In our case, receiving D2H with TFES bit set(PxIS.TFES set to 1) doesn't
triggers aother error IRQ before PxCMD.ST is cleared. Because IRQ was 
turn off(PxIE=0).

After received D2H with TFES bit set, port is restart(clearing PxCMD.ST to 
'0' and then setting PxCMD.ST to '1').In the dmesg output, device is lose 
after the port restart 3 times. Durring this time, the TFES bit was not 
cleared.

The Linux kernel dmesg output as shown below:
 [   40.251795] ahci_error_intr start (irq_stat 0x08000000) ****
[   40.251799] ahci_error_intr: interface fatal error
[   40.251800] ahci_error_intr: freeze (set pxIE to 0)
[   40.251805] ahci_error_intr end (PORT_IRQ_MASK = 0x00000000 )****
[   40.298113] ata8.00: exception Emask 0x10 SAct 0x70e000 SErr 0x280100 
action 0x6 frozen
[   40.298117] ata8.00: irq_stat 0x08000000, interface fatal error
[   40.298119] ata8: SError: { UnrecovData 10B8B BadCRC }
[   40.298121] ata8.00: failed command: READ FPDMA QUEUED
[   40.298122] ata8.00: cmd 60/b8:68:c0:c3:03/08:00:00:00:00/40 tag 13 
ncq dma 1142784 in
         res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[   40.298126] ata8.00: status: { DRDY }
[   40.298128] ata8.00: failed command: READ FPDMA QUEUED
[   40.298129] ata8.00: cmd 60/b8:70:78:cc:03/05:00:00:00:00/40 tag 14 
ncq dma 749568 in
         res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[   40.298132] ata8.00: status: { DRDY }
[   40.298133] ata8.00: failed command: READ FPDMA QUEUED
[   40.298134] ata8.00: cmd 60/00:78:30:d2:03/0a:00:00:00:00/40 tag 15 
ncq dma 1310720 in
         res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[   40.298137] ata8.00: status: { DRDY }
[   40.298138] ata8.00: failed command: READ FPDMA QUEUED
[   40.298139] ata8.00: cmd 60/00:a0:30:dc:03/0a:00:00:00:00/40 tag 20 
ncq dma 1310720 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[   40.298142] ata8.00: status: { DRDY }
[   40.298143] ata8.00: failed command: READ FPDMA QUEUED
[   40.298144] ata8.00: cmd 60/40:a8:30:e6:03/08:00:00:00:00/40 tag 21 
ncq dma 1081344 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[   40.298147] ata8.00: status: { DRDY }
[   40.298148] ata8.00: failed command: READ FPDMA QUEUED
[   40.298149] ata8.00: cmd 60/90:b0:70:ee:03/09:00:00:00:00/40 tag 22 
ncq dma 1253376 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[   40.298151] ata8.00: status: { DRDY }
[   40.298154] ata8: hard resetting link
[   40.298155] ata8: ahci_hardreset *****
[   40.298160] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004d517) 
[   40.298166] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   40.298167] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   40.608009] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   40.608031] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   40.608041] ata8: ahci_softreset *****
[   40.608049] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   40.608059] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   40.608064] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   40.608069] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   40.608079] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   50.199215] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   50.199236] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   50.199242] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   50.199254] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   50.199264] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   50.199269] ata8: softreset failed (1st FIS failed)
[   50.199278] ata8: hard resetting link
[   50.199283] ata8: ahci_hardreset *****
[   50.199289] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   50.199298] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   50.199302] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   50.514443] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   50.514464] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   50.514474] ata8: ahci_softreset *****
[   50.514482] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   50.514492] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   50.514496] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   50.514502] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   50.514511] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   60.173000] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   60.173020] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   60.173026] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   60.173038] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   60.173048] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   60.173053] ata8: softreset failed (1st FIS failed)
[   60.173063] ata8: hard resetting link
[   60.173067] ata8: ahci_hardreset *****
[   60.173073] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   60.173082] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   60.173086] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   60.488241] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   60.488262] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   60.488272] ata8: ahci_softreset *****
[   60.488280] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   60.488289] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   60.488294] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   60.488300] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   60.488309] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   95.144383] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   95.144402] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   95.144409] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   95.144420] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   95.144430] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   95.144435] ata8: softreset failed (1st FIS failed)
[   95.144450] ata8: limiting SATA link speed to 3.0 Gbps
[   95.144454] ata8: hard resetting link
[   95.144458] ata8: ahci_hardreset *****
[   95.144464] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   95.144473] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   95.144477] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   95.459765] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   95.459785] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[   95.459795] ata8: ahci_softreset *****
[   95.459803] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[   95.459813] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[   95.459817] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[   95.459823] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[   95.459832] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[  100.142968] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) 
[  100.142987] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[  100.142993] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[  100.143005] ahci 0000:6f:00.0: ahci_start_engine start 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) ***
[  100.143015] ahci 0000:6f:00.0: ahci_start_engine end 
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c017) ***
[  100.143020] ata8: softreset failed (1st FIS failed)
[  100.143035] ata8: reset failed, giving up
[  100.143040] ata8.00: disable device
[  100.143073] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x00000000 PORT_CMD 0x00044016) 
[  100.143079] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[  100.143095] ata8: EH complete
[  100.143157] sd 7:0:0:0: [sdb] tag#13 FAILED Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK cmd_age=60s
[  100.143166] sd 7:0:0:0: [sdb] tag#13 CDB: Read(10) 28 00 00 03 c3 c0 00 
 08 b8 00
[  100.143170] I/O error, dev sdb, sector 246720 op 0x0:(READ) flags 0x4000 
phys_seg 168 prio class 2
[  100.143196] sd 7:0:0:0: [sdb] tag#14 FAILED Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK cmd_age=60s
[  100.143201] sd 7:0:0:0: [sdb] tag#14 CDB: Read(10) 28 00 00 03 cc 78 00 05 
b8 00
[  100.143204] I/O error, dev sdb, sector 248952 op 0x0:(READ) flags 0x0 phys_seg
 88 prio class 2
[  100.143226] sd 7:0:0:0: [sdb] tag#24 FAILED Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK cmd_age=0s
[  100.143238] sd 7:0:0:0: [sdb] tag#24 CDB: ATA command pass through(16) 85 06 
 20 00 00 00 00 00 00 00 00 00 00 00 e5 00
[  100.143279] sd 7:0:0:0: [sdb] tag#15 FAILED Result: hostbyte=DID_BAD_TARGET 
driverbyte=DRIVER_OK cmd_age=60s
[  100.143287] sd 7:0:0:0: [sdb] tag#15 CDB: Read(10) 28 00 00 03 d2 30 00 
 0a 00 00
[  100.143291] I/O error, dev sdb, sector 250416 op 0x0:(READ) flags 0x4000 
phys_seg 112 prio class 2
[  100.143313] sd 7:0:0:0: [sdb] tag#16 FAILED Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=60s
[  100.143322] sd 7:0:0:0: [sdb] tag#16 CDB: Read(10) 28 00 00 03 dc 30 00
 0a 00 00
[  100.143327] I/O error, dev sdb, sector 252976 op 0x0:(READ) flags 0x4000 
phys_seg 81 prio class 2
[  100.143346] sd 7:0:0:0: [sdb] tag#17 FAILED Result: 
hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=60s
[  100.143353] sd 7:0:0:0: [sdb] tag#17 CDB: Read(10) 28 00 00 03 e6
 30 00 08
 40 00
[  100.143357] I/O error, dev sdb, sector 255536 op 0x0:(READ) flags
 0x4000 phys_seg 65 prio class 2
[  100.143499] sd 7:0:0:0: [sdb] tag#18 FAILED Result:
 hostbyte=DID_BAD_TARGET driverbyte=DRIVER_OK cmd_age=60s
[  100.143508] sd 7:0:0:0: [sdb] tag#18 CDB: Read(10) 28 00 00 03 ee 70 00
 09 90 00
[  100.143513] I/O error, dev sdb, sector 257648 op 0x0:(READ) flags 0x0
 phys_seg 70 prio class 2
 

The Linux(add clear pending interrupt) kernel dmesg output as shown below:

[  331.569303] ahci_error_intr start (irq_stat 0x08000000) ****
[  331.569320] ahci_error_intr: interface fatal error
[  331.569324] ahci_error_intr: freeze (set pxIE to 0)
[  331.569345] ahci_error_intr end (PORT_IRQ_MASK = 0x00000000 )****
[  331.599010] ata8.00: exception Emask 0x10 SAct 0x18 SErr 0x280100 
action 0x6 frozen
[  331.599026] ata8.00: irq_stat 0x08000000, interface fatal error
[  331.599032] ata8: SError: { UnrecovData 10B8B BadCRC }
[  331.599042] ata8.00: failed command: READ FPDMA QUEUED
[  331.599047] ata8.00: cmd 60/00:18:e0:3d:19/0a:00:00:00:00/40 tag 3 
ncq dma 1310720 in
        res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  331.599064] ata8.00: status: { DRDY }
[  331.599070] ata8.00: failed command: READ FPDMA QUEUED
[  331.599074] ata8.00: cmd 60/90:20:e0:47:19/06:00:00:00:00/40 tag 4 
ncq dma 860160 in
        res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  331.599089] ata8.00: status: { DRDY }
[  331.599096] ata8: hard resetting link
[  331.599100] ata8: ahci_hardreset *****
[  331.599107] ahci 0000:6f:00.0: ahci_stop_engine start *** 
( PORT_IRQ_STAT 0x40000008 PORT_CMD 0x0004c317) 
[  331.599118] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x40000008 PORT_CMD 0x00044016) 
[  331.599123] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[  331.914440] ahci 0000:6f:00.0: ahci_start_engine: check 
PORT_SCR_ERR 0x00000000, and to clear
[  331.914447] ahci 0000:6f:00.0: ahci_start_engine: check 
PORT_IRQ_STAT 0x40000008, and to clear 
[  331.914456] ata8: ahci_softreset *****
[  331.914466] ahci 0000:6f:00.0: ahci_stop_engine: setting HBA to idle  
(PORT_IRQ_STAT 0x00000000 PORT_CMD 0x00044016) 
[  331.914470] ahci 0000:6f:00.0: ahci_stop_engine end *** 
[  331.914473] ahci 0000:6f:00.0: ahci_start_engine: check 
PORT_SCR_ERR 0x00000000, and to clear
[  331.914477] ahci 0000:6f:00.0: ahci_start_engine: check 
PORT_IRQ_STAT 0x00000000, and to clear 
[  332.075031] ata8: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  332.075718] ata8.00: configured for UDMA/133
[  332.075739] ata8: EH complete

Thanks.

>
>> action 0x6 frozen
>> [  656.180384] ata7.00: irq_stat 0x08000000, interface fatal error [  
>> 656.180386] ata7: SError: { UnrecovData BadCRC } [  656.180389] 
>> ata7.00: failed command: READ FPDMA QUEUED [  656.180390] ata7.00: cmd 
>> 60/00:30:28:a9:9c/0a:00:01:00:00/40 tag 6 ncq dma 1310720 in
>> 	res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 656.180395] ata7.00: status: { DRDY } [  656.180397] ata7.00: failed 
>> command: READ FPDMA QUEUED [  656.180398] ata7.00: cmd 
>> 60/00:38:28:b3:9c/0a:00:01:00:00/40 tag 7 ncq dma 1310720 in
>> 	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 656.180402] ata7.00: status: { DRDY } [  656.180403] ata7.00: failed 
>> command: READ FPDMA QUEUED [  656.180404] ata7.00: cmd 
>> 60/00:40:28:bd:9c/0a:00:01:00:00/40 tag 8 ncq dma 1310720 in
>> 	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 656.180408] ata7.00: status: { DRDY } [  656.180410] ata7.00: failed 
>> command: READ FPDMA QUEUED [  656.180411] ata7.00: cmd 
>> 60/00:48:28:c7:9c/0a:00:01:00:00/40 tag 9 ncq dma 1310720 in
>> 	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 656.180414] ata7.00: status: { DRDY } [  656.180416] ata7.00: failed 
>> command: READ FPDMA QUEUED [  656.180417] ata7.00: cmd 
>> 60/00:50:28:d1:9c/0a:00:01:00:00/40 tag 10 ncq dma 1310720 in
>> 	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 656.180421] ata7.00: status: { DRDY } [  656.180423] ata7: hard 
>> resetting link [  659.210328] amd_iommu_report_page_fault: 48 
>> callbacks suppressed [  659.210333] nouveau 0000:09:00.0: AMD-Vi: 
>> Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.210345] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.210352] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.811069] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.811080] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.811086] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.827669] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.827676] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.827680] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  659.878319] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.426805] 
>> amd_iommu_report_page_fault: 248 callbacks suppressed [  664.426809] 
>> nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.426819] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.426825] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.676294] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.676305] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.676313] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.693501] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.693513] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.693521] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  664.711480] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  666.180398] ata7: softreset 
>> failed (1st FIS failed) [  666.180405] ata7: hard resetting link [  
>> 670.054987] amd_iommu_report_page_fault: 99 callbacks suppressed [  
>> 670.054992] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  670.055003] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000] [  670.055010] nouveau 
>> 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
>> domain=0x0019 address=0x0 flags=0x0000]
>> 
>> 
>> dmesg (add clear pending Interrupt):
>> [  120.236847] ahci_error_intr: interface fatal error [  120.236854] 
>> ahci_error_intr: freeze (set PxIE to 0) [  120.265268] ata7: limiting 
>> SATA link speed to 3.0 Gbps [  120.265275] ata7.00: exception Emask 
>> 0x10 SAct 0x3f0 SErr 0x400000 action 0x6 frozen [  120.265279] 
>> ata7.00: irq_stat 0x08000000, interface fatal error [  120.265281] 
>> ata7: SError: { Handshk } [  120.265285] ata7.00: failed command: 
>> WRITE FPDMA QUEUED [  120.265287] ata7.00: cmd 
>> 61/00:20:a8:b9:50/0a:00:00:00:00/40 tag 4 ncq dma 1310720 ou
>> 	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 120.265295] ata7.00: status: { DRDY } [  120.265297] ata7.00: failed 
>> command: WRITE FPDMA QUEUED [  120.265299] ata7.00: cmd 
>> 61/20:28:a8:c3:50/03:00:00:00:00/40 tag 5 ncq dma 409600 out
>> 	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 120.265305] ata7.00: status: { DRDY } [  120.265307] ata7.00: failed 
>> command: WRITE FPDMA QUEUED [  120.265309] ata7.00: cmd 
>> 61/00:30:c8:c6:50/0a:00:00:00:00/40 tag 6 ncq dma 1310720 ou
>> 	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 120.265314] ata7.00: status: { DRDY } [  120.265316] ata7.00: failed 
>> command: WRITE FPDMA QUEUED [  120.265318] ata7.00: cmd 
>> 61/00:38:c8:d0:50/0a:00:00:00:00/40 tag 7 ncq dma 1310720 ou
>> 	res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 120.265324] ata7.00: status: { DRDY } [  120.265325] ata7.00: failed 
>> command: WRITE FPDMA QUEUED [  120.265327] ata7.00: cmd 
>> 61/00:40:c8:da:50/0a:00:00:00:00/40 tag 8 ncq dma 1310720 ou
>> 	res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 120.265333] ata7.00: status: { DRDY } [  120.265334] ata7.00: failed 
>> command: WRITE FPDMA QUEUED [  120.265336] ata7.00: cmd 
>> 61/00:48:c8:e4:50/0a:00:00:00:00/40 tag 9 ncq dma 1310720 ou
>> 	res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) [  
>> 120.265342] ata7.00: status: { DRDY } [  120.265346] ata7: hard 
>> resetting link [  120.265348] ata7: ahci_hardreset ***** [  
>> 120.265352] ahci 0000:0a:00.0: ahci_stop_engine: PORT_IRQ_STAT 
>> 0x40000008 PORT_CMD 0x0004c617 [  120.265356] ahci 0000:0a:00.0: 
>> ahci_stop_engine: setting HBA to idle (setting PxCMD.ST to 0) [  
>> 120.937522] ahci 0000:0a:00.0: ahci_start_engine: check PORT_SCR_ERR 
>> 0x00000000, and to clear [  120.937534] ahci 0000:0a:00.0: 
>> ahci_start_engine: check PORT_IRQ_STAT 0x40000008, and to clear [  
>> 120.937544] ata7: ahci_softreset ***** [  120.937550] ahci 
>> 0000:0a:00.0: ahci_stop_engine: setting HBA to idle (setting PxCMD.ST 
>> to 0) [  120.937555] ahci 0000:0a:00.0: ahci_start_engine: check 
>> PORT_SCR_ERR 0x00000000, and to clear [  120.937559] ahci 
>> 0000:0a:00.0: ahci_start_engine: check PORT_IRQ_STAT 0x00000000, and 
>> to clear [  121.097231] ata7: SATA link up 3.0 Gbps (SStatus 123 
>> SControl 320) [  121.113493] ata7.00: configured for UDMA/133 [  
>> 121.113570] ata7: EH complete
>> 
>> I have printk PxIS & PxCMD values to check pending interrupt.
>> It SBD FIS with ERR to setting PxIS.TFES and PxIS.SDBS bit. 
>> 
>> >>
>> >>>    >
>> >>>    > Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>> >>>    > ---
>> >>>    >  drivers/ata/libahci.c | 12 ++++++++++++
>> >>>    >  1 file changed, 12 insertions(+)
>> >>>    >
>> >>>    > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>> >>>    > index 06aec35f88f2..0ae51fd95d46 100644
>> >>>    > --- a/drivers/ata/libahci.c
>> >>>    > +++ b/drivers/ata/libahci.c
>> >>>    > @@ -679,9 +679,21 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
>> >>>    >
>> >>>    >  void ahci_start_engine(struct ata_port *ap)
>> >>>    >  {
>> >>>    > +     struct ahci_host_priv *hpriv = ap->host->private_data;
>> >>>    >       void __iomem *port_mmio = ahci_port_base(ap);
>> >>>    >       u32 tmp;
>> >>>    >
>> >>>    > +     /* clear SError */
>> >>>    > +     tmp = readl(port_mmio + PORT_SCR_ERR);
>> >>>    > +     writel(tmp, port_mmio + PORT_SCR_ERR);
>> >>>    > +
>> >>>    > +     /* clear port IRQ */
>> >>>    > +     tmp = readl(port_mmio + PORT_IRQ_STAT);
>> >>>    > +     if (tmp)
>> >>>    > +             writel(tmp, port_mmio + PORT_IRQ_STAT);
>> >>>    > +
>> >>>    > +     writel(1 << ap->port_no, hpriv->mmio + PORT_IRQ_STAT);
>> >>>    > +
>> >>>    >       /* start DMA */
>> >>>    >       tmp = readl(port_mmio + PORT_CMD);
>> >>>    >       tmp |= PORT_CMD_START;
>> >>>    > --
>> >>>    > 2.39.2
>> >>>   >
>> >>>
>> >>>   --
>> >>>   Damien Le Moal
>> >>>    Western Digital Research
>> >>>
>> >> Thanks.
>> >>
>> >
>> >--
>> >Damien Le Moal
>> >Western Digital Research
><p></p>
>
