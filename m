Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E1479FE8A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjINIhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjINIha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:37:30 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79341BFC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:37:26 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1CCFF3F66D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694680645;
        bh=D8/vdg5WWy297srdvLmeFBOUg2iKk4zetQQ/8UfG4Fs=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=hxcMLj3nvUMdJ5FWf5q2rluFdAolF5PNL6wLhuemiVUS0yt2wUDW/Y75sSgYwh9F1
         5o2DkqjkpljbUtW8T9aJTFp+1l1qgXOG3ppAOfqHm7DJrGydmBKENig1YsQqpvQNO7
         Q98Vg9TbRdLYYr7PyGdXwl2Mc8eIBAFlT1z+Wv4M4ZL9JNkgAnu2FwZS4FlzZLVv5+
         oN7UvYy5KQKMS9ue+Toip4B5fPaKTyOFyLxdVK/kyg52ZfXQgxMgeJAXefV3jcUKnx
         fRgj/oRIb8QXxf/chKzwC/uOzHNGx/LwxUuYO2JJ02eA1t8KOxM09L7tDyPke5dZDL
         7AWCdDphakWaw==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41219864601so8039141cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694680644; x=1695285444;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D8/vdg5WWy297srdvLmeFBOUg2iKk4zetQQ/8UfG4Fs=;
        b=K6u52GKdI+wOCQRoXInNDKYn00kPTmE5V4s3r/O0OxMpwgT5jthIps9ASiuYd89HV/
         6mapWM+sfTL7AZsDhoAgztMj/dvxjz/q9T4qk+m3Z3YotNJB5drs/vYAnuk/ILHEpJCV
         yuQWe7WJE9jQaPP4973WRxV4En8KVULP7U3QsuFsYRbXHySjfaUiSK9zwMfNQqC1mmwC
         dXljgKVqdNfoJA2sJQCkGLA1oSAQBQGUPkR1d3mWvN0r97PzJMGqv14dE1rjh9S5Hik2
         PRFjeQv8nm/Uw/Al4SdU1ivudOp2ofOuoJBStHekwnoEoOBC8h86G4ghTTynSMuY/hlh
         k2rw==
X-Gm-Message-State: AOJu0YwuXc9mE9nHq5NF5L7gJ2lEbrioDHyTMu79vzxKoELetl/KyvFD
        i59BAvDtfjzQSTx0FTH4ykDfPKXhQK46OX8qmTN8DZnZCBZ5EstHFDjwOmYHZ3ZR2Jtu0jvKz3M
        cC1w3qOM3I/0DWqK59RvTynZQlrycMLDhDe/GLVXLo28hO0tqS9wdd4PBWA==
X-Received: by 2002:a05:622a:14d0:b0:412:184d:cfe7 with SMTP id u16-20020a05622a14d000b00412184dcfe7mr5526738qtx.26.1694680643762;
        Thu, 14 Sep 2023 01:37:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNnZ+nGTMsCn0DRQNe0Qzahm4pMoonr/P+YAcKTP/sMMuWeo6QZg94wyWt7YgQ3pHq4DHx2t63CBIKEdArydA=
X-Received: by 2002:a05:622a:14d0:b0:412:184d:cfe7 with SMTP id
 u16-20020a05622a14d000b00412184dcfe7mr5526722qtx.26.1694680643522; Thu, 14
 Sep 2023 01:37:23 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 14 Sep 2023 01:37:23 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230914020044.1397356-3-songshuaishuai@tinylab.org>
References: <20230914020044.1397356-1-songshuaishuai@tinylab.org> <20230914020044.1397356-3-songshuaishuai@tinylab.org>
Mime-Version: 1.0
Date:   Thu, 14 Sep 2023 01:37:23 -0700
Message-ID: <CAJM55Z8D3yJREg0+UtecW3wpgrGKxZYP73Pvbi2oaQfsZf4Gfw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: kexec_file: Support loading Image binary file
To:     Song Shuai <songshuaishuai@tinylab.org>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        guoren@kernel.org, ajones@ventanamicro.com, alexghiti@rivosinc.com,
        evan@rivosinc.com, sunilvl@ventanamicro.com,
        xianting.tian@linux.alibaba.com, samitolvanen@google.com,
        masahiroy@kernel.org, apatel@ventanamicro.com, jszhang@kernel.org,
        duwe@suse.de, eric.devolder@oracle.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai wrote:
> This patch creates image_kexec_ops to load Image binary file
> for kexec_file_load() syscall.
>
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> ---
>  arch/riscv/include/asm/image.h         |  2 +
>  arch/riscv/include/asm/kexec.h         |  1 +
>  arch/riscv/kernel/Makefile             |  2 +-
>  arch/riscv/kernel/kexec_image.c        | 97 ++++++++++++++++++++++++++
>  arch/riscv/kernel/machine_kexec_file.c |  1 +
>  5 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/kexec_image.c
>
> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm/image.h
> index e0b319af3681..8927a6ea1127 100644
> --- a/arch/riscv/include/asm/image.h
> +++ b/arch/riscv/include/asm/image.h
> @@ -30,6 +30,8 @@
>  			      RISCV_HEADER_VERSION_MINOR)
>
>  #ifndef __ASSEMBLY__
> +#define riscv_image_flag_field(flags, field)\
> +			       (((flags) >> field##_SHIFT) & field##_MASK)

Hi Song,

This macro is almost FIELD_GET from linux/bitfield.h ..

>  /**
>   * struct riscv_image_header - riscv kernel image header
>   * @code0:		Executable code
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index 518825fe4160..b9ee8346cc8c 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -56,6 +56,7 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops elf_kexec_ops;
> +extern const struct kexec_file_ops image_kexec_ops;
>
>  struct purgatory_info;
>  int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 1c62c639e875..9ecba3231a36 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -86,7 +86,7 @@ endif
>  obj-$(CONFIG_HOTPLUG_CPU)	+= cpu-hotplug.o
>  obj-$(CONFIG_KGDB)		+= kgdb.o
>  obj-$(CONFIG_KEXEC_CORE)	+= kexec_relocate.o crash_save_regs.o machine_kexec.o
> -obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o machine_kexec_file.o
> +obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o kexec_image.o machine_kexec_file.o
>  obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>  obj-$(CONFIG_CRASH_CORE)	+= crash_core.o
>
> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kexec_image.c
> new file mode 100644
> index 000000000000..b6aa7f59bd53
> --- /dev/null
> +++ b/arch/riscv/kernel/kexec_image.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * RISC-V Kexec image loader
> + *
> + */
> +
> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/kexec.h>
> +#include <linux/pe.h>
> +#include <linux/string.h>
> +#include <asm/byteorder.h>
> +#include <asm/image.h>
> +
> +static int image_probe(const char *kernel_buf, unsigned long kernel_len)
> +{
> +	const struct riscv_image_header *h =
> +		(const struct riscv_image_header *)(kernel_buf);
> +
> +	if (!h || (kernel_len < sizeof(*h)))
> +		return -EINVAL;
> +
> +	/* According to Documentation/riscv/boot-image-header.rst,
> +	 * use "magic2" field to check when version >= 0.2.
> +	 */
> +
> +	if (h->version >= RISCV_HEADER_VERSION &&
> +	    memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void *image_load(struct kimage *image,
> +				char *kernel, unsigned long kernel_len,
> +				char *initrd, unsigned long initrd_len,
> +				char *cmdline, unsigned long cmdline_len)
> +{
> +	struct riscv_image_header *h;
> +	u64 flags;
> +	bool be_image, be_kernel;
> +	struct kexec_buf kbuf;
> +	int ret;
> +
> +	/* Check Image header */
> +	h = (struct riscv_image_header *)kernel;
> +	if (!h->image_size) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Check endianness */
> +	flags = le64_to_cpu(h->flags);
> +	be_image = riscv_image_flag_field(flags, RISCV_IMAGE_FLAG_BE);

..but here you're just testing a single bit, so since be_image is a bool it
could just be
	be_image = flags & RISCV_IMAGE_FLAG_BE_MASK;

/Emil

> +	be_kernel = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> +	if (be_image != be_kernel) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Load the kernel image */
> +	kbuf.image = image;
> +	kbuf.buf_min = 0;
> +	kbuf.buf_max = ULONG_MAX;
> +	kbuf.top_down = false;
> +
> +	kbuf.buffer = kernel;
> +	kbuf.bufsz = kernel_len;
> +	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
> +	kbuf.memsz = le64_to_cpu(h->image_size);
> +	kbuf.buf_align = le64_to_cpu(h->text_offset);
> +
> +	ret = kexec_add_buffer(&kbuf);
> +	if (ret) {
> +		pr_err("Error add kernel image ret=%d\n", ret);
> +		goto out;
> +	}
> +
> +	image->start = kbuf.mem;
> +
> +	pr_info("Loaded kernel at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
> +				kbuf.mem, kbuf.bufsz, kbuf.memsz);
> +
> +	ret = load_extra_segments(image, kbuf.mem, kbuf.memsz,
> +				  initrd, initrd_len, cmdline, cmdline_len);
> +
> +out:
> +	return ret ? ERR_PTR(ret) : NULL;
> +}
> +
> +const struct kexec_file_ops image_kexec_ops = {
> +	.probe = image_probe,
> +	.load = image_load,
> +};
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/machine_kexec_file.c
> index aedb8c16a283..5dc700834f1e 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -17,6 +17,7 @@
>
>  const struct kexec_file_ops * const kexec_file_loaders[] = {
>  	&elf_kexec_ops,
> +	&image_kexec_ops,
>  	NULL
>  };
>
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
