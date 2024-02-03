Return-Path: <linux-kernel+bounces-51179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B6F848767
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5AEB23E50
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A45F57C;
	Sat,  3 Feb 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="X9wnH660"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB85DF22;
	Sat,  3 Feb 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706977393; cv=none; b=sIyrS6LIc97RtaIm0Fpouoq+mZin/MHjmr11cl3drA+vD9XYEjAr9YWtIB/H/momgh+ZHpylI4Ugf/QdjIp5PosvvfXM1k+QNmgWB/a1pCQK2hioyka0MtncVZG9T0atU5IfD/TLgSV+lR9yH0akxwdBAw/GGq4MYVNHwvqDdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706977393; c=relaxed/simple;
	bh=3wZJHeL0+MT599WQdDSuh4qC7vdNkIvw3BTeICTC3vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2eg3RlnA5QAg2MiICVOXyi4iIfn2RRcXyGZARo9wuxfTe7/92P/QI77Sai6mXCn69cICX/2nVkpue03ELiNa2s8fbEvfzKwMqt2sPKbWN+KYEjM0GQrBnrAryLKffVj/s54519nAnVN8RONBY9ng4W7WfSDgvw8ci2YbAFmNFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=X9wnH660; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706977384; x=1707582184; i=rwarsow@gmx.de;
	bh=3wZJHeL0+MT599WQdDSuh4qC7vdNkIvw3BTeICTC3vw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=X9wnH660rum5JptKGeRq+t5lgkof8/UQv1UywNrZE4NUfPZN39ufm3TAaxYH+iLB
	 GPWcsJ/m87EfYUiWXEDtBU0pVs5ZPtNDYTf+bD9C17Q/II27B76E2yrQRtGDbC0fZ
	 /eBAmAKYzgiWh42+VAdOm3jMwNoznKHhnnImhoRwiBVMt46mrYGoO5nN5cE2uQ5k8
	 rngxfoKqiKUx8PhhSlPs+L74ocDtPh9shXn988eWAWxRw726pJCAofbBrKgdfbohl
	 rVXt+HeeskB6oOytFnNCUIbry0jwKl035cA87iJf0SBu7KglVgV8Ci4VxoUuKjU4J
	 6FoDpDMmODaei4BYTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCKBm-1rMv7l2r5e-009QzP; Sat, 03
 Feb 2024 17:23:03 +0100
Message-ID: <6b40877e-7ecf-4690-89f0-50e0db2e90f5@gmx.de>
Date: Sat, 3 Feb 2024 17:23:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.7 000/353] 6.7.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <295b099e-3b60-416f-a28c-6d58bb5564bb@gmx.de>
 <2024020343-handiness-nanometer-ae7d@gregkh>
Content-Language: de-DE, en-US
From: Ronald Warsow <rwarsow@gmx.de>
In-Reply-To: <2024020343-handiness-nanometer-ae7d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u0K4uBq5A/trkiIssFbe+cHnNZYGISe63UJjGimYDfWjOLnu/Pn
 DE8ogRyIm6TZ+k5l/MFW83eWTD+iSnRYvGCK83mFq/x4wBd/Z/QmGI3tDtnCx5lrBVmYR4w
 bLEeZUk2tLmnJN//P4hOd87+OOfXhnM1LsG3B+/ICTUcet+DkPtjmCoR9BwsfWLGILWmU0t
 przF0VFqT6hw8iJHzOEAg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3GJicGxFdVM=;sy+GY8zvoOmsizuzPdSeHitjc3z
 hTapRTah+GwwehQafPRF3RybyB2VYDudXt8W9Ak7PsCRfdaRTJvRGegRrCOMKRRtR4XSKuBWO
 WeAwaknePvpDHJtn5f+W7hhan9zpeP3K2EEPqyGkLw9leo81JxXQYsd8XpJ+rR4287ztbxgRG
 b02uNiNUYVdZbuQx6cDUdttcK8aIFK181et1/RpvC7tpjtPrLYAJgZ2LulDvRK5Za7EKJXh5B
 g16LIjPNqWY5BkgUxv9l1c7zJCxoJ0Bnx87HZdEDV+mYYDHUkMdBP6j83TQE6kPzP72WsfAjd
 DEfiWMj2uhrvTh38fi+y6nNrT3pCScVK7udstOzx2kKnLIbYK3MZ6fm3AYO5EOiUJtoMZmfpZ
 UAr0TApohgmIr56oumFISXYuCYRYptBGxUfxPAtlbG53898fX6SN5O60ZlQNyjUqL/IPNe3Td
 B0iGBV0Wz8kpna+K2KSB+IEVbLDVrHrf2GGmp7F87VsXJMID7dPXbSr+knt+qEtFQoCrHySpd
 dSrMrpnmmn315jeMQeYiYwZVMBfQQ/lcfOokPzGg0ap6JRMcQSWhD1HxNZOPBttqcDk1AFBJh
 8L7GQVepIqPFkGWEdz+3fgrTKIylmYlcRm+T/i9dch5XNFV68rcEMWd9wMIKoeMbiqnPQVOcL
 2m1HUSLiv114cTDkm6V4HGviuW85EZ4LmyZX+6PANsKeMD9u6BrNp/QVYQVVxZYbnMo3AGcDR
 KKVGSKHPE7bX4vj5o4p1TxH7w9Ii/cDmxh+5kSDygC9t57QX4BJLzFRNunpBBeuyxPtQv7Q7b
 eNlzvnECBXwC6Lz0DReq8/AXVp8WJzCwhwy/LkKzjzBqw=

On 03.02.24 15:46, Greg Kroah-Hartman wrote:
> On Sat, Feb 03, 2024 at 02:39:41PM +0100, Ronald Warsow wrote:
>> Hi Greg
>>
..>
> I guess just not tested successfully :(
>

well, team work is essential, one could blame someone else
:-)


> I'll look into all of these errors in a bit..
>

got a serial console log.

Please scroll down and/or search for
"[    4.390912] Workqueue: usb_hub_wq hub_event"

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.000000] Linux version 6.7.4-rc1_MY (ron@obelix.fritz.box) (gcc
(GCC) 13.2.1 20231205 (Red Hat 13.2.1-6), GNU ld version 2.40-14.fc39)
#1 SMP PREEMPT_DYNAMIC Sat Feb  3 16:57:59 CET 2024
[    0.000000] Command line: BOOT_IMAGE=3D(hd1,gpt1)/vmlinuz-6.7.4-rc1_MY
root=3DUUID=3D704d7d4e-6ca3-4647-b027-44dc162e2b3c ro rootflags=3Dsubvol=
=3DROOT
console=3Dtty0 console=3Dtty1 console=3DttyS0,115200 systemd.log_level=3Dd=
ebug
no_console_suspend
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usab=
le
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usab=
le
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000081983fff] usab=
le
[    0.000000] BIOS-e820: [mem 0x0000000081984000-0x0000000081984fff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000081985000-0x000000008fcd9fff] usab=
le
[    0.000000] BIOS-e820: [mem 0x000000008fcda000-0x00000000921d9fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000921da000-0x0000000092459fff]
ACPI data
[    0.000000] BIOS-e820: [mem 0x000000009245a000-0x00000000925fefff]
ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000925ff000-0x0000000093efefff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000093eff000-0x0000000093efffff] usab=
le
[    0.000000] BIOS-e820: [mem 0x0000000093f00000-0x0000000099ffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000009a600000-0x000000009a7fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x000000009b000000-0x00000000a07fffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff]
reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff]
reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000045f7fffff] usab=
le
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem
0x0000000000000000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem
0x000000000009e000-0x000000000009efff] reserved
[    0.000000] reserve setup_data: [mem
0x000000000009f000-0x000000000009ffff] usable
[    0.000000] reserve setup_data: [mem
0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000000100000-0x0000000081983fff] usable
[    0.000000] reserve setup_data: [mem
0x0000000081984000-0x0000000081984fff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000081985000-0x0000000081e24017] usable
[    0.000000] reserve setup_data: [mem
0x0000000081e24018-0x0000000081e33057] usable
[    0.000000] reserve setup_data: [mem
0x0000000081e33058-0x000000008fcd9fff] usable
[    0.000000] reserve setup_data: [mem
0x000000008fcda000-0x00000000921d9fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000921da000-0x0000000092459fff] ACPI data
[    0.000000] reserve setup_data: [mem
0x000000009245a000-0x00000000925fefff] ACPI NVS
[    0.000000] reserve setup_data: [mem
0x00000000925ff000-0x0000000093efefff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000093eff000-0x0000000093efffff] usable
[    0.000000] reserve setup_data: [mem
0x0000000093f00000-0x0000000099ffffff] reserved
[    0.000000] reserve setup_data: [mem
0x000000009a600000-0x000000009a7fffff] reserved
[    0.000000] reserve setup_data: [mem
0x000000009b000000-0x00000000a07fffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000e0000000-0x00000000efffffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] reserve setup_data: [mem
0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] reserve setup_data: [mem
0x0000000100000000-0x000000045f7fffff] usable
[    0.000000] efi: EFI v2.7 by American Megatrends
[    0.000000] efi: ACPI=3D0x92459000 ACPI 2.0=3D0x92459014
TPMFinalLog=3D0x9256c000 SMBIOS=3D0x93c61000 SMBIOS 3.0=3D0x93c60000
MEMATTR=3D0x8d79f818 ESRT=3D0x8db77018 MOKvar=3D0x93ca3000 RNG=3D0x923eac1=
8
TPMEventLog=3D0x81e34018
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem76: MMIO range=3D[0xe0000000-0xefffffff]
(256MB) from e820 map
[    0.000000] efi: Not removing mem77: MMIO
range=3D[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem78: MMIO
range=3D[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem79: MMIO
range=3D[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem81: MMIO
range=3D[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem82: MMIO range=3D[0xff000000-0xffffffff]
(16MB) from e820 map
[    0.000000] SMBIOS 3.3.0 present.
[    0.000000] DMI: ASUS System Product Name/ROG STRIX B560-G GAMING
WIFI, BIOS 2001 09/21/2023
[    0.000000] tsc: Detected 2600.000 MHz processor
[    0.000000] tsc: Detected 2592.000 MHz TSC
[    0.000587] last_pfn =3D 0x45f800 max_arch_pfn =3D 0x400000000
[    0.000590] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built
from 10 variable MTRRs
[    0.000591] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC-
WT
[    0.000803] last_pfn =3D 0x93f00 max_arch_pfn =3D 0x400000000
[    0.008074] esrt: Reserving ESRT space from 0x000000008db77018 to
0x000000008db77050.
[    0.008088] Using GB pages for direct mapping
[    0.008308] Secure boot disabled
[    0.008308] RAMDISK: [mem 0x7a76a000-0x7fffdfff]
[    0.008312] ACPI: Early table checksum verification disabled
[    0.008316] ACPI: RSDP 0x0000000092459014 000024 (v02 ALASKA)
[    0.008318] ACPI: XSDT 0x0000000092458728 0000DC (v01 ALASKA A M I
01072009 AMI  01000013)
[    0.008322] ACPI: FACP 0x0000000092456000 000114 (v06 ALASKA A M I
01072009 AMI  01000013)
[    0.008325] ACPI: DSDT 0x00000000923FF000 056BD2 (v02 ALASKA A M I
01072009 INTL 20180209)
[    0.008327] ACPI: FACS 0x00000000925FE000 000040
[    0.008328] ACPI: MCFG 0x0000000092457000 00003C (v01 ALASKA A M I
01072009 MSFT 00000097)
[    0.008330] ACPI: FIDT 0x00000000923FE000 00009C (v01 ALASKA A M I
01072009 AMI  00010013)
[    0.008332] ACPI: SSDT 0x00000000923FA000 0025EB (v02 CpuRef CpuSsdt
00003000 INTL 20180209)
[    0.008333] ACPI: SSDT 0x00000000923F5000 004476 (v02 SaSsdt SaSsdt
00003000 INTL 20180209)
[    0.008335] ACPI: SSDT 0x00000000923F1000 0032CD (v02 INTEL  IgfxSsdt
00003000 INTL 20180209)
[    0.008337] ACPI: HPET 0x00000000923F0000 000038 (v01 ALASKA A M I
01072009 AMI  01000013)
[    0.008338] ACPI: APIC 0x00000000923EF000 000164 (v04 ALASKA A M I
01072009 AMI  01000013)
[    0.008340] ACPI: SSDT 0x00000000923EE000 000E66 (v02 ALASKA Ther_Rvp
00001000 INTL 20180209)
[    0.008341] ACPI: SSDT 0x00000000923EC000 0017E5 (v02 INTEL  xh_rksu4
00000000 INTL 20180209)
[    0.008343] ACPI: NHLT 0x00000000923EB000 00002D (v00 ALASKA A M I
01072009 AMI  01000013)
[    0.008344] ACPI: LPIT 0x00000000923E9000 0000CC (v01 ALASKA A M I
01072009 AMI  01000013)
[    0.008346] ACPI: SSDT 0x00000000923E7000 000DC6 (v02 ALASKA TbtTypeC
00000000 INTL 20180209)
[    0.008348] ACPI: SSDT 0x00000000923E4000 002720 (v02 ALASKA PtidDevc
00001000 INTL 20180209)
[    0.008349] ACPI: DBGP 0x00000000923E3000 000034 (v01 ALASKA A M I
01072009 AMI  01000013)
[    0.008351] ACPI: DBG2 0x00000000923E2000 000054 (v00 ALASKA A M I
01072009 AMI  01000013)
[    0.008352] ACPI: SSDT 0x00000000923E1000 0006E3 (v02 ALASKA UsbCTabl
00001000 INTL 20180209)
[    0.008354] ACPI: DMAR 0x00000000923E0000 000088 (v02 INTEL  EDK2
00000002      01000013)
[    0.008355] ACPI: SSDT 0x00000000923DF000 000144 (v02 Intel  ADebTabl
00001000 INTL 20180209)
[    0.008357] ACPI: TPM2 0x00000000923DE000 00004C (v04 ALASKA A M I
00000001 AMI  00000000)
[    0.008358] ACPI: PTDT 0x00000000923DD000 000CF0 (v00 ALASKA A M I
00000005 MSFT 0100000D)
[    0.008360] ACPI: WSMT 0x00000000923E8000 000028 (v01 ALASKA A M I
01072009 AMI  00010013)
[    0.008362] ACPI: FPDT 0x00000000923DC000 000044 (v01 ALASKA RKL
01072009 AMI  01000013)
[    0.008363] ACPI: Reserving FACP table memory at [mem
0x92456000-0x92456113]
[    0.008364] ACPI: Reserving DSDT table memory at [mem
0x923ff000-0x92455bd1]
[    0.008364] ACPI: Reserving FACS table memory at [mem
0x925fe000-0x925fe03f]
[    0.008365] ACPI: Reserving MCFG table memory at [mem
0x92457000-0x9245703b]
[    0.008365] ACPI: Reserving FIDT table memory at [mem
0x923fe000-0x923fe09b]
[    0.008365] ACPI: Reserving SSDT table memory at [mem
0x923fa000-0x923fc5ea]
[    0.008366] ACPI: Reserving SSDT table memory at [mem
0x923f5000-0x923f9475]
[    0.008366] ACPI: Reserving SSDT table memory at [mem
0x923f1000-0x923f42cc]
[    0.008367] ACPI: Reserving HPET table memory at [mem
0x923f0000-0x923f0037]
[    0.008367] ACPI: Reserving APIC table memory at [mem
0x923ef000-0x923ef163]
[    0.008367] ACPI: Reserving SSDT table memory at [mem
0x923ee000-0x923eee65]
[    0.008368] ACPI: Reserving SSDT table memory at [mem
0x923ec000-0x923ed7e4]
[    0.008368] ACPI: Reserving NHLT table memory at [mem
0x923eb000-0x923eb02c]
[    0.008368] ACPI: Reserving LPIT table memory at [mem
0x923e9000-0x923e90cb]
[    0.008369] ACPI: Reserving SSDT table memory at [mem
0x923e7000-0x923e7dc5]
[    0.008369] ACPI: Reserving SSDT table memory at [mem
0x923e4000-0x923e671f]
[    0.008369] ACPI: Reserving DBGP table memory at [mem
0x923e3000-0x923e3033]
[    0.008370] ACPI: Reserving DBG2 table memory at [mem
0x923e2000-0x923e2053]
[    0.008370] ACPI: Reserving SSDT table memory at [mem
0x923e1000-0x923e16e2]
[    0.008371] ACPI: Reserving DMAR table memory at [mem
0x923e0000-0x923e0087]
[    0.008371] ACPI: Reserving SSDT table memory at [mem
0x923df000-0x923df143]
[    0.008371] ACPI: Reserving TPM2 table memory at [mem
0x923de000-0x923de04b]
[    0.008372] ACPI: Reserving PTDT table memory at [mem
0x923dd000-0x923ddcef]
[    0.008372] ACPI: Reserving WSMT table memory at [mem
0x923e8000-0x923e8027]
[    0.008373] ACPI: Reserving FPDT table memory at [mem
0x923dc000-0x923dc043]
[    0.008415] No NUMA configuration found
[    0.008415] Faking a node at [mem 0x0000000000000000-0x000000045f7fffff=
]
[    0.008417] NODE_DATA(0) allocated [mem 0x45f7fb000-0x45f7fffff]
[    0.027051] Zone ranges:
[    0.027051]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.027052]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.027053]   Normal   [mem 0x0000000100000000-0x000000045f7fffff]
[    0.027054] Movable zone start for each node
[    0.027054] Early memory node ranges
[    0.027054]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.027055]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.027056]   node   0: [mem 0x0000000000100000-0x0000000081983fff]
[    0.027057]   node   0: [mem 0x0000000081985000-0x000000008fcd9fff]
[    0.027057]   node   0: [mem 0x0000000093eff000-0x0000000093efffff]
[    0.027057]   node   0: [mem 0x0000000100000000-0x000000045f7fffff]
[    0.027058] Initmem setup node 0 [mem
0x0000000000001000-0x000000045f7fffff]
[    0.027061] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.027062] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.027078] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.029514] On node 0, zone DMA32: 1 pages in unavailable ranges
[    0.029612] On node 0, zone DMA32: 16933 pages in unavailable ranges
[    0.045720] On node 0, zone Normal: 16640 pages in unavailable ranges
[    0.045734] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.045781] Reserving Intel graphics memory at [mem
0x9c800000-0xa07fffff]
[    0.047135] ACPI: PM-Timer IO Port: 0x1808
[    0.047139] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.047140] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.047141] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.047141] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.047141] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.047142] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.047142] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.047142] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.047143] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.047143] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.047143] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.047144] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.047144] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.047144] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.047145] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.047145] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.047145] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.047146] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.047146] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.047146] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.047185] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI
0-119
[    0.047187] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.047189] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.047191] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.047192] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.047193] TSC deadline timer available
[    0.047194] smpboot: Allowing 12 CPUs, 0 hotplug CPUs
[    0.047204] PM: hibernation: Registered nosave memory: [mem
0x00000000-0x00000fff]
[    0.047205] PM: hibernation: Registered nosave memory: [mem
0x0009e000-0x0009efff]
[    0.047206] PM: hibernation: Registered nosave memory: [mem
0x000a0000-0x000fffff]
[    0.047207] PM: hibernation: Registered nosave memory: [mem
0x81984000-0x81984fff]
[    0.047208] PM: hibernation: Registered nosave memory: [mem
0x81e24000-0x81e24fff]
[    0.047208] PM: hibernation: Registered nosave memory: [mem
0x81e33000-0x81e33fff]
[    0.047209] PM: hibernation: Registered nosave memory: [mem
0x8db77000-0x8db77fff]
[    0.047210] PM: hibernation: Registered nosave memory: [mem
0x8fcda000-0x921d9fff]
[    0.047210] PM: hibernation: Registered nosave memory: [mem
0x921da000-0x92459fff]
[    0.047211] PM: hibernation: Registered nosave memory: [mem
0x9245a000-0x925fefff]
[    0.047211] PM: hibernation: Registered nosave memory: [mem
0x925ff000-0x93efefff]
[    0.047212] PM: hibernation: Registered nosave memory: [mem
0x93f00000-0x99ffffff]
[    0.047212] PM: hibernation: Registered nosave memory: [mem
0x9a000000-0x9a5fffff]
[    0.047213] PM: hibernation: Registered nosave memory: [mem
0x9a600000-0x9a7fffff]
[    0.047213] PM: hibernation: Registered nosave memory: [mem
0x9a800000-0x9affffff]
[    0.047213] PM: hibernation: Registered nosave memory: [mem
0x9b000000-0xa07fffff]
[    0.047214] PM: hibernation: Registered nosave memory: [mem
0xa0800000-0xfdffffff]
[    0.047214] PM: hibernation: Registered nosave memory: [mem
0xfe000000-0xfe010fff]
[    0.047214] PM: hibernation: Registered nosave memory: [mem
0xfe011000-0xfebfffff]
[    0.047215] PM: hibernation: Registered nosave memory: [mem
0xfec00000-0xfec00fff]
[    0.047215] PM: hibernation: Registered nosave memory: [mem
0xfec01000-0xfecfffff]
[    0.047215] PM: hibernation: Registered nosave memory: [mem
0xfed00000-0xfed00fff]
[    0.047216] PM: hibernation: Registered nosave memory: [mem
0xfed01000-0xfed1ffff]
[    0.047216] PM: hibernation: Registered nosave memory: [mem
0xfed20000-0xfed7ffff]
[    0.047216] PM: hibernation: Registered nosave memory: [mem
0xfed80000-0xfedfffff]
[    0.047217] PM: hibernation: Registered nosave memory: [mem
0xfee00000-0xfee00fff]
[    0.047217] PM: hibernation: Registered nosave memory: [mem
0xfee01000-0xffffffff]
[    0.047218] [mem 0xa0800000-0xfdffffff] available for PCI devices
[    0.047220] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.051558] setup_percpu: NR_CPUS:12 nr_cpumask_bits:12 nr_cpu_ids:12
nr_node_ids:1
[    0.051971] percpu: Embedded 47 pages/cpu s154024 r8192 d30296 u262144
[    0.051990] Kernel command line:
BOOT_IMAGE=3D(hd1,gpt1)/vmlinuz-6.7.4-rc1_MY
root=3DUUID=3D704d7d4e-6ca3-4647-b027-44dc162e2b3c ro rootflags=3Dsubvol=
=3DROOT
console=3Dtty0 console=3Dtty1 console=3DttyS0,115200 systemd.log_level=3Dd=
ebug
no_console_suspend
[    0.052048] Unknown kernel command line parameters
"BOOT_IMAGE=3D(hd1,gpt1)/vmlinuz-6.7.4-rc1_MY", will be passed to user spa=
ce.
[    0.053232] Dentry cache hash table entries: 2097152 (order: 12,
16777216 bytes, linear)
[    0.053811] Inode-cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.053917] Fallback order for Node 0: 0
[    0.053919] Built 1 zonelists, mobility grouping on.  Total pages:
4061190
[    0.053920] Policy zone: Normal
[    0.054078] mem auto-init: stack:all(zero), heap alloc:off, heap free:o=
ff
[    0.054087] software IO TLB: area num 16.
[    0.083728] Memory: 15915072K/16503264K available (20480K kernel
code, 2125K rwdata, 14680K rodata, 2908K init, 1528K bss, 587932K
reserved, 0K cma-reserved)
[    0.083843] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D12,=
 Nodes=3D1
[    0.084294] Dynamic Preempt: voluntary
[    0.084322] rcu: Preemptible hierarchical RCU implementation.
[    0.084323] 	Trampoline variant of Tasks RCU enabled.
[    0.084323] 	Tracing variant of Tasks RCU enabled.
[    0.084324] rcu: RCU calculated value of scheduler-enlistment delay
is 100 jiffies.
[    0.084330] NR_IRQS: 4352, nr_irqs: 2152, preallocated irqs: 16
[    0.084721] rcu: srcu_init: Setting srcu_struct sizes based on
contention.
[    0.084952] kfence: initialized - using 2097152 bytes for 255 objects
at 0x(____ptrval____)-0x(____ptrval____)
[    0.084970] Console: colour dummy device 80x25
[    0.084972] printk: legacy console [tty0] enabled
[    0.085203] printk: legacy console [ttyS0] enabled
[    1.736164] ACPI: Core revision 20230628
[    1.740296] hpet: HPET dysfunctional in PC10. Force disabled.
[    1.746076] APIC: Switch to symmetric I/O mode setup
[    1.751048] DMAR: Host address width 39
[    1.754892] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    1.760216] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap
1c0000c40660462 ecap 29a00f0505e
[    1.768662] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    1.773985] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap
d2008c40660462 ecap f050da
[    1.781906] DMAR: RMRR base: 0x0000009c000000 end: 0x000000a07fffff
[    1.788183] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    1.794545] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    1.799954] DMAR-IR: Queued invalidation will be enabled to support
x2apic and Intr-remapping.
[    1.810171] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    1.815589] x2apic enabled
[    1.818358] APIC: Switched APIC routing to: cluster x2apic
[    1.827940] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x255cb6cc5db, max_idle_ns: 440795203504 ns
[    1.838482] Calibrating delay loop (skipped), value calculated using
timer frequency.. 5184.00 BogoMIPS (lpj=3D2592000)
[    1.839481] CPU0: Thermal monitoring enabled (TM1)
[    1.839481] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    1.839481] process: using mwait in idle threads
[    1.839481] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    1.839481] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    1.839481] Spectre V1 : Mitigation: usercopy/swapgs barriers and
__user pointer sanitization
[    1.839481] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    1.839481] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling
RSB on context switch
[    1.839481] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single
CALL on VMEXIT
[    1.839481] RETBleed: Mitigation: Enhanced IBRS
[    1.839481] Spectre V2 : mitigation: Enabling conditional Indirect
Branch Prediction Barrier
[    1.839481] Speculative Store Bypass: Mitigation: Speculative Store
Bypass disabled via prctl
[    1.839481] MMIO Stale Data: Mitigation: Clear CPU buffers
[    1.839481] GDS: Mitigation: Microcode
[    1.839481] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating
point registers'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds
registers'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x020: 'AVX-512 opmask'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x040: 'AVX-512 Hi256'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x080: 'AVX-512 ZMM_Hi256=
'
[    1.839481] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys
User registers'
[    1.839481] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    1.839481] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    1.839481] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    1.839481] x86/fpu: xstate_offset[5]:  960, xstate_sizes[5]:   64
[    1.839481] x86/fpu: xstate_offset[6]: 1024, xstate_sizes[6]:  512
[    1.839481] x86/fpu: xstate_offset[7]: 1536, xstate_sizes[7]: 1024
[    1.839481] x86/fpu: xstate_offset[9]: 2560, xstate_sizes[9]:    8
[    1.839481] x86/fpu: Enabled xstate features 0x2ff, context size is
2568 bytes, using 'compacted' format.
[    1.839481] Freeing SMP alternatives memory: 60K
[    1.839481] pid_max: default: 32768 minimum: 301
[    1.839481] LSM: initializing
lsm=3Dlockdown,capability,yama,selinux,landlock,integrity
[    1.839481] Yama: becoming mindful.
[    1.839481] SELinux:  Initializing.
[    1.839481] landlock: Up and running.
[    1.839481] Mount-cache hash table entries: 32768 (order: 6, 262144
bytes, linear)
[    1.839481] Mountpoint-cache hash table entries: 32768 (order: 6,
262144 bytes, linear)
[    1.839481] smpboot: CPU0: 11th Gen Intel(R) Core(TM) i5-11400 @
2.60GHz (family: 0x6, model: 0xa7, stepping: 0x1)
[    1.839575] RCU Tasks: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1.
[    1.840489] RCU Tasks Trace: Setting shift to 4 and lim to 1
rcu_task_cb_adjust=3D1.
[    1.841489] Performance Events: PEBS fmt4+-baseline,  AnyThread
deprecated, Icelake events, 32-deep LBR, full-width counters, Intel PMU
driver.
[    1.842483] ... version:                5
[    1.843482] ... bit width:              48
[    1.844482] ... generic registers:      8
[    1.845482] ... value mask:             0000ffffffffffff
[    1.846482] ... max period:             00007fffffffffff
[    1.847482] ... fixed-purpose events:   4
[    1.848482] ... event mask:             0001000f000000ff
[    1.849544] signal: max sigframe size: 3632
[    1.850490] Estimated ratio of average max frequency by base
frequency (times 1024): 1693
[    1.851514] rcu: Hierarchical SRCU implementation.
[    1.852482] rcu: 	Max phase no-delay instances is 400.
[    1.853984] NMI watchdog: Enabled. Permanently consumes one hw-PMU
counter.
[    1.854544] smp: Bringing up secondary CPUs ...
[    1.855531] smpboot: x86: Booting SMP configuration:
[    1.856483] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
#8  #9 #10 #11
[    1.859963] MMIO Stale Data CPU bug present and SMT on, data leak
possible. See
https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/processor_mmio_=
stale_data.html
for more details.
[    1.861528] smp: Brought up 1 node, 12 CPUs
[    1.862482] smpboot: Max logical packages: 1
[    1.863483] smpboot: Total of 12 processors activated (62208.00 BogoMIP=
S)
[    1.865768] devtmpfs: initialized
[    1.866617] ACPI: PM: Registering ACPI NVS region [mem
0x9245a000-0x925fefff] (1724416 bytes)
[    1.867521] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275000 ns
[    1.868484] futex hash table entries: 4096 (order: 6, 262144 bytes,
linear)
[    1.869518] pinctrl core: initialized pinctrl subsystem
[    1.870681] PM: RTC time: 17:00:48, date: 2024-02-03
[    1.871711] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    1.872577] audit: initializing netlink subsys (disabled)
[    1.873497] audit: type=3D2000 audit(1706979646.035:1):
state=3Dinitialized audit_enabled=3D0 res=3D1
[    1.873533] thermal_sys: Registered thermal governor 'fair_share'
[    1.874483] thermal_sys: Registered thermal governor 'bang_bang'
[    1.875482] thermal_sys: Registered thermal governor 'step_wise'
[    1.876482] thermal_sys: Registered thermal governor 'user_space'
[    1.877488] cpuidle: using governor menu
[    1.879578] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    1.880484] PCI: not using MMCONFIG
[    1.881483] PCI: Using configuration type 1 for base access
[    1.882650] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.883525] kprobes: kprobe jump-optimization is enabled. All kprobes
are optimized if possible.
[    1.884508] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pag=
es
[    1.885482] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    1.886483] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    1.887482] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    1.888513] cryptd: max_cpu_qlen set to 1000
[    1.889522] raid6: skipped pq benchmark and selected avx512x4
[    1.890483] raid6: using avx512x2 recovery algorithm
[    1.891501] fbcon: Taking over console
[    1.892494] ACPI: Added _OSI(Module Device)
[    1.893482] ACPI: Added _OSI(Processor Device)
[    1.894482] ACPI: Added _OSI(3.0 _SCP Extensions)
[    1.895482] ACPI: Added _OSI(Processor Aggregator Device)
[    1.937998] ACPI: 10 ACPI AML tables successfully acquired and loaded
[    1.943005] ACPI: Dynamic OEM Table Load:
[    1.943486] ACPI: SSDT 0xFFFFA05541C70400 000394 (v02 PmRef  Cpu0Cst
00003001 INTL 20180209)
[    1.945057] ACPI: Dynamic OEM Table Load:
[    1.945485] ACPI: SSDT 0xFFFFA055411FA000 000581 (v02 PmRef  Cpu0Ist
00003000 INTL 20180209)
[    1.947064] ACPI: Dynamic OEM Table Load:
[    1.947484] ACPI: SSDT 0xFFFFA05541CDB400 0001CB (v02 PmRef  Cpu0Psd
00003000 INTL 20180209)
[    1.949020] ACPI: Dynamic OEM Table Load:
[    1.949484] ACPI: SSDT 0xFFFFA05541C74800 0002F4 (v02 PmRef  Cpu0Hwp
00003000 INTL 20180209)
[    1.951143] ACPI: Dynamic OEM Table Load:
[    1.951486] ACPI: SSDT 0xFFFFA05540094000 0008E7 (v02 PmRef  ApIst
00003000 INTL 20180209)
[    1.953118] ACPI: Dynamic OEM Table Load:
[    1.953484] ACPI: SSDT 0xFFFFA05541D90000 00048A (v02 PmRef  ApHwp
00003000 INTL 20180209)
[    1.955080] ACPI: Dynamic OEM Table Load:
[    1.955484] ACPI: SSDT 0xFFFFA05541D91800 0004D4 (v02 PmRef  ApPsd
00003000 INTL 20180209)
[    1.957078] ACPI: Dynamic OEM Table Load:
[    1.957484] ACPI: SSDT 0xFFFFA05541D97800 00048A (v02 PmRef  ApCst
00003000 INTL 20180209)
[    1.962154] ACPI: _OSC evaluated successfully for all CPUs
[    1.963407] ACPI: Interpreter enabled
[    1.963516] ACPI: PM: (supports S0 S3 S4 S5)
[    1.964482] ACPI: Using IOAPIC for interrupt routing
[    1.966242] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    1.967697] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved as
ACPI motherboard resource
[    1.968488] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=3Dnocrs" and report a bug
[    1.969482] PCI: Ignoring E820 reservations for host bridge windows
[    1.971481] ACPI: Enabled 6 GPEs in block 00 to 7F
[    1.981711] ACPI: \_SB_.PC00.XHCI.RHUB.HS14.BTRT: New power resource
[    1.987461] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    1.987615] ACPI: \_SB_.PC00.SAT0.VOL0.V0PR: New power resource
[    1.988542] ACPI: \_SB_.PC00.SAT0.VOL1.V1PR: New power resource
[    1.989537] ACPI: \_SB_.PC00.SAT0.VOL2.V2PR: New power resource
[    1.994882] ACPI: \_TZ_.FN00: New power resource
[    1.995513] ACPI: \_TZ_.FN01: New power resource
[    1.996510] ACPI: \_TZ_.FN02: New power resource
[    1.997511] ACPI: \_TZ_.FN03: New power resource
[    1.998510] ACPI: \_TZ_.FN04: New power resource
[    1.999831] ACPI: \PIN_: New power resource
[    2.000680] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    2.001484] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI EDR HPX-Type3]
[    2.003588] acpi PNP0A08:00: _OSC: OS now controls [PME AER
PCIeCapability LTR DPC]
[    2.004916] PCI host bridge to bus 0000:00
[    2.005483] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 windo=
w]
[    2.006482] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff windo=
w]
[    2.007482] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    2.008482] pci_bus 0000:00: root bus resource [mem
0x000e0000-0x000effff window]
[    2.009482] pci_bus 0000:00: root bus resource [mem
0xa0800000-0xdfffffff window]
[    2.010482] pci_bus 0000:00: root bus resource [mem
0x4000000000-0x7fffffffff window]
[    2.011484] pci_bus 0000:00: root bus resource [bus 00-fe]
[    2.012643] pci 0000:00:00.0: [8086:4c53] type 00 class 0x060000
[    2.013612] pci 0000:00:02.0: [8086:4c8b] type 00 class 0x030000
[    2.014488] pci 0000:00:02.0: reg 0x10: [mem
0x6000000000-0x6000ffffff 64bit]
[    2.015486] pci 0000:00:02.0: reg 0x18: [mem
0x4000000000-0x400fffffff 64bit pref]
[    2.016484] pci 0000:00:02.0: reg 0x20: [io  0x5000-0x503f]
[    2.017493] pci 0000:00:02.0: BAR 2: assigned to efifb
[    2.018482] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    2.019483] pci 0000:00:02.0: Video device with shadowed ROM at [mem
0x000c0000-0x000dffff]
[    2.020628] pci 0000:00:06.0: [8086:4c09] type 01 class 0x060400
[    2.021564] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    2.022514] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    2.023973] pci 0000:00:14.0: [8086:43ed] type 00 class 0x0c0330
[    2.024502] pci 0000:00:14.0: reg 0x10: [mem
0x6001100000-0x600110ffff 64bit]
[    2.025555] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    2.027691] pci 0000:00:14.2: [8086:43ef] type 00 class 0x050000
[    2.028500] pci 0000:00:14.2: reg 0x10: [mem
0x6001118000-0x600111bfff 64bit]
[    2.029493] pci 0000:00:14.2: reg 0x18: [mem
0x6001121000-0x6001121fff 64bit]
[    2.030617] pci 0000:00:14.3: [8086:43f0] type 00 class 0x028000
[    2.031545] pci 0000:00:14.3: reg 0x10: [mem
0x6001114000-0x6001117fff 64bit]
[    2.032639] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    2.034373] pci 0000:00:15.0: [8086:43e8] type 00 class 0x0c8000
[    2.035468] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bi=
t]
[    2.039980] pci 0000:00:15.1: [8086:43e9] type 00 class 0x0c8000
[    2.041482] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bi=
t]
[    2.046981] pci 0000:00:15.2: [8086:43ea] type 00 class 0x0c8000
[    2.048467] pci 0000:00:15.2: reg 0x10: [mem 0x00000000-0x00000fff 64bi=
t]
[    2.052341] pci 0000:00:16.0: [8086:43e0] type 00 class 0x078000
[    2.052504] pci 0000:00:16.0: reg 0x10: [mem
0x600111d000-0x600111dfff 64bit]
[    2.053562] pci 0000:00:16.0: PME# supported from D3hot
[    2.054854] pci 0000:00:17.0: [8086:43d2] type 00 class 0x010601
[    2.055495] pci 0000:00:17.0: reg 0x10: [mem 0xa1f00000-0xa1f01fff]
[    2.056489] pci 0000:00:17.0: reg 0x14: [mem 0xa1f03000-0xa1f030ff]
[    2.057489] pci 0000:00:17.0: reg 0x18: [io  0x5090-0x5097]
[    2.058488] pci 0000:00:17.0: reg 0x1c: [io  0x5080-0x5083]
[    2.059489] pci 0000:00:17.0: reg 0x20: [io  0x5060-0x507f]
[    2.060488] pci 0000:00:17.0: reg 0x24: [mem 0xa1f02000-0xa1f027ff]
[    2.061520] pci 0000:00:17.0: PME# supported from D3hot
[    2.062886] pci 0000:00:1c.0: [8086:43bc] type 01 class 0x060400
[    2.063569] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    2.064957] pci 0000:00:1c.6: [8086:43be] type 01 class 0x060400
[    2.065590] pci 0000:00:1c.6: PME# supported from D0 D3hot D3cold
[    2.066524] pci 0000:00:1c.6: PTM enabled (root), 4ns granularity
[    2.067969] pci 0000:00:1d.0: [8086:43b0] type 01 class 0x060400
[    2.068569] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    2.069947] pci 0000:00:1f.0: [8086:4387] type 00 class 0x060100
[    2.070761] pci 0000:00:1f.3: [8086:43c8] type 00 class 0x040300
[    2.071521] pci 0000:00:1f.3: reg 0x10: [mem
0x6001110000-0x6001113fff 64bit]
[    2.072531] pci 0000:00:1f.3: reg 0x20: [mem
0x6001000000-0x60010fffff 64bit]
[    2.073579] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    2.074854] pci 0000:00:1f.4: [8086:43a3] type 00 class 0x0c0500
[    2.075504] pci 0000:00:1f.4: reg 0x10: [mem
0x600111c000-0x600111c0ff 64bit]
[    2.076508] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    2.077665] pci 0000:00:1f.5: [8086:43a4] type 00 class 0x0c8000
[    2.078499] pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
[    2.079914] pci 0000:01:00.0: [144d:a80a] type 00 class 0x010802
[    2.080792] pci 0000:01:00.0: reg 0x10: [mem 0xa1e00000-0xa1e03fff 64bi=
t]
[    2.082007] pci 0000:00:06.0: PCI bridge to [bus 01]
[    2.082489] pci 0000:00:06.0:   bridge window [mem 0xa1e00000-0xa1effff=
f]
[    2.083531] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    2.084484] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    2.085485] pci 0000:00:1c.0:   bridge window [mem 0xa1200000-0xa1bffff=
f]
[    2.086622] pci 0000:03:00.0: [8086:15f3] type 00 class 0x020000
[    2.087573] pci 0000:03:00.0: reg 0x10: [mem 0xa1c00000-0xa1cfffff]
[    2.088579] pci 0000:03:00.0: reg 0x1c: [mem 0xa1d00000-0xa1d03fff]
[    2.089677] pci 0000:03:00.0: PME# supported from D0 D3hot D3cold
[    2.090756] pci 0000:00:1c.6: PCI bridge to [bus 03]
[    2.091486] pci 0000:00:1c.6:   bridge window [mem 0xa1c00000-0xa1dffff=
f]
[    2.092518] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    2.093484] pci 0000:00:1d.0:   bridge window [io  0x3000-0x3fff]
[    2.094484] pci 0000:00:1d.0:   bridge window [mem 0xa0800000-0xa11ffff=
f]
[    2.096454] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    2.096543] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    2.097540] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    2.098540] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    2.099540] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    2.100540] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    2.101540] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    2.102540] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    2.108675] iommu: Default domain type: Translated
[    2.109485] iommu: DMA domain TLB invalidation policy: lazy mode
[    2.110534] SCSI subsystem initialized
[    2.111496] ACPI: bus type USB registered
[    2.112488] usbcore: registered new interface driver usbfs
[    2.113485] usbcore: registered new interface driver hub
[    2.114485] usbcore: registered new device driver usb
[    2.115488] pps_core: LinuxPPS API ver. 1 registered
[    2.116482] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    2.117483] PTP clock support registered
[    2.118486] EDAC MC: Ver: 3.0.0
[    2.120372] efivars: Registered efivars operations
[    2.120503] Advanced Linux Sound Architecture Driver Initialized.
[    2.121587] NetLabel: Initializing
[    2.122482] NetLabel:  domain hash size =3D 128
[    2.123482] NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
[    2.124488] NetLabel:  unlabeled traffic allowed by default
[    2.125482] mctp: management component transport protocol core
[    2.126482] NET: Registered PF_MCTP protocol family
[    2.127484] PCI: Using ACPI for IRQ routing
[    2.151576] pci 0000:00:1f.5: can't claim BAR 0 [mem
0xfe010000-0xfe010fff]: no compatible bridge window
[    2.153155] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    2.153481] pci 0000:00:02.0: vgaarb: bridge control possible
[    2.153481] pci 0000:00:02.0: vgaarb: VGA device added:
decodes=3Dio+mem,owns=3Dio+mem,locks=3Dnone
[    2.153483] vgaarb: loaded
[    2.154718] acpi PNP0C14:06: duplicate WMI GUID
97845ED0-4E6D-11DE-8A39-0800200C9A66 (first instance was on PNP0C14:02)
[    2.155560] clocksource: Switched to clocksource tsc-early
[    2.161062] VFS: Disk quotas dquot_6.6.0
[    2.165030] VFS: Dquot-cache hash table entries: 512 (order 0, 4096
bytes)
[    2.171933] FS-Cache: Loaded
[    2.174854] CacheFiles: Loaded
[    2.177957] pnp: PnP ACPI init
[    2.181106] system 00:00: [io  0x0290-0x029f] has been reserved
[    2.187541] system 00:02: [io  0x0680-0x069f] has been reserved
[    2.193496] system 00:02: [io  0x164e-0x164f] has been reserved
[    2.199499] system 00:03: [io  0x1854-0x1857] has been reserved
[    2.205761] system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
[    2.212419] system 00:04: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    2.219052] system 00:04: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    2.225691] system 00:04: [mem 0xe0000000-0xefffffff] has been reserved
[    2.232366] system 00:04: [mem 0xfed20000-0xfed7ffff] could not be
reserved
[    2.239341] system 00:04: [mem 0xfed90000-0xfed93fff] could not be
reserved
[    2.246311] system 00:04: [mem 0xfed45000-0xfed8ffff] could not be
reserved
[    2.253281] system 00:04: [mem 0xfee00000-0xfeefffff] could not be
reserved
[    2.260852] system 00:05: [io  0x1800-0x18fe] could not be reserved
[    2.267154] system 00:05: [mem 0xfe000000-0xfe01ffff] could not be
reserved
[    2.274125] system 00:05: [mem 0xfe04c000-0xfe04ffff] has been reserved
[    2.280745] system 00:05: [mem 0xfe050000-0xfe0affff] has been reserved
[    2.287371] system 00:05: [mem 0xfe0d0000-0xfe0fffff] has been reserved
[    2.293993] system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
[    2.300618] system 00:05: [mem 0xff000000-0xffffffff] has been reserved
[    2.307241] system 00:05: [mem 0xfd000000-0xfd68ffff] has been reserved
[    2.313862] system 00:05: [mem 0xfd6c0000-0xfd6cffff] has been reserved
[    2.320486] system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
[    2.327317] system 00:06: [io  0x2000-0x20fe] has been reserved
[    2.333703] pnp: PnP ACPI: found 8 devices
[    2.343033] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    2.351994] NET: Registered PF_INET protocol family
[    2.357038] IP idents hash table entries: 262144 (order: 9, 2097152
bytes, linear)
[    2.366364] tcp_listen_portaddr_hash hash table entries: 8192 (order:
5, 131072 bytes, linear)
[    2.375031] Table-perturb hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    2.382798] TCP established hash table entries: 131072 (order: 8,
1048576 bytes, linear)
[    2.390983] TCP bind hash table entries: 65536 (order: 9, 2097152
bytes, linear)
[    2.398558] TCP: Hash tables configured (established 131072 bind 65536)
[    2.405268] MPTCP token hash table entries: 16384 (order: 6, 393216
bytes, linear)
[    2.412890] UDP hash table entries: 8192 (order: 6, 262144 bytes, linea=
r)
[    2.419708] UDP-Lite hash table entries: 8192 (order: 6, 262144
bytes, linear)
[    2.427002] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    2.432773] RPC: Registered named UNIX socket transport module.
[    2.438727] RPC: Registered udp transport module.
[    2.443439] RPC: Registered tcp transport module.
[    2.448154] RPC: Registered tcp-with-tls transport module.
[    2.453648] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    2.460100] NET: Registered PF_XDP protocol family
[    2.464900] pci 0000:00:1c.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align
100000
[    2.476409] pci 0000:00:1d.0: bridge window [mem
0x00100000-0x000fffff 64bit pref] to [bus 04] add_size 200000 add_align
100000
[    2.487946] pci 0000:00:1c.0: BAR 15: assigned [mem
0x4010000000-0x40101fffff 64bit pref]
[    2.496140] pci 0000:00:1d.0: BAR 15: assigned [mem
0x4010200000-0x40103fffff 64bit pref]
[    2.504326] pci 0000:00:15.0: BAR 0: assigned [mem
0x4010400000-0x4010400fff 64bit]
[    2.512464] pci 0000:00:15.1: BAR 0: assigned [mem
0x4010401000-0x4010401fff 64bit]
[    2.520607] pci 0000:00:15.2: BAR 0: assigned [mem
0x4010402000-0x4010402fff 64bit]
[    2.528748] pci 0000:00:1f.5: BAR 0: assigned [mem 0xa1f04000-0xa1f04ff=
f]
[    2.535553] pci 0000:00:06.0: PCI bridge to [bus 01]
[    2.540538] pci 0000:00:06.0:   bridge window [mem 0xa1e00000-0xa1effff=
f]
[    2.547355] pci 0000:00:1c.0: PCI bridge to [bus 02]
[    2.552340] pci 0000:00:1c.0:   bridge window [io  0x4000-0x4fff]
[    2.558442] pci 0000:00:1c.0:   bridge window [mem 0xa1200000-0xa1bffff=
f]
[    2.565238] pci 0000:00:1c.0:   bridge window [mem
0x4010000000-0x40101fffff 64bit pref]
[    2.573340] pci 0000:00:1c.6: PCI bridge to [bus 03]
[    2.578311] pci 0000:00:1c.6:   bridge window [mem 0xa1c00000-0xa1dffff=
f]
[    2.585111] pci 0000:00:1d.0: PCI bridge to [bus 04]
[    2.590090] pci 0000:00:1d.0:   bridge window [io  0x3000-0x3fff]
[    2.596195] pci 0000:00:1d.0:   bridge window [mem 0xa0800000-0xa11ffff=
f]
[    2.602991] pci 0000:00:1d.0:   bridge window [mem
0x4010200000-0x40103fffff 64bit pref]
[    2.611091] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    2.617285] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    2.623472] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff
window]
[    2.630358] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000effff
window]
[    2.637240] pci_bus 0000:00: resource 8 [mem 0xa0800000-0xdfffffff
window]
[    2.644125] pci_bus 0000:00: resource 9 [mem
0x4000000000-0x7fffffffff window]
[    2.651355] pci_bus 0000:01: resource 1 [mem 0xa1e00000-0xa1efffff]
[    2.657634] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    2.663213] pci_bus 0000:02: resource 1 [mem 0xa1200000-0xa1bfffff]
[    2.669489] pci_bus 0000:02: resource 2 [mem
0x4010000000-0x40101fffff 64bit pref]
[    2.677069] pci_bus 0000:03: resource 1 [mem 0xa1c00000-0xa1dfffff]
[    2.683345] pci_bus 0000:04: resource 0 [io  0x3000-0x3fff]
[    2.688927] pci_bus 0000:04: resource 1 [mem 0xa0800000-0xa11fffff]
[    2.695202] pci_bus 0000:04: resource 2 [mem
0x4010200000-0x40103fffff 64bit pref]
[    2.703799] PCI: CLS 64 bytes, default 64
[    2.707829] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.707875] Unpacking initramfs...
[    2.714283] software IO TLB: mapped [mem
0x0000000087339000-0x000000008b339000] (64MB)
[    2.726023] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x255cb6cc5db, max_idle_ns: 440795203504 ns
[    2.736130] clocksource: Switched to clocksource tsc
[    2.741148] platform rtc_cmos: registered platform RTC device (no PNP
device found)
[    2.754303] Initialise system trusted keyrings
[    2.758797] Key type blacklist registered
[    2.762853] workingset: timestamp_bits=3D40 max_order=3D22 bucket_order=
=3D0
[    2.769433] DLM installed
[    2.772158] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.778124] NFS: Registering the id_resolver key type
[    2.783213] Key type id_resolver registered
[    2.787409] Key type id_legacy registered
[    2.791432] nfs4filelayout_init: NFSv4 File Layout Driver Registering..=
.
[    2.798139] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver
Registering...
[    2.805720] Key type cifs.spnego registered
[    2.809939] Key type cifs.idmap registered
[    2.814072] ntfs3: Max link count 4000
[    2.817860] ntfs3: Enabled Linux POSIX ACLs support
[    2.822749] ntfs3: Read-only LZX/Xpress compression included
[    2.828471] fuse: init (API version 7.39)
[    2.832792] integrity: Platform Keyring initialized
[    2.837707] integrity: Machine keyring initialized
[    2.848412] NET: Registered PF_ALG protocol family
[    2.853245] xor: automatically using best checksumming function   avx

[    2.860303] Key type asymmetric registered
[    2.864406] Asymmetric key parser 'x509' registered
[    2.869294] Asymmetric key parser 'pkcs8' registered
[    3.524957] Freeing initrd memory: 90704K
[    3.530809] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 245)
[    3.538293] io scheduler mq-deadline registered
[    3.542859] io scheduler kyber registered
[    3.546883] io scheduler bfq registered
[    3.556356] pcieport 0000:00:06.0: PME: Signaling with IRQ 122
[    3.562297] pcieport 0000:00:06.0: AER: enabled with IRQ 122
[    3.568040] pcieport 0000:00:06.0: DPC: enabled with IRQ 122
[    3.573739] pcieport 0000:00:06.0: DPC: error containment
capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4,
DL_ActiveErr+
[    3.586659] pcieport 0000:00:1c.0: PME: Signaling with IRQ 123
[    3.592699] pcieport 0000:00:1c.6: PME: Signaling with IRQ 124
[    3.598633] pcieport 0000:00:1c.6: AER: enabled with IRQ 124
[    3.604383] pcieport 0000:00:1c.6: DPC: enabled with IRQ 124
[    3.610049] pcieport 0000:00:1c.6: DPC: error containment
capabilities: Int Msg #0, RPExt+ PoisonedTLP+ SwTrigger+ RP PIO Log 4,
DL_ActiveErr+
[    3.622962] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    3.628990] ACPI: \_SB_.PR00: Found 3 idle states
[    3.634150] input: Sleep Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    3.642553] ACPI: button: Sleep Button [SLPB]
[    3.646956] input: Power Button as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    3.655326] ACPI: button: Power Button [PWRB]
[    3.659714] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    3.667164] ACPI: button: Power Button [PWRF]
[    3.672807] thermal LNXTHERM:00: registered as thermal_zone0
[    3.678506] ACPI: thermal: Thermal Zone [TZ00] (28 C)
[    3.683671] Serial: 8250/16550 driver, 32 ports, IRQ sharing disabled
[    3.690228] 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200)
is a 16550A
[    3.699663] hpet_acpi_add: no address or irqs in _CRS
[    3.704788] Non-volatile memory driver v1.3
[    3.716254] loop: module loaded
[    3.719538] zram: Added device: zram0
[    3.735666] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    3.742397] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    3.760516] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    3.767358] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    3.785649] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
[    3.792568] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    3.799779] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    3.800273] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps
0x3f impl SATA mode
[    3.806395] nvme nvme0: pci function 0000:01:00.0
[    3.814479] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio
slum part ems deso sadm sds
[    3.834102] scsi host0: ahci
[    3.837224] scsi host1: ahci
[    3.839099] nvme nvme0: Shutdown timeout set to 10 seconds
[    3.840317] scsi host2: ahci
[    3.848751] scsi host3: ahci
[    3.849321] nvme nvme0: 12/0/0 default/read/poll queues
[    3.851882] scsi host4: ahci
[    3.859213]  nvme0n1: p1 p2 p3
[    3.859932] scsi host5: ahci
[    3.865851] ata1: SATA max UDMA/133 abar m2048@0xa1f02000 port
0xa1f02100 irq 126 lpm-pol 0
[    3.874216] ata2: SATA max UDMA/133 abar m2048@0xa1f02000 port
0xa1f02180 irq 126 lpm-pol 0
[    3.882580] ata3: SATA max UDMA/133 abar m2048@0xa1f02000 port
0xa1f02200 irq 126 lpm-pol 0
[    3.890940] ata4: SATA max UDMA/133 abar m2048@0xa1f02000 port
0xa1f02280 irq 126 lpm-pol 0
[    3.899299] ata5: SATA max UDMA/133 abar m2048@0xa1f02000 port
0xa1f02300 irq 126 lpm-pol 0
[    3.907658] ata6: SATA max UDMA/133 abar m2048@0xa1f02000 port
0xa1f02380 irq 126 lpm-pol 0
[    3.916056] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com
for information.
[    3.923918] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld
<Jason@zx2c4.com>. All Rights Reserved.
[    3.933540] Intel(R) 2.5G Ethernet Linux Driver
[    3.938110] Copyright(c) 2018 Intel Corporation.
[    3.942902] igc 0000:03:00.0: enabling device (0000 -> 0002)
[    3.948646] igc 0000:03:00.0: PTM enabled, 4ns granularity
[    4.001077] pps pps0: new PPS source ptp0
[    4.005283] igc 0000:03:00.0 (unnamed net_device) (uninitialized):
PHC added
[    4.038011] igc 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth
(5.0 GT/s PCIe x1 link)
[    4.046231] igc 0000:03:00.0 eth0: MAC: fc:34:97:e0:39:f6
[    4.052063] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    4.057432] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 1
[    4.066008] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version
0x120 quirks 0x0000000200009810
[    4.075421] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    4.080716] xhci_hcd 0000:00:14.0: new USB bus registered, assigned
bus number 2
[    4.088153] xhci_hcd 0000:00:14.0: Host supports USB 3.2 Enhanced
SuperSpeed
[    4.095457] usb usb1: New USB device found, idVendor=3D1d6b,
idProduct=3D0002, bcdDevice=3D 6.07
[    4.103763] usb usb1: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    4.110999] usb usb1: Product: xHCI Host Controller
[    4.115884] usb usb1: Manufacturer: Linux 6.7.4-rc1_MY xhci-hcd
[    4.121813] usb usb1: SerialNumber: 0000:00:14.0
[    4.126582] hub 1-0:1.0: USB hub found
[    4.130423] hub 1-0:1.0: 16 ports detected
[    4.137457] usb usb2: New USB device found, idVendor=3D1d6b,
idProduct=3D0003, bcdDevice=3D 6.07
[    4.145766] usb usb2: New USB device strings: Mfr=3D3, Product=3D2,
SerialNumber=3D1
[    4.152996] usb usb2: Product: xHCI Host Controller
[    4.157881] usb usb2: Manufacturer: Linux 6.7.4-rc1_MY xhci-hcd
[    4.163812] usb usb2: SerialNumber: 0000:00:14.0
[    4.168539] hub 2-0:1.0: USB hub found
[    4.172384] hub 2-0:1.0: 5 ports detected
[    4.177843] usbcore: registered new interface driver usblp
[    4.183561] usbcore: registered new interface driver uas
[    4.188920] usbcore: registered new interface driver usb-storage
[    4.194951] usbcore: registered new interface driver pl2303
[    4.200541] usbserial: USB Serial support registered for pl2303
[    4.206486] i8042: PNP: No PS/2 controller found.
[    4.211294] mousedev: PS/2 mouse device common for all mice
[    4.217044] input: PC Speaker as /devices/platform/pcspkr/input/input3
[    4.219161] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    4.223697] rtc_cmos rtc_cmos: RTC can wake from S4
[    4.229829] ata6: SATA link down (SStatus 4 SControl 300)
[    4.236556] rtc_cmos rtc_cmos: registered as rtc0
[    4.240136] ata2: SATA link down (SStatus 4 SControl 300)
[    4.245195] rtc_cmos rtc_cmos: setting system clock to
2024-02-03T17:00:51 UTC (1706979651)
[    4.250315] ata3: SATA link down (SStatus 4 SControl 300)
[    4.258689] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes
nvram
[    4.264118] ata4: SATA link down (SStatus 4 SControl 300)
[    4.271259] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.276461] ata5: SATA link down (SStatus 4 SControl 300)
[    4.282228] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.287675] ata1.00: ATA-9: INTEL SSDSC2CT120A3, 300i, max UDMA/133
[    4.294163] i2c i2c-0: 2/4 memory slots populated (from DMI)
[    4.299807] ata1.00: 234441648 sectors, multi 16: LBA48 NCQ (depth
32), AA
[    4.302535] nct6775: Found NCT6798D or compatible chip at 0x2e:0x290
[    4.306747] ee1004 0-0051: 512 byte EE1004-compliant SPD EEPROM,
read-only
[    4.321614] ata1.00: configured for UDMA/133
[    4.325657] i2c i2c-0: Successfully instantiated SPD at 0x51
[    4.330136] scsi 0:0:0:0: Direct-Access     ATA      INTEL SSDSC2CT12
300i PQ: 0 ANSI: 5
[    4.336521] ee1004 0-0053: 512 byte EE1004-compliant SPD EEPROM,
read-only
[    4.344525] sd 0:0:0:0: [sda] 234441648 512-byte logical blocks: (120
GB/112 GiB)
[    4.344533] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    4.350729] i2c i2c-0: Successfully instantiated SPD at 0x53
[    4.369311] sd 0:0:0:0: [sda] Write Protect is off
[    4.374241] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    4.377628] usb 1-2: new full-speed USB device number 2 using xhci_hcd
[    4.383457] device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is
disabled. Duplicate IMA measurements will not be recorded in the IMA log.
[    4.383498] sd 0:0:0:0: [sda] Preferred minimum I/O size 512 bytes
[    4.384732]  sda: sda1 sda2 sda3 sda4 sda5 sda6
[    4.385142] sd 0:0:0:0: [sda] Attached SCSI disk
[    4.389921] BUG: kernel NULL pointer dereference, address:
0000000000000010
[    4.402051] device-mapper: uevent: version 1.0.3
[    4.390912] #PF: supervisor read access in kernel mode
[    4.390912] #PF: error_code(0x0000) - not-present page
[    4.412827] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01)
initialised: dm-devel@redhat.com
[    4.390912] PGD 0 P4D 0
[    4.390912] Oops: 0000 [#1] PREEMPT SMP NOPTI
[    4.424434] intel_pstate: HWP enabled by BIOS
[    4.390912] CPU: 6 PID: 109 Comm: kworker/6:1 Not tainted 6.7.4-rc1_MY =
#1
[    4.434147] intel_pstate: Intel P-state driver initializing
[    4.390912] Hardware name: ASUS System Product Name/ROG STRIX B560-G
GAMING WIFI, BIOS 2001 09/21/2023

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D


[    4.390912] Workqueue: usb_hub_wq hub_event
[    4.390912] RIP: 0010:xhci_urb_enqueue+0x265/0x4e0
[    4.390912] Code: 30 e8 5f 08 d8 ff bd 94 ff ff ff eb 96 0f 1f 44 00
00 bd ed ff ff ff eb 8a 49 8b 84 24 c8 03 00 00 8b 54 24 10 48 8b 7c 24
08 <48> 8b 70 10 e8 d2 12 00 00 49 8b 57 40 0f b7 40 06 0f b7 6a 5c 89
[    4.390912] RSP: 0000:ffffa5a980533af0 EFLAGS: 00010246
[    4.390912] RAX: 0000000000000000 RBX: ffffa05540e33000 RCX:
0000000000000001
[    4.390912] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffa05540e33260
[    4.390912] RBP: 0000000000000001 R08: ffffa5a980533aa0 R09:
0000000000000000
[    4.390912] R10: ffffa05543bd5c80 R11: ffffa0554241f858 R12:
ffffa05540e33000
[    4.390912] R13: ffffa05543bd5c80 R14: 0000000000000c00 R15:
ffffa05541d233c0
[    4.390912] FS:  0000000000000000(0000) GS:ffffa0588f580000(0000)
knlGS:0000000000000000
[    4.390912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.390912] CR2: 0000000000000010 CR3: 000000021c430001 CR4:
0000000000770ef0
[    4.390912] PKRU: 55555554
[    4.390912] Call Trace:
[    4.390912]  <TASK>
[    4.390912]  ? __die+0x1a/0x60
[    4.390912]  ? page_fault_oops+0x170/0x4c0
[    4.390912]  ? wait_for_lsr+0x41/0x70
[    4.390912]  ? exc_page_fault+0x5c/0x80
[    4.390912]  ? asm_exc_page_fault+0x22/0x30
[    4.390912]  ? xhci_urb_enqueue+0x265/0x4e0
[    4.390912]  usb_hcd_submit_urb+0xba/0xbb0
[    4.390912]  usb_start_wait_urb+0x85/0x180
[    4.390912]  usb_control_msg+0xda/0x140
[    4.390912]  get_bMaxPacketSize0+0x5a/0xb0
[    4.390912]  hub_port_init+0x1ff/0xec0
[    4.390912]  hub_event+0x11a7/0x1b90
[    4.390912]  ? add_timer_on+0xd7/0x150
[    4.390912]  process_one_work+0x16a/0x290
[    4.390912]  worker_thread+0x303/0x450
[    4.390912]  ? __pfx_worker_thread+0x10/0x10
[    4.390912]  kthread+0xdc/0x110
[    4.390912]  ? __pfx_kthread+0x10/0x10
[    4.390912]  ret_from_fork+0x28/0x40
[    4.390912]  ? __pfx_kthread+0x10/0x10
[    4.390912]  ret_from_fork_asm+0x1b/0x30
[    4.390912]  </TASK>
[    4.390912] Modules linked in:
[    4.390912] CR2: 0000000000000010
[    4.390912] ---[ end trace 0000000000000000 ]---
[    4.390912] RIP: 0010:xhci_urb_enqueue+0x265/0x4e0
[    4.390912] Code: 30 e8 5f 08 d8 ff bd 94 ff ff ff eb 96 0f 1f 44 00
00 bd ed ff ff ff eb 8a 49 8b 84 24 c8 03 00 00 8b 54 24 10 48 8b 7c 24
08 <48> 8b 70 10 e8 d2 12 00 00 49 8b 57 40 0f b7 40 06 0f b7 6a 5c 89
[    4.390912] RSP: 0000:ffffa5a980533af0 EFLAGS: 00010246
[    4.390912] RAX: 0000000000000000 RBX: ffffa05540e33000 RCX:
0000000000000001
[    4.390912] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffffa05540e33260
[    4.390912] RBP: 0000000000000001 R08: ffffa5a980533aa0 R09:
0000000000000000
[    4.390912] R10: ffffa05543bd5c80 R11: ffffa0554241f858 R12:
ffffa05540e33000
[    4.390912] R13: ffffa05543bd5c80 R14: 0000000000000c00 R15:
ffffa05541d233c0
[    4.390912] FS:  0000000000000000(0000) GS:ffffa0588f580000(0000)
knlGS:0000000000000000
[    4.390912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.390912] CR2: 0000000000000010 CR3: 000000021c430001 CR4:
0000000000770ef0
[    4.390912] PKRU: 55555554


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


[    4.390912] note: kworker/6:1[109] exited with irqs disabled
[    4.765954] intel_pstate: HWP enabled
[    4.769835] hid: raw HID events driver (C) Jiri Kosina
[    4.775035] usbcore: registered new interface driver usbhid
[    4.780639] usbhid: USB HID core driver
[    4.784574] usbcore: registered new interface driver snd-usb-audio
[    4.798326] Initializing XFRM netlink socket
[    4.802664] NET: Registered PF_INET6 protocol family
[    4.809979] Segment Routing with IPv6
[    4.813690] RPL Segment Routing with IPv6
[    4.817723] In-situ OAM (IOAM) with IPv6
[    4.821703] mip6: Mobile IPv6
[    4.824743] NET: Registered PF_PACKET protocol family
[    4.829821] NET: Registered PF_KEY protocol family
[    4.836554] NET: Registered PF_RXRPC protocol family
[    4.841563] Key type rxrpc registered
[    4.845231] Key type rxrpc_s registered
[    4.849126] NET: Registered PF_KCM protocol family
[    4.854011] sctp: Hash tables configured (bind 256/256)
[    4.859307] Key type dns_resolver registered
[    4.864708] microcode: Current revision: 0x0000005d
[    4.869634] microcode: Updated early from: 0x00000059
[    4.875308] IPI shorthand broadcast: enabled
[    4.879664] AVX2 version of gcm_enc/dec engaged.
[    4.884946] AES CTR mode by8 optimization enabled
[    4.890767] sched_clock: Marking stable (3137000654,
1753591549)->(6250604981, -1360012778)
[    4.899335] registered taskstats version 1
[    4.903516] Loading compiled-in X.509 certificates
[    4.913926] Loaded X.509 cert 'Build time autogenerated kernel key:
f099905065c2ed911eae766e38306efef7dd8b1e'
[    4.925435] page_owner is disabled
[    4.928900] Key type .fscrypt registered
[    4.932862] Key type fscrypt-provisioning registered
[    4.938118] Btrfs loaded, zoned=3Dyes, fsverity=3Dyes
[    4.942876] Key type big_key registered
[    4.946732] Key type trusted registered
[    4.959769] Key type encrypted registered
[    4.964201] integrity: Loading X.509 certificate: UEFI:db
[    4.974365] integrity: Loaded X.509 cert 'ASUSTeK MotherBoard SW Key
Certificate: da83b990422ebc8c441f8d8b039a65a2'
[    4.984842] integrity: Loading X.509 certificate: UEFI:db
[    4.990352] integrity: Loaded X.509 cert 'ASUSTeK Notebook SW Key
Certificate: b8e581e4df77a5bb4282d5ccfc00c071'
[    5.000559] integrity: Loading X.509 certificate: UEFI:db
[    5.005978] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI
CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    5.016775] integrity: Loading X.509 certificate: UEFI:db
[    5.022188] integrity: Loaded X.509 cert 'Microsoft Windows
Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    5.033252] integrity: Loading X.509 certificate: UEFI:db
[    5.038771] integrity: Loaded X.509 cert 'Canonical Ltd. Master
Certificate Authority: ad91990bc22ab1f517048c23b6655a268e345a63'
[    5.051129] Loading compiled-in module X.509 certificates
[    5.056935] Loaded X.509 cert 'Build time autogenerated kernel key:
f099905065c2ed911eae766e38306efef7dd8b1e'
[    5.066891] ima: Allocated hash algorithm: sha256
[    5.108917] ima: No architecture policies found
[    5.113487] evm: Initialising EVM extended attributes:
[    5.118665] evm: security.selinux
[    5.121989] evm: security.SMACK64 (disabled)
[    5.126269] evm: security.SMACK64EXEC (disabled)
[    5.130898] evm: security.SMACK64TRANSMUTE (disabled)
[    5.135957] evm: security.SMACK64MMAP (disabled)
[    5.140585] evm: security.apparmor (disabled)
[    5.144951] evm: security.ima
[    5.147926] evm: security.capability
[    5.151514] evm: HMAC attrs: 0x1
[    5.237399] alg: No test for fips(ansi_cprng) (fips_ansi_cprng)
[    5.307376] Running certificate verification selftests
[    5.312897] Loaded X.509 cert 'Certificate verification self-testing
key: f58703bb33ce1b73ee02eccdee5b8817518fe3db'
[    5.323772] PM:   Magic number: 12:962:35
[    5.327866] misc cuse: hash matches
[    5.331505] RAS: Correctable Errors collector initialized.
[    5.337064] clk: Disabling unused clocks
[    5.341019] ALSA device list:
[    5.344041]   No soundcards found.
[    5.348096] Freeing unused kernel image (initmem) memory: 2908K
[    5.354051] Write protecting the kernel read-only data: 36864k
[    5.360442] Freeing unused kernel image (rodata/data gap) memory: 1704K
[    5.372314] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    5.378791] rodata_test: all tests were successful
[    5.383589] Run /init as init process
[    5.387258]   with arguments:
[    5.390236]     /init
[    5.392519]   with environment:
[    5.395669]     HOME=3D/
[    5.398042]     TERM=3Dlinux
[    5.400758]     BOOT_IMAGE=3D(hd1,gpt1)/vmlinuz-6.7.4-rc1_MY
[    5.408062] systemd[1]: Setting '/proc/sys/kernel/printk_devkmsg' to 'o=
n'
[    5.414913] systemd[1]: Smack is not enabled in the kernel.
[    5.420531] systemd[1]: No IMA custom policy file
/etc/ima/ima-policy, ignoring: No such file or directory
[    5.430206] systemd[1]: SELinux enabled state cached to: disabled
[    5.436469] systemd[1]: No virtualization found in DMI vendor table.
[    5.442877] systemd[1]: DMI BIOS Extension table does not indicate
virtualization.
[    5.450506] systemd[1]: UML virtualization not found in /proc/cpuinfo.
[    5.457081] systemd[1]: Virtualization XEN not found, /proc/xen does
not exist
[    5.464350] systemd[1]: No virtualization found in CPUID
[    5.469681] systemd[1]: This platform does not support /proc/device-tre=
e
[    5.476389] systemd[1]: This platform does not support /proc/sysinfo
[    5.482754] systemd[1]: Found VM virtualization none
[    5.487767] systemd[1]: Mounting tmpfs to /dev/shm of type tmpfs with
options mode=3D01777.
[    5.495983] systemd[1]: Mounting tmpfs (tmpfs) on /dev/shm
(MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=3D01777")...
[    5.506010] systemd[1]: Mounting devpts to /dev/pts of type devpts
with options mode=3D0620,gid=3D5.
[    5.514832] systemd[1]: Mounting devpts (devpts) on /dev/pts
(MS_NOSUID|MS_NOEXEC "mode=3D0620,gid=3D5")...
[    5.524251] systemd[1]: Mounting tmpfs to /run of type tmpfs with
options mode=3D0755,size=3D20%,nr_inodes=3D800k.
[    5.534111] systemd[1]: Mounting tmpfs (tmpfs) on /run
(MS_NOSUID|MS_NODEV|MS_STRICTATIME "mode=3D0755,size=3D20%,nr_inodes=3D800=
k")...
[    5.545781] systemd[1]: No filesystem is currently mounted on
/sys/fs/cgroup.
[    5.552981] systemd[1]: Mounting cgroup2 to /sys/fs/cgroup of type
cgroup2 with options nsdelegate,memory_recursiveprot.
[    5.563892] systemd[1]: Mounting cgroup2 (cgroup2) on /sys/fs/cgroup
(MS_NOSUID|MS_NODEV|MS_NOEXEC "nsdelegate,memory_recursiveprot")...
[    5.576179] systemd[1]: Found cgroup2 on /sys/fs/cgroup/, full
unified hierarchy
[    5.583586] systemd[1]: Found cgroup2 on /sys/fs/cgroup/, full
unified hierarchy
[    5.591000] systemd[1]: Mounting pstore to /sys/fs/pstore of type
pstore with options n/a.
[    5.599280] systemd[1]: Mounting pstore (pstore) on /sys/fs/pstore
(MS_NOSUID|MS_NODEV|MS_NOEXEC "")...
[    5.608705] systemd[1]: Mounting efivarfs to
/sys/firmware/efi/efivars of type efivarfs with options n/a.
[    5.618308] systemd[1]: Mounting efivarfs (efivarfs) on
/sys/firmware/efi/efivars (MS_NOSUID|MS_NODEV|MS_NOEXEC "")...
[    5.644765] systemd[1]: Mounting bpf to /sys/fs/bpf of type bpf with
options mode=3D0700.
[    5.652804] systemd[1]: Mounting bpf (bpf) on /sys/fs/bpf
(MS_NOSUID|MS_NODEV|MS_NOEXEC "mode=3D0700")...
[    5.663033] systemd[1]: Reading EFI variable
/sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c.
[    5.674200] systemd[1]: Reading EFI variable
/sys/firmware/efi/efivars/SystemdOptions-8cf2644b-4b0b-428f-9387-6d876050d=
c67.
[    5.685340] systemd[1]:
open("/sys/firmware/efi/efivars/SystemdOptions-8cf2644b-4b0b-428f-9387-6d8=
76050dc67")
failed: No such file or directory
[    5.698408] systemd[1]: systemd 254.8-2.fc39 running in system mode
(+PAM +AUDIT +SELINUX -APPARMOR +IMA +SMACK +SECCOMP -GCRYPT +GNUTLS
+OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN -IPTC +KMOD
+LIBCRYPTSETUP +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2
+BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP +SYSVINIT
default-hierarchy=3Dunified)
[    5.730751] systemd[1]: CPUID func 1 0
[    5.734522] systemd[1]: CPUID result a0671 8100800 7ffafbbf bfebfbff
[    5.740884] systemd[1]: CPUID is hypervisor: no
[    5.745424] systemd[1]: Detected architecture x86-64.
[    5.750484] systemd[1]: Running in initrd.
[    5.754590] systemd[1]: Kernel version 6.7.4-rc1_MY, our baseline is 4.=
15
[    5.761401] systemd[1]: No credentials passed via /.extra/credentials/.
[    5.768027] systemd[1]: No credentials passed via
/.extra/global_credentials/.
[    5.775257] systemd[1]: No credentials passed via fw_cfg.
[    5.780688] systemd[1]: Ignoring OEM string: Default string
[    5.786272] systemd[1]: Ignoring OEM string: Default string
[    5.791855] systemd[1]: Ignoring OEM string: FREESIAV
[    5.796916] systemd[1]: Ignoring OEM string: Default string
[    5.802494] systemd[1]: Ignoring OEM string: Default string
[    5.808078] systemd[1]: Ignoring OEM string: Default string
[    5.813659] systemd[1]: Failed to open
'/sys/firmware/dmi/entries/11-1/raw', ignoring: No such file or directory
[    5.823857] systemd[1]: Acquired 0 regular credentials, 0 untrusted
credentials.

Welcome to Fedora Linux 39 (Workstation Edition) dracut-059-16.fc39
(Initramfs)!

[    5.843803] systemd[1]: Hostname set to <obelix.fritz.box>.
[    5.849552] systemd[1]: Successfully added address 127.0.0.1 to
loopback interface
[    5.857159] systemd[1]: Successfully added address ::1 to loopback
interface
[    5.864252] systemd[1]: Successfully brought loopback interface up
[    5.870485] systemd[1]: Setting '/proc/sys/net/unix/max_dgram_qlen'
to '512'
[    5.877585] systemd[1]: Setting '/proc/sys/fs/file-max' to
'9223372036854775807'
[    5.885005] systemd[1]: Setting '/proc/sys/fs/nr_open' to '2147483640'
[    5.891582] systemd[1]: Couldn't write fs.nr_open as 2147483640,
halving it.
[    5.898653] systemd[1]: Setting '/proc/sys/fs/nr_open' to '1073741816'
[    5.905196] systemd[1]: Successfully bumped fs.nr_open to 1073741816
[    5.911749] systemd[1]: Found cgroup2 on /sys/fs/cgroup/, full
unified hierarchy
[    5.919189] systemd[1]: Unified cgroup hierarchy is located at
/sys/fs/cgroup.
[    5.932899] systemd[1]: bpf-firewall: Got EBADF when using
BPF_F_ALLOW_MULTI, which indicates it is supported. Yay!
[    5.959177] systemd[1]: libbpf: prog 'sd_bind4': failed to attach to
cgroup: Bad file descriptor
[    5.968151] systemd[1]: libbpf: prog 'sd_restrictif_i': failed to
attach to cgroup: Bad file descriptor
[    5.977591] systemd[1]: Controller 'cpu' supported: yes
[    5.982835] systemd[1]: Controller 'cpuacct' supported: no
[    5.988327] systemd[1]: Controller 'cpuset' supported: yes
[    5.993825] systemd[1]: Controller 'io' supported: yes
[    5.998970] systemd[1]: Controller 'blkio' supported: no
[    6.004293] systemd[1]: Controller 'memory' supported: yes
[    6.009787] systemd[1]: Controller 'devices' supported: no
[    6.015280] systemd[1]: Controller 'pids' supported: yes
[    6.020603] systemd[1]: Controller 'bpf-firewall' supported: yes
[    6.026622] systemd[1]: Controller 'bpf-devices' supported: yes
[    6.032557] systemd[1]: Controller 'bpf-foreign' supported: yes
[    6.038486] systemd[1]: Controller 'bpf-socket-bind' supported: yes
[    6.044762] systemd[1]: Controller 'bpf-restrict-network-interfaces'
supported: yes
[    6.052434] systemd[1]: Set up TFD_TIMER_CANCEL_ON_SET timerfd.
[    6.058373] systemd[1]: Failed to stat /etc/localtime, ignoring: No
such file or directory
[    6.066647] systemd[1]: /etc/localtime doesn't exist yet, watching
/etc instead.
[    6.074226] systemd[1]: bpf-lsm: BPF LSM hook not enabled in the
kernel, BPF LSM not supported
[    6.082944] systemd[1]: Enabling (yes) showing of status (commandline).
[    6.089800] systemd[1]: Successfully forked off '(sd-executor)' as
PID 494.
[    6.089953] (sd-e[494]: About to execute
/usr/lib/systemd/system-generators/dracut-rootfs-generator (null)
[    6.106594] (sd-e[494]: Successfully forked off '(direxec)' as PID 495.
[    6.113259] (sd-e[494]: About to execute
/usr/lib/systemd/system-generators/systemd-debug-generator (null)
[    6.123029] (sd-e[494]: Successfully forked off '(direxec)' as PID 527.
[    6.129724] (sd-e[494]: About to execute
/usr/lib/systemd/system-generators/systemd-fstab-generator (null)
[    6.139494] (sd-e[494]: Successfully forked off '(direxec)' as PID 528.
[    6.141058] systemd-fstab-generator[528]: Found entry
what=3D/dev/disk/by-uuid/704d7d4e-6ca3-4647-b027-44dc162e2b3c
where=3D/sysroot type=3Dn/a opts=3Dsubvol=3DROOT,ro
[    6.146146] (sd-e[494]: About to execute
/usr/lib/systemd/system-generators/systemd-gpt-auto-generator (null)
[    6.160265] systemd-fstab-generator[528]: Creating
/run/systemd/generator/systemd-fsck-root.service
[    6.170244] (sd-e[494]: Successfully forked off '(direxec)' as PID 529.
[    6.171747] systemd-gpt-auto-generator[529]: Disabling root partition
auto-detection, root=3D is defined.
[    6.179270] systemd-fstab-generator[528]: SELinux enabled state
cached to: disabled
[    6.185839] (sd-e[494]:
/usr/lib/systemd/system-generators/systemd-gpt-auto-generator succeeded.
[    6.195253] systemd-fstab-generator[528]: Parsing /etc/fstab...
[    6.202899] (sd-e[494]:
/usr/lib/systemd/system-generators/systemd-debug-generator succeeded.
[    6.211691] systemd-fstab-generator[528]: Parsing /sysroot/etc/fstab...
[    6.217637] (sd-e[494]:
/usr/lib/systemd/system-generators/dracut-rootfs-generator succeeded.
[    6.241336] (sd-e[494]:
/usr/lib/systemd/system-generators/systemd-fstab-generator succeeded.
[    6.249999] systemd[1]: (sd-executor) succeeded.
[    6.254694] systemd[1]: Looking for unit files in (higher priority
first):
[    6.261603] systemd[1]: 	/etc/systemd/system.control
[    6.266574] systemd[1]: 	/run/systemd/system.control
[    6.271549] systemd[1]: 	/run/systemd/transient
[    6.276090] systemd[1]: 	/run/systemd/generator.early
[    6.281149] systemd[1]: 	/etc/systemd/system
[    6.285430] systemd[1]: 	/etc/systemd/system.attached
[    6.290491] systemd[1]: 	/run/systemd/system
[    6.294771] systemd[1]: 	/run/systemd/system.attached
[    6.299829] systemd[1]: 	/run/systemd/generator
[    6.304370] systemd[1]: 	/usr/local/lib/systemd/system
[    6.309517] systemd[1]: 	/usr/lib/systemd/system
[    6.314144] systemd[1]: 	/run/systemd/generator.late
[    6.319315] systemd[1]: sd-device-enumerator: Failed to open
directory /run/udev/tags/systemd, ignoring: No such file or directory
[    6.331577] systemd[1]: Modification times have changed, need to
update cache.
[    6.338950] systemd[1]: unit_file_build_name_map: normal unit file:
/run/systemd/generator/sysroot.mount
[    6.348467] systemd[1]: unit_file_build_name_map: normal unit file:
/run/systemd/generator/systemd-fsck-root.service
[    6.359035] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/umount.target
[    6.368640] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/timers.target
[    6.378240] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-volatile-root.service
[    6.389204] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-vconsole-setup.service
[    6.400282] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-udevd.service
[    6.410552] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-udevd-kernel.socket
[    6.421352] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-udevd-control.socket
[    6.432234] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-udev-trigger.service
[    6.443113] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-udev-settle.service
[    6.453910] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-tmpfiles-setup.service
[    6.464979] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-tmpfiles-setup-dev.service
[    6.476387] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-sysusers.service
[    6.486924] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-sysctl.service
[    6.497314] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-reboot.service
[    6.507691] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-random-seed.service
[    6.518489] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-poweroff.service
[    6.529017] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-modules-load.service
[    6.539895] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-kexec.service
[    6.550166] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-journald.socket
[    6.560616] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-journald.service
[    6.571171] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-journald-dev-log.socket
[    6.582311] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-journald-audit.socket
[    6.593279] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-halt.service
[    6.603461] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-fsck@.service
[    6.613730] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-ask-password-plymouth.service
[    6.625388] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-ask-password-plymouth.path
[    6.636787] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-ask-password-console.service
[    6.648396] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/systemd-ask-password-console.path
[    6.659744] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/syslog.socket
[    6.669319] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/sysinit.target
[    6.678978] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/sys-kernel-config.mount
[    6.689422] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/swap.target
[    6.698824] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/sockets.target
[    6.708483] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/slices.target
[    6.718060] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/sigpwr.target
[    6.727634] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/shutdown.target
[    6.737382] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/rpcbind.target
[    6.747044] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/rescue.target
[    6.756619] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/rescue.service
[    6.766278] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/emergency.service
[    6.776200] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/remote-fs.target
[    6.786035] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/remote-fs-pre.target
[    6.796216] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/remote-cryptsetup.target
[    6.806748] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/reboot.target
[    6.816321] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/poweroff.target
[    6.826075] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-switch-root.service
[    6.836963] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-start.service
[    6.847319] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-reboot.service
[    6.857763] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-quit.service
[    6.868034] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-quit-wait.service
[    6.878736] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-poweroff.service
[    6.889350] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-kexec.service
[    6.899707] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/plymouth-halt.service
[    6.909977] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/paths.target
[    6.919464] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/nss-user-lookup.target
[    6.929822] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/nss-lookup.target
[    6.939742] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/nm-wait-online-initrd.service
[    6.950708] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/nm-initrd.service
[    6.960629] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/network.target
[    6.970293] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/network-pre.target
[    6.980300] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/network-online.target
[    6.990573] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/multi-user.target
[    7.000502] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/modprobe@.service
[    7.010425] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/memstrack.service
[    7.020346] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/local-fs.target
[    7.030095] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/local-fs-pre.target
[    7.040190] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/kmod-static-nodes.service
[    7.050844] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/kexec.target
[    7.060357] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd.target
[    7.069932] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-usr-fs.target
[    7.080115] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-udevadm-cleanup-db.service
[    7.091425] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-switch-root.target
[    7.102039] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-switch-root.service
[    7.112745] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-root-fs.target
[    7.123010] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-root-device.target
[    7.133630] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-parse-etc.service
[    7.144159] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-fs.target
[    7.153992] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/initrd-cleanup.service
[    7.164351] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/halt.target
[    7.173752] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/final.target
[    7.183236] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/emergency.target
[    7.193072] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-pre-udev.service
[    7.203514] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-pre-trigger.service
[    7.214219] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-pre-pivot.service
[    7.224749] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-pre-mount.service
[    7.235277] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-mount.service
[    7.245461] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-initqueue.service
[    7.255988] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-emergency.service
[    7.266518] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-cmdline.service
[    7.276875] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dracut-cmdline-ask.service
[    7.287577] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/debug-shell.service
[    7.297672] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dbus.socket
[    7.307071] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/dbus-broker.service
[    7.317194] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/cryptsetup.target
[    7.327141] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/cryptsetup-pre.target
[    7.337408] systemd[1]: unit_file_build_name_map: normal unit file:
/usr/lib/systemd/system/basic.target
[    7.347172] systemd[1]: Using notification socket /run/systemd/notify
[    7.353671] systemd[1]: Successfully created private D-Bus server.
[    7.359921] systemd[1]: Too many messages being logged to kmsg, ignorin=
g
          Expecting device
dev-disk-by\x2duu=E2=80=A67d4e-6ca3-4647-b027-44dc162e2b3c...
[  OK  ] Reached target initrd-usr-fs.target - Initrd /usr File System.
[  OK  ] Reached target slices.target - Slice Units.
[  OK  ] Reached target swap.target - Swaps.
[  OK  ] Reached target timers.target - Timer Units.
[  OK  ] Listening on dbus.socket - D-Bus System Message Bus Socket.
[  OK  ] Listening on systemd-journald-dev-=E2=80=A6socket - Journal Socke=
t
(/dev/log).
[  OK  ] Listening on systemd-journald.socket - Journal Socket.
[  OK  ] Listening on systemd-udevd-control.socket - udev Control Socket.
[  OK  ] Listening on systemd-udevd-kernel.socket - udev Kernel Socket.
[  OK  ] Reached target sockets.target - Socket Units.
          Starting systemd-journald.service - Journal Service...
          Startin[    7.529412] systemd-journald[531]: SELinux enabled
state cached to: disabled
g syste[    7.537723] systemd-journald[531]: Collecting audit messages
is disabled.
[    7.537983] systemd-journald[531]: Fixed min_use=3D16.0M max_use=3D314.=
4M
max_size=3D39.3M min_size=3D512.0K keep_free=3D157.2M n_max_files=3D100
[    7.557943] systemd-journald[531]: Reserving 333 entries in field
hash table.
[    7.558535] systemd-journald[531]: Reserving 71566 entries in data
hash table.
md-modules-load.[    7.572612] systemd-journald[531]: Journal effective
settings seal=3Dno keyed_hash=3Dyes compress=3DZSTD compress_threshold_byt=
es=3D512B
[    7.585472] systemd-journald[531]: Vacuuming...
[    7.590025] systemd-journald[531]: Vacuuming done, freed 0B of
archived journals from /run/log/journal/c5778219590742c492f933cf1be153ca.
[    7.602302] systemd-journald[531]: Flushing /dev/kmsg...
service - Load Kernel Modules...
          Starting systemd-sysusers.service - Create[    7.618918]
systemd-journald[531]: systemd-journald running as PID 531 for the system.
  System Users...
[    7.628944] systemd-journald[531]: Sent READY=3D1 notification.
          Startin[    7.635087] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g syste[    7.645360] systemd-journald[531]: Successfully sent stream
file descriptor to service manager.
[    7.655396] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
md-vconsole-setup.service - Virtual Console Setup...
[  OK  ] Started systemd-journald.service - Journal Service.
[  OK  ] Finished systemd-modules-load.service - Load Kernel Modules.
[  OK  ] Finished systemd-vconsole-setup.service - Virtual Console Setup.
          Starting dracut-cmdline-ask.se[    7.722194]
systemd-journald[531]: Successfully sent stream file descriptor to
service manager.
rvic=E2=80=A6or additional cmdline[    7.734377] systemd-journald[531]:
Successfully sent stream file descriptor to service manager.
          Starting systemd-tmpfiles-setup.se=E2=80=A6e Volatile Files and
Directories...
[  OK      7.754968] systemd-journald[531]: Successfully sent stream
file descriptor to service manager.
0m] Finished dracut-cmdline-ask.servic=E2=80=A6 for additional cmdline par=
ameters.
[  OK  ] Finished systemd-sysctl.service - Apply Kernel Variables.
[  OK  ] Finished systemd-tmpfiles-setup-de=E2=80=A6Create Static Device N=
odes
in /dev.
[  OK  ] Finished systemd-tmpfiles-setup.se=E2=80=A6ate Volatile Files and
Directories.
[  OK  ] Reached target local-fs-pre.target=E2=80=A6Preparation for Local =
File
Systems.
[  OK  ] Reached target local-fs.target - Local File Systems.
          Startin[    7.841886] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g dracu[    7.852123] systemd-journald[531]: Successfully sent stream
file descriptor to service manager.
t-cmdline.service - dracut cmdline hook...
[  OK  ] Finished dracut-cmdline.service - dracut cmdline hook.
          Startin[    7.892379] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g dracu[    7.902693] systemd-journald[531]: Successfully sent stream
file descriptor to service manager.
t-pre-udev.service - dracut pre-udev hook...
[  OK  ] Finished dracut-pre-udev.service - dracut pre-udev hook.
[    7.949474] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
          Starting systemd-udevd.service - R=E2=80=A6ager for Device Event=
s and
Files...
[  OK  ] Started systemd-udevd.service - Ru=E2=80=A6anager for Device Even=
ts and
Files.
          Startin[    7.994795] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g systemd-udev-trigger.service - Coldplug All udev Devices...
[  OK  ] Created slice system-modprobe.slice - Slice /system/modprobe.
[    8.071032] igc 0000:03:00.0 enp3s0: renamed from eth0
[    8.079710] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
          Starting modprobe@configfs.service - Load Kernel Module
configfs...
[  OK  ] Finished modprobe@configfs.service - Load Kernel Module configfs.
[  OK  ] Finished systemd-udev-trigger.service - Coldplug All udev Devices=
.
[  OK  ] Found device dev-disk-by\x2duuid-7=E2=80=A6Samsung SSD 980 PRO 1T=
B
BTRFS_Pool.
[    8.166034] ACPI: bus type drm_connector registered
[    8.169622] systemd-journald[531]: Compressed data object 872 -> 300
using ZSTD
[    8.178356] systemd-journald[531]: Compressed data object 880 -> 313
using ZSTD
[    8.185800] Linux agpgart interface v0.103
[  OK  ] Reached target initrd-root-device.target - Initrd Root Device.
[    8.231856] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
          Mounting sys-kernel-config.mount - Kernel Configuration File
System...
[  OK  ] Reached target network.target - Network.
          Startin[    8.259497] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
[    8.269654] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
g dracut-initqueue.service - dracut initqueue hook...
[  OK  ] Stopped systemd-vconsole-setup.service - Virtual Console Setup.
          Stopping systemd-vconsole-setup.service - Virtual Console Setup.=
.
          Startin[    8.308347] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g systemd-vconsole-setup.service - Virtual Console Setup...
[  OK  ] Mounted sys-kernel-config.mount - Kernel Configuration File Syste=
m.
[  OK  ] Finished dracut-initqueue.service - dracut initqueue hook.
[  OK  ] Reached target remote-fs-pre.targe=E2=80=A6reparation for Remote =
File
Systems.
[  OK  ] Reached target remote-fs.target - Remote File Systems.
          Startin[    8.371446] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g systemd-fsck-root.service=E2=80=A67d4e-6ca3-4647-b027-44dc162e2b3c...
[  OK  ] Finished
systemd-fsck-root.service=E2=80=A64d7d4e-6ca3-4647-b027-44dc162e2b3c.
          Mounting sysroot.mount - /sysroot...
[    8.422948] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
[    8.425314] BTRFS: device label BTRFS_Pool devid 1 transid 156690
/dev/nvme0n1p3 scanned by mount (703)
[    8.441385] BTRFS info (device nvme0n1p3): first mount of filesystem
704d7d4e-6ca3-4647-b027-44dc162e2b3c
[    8.451013] BTRFS info (device nvme0n1p3): using crc32c
(crc32c-intel) checksum algorithm
[    8.451017] BTRFS info (device nvme0n1p3): using free space tree
[    8.456205] BTRFS info (device nvme0n1p3): enabling ssd optimizations
[    8.471737] BTRFS info (device nvme0n1p3): auto enabling async discard
[  OK  ] Mounted sysroot.mount - /sysroo[    8.483635] i915
0000:00:02.0: vgaarb: deactivate vga console
t.
[    8.490552] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[  OK      8.497476] i915 0000:00:02.0: vgaarb: VGA decodes changed:
olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
0m] Reached targ[    8.509147] i915 0000:00:02.0: [drm] Finished loading
DMC firmware i915/rkl_dmc_ver2_03.bin (v2.3)
[    8.511423] i915 0000:00:02.0: [drm] Protected Xe Path (PXP)
protected content support initialized
et initrd-root-fs.target - Initrd Root File System.
          Startin[    8.543147] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g initr[    8.553873] [drm] Initialized i915 1.6.0 20230929 for
0000:00:02.0 on minor 0
d-parse-etc.serv[    8.562246] ACPI: video: Video Device [GFX0]
(multi-head: yes  rom: no  post: no)
ice =E2=80=A6ints [    8.570972] input: Video Bus as
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
Configured in th[    8.581429] i915 display info: display version: 12
[    8.587583] i915 display info: cursor_needs_physical: no
[    8.592910] i915 display info: has_cdclk_crawl: no
[    8.597728] i915 display info: has_cdclk_squash: no
[    8.602613] i915 display info: has_ddi: yes
[    8.606806] i915 display info: has_dp_mst: yes
[    8.611261] i915 display info: has_dsb: yes
[    8.615453] i915 display info: has_fpga_dbg: yes
e Real Root...
[    8.620079] i915 display info: has_gmch: no
[    8.620080] i915 display info: has_hotplug: yes
[    8.620080] i915 display info: has_hti: yes
[    8.620081] i915 display info: has_ipc: yes
[    8.620081] i915 display info: has_overlay: no
[    8.620081] i915 display info: has_psr: yes
[    8.620081] i915 display info: has_psr_hw_tracking: no
[    8.620082] i915 display info: overlay_needs_physical: no
[    8.620082] i915 display info: supports_tv: no
[    8.620082] i915 display info: has_hdcp: yes
[    8.620083] i915 display info: has_dmc: yes
[    8.620083] i915 display info: has_dsc: yes
[    8.620086] fbcon: i915drmfb (fb0) is primary device
[    8.683874] Console: switching to colour frame buffer device 240x67
[    8.769413] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[  OK  ] Finished systemd-vconsole-setup.service - Virtual Console Setup.
[    8.804838] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
[  OK  ] Reached target sysinit.target - System Initialization.
          Startin[    8.824361] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
g plymouth-start.service - Show Plymouth Boot Screen...
[    8.859856] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
[    8.869570] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
1;-1f[  OK  ] Stopped systemd-vconsole-setup.service - Virtual Console
Setup.
          Stopping systemd-vconsole-setup.service - Virtual Console Setup.=
.
          Startin[    8.886285] systemd-journald[531]: Successfully sent
stream file descriptor to service manager.
[    8.886313] systemd-journald[531]: Successfully sent stream file
descriptor to service manager.
g systemd-vconsole-setup.service - Virtual Console Setup...
[  OK  ] Finished initrd-parse-etc.service =E2=80=A6points Configured in t=
he
Real Root.
[  OK  ] Started plymouth-start.service - Show Plymouth Boot Screen.
[  OK  ] Started systemd-ask-password-plymo=E2=80=A6quests to Plymouth Dir=
ectory
Watch.
[  OK  ] Reached target initrd-fs.target - Initrd File Systems.
[  OK  ] Reached target paths.target - Path Units.
[  OK  ] Reached target basic.target - Basic System.
[  OK  ] Reached target initrd.target - Initrd Default Target.
          Starting dracut-pre-pivot.service =E2=80=A6racut pre-pivot and c=
leanup
hook...
[  OK  ] Finished systemd-vconsole-setup.service - Virtual Console Setup.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Tested-by: Ronald Warsow <rwarsow@gmx.de>


