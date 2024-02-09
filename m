Return-Path: <linux-kernel+bounces-59894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321E684FD03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D7C287E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8705084A47;
	Fri,  9 Feb 2024 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YpTFkfk9"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275382866
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507615; cv=none; b=l0386nLFj9YXzBshHKl+rwaTiLmd8FYro3q4nGNvrQYY0a9EY98eDVDVXSKs7fXR5QR3rdGTj7GSQVJL95SmwPiScfP25111GGoferrGMNBSiTVOvGTEHM/VU+2doK2PBMgEgA8smYcwgwVN56WsHofAOWjGpcvsF8laW5RRbdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507615; c=relaxed/simple;
	bh=6PPQOnkkIeCfd/CHcSpaIXnSwRon/6R8zai/0r9L2sA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qTJNL7PJre4DxJG956Y4n/mG4FJxeefP7i0Ur8ilf/GDRHODcT6k8L82eNAYa/OM2Bjd8wFw7c2ujJJX6ORtxdsj+KfMFvB65EkkhIbK9HDs3FyicbTZ8PinnC+3fU3+em9eebzOXqvMGkzgob1rJT2+lG3S9M36UETLAYcxce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YpTFkfk9; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5cf2714e392so1308211a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 11:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707507613; x=1708112413; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=17oyzkB4xEUSVt+DktGPEZwkZ62rQj4myNkqahQjvb0=;
        b=YpTFkfk9LE7LjXC30X+m/dcf4SKqGoSU+mC6LyKn1tjdv+XBKoYvYjgpoKb4vV6p+j
         CAS6wv2BB5TK61nxl/bL6QeqUIrLgTZiR+fA+v7FOHln4NSm7i57XlbT//4IGFMF2Cs7
         q+y83+WhAgqeCRN81P/7DUSoZtod1uDmoQgLuH5+/0igKR6cUc8kVXrLWOKlodhRcpPs
         CESUlWlbqxp0qye6JpI/RfHjx/7Cz1SE3bg2fHvqdH/nZrTMITgOUkJPdTYomMLXrym7
         IDnGRPR14om7MR0asbiMnJZba9Lv+a3rVvYG9UQDI7IVVRMXEbiqxPPRw7C7G/A840HM
         LC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707507613; x=1708112413;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17oyzkB4xEUSVt+DktGPEZwkZ62rQj4myNkqahQjvb0=;
        b=sJuY7ZKwJr+C6Q3QH4/fq2YdEgjmntJIVuS/0Cuy48zwOR+Clytee5PhB1NAprz12T
         uAtyPSa6d+H59goq6niNCCRFVJsk/7GYYECQznL+D8JuyO9d+Cp0JO53LYLyYWXVi0OX
         6jjMZh04GNyfRM4E6YCRktkUwjqCSx0hE4bMkwelZLsQEHy1hmitJ7VK/fcw1C3IFHvT
         jRnmYwaWhqstprOLuOBlFnORS+ikcHTzSZ0AL0ivKdiFC5iykAO1jcE+0Z9AgishXB1R
         7I7W0BsHZqF3XJ1bNO+Lm5ickZuiGTGcMaF20v7frUkSNZyvZYMPqjOPX1DYIAmL82g7
         q57A==
X-Gm-Message-State: AOJu0Yzx/xpKLAwdJVOS/uHkDlHdsLDsi5fvAcElFxUpsOdBBu9Qgskt
	laKEqnQwwgBunVhUa7O+0bWMz5CbjxqyHbChJ7tyi53dQw6GXopjjRgYeSh1lDVo4/hole2GkzS
	gyg==
X-Google-Smtp-Source: AGHT+IEYqMT0SNTbGkgjXf0EJatqk8P6yv7iLn+6PgeWuWGZqraP/01ea/W8koFFPXxmnm6TihXTMgnPpMY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a02:305:b0:5dc:19c9:d794 with SMTP id
 bn5-20020a056a02030500b005dc19c9d794mr1603pgb.0.1707507613300; Fri, 09 Feb
 2024 11:40:13 -0800 (PST)
Date: Fri, 9 Feb 2024 11:40:11 -0800
In-Reply-To: <20240209183743.22030-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209183743.22030-1-pbonzini@redhat.com>
Message-ID: <ZcZ_m5By49jsKNXn@google.com>
Subject: Re: [PATCH 00/10] KVM: SEV: allow customizing VMSA features
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Feb 09, 2024, Paolo Bonzini wrote:
> The idea that no parameter would ever be necessary when enabling SEV or
> SEV-ES for a VM was decidedly optimistic.

That implies there was a conscious decision regarding the uAPI.  AFAICT, all of
the SEV uAPIs are direct reflections of the PSP invocations.  Which is why I'm
being so draconian about the SNP uAPIs; this time around, we need to actually
design something.

> The first source of variability that was encountered is the desired set of
> VMSA features, as that affects the measurement of the VM's initial state and
> cannot be changed arbitrarily by the hypervisor.
> 
> This series adds all the APIs that are needed to customize the features,
> with room for future enhancements:
> 
> - a new /dev/kvm device attribute to retrieve the set of supported
>   features (right now, only debug swap)
> 
> - a new sub-operation for KVM_MEM_ENCRYPT_OP that can take a struct,
>   replacing the existing KVM_SEV_INIT and KVM_SEV_ES_INIT
> 
> It then puts the new op to work by including the VMSA features as a field
> of the The existing KVM_SEV_INIT and KVM_SEV_ES_INIT use the full set of
> supported VMSA features for backwards compatibility; but I am considering
> also making them use zero as the feature mask, and will gladly adjust the
> patches if so requested.

Rather than add a new KVM_MEMORY_ENCRYPT_OP, I think we should go for broke and
start building the generic set of "protected VM" APIs.  E.g. TDX wants to add
KVM_TDX_INIT_VM, and I'm guessing ARM needs similar functionality.  And AFAIK,
every technology follows an INIT => ADD (MEASURE) * N => FINALIZE type sequence.

If need be, I would rather have a massive union, a la kvm_run, to hold the vendor
specific bits than end up with sub-sub-ioctls and every vendor implementation
reinventing the wheel.

If it's sane and feasible for userspace, maybe even KVM_CREATE_VM2?

> In order to avoid creating *two* new KVM_MEM_ENCRYPT_OPs, I decided that
> I could as well make SEV and SEV-ES use VM types.  And then, why not make
> a SEV-ES VM, when created with the new VM type instead of KVM_SEV_ES_INIT,
> reject KVM_GET_REGS/KVM_SET_REGS and friends on the vCPU file descriptor
> once the VMSA has been encrypted...  Which is how the API should have
> always behaved.

+1000

