Return-Path: <linux-kernel+bounces-153778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCBC8AD2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 19:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C49CB2517A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E29154BE3;
	Mon, 22 Apr 2024 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9PBXRja"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7770A154442;
	Mon, 22 Apr 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805227; cv=none; b=plkWCBKSXObYZFz3VdvPaFHDQamrRwOJqKmwSUS+Ki1gR6t1rJAerYouSPL/6YaFtPlR1HV+ODIDLPvLGdTkyUjDM2Q0BUb+2TEWNNllhJQ4qHMeJbizzpGrhPp3uIDH5DYvW/63cFsl+jl5lYrDqVMNqt7ZJyqMX09FvU3mJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805227; c=relaxed/simple;
	bh=s1zKSecfH6FRmGi1pXDaj0RBdLhVWJQvZjaTL6GhU6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4d18EPEWCppw6PUW2CJZDL6gH8KZvOw8QhbWjDNhstP66apzLzU54mUuIH0eoqbFKj/meaPCt8foWEgiDt8qBHnGpPjw+c4djBZAeSk/0b8FcDTDnETbpqlpBH2RUycaYmnnd5QZXkr6RmFdzR66MIIuYLKlRqpeQu/Pd+TfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9PBXRja; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126ECC32781;
	Mon, 22 Apr 2024 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713805227;
	bh=s1zKSecfH6FRmGi1pXDaj0RBdLhVWJQvZjaTL6GhU6w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=p9PBXRja5DrqjaANoj45wR5oqP3bp+/4UZDr1Idi/pLcG6u6YCY7FQhylKRY0i125
	 kClvfu45zFNxa5WHWWHfqk7f/H4ByJ2mVfLXyS8OXgMz6lMzzWe5iiONFsDoroeaK3
	 8e0VRnM7RK0K1859HlwfIYg1co1IyxnAIzrP/5svFF/7Gk8aruqarQSxc94Zu6/WI3
	 /nFx4hS6NeiEMBvTU5AMc7JRicRL6HQo6b7FTbNI0mF/NL3YzEJVnCJHFdkCeVpZqT
	 xx2fNaYCm7HsoiynuVCUKahyTtvxXCwNT29/7eFRLqcG0DcJaeRz5jQZOFdJTIV5No
	 l3CFRC+yCqbLQ==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5acdbfa6e94so1233146eaf.2;
        Mon, 22 Apr 2024 10:00:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX5GrzzTpBDChVugSAsOQAOLapXrrvJN5AxH673EV53/L4/ZLkpmPmW5/imqKtpxjWXzndv+f5ZkggCalbm68BObWrXT0YNSoqvnoquNCgiXKbJbhOqQRJgL1zk718+DiJ0xbhuw05Bq19dISt7F0OoSdKr9551zIlaJgaS4rMe3A==
X-Gm-Message-State: AOJu0YwierBbOMy2hwz9wpaJRoMFBTqqNCWEPwJMRISs9l77nP8aoFo8
	iEPLlI1/C/TuIg8MmIK5xmpJnyNBtdvayXX2hHPcO9EnVTamwMHc8ouqAps+u2QC18MnUdoz7hZ
	HFbGb+aDM2QjNwyuTnBy95WGqaeY=
X-Google-Smtp-Source: AGHT+IG5C8aadvjW5yhvWe50p/4WPry2PTf7i+PbfLKWECNBaTQZTZ7wgjS/5Q9vQx4/cCAOWukQ58biWD8awJFIDC0=
X-Received: by 2002:a4a:de19:0:b0:5a7:db56:915c with SMTP id
 y25-20020a4ade19000000b005a7db56915cmr11975023oot.1.1713805226331; Mon, 22
 Apr 2024 10:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411231844.3306037-1-vanshikonda@os.amperecomputing.com>
In-Reply-To: <20240411231844.3306037-1-vanshikonda@os.amperecomputing.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Apr 2024 19:00:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hHbnVb8jnqd+o-GMS+Pw=UMq-7LQekBWWpNqTkBNfUWA@mail.gmail.com>
Message-ID: <CAJZ5v0hHbnVb8jnqd+o-GMS+Pw=UMq-7LQekBWWpNqTkBNfUWA@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: CPPC: Fix access width used for PCC registers
To: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
Cc: Jarred White <jarredwhite@linux.microsoft.com>, 
	Easwar Hariharan <eahariha@linux.microsoft.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "5 . 15+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 1:18=E2=80=AFAM Vanshidhar Konda
<vanshikonda@os.amperecomputing.com> wrote:
>
> commit 2f4a4d63a193be6fd530d180bb13c3592052904c modified
> cpc_read/cpc_write to use access_width to read CPC registers. For PCC
> registers the access width field in the ACPI register macro specifies
> the PCC subspace id. For non-zero PCC subspace id the access width is
> incorrectly treated as access width. This causes errors when reading
> from PCC registers in the CPPC driver.
>
> For PCC registers base the size of read/write on the bit width field.
> The debug message in cpc_read/cpc_write is updated to print relevant
> information for the address space type used to read the register.
>
> Signed-off-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
> Tested-by: Jarred White <jarredwhite@linux.microsoft.com>
> Reviewed-by: Jarred White <jarredwhite@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Cc: 5.15+ <stable@vger.kernel.org> # 5.15+
> ---
>
> When testing v6.9-rc1 kernel on AmpereOne system dmesg showed that
> cpufreq policy had failed to initialize on some cores during boot because
> cpufreq->get() always returned 0. On this system CPPC registers are in PC=
C
> subspace index 2 that are 32 bits wide. With this patch the CPPC driver
> interpreted the access width field as 16 bits, causing the register read
> to roll over too quickly to provide valid values during frequency
> computation.
>
> v2:
> - Use size variable in debug print message
> - Use size instead of reg->bit_width for acpi_os_read_memory and
>   acpi_os_write_memory
>
> v3:
> - Fix language in error messages in cpc_read/cpc_write
>
>  drivers/acpi/cppc_acpi.c | 53 ++++++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 4bfbe55553f4..7d476988fae3 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1002,14 +1002,14 @@ static int cpc_read(int cpu, struct cpc_register_=
resource *reg_res, u64 *val)
>         }
>
>         *val =3D 0;
> +       size =3D GET_BIT_WIDTH(reg);
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> -               u32 width =3D GET_BIT_WIDTH(reg);
>                 u32 val_u32;
>                 acpi_status status;
>
>                 status =3D acpi_os_read_port((acpi_io_address)reg->addres=
s,
> -                                          &val_u32, width);
> +                                          &val_u32, size);
>                 if (ACPI_FAILURE(status)) {
>                         pr_debug("Error: Failed to read SystemIO port %ll=
x\n",
>                                  reg->address);
> @@ -1018,17 +1018,22 @@ static int cpc_read(int cpu, struct cpc_register_=
resource *reg_res, u64 *val)
>
>                 *val =3D val_u32;
>                 return 0;
> -       } else if (reg->space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_COMM && p=
cc_ss_id >=3D 0)
> +       } else if (reg->space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_COMM && p=
cc_ss_id >=3D 0) {
> +               /*
> +                * For registers in PCC space, the register size is deter=
mined
> +                * by the bit width field; the access size is used to ind=
icate
> +                * the PCC subspace id.
> +                */
> +               size =3D reg->bit_width;
>                 vaddr =3D GET_PCC_VADDR(reg->address, pcc_ss_id);
> +       }
>         else if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 vaddr =3D reg_res->sys_mem_vaddr;
>         else if (reg->space_id =3D=3D ACPI_ADR_SPACE_FIXED_HARDWARE)
>                 return cpc_read_ffh(cpu, reg, val);
>         else
>                 return acpi_os_read_memory((acpi_physical_address)reg->ad=
dress,
> -                               val, reg->bit_width);
> -
> -       size =3D GET_BIT_WIDTH(reg);
> +                               val, size);
>
>         switch (size) {
>         case 8:
> @@ -1044,8 +1049,13 @@ static int cpc_read(int cpu, struct cpc_register_r=
esource *reg_res, u64 *val)
>                 *val =3D readq_relaxed(vaddr);
>                 break;
>         default:
> -               pr_debug("Error: Cannot read %u bit width from PCC for ss=
: %d\n",
> -                        reg->bit_width, pcc_ss_id);
> +               if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +                       pr_debug("Error: Cannot read %u bit width from sy=
stem memory: 0x%llx\n",
> +                               size, reg->address);
> +               } else if (reg->space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_C=
OMM) {
> +                       pr_debug("Error: Cannot read %u bit width from PC=
C for ss: %d\n",
> +                               size, pcc_ss_id);
> +               }
>                 return -EFAULT;
>         }
>
> @@ -1063,12 +1073,13 @@ static int cpc_write(int cpu, struct cpc_register=
_resource *reg_res, u64 val)
>         int pcc_ss_id =3D per_cpu(cpu_pcc_subspace_idx, cpu);
>         struct cpc_reg *reg =3D &reg_res->cpc_entry.reg;
>
> +       size =3D GET_BIT_WIDTH(reg);
> +
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_IO) {
> -               u32 width =3D GET_BIT_WIDTH(reg);
>                 acpi_status status;
>
>                 status =3D acpi_os_write_port((acpi_io_address)reg->addre=
ss,
> -                                           (u32)val, width);
> +                                           (u32)val, size);
>                 if (ACPI_FAILURE(status)) {
>                         pr_debug("Error: Failed to write SystemIO port %l=
lx\n",
>                                  reg->address);
> @@ -1076,17 +1087,22 @@ static int cpc_write(int cpu, struct cpc_register=
_resource *reg_res, u64 val)
>                 }
>
>                 return 0;
> -       } else if (reg->space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_COMM && p=
cc_ss_id >=3D 0)
> +       } else if (reg->space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_COMM && p=
cc_ss_id >=3D 0) {
> +               /*
> +                * For registers in PCC space, the register size is deter=
mined
> +                * by the bit width field; the access size is used to ind=
icate
> +                * the PCC subspace id.
> +                */
> +               size =3D reg->bit_width;
>                 vaddr =3D GET_PCC_VADDR(reg->address, pcc_ss_id);
> +       }
>         else if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 vaddr =3D reg_res->sys_mem_vaddr;
>         else if (reg->space_id =3D=3D ACPI_ADR_SPACE_FIXED_HARDWARE)
>                 return cpc_write_ffh(cpu, reg, val);
>         else
>                 return acpi_os_write_memory((acpi_physical_address)reg->a=
ddress,
> -                               val, reg->bit_width);
> -
> -       size =3D GET_BIT_WIDTH(reg);
> +                               val, size);
>
>         if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY)
>                 val =3D MASK_VAL(reg, val);
> @@ -1105,8 +1121,13 @@ static int cpc_write(int cpu, struct cpc_register_=
resource *reg_res, u64 val)
>                 writeq_relaxed(val, vaddr);
>                 break;
>         default:
> -               pr_debug("Error: Cannot write %u bit width to PCC for ss:=
 %d\n",
> -                        reg->bit_width, pcc_ss_id);
> +               if (reg->space_id =3D=3D ACPI_ADR_SPACE_SYSTEM_MEMORY) {
> +                       pr_debug("Error: Cannot write %u bit width to sys=
tem memory: 0x%llx\n",
> +                               size, reg->address);
> +               } else if (reg->space_id =3D=3D ACPI_ADR_SPACE_PLATFORM_C=
OMM) {
> +                       pr_debug("Error: Cannot write %u bit width to PCC=
 for ss: %d\n",
> +                               size, pcc_ss_id);
> +               }
>                 ret_val =3D -EFAULT;
>                 break;
>         }
> --

Applied as 6.9-rc material, thanks!

