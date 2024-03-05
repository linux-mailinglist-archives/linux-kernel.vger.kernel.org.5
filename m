Return-Path: <linux-kernel+bounces-92943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7714A872863
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEDE291D55
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DD7128399;
	Tue,  5 Mar 2024 20:15:40 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B91317BDC;
	Tue,  5 Mar 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709669739; cv=none; b=ScLUbgue6Hnr7Gw6uHyewVfzHXDcYkzyfuZwNqTTMnPpkl9O1rilXCAR/2OOz+0f5LM5FpGJEFqew2m5b3IdLebiXaaDt8UCs6rPoe60Vqe2iVjcBLiFTruiPPx/Wef5G0Lm3NOAflBaH3+tsOY0+jp05cl8ItWfQg+/SudAIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709669739; c=relaxed/simple;
	bh=G7no1YJL9DmcoQkfFWDkjzZL68cN4RmEgEThuxLYasc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxASmnJNm3mngSVMfDI+sYH+PA2it3Wx2/efZMkzFsxZ0bpx3Nv3lvbJ1Ja8p62+tRFh1CAg/sicVKwm4EBFjcvBAD7kJPe1wNj5ZS9U2lC9ELpvXEBbAMBXTVUhG8iidzCefCIyjE6XU5y2ruJ/zocz2rIe/XsVRROkfUP7SpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21eab2bd67bso347401fac.0;
        Tue, 05 Mar 2024 12:15:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709669737; x=1710274537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e90WqAEMxgxrpNORTlE61Hg6YT9+0kYQ66C6ACF3xTE=;
        b=gyU6ekdpbrft3DHiDma7yx2uRdA1cW9yFuS/FIEbZRXWFBFulC/SZGx34Qdww1WnGK
         fuA7ALzGG+tF4zcoxy05qbDzrs9gD55EfO/fAjD2dkh5CI8ALGH6FjXkF4TS3jxsTrkZ
         3zccJ7GD3yOqyrIbMJr2V0BDZxav07J8CxY/rRHzd10T/e4bFMsKnP8PgOefrq0MnrM2
         wuIIG3g+JhjEi0KLFq4VwOejk0OfHGd8JtISEZvQUHjouiSfGnsenxDy4Q+VcS5YEpWK
         ViQP4qPk1cslRlh4DGJWf1hb90Hd98xz7YfgqXf0KcQ2AAHCm26ko8pR35FdvfN+Spdp
         otyw==
X-Forwarded-Encrypted: i=1; AJvYcCWWs0PntAsogGlqKtYYfJQcJgOO69Px/sMqYvt4ipbbzkSzvCQ4alIX1BFm1l2JecorKAnS9oeF0BYhn0+bBOev8tvmqKk2f3ZYP0WyaVR5ZFPZgPAieAbdv8LrF7TG9+OoOuvbhdHbZcxQWMeKZLef5mFLWWv7v1aiBnOn+tCKkA==
X-Gm-Message-State: AOJu0YxF0ov2c8nr/lptoUezcWJRzsKD/A9QaBITndG0OD6Ms1Pi+um2
	lL0FN9CUHxKUygotEtzqTudkg12FJ8TTRNN4ebUI5+Xpmn1fW43z8RAmagZlg+gqJimQ+7/OYJd
	ro5zNqDw9Q0esElVMKu9YhAjm/mLdyRcU
X-Google-Smtp-Source: AGHT+IGpt94eac2seF1UNAk8Va+8JauiQL3EPR8c2l6hQLevF5ZrIe3j6bVBG6B6s0CQ3k7ZHpGIydw+b6t5H0t9s/U=
X-Received: by 2002:a05:6870:2143:b0:221:b2a:3beb with SMTP id
 g3-20020a056870214300b002210b2a3bebmr1054943oae.2.1709669737175; Tue, 05 Mar
 2024 12:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301192600.2568-1-jarredwhite@linux.microsoft.com>
In-Reply-To: <20240301192600.2568-1-jarredwhite@linux.microsoft.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 5 Mar 2024 21:15:25 +0100
Message-ID: <CAJZ5v0hTmkB_rrFgxUYbrxbs_JC-vM1oYdH27D-QvVaVuovNXg@mail.gmail.com>
Subject: Re: [PATCH v3] acpi: Use access_width over bit_width for system
 memory accesses
To: Jarred White <jarredwhite@linux.microsoft.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	srivatsabhat@linux.microsoft.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 8:27=E2=80=AFPM Jarred White
<jarredwhite@linux.microsoft.com> wrote:
>
> To align with ACPI 6.3+, since bit_width can be any 8-bit value, we canno=
t
> depend on it being always on a clean 8b boundary. This was uncovered on t=
he
> Cobalt 100 platform.
>
> SError Interrupt on CPU26, code 0xbe000011 -- SError
>  CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted 5.15.2.1-13 #1
>  Hardware name: MICROSOFT CORPORATION, BIOS MICROSOFT CORPORATION
>  pstate: 62400009 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=3D--)
>  pc : cppc_get_perf_caps+0xec/0x410
>  lr : cppc_get_perf_caps+0xe8/0x410
>  sp : ffff8000155ab730
>  x29: ffff8000155ab730 x28: ffff0080139d0038 x27: ffff0080139d0078
>  x26: 0000000000000000 x25: ffff0080139d0058 x24: 00000000ffffffff
>  x23: ffff0080139d0298 x22: ffff0080139d0278 x21: 0000000000000000
>  x20: ffff00802b251910 x19: ffff0080139d0000 x18: ffffffffffffffff
>  x17: 0000000000000000 x16: ffffdc7e111bad04 x15: ffff00802b251008
>  x14: ffffffffffffffff x13: ffff013f1fd63300 x12: 0000000000000006
>  x11: ffffdc7e128f4420 x10: 0000000000000000 x9 : ffffdc7e111badec
>  x8 : ffff00802b251980 x7 : 0000000000000000 x6 : ffff0080139d0028
>  x5 : 0000000000000000 x4 : ffff0080139d0018 x3 : 00000000ffffffff
>  x2 : 0000000000000008 x1 : ffff8000155ab7a0 x0 : 0000000000000000
>  Kernel panic - not syncing: Asynchronous SError Interrupt
>  CPU: 26 PID: 1510 Comm: systemd-udevd Not tainted
> 5.15.2.1-13 #1
>  Hardware name: MICROSOFT CORPORATION, BIOS MICROSOFT CORPORATION
>  Call trace:
>   dump_backtrace+0x0/0x1e0
>   show_stack+0x24/0x30
>   dump_stack_lvl+0x8c/0xb8
>   dump_stack+0x18/0x34
>   panic+0x16c/0x384
>   add_taint+0x0/0xc0
>   arm64_serror_panic+0x7c/0x90
>   arm64_is_fatal_ras_serror+0x34/0xa4
>   do_serror+0x50/0x6c
>   el1h_64_error_handler+0x40/0x74
>   el1h_64_error+0x7c/0x80
>   cppc_get_perf_caps+0xec/0x410
>   cppc_cpufreq_cpu_init+0x74/0x400 [cppc_cpufreq]
>   cpufreq_online+0x2dc/0xa30
>   cpufreq_add_dev+0xc0/0xd4
>   subsys_interface_register+0x134/0x14c
>   cpufreq_register_driver+0x1b0/0x354
>   cppc_cpufreq_init+0x1a8/0x1000 [cppc_cpufreq]
>   do_one_initcall+0x50/0x250
>   do_init_module+0x60/0x27c
>   load_module+0x2300/0x2570
>   __do_sys_finit_module+0xa8/0x114
>   __arm64_sys_finit_module+0x2c/0x3c
>   invoke_syscall+0x78/0x100
>   el0_svc_common.constprop.0+0x180/0x1a0
>   do_el0_svc+0x84/0xa0
>   el0_svc+0x2c/0xc0
>   el0t_64_sync_handler+0xa4/0x12c
>   el0t_64_sync+0x1a4/0x1a8
>
> Instead, use access_width to determine the size and use the offset and wi=
dth
> to shift and mask the bits we want to read/write out. Make sure to add a =
check
> for system memory since pcc redefines the access_width to subspace id. If
> access_width is not set, then fallback to using the bit_width.
>
> Signed-off-by: Jarred White <jarredwhite@linux.microsoft.com>
> CC: srivatsabhat@linux.microsoft.com
> CC: stable@vger.kernel.org #5.15+
> ---
> changelog:
> v1-->v2:
> https://lore.kernel.org/linux-acpi/20231216001312.1160-1-jarredwhite@linu=
x.microsoft.com/
>         1. Fixed coding style errors
>         2. Backwards compatibility with ioremapping of address still an
>                 open question. Suggestions are welcomed.
> v2-->v3:
>         1. Created a fallback mechanism to revert to using the bit_width
>         2. Re-labeled macro to GET_BIT_WIDTH
>         3. Collapsed the if/else statements in the cpc_read() and cpc_wri=
te() routines
>
>  drivers/acpi/cppc_acpi.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index d155a86a8614..57de7edda7a5 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -166,6 +166,13 @@ show_cppc_data(cppc_get_perf_caps, cppc_perf_caps, n=
ominal_freq);
>  show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
>  show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
>
> +/* Check for valid access_width, otherwise, fallback to using the bit_wi=
dth */
> +#define GET_BIT_WIDTH(reg) ((reg)->access_width ? (8 << ((reg)->access_w=
idth - 1)) : (reg)->bit_width)
> +
> +/* Shift and apply the mask for CPC reads/writes */
> +#define MASK_VAL(reg, val) ((val) >> ((reg)->bit_offset &               =
       \
> +                                       GENMASK(((reg)->bit_width), 0)))
> +
>  static ssize_t show_feedback_ctrs(struct kobject *kobj,
>                 struct kobj_attribute *attr, char *buf)
>  {
> @@ -780,6 +787,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                         } else if (gas_t->space_id =3D=3D ACPI_ADR_SPACE_=
SYSTEM_MEMORY) {
>                                 if (gas_t->address) {
>                                         void __iomem *addr;
> +                                       size_t access_width;
>
>                                         if (!osc_cpc_flexible_adr_space_c=
onfirmed) {
>                                                 pr_debug("Flexible addres=
s space capability not supported\n");
> @@ -787,7 +795,9 @@ int acpi_cppc_processor_probe(struct acpi_processor *=
pr)
>                                                         goto out_free;
>                                         }
>
> -                                       addr =3D ioremap(gas_t->address, =
gas_t->bit_width/8);
> +                                       /* Check for access_width for the=
 size, otherwise use bit_width */
> +                                       access_width =3D GET_BIT_WIDTH(ga=
s_t) / 8;
> +                                       addr =3D ioremap(gas_t->address, =
access_width);
>                                         if (!addr)
>                                                 goto out_free;
>                                         cpc_ptr->cpc_regs[i-2].sys_mem_va=
ddr =3D addr;
> @@ -983,6 +993,7 @@ int __weak cpc_write_ffh(int cpunum, struct cpc_reg *=
reg, u64 val)
>  static int cpc_read(int cpu, struct cpc_register_resource *reg_res, u64 =
*val)
>  {
>         void __iomem *vaddr =3D NULL;
> +       int size;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
>
> @@ -994,7 +1005,7 @@ static int cpc_read(int cpu, struct cpc_register_res=
ource *reg_res, u64 *val)
>         *val =3D 0;
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> -               u32 width =3D 8 << (reg->access_width - 1);
> +               u32 width =3D GET_BIT_WIDTH(reg);
>                 u32 val_u32;
>                 acpi_status status;
>
> @@ -1018,7 +1029,9 @@ static int cpc_read(int cpu, struct cpc_register_re=
source *reg_res, u64 *val)
>                 return acpi_os_read_memory((acpi_physical_address)reg->ad=
dress,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       size =3D GET_BIT_WIDTH(reg);
> +
> +       switch (size) {
>         case 8:
>                 *val =3D readb_relaxed(vaddr);
>                 break;
> @@ -1037,18 +1050,22 @@ static int cpc_read(int cpu, struct cpc_register_=
resource *reg_res, u64 *val)
>                 return -EFAULT;
>         }
>
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               *val =3D MASK_VAL(reg, *val);
> +
>         return 0;
>  }
>
>  static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64=
 val)
>  {
>         int ret_val =3D 0;
> +       int size;
>         void __iomem *vaddr =3D NULL;
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> -               u32 width =3D 8 << (reg->access_width - 1);
> +               u32 width =3D GET_BIT_WIDTH(reg);
>                 acpi_status status;
>
>                 status =3D acpi_os_write_port((acpi_io_address)reg->addre=
ss,
> @@ -1070,7 +1087,12 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
>                 return acpi_os_write_memory((acpi_physical_address)reg->a=
ddress,
>                                 val, reg->bit_width);
>
> -       switch (reg->bit_width) {
> +       size =3D GET_BIT_WIDTH(reg);
> +
> +       if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
> +               val =3D MASK_VAL(reg, val);
> +
> +       switch (size) {
>         case 8:
>                 writeb_relaxed(val, vaddr);
>                 break;
> --

Applied as 6.9 material with some edits in the subject and changelog
and some adjustments of the new comments (one edited and one dropped).

Thanks!

