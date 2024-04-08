Return-Path: <linux-kernel+bounces-135476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A62C89C5BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B161F20CD5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3E7F467;
	Mon,  8 Apr 2024 13:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="IpyLp1h3"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928957D3E8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584784; cv=none; b=GWXBZ4cnklUgBjQU4xKUVgB5TLVrOBi27LO6xqo/ik05pVXfk2uDS6oG4aWq9ANRapH9Ksc1QqIguQJpuFHsDYQRXmTtdaD2zv2VLndHpZ7Ys2aUxLjAufzj9IsqCZxRRkeSlqzEc9OKYsIOwqx2tvJ/ACtb45pUbhg8P3g/dlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584784; c=relaxed/simple;
	bh=lbVTY91IwFFIb6sbUTf2Z6WUddRDSgvFYfQik2bdU5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EeKKzlrksqqfFVaXNHbaag4rQAFvPfgEa+7HyW0UJOeISGHiysrRuREBOgdcV/c0La7qdERzdWhbgBShYVRBtK9uqP58zPVf7TuhpnKigDNcMynD6zlpMVMsI73fDuWVLSpXoy2ESuAjrkT6tubVKDfat1cJP/c8WPufeUcyleI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=IpyLp1h3; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso4340833276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1712584781; x=1713189581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2coaQxB0F90mD/VO/63txYCW7fbnXdz4Og49R0bnS0Q=;
        b=IpyLp1h3XLmltMszTAcxVWHS6ZFLH/1mNbEnJhbxRzfgDqnuBZix6GaXxkPbZRn++j
         GwSzUc0K42qlfV9ozuQ2trE3fpz6b4LFuXTDSaNdIsbZgJGQEpZjZin8pCdRFaHOem7n
         xcrOU/UFn4zxyjB3RodCT5zMwLFQ4ii06grSDEf7iJUtOq5JDnDq0DPeWAvKrrtDZKg9
         nfvmDX8R3vNBjIFBgCZYHb2dmWPA5F9Ag46LO03n5wACybE+mebMDc7g7rseMNC79Gxc
         B7/picFwhBGPBUsUmWXe2q4hKHMuvPLfJpIbnnj3fA5BpqAiQttD7Bw9rLwo10EepvvK
         uleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712584781; x=1713189581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2coaQxB0F90mD/VO/63txYCW7fbnXdz4Og49R0bnS0Q=;
        b=E5oRpMYX7/Gbn98r0Syw05UUtTPwaIXXwf55CgY2PDATrxvouu7ZMTq4DRubJywR9E
         Pqkv2eLILwivGO90moG7K1NmrB3hHHXTuzXSeGkeGPOj6i+aAwWXr63Zz6AA9NUlSqFH
         WZC9ecM0Jc8N1DfJJS9R9IFna8qjJTyjXFn7o32XkKOMJkUSxumBGYX/wr1OgGNiYTeP
         BBdoIFDrUjDnc1UE1hy9Aem3q0r1UJgDSjDgmUuApyt8ZUQ3dOkqhVfkYiQIsHnd8ri7
         lvjynlUazy+w2QIOHtqzlhhLtdtefHz7yyHewXte7/QEAuAnfdQtqqsoHw+h/iS5HSP1
         HqxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQP40k4Myqxu3RUTuVfIreGafuOf2AE6DGJYd0oYxYxC5AnspSn+wgUiQUxy4psmV02Xh4V9l7T7u48x4SZfABzHuNJLSWyNnR3gwC
X-Gm-Message-State: AOJu0YwwNkQhCXH7sAq9RBYAkID/4qIQzx0P7IQfRpK1smkwvENnfn6d
	Ej0eh9LoDhwab3NT/65NNK7TdA32TD4MtPMyJpGus5FQ2JlM1eAlFOJepflNmpxbVC5NM0ZF27y
	ZZWI6s72o/EhFQFDGimTzD3Wpg/zo4cwVlLY63rT8lXhE22YGK80=
X-Google-Smtp-Source: AGHT+IHnQETxLjZU27DkaVuL2NPrz1AKM7HMA3QiyMhApsYgRMKp85PK/KLql+aHldblJDUfaYizBvoO1T3a4j8BLmw=
X-Received: by 2002:a5b:843:0:b0:dcd:af3f:c7fc with SMTP id
 v3-20020a5b0843000000b00dcdaf3fc7fcmr6978574ybq.9.1712584781543; Mon, 08 Apr
 2024 06:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403140116.3002809-1-vineeth@bitbyteword.org> <20240403140116.3002809-4-vineeth@bitbyteword.org>
In-Reply-To: <20240403140116.3002809-4-vineeth@bitbyteword.org>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 8 Apr 2024 09:59:31 -0400
Message-ID: <CAO7JXPjwEBPqCLcz8ErpgZU5VYdMnz4YORwbuMPM5=qRjOZBBQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] kvm: interface for managing pvsched driver for
 guest VMs
To: Ben Segall <bsegall@google.com>, Borislav Petkov <bp@alien8.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Wanpeng Li <wanpengli@tencent.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, himadrics@inria.fr, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tejun Heo <tj@kernel.org>, Barret Rhoden <brho@google.com>, David Vernet <dvernet@meta.com>, 
	Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding sched_ext folks

On Wed, Apr 3, 2024 at 10:01=E2=80=AFAM Vineeth Pillai (Google)
<vineeth@bitbyteword.org> wrote:
>
> Implement ioctl for assigning and unassigning pvsched driver for a
> guest. VMMs would need to adopt this ioctls for supporting the feature.
> Also add a temporary debugfs interface for managing this.
>
> Ideally, the hypervisor would be able to determine the pvsched driver
> based on the information received from the guest. Guest VMs with the
> feature enabled would request hypervisor to select a pvsched driver.
> ioctl api is an override mechanism to give more control to the admin.
>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  include/uapi/linux/kvm.h |   6 ++
>  virt/kvm/kvm_main.c      | 117 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 123 insertions(+)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index c3308536482b..4b29bdad4188 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -2227,4 +2227,10 @@ struct kvm_create_guest_memfd {
>         __u64 reserved[6];
>  };
>
> +struct kvm_pvsched_ops {
> +       __u8 ops_name[32]; /* PVSCHED_NAME_MAX */
> +};
> +
> +#define KVM_GET_PVSCHED_OPS            _IOR(KVMIO, 0xe4, struct kvm_pvsc=
hed_ops)
> +#define KVM_REPLACE_PVSCHED_OPS                _IOWR(KVMIO, 0xe5, struct=
 kvm_pvsched_ops)
>  #endif /* __LINUX_KVM_H */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0546814e4db7..b3d9c362d2e3 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1223,6 +1223,79 @@ static void kvm_destroy_vm_debugfs(struct kvm *kvm=
)
>         }
>  }
>
> +#ifdef CONFIG_PARAVIRT_SCHED_KVM
> +static int pvsched_vcpu_ops_show(struct seq_file *m, void *data)
> +{
> +       char ops_name[PVSCHED_NAME_MAX];
> +       struct pvsched_vcpu_ops *ops;
> +       struct kvm *kvm =3D (struct kvm *) m->private;
> +
> +       rcu_read_lock();
> +       ops =3D rcu_dereference(kvm->pvsched_ops);
> +       if (ops)
> +               strncpy(ops_name, ops->name, PVSCHED_NAME_MAX);
> +       rcu_read_unlock();
> +
> +       seq_printf(m, "%s\n", ops_name);
> +
> +       return 0;
> +}
> +
> +static ssize_t
> +pvsched_vcpu_ops_write(struct file *filp, const char __user *ubuf,
> +               size_t cnt, loff_t *ppos)
> +{
> +       int ret;
> +       char *cmp;
> +       char buf[PVSCHED_NAME_MAX];
> +       struct inode *inode;
> +       struct kvm *kvm;
> +
> +       if (cnt > PVSCHED_NAME_MAX)
> +               return -EINVAL;
> +
> +       if (copy_from_user(&buf, ubuf, cnt))
> +               return -EFAULT;
> +
> +       cmp =3D strstrip(buf);
> +
> +       inode =3D file_inode(filp);
> +       inode_lock(inode);
> +       kvm =3D (struct kvm *)inode->i_private;
> +       ret =3D kvm_replace_pvsched_ops(kvm, cmp);
> +       inode_unlock(inode);
> +
> +       if (ret)
> +               return ret;
> +
> +       *ppos +=3D cnt;
> +       return cnt;
> +}
> +
> +static int pvsched_vcpu_ops_open(struct inode *inode, struct file *filp)
> +{
> +       return single_open(filp, pvsched_vcpu_ops_show, inode->i_private)=
;
> +}
> +
> +static const struct file_operations pvsched_vcpu_ops_fops =3D {
> +       .open           =3D pvsched_vcpu_ops_open,
> +       .write          =3D pvsched_vcpu_ops_write,
> +       .read           =3D seq_read,
> +       .llseek         =3D seq_lseek,
> +       .release        =3D single_release,
> +};
> +
> +static void kvm_create_vm_pvsched_debugfs(struct kvm *kvm)
> +{
> +       debugfs_create_file("pvsched_vcpu_ops", 0644, kvm->debugfs_dentry=
, kvm,
> +                           &pvsched_vcpu_ops_fops);
> +}
> +#else
> +static void kvm_create_vm_pvsched_debugfs(struct kvm *kvm)
> +{
> +}
> +#endif
> +
>  static int kvm_create_vm_debugfs(struct kvm *kvm, const char *fdname)
>  {
>         static DEFINE_MUTEX(kvm_debugfs_lock);
> @@ -1288,6 +1361,8 @@ static int kvm_create_vm_debugfs(struct kvm *kvm, c=
onst char *fdname)
>                                     &stat_fops_per_vm);
>         }
>
> +       kvm_create_vm_pvsched_debugfs(kvm);
> +
>         ret =3D kvm_arch_create_vm_debugfs(kvm);
>         if (ret)
>                 goto out_err;
> @@ -5474,6 +5549,48 @@ static long kvm_vm_ioctl(struct file *filp,
>                 r =3D kvm_gmem_create(kvm, &guest_memfd);
>                 break;
>         }
> +#endif
> +#ifdef CONFIG_PARAVIRT_SCHED_KVM
> +       case KVM_REPLACE_PVSCHED_OPS:
> +               struct pvsched_vcpu_ops *ops;
> +               struct kvm_pvsched_ops in_ops, out_ops;
> +
> +               r =3D -EFAULT;
> +               if (copy_from_user(&in_ops, argp, sizeof(in_ops)))
> +                       goto out;
> +
> +               out_ops.ops_name[0] =3D 0;
> +
> +               rcu_read_lock();
> +               ops =3D rcu_dereference(kvm->pvsched_ops);
> +               if (ops)
> +                       strncpy(out_ops.ops_name, ops->name, PVSCHED_NAME=
_MAX);
> +               rcu_read_unlock();
> +
> +               r =3D kvm_replace_pvsched_ops(kvm, (char *)in_ops.ops_nam=
e);
> +               if (r)
> +                       goto out;
> +
> +               r =3D -EFAULT;
> +               if (copy_to_user(argp, &out_ops, sizeof(out_ops)))
> +                       goto out;
> +
> +               r =3D 0;
> +               break;
> +       case KVM_GET_PVSCHED_OPS:
> +               out_ops.ops_name[0] =3D 0;
> +               rcu_read_lock();
> +               ops =3D rcu_dereference(kvm->pvsched_ops);
> +               if (ops)
> +                       strncpy(out_ops.ops_name, ops->name, PVSCHED_NAME=
_MAX);
> +               rcu_read_unlock();
> +
> +               r =3D -EFAULT;
> +               if (copy_to_user(argp, &out_ops, sizeof(out_ops)))
> +                       goto out;
> +
> +               r =3D 0;
> +               break;
>  #endif
>         default:
>                 r =3D kvm_arch_vm_ioctl(filp, ioctl, arg);
> --
> 2.40.1
>

