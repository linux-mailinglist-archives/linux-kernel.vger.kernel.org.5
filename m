Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D677B02E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbjI0L15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjI0L1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:27:44 -0400
Received: from csmtpq1-prd-nl1-vmo.edge.unified.services (csmtpq1-prd-nl1-vmo.edge.unified.services [84.116.50.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666CA1733
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:27:04 -0700 (PDT)
Received: from csmtp4-prd-nl1-vmo.nl1.unified.services ([100.107.82.18] helo=csmtp4-prd-nl1-vmo.edge.unified.services)
        by csmtpq1-prd-nl1-vmo.edge.unified.services with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <sboyce@blueyonder.co.uk>)
        id 1qlSh3-00BblJ-Tj
        for linux-kernel@vger.kernel.org; Wed, 27 Sep 2023 13:27:01 +0200
Received: from [192.168.10.244] ([82.32.17.210])
        by csmtp4-prd-nl1-vmo.edge.unified.services with ESMTPA
        id lSh3qyt7YwQmmlSh3qSF1N; Wed, 27 Sep 2023 13:27:01 +0200
X-SourceIP: 82.32.17.210
X-Authenticated-Sender: sboyce@blueyonder.co.uk
X-Spam: 0
X-Authority: v=2.4 cv=RNt1Xau+ c=1 sm=1 tr=0 ts=65141185 cx=a_exe
 a=xwbGgp66NgX51+oEeDXSrg==:117 a=xwbGgp66NgX51+oEeDXSrg==:17
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=x7bEGLp0ZPQA:10
 a=0v1b5-HTeeM4QniLAwgA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blueyonder.co.uk;
        s=meg.feb2017; t=1695814021;
        bh=Yv9ymRqN7bz/9Zd/poLje8Q7REupOL0fOfYrUu04h/k=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=bBY6LGvOLLH/IbU66OhaMBn5TA2MZqxWRMlD+ZwM86KKqC7WFRwX+NpfqLmoT4rSE
         Tgy6g4YBc6sm07oduLZp8DMlqE7zHVC0YuQkySxaNiuSTIPH8acNkTsYybui2LTqq+
         OANgQcox6zMq7cKGnQbMc7lYFyLUDV0sHLwr1gno+uS4q3k3KvtCZunP/IDdicTL+Q
         /sLGEdsyTvfoVXA/2vGO3ausSKB0PmDTsInRuPqblxEQFDHhPF8cl0tQ46wWlEFm9V
         NV/K+T5QXx+UFqpLZDSWdHlgUpqXeGpZYT+boQuTmOTvlJPsZuJc2j9xPg9iRFwE07
         aVNNXXYNh3gmQ==
Message-ID: <4b2c3b4e-9b21-4f80-95e1-58aa7f58131e@blueyonder.co.uk>
Date:   Wed, 27 Sep 2023 12:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sboyce@blueyonder.co.uk
Subject: Re: Ryzen 9 7950x sound module does not not build
Content-Language: en-GB
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
From:   Sid Boyce <sboyce@blueyonder.co.uk>
Organization: blueyonder.co.uk
In-Reply-To: <40672e60-3913-4794-b84a-742b7c16d361@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHjfA/CrKzraXoJULEBuTwXh9B/opZ0YhHqWaBgKfqrjEqddl6fD98TTeOAvCmY1ONU0eOYop2WUUTGSmROFWAPPGATxmH/dOuFYeZ94PfidlJzRi6bd
 Y85nu7raFM3v/jjk8/pXPblSvApmgQQ6qTZPWibX8hFHPamd2YT62L3ksqBF0aP2/e5vYA9K9CzLyIQWYQqxR8sfDp0iOxoND3/trOEpNYiv+6LtgaTD/Mh3
 5t7CMsTAJjsxBzb3Im8gEnAzq1ywdw8dArP+3YG97lGPSVMaei+tMrzrUaIv29H/xa0oLtpLpNzePyCaArZI4alAgPDvs665vod402iNohVL+nbMtdLd4FaY
 iBBBoHQHqKJtPQrW1ETZQdMuTmCtipKViLOZhKrdxZY5FUIHKqq6tZ6XnvM9Hbz6NenmRQz6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2023 23:13, Randy Dunlap wrote:
> lspci -vv


01:00.1 Audiodevice: NVIDIA Corporation Device 10fa (rev a1)
        Subsystem: NVIDIA Corporation Device 1f82
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 80
        IOMMU group: 11
        Region 0: Memory at fc080000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [60] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D3 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [68] MSI: Enable- Count=1/1 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [78] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 <64us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 75W
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, 
Exit Latency L0s <512ns, L1 <4us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- 
CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s (downgraded), Width x16
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range AB, TimeoutDis+ 
NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via message, 
ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
LTR- 10BitTagReq- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

0b:00.6 Audiodevice: Advanced Micro Devices, Inc. [AMD] Family 17h/19h 
HD AudioController
        DeviceName: Realtek ALC897 Audio
        Subsystem: ASUSTeK Computer Inc. Device 87fb
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin C routed to IRQ 81
        IOMMU group: 24
        Region 0: Memory at fc500000 (32-bit, non-prefetchable) [size=32K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [64] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
<4us, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr- TransPend-
                LnkCap: Port #0, Speed 16GT/s, Width x16, ASPM L0s L1, 
Exit Latency L0s <64ns, L1 <1us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 16GT/s, Width x16
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ 
NROPrPrP- LTR-
                         10BitTagComp+ 10BitTagReq- OBFF Not Supported, 
ExtFmt+ EETLPPrefix+, MaxEETLPPrefixes 1
                         EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- 
LTR- 10BitTagReq- OBFF Disabled,
                         AtomicOpsCtl: ReqEn-
                LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00000  Data: 0000
        Capabilities: [100 v1] Vendor Specific Information: ID=0001 
Rev=1 Len=010 <?>
        Capabilities: [2a0 v1] Access Control Services
                ACSCap: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel




-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks

