Return-Path: <linux-kernel+bounces-84055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29686A1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B55C1F2E390
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED0151CED;
	Tue, 27 Feb 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DUX70fav"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F514EFE1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069433; cv=none; b=ZglEmEtDz2PtWqZ1oTwFzJxBS/O1D0Kgd4JGLJnQpzHVfm/95TLUHU+lv68Wbkj21jctn3HWcCYl7NVVGqzuVFYJCKIp2/2eC6VqKhE6+lPa5stbSOyqXQTQtLl8KdPceg6j9G09Q/VscmRLT90UhGw+/NKy+/caqAgTq5Aurzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069433; c=relaxed/simple;
	bh=pYEtL1LENAwOGgUH2s4ntndLZN6SXZc/BAgEp69OOYs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TcjVI2M2TTeO9SAibVN4BUy2XpDA21flJzqyf2pS9m4cZ/t3NQJyCEz1e9QcxbF5B/vL//PxgDW4g6Mh04cfdlviCuAySxaNOOcjpwWZUGW+GYAEBdBESoPCmWY/tCU14lzYvGyIgk859dBg6yl7Bri0x8mRWfWRAmyVvD93YLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DUX70fav; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60925cacbb7so23032367b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709069431; x=1709674231; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BiLhRWlBWb+am2iEgrEdgOVU5le4qM5JlbZDBxZ2Je8=;
        b=DUX70favEb4LI+qq02RxZuXYPIeN+e+6+UcRGGNTssdUrDJsnP8PlUOQ+fgGvkMI5N
         YLzajNGt/j0sOHGvmRkztns+tUeymPtZdSyuvac7Fh449dcDZxvxRROXWrwUZMTzD27a
         yHS4Pvb9wG5tBwOGTM5pK+FgcuXZqeqU3l0P/h418co5DTK1GcKRmtKRQVqLIvev2JnY
         TpOL0PvW4+ol6soohtq94VoDc/I4KxjKdz1AliCIKd2aBg3S1cHNHyT72m0BVMlcAuwO
         VP8VooHtap0fXfLzq37HwDF/x0coPIaMhfDXkwTGyCfYRqpn58vJA3DnQsYaDZYNjf7B
         b7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709069431; x=1709674231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiLhRWlBWb+am2iEgrEdgOVU5le4qM5JlbZDBxZ2Je8=;
        b=sdwhf13xtotE2BEugN+BBLLKyPHdV59S7XrOxVrdQwlsO+ApKTczkII2op6vjb0oVE
         BEwcZ1gNTY6YnH3pYuw/sqwsQmT7IyUiGL+4lcAC3SFjyQ5NNXSukiIXrgXwMaGUQ+3m
         uLfZAJRynH8Fq1GZP4v7+Fh2h2Q5rQi6d+Mh0ltCn/pKNHp+g6Xt254k+6fnFW7xT4wE
         IoXBgbBd8MHQ77lPrBPPTWTSNnq92N5UIJI4+MNsfo8jPiRwc/Y7SHP1w6mBAboxqaRJ
         pfG4Uofmi4MjBzZJHJCoWlKlQeZ065S4TExy80H+bTNaSTfOkNIgbWs+0xeIIpHaQtj6
         P1uQ==
X-Gm-Message-State: AOJu0YwEsFfMRnKoeL6GY2me7WJt+pP/sFIseuzKFs13TzWoS50PeT26
	mqmgAVDASrMBxybx49s3IGcO//HGoLFjvEiY9QJectrWC3t2INU3OmmFBIzz1S18bOKvU+b81dk
	iaA==
X-Google-Smtp-Source: AGHT+IEsVcbgBeMscIwHllTsPaeKtX9AI8tlu8w0p7g8fFe/K/ym+PfroFIgpk0isSIhGHblduZI8+6IxqA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:188f:b0:dc6:e20f:80cb with SMTP id
 cj15-20020a056902188f00b00dc6e20f80cbmr31913ybb.3.1709069431295; Tue, 27 Feb
 2024 13:30:31 -0800 (PST)
Date: Tue, 27 Feb 2024 13:28:18 -0800
In-Reply-To: <20240213192340.2023366-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213192340.2023366-1-avagin@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170906349657.3809281.8603439312604083486.b4-ty@google.com>
Subject: Re: [PATCH v3] kvm/x86: allocate the write-tracking metadata on-demand
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrei Vagin <avagin@google.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>, 
	Yan Zhao <yan.y.zhao@intel.com>, Yongwei Ma <yongwei.ma@intel.com>
Content-Type: text/plain; charset="utf-8"

Added a few more KVM-GT folks.  FYI, this changes KVM to allocate metadata for
write-tracking on-demand, i.e. when KVM-GT first registers with KVM.  I tested
by hacking in usage of the external APIs, to register/unregister a node on every
vCPU before/after vcpu_run(), so I am fairly confident that it's functionally
correct.  But just in case you see issues in linux-next... :-)

On Tue, 13 Feb 2024 11:23:40 -0800, Andrei Vagin wrote:
> The write-track is used externally only by the gpu/drm/i915 driver.
> Currently, it is always enabled, if a kernel has been compiled with this
> driver.
> 
> Enabling the write-track mechanism adds a two-byte overhead per page across
> all memory slots. It isn't significant for regular VMs. However in gVisor,
> where the entire process virtual address space is mapped into the VM, even
> with a 39-bit address space, the overhead amounts to 256MB.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/1] kvm/x86: allocate the write-tracking metadata on-demand
      https://github.com/kvm-x86/linux/commit/a364c014a2c1

--
https://github.com/kvm-x86/linux/tree/next

