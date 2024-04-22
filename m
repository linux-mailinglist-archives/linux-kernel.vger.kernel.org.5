Return-Path: <linux-kernel+bounces-152713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2298AC342
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 05:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B34281562
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 03:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FEF179AA;
	Mon, 22 Apr 2024 03:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="YdMwjjBK"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7981643A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 03:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713758245; cv=none; b=ffIGyFu2moIh9M2nOGeWFKWVsAABb58a40W3w7klfU+of4XykKbr/BRRg+BiGTZRO7KHHFYbcJyrmseuKE1Arckyn1BN0jgGnYnAXUO3r0NQVFnh/aaRvh+kHLcUD4fnnRFqEBzkr1nGdfSGB1ID+oKObHs1gnk3K0Cz/nr33NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713758245; c=relaxed/simple;
	bh=m78rjYqtH25kdm1i2u7R5d8dHFrvcmvFLpsxsDFRjuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rkjoj0RtfpbcVqPmLhmScfXJdvw9OIuJLMdUbOLeT12y7z5+refQsVvuNSo/bdErfYneoPJzlsNQOdhtAqDZ+SRmgKWtWZXFmqFyqNVzsJtb38Qj1v3t1iFYVTAvCZ/bVdiK2PgXVK2+3FUL/lAW5q0DtPDV5VwIy3DpD5pXgx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=YdMwjjBK; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36a1b0777b7so16382165ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 20:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1713758243; x=1714363043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EFW9+m2geC2plcNu4ooEHsTuQPopye1HlQhXkbIiQ4=;
        b=YdMwjjBKY1BHDUu7hLKF+k2iC0Qjj1xYlYyMcqpUXMiyyya0LbHUN2BQSVr9lG7I8P
         mbYrABy2wPqDbqAJw7KPWbym9DyAo7dNaeY5vyMTlN80A1kIF6sQjsJubFfsj8E6x07U
         eap7LzCk9Jb9XvFUS6WyT2xmiBKO/R0IXYTCbYr/lXxlL5m7YcNrC6xDQbcHERkAa1rB
         EdQj2sx6J2xPZxC85XshOYbdo7tuKEh8jNUyBDvz96TgC/8xMcUQiSxZK1omn+F+tBGm
         dU7kTYg1VbsjMdzIvURnQ3dd7JZgmoMfNvQYYNMHEIQUgWAz6WWZAw6tK0I5uTQHg9LS
         DzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713758243; x=1714363043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EFW9+m2geC2plcNu4ooEHsTuQPopye1HlQhXkbIiQ4=;
        b=C3Qw891xQszXNZx0YC5ljenmBGLIXqDOBCJRGsR101nPJIWwfwvcAAMqY/IuZuY2Ub
         wQT1He8LH0qzm1gwz5K2xr1sgDWXdKzUM6PSmzC5YX7uIzhiv8x8cF7An/dvAPM9k+b6
         76iE1yrlrTqZ6hGn5twCwyGUmimZ0eu3EUAx0ZLBMGQBnuvdyLKc4GQIQB9j5br5U75Q
         40xfcW7cboaeD+BMD/cO+dOWCvNbXtCjpSUUenpBttyLBYrSNfPpqRbMvDiWxUYv+5Vz
         WFN+8ZLX6CPC5Ufahy3wJZvaw9e5+JR4xPqR3B/Q5lYQpaJI1lf0wRchYvtQhkoLEWqV
         Tsiw==
X-Forwarded-Encrypted: i=1; AJvYcCVldZcFtVYPOt1YnXx51MSgAugt9PZ6N2FGym3u1gQNDrvFo6xOiedlItmlS01QsCjwcWNrCMwVRp+07tRqYjELQSBEptDlNko8MxKV
X-Gm-Message-State: AOJu0Yzvrem0PfkgSOiCW2U5JVw8HX4ABmXs8aahsdw1WMYpOWce07C7
	D+5KKZ0+5GjgvEeiD6ZsRp86SSyTI4Q2k6neleJrhmVv+5VpreDL1geY9fcCRikh7S2QmT9IenK
	pI4dgBYKCPrcne/xDXMBgUrz9slkd539pabwYDA==
X-Google-Smtp-Source: AGHT+IGZzRb71Y0EGdw0Xd6AXtKJ8jm8+FBKvsdhUIBFBj/iamSZ6HZ9Y892uZ7oJdYMgnoSnZprLgbiXRIFLsXAgYE=
X-Received: by 2002:a05:6e02:1d0a:b0:36a:3c07:9cdc with SMTP id
 i10-20020a056e021d0a00b0036a3c079cdcmr11903727ila.31.1713758243560; Sun, 21
 Apr 2024 20:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417074528.16506-1-yongxuan.wang@sifive.com> <20240417074528.16506-3-yongxuan.wang@sifive.com>
In-Reply-To: <20240417074528.16506-3-yongxuan.wang@sifive.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 22 Apr 2024 09:27:12 +0530
Message-ID: <CAAhSdy2na-+4DrZm7W8ZD2zGMF7J3VVL235Wx2_QVPr1AfuFVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISCV: KVM: Introduce vcpu->reset_cntx_lock
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org, 
	greentime.hu@sifive.com, vincent.chen@sifive.com, 
	Atish Patra <atishp@atishpatra.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:15=E2=80=AFPM Yong-Xuan Wang <yongxuan.wang@sifiv=
e.com> wrote:
>
> Originally, the use of kvm->lock in SBI_EXT_HSM_HART_START also avoids
> the simultaneous updates to the reset context of target VCPU. Since this
> lock has been replace with vcpu->mp_state_lock, and this new lock also
> protects the vcpu->mp_state. We have to add a separate lock for
> vcpu->reset_cntx.
>
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  arch/riscv/include/asm/kvm_host.h | 1 +
>  arch/riscv/kvm/vcpu.c             | 6 ++++++
>  arch/riscv/kvm/vcpu_sbi_hsm.c     | 3 +++
>  3 files changed, 10 insertions(+)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/k=
vm_host.h
> index 64d35a8c908c..664d1bb00368 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -211,6 +211,7 @@ struct kvm_vcpu_arch {
>
>         /* CPU context upon Guest VCPU reset */
>         struct kvm_cpu_context guest_reset_context;
> +       spinlock_t reset_cntx_lock;
>
>         /* CPU CSR context upon Guest VCPU reset */
>         struct kvm_vcpu_csr guest_reset_csr;
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 70937f71c3c4..1a2236e4c7f3 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -64,7 +64,9 @@ static void kvm_riscv_reset_vcpu(struct kvm_vcpu *vcpu)
>
>         memcpy(csr, reset_csr, sizeof(*csr));
>
> +       spin_lock(&vcpu->arch.reset_cntx_lock);
>         memcpy(cntx, reset_cntx, sizeof(*cntx));
> +       spin_unlock(&vcpu->arch.reset_cntx_lock);
>
>         kvm_riscv_vcpu_fp_reset(vcpu);
>
> @@ -121,12 +123,16 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>         spin_lock_init(&vcpu->arch.hfence_lock);
>
>         /* Setup reset state of shadow SSTATUS and HSTATUS CSRs */
> +       spin_lock_init(&vcpu->arch.reset_cntx_lock);
> +
> +       spin_lock(&vcpu->arch.reset_cntx_lock);
>         cntx =3D &vcpu->arch.guest_reset_context;
>         cntx->sstatus =3D SR_SPP | SR_SPIE;
>         cntx->hstatus =3D 0;
>         cntx->hstatus |=3D HSTATUS_VTW;
>         cntx->hstatus |=3D HSTATUS_SPVP;
>         cntx->hstatus |=3D HSTATUS_SPV;
> +       spin_unlock(&vcpu->arch.reset_cntx_lock);
>
>         if (kvm_riscv_vcpu_alloc_vector_context(vcpu, cntx))
>                 return -ENOMEM;
> diff --git a/arch/riscv/kvm/vcpu_sbi_hsm.c b/arch/riscv/kvm/vcpu_sbi_hsm.=
c
> index 115a6c6525fd..cc5038b90e02 100644
> --- a/arch/riscv/kvm/vcpu_sbi_hsm.c
> +++ b/arch/riscv/kvm/vcpu_sbi_hsm.c
> @@ -31,6 +31,7 @@ static int kvm_sbi_hsm_vcpu_start(struct kvm_vcpu *vcpu=
)
>                 goto out;
>         }
>
> +       spin_lock(&target_vcpu->arch.reset_cntx_lock);
>         reset_cntx =3D &target_vcpu->arch.guest_reset_context;
>         /* start address */
>         reset_cntx->sepc =3D cp->a1;
> @@ -38,6 +39,8 @@ static int kvm_sbi_hsm_vcpu_start(struct kvm_vcpu *vcpu=
)
>         reset_cntx->a0 =3D target_vcpuid;
>         /* private data passed from kernel */
>         reset_cntx->a1 =3D cp->a2;
> +       spin_unlock(&target_vcpu->arch.reset_cntx_lock);
> +
>         kvm_make_request(KVM_REQ_VCPU_RESET, target_vcpu);
>
>         __kvm_riscv_vcpu_power_on(target_vcpu);
> --
> 2.17.1
>

