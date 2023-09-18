Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14B97A3EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 02:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjIRAS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbjIRASj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 20:18:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A3114;
        Sun, 17 Sep 2023 17:18:33 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c572c9c852so1778185ad.2;
        Sun, 17 Sep 2023 17:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694996313; x=1695601113; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUPk+p0QAVCnpQhxJ51mj1aAsktRcEm6wqkgKlUt8Ro=;
        b=Fyd9ObiLQAVsavWN3XDBUZIYFpVVGstVoefRjH7Kbzc88bP1GgvHY0CVb8GsB27HY+
         G8ly2bSg5hoXe3kJCk3tU8C4vizc0PziNiFkO/UVcwv4x24QQOboeu+zEDw9abnuAs6q
         GE4HDngVmOziknvWGToicTMNWvUUyHVXzLaY/Fdbvx0sfdo25meLD/xR302tX5jpJUlq
         Un7iISpPFlkztHksEXxtZfgKlA8ezOLKrEdC5xetSHKtBE0zjdyFtUKgZxx2aVd1qlCu
         DZpN1Yr6p71oMOfPb5fyYH5eFenzcmoZtcDl2TIWssACn9bjUaRKwTniyghS9jOv6li0
         Erpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694996313; x=1695601113;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUPk+p0QAVCnpQhxJ51mj1aAsktRcEm6wqkgKlUt8Ro=;
        b=hmCJswQ7tnPHteoTb683Bg67IbqAznd8kmeFq18oOP7qiATHOi5GKjGmu39cCqq8gI
         H+wshLOrfo7oTavgIT8Z/wLp77B15VowVIaCg/M0rZxSQRMz+FCyZuJ5rFOZY17fSV4m
         AVKJy/g7qOnJixRiliBm+dlhl3h62DRh17usfzxJ20jYNtJK+isyURzqLiJjqvzj2Cu2
         aXtBQbt0829+dP8cW1yEeHbFOZXsKpZsLlikPsirXrSVzvy6Tzcr3Ngb6xzRhjCW5Kd9
         7cvQU0VRafVX65XzCDNEEPt5r9XD2iBpu8TeAYCPXEHi9czyJ2iFbiobAilKt9joCNMd
         2m1w==
X-Gm-Message-State: AOJu0YwmwkvLorjGAMekCs74FqWN03oB9YhLJe728/7pPLmwqGpQq77h
        HfnA+PtcislsbzUWR3ILVwQ=
X-Google-Smtp-Source: AGHT+IEWKwK1dEKmbphBbSDaopdfK4ADTEiaqrSqgNoT4Tjxj47WkeJDg+U2SzyAohkw6JZUKRGhsw==
X-Received: by 2002:a17:903:455:b0:1c2:702:61af with SMTP id iw21-20020a170903045500b001c2070261afmr6121780plb.38.1694996312752;
        Sun, 17 Sep 2023 17:18:32 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b001bd99fd1114sm7148063plh.288.2023.09.17.17.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 17:18:32 -0700 (PDT)
Message-ID: <224f10a4-7a6a-48bb-88be-491faf8ecff7@gmail.com>
Date:   Mon, 18 Sep 2023 07:18:28 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Song Liu <song@kernel.org>, Timo Gurr <timo.gurr@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: Marvell RAID Controller issues since 6.5.x
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

> Hardware is a HPE ProLiant Microserver Gen10 X3216 with
> 
> # lspci | grep SATA
> 00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 49)
> 01:00.0 SATA controller: Marvell Technology Group Ltd. 88SE9230 PCIe 2.0 x2 4-port SATA 6 Gb/s RAID Controller (rev 11)
> 
> # dmesg | grep ATA
> [    0.015106] NODE_DATA(0) allocated [mem 0x1feffc000-0x1feffffff]
> [    0.569868] ahci 0000:00:11.0: AHCI 0001.0300 32 slots 1 ports 6 Gbps 0x1 impl SATA mode
> [    0.570560] ata1: SATA max UDMA/133 abar m1024@0xfeb69000 port 0xfeb69100 irq 19
> [    0.581964] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [    0.586488] ata2: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40100 irq 28
> [    0.586554] ata3: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40180 irq 28
> [    0.586617] ata4: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40200 irq 28
> [    0.586681] ata5: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40280 irq 28
> [    0.586742] ata6: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40300 irq 28
> [    0.586804] ata7: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40380 irq 28
> [    0.586866] ata8: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40400 irq 28
> [    0.586927] ata9: SATA max UDMA/133 abar m2048@0xfea40000 port 0xfea40480 irq 28
> [    0.882680] ata1: SATA link down (SStatus 0 SControl 300)
> [    0.896665] ata8: SATA link down (SStatus 0 SControl 310)
> [    0.896979] ata7: SATA link down (SStatus 0 SControl 310)
> [    0.897660] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    0.897986] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    0.899615] ata6: SATA link down (SStatus 0 SControl 310)
> [    1.052964] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.312890] ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.477997] ata9.00: ATAPI: MARVELL VIRTUAL, 1.09, max UDMA/66
> [    1.478613] ata3.00: ATA-10: WDC WD40EFZX-68AWUN0, 81.00B81, max UDMA/133
> [    1.478720] ata4.00: ATA-10: WDC WD40EFZX-68AWUN0, 81.00A81, max UDMA/133
> [    1.478912] ata2.00: ATA-9: Samsung SSD 840 EVO 120GB, EXT0DB6Q, max UDMA/133
> [    1.482260] scsi 1:0:0:0: Direct-Access     ATA      Samsung SSD 840  DB6Q PQ: 0 ANSI: 5
> [    1.483793] scsi 2:0:0:0: Direct-Access     ATA      WDC WD40EFZX-68A 0B81 PQ: 0 ANSI: 5
> [    1.485746] scsi 3:0:0:0: Direct-Access     ATA      WDC WD40EFZX-68A 0A81 PQ: 0 ANSI: 5
> [    1.520882] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> [    1.521779] ata5.00: ATA-9: WDC WD30EFRX-68EUZN0, 82.00A82, max UDMA/133
> [    1.523463] scsi 4:0:0:0: Direct-Access     ATA      WDC WD30EFRX-68E 0A82 PQ: 0 ANSI: 
> 
> I don't use the RAID features but make use of software RAID instead, on the first port I have a SSD with the operating system and the three others have HDDs plugged in.
> 
> These days I noticed extensive load and when looking at dmesg I could see the following lines getting repeated constantly.
> 
> [396495.764520] ata9.00: configured for UDMA/66
> [396496.092239] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [396496.092584] ata9.00: configured for UDMA/66
> [396496.420123] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [396496.420464] ata9.00: configured for UDMA/66
> [396496.748016] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [396496.748320] ata9.00: configured for UDMA/66
> [396497.076285] ata9: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [396497.076609] ata9.00: configured for UDMA/66
> 
> First I thought it'a disk issue as I already had some of them dying and replaced, however after leaving only the SSD connected I still recieved the same dmesg spam immediatelly during boot. So my guess was that the SSD is faulty then, so I replaced my long running
> 
> [    1.036030] ata2.00: ATA-9: SanDisk SDSSDP064G, 2.0.0, max UDMA/133
> 
> with with an older spare one I had lying around (using Clonezilla to clone the drive)
> 
> [    1.478912] ata2.00: ATA-9: Samsung SSD 840 EVO 120GB, EXT0DB6Q, max UDMA/133
> 
> and still hit the same problem with that one. After thinking about what I changed lately besides distribution package updates it came to my mind that I upgraded from kernel 6.4.x to 6.5.x lately (kernels and their upgrades are manual on my distribution so no package was used). I used an arch linux iso to boot my system which also used a previous kernel and worked fine, compiled a 6.4.x kernel again on the system, specifically the latest 6.4.16 one. Rebootet and everything is up and running fine again so after half a day I'm pretty sure none of my hardware is faulty and it's indeed a kernel issue/regression.
> 
> I hope I chose the correct component as I wasn't sure if it should be either SCSI or IO/Storage instead. Please let me know if you need further details. I can't guarantee to be able to do any actual testing like bisecting as I use the system in production.

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?id=217920
#regzbot title: UDMA configured spam on Marvell RAID controller

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217920

-- 
An old man doll... just what I always wanted! - Clara
