Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747BB76EC1B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjHCOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjHCOOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:14:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBE71704;
        Thu,  3 Aug 2023 07:13:41 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bbd2761f1bso8831605ad.2;
        Thu, 03 Aug 2023 07:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691072020; x=1691676820;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coAoj0tdhG3mL4YuLqivRwoUrjhPCz4Xqtb3SkuSKxI=;
        b=X9+2apV3iIDu2Hw1TxOFyVcKHLnLHRPJxSsPRRC0hdRSL5FHGMgeQ4QJrhCSNU+O17
         +n52s+k4jqCSROt2cgrTpfuzWq9gHpvc3Ngk3sPo7CtlmvsYkDLaVBtZh4+B94xDQM4u
         obFuxzg0fiYpWlNCLNJO7zjWAm/M33zFtwX5S76POrPd+Wur8LZUUoDNBOmwXTFy5hvM
         nPhT+3VGwSPlTpTbCEwIRcXhmKEYI8NiBnpWoruFxPi3jtffw+6h43eL34iWuHnKx/UF
         vLupEjS6KOFuXzqYDsrBdZjBbIMSnj+C/820SiWNuasrTY83lKidY8dk64rPbsYvLgZh
         5YTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691072020; x=1691676820;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=coAoj0tdhG3mL4YuLqivRwoUrjhPCz4Xqtb3SkuSKxI=;
        b=Ba4nBgW43BFrSCAuEQ1PH5dbGz4kKaMqlfJO1OCaHb9fApsTu9vCK1cdj4wQtTajd7
         sbMsUy422pCOThXblDJFvXoDvU8GQL8erlyFiDM7xueX6y6RhbW6JLahS2eK/l6ZRzW4
         jgpAlcrjmrHO8H09q1BIbNL8UrfkH9VJxjuQn49vushMQcJ6NH08q6aQWuBTkA+OAO2+
         kyQ88PS03j2W9PmfJx78pcpLGXKK4XMYt39B3zsS3dOD/CJ6XcoLlJPhn3UVfwQYDXjw
         /j04xbuvaX5NZvqFqaOjHW3siPfKGmyXtxwaC6cFORz4tZ772R1MFdvVajB5ITnlyMaS
         8z9Q==
X-Gm-Message-State: ABy/qLbTK9gS9kXHKBrVC+FFUuRBwYn4ITQCwn/C4BiU4YbERsTCXa0d
        epjShI1PP52yT8KOk677zs5oOA/6Cfs=
X-Google-Smtp-Source: APBJJlGhWHWdDTO4G61T3eOxs8nYSicQw212lozvendfolkn4DmEtf4RQBnHeYKsr9P/hWJxNGkYXQ==
X-Received: by 2002:a17:902:e847:b0:1b8:9598:6508 with SMTP id t7-20020a170902e84700b001b895986508mr21425242plg.18.1691072020272;
        Thu, 03 Aug 2023 07:13:40 -0700 (PDT)
Received: from [192.168.0.105] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090282c600b001a1b66af22fsm14444999plz.62.2023.08.03.07.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 07:13:39 -0700 (PDT)
Message-ID: <430ca35e-70a1-e2b0-34e4-2586bebccd44@gmail.com>
Date:   Thu, 3 Aug 2023 21:13:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shubhra Prakash Nandi <email2shubhra@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Power Management <linux-pm@vger.kernel.org>,
        Linux Stable <stable@vger.kernel.org>,
        Linux GPIO <linux-gpio@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: System becomes hot when put to sleep
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> I have a Dell Inspiron 14 5425 laptop with hardware specified below. Up till kernel version 6.1.39 the system can sleep and resume correctly but with kernel version 6.1.40 it heats up when put to sleep and drains battery very quickly. It seems CPU cannot suspend though the system can resume correctly and functions correctly after that. I believe many GPIO and pinctrl patches/fixes for the AMD platform beginning 6.1.40 and 6.4.5 has caused this issue. There is no error in logs and sleep/resume log messages in both 6.1.39 and 6.1.40 are the same. Only s2idle sleep mode is available on my system.
> 
> -- CPU
> AMD Ryzen 5 5625U with Radeon Graphics
> 
> -- PCI
> 00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir Root Complex
> 	Subsystem: Dell Renoir Root Complex
> 	Flags: fast devsel
> 
> 00:00.2 IOMMU: Advanced Micro Devices, Inc. [AMD] Renoir IOMMU
> 	Subsystem: Dell Renoir IOMMU
> 	Flags: bus master, fast devsel, latency 0, IRQ -2147483648
> 	Capabilities: <access denied>
> 
> 00:01.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 	Flags: fast devsel, IOMMU group 0
> 
> 00:01.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0, IRQ 34, IOMMU group 1
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
> 	I/O behind bridge: 00002000-00002fff [size=4K]
> 	Memory behind bridge: d0600000-d07fffff [size=2M]
> 	Prefetchable memory behind bridge: 0000000450200000-00000004503fffff [size=2M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:01.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0, IRQ 35, IOMMU group 2
> 	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
> 	I/O behind bridge: [disabled]
> 	Memory behind bridge: d0500000-d05fffff [size=1M]
> 	Prefetchable memory behind bridge: [disabled]
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:02.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 	Flags: fast devsel, IOMMU group 3
> 
> 00:02.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe GPP Bridge (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0, IRQ 36, IOMMU group 4
> 	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
> 	I/O behind bridge: [disabled]
> 	Memory behind bridge: [disabled]
> 	Prefetchable memory behind bridge: 000000fcf0200000-000000fcf03fffff [size=2M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:08.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Renoir PCIe Dummy Host Bridge
> 	Flags: fast devsel, IOMMU group 5
> 
> 00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0, IRQ 37, IOMMU group 6
> 	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
> 	I/O behind bridge: 00001000-00001fff [size=4K]
> 	Memory behind bridge: d0100000-d04fffff [size=4M]
> 	Prefetchable memory behind bridge: 000000fce0000000-000000fcf01fffff [size=258M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:08.2 PCI bridge: Advanced Micro Devices, Inc. [AMD] Renoir Internal PCIe GPP Bridge to Bus (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0, IRQ 38, IOMMU group 7
> 	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
> 	I/O behind bridge: [disabled]
> 	Memory behind bridge: d0000000-d00fffff [size=1M]
> 	Prefetchable memory behind bridge: [disabled]
> 	Capabilities: <access denied>
> 	Kernel driver in use: pcieport
> 
> 00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller (rev 51)
> 	Subsystem: Dell FCH SMBus Controller
> 	Flags: 66MHz, medium devsel, IOMMU group 8
> 	Kernel driver in use: piix4_smbus
> 	Kernel modules: i2c_piix4, sp5100_tco
> 
> 00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge (rev 51)
> 	Subsystem: Dell FCH LPC Bridge
> 	Flags: bus master, 66MHz, medium devsel, latency 0, IOMMU group 8
> 
> 00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166a
> 	Flags: fast devsel, IOMMU group 9
> 
> 00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166b
> 	Flags: fast devsel, IOMMU group 9
> 
> 00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166c
> 	Flags: fast devsel, IOMMU group 9
> 
> 00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166d
> 	Flags: fast devsel, IOMMU group 9
> 	Kernel driver in use: k10temp
> 	Kernel modules: k10temp
> 
> 00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166e
> 	Flags: fast devsel, IOMMU group 9
> 
> 00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 166f
> 	Flags: fast devsel, IOMMU group 9
> 
> 00:18.6 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1670
> 	Flags: fast devsel, IOMMU group 9
> 
> 00:18.7 Host bridge: Advanced Micro Devices, Inc. [AMD] Device 1671
> 	Flags: fast devsel, IOMMU group 9
> 
> 02:00.0 Non-Volatile memory controller: KIOXIA Corporation Device 000c (prog-if 02 [NVM Express])
> 	Subsystem: KIOXIA Corporation Device 0001
> 	Flags: bus master, fast devsel, latency 0, IRQ 58, NUMA node 0, IOMMU group 10
> 	Memory at d0500000 (64-bit, non-prefetchable) [size=16K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: nvme
> 	Kernel modules: nvme
> 
> 03:00.0 Network controller: MEDIATEK Corp. Device 7961
> 	Subsystem: Foxconn International, Inc. Device e0b7
> 	Flags: bus master, fast devsel, latency 0, IRQ 85, IOMMU group 11
> 	Memory at fcf0200000 (64-bit, prefetchable) [size=1M]
> 	Memory at fcf0300000 (64-bit, prefetchable) [size=16K]
> 	Memory at fcf0304000 (64-bit, prefetchable) [size=4K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: mt7921e
> 	Kernel modules: mt7921e
> 
> 04:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Device 15e7 (rev c2) (prog-if 00 [VGA controller])
> 	Subsystem: Dell Device 0b46
> 	Flags: bus master, fast devsel, latency 0, IRQ 49, IOMMU group 12
> 	Memory at fce0000000 (64-bit, prefetchable) [size=256M]
> 	Memory at fcf0000000 (64-bit, prefetchable) [size=2M]
> 	I/O ports at 1000 [size=256]
> 	Memory at d0400000 (32-bit, non-prefetchable) [size=512K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: amdgpu
> 	Kernel modules: amdgpu
> 
> 04:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Device 1637
> 	Subsystem: Dell Device 0b46
> 	Flags: bus master, fast devsel, latency 0, IRQ 83, IOMMU group 13
> 	Memory at d04c8000 (32-bit, non-prefetchable) [size=16K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
> 
> 04:00.2 Encryption controller: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) Platform Security Processor
> 	Subsystem: Dell Family 17h (Models 10h-1fh) Platform Security Processor
> 	Flags: bus master, fast devsel, latency 0, IRQ 77, IOMMU group 14
> 	Memory at d0300000 (32-bit, non-prefetchable) [size=1M]
> 	Memory at d04cc000 (32-bit, non-prefetchable) [size=8K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: ccp
> 	Kernel modules: ccp
> 
> 04:00.3 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1 (prog-if 30 [XHCI])
> 	Subsystem: Dell Renoir USB 3.1
> 	Flags: fast devsel, IRQ 40, IOMMU group 15
> 	Memory at d0100000 (64-bit, non-prefetchable) [size=1M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
> 
> 04:00.4 USB controller: Advanced Micro Devices, Inc. [AMD] Renoir USB 3.1 (prog-if 30 [XHCI])
> 	Subsystem: Dell Renoir USB 3.1
> 	Flags: bus master, fast devsel, latency 0, IRQ 49, IOMMU group 16
> 	Memory at d0200000 (64-bit, non-prefetchable) [size=1M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: xhci_hcd
> 	Kernel modules: xhci_pci
> 
> 04:00.5 Multimedia controller: Advanced Micro Devices, Inc. [AMD] Raven/Raven2/FireFlight/Renoir Audio Processor (rev 01)
> 	Subsystem: Dell Raven/Raven2/FireFlight/Renoir Audio Processor
> 	Flags: bus master, fast devsel, latency 0, IRQ 81, IOMMU group 17
> 	Memory at d0480000 (32-bit, non-prefetchable) [size=256K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: snd_rn_pci_acp3x
> 	Kernel modules: snd_pci_acp3x, snd_rn_pci_acp3x, snd_pci_acp5x, snd_pci_acp6x
> 
> 04:00.6 Audio device: Advanced Micro Devices, Inc. [AMD] Family 17h (Models 10h-1fh) HD Audio Controller
> 	Subsystem: Dell Family 17h (Models 10h-1fh) HD Audio Controller
> 	Flags: bus master, fast devsel, latency 0, IRQ 59, IOMMU group 18
> 	Memory at d04c0000 (32-bit, non-prefetchable) [size=32K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: snd_hda_intel
> 	Kernel modules: snd_hda_intel
> 
> 05:00.0 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81) (prog-if 01 [AHCI 1.0])
> 	Flags: bus master, fast devsel, latency 0, IRQ 255, IOMMU group 19
> 	Memory at d0001000 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: <access denied>
> 	Kernel modules: ahci
> 
> 05:00.1 SATA controller: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] (rev 81) (prog-if 01 [AHCI 1.0])
> 	Flags: bus master, fast devsel, latency 0, IRQ 255, IOMMU group 20
> 	Memory at d0000000 (32-bit, non-prefetchable) [size=2K]
> 	Capabilities: <access denied>
> 	Kernel modules: ahci
> 
> -- USB
> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 003 Device 003: ID 0489:e0c8 Foxconn / Hon Hai Wireless_Device
> Bus 003 Device 004: ID 17ef:608d Lenovo Optical Mouse
> Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
> Bus 001 Device 002: ID 0c45:6739 Microdia Integrated_Webcam_FHD
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

See Bugzilla for the full thread.

Anyway, I'm adding this regression to be tracked by regzbot:

#regzbot introduced: v6.1.40..v6.4.5 https://bugzilla.kernel.org/show_bug.cgi?id=217754
#regzbot title: increased temperature on sleep on Dell Inspiron 14 5425

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217754

-- 
An old man doll... just what I always wanted! - Clara
