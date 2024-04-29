Return-Path: <linux-kernel+bounces-161988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819B88B5441
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ECED1C212F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA1A28373;
	Mon, 29 Apr 2024 09:29:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC58D224EA;
	Mon, 29 Apr 2024 09:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714382951; cv=none; b=BWJ5o+JnrGbxrlRXj5pykReaOzz9ugHCELP5SujtgA2g7VLyaD5KT7w/wEdVHGMWdLiAYgdlaZc+X4DfXB+piWB739IBFa0azF0dndgMKlKGq5jd6j3pdgxK/pZwKxg0bSiBoTn5YBuW/yhoUaTyRXg/Zsuq+yIOljWFEfftAMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714382951; c=relaxed/simple;
	bh=EY2UMA9YckVBPm5cXLrC9DEDGRaHmRG/SJECqw9GRjg=;
	h=From:Subject:To:Cc:Message-ID:Date:MIME-Version:Content-Type; b=AhsKZgghYsBc2bvO2krs5e3gJ9+fYx6JkA5e/BoGMI6RwIBbZGwux6EhNNlY+No7zT7TgQNHIY6BAZpW6yrEDFQiu17+rTLX/7ltwIZeoHVkJ0+RLbzklwONOU24EBQJCzjw0BwOb2yPp4msFmltMlV5cbLanroVVYbI9TJVkfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxKPFhaC9myNwEAA--.17136S3;
	Mon, 29 Apr 2024 17:29:05 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxLN5eaC9muvEJAA--.24632S3;
	Mon, 29 Apr 2024 17:29:03 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Problem and solution about SCSI configs
To: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <ce58178c-7f26-a9a1-443a-71577162c814@loongson.cn>
Date: Mon, 29 Apr 2024 17:29:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxLN5eaC9muvEJAA--.24632S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFW7ZF4UurykWr4fAryUCFX_yoW5WFyxpF
	4xtay7Ar1kJr4qvr4UZryxWFW5Xa97J398KF1Ikas3uF1UAa47Cr9xtrW5J3y7Xwn3JF10
	qrWUWasxCa95JagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
	VUUUUUU==

Hi all,

In the current code, if the rootfs is located on a SCSI device and root=
/dev/sda3 is specified as boot option in grub.cfg, kernel boots failed
with CONFIG_SCSI=y and CONFIG_BLK_DEV_SD=m when there is no initrd, here
are the boot messages via the serial console:

   /dev/root: Can't open blockdev
   VFS: Cannot open root device "/dev/sda3" or unknown-block(0,0): error -6
   Please append a correct "root=" boot option; here are the available 
partitions:
   ...
   Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(0,0)

Set CONFIG_BLK_DEV_SD=y can solve the above issue, but in order to avoid
the potential failure, it is better to restrict the configs.

Here are some backgrounds according to Documentation/scsi/scsi.rst and
drivers/scsi/Kconfig:

The SCSI support in the Linux kernel can be modularized in a number of
different ways depending upon the needs of the end user.

The scsi-core (also known as the "mid level") contains the core of SCSI
support. Without it you can do nothing with any of the other SCSI drivers.
The SCSI core support can be a module, or it can be built into the kernel.
If the core is a module, it must be the first SCSI module loaded, and if
you unload the modules, it will have to be the last one unloaded.

The individual upper and lower level drivers can be loaded in any order
once the SCSI core is present in the kernel (either compiled in or loaded
as a module). The disk driver, CD-ROM driver, tape driver and SCSI generics
driver represent the upper level drivers to support the various assorted
devices which can be controlled.  You can for example load the tape driver
to use the tape drive, and then unload it once you have no further need for
the driver (and release the associated memory).

However, do not compile the SCSI disk driver as a module if your root file
system is located on a SCSI device. In this case, do not compile the driver
for your SCSI host adapter as a module either.

That is to say, if you want to use an ATA hard disk as root device, config
ATA will be set as y and select CONFIG_SCSI, then CONFIG_BLK_DEV_SD should
be set as y and it can not be modified as m through the defconfig or make
menuconfig if CONFIG_SCSI is y, the simple way is to let CONFIG_SCSI select
CONFIG_BLK_DEV_SD if CONFIG_SCSI is y.

Could you please let me know are you OK with the following change?

-- >8 --
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 634f2f501c6c..3e59e3e59e79 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -25,6 +25,7 @@ config SCSI
         select SG_POOL
         select SCSI_COMMON
         select BLK_DEV_BSG_COMMON if BLK_DEV_BSG
+       select BLK_DEV_SD if SCSI=y
         help
           If you want to use a SCSI hard disk, SCSI tape drive, SCSI 
CD-ROM or
           any other SCSI device under Linux, say Y and make sure that 
you know

If yes, I will post a formal patch later.

Thanks,
Tiezhu


