Return-Path: <linux-kernel+bounces-25196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E8C82C963
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 05:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FAD1F239F2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 04:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E667F505;
	Sat, 13 Jan 2024 04:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WypgN0AS"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C9FBE7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5989e17b01fso1800806eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 20:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705121648; x=1705726448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyhhtLBlwuT0db1cYCnecKMxo/jq/0bSomGEhxEpXvw=;
        b=WypgN0AS6Gb78YKgNiTH5rOJBw9THj+eXva0jvZgze7AGKu4R/kKH0aqu5leUbGZIt
         rGI3M9ui3yQMLXhJpusOIx4BBvBdb0dVFw8NXhyNpHw8ja/1lPGcXFhgAamjTDdyivuI
         TDvdOlPGXAR63SQOV6Zj6YfaBo/waWrXwxsf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705121648; x=1705726448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyhhtLBlwuT0db1cYCnecKMxo/jq/0bSomGEhxEpXvw=;
        b=ksD4tmUBVhB5MthXpVEdSLYth6BAFwQahaf1NFh8pi64dF3JR25wY60mqH2QPDB91F
         S9gPDpbzhjYL0yIMkX7GhKkxLIcCxeewUGF3LoVCDx9MYrv9uZ/D5uanLMNfg/EKI/ra
         KWny2UPM8Uvm7d36s5GD639m5rsgDhNA42zbQTOUoa5dfb5ewCG23GMI8pgoT3UF/C0t
         aunChKwqL3iNL+NhC1blXbDgSyfDdXhgGJPVCsYXEuLdTKw3JIBzokNvSo7AwRIjkuAD
         4KTJuMHdAlOJFd8NzEmw8TRiFGEKuMtY+e3B/zL6hSIF7J/KVE5jTEcFqNYg6x77zqKC
         PrnA==
X-Gm-Message-State: AOJu0Yy7tB9GxLg0a8FV+sq84OqMK5ab0xgtHWdvKlIjiHKfFOTFpRmI
	uuUg707QKFKJb48H9ITbgBW17LleAdqSAd2yfOsOnkgSvehM
X-Google-Smtp-Source: AGHT+IHzkZaupeuSQK5mqO9eQjZXMCaJS2zpdQc0QR94VMAtSjhMCO8pJt9SmwC9iCAiC7cwW8GkxCRJM6gO1Jf8YA0=
X-Received: by 2002:a05:6870:9a1b:b0:206:bd2a:b222 with SMTP id
 fo27-20020a0568709a1b00b00206bd2ab222mr2104109oab.72.1705121648191; Fri, 12
 Jan 2024 20:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111234142.2944934-1-jeffxu@chromium.org> <c65170fe-f596-4ce0-96e3-ba83f4e60eaf@infradead.org>
In-Reply-To: <c65170fe-f596-4ce0-96e3-ba83f4e60eaf@infradead.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 12 Jan 2024 20:53:57 -0800
Message-ID: <CABi2SkXt2_eBS=7QkPST0uHGaaEszRJbVLajbwM95RWJrbDXwQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Introduce mseal()
To: Randy Dunlap <rdunlap@infradead.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 6:20=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
>
>
> On 1/11/24 15:41, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@google.com>
> >
> > This patchset proposes a new mseal() syscall for the Linux kernel.
> >
>
> Jeff,
> Building arm64 defconfig, on linux-next-20240112, I get:
>
I don't quite get how this is related to my change.
Can you please send me the steps to reproduce ?  I don't usually build arm.

Thanks
-Jeff


>   CC      arch/arm64/kernel/asm-offsets.s
> In file included from ../include/uapi/linux/mman.h:5,
>                  from ../include/linux/mm.h:33,
>                  from ../include/linux/memblock.h:12,
>                  from ../arch/arm64/include/asm/acpi.h:14,
>                  from ../include/acpi/acpi_io.h:7,
>                  from ../include/linux/acpi.h:39,
>                  from ../include/acpi/apei.h:9,
>                  from ../include/acpi/ghes.h:5,
>                  from ../include/linux/arm_sdei.h:8,
>                  from ../arch/arm64/kernel/asm-offsets.c:10:
> ../arch/arm64/include/asm/mman.h: In function 'arch_calc_vm_prot_bits':
> ../arch/arm64/include/asm/mman.h:15:24: error: 'VM_ARM64_BTI' undeclared =
(first use in this function); did you mean 'ARM64_BTI'?
>    15 |                 ret |=3D VM_ARM64_BTI;
>       |                        ^~~~~~~~~~~~
>       |                        ARM64_BTI
> ../arch/arm64/include/asm/mman.h:15:24: note: each undeclared identifier =
is reported only once for each function it appears in
> ../arch/arm64/include/asm/mman.h:18:24: error: 'VM_MTE' undeclared (first=
 use in this function); did you mean 'VM_MAP'?
>    18 |                 ret |=3D VM_MTE;
>       |                        ^~~~~~
>       |                        VM_MAP
> ../arch/arm64/include/asm/mman.h: In function 'arch_calc_vm_flag_bits':
> ../arch/arm64/include/asm/mman.h:32:24: error: 'VM_MTE_ALLOWED' undeclare=
d (first use in this function)
>    32 |                 return VM_MTE_ALLOWED;
>       |                        ^~~~~~~~~~~~~~
> ../arch/arm64/include/asm/mman.h: In function 'arch_validate_flags':
> ../arch/arm64/include/asm/mman.h:59:29: error: 'VM_MTE' undeclared (first=
 use in this function); did you mean 'VM_MAP'?
>    59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED=
);
>       |                             ^~~~~~
>       |                             VM_MAP
> ../arch/arm64/include/asm/mman.h:59:52: error: 'VM_MTE_ALLOWED' undeclare=
d (first use in this function)
>    59 |         return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED=
);
>       |                                                    ^~~~~~~~~~~~~~
>
>
> --
> #Randy

