Return-Path: <linux-kernel+bounces-15691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B415823056
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF4DB23767
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C71B26C;
	Wed,  3 Jan 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="UOvxH07p"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8B1A71B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a275b3a1167so601337666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1704295109; x=1704899909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x58X07zwjYU7cKHRzjg4ENbbksPJOwVkc9czaYIAXnY=;
        b=UOvxH07pTHjYyCTYEc8kC4SXBKwnARlAPqx1Nkn45nBsttkklzlnQO0vGSUk0+iaNT
         XHBsFqr5bZ9Yh4TdxrNsDnINDC/4iMWizyiIiCHVuSq0qV56hS3CaHVHaYpdYZqDfEhq
         4d7PU6gaOTkho3Fa582w1pyi1hU2arSLSYDG0/bkE2Iss+JvQFoiywFkHQquXmo1eiiT
         hI2MF8Y55UI/rWQO5NI9uykbqEjIyiMrIIho6dtTe9KvpONBs50OwyBQqorJK7nUbAcc
         TCznmPdQdKfT0zsQ5aGAzy2zdtkZvzd48mBuMEuRIprCLvA3zNisA9JFQaa4oIinwHpZ
         wRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704295109; x=1704899909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x58X07zwjYU7cKHRzjg4ENbbksPJOwVkc9czaYIAXnY=;
        b=tWf6ZdjQHEqnipBtKXiERQdazsuCT0FFD/N44b/r8c1DW7alq0qV65OD1irlW3nqA3
         4lrQdUNxK61ixrfYkvemQeiP0tX4N6Ke1zO7atcTLVvSISv+FJWEyDRCEwMBHETFnDE4
         0Z2geWStmYA9D0FbMgTmLzabshEfFHCv0kjH1buonO4Vw2GFmoP94K4PoKuaSGZXxwgm
         Bqgin4xo7fYu+01o+XNQqwGCvh4QkqB7Fk0UxVma04XlUm2hskUmMcg5vEldrrs/bOJl
         5gcA4IIZWqR0AejTLFf8tBjjVxXeZw5OK1uG5NIcpSVYPt96Uj5w6igyeNqUxt7lBgz5
         a/fA==
X-Gm-Message-State: AOJu0YzPsKiDVkPtwFdg6VEiA6HenaVHhtB34m/MIhWTVvfL0oXNXlWm
	FqBzCkC4f5SQBL33iaYFljx592NvjIBXwQ==
X-Google-Smtp-Source: AGHT+IFvaCr1M0YJt2eVUUY9JaIAd7GjOQgEzJfEemGQkJ002T1Rf88/GWTw0XzPMNRZwYC3tYhoyw==
X-Received: by 2002:a17:906:52ce:b0:a28:ab0b:fb56 with SMTP id w14-20020a17090652ce00b00a28ab0bfb56mr392021ejn.106.1704295108657;
        Wed, 03 Jan 2024 07:18:28 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id ez21-20020a1709070bd500b00a26ac88d801sm12144793ejc.30.2024.01.03.07.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 07:18:28 -0800 (PST)
Date: Wed, 3 Jan 2024 16:18:27 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	KVM list <kvm@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: Re: linux-next: Tree for Jan 2 (riscv & KVM problem)
Message-ID: <20240103-d2201c92e97755a4bb438bc3@orel>
References: <20240102165725.6d18cc50@canb.auug.org.au>
 <44907c6b-c5bd-4e4a-a921-e4d3825539d8@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44907c6b-c5bd-4e4a-a921-e4d3825539d8@infradead.org>

On Tue, Jan 02, 2024 at 10:07:21AM -0800, Randy Dunlap wrote:
> 
> 
> On 1/1/24 21:57, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20231222:
> > 
> 
> It is possible for a riscv randconfig to create a .config file with
> CONFIG_KVM enabled but CONFIG_HAVE_KVM is not set.
> Is that expected?
> 
> CONFIG_HAVE_KVM_IRQCHIP=y
> CONFIG_HAVE_KVM_IRQ_ROUTING=y
> CONFIG_KVM_MMIO=y
> CONFIG_HAVE_KVM_MSI=y
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
> CONFIG_HAVE_KVM_VCPU_ASYNC_IOCTL=y
> CONFIG_KVM_XFER_TO_GUEST_WORK=y
> CONFIG_KVM_GENERIC_HARDWARE_ENABLING=y
> CONFIG_KVM_GENERIC_MMU_NOTIFIER=y
> CONFIG_VIRTUALIZATION=y
> CONFIG_KVM=m
> 
> Should arch/riscv/kvm/Kconfig: "config KVM" select HAVE_KVM
> along with the other selects there or should that "config KVM"
> depend on HAVE_KVM?

We probably should add a patch which makes RISCV select HAVE_KVM and
KVM depend on HAVE_KVM in order for riscv kvm to be consistent with
the other KVM supporting architectures.

> 
> 
> The problem .config file causes build errors because EVENTFD
> is not set:
> 
> ../arch/riscv/kvm/../../../virt/kvm/eventfd.c: In function 'kvm_irqfd_assign':
> ../arch/riscv/kvm/../../../virt/kvm/eventfd.c:335:19: error: implicit declaration of function 'eventfd_ctx_fileget'; did you mean 'eventfd_ctx_fdget'? [-Werror=implicit-function-declaration]
>   335 |         eventfd = eventfd_ctx_fileget(f.file);
>       |                   ^~~~~~~~~~~~~~~~~~~
>       |                   eventfd_ctx_fdget
> ../arch/riscv/kvm/../../../virt/kvm/eventfd.c:335:17: warning: assignment to 'struct eventfd_ctx *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>   335 |         eventfd = eventfd_ctx_fileget(f.file);
>       |                 ^
>

Hmm. riscv kvm selects HAVE_KVM_EVENTFD, which selects EVENTFD. I'm
not sure how the lack of HAVE_KVM is leading to this.

Thanks,
drew

