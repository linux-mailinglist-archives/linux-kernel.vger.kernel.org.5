Return-Path: <linux-kernel+bounces-66435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A5855CE0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A21EB321CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802D13AC9;
	Thu, 15 Feb 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlfUM3i5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C51B134AE;
	Thu, 15 Feb 2024 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707986461; cv=none; b=PjESgrjjEY9InE9E/cHUui4s3fWpliNCNduB6cSPXOt2ukREYqvX5inyulvG8sR5lOz3qce1lZks8LSukp+FqcUmUjlmkjW9c+G1rdQ3URZ9rEnXtLEf4AGnmDMlfuJbpVtqPPsWBjPUlZJeafLnqALKdhmTFUMUwQLrJby0xcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707986461; c=relaxed/simple;
	bh=Bb7G28vxTtLCOMbvAF4hRzXKs50eQCWE6EggquZwcvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8G+hSqZe4dmADr9BFKXRgtqs0hpAjvHg8Q0vKWE4HTfnc5dvB87cv4CqoXTAOtB5dRrPxj/Yy9ah0yRPAxU0B6XLkIjoWesX2vGr9j7q+n2pz1EA7302gkKg8WhJXIffi3UZtQHO6y8kKCGpBQWmgB8Jl9ASPwpFBicx8tbb7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlfUM3i5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6ABFC43143;
	Thu, 15 Feb 2024 08:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707986461;
	bh=Bb7G28vxTtLCOMbvAF4hRzXKs50eQCWE6EggquZwcvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KlfUM3i58JKV5z69hPCQg3h1hirLVpf+G3sc0hx2myt86mulCjOx63xoN6Khe/KIo
	 cbsGck360E2i+zAVjGyFLBIOOoGXuiDV2wVNzI7F7k386c7JZhrbKxyYnTHV0PX15H
	 kbP0y+4Su74FDa4jAf5qTPOXLVtJFG7Fu+l8CSbUY4mhMX/D8KBrW+DT4w7UtlLxcN
	 rVPvL7+28AOGiNfG4gSX/Ysii8F1hX3BIaXfe4KK+fmDlMKKJ4R/sQGAU3WuMOQu9q
	 yzEgSKDVNUwiHvxo7vTQFGFrWwqPRKhMV+1sMgZ0+DZjxOewz8jTLAwHf/Ox275Ghr
	 WazlETBLW8BPg==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5128812662eso410968e87.0;
        Thu, 15 Feb 2024 00:41:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHKvMzIgBiYZxMYSSbdYGegAyetGFMFr3jTEdNe5ePLcw2Qg/fjRq/pZ2oOdGN8cv7eoBTicnyKKjByVutLlzt8+Zqt1zHO5EOt5dlexnlvqaUyTrVppZ6Gi0ehTxUzs3zC1C8J7zagAqIY4VMR+7kTlg/tww3mwvzHHJcGAiogErk5WtW3xgsjs8TNc7VbYRi+rkZT4YTodawHaJAC/roy+rV
X-Gm-Message-State: AOJu0YxY+TiMO3xqnHH/qQvYi+U/gPeVwRZntowH9rnTJhj7wXNHuZf0
	rlciz8hxxpWzz5U1Y6Uw/R6LXExljE3eeDwwWaSeno7Jz4hnTYcTHEuR1yFEMaBVnS3oI+z+63a
	LfUhNulUf0gaJ5XsnSrTFU0wkXro=
X-Google-Smtp-Source: AGHT+IHKZDM1wzZoDeSnV/GsFV+KLiRraBtjmAvUmnKJcQWzLjHItXmVflNP+jCESiBY4QtdBjCSPRvbH07EjiNxCL4=
X-Received: by 2002:ac2:489b:0:b0:512:8ad5:6918 with SMTP id
 x27-20020ac2489b000000b005128ad56918mr402532lfc.41.1707986459022; Thu, 15 Feb
 2024 00:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214221847.2066632-1-ross.philipson@oracle.com> <20240214221847.2066632-15-ross.philipson@oracle.com>
In-Reply-To: <20240214221847.2066632-15-ross.philipson@oracle.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 15 Feb 2024 09:40:47 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHXt6z94JCM2C5rLz-n9nGA46bb1eMbqcP5e7K9+NzPSg@mail.gmail.com>
Message-ID: <CAMj1kXHXt6z94JCM2C5rLz-n9nGA46bb1eMbqcP5e7K9+NzPSg@mail.gmail.com>
Subject: Re: [PATCH v8 14/15] x86: Secure Launch late initcall platform module
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 23:32, Ross Philipson <ross.philipson@oracle.com> wrote:
>
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The Secure Launch platform module is a late init module. During the
> init call, the TPM event log is read and measurements taken in the
> early boot stub code are located. These measurements are extended
> into the TPM PCRs using the mainline TPM kernel driver.
>
> The platform module also registers the securityfs nodes to allow
> access to TXT register fields on Intel along with the fetching of
> and writing events to the late launch TPM log.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>

There is an awful amount of code that executes between the point where
the measurements are taken and the point where they are loaded into
the PCRs. All of this code could subvert the boot flow and hide this
fact, by replacing the actual taken measurement values with the known
'blessed' ones that will unseal the keys and/or phone home to do a
successful remote attestation.

At the very least, this should be documented somewhere. And if at all
possible, it should also be documented why this is ok, and to what
extent it limits the provided guarantees compared to a true D-RTM boot
where the early boot code measures straight into the TPMs before
proceeding.


> ---
>  arch/x86/kernel/Makefile   |   1 +
>  arch/x86/kernel/slmodule.c | 511 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 512 insertions(+)
>  create mode 100644 arch/x86/kernel/slmodule.c
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 5848ea310175..948346ff4595 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_IA32_EMULATION)  += tls.o
>  obj-y                          += step.o
>  obj-$(CONFIG_INTEL_TXT)                += tboot.o
>  obj-$(CONFIG_SECURE_LAUNCH)    += slaunch.o
> +obj-$(CONFIG_SECURE_LAUNCH)    += slmodule.o
>  obj-$(CONFIG_ISA_DMA_API)      += i8237.o
>  obj-y                          += stacktrace.o
>  obj-y                          += cpu/
> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
> new file mode 100644
> index 000000000000..52269f24902e
> --- /dev/null
> +++ b/arch/x86/kernel/slmodule.c
> @@ -0,0 +1,511 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Secure Launch late validation/setup, securityfs exposure and finalization.
> + *
> + * Copyright (c) 2022 Apertus Solutions, LLC
> + * Copyright (c) 2021 Assured Information Security, Inc.
> + * Copyright (c) 2022, Oracle and/or its affiliates.
> + *
> + * Co-developed-by: Garnet T. Grimm <grimmg@ainfosec.com>
> + * Signed-off-by: Garnet T. Grimm <grimmg@ainfosec.com>
> + * Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/linkage.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
> +#include <linux/uaccess.h>
> +#include <linux/security.h>
> +#include <linux/memblock.h>
> +#include <asm/segment.h>
> +#include <asm/sections.h>
> +#include <crypto/sha2.h>
> +#include <linux/slr_table.h>
> +#include <linux/slaunch.h>
> +
> +/*
> + * The macro DECLARE_TXT_PUB_READ_U is used to read values from the TXT
> + * public registers as unsigned values.
> + */
> +#define DECLARE_TXT_PUB_READ_U(size, fmt, msg_size)                    \
> +static ssize_t txt_pub_read_u##size(unsigned int offset,               \
> +               loff_t *read_offset,                                    \
> +               size_t read_len,                                        \
> +               char __user *buf)                                       \
> +{                                                                      \
> +       char msg_buffer[msg_size];                                      \
> +       u##size reg_value = 0;                                          \
> +       void __iomem *txt;                                              \
> +                                                                       \
> +       txt = ioremap(TXT_PUB_CONFIG_REGS_BASE,                         \
> +                       TXT_NR_CONFIG_PAGES * PAGE_SIZE);               \
> +       if (!txt)                                                       \
> +               return -EFAULT;                                         \
> +       memcpy_fromio(&reg_value, txt + offset, sizeof(u##size));       \
> +       iounmap(txt);                                                   \
> +       snprintf(msg_buffer, msg_size, fmt, reg_value);                 \
> +       return simple_read_from_buffer(buf, read_len, read_offset,      \
> +                       &msg_buffer, msg_size);                         \
> +}
> +
> +DECLARE_TXT_PUB_READ_U(8, "%#04x\n", 6);
> +DECLARE_TXT_PUB_READ_U(32, "%#010x\n", 12);
> +DECLARE_TXT_PUB_READ_U(64, "%#018llx\n", 20);
> +
> +#define DECLARE_TXT_FOPS(reg_name, reg_offset, reg_size)               \
> +static ssize_t txt_##reg_name##_read(struct file *flip,                        \
> +               char __user *buf, size_t read_len, loff_t *read_offset) \
> +{                                                                      \
> +       return txt_pub_read_u##reg_size(reg_offset, read_offset,        \
> +                       read_len, buf);                                 \
> +}                                                                      \
> +static const struct file_operations reg_name##_ops = {                 \
> +       .read = txt_##reg_name##_read,                                  \
> +}
> +
> +DECLARE_TXT_FOPS(sts, TXT_CR_STS, 64);
> +DECLARE_TXT_FOPS(ests, TXT_CR_ESTS, 8);
> +DECLARE_TXT_FOPS(errorcode, TXT_CR_ERRORCODE, 32);
> +DECLARE_TXT_FOPS(didvid, TXT_CR_DIDVID, 64);
> +DECLARE_TXT_FOPS(e2sts, TXT_CR_E2STS, 64);
> +DECLARE_TXT_FOPS(ver_emif, TXT_CR_VER_EMIF, 32);
> +DECLARE_TXT_FOPS(scratchpad, TXT_CR_SCRATCHPAD, 64);
> +
> +/*
> + * Securityfs exposure
> + */
> +struct memfile {
> +       char *name;
> +       void *addr;
> +       size_t size;
> +};
> +
> +static struct memfile sl_evtlog = {"eventlog", NULL, 0};
> +static void *txt_heap;
> +static struct txt_heap_event_log_pointer2_1_element *evtlog20;
> +static DEFINE_MUTEX(sl_evt_log_mutex);
> +
> +static ssize_t sl_evtlog_read(struct file *file, char __user *buf,
> +                             size_t count, loff_t *pos)
> +{
> +       ssize_t size;
> +
> +       if (!sl_evtlog.addr)
> +               return 0;
> +
> +       mutex_lock(&sl_evt_log_mutex);
> +       size = simple_read_from_buffer(buf, count, pos, sl_evtlog.addr,
> +                                      sl_evtlog.size);
> +       mutex_unlock(&sl_evt_log_mutex);
> +
> +       return size;
> +}
> +
> +static ssize_t sl_evtlog_write(struct file *file, const char __user *buf,
> +                              size_t datalen, loff_t *ppos)
> +{
> +       ssize_t result;
> +       char *data;
> +
> +       if (!sl_evtlog.addr)
> +               return 0;
> +
> +       /* No partial writes. */
> +       result = -EINVAL;
> +       if (*ppos != 0)
> +               goto out;
> +
> +       data = memdup_user(buf, datalen);
> +       if (IS_ERR(data)) {
> +               result = PTR_ERR(data);
> +               goto out;
> +       }
> +
> +       mutex_lock(&sl_evt_log_mutex);
> +       if (evtlog20)
> +               result = tpm20_log_event(evtlog20, sl_evtlog.addr,
> +                                        sl_evtlog.size, datalen, data);
> +       else
> +               result = tpm12_log_event(sl_evtlog.addr, sl_evtlog.size,
> +                                        datalen, data);
> +       mutex_unlock(&sl_evt_log_mutex);
> +
> +       kfree(data);
> +out:
> +       return result;
> +}
> +
> +static const struct file_operations sl_evtlog_ops = {
> +       .read = sl_evtlog_read,
> +       .write = sl_evtlog_write,
> +       .llseek = default_llseek,
> +};
> +
> +struct sfs_file {
> +       const char *name;
> +       const struct file_operations *fops;
> +};
> +
> +#define SL_TXT_ENTRY_COUNT     7
> +static const struct sfs_file sl_txt_files[] = {
> +       { "sts", &sts_ops },
> +       { "ests", &ests_ops },
> +       { "errorcode", &errorcode_ops },
> +       { "didvid", &didvid_ops },
> +       { "ver_emif", &ver_emif_ops },
> +       { "scratchpad", &scratchpad_ops },
> +       { "e2sts", &e2sts_ops }
> +};
> +
> +/* sysfs file handles */
> +static struct dentry *slaunch_dir;
> +static struct dentry *event_file;
> +static struct dentry *txt_dir;
> +static struct dentry *txt_entries[SL_TXT_ENTRY_COUNT];
> +
> +static long slaunch_expose_securityfs(void)
> +{
> +       long ret = 0;
> +       int i;
> +
> +       slaunch_dir = securityfs_create_dir("slaunch", NULL);
> +       if (IS_ERR(slaunch_dir))
> +               return PTR_ERR(slaunch_dir);
> +
> +       if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +               txt_dir = securityfs_create_dir("txt", slaunch_dir);
> +               if (IS_ERR(txt_dir)) {
> +                       ret = PTR_ERR(txt_dir);
> +                       goto remove_slaunch;
> +               }
> +
> +               for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++) {
> +                       txt_entries[i] = securityfs_create_file(
> +                                               sl_txt_files[i].name, 0440,
> +                                               txt_dir, NULL,
> +                                               sl_txt_files[i].fops);
> +                       if (IS_ERR(txt_entries[i])) {
> +                               ret = PTR_ERR(txt_entries[i]);
> +                               goto remove_files;
> +                       }
> +               }
> +       }
> +
> +       if (sl_evtlog.addr) {
> +               event_file = securityfs_create_file(sl_evtlog.name, 0440,
> +                                                   slaunch_dir, NULL,
> +                                                   &sl_evtlog_ops);
> +               if (IS_ERR(event_file)) {
> +                       ret = PTR_ERR(event_file);
> +                       goto remove_files;
> +               }
> +       }
> +
> +       return 0;
> +
> +remove_files:
> +       if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +               while (--i >= 0)
> +                       securityfs_remove(txt_entries[i]);
> +               securityfs_remove(txt_dir);
> +       }
> +
> +remove_slaunch:
> +       securityfs_remove(slaunch_dir);
> +
> +       return ret;
> +}
> +
> +static void slaunch_teardown_securityfs(void)
> +{
> +       int i;
> +
> +       securityfs_remove(event_file);
> +       if (sl_evtlog.addr) {
> +               memunmap(sl_evtlog.addr);
> +               sl_evtlog.addr = NULL;
> +       }
> +       sl_evtlog.size = 0;
> +
> +       if (slaunch_get_flags() & SL_FLAG_ARCH_TXT) {
> +               for (i = 0; i < ARRAY_SIZE(sl_txt_files); i++)
> +                       securityfs_remove(txt_entries[i]);
> +
> +               securityfs_remove(txt_dir);
> +
> +               if (txt_heap) {
> +                       memunmap(txt_heap);
> +                       txt_heap = NULL;
> +               }
> +       }
> +
> +       securityfs_remove(slaunch_dir);
> +}
> +
> +static void slaunch_intel_evtlog(void __iomem *txt)
> +{
> +       struct slr_entry_log_info *log_info;
> +       struct txt_os_mle_data *params;
> +       struct slr_table *slrt;
> +       void *os_sinit_data;
> +       u64 base, size;
> +
> +       memcpy_fromio(&base, txt + TXT_CR_HEAP_BASE, sizeof(base));
> +       memcpy_fromio(&size, txt + TXT_CR_HEAP_SIZE, sizeof(size));
> +
> +       /* now map TXT heap */
> +       txt_heap = memremap(base, size, MEMREMAP_WB);
> +       if (!txt_heap)
> +               slaunch_txt_reset(txt, "Error failed to memremap TXT heap\n",
> +                                 SL_ERROR_HEAP_MAP);
> +
> +       params = (struct txt_os_mle_data *)txt_os_mle_data_start(txt_heap);
> +
> +       /* Get the SLRT and remap it */
> +       slrt = memremap(params->slrt, sizeof(*slrt), MEMREMAP_WB);
> +       if (!slrt)
> +               slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
> +                                 SL_ERROR_SLRT_MAP);
> +       size = slrt->size;
> +       memunmap(slrt);
> +
> +       slrt = memremap(params->slrt, size, MEMREMAP_WB);
> +       if (!slrt)
> +               slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
> +                                 SL_ERROR_SLRT_MAP);
> +
> +       log_info = (struct slr_entry_log_info *)slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_LOG_INFO);
> +       if (!log_info)
> +               slaunch_txt_reset(txt, "Error failed to memremap SLR Table\n",
> +                                 SL_ERROR_SLRT_MISSING_ENTRY);
> +
> +       sl_evtlog.size = log_info->size;
> +       sl_evtlog.addr = memremap(log_info->addr, log_info->size,
> +                                 MEMREMAP_WB);
> +       if (!sl_evtlog.addr)
> +               slaunch_txt_reset(txt, "Error failed to memremap TPM event log\n",
> +                                 SL_ERROR_EVENTLOG_MAP);
> +
> +       memunmap(slrt);
> +
> +       /* Determine if this is TPM 1.2 or 2.0 event log */
> +       if (memcmp(sl_evtlog.addr + sizeof(struct tcg_pcr_event),
> +                   TCG_SPECID_SIG, sizeof(TCG_SPECID_SIG)))
> +               return; /* looks like it is not 2.0 */
> +
> +       /* For TPM 2.0 logs, the extended heap element must be located */
> +       os_sinit_data = txt_os_sinit_data_start(txt_heap);
> +
> +       evtlog20 = tpm20_find_log2_1_element(os_sinit_data);
> +
> +       /*
> +        * If this fails, things are in really bad shape. Any attempt to write
> +        * events to the log will fail.
> +        */
> +       if (!evtlog20)
> +               slaunch_txt_reset(txt, "Error failed to find TPM20 event log element\n",
> +                                 SL_ERROR_TPM_INVALID_LOG20);
> +}
> +
> +static void slaunch_tpm20_extend_event(struct tpm_chip *tpm, void __iomem *txt,
> +                                      struct tcg_pcr_event2_head *event)
> +{
> +       u16 *alg_id_field = (u16 *)((u8 *)event + sizeof(struct tcg_pcr_event2_head));
> +       struct tpm_digest *digests;
> +       u8 *dptr;
> +       u32 i, j;
> +       int ret;
> +
> +       digests = kcalloc(tpm->nr_allocated_banks, sizeof(*digests),
> +                         GFP_KERNEL);
> +       if (!digests)
> +               slaunch_txt_reset(txt, "Failed to allocate array of digests\n",
> +                                 SL_ERROR_GENERIC);
> +
> +       for (i = 0; i < tpm->nr_allocated_banks; i++)
> +               digests[i].alg_id = tpm->allocated_banks[i].alg_id;
> +
> +       /* Early SL code ensured there was a max count of 2 digests */
> +       for (i = 0; i < event->count; i++) {
> +               dptr = (u8 *)alg_id_field + sizeof(u16);
> +
> +               for (j = 0; j < tpm->nr_allocated_banks; j++) {
> +                       if (digests[j].alg_id != *alg_id_field)
> +                               continue;
> +
> +                       switch (digests[j].alg_id) {
> +                       case TPM_ALG_SHA256:
> +                               memcpy(&digests[j].digest[0], dptr,
> +                                      SHA256_DIGEST_SIZE);
> +                               alg_id_field = (u16 *)((u8 *)alg_id_field +
> +                                       SHA256_DIGEST_SIZE + sizeof(u16));
> +                               break;
> +                       case TPM_ALG_SHA1:
> +                               memcpy(&digests[j].digest[0], dptr,
> +                                      SHA1_DIGEST_SIZE);
> +                               alg_id_field = (u16 *)((u8 *)alg_id_field +
> +                                       SHA1_DIGEST_SIZE + sizeof(u16));
> +                       default:
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       ret = tpm_pcr_extend(tpm, event->pcr_idx, digests);
> +       if (ret) {
> +               pr_err("Error extending TPM20 PCR, result: %d\n", ret);
> +               slaunch_txt_reset(txt, "Failed to extend TPM20 PCR\n",
> +                                 SL_ERROR_TPM_EXTEND);
> +       }
> +
> +       kfree(digests);
> +}
> +
> +static void slaunch_tpm20_extend(struct tpm_chip *tpm, void __iomem *txt)
> +{
> +       struct tcg_pcr_event *event_header;
> +       struct tcg_pcr_event2_head *event;
> +       int start = 0, end = 0, size;
> +
> +       event_header = (struct tcg_pcr_event *)(sl_evtlog.addr +
> +                                               evtlog20->first_record_offset);
> +
> +       /* Skip first TPM 1.2 event to get to first TPM 2.0 event */
> +       event = (struct tcg_pcr_event2_head *)((u8 *)event_header +
> +                                               sizeof(struct tcg_pcr_event) +
> +                                               event_header->event_size);
> +
> +       while ((void  *)event < sl_evtlog.addr + evtlog20->next_record_offset) {
> +               size = __calc_tpm2_event_size(event, event_header, false);
> +               if (!size)
> +                       slaunch_txt_reset(txt, "TPM20 invalid event in event log\n",
> +                                         SL_ERROR_TPM_INVALID_EVENT);
> +
> +               /*
> +                * Marker events indicate where the Secure Launch early stub
> +                * started and ended adding post launch events.
> +                */
> +               if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
> +                       end = 1;
> +                       break;
> +               } else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
> +                       start = 1;
> +                       goto next;
> +               }
> +
> +               if (start)
> +                       slaunch_tpm20_extend_event(tpm, txt, event);
> +
> +next:
> +               event = (struct tcg_pcr_event2_head *)((u8 *)event + size);
> +       }
> +
> +       if (!start || !end)
> +               slaunch_txt_reset(txt, "Missing start or end events for extending TPM20 PCRs\n",
> +                                 SL_ERROR_TPM_EXTEND);
> +}
> +
> +static void slaunch_tpm12_extend(struct tpm_chip *tpm, void __iomem *txt)
> +{
> +       struct tpm12_event_log_header *event_header;
> +       struct tcg_pcr_event *event;
> +       struct tpm_digest digest;
> +       int start = 0, end = 0;
> +       int size, ret;
> +
> +       event_header = (struct tpm12_event_log_header *)sl_evtlog.addr;
> +       event = (struct tcg_pcr_event *)((u8 *)event_header +
> +                               sizeof(struct tpm12_event_log_header));
> +
> +       while ((void  *)event < sl_evtlog.addr + event_header->next_event_offset) {
> +               size = sizeof(struct tcg_pcr_event) + event->event_size;
> +
> +               /*
> +                * Marker events indicate where the Secure Launch early stub
> +                * started and ended adding post launch events.
> +                */
> +               if (event->event_type == TXT_EVTYPE_SLAUNCH_END) {
> +                       end = 1;
> +                       break;
> +               } else if (event->event_type == TXT_EVTYPE_SLAUNCH_START) {
> +                       start = 1;
> +                       goto next;
> +               }
> +
> +               if (start) {
> +                       memset(&digest.digest[0], 0, TPM_MAX_DIGEST_SIZE);
> +                       digest.alg_id = TPM_ALG_SHA1;
> +                       memcpy(&digest.digest[0], &event->digest[0],
> +                              SHA1_DIGEST_SIZE);
> +
> +                       ret = tpm_pcr_extend(tpm, event->pcr_idx, &digest);
> +                       if (ret) {
> +                               pr_err("Error extending TPM12 PCR, result: %d\n", ret);
> +                               slaunch_txt_reset(txt, "Failed to extend TPM12 PCR\n",
> +                                                 SL_ERROR_TPM_EXTEND);
> +                       }
> +               }
> +
> +next:
> +               event = (struct tcg_pcr_event *)((u8 *)event + size);
> +       }
> +
> +       if (!start || !end)
> +               slaunch_txt_reset(txt, "Missing start or end events for extending TPM12 PCRs\n",
> +                                 SL_ERROR_TPM_EXTEND);
> +}
> +
> +static void slaunch_pcr_extend(void __iomem *txt)
> +{
> +       struct tpm_chip *tpm;
> +
> +       tpm = tpm_default_chip();
> +       if (!tpm)
> +               slaunch_txt_reset(txt, "Could not get default TPM chip\n",
> +                                 SL_ERROR_TPM_INIT);
> +
> +       if (!tpm_preferred_locality(tpm, 2))
> +               slaunch_txt_reset(txt, "Could not set TPM chip locality 2\n",
> +                                 SL_ERROR_TPM_INIT);
> +
> +       if (evtlog20)
> +               slaunch_tpm20_extend(tpm, txt);
> +       else
> +               slaunch_tpm12_extend(tpm, txt);
> +
> +       tpm_preferred_locality(tpm, 0);
> +}
> +
> +static int __init slaunch_module_init(void)
> +{
> +       void __iomem *txt;
> +
> +       /* Check to see if Secure Launch happened */
> +       if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) !=
> +           (SL_FLAG_ACTIVE | SL_FLAG_ARCH_TXT))
> +               return 0;
> +
> +       txt = ioremap(TXT_PRIV_CONFIG_REGS_BASE, TXT_NR_CONFIG_PAGES *
> +                     PAGE_SIZE);
> +       if (!txt)
> +               panic("Error ioremap of TXT priv registers\n");
> +
> +       /* Only Intel TXT is supported at this point */
> +       slaunch_intel_evtlog(txt);
> +       slaunch_pcr_extend(txt);
> +       iounmap(txt);
> +
> +       return slaunch_expose_securityfs();
> +}
> +
> +static void __exit slaunch_module_exit(void)
> +{
> +       slaunch_teardown_securityfs();
> +}
> +
> +late_initcall(slaunch_module_init);
> +__exitcall(slaunch_module_exit);
> --
> 2.39.3
>

