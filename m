Return-Path: <linux-kernel+bounces-19353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB68826BCB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2AD28301A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBDC2942D;
	Mon,  8 Jan 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHaEXqrL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26C28E25
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704710765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KkVC+mvoxuSAncS71/24Hr1464TinqZdTby20Br9LBs=;
	b=AHaEXqrLCB5EhVKw+harz40HHfcgHxPcq7eDpFjii548y3MA8SFMRTCcdFF9LAg843rPsN
	SGprROUTCRYL6FeVrTkwWuwZmEYZ1Tsc2lInwheedl1P/tUSgSSEwL4ok5cnHgRAFukHy6
	bH7oKtqn6TjF7/+JjuRDHDVTptylGZI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-DhmFpjpwMkahJnS2v2P_5A-1; Mon, 08 Jan 2024 05:46:03 -0500
X-MC-Unique: DhmFpjpwMkahJnS2v2P_5A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33770774fe4so119720f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 02:46:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704710762; x=1705315562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkVC+mvoxuSAncS71/24Hr1464TinqZdTby20Br9LBs=;
        b=vHAAyCifIpFl7CPUJK9T0YqHX4UUkBvtVCFKXuwuQgHSQUwT4wBt3w+9nta/o5Xe1+
         2oZ88JFNEVot/I/+wYH1/veM5Y/moh6Gyh9lCB70B9eX7eEbrYdICrdPh0N5fVbmVGO8
         XEmeOv+Qy2B4d0e28lFDyqcJp8A9e7q+H+w3AAH2cwn2s5xY3KY9cDme9hto4SwtQQfu
         vS7YLoVqhmF7lvSeXJyqe3qNCu3qX8TKaiHbmotPnUrbW8ojVgsfFlAr+WM6khzVPqkJ
         qSn8BaqI6CqF4T5VNRAwJ+t7Nbw/55m7c+oYV4XCHSsQWEJWgkiakDzhpuwMDP5uFzI+
         TtnA==
X-Gm-Message-State: AOJu0YzFTDQy/YG+GHhlkcQMZXrgsu+qDu6RAjyPuALk7sn3qMKJ5nJG
	6Fjx2YY/DYlfutxQKVMham4KlwDVBweox2wPgUUTGFiRQTtXrgYHyXrDgH8Jz7J1MeW2lgW305j
	L+HiRGJf1vWybgRY9hsSNIF6f3hFRLHAFPrUTPYtyooHqf9d2
X-Received: by 2002:a5d:6b8a:0:b0:337:554a:1663 with SMTP id n10-20020a5d6b8a000000b00337554a1663mr2007855wrx.44.1704710762303;
        Mon, 08 Jan 2024 02:46:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpjJr9yCYeNvIWrWfB4mgnNZI1yKac6oPZt2P6kwuw0tK5p+zVcPKccb3QSB5RutnnWw97+Mg7cr6swttBbLA=
X-Received: by 2002:a5d:6b8a:0:b0:337:554a:1663 with SMTP id
 n10-20020a5d6b8a000000b00337554a1663mr2007850wrx.44.1704710762007; Mon, 08
 Jan 2024 02:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103075343.549293-1-ppandit@redhat.com>
In-Reply-To: <20240103075343.549293-1-ppandit@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 8 Jan 2024 16:15:45 +0530
Message-ID: <CAE8KmOwPKDM5xcd1kFhefeJsqYZndP09n9AxaRbypTsHm8mkgw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: make KVM_REQ_NMI request iff NMI pending for vcpu
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 13:24, Prasad Pandit <ppandit@redhat.com> wrote:
> kvm_vcpu_ioctl_x86_set_vcpu_events() routine makes 'KVM_REQ_NMI'
> request for a vcpu even when its 'events->nmi.pending' is zero.
> Ex:
>     qemu_thread_start
>      kvm_vcpu_thread_fn
>       qemu_wait_io_event
>        qemu_wait_io_event_common
>         process_queued_cpu_work
>          do_kvm_cpu_synchronize_post_init/_reset
>           kvm_arch_put_registers
>            kvm_put_vcpu_events (cpu, level=[2|3])
>
> This leads vCPU threads in QEMU to constantly acquire & release the
> global mutex lock, delaying the guest boot due to lock contention.
> Add check to make KVM_REQ_NMI request only if vcpu has NMI pending.
>
> Fixes: bdedff263132 ("KVM: x86: Route pending NMIs from userspace through process_nmi()")
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 1a3aaa7dafae..468870450b8b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5405,7 +5405,8 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
>         if (events->flags & KVM_VCPUEVENT_VALID_NMI_PENDING) {
>                 vcpu->arch.nmi_pending = 0;
>                 atomic_set(&vcpu->arch.nmi_queued, events->nmi.pending);
> -               kvm_make_request(KVM_REQ_NMI, vcpu);
> +               if (events->nmi.pending)
> +                       kvm_make_request(KVM_REQ_NMI, vcpu);
>         }
>         static_call(kvm_x86_set_nmi_mask)(vcpu, events->nmi.masked);
> --
> 2.43.0

Ping...!
---
  - Prasad


