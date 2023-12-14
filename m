Return-Path: <linux-kernel+bounces-243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA5813E31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 676B9B20E24
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB216C6EA;
	Thu, 14 Dec 2023 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TA4y3bHE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8552DB80
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 23:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ca0715f0faso808751fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702596184; x=1703200984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a9LEp0beFnu/8p3983YyIwXa8hmPxSMvxHr3zij24U=;
        b=TA4y3bHEAy+AHnv7w9ceMefhIpZX81GKa+Dq04/6PwGXdq+2mM49UI/XSbwzk43sPV
         MGl2YNsEpUZQE9ypEwmvJ/k49kwbRtOnPtPtV7k2cao661iOgVVHh3XSKaz4QTJtZK0h
         7QP9vpRFVXznwcXjNdZNQ7Jk+DkCGiDL57HM1Q0bEukpvGb3ZT2JwieP7XA83FEGhePM
         exlkQ4XHABRdFvogh+CbZ2q+mmqWlvaMA3PtWYny1X/VYkqOVcIHHqwr0yfwauMFoQlM
         ASlNQPjYboI/PAPtR5fJLy6ZzNp2isg2GdsaY3SYEqjnH6WSRlTjOrbikojQT6WDITEm
         nmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702596184; x=1703200984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4a9LEp0beFnu/8p3983YyIwXa8hmPxSMvxHr3zij24U=;
        b=NwQ1eId8fx8GfgRIJ8aeaZR5TZXgQ4ch/TUJEDffZFxvFzkoDCTPJxgOOo0SwbREuT
         ACHlClA1AZc2QMmFj8qcUr/XbOHXHewcpV9vhd4tnBlkw7b/LbogejImta6uxxSVetpn
         AJj+xufF26d817Ps7nxUO8r9L2pot5MrIuKFhhoMa4gYEFcbUJT8W7FT/L9CQMvDUlpW
         AtDHhVNU+ZYHx2gnBqg3DAWUO/Dx3TnWs7nACGZ+BjQT+bQ08kutG209YJK5Gdn6RQnX
         ikPGuiZPFbadmY503eoZ+TDxnSmouCRdPDimryA9ifNzOrkesU6Lepja8q81Y0xOPHCv
         gKxQ==
X-Gm-Message-State: AOJu0Yx/xt+lKcx+ojUWVsOZ2f110s3RD2JchcGC9kW5r5VKInZTlI7N
	F7FeaElMv6buRSDdpNgL/D0PnJ53PoF5B9/H3bX0v1540Rd+J+Rc0l91OA==
X-Google-Smtp-Source: AGHT+IGKGiS/3/StA5r2Dp0GkrO8zGz+mjoQ6rp95guWVJQ4BveWYe3uUJ9Y2ERNs/53quPYr0kQJkD/oq3vn9eLNMg=
X-Received: by 2002:a05:6512:3a91:b0:50e:1878:77d0 with SMTP id
 q17-20020a0565123a9100b0050e187877d0mr1270052lfu.6.1702596184337; Thu, 14 Dec
 2023 15:23:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699368322.git.isaku.yamahata@intel.com> <413b6ecf9e1ac90f00d3d0debdef0c3f26673f7d.1699368322.git.isaku.yamahata@intel.com>
In-Reply-To: <413b6ecf9e1ac90f00d3d0debdef0c3f26673f7d.1699368322.git.isaku.yamahata@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Thu, 14 Dec 2023 15:22:52 -0800
Message-ID: <CAAhR5DFMwVsTMkCR-inY=5UFHJTpfx6qyrUbki=8oag5OU8MmA@mail.gmail.com>
Subject: Re: [PATCH v17 007/116] KVM: TDX: Make TDX VM type supported
To: isaku.yamahata@intel.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com, 
	Sean Christopherson <seanjc@google.com>, David Matlack <dmatlack@google.com>, Kai Huang <kai.huang@intel.com>, 
	Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com, hang.yuan@intel.com, 
	tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 6:57=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> NOTE: This patch is in position of the patch series for developers to be
> able to test codes during the middle of the patch series although this
> patch series doesn't provide functional features until the all the patche=
s
> of this patch series.  When merging this patch series, this patch can be
> moved to the end.
>
> As first step TDX VM support, return that TDX VM type supported to device
> model, e.g. qemu.  The callback to create guest TD is vm_init callback fo=
r
> KVM_CREATE_VM.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>  arch/x86/kvm/vmx/main.c    | 18 ++++++++++++++++--
>  arch/x86/kvm/vmx/tdx.c     |  6 ++++++
>  arch/x86/kvm/vmx/vmx.c     |  6 ------
>  arch/x86/kvm/vmx/x86_ops.h |  3 ++-
>  4 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
> index 2b805bb95b9e..73a1c4b64819 100644
> --- a/arch/x86/kvm/vmx/main.c
> +++ b/arch/x86/kvm/vmx/main.c
> @@ -10,6 +10,12 @@
>  static bool enable_tdx __ro_after_init;
>  module_param_named(tdx, enable_tdx, bool, 0444);
>
> +static bool vt_is_vm_type_supported(unsigned long type)
> +{
> +       return __kvm_is_vm_type_supported(type) ||
> +               (enable_tdx && tdx_is_vm_type_supported(type));
> +}
> +
>  static int vt_hardware_enable(void)
>  {
>         int ret;
> @@ -37,6 +43,14 @@ static __init int vt_hardware_setup(void)
>         return 0;
>  }
>
> +static int vt_vm_init(struct kvm *kvm)
> +{
> +       if (is_td(kvm))
> +               return -EOPNOTSUPP;     /* Not ready to create guest TD y=
et. */
> +
> +       return vmx_vm_init(kvm);
> +}
> +
>  #define VMX_REQUIRED_APICV_INHIBITS                            \
>         (BIT(APICV_INHIBIT_REASON_DISABLE)|                     \
>          BIT(APICV_INHIBIT_REASON_ABSENT) |                     \
> @@ -57,9 +71,9 @@ struct kvm_x86_ops vt_x86_ops __initdata =3D {
>         .hardware_disable =3D vmx_hardware_disable,
>         .has_emulated_msr =3D vmx_has_emulated_msr,
>
> -       .is_vm_type_supported =3D vmx_is_vm_type_supported,
> +       .is_vm_type_supported =3D vt_is_vm_type_supported,

I don't see is_vm_type_supported defined at HEAD.
I could only find it here:
https://lore.kernel.org/lkml/ab9d8654bd98ae24de05788a2ecaa4bea6c0c44b.16898=
93403.git.isaku.yamahata@intel.com/#r
Is [RFC PATCH v4 00/10] KVM: guest_memfd(), X86: Common base ..." a
dependency for this patch series?

>         .vm_size =3D sizeof(struct kvm_vmx),
> -       .vm_init =3D vmx_vm_init,
> +       .vm_init =3D vt_vm_init,
>         .vm_destroy =3D vmx_vm_destroy,
>
>         .vcpu_precreate =3D vmx_vcpu_precreate,
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 1c9884164566..9d3f593eacb8 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -24,6 +24,12 @@ static int __init tdx_module_setup(void)
>         return 0;
>  }
>
> +bool tdx_is_vm_type_supported(unsigned long type)
> +{
> +       /* enable_tdx check is done by the caller. */
> +       return type =3D=3D KVM_X86_TDX_VM;
> +}
> +
>  struct vmx_tdx_enabled {
>         cpumask_var_t vmx_enabled;
>         atomic_t err;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 34165a3c99fa..83b0b62cab6c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7532,12 +7532,6 @@ int vmx_vcpu_create(struct kvm_vcpu *vcpu)
>         return err;
>  }
>
> -bool vmx_is_vm_type_supported(unsigned long type)
> -{
> -       /* TODO: Check if TDX is supported. */
> -       return __kvm_is_vm_type_supported(type);
> -}
> -
>  #define L1TF_MSG_SMT "L1TF CPU bug present and SMT on, data leak possibl=
e. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide=
/hw-vuln/l1tf.html for details.\n"
>  #define L1TF_MSG_L1D "L1TF CPU bug present and virtualization mitigation=
 disabled, data leak possible. See CVE-2018-3646 and https://www.kernel.org=
/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.\n"
>
> diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
> index 86c8ee6954e5..ed9147f7b958 100644
> --- a/arch/x86/kvm/vmx/x86_ops.h
> +++ b/arch/x86/kvm/vmx/x86_ops.h
> @@ -28,7 +28,6 @@ void vmx_hardware_unsetup(void);
>  int vmx_check_processor_compat(void);
>  int vmx_hardware_enable(void);
>  void vmx_hardware_disable(void);
> -bool vmx_is_vm_type_supported(unsigned long type);
>  int vmx_vm_init(struct kvm *kvm);
>  void vmx_vm_destroy(struct kvm *kvm);
>  int vmx_vcpu_precreate(struct kvm *kvm);
> @@ -137,8 +136,10 @@ void vmx_setup_mce(struct kvm_vcpu *vcpu);
>
>  #ifdef CONFIG_INTEL_TDX_HOST
>  int __init tdx_hardware_setup(struct kvm_x86_ops *x86_ops);
> +bool tdx_is_vm_type_supported(unsigned long type);
>  #else
>  static inline int tdx_hardware_setup(struct kvm_x86_ops *x86_ops) { retu=
rn -EOPNOTSUPP; }
> +static inline bool tdx_is_vm_type_supported(unsigned long type) { return=
 false; }
>  #endif
>
>  #endif /* __KVM_X86_VMX_X86_OPS_H */
> --
> 2.25.1
>

