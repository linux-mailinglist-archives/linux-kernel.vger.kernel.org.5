Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF3480B0EF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574874AbjLIA0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIA0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:26:52 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0CA1724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 16:26:58 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso3454768e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 16:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702081617; x=1702686417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hRzpUJt/zJ83ew9kv7GqhhWrCD4wJjJTFBUypveDRg=;
        b=bLCsaPQYUtr3zfp7MWbxGlwUlUC5xShcvU8bgHlOgJPsYAjBUfjUE94bZlVsi7e2oK
         qM6Luh0E8aBEdiRccrzFFjpvY2fTSiX4gP2fOiSkDVehzLO99V73TldD3JMpOo55N2XS
         zoE8ZY2rbY7zSM1o5ybRkIYcKzYauQWR4BnuLhi6UAnYhej5tVcKzhuhkUCGqJWdgoAI
         50fuFQrG2xmiP1LEB1CL87YLswTPVEhzqii6+nye+0n0n5l4MNVQEV462mi0EFl5Rkd3
         lxNw4hsicrk3MASWSVzWTG+ujLk5uViKs4JhWm7fYkr9GonEMSmzycx6O/vktpVIAhC6
         Uf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081617; x=1702686417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hRzpUJt/zJ83ew9kv7GqhhWrCD4wJjJTFBUypveDRg=;
        b=lxdQANU07EP2b3gKvT/U+6+4xz8/4s09Jwusw78yv7M09N0R5WdsBSp3GkJmjq/5hk
         qca53Zh/XBOcWwZ9F7VocFq/G8am7I1qLZmfRU0R67N6CWM0NomqS7kpOlqQEV/4tlr7
         pZivNLAEuwms/9JDlHXchxQ0rUg1k0CCJe+yiNGO+Okqu0aJo7EhXTkbR6gDldEuabcV
         6TedYcWHgR7prqOVN8V52G2ZJ9CdRhE6rJ+yMb6QRIeyAPYz2dgIcd2j5rc4WAR/Eq3N
         aeJvhSFeDvOwonj2Q+unkoLn5pIRnPT9CRX4DJINCJ1+sQKNGLPbRQbAAY8wH8YmJO8j
         mhag==
X-Gm-Message-State: AOJu0YxsK4d8xGzoR3zwzjSsjUgwrWp+aaBQOXcj45eerL7AInxzRs6x
        mNn+fMJb2erChfXqr+osym5cnX11jgJq3vV9I0+GKQ==
X-Google-Smtp-Source: AGHT+IGUBMLMqZANgiyUhZSK/xcXmEo19ketJCC7LdaL3bhq5USFZGqOfEzCEL9b91+Th4EXw0BIs0+IJhclCMD0KO0=
X-Received: by 2002:ac2:5e89:0:b0:50c:9e1:bf7a with SMTP id
 b9-20020ac25e89000000b0050c09e1bf7amr395367lfq.69.1702081616958; Fri, 08 Dec
 2023 16:26:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699368322.git.isaku.yamahata@intel.com> <d8b438b6be78b4dbeea5c2a0ecaddfc06bfea43c.1699368322.git.isaku.yamahata@intel.com>
In-Reply-To: <d8b438b6be78b4dbeea5c2a0ecaddfc06bfea43c.1699368322.git.isaku.yamahata@intel.com>
From:   Sagi Shahar <sagis@google.com>
Date:   Fri, 8 Dec 2023 16:26:45 -0800
Message-ID: <CAAhR5DH-k8Jf6tdvpCJPPmHpck=mynvcM4a3We3iNDKzYo3RaA@mail.gmail.com>
Subject: Re: [PATCH v17 093/116] KVM: TDX: Handle TDX PV port io hypercall
To:     isaku.yamahata@intel.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        isaku.yamahata@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
        erdemaktas@google.com, Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, chen.bo@intel.com,
        hang.yuan@intel.com, tina.zhang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:58=E2=80=AFAM <isaku.yamahata@intel.com> wrote:
>
> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> Wire up TDX PV port IO hypercall to the KVM backend function.
>
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/tdx.c | 57 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> index 4e48989d364f..d4b09255ad32 100644
> --- a/arch/x86/kvm/vmx/tdx.c
> +++ b/arch/x86/kvm/vmx/tdx.c
> @@ -1140,6 +1140,61 @@ static int tdx_emulate_hlt(struct kvm_vcpu *vcpu)
>         return kvm_emulate_halt_noskip(vcpu);
>  }
>
> +static int tdx_complete_pio_in(struct kvm_vcpu *vcpu)
> +{
> +       struct x86_emulate_ctxt *ctxt =3D vcpu->arch.emulate_ctxt;
> +       unsigned long val =3D 0;
> +       int ret;
> +
> +       WARN_ON_ONCE(vcpu->arch.pio.count !=3D 1);
> +
> +       ret =3D ctxt->ops->pio_in_emulated(ctxt, vcpu->arch.pio.size,
> +                                        vcpu->arch.pio.port, &val, 1);
> +       WARN_ON_ONCE(!ret);
> +
> +       tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_SUCCESS);
> +       tdvmcall_set_return_val(vcpu, val);
> +
> +       return 1;
> +}
> +
> +static int tdx_emulate_io(struct kvm_vcpu *vcpu)
> +{
> +       struct x86_emulate_ctxt *ctxt =3D vcpu->arch.emulate_ctxt;
> +       unsigned long val =3D 0;
> +       unsigned int port;
> +       int size, ret;
> +       bool write;
> +
> +       ++vcpu->stat.io_exits;
> +
> +       size =3D tdvmcall_a0_read(vcpu);
> +       write =3D tdvmcall_a1_read(vcpu);
> +       port =3D tdvmcall_a2_read(vcpu);
> +
> +       if (size !=3D 1 && size !=3D 2 && size !=3D 4) {
> +               tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_INVALID_OPER=
AND);
> +               return 1;
> +       }
> +
> +       if (write) {
> +               val =3D tdvmcall_a3_read(vcpu);
> +               ret =3D ctxt->ops->pio_out_emulated(ctxt, size, port, &va=
l, 1);
> +
> +               /* No need for a complete_userspace_io callback. */
> +               vcpu->arch.pio.count =3D 0;
> +       } else {
> +               ret =3D ctxt->ops->pio_in_emulated(ctxt, size, port, &val=
, 1);
> +               if (!ret)
> +                       vcpu->arch.complete_userspace_io =3D tdx_complete=
_pio_in;
> +               else
> +                       tdvmcall_set_return_val(vcpu, val);
> +       }
> +       if (ret)
> +               tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_SUCCESS);

In the case of a write operation that needs to exit to userspace,
pio_out_emulated is going to return 0 which means that the return code
is never set by tdx_emulate_io.
The reason this code is working now is because r10 is already set to 0
by the guest as part of the call to tdvmcall and never gets written by
the host.

> +       return ret;
> +}
> +
>  static int handle_tdvmcall(struct kvm_vcpu *vcpu)
>  {
>         if (tdvmcall_exit_type(vcpu))
> @@ -1150,6 +1205,8 @@ static int handle_tdvmcall(struct kvm_vcpu *vcpu)
>                 return tdx_emulate_cpuid(vcpu);
>         case EXIT_REASON_HLT:
>                 return tdx_emulate_hlt(vcpu);
> +       case EXIT_REASON_IO_INSTRUCTION:
> +               return tdx_emulate_io(vcpu);
>         default:
>                 break;
>         }
> --
> 2.25.1
>
