Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4715E7B4F49
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjJBJnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236152AbjJBJnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:43:41 -0400
Received: from csmtpq4-prd-nl1-vmo.edge.unified.services (csmtpq4-prd-nl1-vmo.edge.unified.services [84.116.50.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A76A7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 02:43:37 -0700 (PDT)
Received: from csmtp6-prd-nl1-vmo.nl1.unified.services ([100.107.82.136] helo=csmtp6-prd-nl1-vmo.edge.unified.services)
        by csmtpq4-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1qnFSg-004RLK-C7
        for linux-kernel@vger.kernel.org; Mon, 02 Oct 2023 11:43:34 +0200
Received: from [192.168.10.244] ([82.32.17.210])
        by csmtp6-prd-nl1-vmo.edge.unified.services with ESMTPA
        id nFSfqXrqHQDxRnFSfqMNAL; Mon, 02 Oct 2023 11:43:34 +0200
X-SourceIP: 82.32.17.210
X-Authenticated-Sender: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.4 cv=MPKm2uVl c=1 sm=1 tr=0 ts=651a90c6 cx=a_exe
 a=xwbGgp66NgX51+oEeDXSrg==:117 a=xwbGgp66NgX51+oEeDXSrg==:17
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=x7bEGLp0ZPQA:10
 a=ewtThX2HDLarbOYQafYA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1696239814;
        bh=PZ2qKnhnVOcb+k/KzAKGKGo0ubaHjUF6lzAcMrBnfcE=;
        h=Date:From:Subject:Reply-To:To:Cc:References:In-Reply-To;
        b=abiRy82KbtO6Pw5/8sk5jZaf3biFzoDxyAssWVtsAsn9/sqLb85yfTAv3z2hAYi2a
         XrTZt+KtCcpzBA+WoLSY4FVw1YO+gjTJQiGa8DP6Qq0tms4tKer1iSP6Zj2BIKnXpj
         c5yb4X5j/Y3VqaGldbjS+Fg+OGEolNJOOfA58ZrxI332F3yY5s76vYKiHXzBgMFMMj
         AETQwLS3dLrs1Nku28RJhhwO7mdq96pk6pbWtdpobo/6OSff2/oAVmfzOAn03mhxbK
         IkzeUV4YR9Kg/64AGjqM3np66UhAfk7ZiuwLaa8moRDbBU51bTBPnyUJLMYa5udlWn
         S8l7upJFHkaVQ==
Message-ID: <970e0a2a-18ed-4add-8feb-134e97743b48@blueyonder.co.uk>
Date:   Mon, 2 Oct 2023 10:43:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: Ryzen 9 7950x sound module does not not build
Reply-To: sboyce@blueyonder.co.uk
To:     Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
 <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
 <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
 <ZRLWIkyngsasQbQ7@debian.me>
 <6a6d7683-78f2-4511-976d-eb42d3b59c89@blueyonder.co.uk>
 <40672e60-3913-4794-b84a-742b7c16d361@infradead.org>
 <4b2c3b4e-9b21-4f80-95e1-58aa7f58131e@blueyonder.co.uk>
 <7afa193e-6bf1-4792-89e1-ca72bc4588e9@infradead.org>
Content-Language: en-GB
Organization: blueyonder.co.uk
In-Reply-To: <7afa193e-6bf1-4792-89e1-ca72bc4588e9@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJLxb73Ubk0IGPwlkojEFGhv8XHs3FIOJl1hASxAQhp1OPR3BodIA0j43oHeHZalOUikyRSLwNw3jiCB1urR9LJ/xONRo23llGDN8ennWdwzhgLqsk1R
 Ne9FzwPO8SRBy/SJN+rZ6mhqWilwn6ok1ZFTrIaQvUXGQVGDwT/Dl7cEKdZ3JlCWqtk2MJy23LH9Cmj2Z1Y58/icPmfUTTI16+dIv/YdUTuswuIrRD6DICPZ
 5zphCkv9AmpDqoL+JKPZ3i3t3QXExIoBiXDobUJeB01Soxvdo4rmOxtODpFWjY661/T21sgYrRuBEzcIEU10WmtHd+2VVZiW9sYsPxViVhz4Q28w+hTluWGy
 QSB+BcDMyjWqJAvD7VgO31JTZfrY+szkO+GDHAlLmOJ5aRn3VihdlY5TFJOEvLXaXs4jn2H9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 16:40, Randy Dunlap wrote:
>
> On 9/27/23 04:27, Sid Boyce wrote:
>> On 26/09/2023 23:13, Randy Dunlap wrote:
> || The snd-rpl-pci-acp6x driver only supports
> || vendor=0x1022, device=0x15e2, and PCI revision=0x62.
>
>>> lspci -vv
>>
>> 01:00.1 Audiodevice: NVIDIA Corporation Device 10fa (rev a1)
>>        Subsystem: NVIDIA Corporation Device 1f82
>>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx-
>>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>        Latency: 0, Cache Line Size: 64 bytes
>>        Interrupt: pin B routed to IRQ 80
>>        IOMMU group: 11
>>        Region 0: Memory at fc080000 (32-bit, non-prefetchable) [size=16K]
>>        Capabilities: [60] Power Management version 3
>>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>>                Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
>>                Address: 0000000000000000  Data: 0000
>>        Capabilities: [78] Express (v2) Endpoint, MSI 00
>>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
>> unlimited, L1 <64us
>>                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ 
>> FLReset- SlotPowerLimit 75W
>>                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>>                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>                        MaxPayload 256 bytes, MaxReadReq 512 bytes
>>                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
>> AuxPwr- TransPend-
>>                LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, 
>> Exit Latency L0s <512ns, L1 <4us
>>                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- 
>> CommClk+
>>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                LnkSta: Speed 2.5GT/s (downgraded), Width x16
>>                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>                DevCap2: Completion Timeout: Range AB, TimeoutDis+ 
>> NROPrPrP- LTR+
>>                         10BitTagComp- 10BitTagReq- OBFF Via message, 
>> ExtFmt- EETLPPrefix-
>>                         EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>                         FRS- TPHComp- ExtTPHComp-
>>                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
>> LTR- 10BitTagReq- OBFF Disabled,
>>                         AtomicOpsCtl: ReqEn-
>>                LnkSta2: Current De-emphasis Level: -3.5dB, 
>> EqualizationComplete- EqualizationPhase1-
>>                         EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>                         Retimer- 2Retimers- CrosslinkRes: unsupported
>>        Capabilities: [100 v2] Advanced Error Reporting
>>                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
>> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
>> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
>> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr-
>>                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
>> AdvNonFatalErr+
>>                AERCap: First Error Pointer: 00, ECRCGenCap- 
>> ECRCGenEn- ECRCChkCap- ECRCChkEn-
>>                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- 
>> HdrLogCap-
>>                HeaderLog: 00000000 00000000 00000000 00000000
>>        Kernel driver in use: snd_hda_intel
>>        Kernel modules: snd_hda_intel
>>
>> 0b:00.6 Audiodevice: Advanced Micro Devices, Inc. [AMD] Family 
>> 17h/19h HD AudioController
>>        DeviceName: Realtek ALC897 Audio
>>        Subsystem: ASUSTeK Computer Inc. Device 87fb
>>        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
>> ParErr- Stepping- SERR- FastB2B- DisINTx+
>>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
>> <TAbort- <MAbort- >SERR- <PERR- INTx-
>>        Latency: 0, Cache Line Size: 64 bytes
>>        Interrupt: pin C routed to IRQ 81
>>        IOMMU group: 24
>>        Region 0: Memory at fc500000 (32-bit, non-prefetchable) [size=32K]
>>        Capabilities: [48] Vendor Specific Information: Len=08 <?>
>>        Capabilities: [50] Power Management version 3
>>                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>>        Capabilities: [64] Express (v2) Endpoint, MSI 00
>>                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
>> <4us, L1 unlimited
>>                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ 
>> FLReset- SlotPowerLimit 0W
>>                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>>                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>>                        MaxPayload 256 bytes, MaxReadReq 512 bytes
>>                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
>> AuxPwr- TransPend-
>>                LnkCap: Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, 
>> Exit Latency L0s <64ns, L1 <1us
>>                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
>>                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
>>                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                LnkSta: Speed 16GT/s, Width x16
>>                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
>> NROPrPrP- LTR-
>>                         10BitTagComp+ 10BitTagReq- OBFF Not 
>> Supported, ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
>>                         EmergencyPowerReduction Not Supported, 
>> EmergencyPowerReductionInit-
>>                         FRS- TPHComp- ExtTPHComp-
>>                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>>                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
>> LTR- 10BitTagReq- OBFF Disabled,
>>                         AtomicOpsCtl: ReqEn-
>>                LnkSta2: Current De-emphasis Level: -3.5dB, 
>> EqualizationComplete- EqualizationPhase1-
>>                         EqualizationPhase2- EqualizationPhase3- 
>> LinkEqualizationRequest-
>>                         Retimer- 2Retimers- CrosslinkRes: unsupported
>>        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>                Address: 00000000fee00000  Data: 0000
>>        Capabilities: [100 v1] Vendor Specific Information: ID=0001 
>> Rev=1 Len=010 <?>
>>        Capabilities: [2a0 v1] Access Control Services
>>                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
>> UpstreamFwd- EgressCtrl- DirectTrans-
>>                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
>> UpstreamFwd- EgressCtrl- DirectTrans-
>>        Kernel driver in use: snd_hda_intel
>>        Kernel modules: snd_hda_intel
>>
> Sid, do you have some reason to believe that one of these devices 
> should use the
> snd-rpl-pci-acp6x driver? I don't see that either one of them is the 
> correct
> vendor/device ID pair for that driver, but I would prefer that someone 
> who is
> familiar with the driver & device jump in here...
>
Discovered this morning that there was a faulty plug to one of the 
external speakers.

Playback Devices in kmix  now show "Family 17h/19h HD Audio Controller 
Analog Stereo" and I have audio working with pipewire.

Regards

Sid.

-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks

