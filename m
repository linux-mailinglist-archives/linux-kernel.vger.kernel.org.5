Return-Path: <linux-kernel+bounces-16664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C52E824212
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5031C21E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3E22313;
	Thu,  4 Jan 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W4I5KaWt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844122303
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e7abe4be4so607770e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704372950; x=1704977750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjQDiWQhmYwu06q+jnykGxK4oKv3uADualUi+Y7oThw=;
        b=W4I5KaWtfUjObGwUERBeRUi4jE5oaWtW8RpCG560/uoGdcXvkWcqRKXzVD2Vm8v8FD
         vl9z0QulCrluSaJrCMGqCXad02QURuR0hW1n8xrWvLkv+HPG1unC2pNMahgsgLwH0AUS
         gCKNReq1LI+01gLDfvU5NRj+4FVIWQ94NcfQTvQIUCveR6wLoy1AVQeNrP7pxFxY1+/u
         Scb4XOCBjVcVjosO5VfoJJnnErTSzLggzBh+ubUqE/Rk86gcvx0JYsl+3wOb4J47Bsgy
         o0A/SyNUEORLwT4fnj7LQsBTQz4UPg8bagedu+gyGAFKZaQjbHWyn55QY9nAReuAe0WD
         wnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372950; x=1704977750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjQDiWQhmYwu06q+jnykGxK4oKv3uADualUi+Y7oThw=;
        b=PXg0lNvgQhkN27l3d+nC9MnRBdtsuzs09oQ8mF1OMkkySPzim76eTkyoaTHtXkaoIM
         OYj1LNszpXKyGL7UYYXai8aP5ve/L44NFBhjZ8W45pRWnqRIcB6M2tvFoYJrO+/z7lc3
         uVWmlY+Jy35yVxpXZryPI/yBBj2YkB6Bj1VFdNE22AIs9f03FmW3mPnTHfhdOshzdF7E
         IIRNjkUPN9K7rBDLwC7+cWSVXn/nlcNA9TYNLr2I4hYtIE0aFFPbTm+6934/1EU6UDyH
         /K01Oafp1jDzfuQAdE2+4PsSkdS/EnxnciJer5NHPkGbTwgLH9lhWlzp1Fz/5W8Or9zG
         JGFA==
X-Gm-Message-State: AOJu0YywxRiOe9WdvcLCmkGk98WqfOLJecV/t9I9ghnwbNBpyoYGGPEh
	LCbaeg9nWvhFTafwMUFreSQmQp2t+Q+YgNX2GOIQW0Ow44rmHA==
X-Google-Smtp-Source: AGHT+IHNx4kxzc88ls5DeUmZEq3LCdQ7T5LlcjxcR56/jWxl2zztQ6IRlN2xiwuKaa1gM1Qx2n2k1SQVWMFXB48tpgc=
X-Received: by 2002:a05:6512:3b07:b0:50e:378b:5187 with SMTP id
 f7-20020a0565123b0700b0050e378b5187mr480099lfv.41.1704372950594; Thu, 04 Jan
 2024 04:55:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102220134.3229156-1-samuel.holland@sifive.com> <20240102220134.3229156-12-samuel.holland@sifive.com>
In-Reply-To: <20240102220134.3229156-12-samuel.holland@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Thu, 4 Jan 2024 13:55:40 +0100
Message-ID: <CAHVXubg35imiKb+daAaMXwkWvM06x4+JCczZAGHbb-pSuffLPg@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] riscv: mm: Preserve global TLB entries when
 switching contexts
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 11:01=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> If the CPU does not support multiple ASIDs, all MM contexts use ASID 0.
> In this case, it is still beneficial to flush the TLB by ASID, as the
> single-ASID variant of the sfence.vma instruction preserves TLB entries
> for global (kernel) pages.
>
> This optimization is recommended by the RISC-V privileged specification:
>
>   If the implementation does not provide ASIDs, or software chooses
>   to always use ASID 0, then after every satp write, software should
>   execute SFENCE.VMA with rs1=3Dx0. In the common case that no global
>   translations have been modified, rs2 should be set to a register
>   other than x0 but which contains the value zero, so that global
>   translations are not flushed.
>
> It is not possible to apply this optimization when using the ASID
> allocator, because that code must flush the TLB for all ASIDs at once
> when incrementing the version number.
>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> (no changes since v1)
>
>  arch/riscv/mm/context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 43a8bc2d5af4..3ca9b653df7d 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -200,7 +200,7 @@ static void set_mm_noasid(struct mm_struct *mm)
>  {
>         /* Switch the page table and blindly nuke entire local TLB */
>         csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | satp_mode);
> -       local_flush_tlb_all();
> +       local_flush_tlb_all_asid(0);
>  }
>
>  static inline void set_mm(struct mm_struct *prev,
> --
> 2.42.0
>

You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex

