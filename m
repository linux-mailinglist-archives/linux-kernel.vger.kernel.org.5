Return-Path: <linux-kernel+bounces-22292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56EB829BE9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EFA7284DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE8495DC;
	Wed, 10 Jan 2024 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTVN1lrL"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4D0495C5
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6d9c7de04d0so2826700b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704895165; x=1705499965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qLF+8HQzMDDK3mYkGACeVLM+vDBicJwXAByQZFsnG0M=;
        b=eTVN1lrLwvmSKGhDVIMSEdvSRkyQVFrrfBSTSO0eaqJbWjrOe5q8QmfrTw3M4PmwJw
         mBM+ffgZQX1d5iI3YERmGM9sWXRYd9WO7S9g1qm+CKwiHlZ7pj/FYH3B/Amsp+OhJpyQ
         p/hOf7flOSDVJ5mfR4vFRVhu0hl7ZA53Lc1V9vvqQrvvDnK1H35sw2WVnL0wOJdIycfh
         A2QOAzAFWbB+RziO/MJ75Vxg20ceLDaNrIq1v5qv+QcAIhNKV+lam4IjXAO1dHHd9ddT
         kQz5ua1R6NJ4d21qYMhKH73rvNkNpaiTdR2bQ8t77UK+8c5CT/UiNa2PYhyDZPZn7+wB
         MBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704895165; x=1705499965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLF+8HQzMDDK3mYkGACeVLM+vDBicJwXAByQZFsnG0M=;
        b=gP9+kfOay9t6Zlzb4EPPF2fKuWCJcalnrBSd/shQ7lYoFsQvdlY5o+ujk+eNzSi8WA
         yZlQguvmDeHhnClsAe9y+Cn9CGmRTmdrhUhdDPXvKhHyD1oByp1dYffWG0+xWT8pEEA/
         JelF+gQ9mBhc8hi2NRDlJRu6O5QF6jwVAI454prnUjcFj1/KFbeiRkeUwrmY9vKZCg0W
         xQwArZK13R+YyI8x1olNrv/RHPwq9KEQJOswBvfaEpxG4HcV+b9g198v+sz2ZhFom0R+
         LYeLZVpIa7+OEu4vn5PILv9CEBtKHOiCyQqmjE/oEf/dzMoAIr/ikLvuWq3bIfbrMGEY
         IquQ==
X-Gm-Message-State: AOJu0Yz6o220lJwazaR0KCp5NUjQYHbyVc5nQoNZBtA8/ONY52BGSEkz
	qSAceC7LQcwrzBvFYEmyVUqBCC0mDIxFfl1Ehw==
X-Google-Smtp-Source: AGHT+IH62EkYn+sCR2h06kpZrY1KuHvf0XMA2N71BfsD8CyPfiV0JJtXO4sAsikSwGY9cwSTn44cMo4xano=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:887:b0:6da:83a2:1d95 with SMTP id
 q7-20020a056a00088700b006da83a21d95mr136621pfj.0.1704895165332; Wed, 10 Jan
 2024 05:59:25 -0800 (PST)
Date: Wed, 10 Jan 2024 05:59:23 -0800
In-Reply-To: <ZZ3+8N3lUtmmwS0T@linux.bj.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240110002340.485595-1-seanjc@google.com> <ZZ3+8N3lUtmmwS0T@linux.bj.intel.com>
Message-ID: <ZZ6iu5v_nAYtrz7K@google.com>
Subject: Re: [PATCH] x86/cpu: Add a VMX flag to enumerate 5-level EPT support
 to userspace
From: Sean Christopherson <seanjc@google.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yi Lai <yi1.lai@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jan 10, 2024, Tao Su wrote:
> On Tue, Jan 09, 2024 at 04:23:40PM -0800, Sean Christopherson wrote:
> > Add a VMX flag in /proc/cpuinfo, ept_5level, so that userspace can query
> > whether or not the CPU supports 5-level EPT paging.  EPT capabilities are
> > enumerated via MSR, i.e. aren't accessible to userspace without help from
> > the kernel, and knowing whether or not 5-level EPT is supported is sadly
> > necessary for userspace to correctly configure KVM VMs.
> > 
> > When EPT is enabled, bits 51:49 of guest physical addresses are consumed
> 
> nit: s/49/48

Argh, you even pointed that out before too.  Thanks!

