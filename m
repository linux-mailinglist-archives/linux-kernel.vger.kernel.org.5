Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C5B78E38D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjH3X4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjH3X4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:56:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA78FD1;
        Wed, 30 Aug 2023 16:56:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdbf10333bso1723855ad.1;
        Wed, 30 Aug 2023 16:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693439796; x=1694044596; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrFfvKQbnjxVtV6vUDM3FY5O6WtAXWg+FAQEPGoqzD8=;
        b=sXMuuKrOUOr5EjPVOp+vOuIro7i0gvXxdl6qV3eobS66d9DU3VInnfyob0yshm8r4B
         FYNrEjmy0Sk3BLYdpdrCyQ0cein1oImWXh8L/58AEwgaIiLRc7EsVr/POWDCkBI7dXsj
         V6CXPe5oZxQVKX+/UXATtARqOPwtAkCAVcGt0EhYEHPEBb0oBvmmw1mMTSBzoZ+rHe6x
         qmWiOUfVVX0aagbPuUw+jdYiNs3zOr9rsX4IseIITPcOSNcpnYskXh+x6cVcVeTb/dYb
         cxpZqscN1EhY5csGbK1rF/pMAV2voPeOB6CzNQBfr86Igf3NlDNBL3wdYXUHZEJaZ5Ez
         910w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693439796; x=1694044596;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mrFfvKQbnjxVtV6vUDM3FY5O6WtAXWg+FAQEPGoqzD8=;
        b=fdUmHC8HyO5pKotZkj+V/QJgrGzT3TuwNStDm0R3ipJM79sbYS62MNE2hgwTiqKLT2
         pw6OUwRmSJpQRvCYN2QtP2Sbuv3pDb7Uc4qaWggupwXCgaILgRcFiA73271fm1Zuo0eC
         pKKtPVvxg9dVrv9UXmx66PbLHL08EZ3nGv3dXmkUHoP3hdXyjWqtTaGEgRWMQZ6X6ot6
         7hV06MTOjGaWKvzUFELG4AS7t7xfWFBay4rBXHXucc9CLTiIfcz2FNauBoenOJ5On3Ac
         WisZAiFCFnkO0i93xtvRd6T35+oN31D1qHuLVBAonjGgLaLTg2AubwqbwDkD+K+k7VI/
         /1aQ==
X-Gm-Message-State: AOJu0Yy1z8Pjspfjbfl4qiQXMgGB4e7XjN6TvUkiIDS77v/RHv1JKMpr
        NZyX23UbdQLIopUGaQGquOc=
X-Google-Smtp-Source: AGHT+IFxqnfKOrGfM7uKj/9L/HQKvzNwmAKjNPFs/9xrlKfFfzOvyGSwoZtpbOxh/AftaCvL6whpWw==
X-Received: by 2002:a17:902:a415:b0:1b8:33d4:77f8 with SMTP id p21-20020a170902a41500b001b833d477f8mr3670573plq.23.1693439796072;
        Wed, 30 Aug 2023 16:56:36 -0700 (PDT)
Received: from [192.168.0.105] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902b78700b001bf574dd1fesm62061pls.141.2023.08.30.16.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 16:56:35 -0700 (PDT)
Message-ID: <f40669fe-d4aa-0000-4ca6-d23daff97046@gmail.com>
Date:   Thu, 31 Aug 2023 06:56:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Kalle Valo <kvalo@kernel.org>, sander44 <ionut_n2001@yahoo.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x192/0x1a0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

I notice a bug report on Bugzilla [1]. Quoting from it:

> Hello Kernel Team,
>=20
> I tried today to rebuild latest mainline kernel. Kernel Version: 6.5.0-=
vanilla1
>=20
> Controller:
>  lspci -vvvv  -s 14.3
> 00:14.3 Network controller: Intel Corporation Alder Lake-P PCH CNVi WiF=
i (rev 01)
>         DeviceName: Onboard - Ethernet
>         Subsystem: Intel Corporation Alder Lake-P PCH CNVi WiFi
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 16
>         IOMMU group: 9
>         Region 0: Memory at 603d1ac000 (64-bit, non-prefetchable) [disa=
bled] [size=3D16K]
>         Capabilities: [c8] Power Management version 3
>                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA PME(D0+,D1=
-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME-
>         Capabilities: [d0] MSI: Enable- Count=3D1/1 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [40] Express (v2) Root Complex Integrated Endpoin=
t, MSI 00
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0
>                         ExtTag- RBE- FLReset+
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ FL=
Reset-
>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>                 DevSta: CorrErr- NonFatalErr+ FatalErr- UnsupReq+ AuxPw=
r+ TransPend-
>                 DevCap2: Completion Timeout: Range B, TimeoutDis+ NROPr=
PrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Via WAKE#, Ext=
Fmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, Emergen=
cyPowerReductionInit-
>                          FRS-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 16ms to 55ms, TimeoutDis- =
LTR- 10BitTagReq- OBFF Disabled,
>                          AtomicOpsCtl: ReqEn-
>         Capabilities: [80] MSI-X: Enable- Count=3D16 Masked-
>                 Vector table: BAR=3D0 offset=3D00002000
>                 PBA: BAR=3D0 offset=3D00003000
>         Capabilities: [100 v1] Latency Tolerance Reporting
>                 Max snoop latency: 0ns
>                 Max no snoop latency: 0ns
>         Capabilities: [164 v1] Vendor Specific Information: ID=3D0010 R=
ev=3D0 Len=3D014 <?>
>         Kernel driver in use: iwlwifi
>         Kernel modules: iwlwifi
>=20
>=20
> Bug Error, Output:
>  dmesg | grep iwlwifi
> [    2.621540] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
> [    2.624632] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0=
x80400 wfpm id 0x80000020
> [    2.624683] iwlwifi 0000:00:14.3: PCI dev 51f0/0090, rev=3D0x370, rf=
id=3D0x2010d000
> [    2.637308] iwlwifi 0000:00:14.3: api flags index 2 larger than supp=
orted by driver
> [    2.637329] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version:=
 0.0.2.41
> [    2.637703] iwlwifi 0000:00:14.3: loaded firmware version 83.e8f84e9=
8.0 so-a0-gf-a0-83.ucode op_mode iwlmvm
> [    2.878933] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 1=
60MHz, REV=3D0x370
> [    2.886860] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
> [    3.987010] WARNING: CPU: 1 PID: 518 at drivers/net/wireless/intel/i=
wlwifi/pcie/trans.c:2216 __iwl_trans_pcie_grab_nic_access+0x192/0x1a0 [iw=
lwifi]
> [    3.987030] Modules linked in: snd_hda_codec_hdmi snd_hda_codec_real=
tek snd_hda_codec_generic ledtrig_audio snd_sof_pci_intel_tgl snd_sof_int=
el_hda_common intel_rapl_msr soundwire_intel intel_rapl_common soundwire_=
generic_allocation snd_sof_intel_hda_mlink intel_uncore_frequency intel_u=
ncore_frequency_common soundwire_cadence snd_sof_intel_hda snd_sof_pci sn=
d_sof_xtensa_dsp snd_sof snd_sof_utils snd_soc_hdac_hda snd_hda_ext_core =
snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus snd_soc_core snd_comp=
ress ac97_bus x86_pkg_temp_thermal snd_pcm_dmaengine intel_powerclamp snd=
_hda_intel coretemp iwlmvm(+) snd_intel_dspcfg snd_intel_sdw_acpi kvm_int=
el snd_hda_codec mac80211 i915 snd_hda_core libarc4 kvm snd_hwdep snd_pcm=
 irqbypass snd_seq_midi snd_seq_midi_event crct10dif_pclmul polyval_clmul=
ni polyval_generic ghash_clmulni_intel snd_rawmidi sha512_ssse3 ofpart ae=
sni_intel tps6598x typec cmdlinepart crypto_simd snd_seq iwlwifi ee1004 s=
pi_nor drm_buddy cryptd mei_pxp mei_hdcp ttm snd_seq_device rapl pmt_tele=
metry mtd
> [    3.987084] RIP: 0010:__iwl_trans_pcie_grab_nic_access+0x192/0x1a0 [=
iwlwifi]
> [    3.987114]  ? __iwl_trans_pcie_grab_nic_access+0x192/0x1a0 [iwlwifi=
]
> [    3.987133]  ? __iwl_trans_pcie_grab_nic_access+0x192/0x1a0 [iwlwifi=
]
> [    3.987144]  ? __iwl_trans_pcie_grab_nic_access+0x192/0x1a0 [iwlwifi=
]
> [    3.987154]  iwl_trans_pcie_grab_nic_access+0x1a/0x50 [iwlwifi]
> [    3.987164]  iwl_read_prph+0x1f/0x70 [iwlwifi]
> [    3.987220]  ? iwl_write32+0x33/0x90 [iwlwifi]
> [    3.987241]  ? iwl_read32+0x21/0x90 [iwlwifi]
> [    3.987250]  ? iwl_trans_pcie_start_hw+0x8e/0x300 [iwlwifi]
> [    3.987287]  _iwl_op_mode_start+0xab/0xe0 [iwlwifi]
> [    3.987297]  iwl_opmode_register+0x6d/0xf0 [iwlwifi]
> [    3.987364] iwlwifi 0000:00:14.3: iwlwifi transaction failed, dumpin=
g registers
> [    3.987376] iwlwifi 0000:00:14.3: iwlwifi device config registers:
> [    3.987654] iwlwifi 0000:00:14.3: 00000000: 51f08086 00100000 028000=
01 00800000 00000004 00000000 00000000 00000000
> [    3.987664] iwlwifi 0000:00:14.3: 00000020: 00000000 00000000 000000=
00 00908086 00000000 000000c8 00000000 00000100
> [    3.987673] iwlwifi 0000:00:14.3: 00000040: 00928010 10000ec0 001a0c=
10 00000000 00000000 00000000 00000000 00000000
> [    3.987683] iwlwifi 0000:00:14.3: 00000060: 00000000 00080812 000000=
05 00000000 00000000 00000000 00000000 00000000
> [    3.987691] iwlwifi 0000:00:14.3: 00000080: 000f0011 00002000 000030=
00 00000000 00000000 00000000 00000000 00000000
> [    3.987702] iwlwifi 0000:00:14.3: 000000a0: 00000000 00000000 000000=
00 00000000 00000000 00000000 00000000 00000000
> [    3.987712] iwlwifi 0000:00:14.3: 000000c0: 00000000 00000000 c823d0=
01 0d000008 00804005 00000000 00000000 00000000
> [    3.987722] iwlwifi 0000:00:14.3: 000000e0: 00000000 00000000 000000=
00 00000000 00000000 00000000 00000000 00000000
> [    3.987732] iwlwifi 0000:00:14.3: 00000100: 16410018 00000000 000000=
00 00462031 00000000 00002000 00000014 00000000
> [    3.987742] iwlwifi 0000:00:14.3: 00000120: 00000000 00000000 000000=
00 00000000 00000000 00000000 00000000 00000000
> [    3.987752] iwlwifi 0000:00:14.3: 00000140: 14c00000 ff000000 000000=
ff 00000000 00000000 0001001e 00481e1f 00000000
> [    3.987761] iwlwifi 0000:00:14.3: iwlwifi device memory mapped regis=
ters:
> [    3.987818] iwlwifi 0000:00:14.3: 00000000: ffffffff ffffffff ffffff=
ff ffffffff ffffffff ffffffff ffffffff ffffffff
> [    3.987828] iwlwifi 0000:00:14.3: 00000020: ffffffff ffffffff ffffff=
ff ffffffff ffffffff ffffffff ffffffff ffffffff
> [    3.987894] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x5a5a5=
a5a
> [    4.074309] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x5a5a=
5a5a
> [    4.160955] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x5a5a5a5a
> [    4.249144] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x5a5a5a5a
> [    4.427371] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x5a5a5a5a, C=
PU2 Status: 0x5a5a5a5a
> [    4.516852] iwlwifi 0000:00:14.3: WFPM_LMAC1_PD_NOTIFICATION: 0x5a5a=
5a5a
> [    4.605879] iwlwifi 0000:00:14.3: HPM_SECONDARY_DEVICE_STATE: 0x5a5a=
5a5a
> [    4.695911] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_ADDR: 0x5a5a5a5a=

> [    4.796159] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_DATA: 0x5a5a5a5a=

> [    4.797593] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0xd05c18
> [    4.799031] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd05c1c
> [    4.800436] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
> [    4.979520] iwlwifi 0000:00:14.3: HW error, resetting before reading=

> [    5.078256] iwlwifi 0000:00:14.3: Loaded firmware version: 83.e8f84e=
98.0 so-a0-gf-a0-83.ucode
> [    5.079626] iwlwifi 0000:00:14.3: 0x00000000 | ADVANCED_SYSASSERT
> [    5.080468] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status0
> [    5.081267] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
> [    5.082054] iwlwifi 0000:00:14.3: 0x00000000 | branchlink2
> [    5.082812] iwlwifi 0000:00:14.3: 0x00000000 | interruptlink1
> [    5.083547] iwlwifi 0000:00:14.3: 0x00000000 | interruptlink2
> [    5.084389] iwlwifi 0000:00:14.3: 0x00000000 | data1
> [    5.085742] iwlwifi 0000:00:14.3: 0x00000000 | data2
> [    5.086499] iwlwifi 0000:00:14.3: 0x00000000 | data3
> [    5.087261] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
> [    5.088063] iwlwifi 0000:00:14.3: 0x00000000 | tsf low
> [    5.088912] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
> [    5.089665] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
> [    5.090417] iwlwifi 0000:00:14.3: 0x00000000 | time gp2
> [    5.091189] iwlwifi 0000:00:14.3: 0x00000000 | uCode revision type
> [    5.091950] iwlwifi 0000:00:14.3: 0x00000000 | uCode version major
> [    5.092759] iwlwifi 0000:00:14.3: 0x00000000 | uCode version minor
> [    5.093519] iwlwifi 0000:00:14.3: 0x00000000 | hw version
> [    5.094289] iwlwifi 0000:00:14.3: 0x00000000 | board version
> [    5.095041] iwlwifi 0000:00:14.3: 0x00000000 | hcmd
> [    5.095844] iwlwifi 0000:00:14.3: 0x00000000 | isr0
> [    5.095847] iwlwifi 0000:00:14.3: 0x00000000 | isr1
> [    5.095849] iwlwifi 0000:00:14.3: 0x00000000 | isr2
> [    5.095849] iwlwifi 0000:00:14.3: 0x00000000 | isr3
> [    5.095850] iwlwifi 0000:00:14.3: 0x00000000 | isr4
> [    5.095851] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
> [    5.102318] iwlwifi 0000:00:14.3: 0x00000000 | wait_event
> [    5.102324] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
> [    5.102325] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
> [    5.102325] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
> [    5.102326] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
> [    5.102326] iwlwifi 0000:00:14.3: 0x00000000 | lmpm_pmg_sel
> [    5.102327] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
> [    5.102327] iwlwifi 0000:00:14.3: 0x00000000 | flow_handler
> [    5.192036] iwlwifi 0000:00:14.3: 0x00000000 | ADVANCED_SYSASSERT
> [    5.192704] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
> [    5.193298] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink2
> [    5.193880] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink1
> [    5.194446] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
> [    5.195013] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
> [    5.195578] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
> [    5.196141] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
> [    5.196757] iwlwifi 0000:00:14.3: 0x00000000 | umac major
> [    5.197315] iwlwifi 0000:00:14.3: 0x00000000 | umac minor
> [    5.197856] iwlwifi 0000:00:14.3: 0x00000000 | frame pointer
> [    5.198401] iwlwifi 0000:00:14.3: 0x00000000 | stack pointer
> [    5.198933] iwlwifi 0000:00:14.3: 0x00000000 | last host cmd
> [    5.199462] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
> [    5.289576] iwlwifi 0000:00:14.3: IML/ROM dump:
> [    5.290046] iwlwifi 0000:00:14.3: 0x5A5A | IML/ROM SYSASSERT
> [    5.290510] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM error/state
> [    5.380577] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM data1
> [    5.470590] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM WFPM_AUTH_KEY=
_0
> [    5.650080] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
> [    5.650552] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
> [    5.829715] iwlwifi 0000:00:14.3: WRT: Failed to dump region: id=3D1=
, type=3D10
> [    6.468069] iwlwifi 0000:00:14.3: Failed to get monitor header
> [    6.468570] iwlwifi 0000:00:14.3: WRT: Failed to fill region header:=
 id=3D16, type=3D2
> [    6.855809] iwlwifi 0000:00:14.3: WRT: Failed to dump region: id=3D1=
, type=3D10
> [    7.407484] iwlwifi 0000:00:14.3: Failed to get monitor header
> [    7.407938] iwlwifi 0000:00:14.3: WRT: Failed to fill region header:=
 id=3D16, type=3D2
> [   42.272630] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
> [   42.286023] iwlwifi 0000:00:14.3: retry init count 0
> [   42.296223] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 1=
60MHz, REV=3D0x370
> [   42.694103] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
> [   44.182172] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x5a5a5=
a5a
> [   44.271873] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x5a5a=
5a5a
> [   44.361520] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x5a5a5a5a
> [   44.451086] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x5a5a5a5a
> [   44.630364] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x5a5a5a5a, C=
PU2 Status: 0x5a5a5a5a
> [   44.720647] iwlwifi 0000:00:14.3: WFPM_LMAC1_PD_NOTIFICATION: 0x5a5a=
5a5a
> [   44.811048] iwlwifi 0000:00:14.3: HPM_SECONDARY_DEVICE_STATE: 0x5a5a=
5a5a
> [   44.901343] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_ADDR: 0x5a5a5a5a=

> [   44.991711] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_DATA: 0x5a5a5a5a=

> [   44.992310] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0xd05c18
> [   44.992894] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd05c1c
> [   44.993477] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
> [   45.173055] iwlwifi 0000:00:14.3: HW error, resetting before reading=

> [   45.269654] iwlwifi 0000:00:14.3: Loaded firmware version: 83.e8f84e=
98.0 so-a0-gf-a0-83.ucode
> [   45.270254] iwlwifi 0000:00:14.3: 0x00000000 | ADVANCED_SYSASSERT
> [   45.270841] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status0
> [   45.271417] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
> [   45.271993] iwlwifi 0000:00:14.3: 0x00000000 | branchlink2
> [   45.272626] iwlwifi 0000:00:14.3: 0x00000000 | interruptlink1
> [   45.273240] iwlwifi 0000:00:14.3: 0x00000000 | interruptlink2
> [   45.273800] iwlwifi 0000:00:14.3: 0x00000000 | data1
> [   45.274379] iwlwifi 0000:00:14.3: 0x00000000 | data2
> [   45.274939] iwlwifi 0000:00:14.3: 0x00000000 | data3
> [   45.275498] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
> [   45.276057] iwlwifi 0000:00:14.3: 0x00000000 | tsf low
> [   45.276664] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
> [   45.277223] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
> [   45.277765] iwlwifi 0000:00:14.3: 0x00000000 | time gp2
> [   45.278303] iwlwifi 0000:00:14.3: 0x00000000 | uCode revision type
> [   45.278841] iwlwifi 0000:00:14.3: 0x00000000 | uCode version major
> [   45.279372] iwlwifi 0000:00:14.3: 0x00000000 | uCode version minor
> [   45.279906] iwlwifi 0000:00:14.3: 0x00000000 | hw version
> [   45.280460] iwlwifi 0000:00:14.3: 0x00000000 | board version
> [   45.280999] iwlwifi 0000:00:14.3: 0x00000000 | hcmd
> [   45.281525] iwlwifi 0000:00:14.3: 0x00000000 | isr0
> [   45.282048] iwlwifi 0000:00:14.3: 0x00000000 | isr1
> [   45.282570] iwlwifi 0000:00:14.3: 0x00000000 | isr2
> [   45.283088] iwlwifi 0000:00:14.3: 0x00000000 | isr3
> [   45.283597] iwlwifi 0000:00:14.3: 0x00000000 | isr4
> [   45.284102] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
> [   45.284652] iwlwifi 0000:00:14.3: 0x00000000 | wait_event
> [   45.285170] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
> [   45.285667] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
> [   45.286163] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
> [   45.286645] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
> [   45.287127] iwlwifi 0000:00:14.3: 0x00000000 | lmpm_pmg_sel
> [   45.287602] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
> [   45.288077] iwlwifi 0000:00:14.3: 0x00000000 | flow_handler
> [   45.378293] iwlwifi 0000:00:14.3: 0x00000000 | ADVANCED_SYSASSERT
> [   45.378772] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
> [   45.379242] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink2
> [   45.379710] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink1
> [   45.380199] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
> [   45.380673] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
> [   45.381131] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
> [   45.381587] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
> [   45.382040] iwlwifi 0000:00:14.3: 0x00000000 | umac major
> [   45.382490] iwlwifi 0000:00:14.3: 0x00000000 | umac minor
> [   45.382937] iwlwifi 0000:00:14.3: 0x00000000 | frame pointer
> [   45.383383] iwlwifi 0000:00:14.3: 0x00000000 | stack pointer
> [   45.383818] iwlwifi 0000:00:14.3: 0x00000000 | last host cmd
> [   45.384261] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
> [   45.474633] iwlwifi 0000:00:14.3: IML/ROM dump:
> [   45.475065] iwlwifi 0000:00:14.3: 0x5A5A | IML/ROM SYSASSERT
> [   45.475493] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM error/state
> [   45.565627] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM data1
> [   45.655392] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM WFPM_AUTH_KEY=
_0
> [   45.835366] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
> [   45.835803] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
> [   46.429216] iwlwifi 0000:00:14.3: WRT: Failed to dump region: id=3D1=
, type=3D10
> [   48.765077] iwlwifi 0000:00:14.3: Failed to get monitor header
> [   48.765512] iwlwifi 0000:00:14.3: WRT: Failed to fill region header:=
 id=3D16, type=3D2
> [   50.323190] iwlwifi 0000:00:14.3: WRT: Failed to dump region: id=3D1=
, type=3D10
> [   52.658022] iwlwifi 0000:00:14.3: Failed to get monitor header
> [   52.658469] iwlwifi 0000:00:14.3: WRT: Failed to fill region header:=
 id=3D16, type=3D2
> [   93.262469] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
> [   93.276270] iwlwifi 0000:00:14.3: retry init count 1
> [   93.287510] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 1=
60MHz, REV=3D0x370
> [   93.477618] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
> [   94.678674] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x5a5a5=
a5a
> [   94.768755] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x5a5a=
5a5a
> [   94.858871] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x5a5a5a5a
> [   94.949012] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x5a5a5a5a
> [   95.129141] iwlwifi 0000:00:14.3: SecBoot CPU1 Status: 0x5a5a5a5a, C=
PU2 Status: 0x5a5a5a5a
> [   95.219560] iwlwifi 0000:00:14.3: WFPM_LMAC1_PD_NOTIFICATION: 0x5a5a=
5a5a
> [   95.310251] iwlwifi 0000:00:14.3: HPM_SECONDARY_DEVICE_STATE: 0x5a5a=
5a5a
> [   95.400987] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_ADDR: 0x5a5a5a5a=

> [   95.491664] iwlwifi 0000:00:14.3: WFPM_MAC_OTP_CFG7_DATA: 0x5a5a5a5a=

> [   95.492134] iwlwifi 0000:00:14.3: UMAC CURRENT PC: 0xd05c18
> [   95.492635] iwlwifi 0000:00:14.3: LMAC1 CURRENT PC: 0xd05c1c
> [   95.493152] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
> [   95.673376] iwlwifi 0000:00:14.3: HW error, resetting before reading=

> [   95.770329] iwlwifi 0000:00:14.3: Loaded firmware version: 83.e8f84e=
98.0 so-a0-gf-a0-83.ucode
> [   95.770796] iwlwifi 0000:00:14.3: 0x00000000 | ADVANCED_SYSASSERT
> [   95.771253] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status0
> [   95.771702] iwlwifi 0000:00:14.3: 0x00000000 | trm_hw_status1
> [   95.772198] iwlwifi 0000:00:14.3: 0x00000000 | branchlink2
> [   95.772673] iwlwifi 0000:00:14.3: 0x00000000 | interruptlink1
> [   95.773120] iwlwifi 0000:00:14.3: 0x00000000 | interruptlink2
> [   95.773564] iwlwifi 0000:00:14.3: 0x00000000 | data1
> [   95.774008] iwlwifi 0000:00:14.3: 0x00000000 | data2
> [   95.774447] iwlwifi 0000:00:14.3: 0x00000000 | data3
> [   95.774886] iwlwifi 0000:00:14.3: 0x00000000 | beacon time
> [   95.775322] iwlwifi 0000:00:14.3: 0x00000000 | tsf low
> [   95.775757] iwlwifi 0000:00:14.3: 0x00000000 | tsf hi
> [   95.776204] iwlwifi 0000:00:14.3: 0x00000000 | time gp1
> [   95.776655] iwlwifi 0000:00:14.3: 0x00000000 | time gp2
> [   95.777094] iwlwifi 0000:00:14.3: 0x00000000 | uCode revision type
> [   95.777530] iwlwifi 0000:00:14.3: 0x00000000 | uCode version major
> [   95.777971] iwlwifi 0000:00:14.3: 0x00000000 | uCode version minor
> [   95.778413] iwlwifi 0000:00:14.3: 0x00000000 | hw version
> [   95.778855] iwlwifi 0000:00:14.3: 0x00000000 | board version
> [   95.779298] iwlwifi 0000:00:14.3: 0x00000000 | hcmd
> [   95.779736] iwlwifi 0000:00:14.3: 0x00000000 | isr0
> [   95.780187] iwlwifi 0000:00:14.3: 0x00000000 | isr1
> [   95.780640] iwlwifi 0000:00:14.3: 0x00000000 | isr2
> [   95.781081] iwlwifi 0000:00:14.3: 0x00000000 | isr3
> [   95.781520] iwlwifi 0000:00:14.3: 0x00000000 | isr4
> [   95.781959] iwlwifi 0000:00:14.3: 0x00000000 | last cmd Id
> [   95.782403] iwlwifi 0000:00:14.3: 0x00000000 | wait_event
> [   95.782852] iwlwifi 0000:00:14.3: 0x00000000 | l2p_control
> [   95.783290] iwlwifi 0000:00:14.3: 0x00000000 | l2p_duration
> [   95.783730] iwlwifi 0000:00:14.3: 0x00000000 | l2p_mhvalid
> [   95.784193] iwlwifi 0000:00:14.3: 0x00000000 | l2p_addr_match
> [   95.784647] iwlwifi 0000:00:14.3: 0x00000000 | lmpm_pmg_sel
> [   95.785091] iwlwifi 0000:00:14.3: 0x00000000 | timestamp
> [   95.785532] iwlwifi 0000:00:14.3: 0x00000000 | flow_handler
> [   95.876220] iwlwifi 0000:00:14.3: 0x00000000 | ADVANCED_SYSASSERT
> [   95.876674] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink1
> [   95.877123] iwlwifi 0000:00:14.3: 0x00000000 | umac branchlink2
> [   95.877561] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink1
> [   95.878006] iwlwifi 0000:00:14.3: 0x00000000 | umac interruptlink2
> [   95.878449] iwlwifi 0000:00:14.3: 0x00000000 | umac data1
> [   95.878892] iwlwifi 0000:00:14.3: 0x00000000 | umac data2
> [   95.879335] iwlwifi 0000:00:14.3: 0x00000000 | umac data3
> [   95.879772] iwlwifi 0000:00:14.3: 0x00000000 | umac major
> [   95.880209] iwlwifi 0000:00:14.3: 0x00000000 | umac minor
> [   95.880656] iwlwifi 0000:00:14.3: 0x00000000 | frame pointer
> [   95.881093] iwlwifi 0000:00:14.3: 0x00000000 | stack pointer
> [   95.881526] iwlwifi 0000:00:14.3: 0x00000000 | last host cmd
> [   95.881956] iwlwifi 0000:00:14.3: 0x00000000 | isr status reg
> [   95.973323] iwlwifi 0000:00:14.3: IML/ROM dump:
> [   95.973831] iwlwifi 0000:00:14.3: 0x5A5A | IML/ROM SYSASSERT
> [   95.974272] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM error/state
> [   96.067328] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM data1
> [   96.416183] iwlwifi 0000:00:14.3: 0x5A5A5A5A | IML/ROM WFPM_AUTH_KEY=
_0
> [   97.198294] iwlwifi 0000:00:14.3: Failed to start RT ucode: -110
> [   97.198752] iwlwifi 0000:00:14.3: WRT: Collecting data: ini trigger =
13 fired (delay=3D0ms).
> [   97.984887] iwlwifi 0000:00:14.3: WRT: Failed to dump region: id=3D1=
, type=3D10
> [  100.331964] iwlwifi 0000:00:14.3: Failed to get monitor header
> [  100.332469] iwlwifi 0000:00:14.3: WRT: Failed to fill region header:=
 id=3D16, type=3D2
> [  101.900395] iwlwifi 0000:00:14.3: WRT: Failed to dump region: id=3D1=
, type=3D10
> [  104.255732] iwlwifi 0000:00:14.3: Failed to get monitor header
> [  104.256606] iwlwifi 0000:00:14.3: WRT: Failed to fill region header:=
 id=3D16, type=3D2
> [  145.231251] iwlwifi 0000:00:14.3: Failed to run INIT ucode: -110
> [  145.245829] iwlwifi 0000:00:14.3: retry init count 2

See Bugzilla for the full thread.

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217846

--=20
An old man doll... just what I always wanted! - Clara
