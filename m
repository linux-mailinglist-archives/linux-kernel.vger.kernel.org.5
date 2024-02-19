Return-Path: <linux-kernel+bounces-71069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE9685A03B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6DF1C2113A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680CB25605;
	Mon, 19 Feb 2024 09:53:03 +0000 (UTC)
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C402624B4A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.155.65.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336382; cv=none; b=EY2emShyTgyfELR1PKXae0781wPLvy99FbYcHDZLsQvUGGWU0wAFRkVy4tcokFKvSBfLKcJ5J4Q+Exw7VJJaZahkjrgLXWqEYOiRCMDJTgsXI0B4Wii/f36VWKu8uW1C8J1Iz8prQjLlnuEa1beJrQdKlWkpl7giz2LqwYNwKfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336382; c=relaxed/simple;
	bh=USGYeRrXxViQ0V/cmPh6iHdvV9/w1kJmW+dkRzsXR+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ts6DGnF369WgDDbKM1CoeSyojMPK7FOS0Q90t5K4B6qlgAE9lpfP5rgyT6KGjfiMScWDwWR9mXPZ6Nuj0c/Ov5Y51u/YkUTg9eA0DgK5BkMGw2qSpxjmvwm4ROS7NfA+fOiuQkAC3pCQD4Q2hJquHj5iBuMZgWPzvNZA8YFrlWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=43.155.65.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: bizesmtp72t1708336363tb2b6c60
X-QQ-Originating-IP: HuLcG65SFiWViZxEC/Abapl6jvesO57ib4Sl3Hj6ZmA=
Received: from [10.4.6.71] ( [58.240.82.166])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 Feb 2024 17:52:40 +0800 (CST)
X-QQ-SSF: 00200000000000B0B000000A0000000
X-QQ-FEAT: JP/5YZ9VfwnVZ+XDiKFYg3uePSUkuTmiGsSJScM5wk/aUc1KIPUFNCaS0FTKL
	bFqErT2AQGme/kPaYkxEeIRGQklZ5+yJl8mWZPOcnAad35e8rPDeXc25wwqWvbUMM3PsNUF
	m6x8aVUWhzrLEmkRozykCv/IQJUNMyWWcszfxFouCbrBYOnHIbfddP/amIFL/3fj5+2oqEf
	CPjNgYrsrxIPMUhQn1ka3JIZGWXCfoGtRhYhSUa5pO8L/npL6CTsTLfpz+vzDz3Ynui84am
	n+LEdM0q6UPFHbMKG7W2D1hayQWkicCnN3vcaSPSFPWPEVhLN0eAEfd/uHPIIP1okXV+c3s
	s8rD7UuipeZTDOcxSa1b8m8fH+tiUHytzMfLjE0Rb/T41OVzYw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13727999119307729438
Message-ID: <27DC53FAEB131D26+df5f1be3-4185-07d7-21f8-ebb6ccdfcb23@tinylab.org>
Date: Mon, 19 Feb 2024 17:52:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [External] [PATCH 2/2] riscv: kexec_file: Support loading Image
 binary file
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 lihuafei1@huawei.com, conor.dooley@microchip.com, liaochang1@huawei.com,
 guoren@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
 evan@rivosinc.com, sunilvl@ventanamicro.com,
 xianting.tian@linux.alibaba.com, samitolvanen@google.com,
 masahiroy@kernel.org, apatel@ventanamicro.com, jszhang@kernel.org,
 duwe@suse.de, eric.devolder@oracle.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20230914020044.1397356-1-songshuaishuai@tinylab.org>
 <20230914020044.1397356-3-songshuaishuai@tinylab.org>
 <CAEEQ3w=Xeuoyd8T0RDv0Eoums1S5-kX4omAUsACQLGixJqio3w@mail.gmail.com>
From: Song Shuai <songshuaishuai@tinylab.org>
In-Reply-To: <CAEEQ3w=Xeuoyd8T0RDv0Eoums1S5-kX4omAUsACQLGixJqio3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz4a-2


Hi, yunhui:

在 2024/2/16 16:54, yunhui cui 写道:
> Hi Shuai,
> 
> On Thu, Sep 14, 2023 at 10:09 AM Song Shuai <songshuaishuai@tinylab.org> wrote:
>>
>> This patch creates image_kexec_ops to load Image binary file
>> for kexec_file_load() syscall.
>>
>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
>> ---
>>   arch/riscv/include/asm/image.h         |  2 +
>>   arch/riscv/include/asm/kexec.h         |  1 +
>>   arch/riscv/kernel/Makefile             |  2 +-
>>   arch/riscv/kernel/kexec_image.c        | 97 ++++++++++++++++++++++++++
>>   arch/riscv/kernel/machine_kexec_file.c |  1 +
>>   5 files changed, 102 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/riscv/kernel/kexec_image.c
>>
>> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
>> index e0b319af3681..8927a6ea1127 100644
>> --- a/arch/riscv/include/asm/image.h
>> +++ b/arch/riscv/include/asm/image.h
>> @@ -30,6 +30,8 @@
>>                                RISCV_HEADER_VERSION_MINOR)
>>
>>   #ifndef __ASSEMBLY__
>> +#define riscv_image_flag_field(flags, field)\
>> +                              (((flags) >> field##_SHIFT) & field##_MASK)
>>   /**
>>    * struct riscv_image_header - riscv kernel image header
>>    * @code0:             Executable code
>> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
>> index 518825fe4160..b9ee8346cc8c 100644
>> --- a/arch/riscv/include/asm/kexec.h
>> +++ b/arch/riscv/include/asm/kexec.h
>> @@ -56,6 +56,7 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>>
>>   #ifdef CONFIG_KEXEC_FILE
>>   extern const struct kexec_file_ops elf_kexec_ops;
>> +extern const struct kexec_file_ops image_kexec_ops;
>>
>>   struct purgatory_info;
>>   int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
>> index 1c62c639e875..9ecba3231a36 100644
>> --- a/arch/riscv/kernel/Makefile
>> +++ b/arch/riscv/kernel/Makefile
>> @@ -86,7 +86,7 @@ endif
>>   obj-$(CONFIG_HOTPLUG_CPU)      += cpu-hotplug.o
>>   obj-$(CONFIG_KGDB)             += kgdb.o
>>   obj-$(CONFIG_KEXEC_CORE)       += kexec_relocate.o crash_save_regs.o machine_kexec.o
>> -obj-$(CONFIG_KEXEC_FILE)       += kexec_elf.o machine_kexec_file.o
>> +obj-$(CONFIG_KEXEC_FILE)       += kexec_elf.o kexec_image.o machine_kexec_file.o
>>   obj-$(CONFIG_CRASH_DUMP)       += crash_dump.o
>>   obj-$(CONFIG_CRASH_CORE)       += crash_core.o
>>
>> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
>> new file mode 100644
>> index 000000000000..b6aa7f59bd53
>> --- /dev/null
>> +++ b/arch/riscv/kernel/kexec_image.c
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * RISC-V Kexec image loader
>> + *
>> + */
>> +
>> +#define pr_fmt(fmt)    "kexec_file(Image): " fmt
>> +
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kexec.h>
>> +#include <linux/pe.h>
>> +#include <linux/string.h>
>> +#include <asm/byteorder.h>
>> +#include <asm/image.h>
>> +
>> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
>> +{
>> +       const struct riscv_image_header *h =
>> +               (const struct riscv_image_header *)(kernel_buf);
>> +
>> +       if (!h || (kernel_len < sizeof(*h)))
>> +               return -EINVAL;
>> +
>> +       /* According to Documentation/riscv/boot-image-header.rst,
>> +        * use "magic2" field to check when version >= 0.2.
>> +        */
>> +
>> +       if (h->version >= RISCV_HEADER_VERSION &&
>> +           memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +static void *image_load(struct kimage *image,
>> +                               char *kernel, unsigned long kernel_len,
>> +                               char *initrd, unsigned long initrd_len,
>> +                               char *cmdline, unsigned long cmdline_len)
>> +{
>> +       struct riscv_image_header *h;
>> +       u64 flags;
>> +       bool be_image, be_kernel;
>> +       struct kexec_buf kbuf;
>> +       int ret;
>> +
>> +       /* Check Image header */
>> +       h = (struct riscv_image_header *)kernel;
>> +       if (!h->image_size) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       /* Check endianness */
>> +       flags = le64_to_cpu(h->flags);
>> +       be_image = riscv_image_flag_field(flags, RISCV_IMAGE_FLAG_BE);
>> +       be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
>> +       if (be_image != be_kernel) {
>> +               ret = -EINVAL;
>> +               goto out;
>> +       }
>> +
>> +       /* Load the kernel image */
>> +       kbuf.image = image;
>> +       kbuf.buf_min = 0;
>> +       kbuf.buf_max = ULONG_MAX;
>> +       kbuf.top_down = false;
>> +
>> +       kbuf.buffer = kernel;
>> +       kbuf.bufsz = kernel_len;
>> +       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>> +       kbuf.memsz = le64_to_cpu(h->image_size);
>> +       kbuf.buf_align = le64_to_cpu(h->text_offset);
>> +
>> +       ret = kexec_add_buffer(&kbuf);
>> +       if (ret) {
>> +               pr_err("Error add kernel image ret=%d\n", ret);
>> +               goto out;
>> +       }
>> +
>> +       image->start = kbuf.mem;
>> +
>> +       pr_info("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
>> +                               kbuf.mem, kbuf.bufsz, kbuf.memsz);
> 
> pr_info() or pr_debug()? >
> 
>> +
>> +       ret = load_extra_segments(image, kbuf.mem, kbuf.memsz,
>> +                                 initrd, initrd_len, cmdline, cmdline_len);
>> +
>> +out:
>> +       return ret ? ERR_PTR(ret) : NULL;
>> +}
>> +
>> +const struct kexec_file_ops image_kexec_ops = {
>> +       .probe = image_probe,
>> +       .load = image_load,
>> +};
>> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
>> index aedb8c16a283..5dc700834f1e 100644
>> --- a/arch/riscv/kernel/machine_kexec_file.c
>> +++ b/arch/riscv/kernel/machine_kexec_file.c
>> @@ -17,6 +17,7 @@
>>
>>   const struct kexec_file_ops * const kexec_file_loaders[] = {
>>          &elf_kexec_ops,
>> +       &image_kexec_ops,
>>          NULL
>>   };
>>
>> --
>> 2.20.1
>>
> 
> I tested these two patches. It works when
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY is not enabled. When
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY is enabled, the error is as
> follows:
> 
> [45.712019] Unknown rela relocation: 34
> [45.712258] Error loading purgatory ret=-8
> 
> How to fix it? >
> Thanks，
> Yunhui
> 
Thanks for your attention to this series and RV kdump/kexec stack.

As you noticed, this series and the kexec-tools RV support patches[1] 
didn't get any positive responses and have been suspended for a few 
months. And I'm now struggling in my own job, so really sorry that I 
have no time to continue these works.

Although that, I would like to reply to your comments in case anyone 
wants to push this series:

Comment1: Why rename elf_kexec.c to kexec_elf.c ？
- s390 uses kexec_{elf,image}.c file names, so I followed it.

Comment2: pr_info() or pr_debug()?
- pr_debug() seems better.

Comment3: Unknown rela relocation: 34

- The CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY was enabled when I posted 
this series, I didn't see this relocation error at that time.

If you want to fix this relocation error, you need to figure out who 
hold the R_RISCV_ADD16 (34), and how it was generated (compiler options 
or other RV kernel configures). This commit 0f5f46a869a5 ("riscv: kexec: 
Remove -fPIE for PURGATORY_CFLAGS") may help.

[1]: 
https://lore.kernel.org/kexec/DA84A55096BADE15+594e239a-ff6a-368f-ae92-b6cfebbf8dc0@tinylab.org/
-- 
Thanks
Song Shuai


