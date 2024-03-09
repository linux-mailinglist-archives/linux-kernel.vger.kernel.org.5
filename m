Return-Path: <linux-kernel+bounces-97976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE118772E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936B3282185
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1908F4AEFE;
	Sat,  9 Mar 2024 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeMOHf8+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0582901;
	Sat,  9 Mar 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008149; cv=none; b=D4trcAXya5MyxshJNO6Af/GJ6ndaygchYdJkNxGgFhQqa306QYCS7YldoRJgW+QTWgvgkKRG+aUOyezPEu2j3aYWOMbuu6rkdZst9EHvPZHWrHG/cTk10TKV5E+Q0HyEStt9qeXznCIbq9taz1sdyMUjFEdUqQS92S1BIirZg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008149; c=relaxed/simple;
	bh=+vOYQK+xByHVzP7QdRrICOuY6MgWTDVepDXvX9NubAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PkwjVKS0ujbjApevNCNwNIHjASlzTfAd5wu+Oli1SsZswFOZHKPHaFYFcXeQqIJNMlpGKMslEjJvUQ7DZlS8El3j/CIVwDpiNDMk8/KLM7gIvzif1Krg60xoFqQ0bfHrHlgqR0ntLEn/LixwNazVKJSWKcxyrO0BxhdcKmk1dQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeMOHf8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 795C7C433C7;
	Sat,  9 Mar 2024 18:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008148;
	bh=+vOYQK+xByHVzP7QdRrICOuY6MgWTDVepDXvX9NubAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XeMOHf8+1Fhv4dBQiSC0ykKk7m6/D6lsmUg9nsJw8u+1wCKbVDOSFafEgLlc/LuKQ
	 K8AVPMUb5Ll5lxMHXMEtJWpU9CuuNBM5bh929daM3hYJjUR747Mme2rUOkS/TYfc6A
	 BC5IIfa7CpfjPa0eaDkSiui19cDFO2HRLmRo1Og4mo9RnA7uq7Ch5dxDu2svhLm106
	 F4ERjV/IpMi0/qjDhE+TkF9FhINw64AyO/J49tkcyij1f92lNpQdcTRQm6Njra50FC
	 Vr56qJmw8yNYbDeO37YcqCdFMVfdAcLC85rSDf7MSsijNZ/7CCTISppghsgTGjsff0
	 njqRL3XR7f6jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA93C54E5E;
	Sat,  9 Mar 2024 18:15:48 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 09 Mar 2024 19:15:22 +0100
Subject: [PATCH v2 01/28] sparc32: Update defconfig to LEON SMP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240309-sunset-v2-1-f09912574d2c@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
In-Reply-To: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Arnd Bergmann <arnd@kernel.org>, Andreas Larsson <andreas@gaisler.com>
Cc: Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Kjetil Oftedal <oftedal@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710008145; l=5935;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=CY6t261mQZCeFlQc9qnp4yZ7kWWgcRlupfpdl36yJw8=; =?utf-8?q?b=3DCNVa0cWJQ1bR?=
 =?utf-8?q?jpCksBnFRLQQN8o3sSyQRdRo3SP0TYBO/N7NSWN0z11MbzmcXDc5C6ayG4aKgjrq?=
 VflaOiy2BsU+Qi2uvU5KQLmMdoWAuRE1kkDYsWk1keWTNqKC0BKs
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: <sam@ravnborg.org>

From: Sam Ravnborg <sam@ravnborg.org>

This is a copy of the leon_smp defconfig found in
gaisler-buildroot-2023.02-1.0.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/configs/sparc32_defconfig | 171 +++++++++++++++++++----------------
 1 file changed, 91 insertions(+), 80 deletions(-)

diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index 5010164de3e4..71273fc578bf 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -1,97 +1,108 @@
+CONFIG_DEFAULT_HOSTNAME="leon"
 CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_BLK_DEV_INITRD=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PCI=y
-CONFIG_SUN_OPENPROMFS=m
-CONFIG_BINFMT_MISC=m
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_RD_ZSTD is not set
+CONFIG_SMP=y
+CONFIG_HZ_100=y
+CONFIG_SPARC_LEON=y
+CONFIG_SUN_OPENPROMFS=y
+CONFIG_SUN_OPENPROMIO=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_BINFMT_MISC=y
+# CONFIG_COMPACTION is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-CONFIG_XFRM_USER=m
-CONFIG_NET_KEY=m
 CONFIG_INET=y
 CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_INET_AH=y
-CONFIG_INET_ESP=y
-CONFIG_INET_IPCOMP=y
-CONFIG_INET6_AH=m
-CONFIG_INET6_ESP=m
-CONFIG_INET6_IPCOMP=m
-CONFIG_IPV6_TUNNEL=m
-CONFIG_NET_PKTGEN=m
-CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
-CONFIG_BLK_DEV_RAM=y
-CONFIG_SCSI=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_BLK_DEV_SR=m
-CONFIG_CHR_DEV_SG=m
-CONFIG_SCSI_QLOGICPTI=m
-CONFIG_SCSI_SUNESP=y
+# CONFIG_WIRELESS is not set
+CONFIG_UEVENT_HELPER=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=m
-CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
-CONFIG_SUNLANCE=y
-CONFIG_HAPPYMEAL=m
-CONFIG_SUNBMAC=m
-CONFIG_SUNQE=m
+CONFIG_GRETH=y
+# CONFIG_NET_VENDOR_ALACRITECH is not set
+# CONFIG_NET_VENDOR_AMAZON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_AQUANTIA is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
+# CONFIG_NET_VENDOR_CAVIUM is not set
+# CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_GOOGLE is not set
+# CONFIG_NET_VENDOR_HUAWEI is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MICROSEMI is not set
+# CONFIG_NET_VENDOR_NI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_NET_VENDOR_PENSANDO is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SOLARFLARE is not set
+# CONFIG_NET_VENDOR_SOCIONEXT is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_SYNOPSYS is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+CONFIG_BROADCOM_PHY=y
+CONFIG_CICADA_PHY=y
+CONFIG_DAVICOM_PHY=y
+CONFIG_ICPLUS_PHY=y
+CONFIG_LXT_PHY=y
+CONFIG_LSI_ET1011C_PHY=y
+CONFIG_MARVELL_PHY=y
+CONFIG_MICREL_PHY=y
+CONFIG_NATIONAL_PHY=y
+CONFIG_QSEMI_PHY=y
+CONFIG_REALTEK_PHY=y
+CONFIG_SMSC_PHY=y
+CONFIG_STE10XP=y
+CONFIG_VITESSE_PHY=y
 # CONFIG_WLAN is not set
-CONFIG_INPUT_JOYDEV=m
-CONFIG_INPUT_EVDEV=m
-CONFIG_INPUT_EVBUG=m
-CONFIG_KEYBOARD_ATKBD=m
-CONFIG_KEYBOARD_SUNKBD=m
-CONFIG_MOUSE_PS2=m
-CONFIG_MOUSE_SERIAL=m
-CONFIG_SERIO=m
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO_I8042 is not set
 CONFIG_SERIAL_SUNZILOG=y
 CONFIG_SERIAL_SUNZILOG_CONSOLE=y
-CONFIG_SERIAL_SUNSU=y
-CONFIG_SERIAL_SUNSU_CONSOLE=y
-CONFIG_SPI=y
-CONFIG_SPI_XILINX=m
-CONFIG_SPI_XILINX_PLTFM=m
-CONFIG_SUN_OPENPROMIO=m
-CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-CONFIG_EXT2_FS_SECURITY=y
-CONFIG_AUTOFS_FS=m
-CONFIG_ISO9660_FS=m
+CONFIG_SERIAL_GRLIB_GAISLER_APBUART=y
+CONFIG_SERIAL_GRLIB_GAISLER_APBUART_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+# CONFIG_HWMON is not set
+# CONFIG_HID_GENERIC is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_RTC_HCTOSYS is not set
+# CONFIG_RTC_INTF_SYSFS is not set
+# CONFIG_RTC_INTF_PROC is not set
+# CONFIG_RTC_INTF_DEV is not set
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_FSCACHE=y
 CONFIG_PROC_KCORE=y
-CONFIG_ROMFS_FS=m
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
-CONFIG_RPCSEC_GSS_KRB5=m
+CONFIG_NFS_FSCACHE=y
 CONFIG_NLS=y
-CONFIG_DEBUG_KERNEL=y
-CONFIG_DETECT_HUNG_TASK=y
-# CONFIG_SCHED_DEBUG is not set
-CONFIG_KGDB=y
-CONFIG_KGDB_TESTS=y
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_TWOFISH=m
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-# CONFIG_CRYPTO_HW is not set
-CONFIG_LIBCRC32C=m
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+# CONFIG_RUNTIME_TESTING_MENU is not set

-- 
2.34.1


