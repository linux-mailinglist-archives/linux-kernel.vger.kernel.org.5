Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD4E7CA167
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjJPIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPIRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:17:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0138A2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:17:08 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4CCC140618
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697444225;
        bh=yKqKYdOrjqDzbKjE7QI+JywD0uRuXM80vXhwAAr4da0=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=GuSi4mmyygWJHnvA+nGBdTXA1dm78vIxBlYwjCgt8IXY8C0yhErcSbMmJEXHWEvsn
         DPzXPjAsuOk12fMs3uXqqzjJs1y0uMPBJDx9z+dZmU1wZgMWeevtveLaJEBWAZgsqv
         S4fPl26S/7lrUvqbstQTvbPj0S5oebKbGYDTlj3CzvcxI61pW+MYn5BPwBimAbUHC2
         JCRSQQmGEKdRziPUg5d4RSk7d+dRHBENM0/KAa7rCh4opeLIYcknRfJrGPYUAXJo+a
         e5YbIvg05ydoOH/jQZr+4pUWkjKU1gDTANMKjxYmXkmwsalrPrGhvANxVvpLo3Y3gj
         loCxJYddq0D0g==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-418ce89e56cso49451551cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 01:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697444223; x=1698049023;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yKqKYdOrjqDzbKjE7QI+JywD0uRuXM80vXhwAAr4da0=;
        b=KFmscMNfSlOketjLSvu6UaYvlMY1CgJ9NSl/QD/uJ3w8gk4ekQIxYuPm0ToMeHS8CB
         +yh+nuPnZ+tCmwrT/rKRyIgfxDw8TsT8ya2wK6ULQ/39ZINxR7SfIlq2mK5b1cT9qCwB
         0nIjtQ0OWYCz8GH0IKBn5o8QmqZWw7pTkV7QT151TplnL9ssDjlJuWJKdyExLVpFbCG2
         aXEOipl2il8LzZAmY2eDM26fIVZ4s0ambcSkBXSuiyNoWmoBzLmwpUw7fRfnIRWCvitH
         /hTurwe+pBF/ScF+dd3NxEfio0m1L80JvsloiIIlyw7xiDbrwmzbu3BySRc2rxbSm2WZ
         kaOA==
X-Gm-Message-State: AOJu0Ywdi+Z9u22g04NhO64OEMPM/wmoGqfgcUgAsmNY53oEUKW4fPyt
        UmSFJRZlRu09I++jArsb2Ke5BihHdtmqkQAvmFS+BSwY9wbPB7Jkaazay4Afnn43ucbleOQ0RX2
        AYdx9YdiKFCRQWqhliqy7vF/KZFFXng8vGoLsH6N3LXoFlcpYY5WRzHC6CA==
X-Received: by 2002:a05:622a:134c:b0:416:5ead:6171 with SMTP id w12-20020a05622a134c00b004165ead6171mr42810482qtk.47.1697444223131;
        Mon, 16 Oct 2023 01:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfK4PFNPu9u2oK3ldpaOVa7DUNMx3C2S13vAb7ALi83B+RYl1UtGruCC+LHbqzM05hI95jTOiypTmLUeR78ks=
X-Received: by 2002:a05:622a:134c:b0:416:5ead:6171 with SMTP id
 w12-20020a05622a134c00b004165ead6171mr42810473qtk.47.1697444222812; Mon, 16
 Oct 2023 01:17:02 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Oct 2023 01:17:02 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <0BE7AF7DDB61C4D3+44252858-c2e6-07e6-e9eb-dec8d3990956@tinylab.org>
References: <20230914020044.1397356-1-songshuaishuai@tinylab.org>
 <20230914020044.1397356-3-songshuaishuai@tinylab.org> <CAJM55Z8D3yJREg0+UtecW3wpgrGKxZYP73Pvbi2oaQfsZf4Gfw@mail.gmail.com>
 <22EFF2C197DC5C5A+f82966f5-90cf-09a5-214e-4b0e87bc6064@tinylab.org>
 <CAJM55Z8OebLJHg3mxk7y7Dw0z=JLgi4j17tQPf4-Mdd0BCQbaw@mail.gmail.com> <0BE7AF7DDB61C4D3+44252858-c2e6-07e6-e9eb-dec8d3990956@tinylab.org>
Mime-Version: 1.0
Date:   Mon, 16 Oct 2023 01:17:02 -0700
Message-ID: <CAJM55Z_V4S1JDnqb2ACQBn7Z=oFha5QbpurYM6AW_Upo0G8N3A@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: kexec_file: Support loading Image binary file
To:     Song Shuai <songshuaishuai@tinylab.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, lihuafei1@huawei.com,
        conor.dooley@microchip.com, liaochang1@huawei.com,
        ajones@ventanamicro.com, alexghiti@rivosinc.com, evan@rivosinc.com,
        sunilvl@ventanamicro.com, xianting.tian@linux.alibaba.com,
        samitolvanen@google.com, masahiroy@kernel.org,
        apatel@ventanamicro.com, jszhang@kernel.org, duwe@suse.de,
        eric.devolder@oracle.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Song Shuai wrote:
>
>
> =E5=9C=A8 2023/10/11 18:48, Emil Renner Berthing =E5=86=99=E9=81=93:
> > Song Shuai wrote:
> >>
> >>
> >> =E5=9C=A8 2023/9/14 16:37, Emil Renner Berthing =E5=86=99=E9=81=93:
> >>> Song Shuai wrote:
> >>>> This patch creates image_kexec_ops to load Image binary file
> >>>> for kexec_file_load() syscall.
> >>>>
> >>>> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> >>>> ---
> >>>>    arch/riscv/include/asm/image.h         |  2 +
> >>>>    arch/riscv/include/asm/kexec.h         |  1 +
> >>>>    arch/riscv/kernel/Makefile             |  2 +-
> >>>>    arch/riscv/kernel/kexec_image.c        | 97 +++++++++++++++++++++=
+++++
> >>>>    arch/riscv/kernel/machine_kexec_file.c |  1 +
> >>>>    5 files changed, 102 insertions(+), 1 deletion(-)
> >>>>    create mode 100644 arch/riscv/kernel/kexec_image.c
> >>>>
> >>>> diff --git a/arch/riscv/include/asm/image.h b/arch/riscv/include/asm=
/image.h
> >>>> index e0b319af3681..8927a6ea1127 100644
> >>>> --- a/arch/riscv/include/asm/image.h
> >>>> +++ b/arch/riscv/include/asm/image.h
> >>>> @@ -30,6 +30,8 @@
> >>>>    			      RISCV_HEADER_VERSION_MINOR)
> >>>>
> >>>>    #ifndef __ASSEMBLY__
> >>>> +#define riscv_image_flag_field(flags, field)\
> >>>> +			       (((flags) >> field##_SHIFT) & field##_MASK)
> >>>
> >>> Hi Song,
> >>>
> >>> This macro is almost FIELD_GET from linux/bitfield.h ..
> >>>
> >>>>    /**
> >>>>     * struct riscv_image_header - riscv kernel image header
> >>>>     * @code0:		Executable code
> >>>> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm=
/kexec.h
> >>>> index 518825fe4160..b9ee8346cc8c 100644
> >>>> --- a/arch/riscv/include/asm/kexec.h
> >>>> +++ b/arch/riscv/include/asm/kexec.h
> >>>> @@ -56,6 +56,7 @@ extern riscv_kexec_method riscv_kexec_norelocate;
> >>>>
> >>>>    #ifdef CONFIG_KEXEC_FILE
> >>>>    extern const struct kexec_file_ops elf_kexec_ops;
> >>>> +extern const struct kexec_file_ops image_kexec_ops;
> >>>>
> >>>>    struct purgatory_info;
> >>>>    int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> >>>> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> >>>> index 1c62c639e875..9ecba3231a36 100644
> >>>> --- a/arch/riscv/kernel/Makefile
> >>>> +++ b/arch/riscv/kernel/Makefile
> >>>> @@ -86,7 +86,7 @@ endif
> >>>>    obj-$(CONFIG_HOTPLUG_CPU)	+=3D cpu-hotplug.o
> >>>>    obj-$(CONFIG_KGDB)		+=3D kgdb.o
> >>>>    obj-$(CONFIG_KEXEC_CORE)	+=3D kexec_relocate.o crash_save_regs.o =
machine_kexec.o
> >>>> -obj-$(CONFIG_KEXEC_FILE)	+=3D kexec_elf.o machine_kexec_file.o
> >>>> +obj-$(CONFIG_KEXEC_FILE)	+=3D kexec_elf.o kexec_image.o machine_kex=
ec_file.o
> >>>>    obj-$(CONFIG_CRASH_DUMP)	+=3D crash_dump.o
> >>>>    obj-$(CONFIG_CRASH_CORE)	+=3D crash_core.o
> >>>>
> >>>> diff --git a/arch/riscv/kernel/kexec_image.c b/arch/riscv/kernel/kex=
ec_image.c
> >>>> new file mode 100644
> >>>> index 000000000000..b6aa7f59bd53
> >>>> --- /dev/null
> >>>> +++ b/arch/riscv/kernel/kexec_image.c
> >>>> @@ -0,0 +1,97 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * RISC-V Kexec image loader
> >>>> + *
> >>>> + */
> >>>> +
> >>>> +#define pr_fmt(fmt)	"kexec_file(Image): " fmt
> >>>> +
> >>>> +#include <linux/err.h>
> >>>> +#include <linux/errno.h>
> >>>> +#include <linux/kernel.h>
> >>>> +#include <linux/kexec.h>
> >>>> +#include <linux/pe.h>
> >>>> +#include <linux/string.h>
> >>>> +#include <asm/byteorder.h>
> >>>> +#include <asm/image.h>
> >>>> +
> >>>> +static int image_probe(const char *kernel_buf, unsigned long kernel=
_len)
> >>>> +{
> >>>> +	const struct riscv_image_header *h =3D
> >>>> +		(const struct riscv_image_header *)(kernel_buf);
> >>>> +
> >>>> +	if (!h || (kernel_len < sizeof(*h)))
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	/* According to Documentation/riscv/boot-image-header.rst,
> >>>> +	 * use "magic2" field to check when version >=3D 0.2.
> >>>> +	 */
> >>>> +
> >>>> +	if (h->version >=3D RISCV_HEADER_VERSION &&
> >>>> +	    memcmp(&h->magic2, RISCV_IMAGE_MAGIC2, sizeof(h->magic2)))
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static void *image_load(struct kimage *image,
> >>>> +				char *kernel, unsigned long kernel_len,
> >>>> +				char *initrd, unsigned long initrd_len,
> >>>> +				char *cmdline, unsigned long cmdline_len)
> >>>> +{
> >>>> +	struct riscv_image_header *h;
> >>>> +	u64 flags;
> >>>> +	bool be_image, be_kernel;
> >>>> +	struct kexec_buf kbuf;
> >>>> +	int ret;
> >>>> +
> >>>> +	/* Check Image header */
> >>>> +	h =3D (struct riscv_image_header *)kernel;
> >>>> +	if (!h->image_size) {
> >>>> +		ret =3D -EINVAL;
> >>>> +		goto out;
> >>>> +	}
> >>>> +
> >>>> +	/* Check endianness */
> >>>> +	flags =3D le64_to_cpu(h->flags);
> >>>> +	be_image =3D riscv_image_flag_field(flags, RISCV_IMAGE_FLAG_BE);
> >>>
> >>> ..but here you're just testing a single bit, so since be_image is a b=
ool it
> >>> could just be
> >>> 	be_image =3D flags & RISCV_IMAGE_FLAG_BE_MASK;
> >>>
> >>> /Emil
> >> Hi Emil,
> >>
> >> Sorry for the delayed response,
> >>
> >> The `flags` field currently only has bit-0 to indicate the kenrel
> >> endianness, your comment looks good in this case.
> >>
> >> While considering the future extension of the `flags` feild, the
> >> riscv_image_flag_field() is neccessiry to make callers to require the
> >> bits they want.
> >
> > Right, but please don't invent your own FIELD_GET then.
>
> Hi Emil,
>
> I tried to use FIELD_PREP/FIELD_GET to set/get the RISCV_IMAGE_FLAG_BE,
> but using FIELD_PREP to define the __HEAD_FLAGS (used in head.S) emitted
> AS build error and the final .s file looked like:
>
>   883  .dword _end - _start
>   884  .dword (({ ({ do { } while (0); do { } while (0); do { } while
> (0); do { } while (0); do { } while (0); }); ((typeof((((1)) <<
> (0))))(0) << (__builtin_ffsll((((1)) << (0))) - 1)) & ((((1)) << (0))); }=
))
>
> IIUC the FIELD_PREP can't work well in this asm context, and using
> FILED_GET without FIELD_PREP paired looks not good to me.
>
> The original riscv/*/image.h and the riscv_image_flag_filed() of this
> patch just do what arm64 does, so I still like to keep them.

Hi Song,

Your riscv_image_flag_field macro is already guarded by a #ifndef __ASSEMBL=
Y__
and your patches above doesn't touch any __HEAD_FLAGS macro, so I don't kno=
w
what you're trying to do with FIELD_PREP.

What I'm saying is that instead of defining the riscv_image_flag_field macr=
o
you can just do

-be_image =3D riscv_image_flag_field(flags, RISCV_IMAGE_FLAG_BE);
+be_image =3D FIELD_GET(RISCV_IMAGE_FLAG_BE, flags);

/Emil

> I also found that Patch1 has a build issue due to my previous uncareful
> cherry-picking,
> V2 will be sent to fix it if you're ok this patch without bitfield armed.
>
> I would like to listen to your advice.
>
> >
> >>
> >> So I prefer to keep this snippet.
> >>>
> >>>> +	be_kernel =3D IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> >>>> +	if (be_image !=3D be_kernel) {
> >>>> +		ret =3D -EINVAL;
> >>>> +		goto out;
> >>>> +	}
> >>>> +
> >>>> +	/* Load the kernel image */
> >>>> +	kbuf.image =3D image;
> >>>> +	kbuf.buf_min =3D 0;
> >>>> +	kbuf.buf_max =3D ULONG_MAX;
> >>>> +	kbuf.top_down =3D false;
> >>>> +
> >>>> +	kbuf.buffer =3D kernel;
> >>>> +	kbuf.bufsz =3D kernel_len;
> >>>> +	kbuf.mem =3D KEXEC_BUF_MEM_UNKNOWN;
> >>>> +	kbuf.memsz =3D le64_to_cpu(h->image_size);
> >>>> +	kbuf.buf_align =3D le64_to_cpu(h->text_offset);
> >>>> +
> >>>> +	ret =3D kexec_add_buffer(&kbuf);
> >>>> +	if (ret) {
> >>>> +		pr_err("Error add kernel image ret=3D%d\n", ret);
> >>>> +		goto out;
> >>>> +	}
> >>>> +
> >>>> +	image->start =3D kbuf.mem;
> >>>> +
> >>>> +	pr_info("Loaded kernel at 0x%lx bufsz=3D0x%lx memsz=3D0x%lx\n",
> >>>> +				kbuf.mem, kbuf.bufsz, kbuf.memsz);
> >>>> +
> >>>> +	ret =3D load_extra_segments(image, kbuf.mem, kbuf.memsz,
> >>>> +				  initrd, initrd_len, cmdline, cmdline_len);
> >>>> +
> >>>> +out:
> >>>> +	return ret ? ERR_PTR(ret) : NULL;
> >>>> +}
> >>>> +
> >>>> +const struct kexec_file_ops image_kexec_ops =3D {
> >>>> +	.probe =3D image_probe,
> >>>> +	.load =3D image_load,
> >>>> +};
> >>>> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/ker=
nel/machine_kexec_file.c
> >>>> index aedb8c16a283..5dc700834f1e 100644
> >>>> --- a/arch/riscv/kernel/machine_kexec_file.c
> >>>> +++ b/arch/riscv/kernel/machine_kexec_file.c
> >>>> @@ -17,6 +17,7 @@
> >>>>
> >>>>    const struct kexec_file_ops * const kexec_file_loaders[] =3D {
> >>>>    	&elf_kexec_ops,
> >>>> +	&image_kexec_ops,
> >>>>    	NULL
> >>>>    };
> >>>>
> >>>> --
> >>>> 2.20.1
