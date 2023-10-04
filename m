Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65497B7741
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 06:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241297AbjJDEuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 00:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjJDEuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 00:50:08 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C186EA6;
        Tue,  3 Oct 2023 21:49:55 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
        by mailout.nyi.internal (Postfix) with ESMTP id 349585C0286;
        Wed,  4 Oct 2023 00:49:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 04 Oct 2023 00:49:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1696394993; x=
        1696481393; bh=Uucg8goe4VgcCmidRR03MzriiZ8W9nDY4igF8b/maBQ=; b=K
        wvPY3TeBD0m8jLYjeLDup7KcWCCRGX+4i8cg33i1e/NLPZLIKrYpIdKocadLtMvq
        kxivfj9lLEuquTjvcvaZz82N2uOXTr2KdkskKcxLCFIgVZClci+FLu+Ano8+81xF
        nJkF0fFtYhmIayZ4fdHUP6SGZu7wSlHBD2zKQUB82k6KkfhQKnycYWEOGtbUFecr
        ItQqM4TTjyz+14mgoAUHaDcQlgVRsoFHRg6WawK0puLPva4zlKLEd9ie7n/tGD5g
        6NhsUGGcTIvsqPn7/oQcx4QWA9/xGd3km91o422yDVrS6fDYPV9hBnTCFFwv9Yjy
        SWr7DryYXXb7rITGMG89Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696394993; x=1696481393; bh=Uucg8goe4VgcC
        midRR03MzriiZ8W9nDY4igF8b/maBQ=; b=HWXBtYykWDjPcZeN6W/aAh6NhqzfA
        BUkALczkFaIw+8/Ysn77g7WpY3eawfsMn8cAq7dHilqmYpt/oieW5dKGTUMn6bCr
        SpXB0zqzQyy3/tHquRYRq+xIdR6nFts+xByPn/elj+AnO8ZhLWRjIR0sMpq1JQOH
        1uzXGFBu8zRmxDaDcbv6Fn4QV+Gt2S5dcE0Ah/79R3pR7BfkJzlvwOsmv8Gw8pJD
        DVzp+sBb3Ccym634ALDMgfx5kyIOiXy4uiXmfYZlA4UI7GBNQKqy2/OItFYh6fGR
        JW9OXUD0GKyLiUOTvlljL6L6IkA9SaxcExmu8rzABo7kRIv+904aXj9ng==
X-ME-Sender: <xms:7-4cZVS1LK1LvjAkabgF-DpFhKayf-1VC--muBworAZawrXQ36TL3w>
    <xme:7-4cZezIWDC-615yYfNY1K7Pwe8nkJb5zTGcWNnYUN6shDArKPbrXJJy7e7hdVzr_
    zvDFHEo-jgpxzbByVM>
X-ME-Received: <xmr:7-4cZa3sQTOMjJWHN8SaemWwhnH_XjSY36HgT309Q_gx4lPfW4pYfqX7HCJcmlPIhPW3YQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgedtgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehmtddtredttddvnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepudehvdekfefhgedvfffhkedugfekudfhvdduvdel
    heekieefkeefveelhfffgfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:8O4cZdCfFIgFy5CmLvT8FGYkVcX8ak-L5IJpmu5-40tOJv3Q5-K6GQ>
    <xmx:8O4cZeivYGgM4WqUYvCRArg2SfY0usNp6xzCT_TEnoL6_aHhf6puZA>
    <xmx:8O4cZRry-ym-miFLTVtlIXz5PpicmvH4t1HxdiM4-579SyYkqQT4Vw>
    <xmx:8e4cZTYMc4fi8tEzZFaA3esUVZXenrQLGvZPhqF8XjWQhqVvRlPLkw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Oct 2023 00:49:51 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2E55110A08E; Wed,  4 Oct 2023 07:49:47 +0300 (+03)
Date:   Wed, 4 Oct 2023 07:49:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Max Chou <max.chou@realtek.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Hilda Wu <hildawu@realtek.com>,
        "alex_lu@realsil.com.cn" <alex_lu@realsil.com.cn>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression: devcoredump patch broke Realtek usb bluetooth adapter
Message-ID: <20231004044947.vgegwvxxindkjo7g@box.shutemov.name>
References: <20231003182038.k57nirtt4sonvt7c@box.shutemov.name>
 <ZRyqIn0_qqEFBPdy@debian.me>
 <b2ef2f1c457a4cf7a246b2e8b8598a30@realtek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fq34hsvlnldgmiyp"
Content-Disposition: inline
In-Reply-To: <b2ef2f1c457a4cf7a246b2e8b8598a30@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fq34hsvlnldgmiyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 04, 2023 at 03:07:24AM +0000, Max Chou wrote:
> Hi! Kirill,
> I based on Kernel v6.5.5 and updated drivers/bluetooth to the last version of bluetooth-next tree for a test with RTL8761BUV.
> The dmesg log and "hciconfig -a" are correct.
> Could you share the dmesg for your failure case?
> 
> [56133.563293] usb 3-1: new full-speed USB device number 28 using xhci_hcd
> [56133.712559] usb 3-1: New USB device found, idVendor=0bda, idProduct=8771, bcdDevice= 2.00
> [56133.712577] usb 3-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [56133.712582] usb 3-1: Product: Bluetooth Radio
> [56133.712585] usb 3-1: Manufacturer: Realtek
> [56133.712588] usb 3-1: SerialNumber: 00E04C239987
> [56133.737812] usbcore: registered new interface driver btusb
> [56133.742126] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
> [56133.743115] Bluetooth: hci0: RTL: rom_version status=0 version=1
> [56133.743124] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
> [56133.743754] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
> [56133.743829] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
> [56133.913311] Bluetooth: hci0: RTL: fw version 0xdfc6d922
> [56133.980299] Bluetooth: MGMT ver 1.22
> 
> hci0:   Type: Primary  Bus: USB
>         BD Address: 98:A2:35:85:56:F1  ACL MTU: 1021:6  SCO MTU: 255:12
>         UP RUNNING
>         RX bytes:1670 acl:0 sco:0 events:184 errors:0
>         TX bytes:33917 acl:0 sco:0 commands:184 errors:0
>         Features: 0xff 0xff 0xff 0xfe 0xdb 0xfd 0x7b 0x87
>         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>         Link policy: RSWITCH HOLD SNIFF PARK
>         Link mode: PERIPHERAL ACCEPT
>         Name: 'max-ThinkPad-X230'
>         Class: 0x6c010c
>         Service Classes: Rendering, Capturing, Audio, Telephony
>         Device Class: Computer, Laptop
>         HCI Version: 5.1 (0xa)  Revision: 0xdfc6
>         LMP Version: 5.1 (0xa)  Subversion: 0xd922
>         Manufacturer: Realtek Semiconductor Corporation (93)

I don't see anything obviously wrong in dmesg. Attached hciconfig and
dmesg for both functional and broken cases.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

--fq34hsvlnldgmiyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.bad"

[    0.000000] microcode: updated early: 0x2000065 -> 0x2007006, date = 2023-03-06
[    0.000000] Linux version 6.6.0-rc1-00399-gcffdc28aa2e2 (kas@box) (gcc (Gentoo 13.2.1_p20230826 p7) 13.2.1 20230826, GNU ld (Gentoo 2.41 p2) 2.41.0) #245 SMP PREEMPT_DYNAMIC Wed Oct  4 07:43:50 +03 2023
[    0.000000] Command line: initrd=\initramfs
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003560dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000003560e000-0x00000000365f6fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000365f7000-0x000000003661efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003661f000-0x0000000037786fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000037787000-0x0000000038657fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000038658000-0x000000004fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000050000000-0x000000006fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000109fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x2bc65018-0x2bc75e57] usable ==> usable
[    0.000000] e820: update [mem 0x2bc65018-0x2bc75e57] usable ==> usable
[    0.000000] e820: update [mem 0x2bc45018-0x2bc64a57] usable ==> usable
[    0.000000] e820: update [mem 0x2bc45018-0x2bc64a57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000002bc45017] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc45018-0x000000002bc64a57] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc64a58-0x000000002bc65017] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc65018-0x000000002bc75e57] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc75e58-0x000000003560dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000003560e000-0x00000000365f6fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000365f7000-0x000000003661efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000003661f000-0x0000000037786fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000037787000-0x0000000038657fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000038658000-0x000000004fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000050000000-0x000000006fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000109fffffff] usable
[    0.000000] efi: EFI v2.6 by American Megatrends
[    0.000000] efi: TPMFinalLog=0x37755000 ACPI 2.0=0x36916000 ACPI=0x36916000 SMBIOS=0x384ba000 SMBIOS 3.0=0x384b9000 ESRT=0x33af7898 MEMATTR=0x33af1018 INITRD=0x2bf32f18 TPMEventLog=0x2bc76018 
[    0.000000] efi: Remove mem25: MMIO range=[0x60000000-0x6fffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0x60000000-0x6fffffff] reserved
[    0.000000] efi: Not removing mem26: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem27: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem28: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem29: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem30: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. X299 AORUS Gaming 3 Pro/X299 AORUS Gaming 3 Pro-CF, BIOS F5d 11/28/2019
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2799.927 MHz TSC
[    0.000000] [Firmware Bug]: TSC ADJUST: CPU0: -149457080076105 force to 0
[    0.000560] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000565] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000572] last_pfn = 0x10a0000 max_arch_pfn = 0x400000000
[    0.000576] MTRR map: 6 entries (3 fixed + 3 variable; max 23), built from 10 variable MTRRs
[    0.000579] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000960] e820: update [mem 0x5f000000-0xffffffff] usable ==> reserved
[    0.000964] last_pfn = 0x50000 max_arch_pfn = 0x400000000
[    0.006591] found SMP MP-table at [mem 0x000fcfd0-0x000fcfdf]
[    0.006601] esrt: Reserving ESRT space from 0x0000000033af7898 to 0x0000000033af78d0.
[    0.006607] e820: update [mem 0x33af7000-0x33af7fff] usable ==> reserved
[    0.006619] Using GB pages for direct mapping
[    0.006988] Secure boot disabled
[    0.006989] RAMDISK: [mem 0x2bc78000-0x2bf31fff]
[    0.006993] ACPI: Early table checksum verification disabled
[    0.006996] ACPI: RSDP 0x0000000036916000 000024 (v02 ALASKA)
[    0.007001] ACPI: XSDT 0x00000000369160D8 000134 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007007] ACPI: FACP 0x0000000036935A38 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.007013] ACPI: DSDT 0x00000000369162A8 01F78F (v02 ALASKA A M I    01072009 INTL 20160422)
[    0.007017] ACPI: FACS 0x0000000037754080 000040
[    0.007021] ACPI: FPDT 0x0000000036935B50 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007024] ACPI: FIDT 0x0000000036935B98 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007028] ACPI: SSDT 0x0000000036935C38 007A4B (v01 GBT    GSWApp   00000001 INTL 20160422)
[    0.007032] ACPI: UEFI 0x000000003693D688 000042 (v01 ALASKA A M I    00000002      01000013)
[    0.007036] ACPI: MCFG 0x000000003693D6D0 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.007040] ACPI: HPET 0x000000003693D710 000038 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007044] ACPI: APIC 0x000000003693D748 00071E (v03 ALASKA A M I    00000000 INTL 20091013)
[    0.007047] ACPI: MCFG 0x000000003693DE68 00003C (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007051] ACPI: MIGT 0x000000003693DEA8 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.007055] ACPI: MSCT 0x000000003693DEE8 00004E (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007059] ACPI: PCCT 0x000000003693DF38 00006E (v01 ALASKA A M I    00000002 INTL 20091013)
[    0.007062] ACPI: RASF 0x000000003693DFA8 000030 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007066] ACPI: SLIT 0x000000003693DFD8 00006C (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007070] ACPI: SRAT 0x000000003693E048 000A30 (v03 ALASKA A M I    00000002 INTL 20091013)
[    0.007073] ACPI: SVOS 0x000000003693EA78 000032 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.007077] ACPI: WDDT 0x000000003693EAB0 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.007081] ACPI: OEM4 0x000000003693EAF0 029A72 (v02 INTEL  CPU  CST 00003000 INTL 20160422)
[    0.007085] ACPI: OEM1 0x0000000036968568 00ABCB (v02 INTEL  CPU EIST 00003000 INTL 20160422)
[    0.007089] ACPI: OEM2 0x0000000036973138 006AB0 (v02 INTEL  CPU  HWP 00003000 INTL 20160422)
[    0.007092] ACPI: SSDT 0x0000000036979BE8 00D427 (v02 INTEL  SSDT  PM 00004000 INTL 20160422)
[    0.007096] ACPI: NITR 0x0000000036987010 000071 (v02 ALASKA A M I    00000001 INTL 20091013)
[    0.007100] ACPI: SSDT 0x0000000036987088 000956 (v02 ALASKA A M I    00000000 INTL 20091013)
[    0.007104] ACPI: LPIT 0x00000000369879E0 000094 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.007108] ACPI: WSMT 0x0000000036987A78 000028 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.007111] ACPI: WDAT 0x0000000036987AA0 000134 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.007115] ACPI: SSDT 0x0000000036987BD8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.007119] ACPI: SSDT 0x0000000036987E78 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.007123] ACPI: DBGP 0x000000003698AE80 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.007126] ACPI: DBG2 0x000000003698AEB8 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.007130] ACPI: BGRT 0x000000003698AF10 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007134] ACPI: TPM2 0x000000003698AF48 000034 (v03 ALASKA A M I    00000001 AMI  00000000)
[    0.007138] ACPI: DMAR 0x000000003698AF80 0000D8 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007141] ACPI: WSMT 0x000000003698B058 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007145] ACPI: Reserving FACP table memory at [mem 0x36935a38-0x36935b4b]
[    0.007146] ACPI: Reserving DSDT table memory at [mem 0x369162a8-0x36935a36]
[    0.007148] ACPI: Reserving FACS table memory at [mem 0x37754080-0x377540bf]
[    0.007149] ACPI: Reserving FPDT table memory at [mem 0x36935b50-0x36935b93]
[    0.007150] ACPI: Reserving FIDT table memory at [mem 0x36935b98-0x36935c33]
[    0.007151] ACPI: Reserving SSDT table memory at [mem 0x36935c38-0x3693d682]
[    0.007152] ACPI: Reserving UEFI table memory at [mem 0x3693d688-0x3693d6c9]
[    0.007153] ACPI: Reserving MCFG table memory at [mem 0x3693d6d0-0x3693d70b]
[    0.007154] ACPI: Reserving HPET table memory at [mem 0x3693d710-0x3693d747]
[    0.007156] ACPI: Reserving APIC table memory at [mem 0x3693d748-0x3693de65]
[    0.007157] ACPI: Reserving MCFG table memory at [mem 0x3693de68-0x3693dea3]
[    0.007158] ACPI: Reserving MIGT table memory at [mem 0x3693dea8-0x3693dee7]
[    0.007159] ACPI: Reserving MSCT table memory at [mem 0x3693dee8-0x3693df35]
[    0.007160] ACPI: Reserving PCCT table memory at [mem 0x3693df38-0x3693dfa5]
[    0.007161] ACPI: Reserving RASF table memory at [mem 0x3693dfa8-0x3693dfd7]
[    0.007162] ACPI: Reserving SLIT table memory at [mem 0x3693dfd8-0x3693e043]
[    0.007164] ACPI: Reserving SRAT table memory at [mem 0x3693e048-0x3693ea77]
[    0.007165] ACPI: Reserving SVOS table memory at [mem 0x3693ea78-0x3693eaa9]
[    0.007166] ACPI: Reserving WDDT table memory at [mem 0x3693eab0-0x3693eaef]
[    0.007167] ACPI: Reserving OEM4 table memory at [mem 0x3693eaf0-0x36968561]
[    0.007168] ACPI: Reserving OEM1 table memory at [mem 0x36968568-0x36973132]
[    0.007169] ACPI: Reserving OEM2 table memory at [mem 0x36973138-0x36979be7]
[    0.007170] ACPI: Reserving SSDT table memory at [mem 0x36979be8-0x3698700e]
[    0.007171] ACPI: Reserving NITR table memory at [mem 0x36987010-0x36987080]
[    0.007173] ACPI: Reserving SSDT table memory at [mem 0x36987088-0x369879dd]
[    0.007174] ACPI: Reserving LPIT table memory at [mem 0x369879e0-0x36987a73]
[    0.007175] ACPI: Reserving WSMT table memory at [mem 0x36987a78-0x36987a9f]
[    0.007176] ACPI: Reserving WDAT table memory at [mem 0x36987aa0-0x36987bd3]
[    0.007177] ACPI: Reserving SSDT table memory at [mem 0x36987bd8-0x36987e76]
[    0.007178] ACPI: Reserving SSDT table memory at [mem 0x36987e78-0x3698ae79]
[    0.007180] ACPI: Reserving DBGP table memory at [mem 0x3698ae80-0x3698aeb3]
[    0.007181] ACPI: Reserving DBG2 table memory at [mem 0x3698aeb8-0x3698af0b]
[    0.007182] ACPI: Reserving BGRT table memory at [mem 0x3698af10-0x3698af47]
[    0.007183] ACPI: Reserving TPM2 table memory at [mem 0x3698af48-0x3698af7b]
[    0.007184] ACPI: Reserving DMAR table memory at [mem 0x3698af80-0x3698b057]
[    0.007185] ACPI: Reserving WSMT table memory at [mem 0x3698b058-0x3698b07f]
[    0.083333] Zone ranges:
[    0.083335]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.083338]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.083340]   Normal   [mem 0x0000000100000000-0x000000109fffffff]
[    0.083342] Movable zone start for each node
[    0.083343] Early memory node ranges
[    0.083344]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.083346]   node   0: [mem 0x0000000000100000-0x000000003560dfff]
[    0.083348]   node   0: [mem 0x0000000038658000-0x000000004fffffff]
[    0.083349]   node   0: [mem 0x0000000100000000-0x000000109fffffff]
[    0.083355] Initmem setup node 0 [mem 0x0000000000001000-0x000000109fffffff]
[    0.083359] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.083374] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.084476] On node 0, zone DMA32: 12362 pages in unavailable ranges
[    0.159652] ACPI: PM-Timer IO Port: 0x1808
[    0.159661] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.159664] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.159692] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.159697] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.159702] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.159707] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.159711] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.159714] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.159716] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.159721] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.159723] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.159726] TSC deadline timer available
[    0.159727] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.159744] [mem 0x60000000-0xfdffffff] available for PCI devices
[    0.159746] Booting paravirtualized kernel on bare hardware
[    0.159749] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.166219] setup_percpu: NR_CPUS:128 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.177665] percpu: Embedded 503 pages/cpu s2030888 r0 d29400 u2097152
[    0.177673] pcpu-alloc: s2030888 r0 d29400 u2097152 alloc=1*2097152
[    0.177676] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07 
[    0.177691] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15 
[    0.177705] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 22 [0] 23 
[    0.177719] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] 30 [0] 31 
[    0.177741] Kernel command line: root=/dev/mapper/box-root dolvm rw rootfstype=ext4
[    0.177767] Unknown kernel command line parameters "dolvm", will be passed to user space.
[    0.177799] random: crng init done
[    0.177800] printk: log_buf_len individual max cpu contribution: 131072 bytes
[    0.177802] printk: log_buf_len total cpu_extra contributions: 4063232 bytes
[    0.177803] printk: log_buf_len min size: 524288 bytes
[    0.182688] printk: log_buf_len: 8388608 bytes
[    0.182691] printk: early log buf free: 509784(97%)
[    0.187398] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.189763] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.190094] Built 1 zonelists, mobility grouping on.  Total pages: 16438135
[    0.190099] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.190110] software IO TLB: area num 32.
[    0.327197] Memory: 65367828K/66796884K available (22528K kernel code, 4414K rwdata, 7928K rodata, 8364K init, 5472K bss, 1428800K reserved, 0K cma-reserved)
[    0.327364] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.327384] Kernel/User page tables isolation: enabled
[    0.327475] ftrace: allocating 58697 entries in 230 pages
[    0.337829] ftrace: allocated 230 pages with 5 groups
[    0.337938] Dynamic Preempt: full
[    0.338168] rcu: Preemptible hierarchical RCU implementation.
[    0.338169] rcu: 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=32.
[    0.338171] 	Trampoline variant of Tasks RCU enabled.
[    0.338172] 	Rude variant of Tasks RCU enabled.
[    0.338172] 	Tracing variant of Tasks RCU enabled.
[    0.338173] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.338174] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.341520] NR_IRQS: 8448, nr_irqs: 1224, preallocated irqs: 16
[    0.341775] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.342003] Console: colour dummy device 80x25
[    0.342009] printk: console [tty0] enabled
[    0.343684] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.343695] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.343701] ... MAX_LOCK_DEPTH:          48
[    0.343708] ... MAX_LOCKDEP_KEYS:        8192
[    0.343714] ... CLASSHASH_SIZE:          4096
[    0.343720] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.343727] ... MAX_LOCKDEP_CHAINS:      65536
[    0.343734] ... CHAINHASH_SIZE:          32768
[    0.343740]  memory used by lock dependency info: 4277 kB
[    0.343748]  per task-struct memory footprint: 2688 bytes
[    0.343776] ACPI: Core revision 20230628
[    0.344312] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.344401] APIC: Switch to symmetric I/O mode setup
[    0.344410] DMAR: Host address width 46
[    0.344416] DMAR: DRHD base: 0x000000b5ffc000 flags: 0x0
[    0.344431] DMAR: dmar0: reg_base_addr b5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.344444] DMAR: DRHD base: 0x000000d8ffc000 flags: 0x0
[    0.344456] DMAR: dmar1: reg_base_addr d8ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.344467] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.344478] DMAR: dmar2: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.344490] DMAR: DRHD base: 0x00000092ffc000 flags: 0x1
[    0.344501] DMAR: dmar3: reg_base_addr 92ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.344512] DMAR: RMRR base: 0x0000003774e000 end: 0x00000037750fff
[    0.344521] DMAR: ATSR flags: 0x0
[    0.344529] DMAR-IR: IOAPIC id 12 under DRHD base  0xfbffc000 IOMMU 2
[    0.344539] DMAR-IR: IOAPIC id 11 under DRHD base  0xd8ffc000 IOMMU 1
[    0.344548] DMAR-IR: IOAPIC id 10 under DRHD base  0xb5ffc000 IOMMU 0
[    0.344557] DMAR-IR: IOAPIC id 8 under DRHD base  0x92ffc000 IOMMU 3
[    0.344566] DMAR-IR: IOAPIC id 9 under DRHD base  0x92ffc000 IOMMU 3
[    0.344575] DMAR-IR: HPET id 0 under DRHD base 0x92ffc000
[    0.344582] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.344583] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.345586] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.345597] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.345623] APIC: Switched APIC routing to: physical flat
[    0.347021] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.351387] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x285bfbafad2, max_idle_ns: 440795215530 ns
[    0.351407] Calibrating delay loop (skipped), value calculated using timer frequency.. 5599.85 BogoMIPS (lpj=2799927)
[    0.351446] CPU0: Thermal monitoring enabled (TM1)
[    0.351526] process: using mwait in idle threads
[    0.351537] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.351546] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.351559] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.351573] Spectre V2 : Mitigation: IBRS
[    0.351580] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.351599] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.351614] RETBleed: Mitigation: IBRS
[    0.351626] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.351645] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.351659] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.351695] MDS: Mitigation: Clear CPU buffers
[    0.351707] TAA: Mitigation: Clear CPU buffers
[    0.351718] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.351738] GDS: Mitigation: Microcode
[    0.351756] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.351775] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.351790] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.351806] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.351822] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.351837] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.351852] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.351868] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.351884] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.351900] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.351915] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.351930] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.351946] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.351961] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.351976] x86/fpu: Enabled xstate features 0xff, context size is 2560 bytes, using 'compacted' format.
[    0.376372] Freeing SMP alternatives memory: 52K
[    0.376387] pid_max: default: 32768 minimum: 301
[    0.385104] LSM: initializing lsm=capability
[    0.385225] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.385306] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.386143] smpboot: CPU0: Intel(R) Core(TM) i9-7960X CPU @ 2.80GHz (family: 0x6, model: 0x55, stepping: 0x4)
[    0.386403] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.386403] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.386403] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.386403] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.386403] ... version:                4
[    0.386403] ... bit width:              48
[    0.386403] ... generic registers:      4
[    0.386403] ... value mask:             0000ffffffffffff
[    0.386403] ... max period:             00007fffffffffff
[    0.386403] ... fixed-purpose events:   3
[    0.386403] ... event mask:             000000070000000f
[    0.386428] signal: max sigframe size: 3632
[    0.386461] Estimated ratio of average max frequency by base frequency (times 1024): 1462
[    0.386536] rcu: Hierarchical SRCU implementation.
[    0.386548] rcu: 	Max phase no-delay instances is 400.
[    0.388628] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.389246] smp: Bringing up secondary CPUs ...
[    0.389565] smpboot: x86: Booting SMP configuration:
[    0.389578] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.003503] [Firmware Bug]: TSC ADJUST differs within socket(s), fixing all errors
[    0.402661]  #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.412424] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.412475] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
[    0.412504] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.415521] smp: Brought up 1 node, 32 CPUs
[    0.415521] smpboot: Max logical packages: 1
[    0.415521] smpboot: Total of 32 processors activated (179195.32 BogoMIPS)
[    0.418882] devtmpfs: initialized
[    0.418882] x86/mm: Memory block size: 2048MB
[    0.421111] ACPI: PM: Registering ACPI NVS region [mem 0x3661f000-0x37786fff] (18251776 bytes)
[    0.422901] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.422928] futex hash table entries: 8192 (order: 8, 1048576 bytes, linear)
[    0.423568] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.424167] audit: initializing netlink subsys (disabled)
[    0.424228] audit: type=2000 audit(1696394718.079:1): state=initialized audit_enabled=0 res=1
[    0.424501] thermal_sys: Registered thermal governor 'fair_share'
[    0.424504] thermal_sys: Registered thermal governor 'step_wise'
[    0.424519] thermal_sys: Registered thermal governor 'user_space'
[    0.424618] cpuidle: using governor ladder
[    0.424618] cpuidle: using governor menu
[    0.424618] Detected 1 PCC Subspaces
[    0.424618] Registering PCC driver as Mailbox controller
[    0.424759] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.424759] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x60000000-0x6fffffff] (base 0x60000000)
[    0.425410] PCI: not using MMCONFIG
[    0.425419] PCI: Using configuration type 1 for base access
[    0.427022] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.428619] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.428641] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.428661] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.428681] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.429403] cryptd: max_cpu_qlen set to 1000
[    0.445439] raid6: avx512x4 gen() 50970 MB/s
[    0.462459] raid6: avx512x2 gen() 50916 MB/s
[    0.479482] raid6: avx512x1 gen() 47729 MB/s
[    0.496505] raid6: avx2x4   gen() 31053 MB/s
[    0.513527] raid6: avx2x2   gen() 36669 MB/s
[    0.530548] raid6: avx2x1   gen() 30918 MB/s
[    0.530560] raid6: using algorithm avx512x4 gen() 50970 MB/s
[    0.547569] raid6: .... xor() 8178 MB/s, rmw enabled
[    0.547583] raid6: using avx512x2 recovery algorithm
[    0.547804] ACPI: Added _OSI(Module Device)
[    0.547817] ACPI: Added _OSI(Processor Device)
[    0.547829] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.547842] ACPI: Added _OSI(Processor Aggregator Device)
[    0.610729] ACPI: 6 ACPI AML tables successfully acquired and loaded
[    0.657615] ACPI: Dynamic OEM Table Load:
[    0.677371] ACPI: Dynamic OEM Table Load:
[    0.689716] ACPI: Dynamic OEM Table Load:
[    0.793826] ACPI: _OSC evaluated successfully for all CPUs
[    0.794964] ACPI: Interpreter enabled
[    0.795017] ACPI: PM: (supports S0 S3 S5)
[    0.795030] ACPI: Using IOAPIC for interrupt routing
[    0.795095] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x60000000-0x6fffffff] (base 0x60000000)
[    0.799224] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.799253] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.803379] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.803407] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.807544] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.807572] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.811698] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.811725] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.815857] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.815884] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.815917] [Firmware Info]: PCI: MMCONFIG at [mem 0x60000000-0x6fffffff] not reserved in ACPI motherboard resources
[    0.815940] PCI: MMCONFIG at [mem 0x60000000-0x6fffffff] reserved as EfiMemoryMappedIO
[    0.815971] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.815991] PCI: Using E820 reservations for host bridge windows
[    0.817509] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.883895] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.883926] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.902510] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-15])
[    0.902531] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.902722] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.903056] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.906804] PCI host bridge to bus 0000:00
[    0.906816] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.906833] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    0.906849] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.906867] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
[    0.906884] pci_bus 0000:00: root bus resource [mem 0x70000000-0x92ffffff window]
[    0.906902] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x3800ffffffff window]
[    0.906921] pci_bus 0000:00: root bus resource [bus 00-15]
[    0.907030] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    0.907413] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    0.907445] pci 0000:00:04.0: reg 0x10: [mem 0x92f64000-0x92f67fff 64bit]
[    0.907753] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    0.907785] pci 0000:00:04.1: reg 0x10: [mem 0x92f60000-0x92f63fff 64bit]
[    0.908091] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    0.908122] pci 0000:00:04.2: reg 0x10: [mem 0x92f5c000-0x92f5ffff 64bit]
[    0.908431] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    0.908462] pci 0000:00:04.3: reg 0x10: [mem 0x92f58000-0x92f5bfff 64bit]
[    0.908767] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    0.908799] pci 0000:00:04.4: reg 0x10: [mem 0x92f54000-0x92f57fff 64bit]
[    0.909102] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    0.909133] pci 0000:00:04.5: reg 0x10: [mem 0x92f50000-0x92f53fff 64bit]
[    0.909445] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    0.909476] pci 0000:00:04.6: reg 0x10: [mem 0x92f4c000-0x92f4ffff 64bit]
[    0.909791] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    0.909822] pci 0000:00:04.7: reg 0x10: [mem 0x92f48000-0x92f4bfff 64bit]
[    0.910133] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    0.910433] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    0.910643] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    0.910672] pci 0000:00:05.4: reg 0x10: [mem 0x92f6e000-0x92f6efff]
[    0.910920] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    0.911198] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    0.911371] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    0.911613] pci 0000:00:14.0: [8086:a2af] type 00 class 0x0c0330
[    0.911655] pci 0000:00:14.0: reg 0x10: [mem 0x92f30000-0x92f3ffff 64bit]
[    0.911766] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.912568] pci 0000:00:16.0: [8086:a2ba] type 00 class 0x078000
[    0.912610] pci 0000:00:16.0: reg 0x10: [mem 0x92f6d000-0x92f6dfff 64bit]
[    0.912716] pci 0000:00:16.0: PME# supported from D3hot
[    0.913005] pci 0000:00:17.0: [8086:a282] type 00 class 0x010601
[    0.913039] pci 0000:00:17.0: reg 0x10: [mem 0x92f68000-0x92f69fff]
[    0.913066] pci 0000:00:17.0: reg 0x14: [mem 0x92f6c000-0x92f6c0ff]
[    0.913092] pci 0000:00:17.0: reg 0x18: [io  0x3050-0x3057]
[    0.913118] pci 0000:00:17.0: reg 0x1c: [io  0x3040-0x3043]
[    0.913143] pci 0000:00:17.0: reg 0x20: [io  0x3020-0x303f]
[    0.913168] pci 0000:00:17.0: reg 0x24: [mem 0x92f6b000-0x92f6b7ff]
[    0.913232] pci 0000:00:17.0: PME# supported from D3hot
[    0.913812] pci 0000:00:1b.0: [8086:a2e7] type 01 class 0x060400
[    0.913936] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.914997] pci 0000:00:1c.0: [8086:a290] type 01 class 0x060400
[    0.915121] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.916162] pci 0000:00:1c.4: [8086:a294] type 01 class 0x060400
[    0.916284] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.917351] pci 0000:00:1d.0: [8086:a298] type 01 class 0x060400
[    0.917472] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.918477] pci 0000:00:1f.0: [8086:a2d2] type 00 class 0x060100
[    0.919134] pci 0000:00:1f.2: [8086:a2a1] type 00 class 0x058000
[    0.919170] pci 0000:00:1f.2: reg 0x10: [mem 0x92f44000-0x92f47fff]
[    0.919727] pci 0000:00:1f.3: [8086:a2f0] type 00 class 0x040300
[    0.919770] pci 0000:00:1f.3: reg 0x10: [mem 0x92f40000-0x92f43fff 64bit]
[    0.919830] pci 0000:00:1f.3: reg 0x20: [mem 0x92f20000-0x92f2ffff 64bit]
[    0.919895] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.920600] pci 0000:00:1f.4: [8086:a2a3] type 00 class 0x0c0500
[    0.920671] pci 0000:00:1f.4: reg 0x10: [mem 0x92f6a000-0x92f6a0ff 64bit]
[    0.920757] pci 0000:00:1f.4: reg 0x20: [io  0x3000-0x301f]
[    0.921080] pci 0000:00:1f.6: [8086:15b8] type 00 class 0x020000
[    0.921122] pci 0000:00:1f.6: reg 0x10: [mem 0x92f00000-0x92f1ffff]
[    0.921284] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.921818] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.921924] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.922046] pci 0000:03:00.0: [1b21:2142] type 00 class 0x0c0330
[    0.922092] pci 0000:03:00.0: reg 0x10: [mem 0x92e00000-0x92e07fff 64bit]
[    0.922184] pci 0000:03:00.0: enabling Extended Tags
[    0.922274] pci 0000:03:00.0: PME# supported from D0
[    0.922568] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.922584] pci 0000:00:1c.4:   bridge window [mem 0x92e00000-0x92efffff]
[    0.922685] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    0.922738] pci_bus 0000:00: on NUMA node 0
[    0.924842] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 16-63])
[    0.924861] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.926014] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.926586] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.927084] PCI host bridge to bus 0000:16
[    0.927096] pci_bus 0000:16: root bus resource [io  0x4000-0x7fff window]
[    0.927112] pci_bus 0000:16: root bus resource [mem 0x93000000-0xb5ffffff window]
[    0.927130] pci_bus 0000:16: root bus resource [mem 0x380100000000-0x3801ffffffff window]
[    0.927149] pci_bus 0000:16: root bus resource [bus 16-63]
[    0.927192] pci 0000:16:05.0: [8086:2034] type 00 class 0x088000
[    0.927400] pci 0000:16:05.2: [8086:2035] type 00 class 0x088000
[    0.927590] pci 0000:16:05.4: [8086:2036] type 00 class 0x080020
[    0.927620] pci 0000:16:05.4: reg 0x10: [mem 0xb5f00000-0xb5f00fff]
[    0.927833] pci 0000:16:08.0: [8086:208d] type 00 class 0x088000
[    0.928070] pci 0000:16:08.1: [8086:208d] type 00 class 0x088000
[    0.928222] pci 0000:16:08.2: [8086:208d] type 00 class 0x088000
[    0.928377] pci 0000:16:08.3: [8086:208d] type 00 class 0x088000
[    0.928528] pci 0000:16:08.4: [8086:208d] type 00 class 0x088000
[    0.928678] pci 0000:16:08.5: [8086:208d] type 00 class 0x088000
[    0.928830] pci 0000:16:08.6: [8086:208d] type 00 class 0x088000
[    0.928981] pci 0000:16:08.7: [8086:208d] type 00 class 0x088000
[    0.929139] pci 0000:16:09.0: [8086:208d] type 00 class 0x088000
[    0.929376] pci 0000:16:09.1: [8086:208d] type 00 class 0x088000
[    0.929529] pci 0000:16:09.2: [8086:208d] type 00 class 0x088000
[    0.929679] pci 0000:16:09.3: [8086:208d] type 00 class 0x088000
[    0.929832] pci 0000:16:09.4: [8086:208d] type 00 class 0x088000
[    0.929983] pci 0000:16:09.5: [8086:208d] type 00 class 0x088000
[    0.930135] pci 0000:16:09.6: [8086:208d] type 00 class 0x088000
[    0.930287] pci 0000:16:09.7: [8086:208d] type 00 class 0x088000
[    0.930446] pci 0000:16:0a.0: [8086:208d] type 00 class 0x088000
[    0.930677] pci 0000:16:0a.1: [8086:208d] type 00 class 0x088000
[    0.930842] pci 0000:16:0e.0: [8086:208e] type 00 class 0x088000
[    0.931073] pci 0000:16:0e.1: [8086:208e] type 00 class 0x088000
[    0.931226] pci 0000:16:0e.2: [8086:208e] type 00 class 0x088000
[    0.931380] pci 0000:16:0e.3: [8086:208e] type 00 class 0x088000
[    0.931533] pci 0000:16:0e.4: [8086:208e] type 00 class 0x088000
[    0.931685] pci 0000:16:0e.5: [8086:208e] type 00 class 0x088000
[    0.931837] pci 0000:16:0e.6: [8086:208e] type 00 class 0x088000
[    0.931988] pci 0000:16:0e.7: [8086:208e] type 00 class 0x088000
[    0.932144] pci 0000:16:0f.0: [8086:208e] type 00 class 0x088000
[    0.932382] pci 0000:16:0f.1: [8086:208e] type 00 class 0x088000
[    0.932533] pci 0000:16:0f.2: [8086:208e] type 00 class 0x088000
[    0.932685] pci 0000:16:0f.3: [8086:208e] type 00 class 0x088000
[    0.932837] pci 0000:16:0f.4: [8086:208e] type 00 class 0x088000
[    0.932990] pci 0000:16:0f.5: [8086:208e] type 00 class 0x088000
[    0.933143] pci 0000:16:0f.6: [8086:208e] type 00 class 0x088000
[    0.933297] pci 0000:16:0f.7: [8086:208e] type 00 class 0x088000
[    0.933457] pci 0000:16:10.0: [8086:208e] type 00 class 0x088000
[    0.933696] pci 0000:16:10.1: [8086:208e] type 00 class 0x088000
[    0.933868] pci 0000:16:1d.0: [8086:2054] type 00 class 0x088000
[    0.934113] pci 0000:16:1d.1: [8086:2055] type 00 class 0x088000
[    0.934267] pci 0000:16:1d.2: [8086:2056] type 00 class 0x088000
[    0.934420] pci 0000:16:1d.3: [8086:2057] type 00 class 0x088000
[    0.934582] pci 0000:16:1e.0: [8086:2080] type 00 class 0x088000
[    0.934814] pci 0000:16:1e.1: [8086:2081] type 00 class 0x088000
[    0.934967] pci 0000:16:1e.2: [8086:2082] type 00 class 0x088000
[    0.935120] pci 0000:16:1e.3: [8086:2083] type 00 class 0x088000
[    0.935274] pci 0000:16:1e.4: [8086:2084] type 00 class 0x088000
[    0.935428] pci 0000:16:1e.5: [8086:2085] type 00 class 0x088000
[    0.935581] pci 0000:16:1e.6: [8086:2086] type 00 class 0x088000
[    0.935725] pci_bus 0000:16: on NUMA node 0
[    0.936064] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 64-b1])
[    0.936082] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.937180] acpi PNP0A08:02: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.937731] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.938077] PCI host bridge to bus 0000:64
[    0.938089] pci_bus 0000:64: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.938107] pci_bus 0000:64: root bus resource [io  0x8000-0xbfff window]
[    0.938123] pci_bus 0000:64: root bus resource [io  0x03b0-0x03bb window]
[    0.938139] pci_bus 0000:64: root bus resource [io  0x03c0-0x03df window]
[    0.938155] pci_bus 0000:64: root bus resource [mem 0xb6000000-0xd8ffffff window]
[    0.938172] pci_bus 0000:64: root bus resource [mem 0x380200000000-0x3802ffffffff window]
[    0.938191] pci_bus 0000:64: root bus resource [bus 64-b1]
[    0.938240] pci 0000:64:00.0: [8086:2030] type 01 class 0x060400
[    0.938348] pci 0000:64:00.0: PME# supported from D0 D3hot D3cold
[    0.938678] pci 0000:64:05.0: [8086:2034] type 00 class 0x088000
[    0.938870] pci 0000:64:05.2: [8086:2035] type 00 class 0x088000
[    0.939060] pci 0000:64:05.4: [8086:2036] type 00 class 0x080020
[    0.939089] pci 0000:64:05.4: reg 0x10: [mem 0xd8100000-0xd8100fff]
[    0.939303] pci 0000:64:08.0: [8086:2066] type 00 class 0x088000
[    0.939571] pci 0000:64:09.0: [8086:2066] type 00 class 0x088000
[    0.939838] pci 0000:64:0a.0: [8086:2040] type 00 class 0x088000
[    0.940099] pci 0000:64:0a.1: [8086:2041] type 00 class 0x088000
[    0.940279] pci 0000:64:0a.2: [8086:2042] type 00 class 0x088000
[    0.940460] pci 0000:64:0a.3: [8086:2043] type 00 class 0x088000
[    0.940639] pci 0000:64:0a.4: [8086:2044] type 00 class 0x088000
[    0.940818] pci 0000:64:0a.5: [8086:2045] type 00 class 0x088000
[    0.940996] pci 0000:64:0a.6: [8086:2046] type 00 class 0x088000
[    0.941173] pci 0000:64:0a.7: [8086:2047] type 00 class 0x088000
[    0.941357] pci 0000:64:0b.0: [8086:2048] type 00 class 0x088000
[    0.941618] pci 0000:64:0b.1: [8086:2049] type 00 class 0x088000
[    0.941795] pci 0000:64:0b.2: [8086:204a] type 00 class 0x088000
[    0.941975] pci 0000:64:0b.3: [8086:204b] type 00 class 0x088000
[    0.942161] pci 0000:64:0c.0: [8086:2040] type 00 class 0x088000
[    0.942424] pci 0000:64:0c.1: [8086:2041] type 00 class 0x088000
[    0.942604] pci 0000:64:0c.2: [8086:2042] type 00 class 0x088000
[    0.942783] pci 0000:64:0c.3: [8086:2043] type 00 class 0x088000
[    0.942972] pci 0000:64:0c.4: [8086:2044] type 00 class 0x088000
[    0.943151] pci 0000:64:0c.5: [8086:2045] type 00 class 0x088000
[    0.943332] pci 0000:64:0c.6: [8086:2046] type 00 class 0x088000
[    0.943513] pci 0000:64:0c.7: [8086:2047] type 00 class 0x088000
[    0.943696] pci 0000:64:0d.0: [8086:2048] type 00 class 0x088000
[    0.943959] pci 0000:64:0d.1: [8086:2049] type 00 class 0x088000
[    0.944138] pci 0000:64:0d.2: [8086:204a] type 00 class 0x088000
[    0.944321] pci 0000:64:0d.3: [8086:204b] type 00 class 0x088000
[    0.944619] pci 0000:65:00.0: [10de:1b80] type 00 class 0x030000
[    0.944653] pci 0000:65:00.0: reg 0x10: [mem 0xd7000000-0xd7ffffff]
[    0.944685] pci 0000:65:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.944720] pci 0000:65:00.0: reg 0x1c: [mem 0xd0000000-0xd1ffffff 64bit pref]
[    0.944748] pci 0000:65:00.0: reg 0x24: [io  0xb000-0xb07f]
[    0.944772] pci 0000:65:00.0: reg 0x30: [mem 0xd8000000-0xd807ffff pref]
[    0.944822] pci 0000:65:00.0: BAR 3: assigned to efifb
[    0.944840] pci 0000:65:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.944943] pci 0000:65:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at 0000:64:00.0 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
[    0.945225] pci 0000:65:00.1: [10de:10f0] type 00 class 0x040300
[    0.945261] pci 0000:65:00.1: reg 0x10: [mem 0xd8080000-0xd8083fff]
[    0.945530] pci 0000:64:00.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[    0.948473] pci 0000:64:00.0: PCI bridge to [bus 65]
[    0.948487] pci 0000:64:00.0:   bridge window [io  0xb000-0xbfff]
[    0.948502] pci 0000:64:00.0:   bridge window [mem 0xd7000000-0xd80fffff]
[    0.948520] pci 0000:64:00.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.948549] pci_bus 0000:64: on NUMA node 0
[    0.948835] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus b2-ff])
[    0.948852] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.949967] acpi PNP0A08:03: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.950513] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.950840] PCI host bridge to bus 0000:b2
[    0.950851] pci_bus 0000:b2: root bus resource [io  0xc000-0xffff window]
[    0.950868] pci_bus 0000:b2: root bus resource [mem 0xd9000000-0xfbffffff window]
[    0.950885] pci_bus 0000:b2: root bus resource [mem 0x380300000000-0x3803ffffffff window]
[    0.950904] pci_bus 0000:b2: root bus resource [bus b2-ff]
[    0.950941] pci 0000:b2:05.0: [8086:2034] type 00 class 0x088000
[    0.951138] pci 0000:b2:05.2: [8086:2035] type 00 class 0x088000
[    0.951333] pci 0000:b2:05.4: [8086:2036] type 00 class 0x080020
[    0.951363] pci 0000:b2:05.4: reg 0x10: [mem 0xfbf00000-0xfbf00fff]
[    0.951583] pci 0000:b2:12.0: [8086:204c] type 00 class 0x110100
[    0.951840] pci 0000:b2:12.1: [8086:204d] type 00 class 0x110100
[    0.951992] pci 0000:b2:12.2: [8086:204e] type 00 class 0x088000
[    0.952151] pci 0000:b2:15.0: [8086:2018] type 00 class 0x088000
[    0.952393] pci 0000:b2:16.0: [8086:2018] type 00 class 0x088000
[    0.952624] pci 0000:b2:16.4: [8086:2018] type 00 class 0x088000
[    0.952782] pci 0000:b2:17.0: [8086:2018] type 00 class 0x088000
[    0.953015] pci_bus 0000:b2: on NUMA node 0
[    0.953441] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.953557] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.953671] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.953785] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.953899] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    0.954013] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    0.954126] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.954240] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.954421] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.954450] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.955185] iommu: Default domain type: Translated
[    0.955185] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.955185] SCSI subsystem initialized
[    0.955523] libata version 3.00 loaded.
[    0.955523] ACPI: bus type USB registered
[    0.955548] usbcore: registered new interface driver usbfs
[    0.955583] usbcore: registered new interface driver hub
[    0.955603] usbcore: registered new device driver usb
[    0.955603] mc: Linux media interface: v0.10
[    0.955603] videodev: Linux video capture interface: v2.00
[    0.955603] pps_core: LinuxPPS API ver. 1 registered
[    0.955603] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.955648] EDAC MC: Ver: 3.0.0
[    0.956733] efivars: Registered efivars operations
[    0.956733] Advanced Linux Sound Architecture Driver Initialized.
[    0.957009] Bluetooth: Core ver 2.22
[    0.957040] NET: Registered PF_BLUETOOTH protocol family
[    0.957054] Bluetooth: HCI device and connection manager initialized
[    0.957076] Bluetooth: HCI socket layer initialized
[    0.957099] Bluetooth: L2CAP socket layer initialized
[    0.957122] Bluetooth: SCO socket layer initialized
[    0.957144] NetLabel: Initializing
[    0.957154] NetLabel:  domain hash size = 128
[    0.957166] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.957210] NetLabel:  unlabeled traffic allowed by default
[    0.957448] PCI: Using ACPI for IRQ routing
[    0.963191] PCI: pci_cache_line_size set to 64 bytes
[    0.963358] e820: reserve RAM buffer [mem 0x2bc45018-0x2bffffff]
[    0.963361] e820: reserve RAM buffer [mem 0x2bc65018-0x2bffffff]
[    0.963364] e820: reserve RAM buffer [mem 0x33af7000-0x33ffffff]
[    0.963366] e820: reserve RAM buffer [mem 0x3560e000-0x37ffffff]
[    0.963496] pci 0000:65:00.0: vgaarb: setting as boot VGA device
[    0.963511] pci 0000:65:00.0: vgaarb: bridge control possible
[    0.963525] pci 0000:65:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.963552] vgaarb: loaded
[    0.965013] acpi PNP0C14:03: duplicate WMI GUID DEADBEEF-4001-0000-00A0-C90629100000 (first instance was on PNP0C14:03)
[    0.965416] clocksource: Switched to clocksource tsc-early
[    0.965709] VFS: Disk quotas dquot_6.6.0
[    0.965742] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.965899] pnp: PnP ACPI init
[    0.966950] system 00:01: [io  0x0500-0x053f] has been reserved
[    0.966967] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.966983] system 00:01: [io  0x0540-0x057f] has been reserved
[    0.966997] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.967012] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    0.967026] system 00:01: [io  0x0880-0x0883] has been reserved
[    0.967040] system 00:01: [io  0x0800-0x081f] has been reserved
[    0.967055] system 00:01: [mem 0xfed1c000-0xfed3ffff] has been reserved
[    0.967072] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    0.967088] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    0.967104] system 00:01: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.967120] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    0.967136] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    0.967152] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    0.967679] system 00:02: [io  0x0a00-0x0a2f] has been reserved
[    0.967695] system 00:02: [io  0x0a30-0x0a3f] has been reserved
[    0.967710] system 00:02: [io  0x0a40-0x0a4f] has been reserved
[    0.968257] system 00:03: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.968274] system 00:03: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.968290] system 00:03: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.968306] system 00:03: [mem 0xfe000000-0xfe00ffff] has been reserved
[    0.968322] system 00:03: [mem 0xfe011000-0xfe01ffff] has been reserved
[    0.968338] system 00:03: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.968354] system 00:03: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.968370] system 00:03: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.968841] system 00:04: [io  0x0f00-0x0ffe] has been reserved
[    0.970567] system 00:05: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.970584] system 00:05: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.970600] system 00:05: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.972211] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.972239] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.972273] pnp: PnP ACPI: found 7 devices
[    0.981072] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.981860] NET: Registered PF_INET protocol family
[    0.982052] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.984587] tcp_listen_portaddr_hash hash table entries: 32768 (order: 9, 2621440 bytes, linear)
[    0.985260] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.985288] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.985652] TCP bind hash table entries: 65536 (order: 11, 10485760 bytes, vmalloc hugepage)
[    0.988304] TCP: Hash tables configured (established 524288 bind 65536)
[    0.988470] UDP hash table entries: 32768 (order: 10, 6291456 bytes, vmalloc hugepage)
[    0.989873] UDP-Lite hash table entries: 32768 (order: 10, 6291456 bytes, vmalloc hugepage)
[    0.991362] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.991407] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[    0.991427] pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
[    0.991453] pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff] to [bus 04] add_size 200000 add_align 100000
[    0.991483] pci 0000:00:1d.0: BAR 14: assigned [mem 0x70000000-0x701fffff]
[    0.991501] pci 0000:00:1d.0: BAR 15: assigned [mem 0x380000000000-0x3800001fffff 64bit pref]
[    0.991528] pci 0000:00:1d.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.991544] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.991577] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.991611] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.991629] pci 0000:00:1c.4:   bridge window [mem 0x92e00000-0x92efffff]
[    0.991657] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    0.991670] pci 0000:00:1d.0:   bridge window [io  0x1000-0x1fff]
[    0.991690] pci 0000:00:1d.0:   bridge window [mem 0x70000000-0x701fffff]
[    0.991710] pci 0000:00:1d.0:   bridge window [mem 0x380000000000-0x3800001fffff 64bit pref]
[    0.991738] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.991752] pci_bus 0000:00: resource 5 [io  0x1000-0x3fff window]
[    0.991767] pci_bus 0000:00: resource 6 [mem 0x000c4000-0x000c7fff window]
[    0.991782] pci_bus 0000:00: resource 7 [mem 0xfe010000-0xfe010fff window]
[    0.991798] pci_bus 0000:00: resource 8 [mem 0x70000000-0x92ffffff window]
[    0.991813] pci_bus 0000:00: resource 9 [mem 0x380000000000-0x3800ffffffff window]
[    0.991831] pci_bus 0000:03: resource 1 [mem 0x92e00000-0x92efffff]
[    0.991845] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    0.991859] pci_bus 0000:04: resource 1 [mem 0x70000000-0x701fffff]
[    0.991873] pci_bus 0000:04: resource 2 [mem 0x380000000000-0x3800001fffff 64bit pref]
[    0.992225] pci_bus 0000:16: resource 4 [io  0x4000-0x7fff window]
[    0.992240] pci_bus 0000:16: resource 5 [mem 0x93000000-0xb5ffffff window]
[    0.992255] pci_bus 0000:16: resource 6 [mem 0x380100000000-0x3801ffffffff window]
[    0.992325] pci 0000:64:00.0: PCI bridge to [bus 65]
[    0.992338] pci 0000:64:00.0:   bridge window [io  0xb000-0xbfff]
[    0.992358] pci 0000:64:00.0:   bridge window [mem 0xd7000000-0xd80fffff]
[    0.992377] pci 0000:64:00.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.992402] pci_bus 0000:64: resource 4 [mem 0x000a0000-0x000bffff window]
[    0.992418] pci_bus 0000:64: resource 5 [io  0x8000-0xbfff window]
[    0.992432] pci_bus 0000:64: resource 6 [io  0x03b0-0x03bb window]
[    0.992446] pci_bus 0000:64: resource 7 [io  0x03c0-0x03df window]
[    0.992460] pci_bus 0000:64: resource 8 [mem 0xb6000000-0xd8ffffff window]
[    0.992475] pci_bus 0000:64: resource 9 [mem 0x380200000000-0x3802ffffffff window]
[    0.992492] pci_bus 0000:65: resource 0 [io  0xb000-0xbfff]
[    0.992510] pci_bus 0000:65: resource 1 [mem 0xd7000000-0xd80fffff]
[    0.992524] pci_bus 0000:65: resource 2 [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.992578] pci_bus 0000:b2: resource 4 [io  0xc000-0xffff window]
[    0.992593] pci_bus 0000:b2: resource 5 [mem 0xd9000000-0xfbffffff window]
[    0.992609] pci_bus 0000:b2: resource 6 [mem 0x380300000000-0x3803ffffffff window]
[    0.994364] pci 0000:03:00.0: PME# does not work under D0, disabling it
[    0.994912] pci 0000:16:05.0: disabled boot interrupts on device [8086:2034]
[    0.995031] pci 0000:64:05.0: disabled boot interrupts on device [8086:2034]
[    0.995112] pci 0000:65:00.0: CLS mismatch (64 != 32), using 64 bytes
[    0.995130] pci 0000:65:00.1: extending delay after power-on from D3hot to 20 msec
[    0.995288] pci 0000:65:00.1: D0 power state depends on 0000:65:00.0
[    0.995366] pci 0000:b2:05.0: disabled boot interrupts on device [8086:2034]
[    0.995531] Unpacking initramfs...
[    0.995565] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.995582] software IO TLB: mapped [mem 0x000000004c000000-0x0000000050000000] (64MB)
[    0.998536] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    0.998554] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.998568] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    1.023715] Initialise system trusted keyrings
[    1.023814] workingset: timestamp_bits=46 max_order=24 bucket_order=0
[    1.024697] Key type cifs.idmap registered
[    1.024837] fuse: init (API version 7.39)
[    1.031967] NET: Registered PF_ALG protocol family
[    1.031988] xor: automatically using best checksumming function   avx       
[    1.032004] Key type asymmetric registered
[    1.032018] Asymmetric key parser 'x509' registered
[    1.032051] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    1.033130] pcieport 0000:00:1b.0: PME: Signaling with IRQ 24
[    1.033774] pcieport 0000:00:1c.0: PME: Signaling with IRQ 25
[    1.034046] pcieport 0000:00:1c.4: PME: Signaling with IRQ 26
[    1.034655] pcieport 0000:00:1d.0: PME: Signaling with IRQ 27
[    1.034738] pcieport 0000:00:1d.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.035558] pcieport 0000:64:00.0: PME: Signaling with IRQ 29
[    1.036052] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.036099] efifb: probing for efifb
[    1.036120] efifb: framebuffer at 0xd1000000, using 3072k, total 3072k
[    1.036136] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.036150] efifb: scrolling: redraw
[    1.036159] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.037574] Console: switching to colour frame buffer device 128x48
[    1.038800] fb0: EFI VGA frame buffer device
[    1.038952] Monitor-Mwait will be used to enter C-1 state
[    1.038969] Monitor-Mwait will be used to enter C-2 state
[    1.038978] ACPI: \_SB_.SCK0.CP00: Found 2 idle states
[    1.044055] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    1.044165] ACPI: button: Sleep Button [SLPB]
[    1.044325] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.044424] ACPI: button: Power Button [PWRB]
[    1.044547] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.045595] ACPI: button: Power Button [PWRF]
[    1.052230] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.053624] Non-volatile memory driver v1.3
[    1.065882] ACPI: bus type drm_connector registered
[    1.066376] Console: switching to colour dummy device 80x25
[    1.066427] nouveau 0000:65:00.0: vgaarb: deactivate vga console
[    1.066542] nouveau 0000:65:00.0: NVIDIA GP104 (134000a1)
[    1.176385] nouveau 0000:65:00.0: bios: version 86.04.60.40.1f
[    1.177277] nouveau 0000:65:00.0: pmu: firmware unavailable
[    1.178557] nouveau 0000:65:00.0: fb: 8192 MiB GDDR5X
[    1.208538] nouveau 0000:65:00.0: DRM: VRAM: 8192 MiB
[    1.208555] nouveau 0000:65:00.0: DRM: GART: 536870912 MiB
[    1.208567] nouveau 0000:65:00.0: DRM: BIT table 'A' not found
[    1.208580] nouveau 0000:65:00.0: DRM: BIT table 'L' not found
[    1.208592] nouveau 0000:65:00.0: DRM: TMDS table version 2.0
[    1.208605] nouveau 0000:65:00.0: DRM: DCB version 4.1
[    1.208616] nouveau 0000:65:00.0: DRM: DCB outp 00: 01000f42 00020030
[    1.208630] nouveau 0000:65:00.0: DRM: DCB outp 01: 04811f96 04600020
[    1.208645] nouveau 0000:65:00.0: DRM: DCB outp 02: 04011f92 00020020
[    1.208658] nouveau 0000:65:00.0: DRM: DCB outp 03: 04822f86 04600010
[    1.208672] nouveau 0000:65:00.0: DRM: DCB outp 04: 04022f82 00020010
[    1.208685] nouveau 0000:65:00.0: DRM: DCB outp 06: 02033f62 00020010
[    1.208699] nouveau 0000:65:00.0: DRM: DCB outp 07: 02844f76 04600020
[    1.208712] nouveau 0000:65:00.0: DRM: DCB outp 08: 02044f72 00020020
[    1.208726] nouveau 0000:65:00.0: DRM: DCB conn 00: 00001031
[    1.208738] nouveau 0000:65:00.0: DRM: DCB conn 01: 02000146
[    1.208750] nouveau 0000:65:00.0: DRM: DCB conn 02: 01000246
[    1.208762] nouveau 0000:65:00.0: DRM: DCB conn 03: 00010361
[    1.208774] nouveau 0000:65:00.0: DRM: DCB conn 04: 00020446
[    1.210397] nouveau 0000:65:00.0: DRM: MM: using COPY for buffer copies
[    1.210629] Freeing initrd memory: 2792K
[    1.267706] [drm] Initialized nouveau 1.4.0 20120801 for 0000:65:00.0 on minor 0
[    1.364706] fbcon: nouveaudrmfb (fb0) is primary device
[    1.533559] Console: switching to colour frame buffer device 480x135
[    1.561349] nouveau 0000:65:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[    1.578517] loop: module loaded
[    1.579977] ahci 0000:00:17.0: version 3.0
[    1.590659] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    1.590692] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sadm sds apst 
[    1.613474] scsi host0: ahci
[    1.613899] scsi host1: ahci
[    1.614269] scsi host2: ahci
[    1.614617] scsi host3: ahci
[    1.615041] scsi host4: ahci
[    1.615410] scsi host5: ahci
[    1.615782] scsi host6: ahci
[    1.616050] scsi host7: ahci
[    1.616195] ata1: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b100 irq 32
[    1.616219] ata2: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b180 irq 32
[    1.616241] ata3: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b200 irq 32
[    1.616262] ata4: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b280 irq 32
[    1.616283] ata5: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b300 irq 32
[    1.616304] ata6: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b380 irq 32
[    1.616325] ata7: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b400 irq 32
[    1.616346] ata8: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b480 irq 32
[    1.616942] tun: Universal TUN/TAP device driver, 1.6
[    1.617063] e1000e: Intel(R) PRO/1000 Network Driver
[    1.617079] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.617560] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.926370] ata8: SATA link down (SStatus 4 SControl 300)
[    1.926409] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.926534] ata7: SATA link down (SStatus 4 SControl 300)
[    1.926570] ata6: SATA link down (SStatus 4 SControl 300)
[    1.926607] ata3: SATA link down (SStatus 4 SControl 300)
[    1.926645] ata4: SATA link down (SStatus 4 SControl 300)
[    1.926687] ata5: SATA link down (SStatus 4 SControl 300)
[    1.926740] ata1: SATA link down (SStatus 4 SControl 300)
[    1.927128] ata2.00: ATA-10: INTEL SSDSC2KW010T8,  LHF0B1C, max UDMA/133
[    1.927194] ata2.00: 2000409264 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.927592] ata2.00: Features: Dev-Sleep
[    1.928162] ata2.00: configured for UDMA/133
[    1.928353] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2KW01 0B1C PQ: 0 ANSI: 5
[    1.929085] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    1.929248] ata2.00: Enabling discard_zeroes_data
[    1.929416] sd 1:0:0:0: [sda] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    1.929467] sd 1:0:0:0: [sda] Write Protect is off
[    1.929491] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.929554] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.929642] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    1.930896] ata2.00: Enabling discard_zeroes_data
[    1.932401]  sda: sda1 sda2
[    1.932650] sd 1:0:0:0: [sda] Attached SCSI disk
[    2.039637] tsc: Refined TSC clocksource calibration: 2807.999 MHz
[    2.039743] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2879c523a63, max_idle_ns: 440795252908 ns
[    2.039901] clocksource: Switched to clocksource tsc
[    2.060569] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) e0:d5:5e:e3:99:9a
[    2.060605] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    2.060714] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    2.060836] usbcore: registered new device driver r8152-cfgselector
[    2.060869] usbcore: registered new interface driver r8152
[    2.060901] usbcore: registered new interface driver asix
[    2.060931] usbcore: registered new interface driver ax88179_178a
[    2.060963] usbcore: registered new interface driver cdc_ether
[    2.060994] usbcore: registered new interface driver net1080
[    2.061024] usbcore: registered new interface driver cdc_subset
[    2.061055] usbcore: registered new interface driver zaurus
[    2.061087] usbcore: registered new interface driver cdc_ncm
[    2.061117] usbcore: registered new interface driver r8153_ecm
[    2.061720] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.061760] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.062888] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    2.063576] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.063610] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.063639] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.064532] hub 1-0:1.0: USB hub found
[    2.064661] hub 1-0:1.0: 16 ports detected
[    2.071362] hub 2-0:1.0: USB hub found
[    2.071415] hub 2-0:1.0: 10 ports detected
[    2.074941] usb: port power management may be unreliable
[    2.075475] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.075533] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 3
[    2.130400] xhci_hcd 0000:03:00.0: hcc params 0x0200ef80 hci version 0x110 quirks 0x0000000000800010
[    2.131454] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.131553] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 4
[    2.131650] xhci_hcd 0000:03:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.132204] hub 3-0:1.0: USB hub found
[    2.132287] hub 3-0:1.0: 2 ports detected
[    2.132626] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.133140] hub 4-0:1.0: USB hub found
[    2.133232] hub 4-0:1.0: 2 ports detected
[    2.133690] usbcore: registered new interface driver usb-storage
[    2.133783] i8042: PNP: No PS/2 controller found.
[    2.133966] mousedev: PS/2 mouse device common for all mice
[    2.134229] rtc_cmos 00:00: RTC can wake from S4
[    2.135183] rtc_cmos 00:00: registered as rtc0
[    2.135492] rtc_cmos 00:00: setting system clock to 2023-10-04T04:45:20 UTC (1696394720)
[    2.135665] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
[    2.135858] i801_smbus 0000:00:1f.4: enabling device (0001 -> 0003)
[    2.135923] usbcore: registered new interface driver uvcvideo
[    2.136263] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.136322] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.136455] pci 0000:00:1f.1: [8086:a2a0] type 00 class 0x058000
[    2.136544] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
[    2.139049] i2c i2c-17: 4/8 memory slots populated (from DMI)
[    2.139074] i2c i2c-17: Systems with more than 4 memory slots not supported yet, not instantiating SPD
[    2.140600] device-mapper: uevent: version 1.0.3
[    2.140774] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    2.140924] Bluetooth: HCI UART driver ver 2.3
[    2.140971] usbcore: registered new interface driver btusb
[    2.140991] intel_pstate: Intel P-state driver initializing
[    2.147517] intel_pstate: HWP enabled
[    2.147590] sdhci: Secure Digital Host Controller Interface driver
[    2.147616] sdhci: Copyright(c) Pierre Ossman
[    2.148250] ledtrig-cpu: registered to indicate activity on CPUs
[    2.148382] pstore: Using crash dump compression: deflate
[    2.149882] pstore: Registered efi_pstore as persistent store backend
[    2.152663] hid: raw HID events driver (C) Jiri Kosina
[    2.154601] usbcore: registered new interface driver usbhid
[    2.156211] usbhid: USB HID core driver
[    2.159221] usbcore: registered new interface driver snd-usb-audio
[    2.162488] IPVS: Registered protocols (TCP, UDP)
[    2.164605] IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
[    2.166844] IPVS: ipvs loaded.
[    2.168939] IPVS: [rr] scheduler registered.
[    2.170409] NET: Registered PF_INET6 protocol family
[    2.172772] Segment Routing with IPv6
[    2.174105] In-situ OAM (IOAM) with IPv6
[    2.175473] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.181399] bpfilter: Loaded bpfilter_umh pid 311
[    2.182357] NET: Registered PF_PACKET protocol family
[    2.183297] Bridge firewalling registered
[    2.184381] Bluetooth: RFCOMM TTY layer initialized
[    2.185282] Bluetooth: RFCOMM socket layer initialized
[    2.186193] Bluetooth: RFCOMM ver 1.11
[    2.187093] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.187987] Bluetooth: BNEP filters: protocol multicast
[    2.188881] Bluetooth: BNEP socket layer initialized
[    2.189777] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.190631] Bluetooth: HIDP socket layer initialized
[    2.191485] 8021q: 802.1Q VLAN Support v1.8
[    2.192396] Key type dns_resolver registered
[    2.193478] NET: Registered PF_VSOCK protocol family
[    2.213601] microcode: Microcode Update Driver: v2.2.
[    2.213611] IPI shorthand broadcast: enabled
[    2.216157] AVX2 version of gcm_enc/dec engaged.
[    2.217715] AES CTR mode by8 optimization enabled
[    2.243876] sched_clock: Marking stable (2241002682, 2503699)->(2262103273, -18596892)
[    2.247685] registered taskstats version 1
[    2.266784] Loading compiled-in X.509 certificates
[    2.284728] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[    2.314610] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    2.422631] Btrfs loaded, zoned=no, fsverity=no
[    2.424451] Key type trusted registered
[    2.429058] clk: Disabling unused clocks
[    2.430237] ALSA device list:
[    2.431383]   No soundcards found.
[    2.438578] Freeing unused kernel image (initmem) memory: 8364K
[    2.449597] Write protecting the kernel read-only data: 30720k
[    2.451688] Freeing unused kernel image (rodata/data gap) memory: 264K
[    2.451827] input: TrulyErgonomic.com Truly Ergonomic Computer Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:0E6A:030C.0001/input/input3
[    2.456024] Run /init as init process
[    2.456027]   with arguments:
[    2.456030]     /init
[    2.456031]     dolvm
[    2.456033]   with environment:
[    2.456035]     HOME=/
[    2.456036]     TERM=linux
[    2.511697] hid-generic 0003:0E6A:030C.0001: input,hidraw0: USB HID v1.11 Keyboard [TrulyErgonomic.com Truly Ergonomic Computer Keyboard] on usb-0000:00:14.0-2/input0
[    2.514423] input: TrulyErgonomic.com Truly Ergonomic Computer Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:0E6A:030C.0002/input/input4
[    2.566079] hid-generic 0003:0E6A:030C.0002: input,hidraw1: USB HID v1.11 Device [TrulyErgonomic.com Truly Ergonomic Computer Keyboard] on usb-0000:00:14.0-2/input1
[    2.681559] usb 1-6: new full-speed USB device number 3 using xhci_hcd
[    2.822680] logitech-djreceiver 0003:046D:C52B.0005: hiddev0,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-6/input2
[    2.940234] input: Logitech Performance MX as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.2/0003:046D:C52B.0005/0003:046D:101A.0006/input/input5
[    2.940889] logitech-hidpp-device 0003:046D:101A.0006: input,hidraw3: USB HID v1.11 Mouse [Logitech Performance MX] on usb-0000:00:14.0-6/input2:1
[    2.948418] input: Logitech MX Master 2S as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.2/0003:046D:C52B.0005/0003:046D:4069.0007/input/input6
[    2.949835] logitech-hidpp-device 0003:046D:4069.0007: input,hidraw4: USB HID v1.11 Keyboard [Logitech MX Master 2S] on usb-0000:00:14.0-6/input2:2
[    2.956551] input: Logitech MX Vertical as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.2/0003:046D:C52B.0005/0003:046D:407B.0008/input/input7
[    2.957960] logitech-hidpp-device 0003:046D:407B.0008: input,hidraw5: USB HID v1.11 Keyboard [Logitech MX Vertical] on usb-0000:00:14.0-6/input2:3
[    3.041639] usb 1-9: new full-speed USB device number 4 using xhci_hcd
[    3.178113] input: Kensington Expert Wireless TB Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:047D:8018.0009/input/input8
[    3.178816] input: Kensington Expert Wireless TB Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:047D:8018.0009/input/input9
[    3.231197] hid-generic 0003:047D:8018.0009: input,hidraw6: USB HID v1.11 Mouse [Kensington Expert Wireless TB] on usb-0000:00:14.0-9/input0
[    3.234393] hid-generic 0003:047D:8018.000A: hiddev1,hidraw7: USB HID v1.10 Device [Kensington Expert Wireless TB] on usb-0000:00:14.0-9/input1
[    3.348612] usb 1-10: new full-speed USB device number 5 using xhci_hcd
[    3.381461] EXT4-fs (dm-0): mounted filesystem 2002ff65-fa47-45a9-827f-22f08fe2e5a6 ro with ordered data mode. Quota mode: none.
[    3.483977] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[    3.485036] Bluetooth: hci0: RTL: rom_version status=0 version=1
[    3.485045] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[    3.485647] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
[    3.485698] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
[    3.634113] Bluetooth: hci0: RTL: fw version 0xdfc6d922
[    7.433772] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    9.663358] EXT4-fs (dm-0): re-mounted 2002ff65-fa47-45a9-827f-22f08fe2e5a6 r/w. Quota mode: none.
[    9.707429] EXT4-fs (dm-0): re-mounted 2002ff65-fa47-45a9-827f-22f08fe2e5a6 r/w. Quota mode: none.
[   10.124221] Adding 67108860k swap on /dev/mapper/box-swap.  Priority:-2 extents:1 across:67108860k SS
[   32.101121] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   32.872260] EXT4-fs (dm-3): mounted filesystem 59b57016-ad18-4cdd-99ee-54b85a9dbb64 r/w with ordered data mode. Quota mode: none.
[   36.438007] CIFS: Attempting to mount //node/video
[   36.673701] CIFS: Attempting to mount //node/music
[   45.975541] pipewire[3750]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set

--fq34hsvlnldgmiyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.good"

[    0.000000] microcode: updated early: 0x2000065 -> 0x2007006, date = 2023-03-06
[    0.000000] Linux version 6.6.0-rc4-00002-g243ada785372 (kas@box) (gcc (Gentoo 13.2.1_p20230826 p7) 13.2.1 20230826, GNU ld (Gentoo 2.41 p2) 2.41.0) #244 SMP PREEMPT_DYNAMIC Tue Oct  3 20:47:28 +03 2023
[    0.000000] Command line: initrd=\initramfs
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003560dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000003560e000-0x00000000365f6fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000365f7000-0x000000003661efff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000003661f000-0x0000000037786fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000037787000-0x0000000038657fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000038658000-0x000000004fffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000050000000-0x000000006fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000109fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] e820: update [mem 0x2bc65018-0x2bc75e57] usable ==> usable
[    0.000000] e820: update [mem 0x2bc65018-0x2bc75e57] usable ==> usable
[    0.000000] e820: update [mem 0x2bc45018-0x2bc64a57] usable ==> usable
[    0.000000] e820: update [mem 0x2bc45018-0x2bc64a57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000002bc45017] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc45018-0x000000002bc64a57] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc64a58-0x000000002bc65017] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc65018-0x000000002bc75e57] usable
[    0.000000] reserve setup_data: [mem 0x000000002bc75e58-0x000000003560dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000003560e000-0x00000000365f6fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000365f7000-0x000000003661efff] ACPI data
[    0.000000] reserve setup_data: [mem 0x000000003661f000-0x0000000037786fff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000037787000-0x0000000038657fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000038658000-0x000000004fffffff] usable
[    0.000000] reserve setup_data: [mem 0x0000000050000000-0x000000006fffffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000109fffffff] usable
[    0.000000] efi: EFI v2.6 by American Megatrends
[    0.000000] efi: TPMFinalLog=0x37755000 ACPI 2.0=0x36916000 ACPI=0x36916000 SMBIOS=0x384ba000 SMBIOS 3.0=0x384b9000 ESRT=0x33af7898 MEMATTR=0x33af1018 INITRD=0x2bf32f18 TPMEventLog=0x2bc76018 
[    0.000000] efi: Remove mem25: MMIO range=[0x60000000-0x6fffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0x60000000-0x6fffffff] reserved
[    0.000000] efi: Not removing mem26: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem27: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem28: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem29: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem30: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.0.0 present.
[    0.000000] DMI: Gigabyte Technology Co., Ltd. X299 AORUS Gaming 3 Pro/X299 AORUS Gaming 3 Pro-CF, BIOS F5d 11/28/2019
[    0.000000] tsc: Detected 2800.000 MHz processor
[    0.000000] tsc: Detected 2799.927 MHz TSC
[    0.000000] [Firmware Bug]: TSC ADJUST: CPU0: -39261671193163 force to 0
[    0.000526] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000531] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000538] last_pfn = 0x10a0000 max_arch_pfn = 0x400000000
[    0.000542] MTRR map: 6 entries (3 fixed + 3 variable; max 23), built from 10 variable MTRRs
[    0.000545] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000926] e820: update [mem 0x5f000000-0xffffffff] usable ==> reserved
[    0.000931] last_pfn = 0x50000 max_arch_pfn = 0x400000000
[    0.006573] found SMP MP-table at [mem 0x000fcfd0-0x000fcfdf]
[    0.006583] esrt: Reserving ESRT space from 0x0000000033af7898 to 0x0000000033af78d0.
[    0.006588] e820: update [mem 0x33af7000-0x33af7fff] usable ==> reserved
[    0.006601] Using GB pages for direct mapping
[    0.007002] Secure boot disabled
[    0.007003] RAMDISK: [mem 0x2bc78000-0x2bf31fff]
[    0.007007] ACPI: Early table checksum verification disabled
[    0.007010] ACPI: RSDP 0x0000000036916000 000024 (v02 ALASKA)
[    0.007014] ACPI: XSDT 0x00000000369160D8 000134 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007021] ACPI: FACP 0x0000000036935A38 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
[    0.007027] ACPI: DSDT 0x00000000369162A8 01F78F (v02 ALASKA A M I    01072009 INTL 20160422)
[    0.007031] ACPI: FACS 0x0000000037754080 000040
[    0.007034] ACPI: FPDT 0x0000000036935B50 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007038] ACPI: FIDT 0x0000000036935B98 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007042] ACPI: SSDT 0x0000000036935C38 007A4B (v01 GBT    GSWApp   00000001 INTL 20160422)
[    0.007046] ACPI: UEFI 0x000000003693D688 000042 (v01 ALASKA A M I    00000002      01000013)
[    0.007049] ACPI: MCFG 0x000000003693D6D0 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
[    0.007053] ACPI: HPET 0x000000003693D710 000038 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007057] ACPI: APIC 0x000000003693D748 00071E (v03 ALASKA A M I    00000000 INTL 20091013)
[    0.007061] ACPI: MCFG 0x000000003693DE68 00003C (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007065] ACPI: MIGT 0x000000003693DEA8 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.007068] ACPI: MSCT 0x000000003693DEE8 00004E (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007072] ACPI: PCCT 0x000000003693DF38 00006E (v01 ALASKA A M I    00000002 INTL 20091013)
[    0.007076] ACPI: RASF 0x000000003693DFA8 000030 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007079] ACPI: SLIT 0x000000003693DFD8 00006C (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007083] ACPI: SRAT 0x000000003693E048 000A30 (v03 ALASKA A M I    00000002 INTL 20091013)
[    0.007087] ACPI: SVOS 0x000000003693EA78 000032 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.007091] ACPI: WDDT 0x000000003693EAB0 000040 (v01 ALASKA A M I    00000000 INTL 20091013)
[    0.007095] ACPI: OEM4 0x000000003693EAF0 029A72 (v02 INTEL  CPU  CST 00003000 INTL 20160422)
[    0.007099] ACPI: OEM1 0x0000000036968568 00ABCB (v02 INTEL  CPU EIST 00003000 INTL 20160422)
[    0.007103] ACPI: OEM2 0x0000000036973138 006AB0 (v02 INTEL  CPU  HWP 00003000 INTL 20160422)
[    0.007106] ACPI: SSDT 0x0000000036979BE8 00D427 (v02 INTEL  SSDT  PM 00004000 INTL 20160422)
[    0.007110] ACPI: NITR 0x0000000036987010 000071 (v02 ALASKA A M I    00000001 INTL 20091013)
[    0.007114] ACPI: SSDT 0x0000000036987088 000956 (v02 ALASKA A M I    00000000 INTL 20091013)
[    0.007118] ACPI: LPIT 0x00000000369879E0 000094 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.007122] ACPI: WSMT 0x0000000036987A78 000028 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.007125] ACPI: WDAT 0x0000000036987AA0 000134 (v01 INTEL  SKL      00000000 MSFT 0000005F)
[    0.007129] ACPI: SSDT 0x0000000036987BD8 00029F (v02 INTEL  sensrhub 00000000 INTL 20160422)
[    0.007133] ACPI: SSDT 0x0000000036987E78 003002 (v02 INTEL  PtidDevc 00001000 INTL 20160422)
[    0.007137] ACPI: DBGP 0x000000003698AE80 000034 (v01 INTEL           00000002 MSFT 0000005F)
[    0.007140] ACPI: DBG2 0x000000003698AEB8 000054 (v00 INTEL           00000002 MSFT 0000005F)
[    0.007144] ACPI: BGRT 0x000000003698AF10 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007148] ACPI: TPM2 0x000000003698AF48 000034 (v03 ALASKA A M I    00000001 AMI  00000000)
[    0.007151] ACPI: DMAR 0x000000003698AF80 0000D8 (v01 ALASKA A M I    00000001 INTL 20091013)
[    0.007155] ACPI: WSMT 0x000000003698B058 000028 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.007159] ACPI: Reserving FACP table memory at [mem 0x36935a38-0x36935b4b]
[    0.007160] ACPI: Reserving DSDT table memory at [mem 0x369162a8-0x36935a36]
[    0.007162] ACPI: Reserving FACS table memory at [mem 0x37754080-0x377540bf]
[    0.007163] ACPI: Reserving FPDT table memory at [mem 0x36935b50-0x36935b93]
[    0.007164] ACPI: Reserving FIDT table memory at [mem 0x36935b98-0x36935c33]
[    0.007165] ACPI: Reserving SSDT table memory at [mem 0x36935c38-0x3693d682]
[    0.007166] ACPI: Reserving UEFI table memory at [mem 0x3693d688-0x3693d6c9]
[    0.007167] ACPI: Reserving MCFG table memory at [mem 0x3693d6d0-0x3693d70b]
[    0.007169] ACPI: Reserving HPET table memory at [mem 0x3693d710-0x3693d747]
[    0.007170] ACPI: Reserving APIC table memory at [mem 0x3693d748-0x3693de65]
[    0.007171] ACPI: Reserving MCFG table memory at [mem 0x3693de68-0x3693dea3]
[    0.007172] ACPI: Reserving MIGT table memory at [mem 0x3693dea8-0x3693dee7]
[    0.007173] ACPI: Reserving MSCT table memory at [mem 0x3693dee8-0x3693df35]
[    0.007174] ACPI: Reserving PCCT table memory at [mem 0x3693df38-0x3693dfa5]
[    0.007176] ACPI: Reserving RASF table memory at [mem 0x3693dfa8-0x3693dfd7]
[    0.007177] ACPI: Reserving SLIT table memory at [mem 0x3693dfd8-0x3693e043]
[    0.007178] ACPI: Reserving SRAT table memory at [mem 0x3693e048-0x3693ea77]
[    0.007179] ACPI: Reserving SVOS table memory at [mem 0x3693ea78-0x3693eaa9]
[    0.007180] ACPI: Reserving WDDT table memory at [mem 0x3693eab0-0x3693eaef]
[    0.007181] ACPI: Reserving OEM4 table memory at [mem 0x3693eaf0-0x36968561]
[    0.007183] ACPI: Reserving OEM1 table memory at [mem 0x36968568-0x36973132]
[    0.007184] ACPI: Reserving OEM2 table memory at [mem 0x36973138-0x36979be7]
[    0.007185] ACPI: Reserving SSDT table memory at [mem 0x36979be8-0x3698700e]
[    0.007186] ACPI: Reserving NITR table memory at [mem 0x36987010-0x36987080]
[    0.007187] ACPI: Reserving SSDT table memory at [mem 0x36987088-0x369879dd]
[    0.007188] ACPI: Reserving LPIT table memory at [mem 0x369879e0-0x36987a73]
[    0.007190] ACPI: Reserving WSMT table memory at [mem 0x36987a78-0x36987a9f]
[    0.007191] ACPI: Reserving WDAT table memory at [mem 0x36987aa0-0x36987bd3]
[    0.007192] ACPI: Reserving SSDT table memory at [mem 0x36987bd8-0x36987e76]
[    0.007193] ACPI: Reserving SSDT table memory at [mem 0x36987e78-0x3698ae79]
[    0.007194] ACPI: Reserving DBGP table memory at [mem 0x3698ae80-0x3698aeb3]
[    0.007195] ACPI: Reserving DBG2 table memory at [mem 0x3698aeb8-0x3698af0b]
[    0.007197] ACPI: Reserving BGRT table memory at [mem 0x3698af10-0x3698af47]
[    0.007198] ACPI: Reserving TPM2 table memory at [mem 0x3698af48-0x3698af7b]
[    0.007199] ACPI: Reserving DMAR table memory at [mem 0x3698af80-0x3698b057]
[    0.007200] ACPI: Reserving WSMT table memory at [mem 0x3698b058-0x3698b07f]
[    0.083247] Zone ranges:
[    0.083248]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.083251]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.083253]   Normal   [mem 0x0000000100000000-0x000000109fffffff]
[    0.083256] Movable zone start for each node
[    0.083257] Early memory node ranges
[    0.083257]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.083259]   node   0: [mem 0x0000000000100000-0x000000003560dfff]
[    0.083261]   node   0: [mem 0x0000000038658000-0x000000004fffffff]
[    0.083262]   node   0: [mem 0x0000000100000000-0x000000109fffffff]
[    0.083267] Initmem setup node 0 [mem 0x0000000000001000-0x000000109fffffff]
[    0.083271] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.083286] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.084399] On node 0, zone DMA32: 12362 pages in unavailable ranges
[    0.159560] ACPI: PM-Timer IO Port: 0x1808
[    0.159570] ACPI: X2APIC_NMI (uid[0xffffffff] high level lint[0x1])
[    0.159573] ACPI: LAPIC_NMI (acpi_id[0xff] high level lint[0x1])
[    0.159601] IOAPIC[0]: apic_id 8, version 32, address 0xfec00000, GSI 0-23
[    0.159606] IOAPIC[1]: apic_id 9, version 32, address 0xfec01000, GSI 24-31
[    0.159611] IOAPIC[2]: apic_id 10, version 32, address 0xfec08000, GSI 32-39
[    0.159616] IOAPIC[3]: apic_id 11, version 32, address 0xfec10000, GSI 40-47
[    0.159620] IOAPIC[4]: apic_id 12, version 32, address 0xfec18000, GSI 48-55
[    0.159623] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.159625] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.159630] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.159631] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.159634] TSC deadline timer available
[    0.159635] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.159652] [mem 0x60000000-0xfdffffff] available for PCI devices
[    0.159654] Booting paravirtualized kernel on bare hardware
[    0.159657] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.166022] setup_percpu: NR_CPUS:128 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    0.177721] percpu: Embedded 503 pages/cpu s2030888 r0 d29400 u2097152
[    0.177731] pcpu-alloc: s2030888 r0 d29400 u2097152 alloc=1*2097152
[    0.177735] pcpu-alloc: [0] 00 [0] 01 [0] 02 [0] 03 [0] 04 [0] 05 [0] 06 [0] 07 
[    0.177750] pcpu-alloc: [0] 08 [0] 09 [0] 10 [0] 11 [0] 12 [0] 13 [0] 14 [0] 15 
[    0.177765] pcpu-alloc: [0] 16 [0] 17 [0] 18 [0] 19 [0] 20 [0] 21 [0] 22 [0] 23 
[    0.177780] pcpu-alloc: [0] 24 [0] 25 [0] 26 [0] 27 [0] 28 [0] 29 [0] 30 [0] 31 
[    0.177802] Kernel command line: root=/dev/mapper/box-root dolvm rw rootfstype=ext4
[    0.177827] Unknown kernel command line parameters "dolvm", will be passed to user space.
[    0.177859] random: crng init done
[    0.177861] printk: log_buf_len individual max cpu contribution: 131072 bytes
[    0.177863] printk: log_buf_len total cpu_extra contributions: 4063232 bytes
[    0.177864] printk: log_buf_len min size: 524288 bytes
[    0.182723] printk: log_buf_len: 8388608 bytes
[    0.182726] printk: early log buf free: 509784(97%)
[    0.187439] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.190013] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.190344] Built 1 zonelists, mobility grouping on.  Total pages: 16438135
[    0.190349] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.190362] software IO TLB: area num 32.
[    0.328402] Memory: 65365780K/66796884K available (22528K kernel code, 4415K rwdata, 7928K rodata, 8364K init, 7508K bss, 1430848K reserved, 0K cma-reserved)
[    0.328569] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    0.328590] Kernel/User page tables isolation: enabled
[    0.328680] ftrace: allocating 58701 entries in 230 pages
[    0.339076] ftrace: allocated 230 pages with 5 groups
[    0.339184] Dynamic Preempt: full
[    0.339412] rcu: Preemptible hierarchical RCU implementation.
[    0.339413] rcu: 	RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=32.
[    0.339415] 	Trampoline variant of Tasks RCU enabled.
[    0.339416] 	Rude variant of Tasks RCU enabled.
[    0.339417] 	Tracing variant of Tasks RCU enabled.
[    0.339418] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.339419] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    0.342776] NR_IRQS: 8448, nr_irqs: 1224, preallocated irqs: 16
[    0.343030] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.343258] Console: colour dummy device 80x25
[    0.343264] printk: console [tty0] enabled
[    0.344969] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.344980] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.344986] ... MAX_LOCK_DEPTH:          48
[    0.344993] ... MAX_LOCKDEP_KEYS:        8192
[    0.345000] ... CLASSHASH_SIZE:          4096
[    0.345006] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.345013] ... MAX_LOCKDEP_CHAINS:      65536
[    0.345020] ... CHAINHASH_SIZE:          32768
[    0.345026]  memory used by lock dependency info: 4277 kB
[    0.345034]  per task-struct memory footprint: 2688 bytes
[    0.345062] ACPI: Core revision 20230628
[    0.345601] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.345691] APIC: Switch to symmetric I/O mode setup
[    0.345700] DMAR: Host address width 46
[    0.345706] DMAR: DRHD base: 0x000000b5ffc000 flags: 0x0
[    0.345721] DMAR: dmar0: reg_base_addr b5ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.345733] DMAR: DRHD base: 0x000000d8ffc000 flags: 0x0
[    0.345745] DMAR: dmar1: reg_base_addr d8ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.345757] DMAR: DRHD base: 0x000000fbffc000 flags: 0x0
[    0.345768] DMAR: dmar2: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.345780] DMAR: DRHD base: 0x00000092ffc000 flags: 0x1
[    0.345791] DMAR: dmar3: reg_base_addr 92ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
[    0.345802] DMAR: RMRR base: 0x0000003774e000 end: 0x00000037750fff
[    0.345812] DMAR: ATSR flags: 0x0
[    0.345820] DMAR-IR: IOAPIC id 12 under DRHD base  0xfbffc000 IOMMU 2
[    0.345829] DMAR-IR: IOAPIC id 11 under DRHD base  0xd8ffc000 IOMMU 1
[    0.345838] DMAR-IR: IOAPIC id 10 under DRHD base  0xb5ffc000 IOMMU 0
[    0.345847] DMAR-IR: IOAPIC id 8 under DRHD base  0x92ffc000 IOMMU 3
[    0.345856] DMAR-IR: IOAPIC id 9 under DRHD base  0x92ffc000 IOMMU 3
[    0.345865] DMAR-IR: HPET id 0 under DRHD base 0x92ffc000
[    0.345873] DMAR-IR: x2apic is disabled because BIOS sets x2apic opt out bit.
[    0.345874] DMAR-IR: Use 'intremap=no_x2apic_optout' to override the BIOS setting.
[    0.346873] DMAR-IR: Enabled IRQ remapping in xapic mode
[    0.346883] x2apic: IRQ remapping doesn't support X2APIC mode
[    0.347060] APIC: Switched APIC routing to: physical flat
[    0.348309] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.352676] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x285bfbafad2, max_idle_ns: 440795215530 ns
[    0.352697] Calibrating delay loop (skipped), value calculated using timer frequency.. 5599.85 BogoMIPS (lpj=2799927)
[    0.352736] CPU0: Thermal monitoring enabled (TM1)
[    0.352816] process: using mwait in idle threads
[    0.352826] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.352835] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.352850] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.352864] Spectre V2 : Mitigation: IBRS
[    0.352873] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.352891] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    0.352906] RETBleed: Mitigation: IBRS
[    0.352917] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.352935] Spectre V2 : User space: Mitigation: STIBP via prctl
[    0.352949] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.352984] MDS: Mitigation: Clear CPU buffers
[    0.352996] TAA: Mitigation: Clear CPU buffers
[    0.353007] MMIO Stale Data: Mitigation: Clear CPU buffers
[    0.353027] GDS: Mitigation: Microcode
[    0.353045] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.353064] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.353080] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.353095] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.353111] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.353125] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    0.353141] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    0.353156] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256'
[    0.353172] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.353187] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.353203] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.353218] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    0.353233] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    0.353248] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    0.353263] x86/fpu: Enabled xstate features 0xff, context size is 2560 bytes, using 'compacted' format.
[    0.377751] Freeing SMP alternatives memory: 48K
[    0.377765] pid_max: default: 32768 minimum: 301
[    0.386478] LSM: initializing lsm=capability
[    0.386599] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.386680] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.387515] smpboot: CPU0: Intel(R) Core(TM) i9-7960X CPU @ 2.80GHz (family: 0x6, model: 0x55, stepping: 0x4)
[    0.387694] RCU Tasks: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.387694] RCU Tasks Rude: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.387694] RCU Tasks Trace: Setting shift to 5 and lim to 1 rcu_task_cb_adjust=1.
[    0.387694] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.387694] ... version:                4
[    0.387694] ... bit width:              48
[    0.387694] ... generic registers:      4
[    0.387694] ... value mask:             0000ffffffffffff
[    0.387694] ... max period:             00007fffffffffff
[    0.387694] ... fixed-purpose events:   3
[    0.387694] ... event mask:             000000070000000f
[    0.387715] signal: max sigframe size: 3632
[    0.387749] Estimated ratio of average max frequency by base frequency (times 1024): 1462
[    0.387832] rcu: Hierarchical SRCU implementation.
[    0.387844] rcu: 	Max phase no-delay instances is 400.
[    0.389929] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.390553] smp: Bringing up secondary CPUs ...
[    0.390878] smpboot: x86: Booting SMP configuration:
[    0.390891] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7  #8  #9 #10 #11 #12 #13 #14 #15
[    0.003537] [Firmware Bug]: TSC ADJUST differs within socket(s), fixing all errors
[    0.403823]  #16 #17 #18 #19 #20 #21 #22 #23 #24 #25 #26 #27 #28 #29 #30 #31
[    0.413457] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    0.413457] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
[    0.413457] MMIO Stale Data CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_stale_data.html for more details.
[    0.416808] smp: Brought up 1 node, 32 CPUs
[    0.416808] smpboot: Max logical packages: 1
[    0.416808] smpboot: Total of 32 processors activated (179195.32 BogoMIPS)
[    0.420175] devtmpfs: initialized
[    0.420175] x86/mm: Memory block size: 2048MB
[    0.422399] ACPI: PM: Registering ACPI NVS region [mem 0x3661f000-0x37786fff] (18251776 bytes)
[    0.424245] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.424273] futex hash table entries: 8192 (order: 8, 1048576 bytes, linear)
[    0.424910] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.425517] audit: initializing netlink subsys (disabled)
[    0.425582] audit: type=2000 audit(1696355475.079:1): state=initialized audit_enabled=0 res=1
[    0.425859] thermal_sys: Registered thermal governor 'fair_share'
[    0.425862] thermal_sys: Registered thermal governor 'step_wise'
[    0.425877] thermal_sys: Registered thermal governor 'user_space'
[    0.425977] cpuidle: using governor ladder
[    0.425977] cpuidle: using governor menu
[    0.425977] Detected 1 PCC Subspaces
[    0.425977] Registering PCC driver as Mailbox controller
[    0.426066] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.426066] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x60000000-0x6fffffff] (base 0x60000000)
[    0.426066] PCI: not using MMCONFIG
[    0.426066] PCI: Using configuration type 1 for base access
[    0.428365] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.429917] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.429939] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.429961] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.429982] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.430726] cryptd: max_cpu_qlen set to 1000
[    0.446747] raid6: avx512x4 gen() 50942 MB/s
[    0.463770] raid6: avx512x2 gen() 50895 MB/s
[    0.480791] raid6: avx512x1 gen() 47605 MB/s
[    0.497813] raid6: avx2x4   gen() 31067 MB/s
[    0.514835] raid6: avx2x2   gen() 36645 MB/s
[    0.531857] raid6: avx2x1   gen() 30899 MB/s
[    0.531869] raid6: using algorithm avx512x4 gen() 50942 MB/s
[    0.548879] raid6: .... xor() 8318 MB/s, rmw enabled
[    0.548892] raid6: using avx512x2 recovery algorithm
[    0.549114] ACPI: Added _OSI(Module Device)
[    0.549126] ACPI: Added _OSI(Processor Device)
[    0.549139] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.549151] ACPI: Added _OSI(Processor Aggregator Device)
[    0.611428] ACPI: 6 ACPI AML tables successfully acquired and loaded
[    0.658218] ACPI: Dynamic OEM Table Load:
[    0.678016] ACPI: Dynamic OEM Table Load:
[    0.690296] ACPI: Dynamic OEM Table Load:
[    0.794508] ACPI: _OSC evaluated successfully for all CPUs
[    0.795636] ACPI: Interpreter enabled
[    0.795688] ACPI: PM: (supports S0 S3 S5)
[    0.795699] ACPI: Using IOAPIC for interrupt routing
[    0.795767] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x60000000-0x6fffffff] (base 0x60000000)
[    0.799888] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.799917] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.804050] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.804078] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.808204] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.808232] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.812357] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.812385] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.816493] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.816521] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.816554] [Firmware Info]: PCI: MMCONFIG at [mem 0x60000000-0x6fffffff] not reserved in ACPI motherboard resources
[    0.816577] PCI: MMCONFIG at [mem 0x60000000-0x6fffffff] reserved as EfiMemoryMappedIO
[    0.816607] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.816627] PCI: Using E820 reservations for host bridge windows
[    0.818135] ACPI: Enabled 9 GPEs in block 00 to 7F
[    0.884486] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.884517] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.903119] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-15])
[    0.903140] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.903333] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.903667] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.907419] PCI host bridge to bus 0000:00
[    0.907431] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.907451] pci_bus 0000:00: root bus resource [io  0x1000-0x3fff window]
[    0.907467] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    0.907484] pci_bus 0000:00: root bus resource [mem 0xfe010000-0xfe010fff window]
[    0.907502] pci_bus 0000:00: root bus resource [mem 0x70000000-0x92ffffff window]
[    0.907519] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x3800ffffffff window]
[    0.907538] pci_bus 0000:00: root bus resource [bus 00-15]
[    0.907646] pci 0000:00:00.0: [8086:2020] type 00 class 0x060000
[    0.908027] pci 0000:00:04.0: [8086:2021] type 00 class 0x088000
[    0.908059] pci 0000:00:04.0: reg 0x10: [mem 0x92f64000-0x92f67fff 64bit]
[    0.908368] pci 0000:00:04.1: [8086:2021] type 00 class 0x088000
[    0.908399] pci 0000:00:04.1: reg 0x10: [mem 0x92f60000-0x92f63fff 64bit]
[    0.908709] pci 0000:00:04.2: [8086:2021] type 00 class 0x088000
[    0.908741] pci 0000:00:04.2: reg 0x10: [mem 0x92f5c000-0x92f5ffff 64bit]
[    0.909047] pci 0000:00:04.3: [8086:2021] type 00 class 0x088000
[    0.909078] pci 0000:00:04.3: reg 0x10: [mem 0x92f58000-0x92f5bfff 64bit]
[    0.909382] pci 0000:00:04.4: [8086:2021] type 00 class 0x088000
[    0.909414] pci 0000:00:04.4: reg 0x10: [mem 0x92f54000-0x92f57fff 64bit]
[    0.909719] pci 0000:00:04.5: [8086:2021] type 00 class 0x088000
[    0.909751] pci 0000:00:04.5: reg 0x10: [mem 0x92f50000-0x92f53fff 64bit]
[    0.910059] pci 0000:00:04.6: [8086:2021] type 00 class 0x088000
[    0.910090] pci 0000:00:04.6: reg 0x10: [mem 0x92f4c000-0x92f4ffff 64bit]
[    0.910405] pci 0000:00:04.7: [8086:2021] type 00 class 0x088000
[    0.910437] pci 0000:00:04.7: reg 0x10: [mem 0x92f48000-0x92f4bfff 64bit]
[    0.910750] pci 0000:00:05.0: [8086:2024] type 00 class 0x088000
[    0.911048] pci 0000:00:05.2: [8086:2025] type 00 class 0x088000
[    0.911258] pci 0000:00:05.4: [8086:2026] type 00 class 0x080020
[    0.911287] pci 0000:00:05.4: reg 0x10: [mem 0x92f6e000-0x92f6efff]
[    0.911538] pci 0000:00:08.0: [8086:2014] type 00 class 0x088000
[    0.911817] pci 0000:00:08.1: [8086:2015] type 00 class 0x110100
[    0.911990] pci 0000:00:08.2: [8086:2016] type 00 class 0x088000
[    0.912231] pci 0000:00:14.0: [8086:a2af] type 00 class 0x0c0330
[    0.912273] pci 0000:00:14.0: reg 0x10: [mem 0x92f30000-0x92f3ffff 64bit]
[    0.912383] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.913185] pci 0000:00:16.0: [8086:a2ba] type 00 class 0x078000
[    0.913227] pci 0000:00:16.0: reg 0x10: [mem 0x92f6d000-0x92f6dfff 64bit]
[    0.913334] pci 0000:00:16.0: PME# supported from D3hot
[    0.913623] pci 0000:00:17.0: [8086:a282] type 00 class 0x010601
[    0.913658] pci 0000:00:17.0: reg 0x10: [mem 0x92f68000-0x92f69fff]
[    0.913684] pci 0000:00:17.0: reg 0x14: [mem 0x92f6c000-0x92f6c0ff]
[    0.913708] pci 0000:00:17.0: reg 0x18: [io  0x3050-0x3057]
[    0.913734] pci 0000:00:17.0: reg 0x1c: [io  0x3040-0x3043]
[    0.913759] pci 0000:00:17.0: reg 0x20: [io  0x3020-0x303f]
[    0.913784] pci 0000:00:17.0: reg 0x24: [mem 0x92f6b000-0x92f6b7ff]
[    0.913846] pci 0000:00:17.0: PME# supported from D3hot
[    0.914429] pci 0000:00:1b.0: [8086:a2e7] type 01 class 0x060400
[    0.914555] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    0.915615] pci 0000:00:1c.0: [8086:a290] type 01 class 0x060400
[    0.915743] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.916788] pci 0000:00:1c.4: [8086:a294] type 01 class 0x060400
[    0.916909] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.917969] pci 0000:00:1d.0: [8086:a298] type 01 class 0x060400
[    0.918093] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.919102] pci 0000:00:1f.0: [8086:a2d2] type 00 class 0x060100
[    0.919763] pci 0000:00:1f.2: [8086:a2a1] type 00 class 0x058000
[    0.919800] pci 0000:00:1f.2: reg 0x10: [mem 0x92f44000-0x92f47fff]
[    0.920351] pci 0000:00:1f.3: [8086:a2f0] type 00 class 0x040300
[    0.920394] pci 0000:00:1f.3: reg 0x10: [mem 0x92f40000-0x92f43fff 64bit]
[    0.920454] pci 0000:00:1f.3: reg 0x20: [mem 0x92f20000-0x92f2ffff 64bit]
[    0.920520] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.921225] pci 0000:00:1f.4: [8086:a2a3] type 00 class 0x0c0500
[    0.921297] pci 0000:00:1f.4: reg 0x10: [mem 0x92f6a000-0x92f6a0ff 64bit]
[    0.921383] pci 0000:00:1f.4: reg 0x20: [io  0x3000-0x301f]
[    0.921708] pci 0000:00:1f.6: [8086:15b8] type 00 class 0x020000
[    0.921750] pci 0000:00:1f.6: reg 0x10: [mem 0x92f00000-0x92f1ffff]
[    0.921912] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    0.922443] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.922551] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.922673] pci 0000:03:00.0: [1b21:2142] type 00 class 0x0c0330
[    0.922720] pci 0000:03:00.0: reg 0x10: [mem 0x92e00000-0x92e07fff 64bit]
[    0.922813] pci 0000:03:00.0: enabling Extended Tags
[    0.922903] pci 0000:03:00.0: PME# supported from D0
[    0.923197] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.923213] pci 0000:00:1c.4:   bridge window [mem 0x92e00000-0x92efffff]
[    0.923314] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    0.923367] pci_bus 0000:00: on NUMA node 0
[    0.925465] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 16-63])
[    0.925484] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.926623] acpi PNP0A08:01: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.927190] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.927700] PCI host bridge to bus 0000:16
[    0.927711] pci_bus 0000:16: root bus resource [io  0x4000-0x7fff window]
[    0.927728] pci_bus 0000:16: root bus resource [mem 0x93000000-0xb5ffffff window]
[    0.927746] pci_bus 0000:16: root bus resource [mem 0x380100000000-0x3801ffffffff window]
[    0.927765] pci_bus 0000:16: root bus resource [bus 16-63]
[    0.927807] pci 0000:16:05.0: [8086:2034] type 00 class 0x088000
[    0.928004] pci 0000:16:05.2: [8086:2035] type 00 class 0x088000
[    0.928197] pci 0000:16:05.4: [8086:2036] type 00 class 0x080020
[    0.928227] pci 0000:16:05.4: reg 0x10: [mem 0xb5f00000-0xb5f00fff]
[    0.928441] pci 0000:16:08.0: [8086:208d] type 00 class 0x088000
[    0.928679] pci 0000:16:08.1: [8086:208d] type 00 class 0x088000
[    0.928836] pci 0000:16:08.2: [8086:208d] type 00 class 0x088000
[    0.928989] pci 0000:16:08.3: [8086:208d] type 00 class 0x088000
[    0.929139] pci 0000:16:08.4: [8086:208d] type 00 class 0x088000
[    0.929290] pci 0000:16:08.5: [8086:208d] type 00 class 0x088000
[    0.929442] pci 0000:16:08.6: [8086:208d] type 00 class 0x088000
[    0.929595] pci 0000:16:08.7: [8086:208d] type 00 class 0x088000
[    0.929753] pci 0000:16:09.0: [8086:208d] type 00 class 0x088000
[    0.929990] pci 0000:16:09.1: [8086:208d] type 00 class 0x088000
[    0.930141] pci 0000:16:09.2: [8086:208d] type 00 class 0x088000
[    0.930292] pci 0000:16:09.3: [8086:208d] type 00 class 0x088000
[    0.930444] pci 0000:16:09.4: [8086:208d] type 00 class 0x088000
[    0.930599] pci 0000:16:09.5: [8086:208d] type 00 class 0x088000
[    0.930749] pci 0000:16:09.6: [8086:208d] type 00 class 0x088000
[    0.930901] pci 0000:16:09.7: [8086:208d] type 00 class 0x088000
[    0.931059] pci 0000:16:0a.0: [8086:208d] type 00 class 0x088000
[    0.931291] pci 0000:16:0a.1: [8086:208d] type 00 class 0x088000
[    0.931455] pci 0000:16:0e.0: [8086:208e] type 00 class 0x088000
[    0.931688] pci 0000:16:0e.1: [8086:208e] type 00 class 0x088000
[    0.931834] pci 0000:16:0e.2: [8086:208e] type 00 class 0x088000
[    0.931984] pci 0000:16:0e.3: [8086:208e] type 00 class 0x088000
[    0.932136] pci 0000:16:0e.4: [8086:208e] type 00 class 0x088000
[    0.932287] pci 0000:16:0e.5: [8086:208e] type 00 class 0x088000
[    0.932438] pci 0000:16:0e.6: [8086:208e] type 00 class 0x088000
[    0.932592] pci 0000:16:0e.7: [8086:208e] type 00 class 0x088000
[    0.932749] pci 0000:16:0f.0: [8086:208e] type 00 class 0x088000
[    0.932984] pci 0000:16:0f.1: [8086:208e] type 00 class 0x088000
[    0.933135] pci 0000:16:0f.2: [8086:208e] type 00 class 0x088000
[    0.933290] pci 0000:16:0f.3: [8086:208e] type 00 class 0x088000
[    0.933441] pci 0000:16:0f.4: [8086:208e] type 00 class 0x088000
[    0.933595] pci 0000:16:0f.5: [8086:208e] type 00 class 0x088000
[    0.933748] pci 0000:16:0f.6: [8086:208e] type 00 class 0x088000
[    0.933901] pci 0000:16:0f.7: [8086:208e] type 00 class 0x088000
[    0.934057] pci 0000:16:10.0: [8086:208e] type 00 class 0x088000
[    0.934296] pci 0000:16:10.1: [8086:208e] type 00 class 0x088000
[    0.934477] pci 0000:16:1d.0: [8086:2054] type 00 class 0x088000
[    0.934717] pci 0000:16:1d.1: [8086:2055] type 00 class 0x088000
[    0.934870] pci 0000:16:1d.2: [8086:2056] type 00 class 0x088000
[    0.935023] pci 0000:16:1d.3: [8086:2057] type 00 class 0x088000
[    0.935185] pci 0000:16:1e.0: [8086:2080] type 00 class 0x088000
[    0.935417] pci 0000:16:1e.1: [8086:2081] type 00 class 0x088000
[    0.935570] pci 0000:16:1e.2: [8086:2082] type 00 class 0x088000
[    0.935725] pci 0000:16:1e.3: [8086:2083] type 00 class 0x088000
[    0.935877] pci 0000:16:1e.4: [8086:2084] type 00 class 0x088000
[    0.936029] pci 0000:16:1e.5: [8086:2085] type 00 class 0x088000
[    0.936180] pci 0000:16:1e.6: [8086:2086] type 00 class 0x088000
[    0.936326] pci_bus 0000:16: on NUMA node 0
[    0.936668] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 64-b1])
[    0.936686] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.937781] acpi PNP0A08:02: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.938324] acpi PNP0A08:02: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.938674] PCI host bridge to bus 0000:64
[    0.938685] pci_bus 0000:64: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.938697] pci_bus 0000:64: root bus resource [io  0x8000-0xbfff window]
[    0.938713] pci_bus 0000:64: root bus resource [io  0x03b0-0x03bb window]
[    0.938729] pci_bus 0000:64: root bus resource [io  0x03c0-0x03df window]
[    0.938745] pci_bus 0000:64: root bus resource [mem 0xb6000000-0xd8ffffff window]
[    0.938762] pci_bus 0000:64: root bus resource [mem 0x380200000000-0x3802ffffffff window]
[    0.938782] pci_bus 0000:64: root bus resource [bus 64-b1]
[    0.938829] pci 0000:64:00.0: [8086:2030] type 01 class 0x060400
[    0.938937] pci 0000:64:00.0: PME# supported from D0 D3hot D3cold
[    0.939265] pci 0000:64:05.0: [8086:2034] type 00 class 0x088000
[    0.939457] pci 0000:64:05.2: [8086:2035] type 00 class 0x088000
[    0.939649] pci 0000:64:05.4: [8086:2036] type 00 class 0x080020
[    0.939679] pci 0000:64:05.4: reg 0x10: [mem 0xd8100000-0xd8100fff]
[    0.939892] pci 0000:64:08.0: [8086:2066] type 00 class 0x088000
[    0.940157] pci 0000:64:09.0: [8086:2066] type 00 class 0x088000
[    0.940424] pci 0000:64:0a.0: [8086:2040] type 00 class 0x088000
[    0.940686] pci 0000:64:0a.1: [8086:2041] type 00 class 0x088000
[    0.940862] pci 0000:64:0a.2: [8086:2042] type 00 class 0x088000
[    0.941042] pci 0000:64:0a.3: [8086:2043] type 00 class 0x088000
[    0.941222] pci 0000:64:0a.4: [8086:2044] type 00 class 0x088000
[    0.941399] pci 0000:64:0a.5: [8086:2045] type 00 class 0x088000
[    0.941578] pci 0000:64:0a.6: [8086:2046] type 00 class 0x088000
[    0.941758] pci 0000:64:0a.7: [8086:2047] type 00 class 0x088000
[    0.941940] pci 0000:64:0b.0: [8086:2048] type 00 class 0x088000
[    0.942198] pci 0000:64:0b.1: [8086:2049] type 00 class 0x088000
[    0.942377] pci 0000:64:0b.2: [8086:204a] type 00 class 0x088000
[    0.942560] pci 0000:64:0b.3: [8086:204b] type 00 class 0x088000
[    0.942745] pci 0000:64:0c.0: [8086:2040] type 00 class 0x088000
[    0.943005] pci 0000:64:0c.1: [8086:2041] type 00 class 0x088000
[    0.943185] pci 0000:64:0c.2: [8086:2042] type 00 class 0x088000
[    0.943371] pci 0000:64:0c.3: [8086:2043] type 00 class 0x088000
[    0.943554] pci 0000:64:0c.4: [8086:2044] type 00 class 0x088000
[    0.943733] pci 0000:64:0c.5: [8086:2045] type 00 class 0x088000
[    0.943912] pci 0000:64:0c.6: [8086:2046] type 00 class 0x088000
[    0.944095] pci 0000:64:0c.7: [8086:2047] type 00 class 0x088000
[    0.944278] pci 0000:64:0d.0: [8086:2048] type 00 class 0x088000
[    0.944539] pci 0000:64:0d.1: [8086:2049] type 00 class 0x088000
[    0.944720] pci 0000:64:0d.2: [8086:204a] type 00 class 0x088000
[    0.944899] pci 0000:64:0d.3: [8086:204b] type 00 class 0x088000
[    0.945195] pci 0000:65:00.0: [10de:1b80] type 00 class 0x030000
[    0.945229] pci 0000:65:00.0: reg 0x10: [mem 0xd7000000-0xd7ffffff]
[    0.945262] pci 0000:65:00.0: reg 0x14: [mem 0xc0000000-0xcfffffff 64bit pref]
[    0.945296] pci 0000:65:00.0: reg 0x1c: [mem 0xd0000000-0xd1ffffff 64bit pref]
[    0.945325] pci 0000:65:00.0: reg 0x24: [io  0xb000-0xb07f]
[    0.945350] pci 0000:65:00.0: reg 0x30: [mem 0xd8000000-0xd807ffff pref]
[    0.945400] pci 0000:65:00.0: BAR 3: assigned to efifb
[    0.945418] pci 0000:65:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.945522] pci 0000:65:00.0: 32.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x16 link at 0000:64:00.0 (capable of 126.016 Gb/s with 8.0 GT/s PCIe x16 link)
[    0.945802] pci 0000:65:00.1: [10de:10f0] type 00 class 0x040300
[    0.945836] pci 0000:65:00.1: reg 0x10: [mem 0xd8080000-0xd8083fff]
[    0.946104] pci 0000:64:00.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[    0.948726] pci 0000:64:00.0: PCI bridge to [bus 65]
[    0.948740] pci 0000:64:00.0:   bridge window [io  0xb000-0xbfff]
[    0.948755] pci 0000:64:00.0:   bridge window [mem 0xd7000000-0xd80fffff]
[    0.948773] pci 0000:64:00.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.948803] pci_bus 0000:64: on NUMA node 0
[    0.949088] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus b2-ff])
[    0.949106] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.950222] acpi PNP0A08:03: _OSC: platform does not support [SHPCHotplug AER LTR]
[    0.950767] acpi PNP0A08:03: _OSC: OS now controls [PCIeHotplug PME PCIeCapability]
[    0.951093] PCI host bridge to bus 0000:b2
[    0.951104] pci_bus 0000:b2: root bus resource [io  0xc000-0xffff window]
[    0.951121] pci_bus 0000:b2: root bus resource [mem 0xd9000000-0xfbffffff window]
[    0.951139] pci_bus 0000:b2: root bus resource [mem 0x380300000000-0x3803ffffffff window]
[    0.951157] pci_bus 0000:b2: root bus resource [bus b2-ff]
[    0.951195] pci 0000:b2:05.0: [8086:2034] type 00 class 0x088000
[    0.951393] pci 0000:b2:05.2: [8086:2035] type 00 class 0x088000
[    0.951589] pci 0000:b2:05.4: [8086:2036] type 00 class 0x080020
[    0.951619] pci 0000:b2:05.4: reg 0x10: [mem 0xfbf00000-0xfbf00fff]
[    0.951840] pci 0000:b2:12.0: [8086:204c] type 00 class 0x110100
[    0.952097] pci 0000:b2:12.1: [8086:204d] type 00 class 0x110100
[    0.952249] pci 0000:b2:12.2: [8086:204e] type 00 class 0x088000
[    0.952407] pci 0000:b2:15.0: [8086:2018] type 00 class 0x088000
[    0.952649] pci 0000:b2:16.0: [8086:2018] type 00 class 0x088000
[    0.952881] pci 0000:b2:16.4: [8086:2018] type 00 class 0x088000
[    0.953038] pci 0000:b2:17.0: [8086:2018] type 00 class 0x088000
[    0.953272] pci_bus 0000:b2: on NUMA node 0
[    0.953696] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    0.953813] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    0.953927] ACPI: PCI: Interrupt link LNKC configured for IRQ 11
[    0.954041] ACPI: PCI: Interrupt link LNKD configured for IRQ 11
[    0.954153] ACPI: PCI: Interrupt link LNKE configured for IRQ 11
[    0.954266] ACPI: PCI: Interrupt link LNKF configured for IRQ 11
[    0.954378] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    0.954491] ACPI: PCI: Interrupt link LNKH configured for IRQ 11
[    0.954670] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.954697] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.955419] iommu: Default domain type: Translated
[    0.955419] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.955419] SCSI subsystem initialized
[    0.955751] libata version 3.00 loaded.
[    0.955785] ACPI: bus type USB registered
[    0.955839] usbcore: registered new interface driver usbfs
[    0.955873] usbcore: registered new interface driver hub
[    0.955934] usbcore: registered new device driver usb
[    0.955934] mc: Linux media interface: v0.10
[    0.955934] videodev: Linux video capture interface: v2.00
[    0.955934] pps_core: LinuxPPS API ver. 1 registered
[    0.955934] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.955934] EDAC MC: Ver: 3.0.0
[    0.957020] efivars: Registered efivars operations
[    0.957020] Advanced Linux Sound Architecture Driver Initialized.
[    0.957309] Bluetooth: Core ver 2.22
[    0.957342] NET: Registered PF_BLUETOOTH protocol family
[    0.957356] Bluetooth: HCI device and connection manager initialized
[    0.957378] Bluetooth: HCI socket layer initialized
[    0.957394] Bluetooth: L2CAP socket layer initialized
[    0.957418] Bluetooth: SCO socket layer initialized
[    0.957439] NetLabel: Initializing
[    0.957449] NetLabel:  domain hash size = 128
[    0.957461] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.957506] NetLabel:  unlabeled traffic allowed by default
[    0.957740] PCI: Using ACPI for IRQ routing
[    0.963476] PCI: pci_cache_line_size set to 64 bytes
[    0.963643] e820: reserve RAM buffer [mem 0x2bc45018-0x2bffffff]
[    0.963647] e820: reserve RAM buffer [mem 0x2bc65018-0x2bffffff]
[    0.963649] e820: reserve RAM buffer [mem 0x33af7000-0x33ffffff]
[    0.963651] e820: reserve RAM buffer [mem 0x3560e000-0x37ffffff]
[    0.963788] pci 0000:65:00.0: vgaarb: setting as boot VGA device
[    0.963803] pci 0000:65:00.0: vgaarb: bridge control possible
[    0.963817] pci 0000:65:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.963845] vgaarb: loaded
[    0.965299] acpi PNP0C14:03: duplicate WMI GUID DEADBEEF-4001-0000-00A0-C90629100000 (first instance was on PNP0C14:03)
[    0.965706] clocksource: Switched to clocksource tsc-early
[    0.965996] VFS: Disk quotas dquot_6.6.0
[    0.966029] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.966187] pnp: PnP ACPI init
[    0.967237] system 00:01: [io  0x0500-0x053f] has been reserved
[    0.967255] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.967270] system 00:01: [io  0x0540-0x057f] has been reserved
[    0.967285] system 00:01: [io  0x0600-0x061f] has been reserved
[    0.967300] system 00:01: [io  0x0ca0-0x0ca5] has been reserved
[    0.967315] system 00:01: [io  0x0880-0x0883] has been reserved
[    0.967330] system 00:01: [io  0x0800-0x081f] has been reserved
[    0.967345] system 00:01: [mem 0xfed1c000-0xfed3ffff] has been reserved
[    0.967361] system 00:01: [mem 0xfed45000-0xfed8bfff] has been reserved
[    0.967378] system 00:01: [mem 0xff000000-0xffffffff] has been reserved
[    0.967394] system 00:01: [mem 0xfee00000-0xfeefffff] could not be reserved
[    0.967411] system 00:01: [mem 0xfed12000-0xfed1200f] has been reserved
[    0.967429] system 00:01: [mem 0xfed12010-0xfed1201f] has been reserved
[    0.967445] system 00:01: [mem 0xfed1b000-0xfed1bfff] has been reserved
[    0.967979] system 00:02: [io  0x0a00-0x0a2f] has been reserved
[    0.967994] system 00:02: [io  0x0a30-0x0a3f] has been reserved
[    0.968009] system 00:02: [io  0x0a40-0x0a4f] has been reserved
[    0.968558] system 00:03: [mem 0xfd000000-0xfdabffff] has been reserved
[    0.968575] system 00:03: [mem 0xfdad0000-0xfdadffff] has been reserved
[    0.968591] system 00:03: [mem 0xfdb00000-0xfdffffff] has been reserved
[    0.968607] system 00:03: [mem 0xfe000000-0xfe00ffff] has been reserved
[    0.968623] system 00:03: [mem 0xfe011000-0xfe01ffff] has been reserved
[    0.968639] system 00:03: [mem 0xfe036000-0xfe03bfff] has been reserved
[    0.968655] system 00:03: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    0.968672] system 00:03: [mem 0xfe410000-0xfe7fffff] has been reserved
[    0.969139] system 00:04: [io  0x0f00-0x0ffe] has been reserved
[    0.970862] system 00:05: [mem 0xfdaf0000-0xfdafffff] has been reserved
[    0.970879] system 00:05: [mem 0xfdae0000-0xfdaeffff] has been reserved
[    0.970896] system 00:05: [mem 0xfdac0000-0xfdacffff] has been reserved
[    0.972500] ACPI BIOS Error (bug): Could not resolve symbol [\SHAD._STA.SDS0], AE_NOT_FOUND (20230628/psargs-330)
[    0.972529] ACPI Error: Aborting method \SHAD._STA due to previous error (AE_NOT_FOUND) (20230628/psparse-529)
[    0.972567] pnp: PnP ACPI: found 7 devices
[    0.981394] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.982198] NET: Registered PF_INET protocol family
[    0.982389] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.984958] tcp_listen_portaddr_hash hash table entries: 32768 (order: 9, 2621440 bytes, linear)
[    0.985637] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.985666] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.986031] TCP bind hash table entries: 65536 (order: 11, 10485760 bytes, vmalloc hugepage)
[    0.988655] TCP: Hash tables configured (established 524288 bind 65536)
[    0.988819] UDP hash table entries: 32768 (order: 10, 6291456 bytes, vmalloc hugepage)
[    0.990204] UDP-Lite hash table entries: 32768 (order: 10, 6291456 bytes, vmalloc hugepage)
[    0.991703] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.991747] pci 0000:00:1d.0: bridge window [io  0x1000-0x0fff] to [bus 04] add_size 1000
[    0.991768] pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align 100000
[    0.991794] pci 0000:00:1d.0: bridge window [mem 0x00100000-0x000fffff] to [bus 04] add_size 200000 add_align 100000
[    0.991824] pci 0000:00:1d.0: BAR 14: assigned [mem 0x70000000-0x701fffff]
[    0.991842] pci 0000:00:1d.0: BAR 15: assigned [mem 0x380000000000-0x3800001fffff 64bit pref]
[    0.991862] pci 0000:00:1d.0: BAR 13: assigned [io  0x1000-0x1fff]
[    0.991878] pci 0000:00:1b.0: PCI bridge to [bus 01]
[    0.991911] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    0.991944] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    0.991962] pci 0000:00:1c.4:   bridge window [mem 0x92e00000-0x92efffff]
[    0.991990] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    0.992003] pci 0000:00:1d.0:   bridge window [io  0x1000-0x1fff]
[    0.992024] pci 0000:00:1d.0:   bridge window [mem 0x70000000-0x701fffff]
[    0.992043] pci 0000:00:1d.0:   bridge window [mem 0x380000000000-0x3800001fffff 64bit pref]
[    0.992071] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.992085] pci_bus 0000:00: resource 5 [io  0x1000-0x3fff window]
[    0.992100] pci_bus 0000:00: resource 6 [mem 0x000c4000-0x000c7fff window]
[    0.992115] pci_bus 0000:00: resource 7 [mem 0xfe010000-0xfe010fff window]
[    0.992131] pci_bus 0000:00: resource 8 [mem 0x70000000-0x92ffffff window]
[    0.992146] pci_bus 0000:00: resource 9 [mem 0x380000000000-0x3800ffffffff window]
[    0.992163] pci_bus 0000:03: resource 1 [mem 0x92e00000-0x92efffff]
[    0.992178] pci_bus 0000:04: resource 0 [io  0x1000-0x1fff]
[    0.992191] pci_bus 0000:04: resource 1 [mem 0x70000000-0x701fffff]
[    0.992205] pci_bus 0000:04: resource 2 [mem 0x380000000000-0x3800001fffff 64bit pref]
[    0.992562] pci_bus 0000:16: resource 4 [io  0x4000-0x7fff window]
[    0.992577] pci_bus 0000:16: resource 5 [mem 0x93000000-0xb5ffffff window]
[    0.992593] pci_bus 0000:16: resource 6 [mem 0x380100000000-0x3801ffffffff window]
[    0.992662] pci 0000:64:00.0: PCI bridge to [bus 65]
[    0.992675] pci 0000:64:00.0:   bridge window [io  0xb000-0xbfff]
[    0.992695] pci 0000:64:00.0:   bridge window [mem 0xd7000000-0xd80fffff]
[    0.992714] pci 0000:64:00.0:   bridge window [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.992740] pci_bus 0000:64: resource 4 [mem 0x000a0000-0x000bffff window]
[    0.992756] pci_bus 0000:64: resource 5 [io  0x8000-0xbfff window]
[    0.992770] pci_bus 0000:64: resource 6 [io  0x03b0-0x03bb window]
[    0.992784] pci_bus 0000:64: resource 7 [io  0x03c0-0x03df window]
[    0.992798] pci_bus 0000:64: resource 8 [mem 0xb6000000-0xd8ffffff window]
[    0.992814] pci_bus 0000:64: resource 9 [mem 0x380200000000-0x3802ffffffff window]
[    0.992831] pci_bus 0000:65: resource 0 [io  0xb000-0xbfff]
[    0.992844] pci_bus 0000:65: resource 1 [mem 0xd7000000-0xd80fffff]
[    0.992859] pci_bus 0000:65: resource 2 [mem 0xc0000000-0xd1ffffff 64bit pref]
[    0.992913] pci_bus 0000:b2: resource 4 [io  0xc000-0xffff window]
[    0.992927] pci_bus 0000:b2: resource 5 [mem 0xd9000000-0xfbffffff window]
[    0.992943] pci_bus 0000:b2: resource 6 [mem 0x380300000000-0x3803ffffffff window]
[    0.994700] pci 0000:03:00.0: PME# does not work under D0, disabling it
[    0.995245] pci 0000:16:05.0: disabled boot interrupts on device [8086:2034]
[    0.995365] pci 0000:64:05.0: disabled boot interrupts on device [8086:2034]
[    0.995447] pci 0000:65:00.0: CLS mismatch (64 != 32), using 64 bytes
[    0.995464] pci 0000:65:00.1: extending delay after power-on from D3hot to 20 msec
[    0.995626] pci 0000:65:00.1: D0 power state depends on 0000:65:00.0
[    0.995705] pci 0000:b2:05.0: disabled boot interrupts on device [8086:2034]
[    0.995863] Unpacking initramfs...
[    0.995895] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.995911] software IO TLB: mapped [mem 0x000000004c000000-0x0000000050000000] (64MB)
[    0.999770] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 655360 ms ovfl timer
[    0.999789] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.999802] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    1.024985] Initialise system trusted keyrings
[    1.025081] workingset: timestamp_bits=46 max_order=24 bucket_order=0
[    1.025967] Key type cifs.idmap registered
[    1.026108] fuse: init (API version 7.39)
[    1.032955] NET: Registered PF_ALG protocol family
[    1.032976] xor: automatically using best checksumming function   avx       
[    1.032993] Key type asymmetric registered
[    1.033008] Asymmetric key parser 'x509' registered
[    1.033040] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
[    1.034114] pcieport 0000:00:1b.0: PME: Signaling with IRQ 24
[    1.034746] pcieport 0000:00:1c.0: PME: Signaling with IRQ 25
[    1.035028] pcieport 0000:00:1c.4: PME: Signaling with IRQ 26
[    1.035627] pcieport 0000:00:1d.0: PME: Signaling with IRQ 27
[    1.035701] pcieport 0000:00:1d.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.036522] pcieport 0000:64:00.0: PME: Signaling with IRQ 29
[    1.037029] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.037078] efifb: probing for efifb
[    1.037100] efifb: framebuffer at 0xd1000000, using 3072k, total 3072k
[    1.037116] efifb: mode is 1024x768x32, linelength=4096, pages=1
[    1.037130] efifb: scrolling: redraw
[    1.037139] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    1.038553] Console: switching to colour frame buffer device 128x48
[    1.039779] fb0: EFI VGA frame buffer device
[    1.039932] Monitor-Mwait will be used to enter C-1 state
[    1.039949] Monitor-Mwait will be used to enter C-2 state
[    1.039958] ACPI: \_SB_.SCK0.CP00: Found 2 idle states
[    1.045015] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    1.045123] ACPI: button: Sleep Button [SLPB]
[    1.045284] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.045382] ACPI: button: Power Button [PWRB]
[    1.045492] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.046642] ACPI: button: Power Button [PWRF]
[    1.053199] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.054576] Non-volatile memory driver v1.3
[    1.066934] ACPI: bus type drm_connector registered
[    1.067425] Console: switching to colour dummy device 80x25
[    1.067478] nouveau 0000:65:00.0: vgaarb: deactivate vga console
[    1.067594] nouveau 0000:65:00.0: NVIDIA GP104 (134000a1)
[    1.177507] nouveau 0000:65:00.0: bios: version 86.04.60.40.1f
[    1.178378] nouveau 0000:65:00.0: pmu: firmware unavailable
[    1.179706] nouveau 0000:65:00.0: fb: 8192 MiB GDDR5X
[    1.209707] nouveau 0000:65:00.0: DRM: VRAM: 8192 MiB
[    1.209721] nouveau 0000:65:00.0: DRM: GART: 536870912 MiB
[    1.209736] nouveau 0000:65:00.0: DRM: BIT table 'A' not found
[    1.209750] nouveau 0000:65:00.0: DRM: BIT table 'L' not found
[    1.209764] nouveau 0000:65:00.0: DRM: TMDS table version 2.0
[    1.209777] nouveau 0000:65:00.0: DRM: DCB version 4.1
[    1.209790] nouveau 0000:65:00.0: DRM: DCB outp 00: 01000f42 00020030
[    1.209806] nouveau 0000:65:00.0: DRM: DCB outp 01: 04811f96 04600020
[    1.209821] nouveau 0000:65:00.0: DRM: DCB outp 02: 04011f92 00020020
[    1.209836] nouveau 0000:65:00.0: DRM: DCB outp 03: 04822f86 04600010
[    1.209851] nouveau 0000:65:00.0: DRM: DCB outp 04: 04022f82 00020010
[    1.209866] nouveau 0000:65:00.0: DRM: DCB outp 06: 02033f62 00020010
[    1.209881] nouveau 0000:65:00.0: DRM: DCB outp 07: 02844f76 04600020
[    1.209896] nouveau 0000:65:00.0: DRM: DCB outp 08: 02044f72 00020020
[    1.209911] nouveau 0000:65:00.0: DRM: DCB conn 00: 00001031
[    1.209924] nouveau 0000:65:00.0: DRM: DCB conn 01: 02000146
[    1.209937] nouveau 0000:65:00.0: DRM: DCB conn 02: 01000246
[    1.209950] nouveau 0000:65:00.0: DRM: DCB conn 03: 00010361
[    1.209963] nouveau 0000:65:00.0: DRM: DCB conn 04: 00020446
[    1.210392] Freeing initrd memory: 2792K
[    1.211534] nouveau 0000:65:00.0: DRM: MM: using COPY for buffer copies
[    1.273804] [drm] Initialized nouveau 1.4.0 20120801 for 0000:65:00.0 on minor 0
[    1.370826] fbcon: nouveaudrmfb (fb0) is primary device
[    1.524827] Console: switching to colour frame buffer device 480x135
[    1.562789] nouveau 0000:65:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[    1.581751] loop: module loaded
[    1.583146] ahci 0000:00:17.0: version 3.0
[    1.593832] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 8 ports 6 Gbps 0xff impl SATA mode
[    1.593860] ahci 0000:00:17.0: flags: 64bit ncq sntf led clo only pio slum part ems deso sadm sds apst 
[    1.616574] scsi host0: ahci
[    1.616994] scsi host1: ahci
[    1.617368] scsi host2: ahci
[    1.617705] scsi host3: ahci
[    1.618078] scsi host4: ahci
[    1.618464] scsi host5: ahci
[    1.618809] scsi host6: ahci
[    1.619149] scsi host7: ahci
[    1.619291] ata1: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b100 irq 32
[    1.619315] ata2: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b180 irq 32
[    1.619337] ata3: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b200 irq 32
[    1.619359] ata4: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b280 irq 32
[    1.619380] ata5: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b300 irq 32
[    1.619401] ata6: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b380 irq 32
[    1.619423] ata7: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b400 irq 32
[    1.619444] ata8: SATA max UDMA/133 abar m2048@0x92f6b000 port 0x92f6b480 irq 32
[    1.620039] tun: Universal TUN/TAP device driver, 1.6
[    1.620163] e1000e: Intel(R) PRO/1000 Network Driver
[    1.620183] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.620671] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    1.928431] ata3: SATA link down (SStatus 4 SControl 300)
[    1.928513] ata4: SATA link down (SStatus 4 SControl 300)
[    1.928636] ata8: SATA link down (SStatus 4 SControl 300)
[    1.928695] ata1: SATA link down (SStatus 4 SControl 300)
[    1.928742] ata6: SATA link down (SStatus 4 SControl 300)
[    1.928779] ata5: SATA link down (SStatus 4 SControl 300)
[    1.928825] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    1.928865] ata7: SATA link down (SStatus 4 SControl 300)
[    1.929534] ata2.00: ATA-10: INTEL SSDSC2KW010T8,  LHF0B1C, max UDMA/133
[    1.929609] ata2.00: 2000409264 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.930119] ata2.00: Features: Dev-Sleep
[    1.930677] ata2.00: configured for UDMA/133
[    1.930974] scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2KW01 0B1C PQ: 0 ANSI: 5
[    1.931701] sd 1:0:0:0: Attached scsi generic sg0 type 0
[    1.931875] ata2.00: Enabling discard_zeroes_data
[    1.931910] sd 1:0:0:0: [sda] 2000409264 512-byte logical blocks: (1.02 TB/954 GiB)
[    1.931954] sd 1:0:0:0: [sda] Write Protect is off
[    1.931970] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    1.931992] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    1.932047] sd 1:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    1.933231] ata2.00: Enabling discard_zeroes_data
[    1.934747]  sda: sda1 sda2
[    1.935088] sd 1:0:0:0: [sda] Attached SCSI disk
[    2.041644] tsc: Refined TSC clocksource calibration: 2807.999 MHz
[    2.041680] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2879c523a63, max_idle_ns: 440795252908 ns
[    2.041806] clocksource: Switched to clocksource tsc
[    2.063394] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) e0:d5:5e:e3:99:9a
[    2.063430] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    2.063549] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    2.063668] usbcore: registered new device driver r8152-cfgselector
[    2.063701] usbcore: registered new interface driver r8152
[    2.063731] usbcore: registered new interface driver asix
[    2.063762] usbcore: registered new interface driver ax88179_178a
[    2.063793] usbcore: registered new interface driver cdc_ether
[    2.063827] usbcore: registered new interface driver net1080
[    2.063858] usbcore: registered new interface driver cdc_subset
[    2.063889] usbcore: registered new interface driver zaurus
[    2.063920] usbcore: registered new interface driver cdc_ncm
[    2.063951] usbcore: registered new interface driver r8153_ecm
[    2.064550] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.064590] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    2.065732] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000000009810
[    2.066354] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    2.066375] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    2.066397] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
[    2.067456] hub 1-0:1.0: USB hub found
[    2.067518] hub 1-0:1.0: 16 ports detected
[    2.074028] hub 2-0:1.0: USB hub found
[    2.074080] hub 2-0:1.0: 10 ports detected
[    2.077512] usb: port power management may be unreliable
[    2.078125] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.078214] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 3
[    2.133140] xhci_hcd 0000:03:00.0: hcc params 0x0200ef80 hci version 0x110 quirks 0x0000000000800010
[    2.134189] xhci_hcd 0000:03:00.0: xHCI Host Controller
[    2.134279] xhci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 4
[    2.134376] xhci_hcd 0000:03:00.0: Host supports USB 3.1 Enhanced SuperSpeed
[    2.135004] hub 3-0:1.0: USB hub found
[    2.135088] hub 3-0:1.0: 2 ports detected
[    2.135470] usb usb4: We don't know the algorithms for LPM for this host, disabling LPM.
[    2.136023] hub 4-0:1.0: USB hub found
[    2.136117] hub 4-0:1.0: 2 ports detected
[    2.136579] usbcore: registered new interface driver usb-storage
[    2.136738] i8042: PNP: No PS/2 controller found.
[    2.136958] mousedev: PS/2 mouse device common for all mice
[    2.137220] rtc_cmos 00:00: RTC can wake from S4
[    2.138253] rtc_cmos 00:00: registered as rtc0
[    2.138475] rtc_cmos 00:00: setting system clock to 2023-10-03T17:51:17 UTC (1696355477)
[    2.138641] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram
[    2.138890] usbcore: registered new interface driver uvcvideo
[    2.138891] i801_smbus 0000:00:1f.4: enabling device (0001 -> 0003)
[    2.139267] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    2.139500] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    2.139705] pci 0000:00:1f.1: [8086:a2a0] type 00 class 0x058000
[    2.139849] pci 0000:00:1f.1: reg 0x10: [mem 0xfd000000-0xfdffffff 64bit]
[    2.146172] device-mapper: uevent: version 1.0.3
[    2.146411] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@redhat.com
[    2.146412] i2c i2c-17: 4/8 memory slots populated (from DMI)
[    2.146459] i2c i2c-17: Systems with more than 4 memory slots not supported yet, not instantiating SPD
[    2.146879] Bluetooth: HCI UART driver ver 2.3
[    2.146928] usbcore: registered new interface driver btusb
[    2.146948] intel_pstate: Intel P-state driver initializing
[    2.153853] intel_pstate: HWP enabled
[    2.153934] sdhci: Secure Digital Host Controller Interface driver
[    2.153960] sdhci: Copyright(c) Pierre Ossman
[    2.154604] ledtrig-cpu: registered to indicate activity on CPUs
[    2.154743] pstore: Using crash dump compression: deflate
[    2.155983] pstore: Registered efi_pstore as persistent store backend
[    2.157367] hid: raw HID events driver (C) Jiri Kosina
[    2.160019] usbcore: registered new interface driver usbhid
[    2.161649] usbhid: USB HID core driver
[    2.164601] usbcore: registered new interface driver snd-usb-audio
[    2.167342] IPVS: Registered protocols (TCP, UDP)
[    2.169261] IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
[    2.171237] IPVS: ipvs loaded.
[    2.173054] IPVS: [rr] scheduler registered.
[    2.175024] NET: Registered PF_INET6 protocol family
[    2.177875] Segment Routing with IPv6
[    2.179073] In-situ OAM (IOAM) with IPv6
[    2.180300] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.186118] bpfilter: Loaded bpfilter_umh pid 310
[    2.187339] NET: Registered PF_PACKET protocol family
[    2.188250] Bridge firewalling registered
[    2.189386] Bluetooth: RFCOMM TTY layer initialized
[    2.190286] Bluetooth: RFCOMM socket layer initialized
[    2.191185] Bluetooth: RFCOMM ver 1.11
[    2.192061] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    2.192939] Bluetooth: BNEP filters: protocol multicast
[    2.193830] Bluetooth: BNEP socket layer initialized
[    2.194720] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    2.195609] Bluetooth: HIDP socket layer initialized
[    2.196465] 8021q: 802.1Q VLAN Support v1.8
[    2.197360] Key type dns_resolver registered
[    2.198436] NET: Registered PF_VSOCK protocol family
[    2.220674] microcode: Microcode Update Driver: v2.2.
[    2.220686] IPI shorthand broadcast: enabled
[    2.223940] AVX2 version of gcm_enc/dec engaged.
[    2.225850] AES CTR mode by8 optimization enabled
[    2.244972] sched_clock: Marking stable (2242001748, 2537712)->(2262902589, -18363129)
[    2.247079] registered taskstats version 1
[    2.248521] Loading compiled-in X.509 certificates
[    2.257216] debug_vm_pgtable: [debug_vm_pgtable         ]: Validating architecture page table helpers
[    2.315648] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    2.371231] Btrfs loaded, zoned=no, fsverity=no
[    2.372976] Key type trusted registered
[    2.377747] clk: Disabling unused clocks
[    2.380624] ALSA device list:
[    2.383487]   No soundcards found.
[    2.397311] Freeing unused kernel image (initmem) memory: 8364K
[    2.407617] Write protecting the kernel read-only data: 30720k
[    2.410324] Freeing unused kernel image (rodata/data gap) memory: 264K
[    2.412937] Run /init as init process
[    2.415409]   with arguments:
[    2.415416]     /init
[    2.415420]     dolvm
[    2.415424]   with environment:
[    2.415428]     HOME=/
[    2.415432]     TERM=linux
[    2.457898] input: TrulyErgonomic.com Truly Ergonomic Computer Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.0/0003:0E6A:030C.0001/input/input3
[    2.510682] hid-generic 0003:0E6A:030C.0001: input,hidraw0: USB HID v1.11 Keyboard [TrulyErgonomic.com Truly Ergonomic Computer Keyboard] on usb-0000:00:14.0-2/input0
[    2.513367] input: TrulyErgonomic.com Truly Ergonomic Computer Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-2/1-2:1.1/0003:0E6A:030C.0002/input/input4
[    2.566041] hid-generic 0003:0E6A:030C.0002: input,hidraw1: USB HID v1.11 Device [TrulyErgonomic.com Truly Ergonomic Computer Keyboard] on usb-0000:00:14.0-2/input1
[    2.680676] usb 1-6: new full-speed USB device number 3 using xhci_hcd
[    2.820821] logitech-djreceiver 0003:046D:C52B.0005: hiddev0,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-6/input2
[    2.937700] input: Logitech Performance MX as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.2/0003:046D:C52B.0005/0003:046D:101A.0006/input/input5
[    2.938274] logitech-hidpp-device 0003:046D:101A.0006: input,hidraw3: USB HID v1.11 Mouse [Logitech Performance MX] on usb-0000:00:14.0-6/input2:1
[    2.945917] input: Logitech MX Master 2S as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.2/0003:046D:C52B.0005/0003:046D:4069.0007/input/input6
[    2.947204] logitech-hidpp-device 0003:046D:4069.0007: input,hidraw4: USB HID v1.11 Keyboard [Logitech MX Master 2S] on usb-0000:00:14.0-6/input2:2
[    2.953927] input: Logitech MX Vertical as /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6:1.2/0003:046D:C52B.0005/0003:046D:407B.0008/input/input7
[    2.955249] logitech-hidpp-device 0003:046D:407B.0008: input,hidraw5: USB HID v1.11 Keyboard [Logitech MX Vertical] on usb-0000:00:14.0-6/input2:3
[    3.038659] usb 1-9: new full-speed USB device number 4 using xhci_hcd
[    3.174752] input: Kensington Expert Wireless TB Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:047D:8018.0009/input/input8
[    3.175391] input: Kensington Expert Wireless TB Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:047D:8018.0009/input/input9
[    3.227150] hid-generic 0003:047D:8018.0009: input,hidraw6: USB HID v1.11 Mouse [Kensington Expert Wireless TB] on usb-0000:00:14.0-9/input0
[    3.230532] hid-generic 0003:047D:8018.000A: hiddev1,hidraw7: USB HID v1.10 Device [Kensington Expert Wireless TB] on usb-0000:00:14.0-9/input1
[    3.315103] EXT4-fs (dm-0): mounted filesystem 2002ff65-fa47-45a9-827f-22f08fe2e5a6 ro with ordered data mode. Quota mode: none.
[    3.347639] usb 1-10: new full-speed USB device number 5 using xhci_hcd
[    3.482477] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[    3.483471] Bluetooth: hci0: RTL: rom_version status=0 version=1
[    3.483484] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_fw.bin
[    3.484076] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761bu_config.bin
[    3.484131] Bluetooth: hci0: RTL: cfg_sz 6, total sz 30210
[    3.634587] Bluetooth: hci0: RTL: fw version 0xdfc6d922
[    7.299155] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    8.789602] EXT4-fs (dm-0): re-mounted 2002ff65-fa47-45a9-827f-22f08fe2e5a6 r/w. Quota mode: none.
[    8.833097] EXT4-fs (dm-0): re-mounted 2002ff65-fa47-45a9-827f-22f08fe2e5a6 r/w. Quota mode: none.
[    9.245567] Adding 67108860k swap on /dev/mapper/box-swap.  Priority:-2 extents:1 across:67108860k SS
[   13.565464] Bluetooth: MGMT ver 1.22
[   13.686982] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
[   16.984285] input: Adv360 Pro Keyboard as /devices/virtual/misc/uhid/0005:1D50:615E.000B/input/input10
[   16.985748] hid-generic 0005:1D50:615E.000B: input,hidraw8: BLUETOOTH HID v0.01 Keyboard [Adv360 Pro] on 04:42:1a:59:ef:ee
[   30.619167] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: None
[   31.447016] EXT4-fs (dm-3): mounted filesystem 59b57016-ad18-4cdd-99ee-54b85a9dbb64 r/w with ordered data mode. Quota mode: none.
[   34.966887] CIFS: Attempting to mount //node/video
[   35.152526] CIFS: Attempting to mount //node/music
[   48.286080] pipewire[3858]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set
[   63.615434] logitech-hidpp-device 0003:046D:407B.0008: HID++ 4.5 device connected.

--fq34hsvlnldgmiyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hciconfig.bad"

hci0:	Type: Primary  Bus: USB
	BD Address: 00:00:00:00:00:00  ACL MTU: 0:0  SCO MTU: 0:0
	DOWN 
	RX bytes:883 acl:0 sco:0 events:124 errors:0
	TX bytes:30707 acl:0 sco:0 commands:124 errors:0
	Features: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
	Packet type: DM1 DH1 HV1 
	Link policy: 
	Link mode: PERIPHERAL ACCEPT 


--fq34hsvlnldgmiyp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hciconfig.good"

hci0:	Type: Primary  Bus: USB
	BD Address: 04:42:1A:59:EF:EE  ACL MTU: 1021:6  SCO MTU: 255:12
	UP RUNNING PSCAN 
	RX bytes:129632 acl:4703 sco:0 events:975 errors:0
	TX bytes:43682 acl:399 sco:0 commands:402 errors:0
	Features: 0xff 0xff 0xff 0xfe 0xdb 0xfd 0x7b 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: PERIPHERAL ACCEPT 
	Name: 'BlueZ 5.68'
	Class: 0x6c0104
	Service Classes: Rendering, Capturing, Audio, Telephony
	Device Class: Computer, Desktop workstation
	HCI Version: 5.1 (0xa)  Revision: 0xdfc6
	LMP Version: 5.1 (0xa)  Subversion: 0xd922
	Manufacturer: Realtek Semiconductor Corporation (93)


--fq34hsvlnldgmiyp--
