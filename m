Return-Path: <linux-kernel+bounces-19586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E1A826F3D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBA01C22731
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FA344C8A;
	Mon,  8 Jan 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a27UhlN+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8558244C81
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 13:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704719180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+8Lqj6hWE2i7R49OXd/zNqcjNcogl72LCJ21CQyGp4=;
	b=a27UhlN+Xfmoc2KimiJwrLF+y+s9dkgjYdEgBKUOW5wa5nfw4rEgDl9bqV196o+5dkcKIM
	5n43Mx2ZQe/zutsOVDQldeCXR4Z699i7sjEAvRibaP/t1ya7XCPL7XxKTShSyZ0nC8Yg06
	OcLWzlsxgpXqvfcawpah+VKXnuaqflY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-XJFem5jqMm6VoVxG_C9JFQ-1; Mon, 08 Jan 2024 08:06:19 -0500
X-MC-Unique: XJFem5jqMm6VoVxG_C9JFQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6dbfec8ee69so2050430a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 05:06:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704719178; x=1705323978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+8Lqj6hWE2i7R49OXd/zNqcjNcogl72LCJ21CQyGp4=;
        b=Gw7IwzT3UCh6o24hLAjTHUVbyvckHt5DEoLeoEzmkwksb6JsMy/YPp7BHpAE1BiPSF
         IEsO28OefZ1NF9qlAEQFWlJDyInrgrSHbM2OWA7iGEBFe07PtppRjR+ucCyZ8VeKs5q0
         huR+oqMlyBVk1HZx1QSK+lcWhEZrQNcFE8OxL8k9lFoQwueoVWC7Q7CW1fCfwDhIysNt
         /48yhcyNv3kCcg8++mpOH8iariGonZh70YNeQATI4EoeEXGyyoG9CXtRKTvbXFbFhUUh
         I2qUQ2OtBYceC4NgdK8M7dRGJvAWIY3xCJTf/ExLYVxxthfxAOICXq16EEU+xKPW6l4+
         xiSg==
X-Gm-Message-State: AOJu0Yyezu0WiU36IFyro9SwoZujMB/sJLoPsU9D3vWStjlTDtEeqQcu
	j+FS0WLFVZW2JkVDfYYrmWi0Ecygbmo3tIlYiTkc+HTrtQ5g2TiFwoabGlc6YSH6SAJ5yxJXVAH
	vlU2gVcj6JoSBEgIdUWS8puv/wueaJdkv4nLK6i9Hmk9wcgNp
X-Received: by 2002:a9d:6e18:0:b0:6dc:91b7:ca96 with SMTP id e24-20020a9d6e18000000b006dc91b7ca96mr3101772otr.6.1704719178407;
        Mon, 08 Jan 2024 05:06:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTBr19IZ9T5r+flE9vk3UxQSRnxjgnfuTD+WjZPThubQVoz63Ho4YxFtB3vHcJK/+dN/27gRc3emkbSLKGkoY=
X-Received: by 2002:a9d:6e18:0:b0:6dc:91b7:ca96 with SMTP id
 e24-20020a9d6e18000000b006dc91b7ca96mr3101761otr.6.1704719178214; Mon, 08 Jan
 2024 05:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104193303.3175844-1-seanjc@google.com> <20240104193303.3175844-9-seanjc@google.com>
In-Reply-To: <20240104193303.3175844-9-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jan 2024 14:06:06 +0100
Message-ID: <CABgObfavshc4VZAF0q+EjpXnkA4nVw8NSz_EvNt-iKxoFqgR5w@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86: Xen change for 6.8
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:33=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> A single Xen fix (of sorts) to let userspace workaround buggy guests that=
 don't
> react well to KVM setting the "stable TSC" bit in Xen PV clocks.
>
> The following changes since commit e9e60c82fe391d04db55a91c733df4a017c28b=
2f:
>
>   selftests/kvm: fix compilation on non-x86_64 platforms (2023-11-21 11:5=
8:25 -0500)
>
> are available in the Git repository at:
>
>   https://github.com/kvm-x86/linux.git tags/kvm-x86-xen-6.8
>
> for you to fetch changes up to 6d72283526090850274d065cd5d60af732cc5fc8:
>
>   KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT (2023-12-07 15:=
52:57 -0800)

Pulled, thanks.

Paolo



> ----------------------------------------------------------------
> KVM Xen change for 6.8:
>
> To workaround Xen guests that don't expect Xen PV clocks to be marked as =
being
> based on a stable TSC, add a Xen config knob to allow userspace to opt ou=
t of
> KVM setting the "TSC stable" bit in Xen PV clocks.  Note, the "TSC stable=
" bit
> was added to the PVCLOCK ABI by KVM without an ack from Xen, i.e. KVM isn=
't
> entirely blameless for the buggy guest behavior.
>
> ----------------------------------------------------------------
> Paul Durrant (1):
>       KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT
>
>  Documentation/virt/kvm/api.rst |  6 ++++++
>  arch/x86/kvm/x86.c             | 28 +++++++++++++++++++++++-----
>  arch/x86/kvm/xen.c             |  9 ++++++++-
>  include/uapi/linux/kvm.h       |  1 +
>  4 files changed, 38 insertions(+), 6 deletions(-)
>


