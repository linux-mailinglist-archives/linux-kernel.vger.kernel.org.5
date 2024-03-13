Return-Path: <linux-kernel+bounces-101168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB6F87A358
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D931F22332
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D745A168CC;
	Wed, 13 Mar 2024 07:19:00 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291F15AD9;
	Wed, 13 Mar 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314340; cv=none; b=KLSdN+DOOnnPuAS8emkYs7wXM82y+ksI+aSAQB5DWGM9afyQ0DD65tFs6glUTa0TNQ5ViUFiKS5oxI/FeHZaMb0fQ4yQ5d5p/XR7V68TxEUC1wVLtq3ZoPXeubuUPxavMWnJqUMHZOUAmkwepRmWYNrUKycjj4qKtQYLWUWPDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314340; c=relaxed/simple;
	bh=SyHGz53d5S3pstaPL0dD+/ICzyNlgdE7M2KqnseDQ60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AmT0bnFieooV3xFLYXZzKdlYpCn3lB/xa9qat9MCB1GWdYME6CkWhXt9og+XDJPMH+OMA/zj8dsgEzSo4ymcpK0cbetaI4I2AwWXkRZwig8rCG9WqGnCQWBIfyfyTck22MQR4UDtoD0ls+aZY+bqWSwz/a5qMbFBqnrWnPa0hg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:9430:1955:e0f1:3204:86f1])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 766107E017A;
	Wed, 13 Mar 2024 15:18:22 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: quic_kathirav@quicinc.com
Cc: amadeus@jmu.edu.cn,
	andersson@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.baryshkov@linaro.org,
	konrad.dybcio@linaro.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: ipq6018: add 1.2GHz CPU Frequency
Date: Wed, 13 Mar 2024 15:18:03 +0800
Message-Id: <20240313071803.422343-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1a4e09da-b19b-4cf5-8fae-822c74cfe048@quicinc.com>
References: <1a4e09da-b19b-4cf5-8fae-822c74cfe048@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSR0YVktJTkNCTE0aHR9MHlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPSx5BSBlIQUkYS0tBQk9IS0FKQk5OQR5LHUpBSElLT0FDTR1KWVdZFhoPEhUdFF
	lBWU9LSFVKTEpPTENVSktLVUpCS0tZBg++
X-HM-Tid: 0a8e36ad2d1c03a2kunm766107e017a
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MFE6Hww6HTMPEioQLU0TKgoB
	TQEKFDFVSlVKTEpLSEpPSEtISk5JVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBQk9IS0FKQk5OQR5LHUpBSElLT0FDTR1KWVdZCAFZQUJKTkw3Bg++

> Could you share the OEM bootloader log on both these SoCs?

Chip silk screen: ipq6000, msm_id: ipq6000, bootloader log:

Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.XF.0.3-00086-IPQ60xxLZB-1
S - IMAGE_VARIANT_STRING=IPQ6018LA
S - OEM_IMAGE_VERSION_STRING=crm-ubuntu200
S - Boot Interface: NAND
S - Secure Boot: Off
S - Boot Config @ 0x000a602c = 0x000002e5
S - JTAG ID @ 0x000a607c = 0x001390e1
S - OEM ID @ 0x000a6080 = 0x00000000
S - Serial Number @ 0x000a4128 = 0xd553f610
S - OEM Config Row 0 @ 0x000a4188 = 0x0000000000000000
S - OEM Config Row 1 @ 0x000a4190 = 0x0000000000000000
S - Feature Config Row 0 @ 0x000a4130 = 0x0000800018200021
S - Feature Config Row 1 @ 0x000a4138 = 0x02c3e83783000009
S - PBL Patch Ver: 1
S - I-cache: On
S - D-cache: On
B -      3413 - PBL, Start
B -       592 - bootable_media_detect_entry, Start
B -      4339 - bootable_media_detect_success, Start
B -      5207 - elf_loader_entry, Start
B -      5380 - auth_hash_seg_entry, Start
B -      7846 - auth_hash_seg_exit, Start
B -      8341 - elf_segs_hash_verify_entry, Start
B -    103774 - elf_segs_hash_verify_exit, Start
B -    107970 - auth_xbl_sec_hash_seg_entry, Start
B -    108114 - auth_xbl_sec_hash_seg_exit, Start
B -    114659 - xbl_sec_segs_hash_verify_entry, Start
B -    114660 - xbl_sec_segs_hash_verify_exit, Start
B -    115589 - PBL, End
B -     97478 - SBL1, Start
B -    237259 - GCC [RstStat:0x0, RstDbg:0x600000] WDog Stat : 0x4
B -    239699 - clock_init, Start
D -      2836 - clock_init, Delta
B -    248270 - boot_flash_init, Start
D -     26962 - boot_flash_init, Delta
B -    278404 - sbl1_ddr_set_default_params, Start
D -       244 - sbl1_ddr_set_default_params, Delta
B -    285022 - boot_config_data_table_init, Start
D -      4788 - boot_config_data_table_init, Delta - (575 Bytes)
B -    294904 - CDT Version:2,Platform ID:8,Major ID:3,Minor ID:2,Subtype:0
B -    299693 - Image Load, Start
D -      6618 - OEM_MISC Image Loaded, Delta - (0 Bytes)
B -    309056 - Image Load, Start
D -      5063 - PMIC Image Loaded, Delta - (0 Bytes)
B -    316925 - sbl1_ddr_set_params, Start
B -    321897 - CPR configuration: 0x555
B -    325099 - Pre_DDR_clock_init, Start
D -       213 - Pre_DDR_clock_init, Delta
D -         0 - sbl1_ddr_set_params, Delta
B -    357856 - Image Load, Start
D -       427 - APDP Image Loaded, Delta - (0 Bytes)
B -    375851 - Image Load, Start
D -       427 - QTI_MISC Image Loaded, Delta - (0 Bytes)
B -    378261 - Image Load, Start
D -       793 - Auth Metadata
D -       641 - Segments hash check
D -     22509 - QSEE Dev Config Image Loaded, Delta - (36362 Bytes)
B -    402722 - Image Load, Start
D -      6863 - Auth Metadata
D -     10309 - Segments hash check
D -    331504 - QSEE Image Loaded, Delta - (1419184 Bytes)
B -    734684 - Image Load, Start
D -       671 - Auth Metadata
D -       945 - Segments hash check
D -     34709 - RPM Image Loaded, Delta - (102800 Bytes)
B -    771070 - Image Load, Start
D -       762 - Auth Metadata
D -      3203 - Segments hash check
D -    124440 - APPSBL Image Loaded, Delta - (563588 Bytes)
B -    911126 - SBL1, End
D -    813953 - SBL1, Delta
S - Flash Throughput, 4000 KB/s  (2122509 Bytes,  432999 us)
S - Core 0 Frequency, 800 MHz
S - DDR Frequency, 466 MHz


U-Boot 2016.01 (Dec 01 2021 - 20:16:45 +0800)

DRAM:  smem ram ptable found: ver: 2 len: 4
512 MiB
NAND:  ONFI device found
ID = 1580a1f8
Vendor = f8
Device = a1
SF: Unsupported flash IDs: manuf 00, jedec 0000, ext_jedec 0000
ipq_spi: SPI Flash not found (bus/cs/speed/mode) = (0/0/48000000/0)
128 MiB
MMC:   <NULL>: 0
PCI0 is not defined in the device tree
In:    serial@78B1000
Out:   serial@78B1000
Err:   serial@78B1000
machid: 8030200


Chip silk screen: ipq6000, msm_id: ipq6018, bootloader log:

Format: Log Type - Time(microsec) - Message - Optional Info
Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
S - QC_IMAGE_VERSION_STRING=BOOT.XF.0.3-00077-IPQ60xxLZB-2
S - IMAGE_VARIANT_STRING=IPQ6018LA
S - OEM_IMAGE_VERSION_STRING=crm-ubuntu64
S - Boot Interface: NAND
S - Secure Boot: Off
S - Boot Config @ 0x000a602c = 0x000002e5
S - JTAG ID @ 0x000a607c = 0x001390e1
S - OEM ID @ 0x000a6080 = 0x00000000
S - Serial Number @ 0x000a4128 = 0xcb4a3f56
S - OEM Config Row 0 @ 0x000a4188 = 0x0000000000000000
S - OEM Config Row 1 @ 0x000a4190 = 0x0000000000000000
S - Feature Config Row 0 @ 0x000a4130 = 0x0000800018200021
S - Feature Config Row 1 @ 0x000a4138 = 0x02c3e83783000009
S - PBL Patch Ver: 1
S - I-cache: On
S - D-cache: On
B -      3413 - PBL, Start
B -       592 - bootable_media_detect_entry, Start
B -      4339 - bootable_media_detect_success, Start
B -      5147 - elf_loader_entry, Start
B -      5319 - auth_hash_seg_entry, Start
B -      7785 - auth_hash_seg_exit, Start
B -      8283 - elf_segs_hash_verify_entry, Start
B -    110432 - elf_segs_hash_verify_exit, Start
B -    114856 - auth_xbl_sec_hash_seg_entry, Start
B -    114999 - auth_xbl_sec_hash_seg_exit, Start
B -    121547 - xbl_sec_segs_hash_verify_entry, Start
B -    121548 - xbl_sec_segs_hash_verify_exit, Start
B -    122477 - PBL, End
B -    103273 - SBL1, Start
B -    243359 - GCC [RstStat:0x0, RstDbg:0x600000] WDog Stat : 0x4
B -    245799 - clock_init, Start
D -      2836 - clock_init, Delta
B -    254339 - boot_flash_init, Start
D -     26199 - boot_flash_init, Delta
B -    283772 - sbl1_ddr_set_default_params, Start
D -       213 - sbl1_ddr_set_default_params, Delta
B -    290390 - boot_config_data_table_init, Start
D -      4727 - boot_config_data_table_init, Delta - (575 Bytes)
B -    300242 - CDT Version:2,Platform ID:8,Major ID:3,Minor ID:2,Subtype:0
B -    305091 - Image Load, Start
D -      6618 - OEM_MISC Image Loaded, Delta - (0 Bytes)
B -    314394 - Image Load, Start
D -      5063 - PMIC Image Loaded, Delta - (0 Bytes)
B -    322293 - sbl1_ddr_set_params, Start
B -    327265 - CPR configuration: 0x366
B -    330467 - Pre_DDR_clock_init, Start
D -       183 - Pre_DDR_clock_init, Delta
D -         0 - sbl1_ddr_set_params, Delta
B -    367098 - Image Load, Start
D -       457 - APDP Image Loaded, Delta - (0 Bytes)
B -    380213 - Image Load, Start
D -       458 - QTI_MISC Image Loaded, Delta - (0 Bytes)
B -    382622 - Image Load, Start
D -       824 - Auth Metadata
D -       671 - Segments hash check
D -     22235 - QSEE Dev Config Image Loaded, Delta - (36354 Bytes)
B -    406839 - Image Load, Start
D -      6588 - Auth Metadata
D -     10492 - Segments hash check
D -    329735 - QSEE Image Loaded, Delta - (1470632 Bytes)
B -    737002 - Image Load, Start
D -       671 - Auth Metadata
D -       976 - Segments hash check
D -     34465 - RPM Image Loaded, Delta - (102664 Bytes)
B -    773175 - Image Load, Start
D -       702 - Auth Metadata
D -      3202 - Segments hash check
D -    119011 - APPSBL Image Loaded, Delta - (561320 Bytes)
B -    907802 - SBL1, End
D -    804834 - SBL1, Delta
S - Flash Throughput, 5000 KB/s  (2171545 Bytes,  423057 us)
S - Core 0 Frequency, 800 MHz
S - DDR Frequency, 466 MHz


U-Boot 2016.01 (Mar 18 2020 - 13:15:21 +0800)

DRAM:  smem ram ptable found: ver: 2 len: 4
512 MiB
NAND:  ONFI device found
ID = 1590aac2
Vendor = c2
Device = aa
SF: Unsupported flash IDs: manuf 00, jedec 0000, ext_jedec 0000
ipq_spi: SPI Flash not found (bus/cs/speed/mode) = (0/0/48000000/0)
256 MiB
MMC:   sdhci: Node Not found, skipping initialization

PCI0 is not defined in the device tree
In:    serial@78B1000
Out:   serial@78B1000
Err:   serial@78B1000
machid: 8030200

