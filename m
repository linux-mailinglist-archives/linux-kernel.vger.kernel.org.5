Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCF877B05D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 06:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjHNER4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 00:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjHNER3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 00:17:29 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C11E5E;
        Sun, 13 Aug 2023 21:17:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc0d39b52cso23057285ad.2;
        Sun, 13 Aug 2023 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691986647; x=1692591447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUTcsFQVn6S37FY3BXYIj5/hg/rZPw8BZJcPn+6voBw=;
        b=gGxP/EwYw874dGqOIff8f234FrKVfd/P3h3tzfnJXNAQd6EbnyidaJs7XkTOBhQzxi
         Y7+NGSVhnDqFOybHG0ps5E6hY27cEyA49X6xl+irAdLEDSbxBARwg2zuWxOwGmaSaETL
         qUZvEZhvfhWIzKUE/Mk6w6nhbANRc3E8f00BqlW25hnX9NrsfphwsxOKGvoNqXnwe6b1
         2UmxtC0FSxFBxywCABEh1UyGTiS97f8K7zByalB8VmeSVxy4MiSwkb0YaDQgNKOglfk5
         e1RzaNV/JjXQIz3g5l6ErUx2o2M7x9Dw8U99ne+EF9RWyzCH1J2QrJ5XS2vtgpv5AYjC
         sZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691986647; x=1692591447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUTcsFQVn6S37FY3BXYIj5/hg/rZPw8BZJcPn+6voBw=;
        b=N/f9XNu5Um6t+bN/+5hBn6/cMMzRde5xsRRTiMY9S4DpP08AZk3H8zu62vasJ3Ezdk
         b/OZQ2hqx/Qwvs3i0IxosdpFd8v8ADAzOao7nQnom39jbWJyT38ix7iuPJ/Jfr6K8GkC
         5XmNJvIHTsNMCLa+EbVmfVZlO1ZAGTn4ctdm/P1i8dTAAqI8GaLQ7PFIztDl8v9phs4z
         g8Sef1Qu1p+ZOasdo7aFT4fzTed0rlUdsbi7ilxuZC/5g9QFXh6qvyLmFs1+3XnY6nSX
         /3OMQu4A57KpSvV2CEzlVhLM9WKwqJtlaoLh2fHXrc38jMxo9C5PkUcD/Ab2LPe78kgc
         Z42A==
X-Gm-Message-State: AOJu0Yz9vAtU7wSwmwBljZF3pFAvu8JwAL7fUZLnXMnNrWQZF1/u2vEQ
        QMVEKKwxESoplgW9cBZ24qI=
X-Google-Smtp-Source: AGHT+IE4bpkrJIogwV/KIftfcw+L73NbxzqcaDmO2rUuPOd1yufQc0cx0qUzHMQpGJiuemjIrmotoQ==
X-Received: by 2002:a17:903:110c:b0:1bc:2c58:ad97 with SMTP id n12-20020a170903110c00b001bc2c58ad97mr8033404plh.22.1691986646620;
        Sun, 13 Aug 2023 21:17:26 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902eccc00b001aadd0d7364sm8211888plh.83.2023.08.13.21.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 21:17:26 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
X-Google-Original-From: Szuying Chen <Chloe_Chen@asmedia.com.tw>
To:     dlemoal@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Szuying Chen <Chloe_Chen@asmedia.com.tw>
Subject: Re: Re: [PATCH] ahci: libahci: clear pending interrupt status
Date:   Mon, 14 Aug 2023 12:17:20 +0800
Message-Id: <20230814041720.76214-1-Chloe_Chen@asmedia.com.tw>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 17:59, Damien Le Moal wrote: 
>On 8/10/23 18:31, Szuying Chen wrote:
>>> On 8/10/23 14:12, Damien Le Moal wrote: 
>>>    On 8/10/23 14:05, Szuying Chen wrote:
>>>    > When ISR handle interface fatal error with error recovery after clear PxIS
>>>    > and PxIE. Another FIS(SDB FIS with err) that set PxIS.IFS to 1 is recevied
>>>    > during error recovery, which causing the HBA not issue any new commands
>>>    > after cmd.ST set 1.
>>>
>>>    This is not very clear. If there was a fatal error, the drive should be in
>>>    error state and no other SDB FIS can be received as the drive does absolutely
>>>    nothing while in error state (it only waits for a read log 10h command to be>
>>>    issued to get it out of error state). So if you are seeing 2 SDB FIS with
>>>    errors one after the other, you have a buggy device...
>>>
>>>    However, I may be misunderstanding your issue here. Could you provide more
>>>    details and a dmesg output example of the issue ?
>> 
>> According to AHCI 1.3.1 specification ch6.1.9, when an R_ERR is received
>> on an H2D Data FIS in normal operation, the HBA sets PxIS.IFS to 1
>> (fatal error) and halts operation. Referring to SATA 3.0 specification we
>> know the device will halt queued command processing and transmit SDB FIS to
>> host with ERR bit in Status field set to one(set PxIS.TFES to 1).
>
>Sure, but that SBD FIS should be completely ignored by the adapter since it
>stopped operation. If you see it, then it means that the handling of the first
>error was incomplete.
>
The SDB FIS  happens between pxIS.IE was cleared and PxCMD.ST not cleared
to 0. Because the PxCMD.ST still setting, so the SDB FIS can't ignored.  

>> In our case, the ISR handles fatal errors(PxIS.IFS) and enters error 
>> recovery after cleaning up PxIS and PxIE. Then a SDB FIS is received 
>> with interrupt bit(PxIS.TFES) set to 1. According to AHCI 1.3.1 
>> specification ch6.2.2, HBA can't issue(cmd.ST set to 1) any new commands
>> under PxIS.TFES alive during error recovery.
>
>But how come you see a new command being issued ? This entire situation should
>result in a port reset with the first error. I do not see how this is possible.
>Are you saying that the port reset is not cleaning things up properly ? Could
>you share the dmesg output of this case ?
>
>
dmesg:
[  654.244958] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  654.460522] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  656.180375] ata7.00: exception Emask 0x10 SAct 0x7c0 SErr 0x200100 
action 0x6 frozen 
[  656.180384] ata7.00: irq_stat 0x08000000, interface fatal error 
[  656.180386] ata7: SError: { UnrecovData BadCRC } 
[  656.180389] ata7.00: failed command: READ FPDMA QUEUED 
[  656.180390] ata7.00: cmd 60/00:30:28:a9:9c/0a:00:01:00:00/40 tag 6 ncq 
dma 1310720 in 
	res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) 
[  656.180395] ata7.00: status: { DRDY } 
[  656.180397] ata7.00: failed command: READ FPDMA QUEUED 
[  656.180398] ata7.00: cmd 60/00:38:28:b3:9c/0a:00:01:00:00/40 tag 7 ncq 
dma 1310720 in 
	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) 
[  656.180402] ata7.00: status: { DRDY } 
[  656.180403] ata7.00: failed command: READ FPDMA QUEUED 
[  656.180404] ata7.00: cmd 60/00:40:28:bd:9c/0a:00:01:00:00/40 tag 8 ncq 
dma 1310720 in
	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) 
[  656.180408] ata7.00: status: { DRDY } 
[  656.180410] ata7.00: failed command: READ FPDMA QUEUED 
[  656.180411] ata7.00: cmd 60/00:48:28:c7:9c/0a:00:01:00:00/40 tag 9 ncq 
dma 1310720 in 
	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) 
[  656.180414] ata7.00: status: { DRDY } 
[  656.180416] ata7.00: failed command: READ FPDMA QUEUED 
[  656.180417] ata7.00: cmd 60/00:50:28:d1:9c/0a:00:01:00:00/40 tag 10 ncq 
dma 1310720 in 
	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error) 
[  656.180421] ata7.00: status: { DRDY } 
[  656.180423] ata7: hard resetting link 
[  659.210328] amd_iommu_report_page_fault: 48 callbacks suppressed 
[  659.210333] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.210345] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.210352] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.811069] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.811080] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.811086] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.827669] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.827676] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.827680] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  659.878319] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.426805] amd_iommu_report_page_fault: 248 callbacks suppressed 
[  664.426809] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.426819] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.426825] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.676294] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.676305] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.676313] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.693501] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.693513] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.693521] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  664.711480] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000] 
[  666.180398] ata7: softreset failed (1st FIS failed) 
[  666.180405] ata7: hard resetting link 
[  670.054987] amd_iommu_report_page_fault: 99 callbacks suppressed
[  670.054992] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000]
[  670.055003] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000]
[  670.055010] nouveau 0000:09:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT 
domain=0x0019 address=0x0 flags=0x0000]


dmesg (add clear pending Interrupt):
[  120.236847] ahci_error_intr: interface fatal error
[  120.236854] ahci_error_intr: freeze (set PxIE to 0)
[  120.265268] ata7: limiting SATA link speed to 3.0 Gbps
[  120.265275] ata7.00: exception Emask 0x10 SAct 0x3f0 SErr 0x400000 
action 0x6 frozen
[  120.265279] ata7.00: irq_stat 0x08000000, interface fatal error
[  120.265281] ata7: SError: { Handshk }
[  120.265285] ata7.00: failed command: WRITE FPDMA QUEUED
[  120.265287] ata7.00: cmd 61/00:20:a8:b9:50/0a:00:00:00:00/40 tag 4 ncq 
dma 1310720 ou
	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  120.265295] ata7.00: status: { DRDY }
[  120.265297] ata7.00: failed command: WRITE FPDMA QUEUED
[  120.265299] ata7.00: cmd 61/20:28:a8:c3:50/03:00:00:00:00/40 tag 5 ncq 
dma 409600 out
	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  120.265305] ata7.00: status: { DRDY }
[  120.265307] ata7.00: failed command: WRITE FPDMA QUEUED
[  120.265309] ata7.00: cmd 61/00:30:c8:c6:50/0a:00:00:00:00/40 tag 6 ncq 
dma 1310720 ou
	res 40/00:ff:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  120.265314] ata7.00: status: { DRDY }
[  120.265316] ata7.00: failed command: WRITE FPDMA QUEUED
[  120.265318] ata7.00: cmd 61/00:38:c8:d0:50/0a:00:00:00:00/40 tag 7 ncq 
dma 1310720 ou
	res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  120.265324] ata7.00: status: { DRDY }
[  120.265325] ata7.00: failed command: WRITE FPDMA QUEUED
[  120.265327] ata7.00: cmd 61/00:40:c8:da:50/0a:00:00:00:00/40 tag 8 ncq 
dma 1310720 ou
	res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  120.265333] ata7.00: status: { DRDY }
[  120.265334] ata7.00: failed command: WRITE FPDMA QUEUED
[  120.265336] ata7.00: cmd 61/00:48:c8:e4:50/0a:00:00:00:00/40 tag 9 ncq 
dma 1310720 ou
	res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x10 (ATA bus error)
[  120.265342] ata7.00: status: { DRDY }
[  120.265346] ata7: hard resetting link
[  120.265348] ata7: ahci_hardreset *****
[  120.265352] ahci 0000:0a:00.0: ahci_stop_engine: PORT_IRQ_STAT 0x40000008
PORT_CMD 0x0004c617
[  120.265356] ahci 0000:0a:00.0: ahci_stop_engine: setting HBA to idle 
(setting PxCMD.ST to 0) 
[  120.937522] ahci 0000:0a:00.0: ahci_start_engine: check 
PORT_SCR_ERR 0x00000000, and to clear
[  120.937534] ahci 0000:0a:00.0: ahci_start_engine: check 
PORT_IRQ_STAT 0x40000008, and to clear 
[  120.937544] ata7: ahci_softreset *****
[  120.937550] ahci 0000:0a:00.0: ahci_stop_engine: setting HBA to idle  
(setting PxCMD.ST to 0) 
[  120.937555] ahci 0000:0a:00.0: ahci_start_engine: check 
PORT_SCR_ERR 0x00000000, and to clear
[  120.937559] ahci 0000:0a:00.0: ahci_start_engine: check 
PORT_IRQ_STAT 0x00000000, and to clear 
[  121.097231] ata7: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[  121.113493] ata7.00: configured for UDMA/133
[  121.113570] ata7: EH complete

I have printk PxIS & PxCMD values to check pending interrupt.
It SBD FIS with ERR to setting PxIS.TFES and PxIS.SDBS bit. 

>>
>>>    >
>>>    > Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>>>    > ---
>>>    >  drivers/ata/libahci.c | 12 ++++++++++++
>>>    >  1 file changed, 12 insertions(+)
>>>    >
>>>    > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>>>    > index 06aec35f88f2..0ae51fd95d46 100644
>>>    > --- a/drivers/ata/libahci.c
>>>    > +++ b/drivers/ata/libahci.c
>>>    > @@ -679,9 +679,21 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
>>>    >
>>>    >  void ahci_start_engine(struct ata_port *ap)
>>>    >  {
>>>    > +     struct ahci_host_priv *hpriv = ap->host->private_data;
>>>    >       void __iomem *port_mmio = ahci_port_base(ap);
>>>    >       u32 tmp;
>>>    >
>>>    > +     /* clear SError */
>>>    > +     tmp = readl(port_mmio + PORT_SCR_ERR);
>>>    > +     writel(tmp, port_mmio + PORT_SCR_ERR);
>>>    > +
>>>    > +     /* clear port IRQ */
>>>    > +     tmp = readl(port_mmio + PORT_IRQ_STAT);
>>>    > +     if (tmp)
>>>    > +             writel(tmp, port_mmio + PORT_IRQ_STAT);
>>>    > +
>>>    > +     writel(1 << ap->port_no, hpriv->mmio + PORT_IRQ_STAT);
>>>    > +
>>>    >       /* start DMA */
>>>    >       tmp = readl(port_mmio + PORT_CMD);
>>>    >       tmp |= PORT_CMD_START;
>>>    > --
>>>    > 2.39.2
>>>   >
>>>
>>>   --
>>>   Damien Le Moal
>>>    Western Digital Research
>>>
>> Thanks.
>>
>
>-- 
>Damien Le Moal
>Western Digital Research
