Return-Path: <linux-kernel+bounces-21615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DCE8291F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3821C23C5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9E17C8;
	Wed, 10 Jan 2024 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j1Dq/0sU"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35DE81F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb46770d7so4566339276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704849336; x=1705454136; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mORrEHldp2qawKkikf9wfX27vt6z2DPQ9oCLXkJKW8A=;
        b=j1Dq/0sU3fi7kMu99PU9AsJyFwxIKVtslB3d+bqQb7WIPf/f/pIA33ykBOWUFs94bq
         mGff7EpnhIOUPcx7k4lIaBx+po8G63fh/eQX+hWdIzR2WKlXCOBmhZUC7c5TWXLJnkbF
         RUjZVE4lYOe/5Ur3MkbYhvcdOHLGjf9WzQzh7TkaDyPC5qVdpHd/KCYmCdFI08XBVXhZ
         5MXuVsDMfGEul2/kKyuQwPXsTMAmWTUBiuFRMJq8o44/BZAU1pTafn2vIB9ajnP5RtgK
         uS0qO/VVnJQSWpy9qzehqFqtnE/GIRdjXUmiwb8nMF/WGO/H2TDyasBiWyVsbW2K/fR/
         ar3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704849336; x=1705454136;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mORrEHldp2qawKkikf9wfX27vt6z2DPQ9oCLXkJKW8A=;
        b=u+Pk/2LMQUBUDRV1bUvumZLAZOEbWHU73kafM8NWa2qu3d4tJxnR+6C0p8PWF2QsWV
         vH/C3tr8xwLZH9oBqb0q4TSLXGmqyjvypU75Gjd3YukG7ydAboZagTsxD9OT9pCZmArd
         6T54x6aigyMNUqFXGG45Bc5xUfF2rVKUqCl0vlywChSSznNNS3RyqchMCNw0WZb0bW2w
         jnSETI935HqpzPbnG9t7fm32cSRJpdS4KOJzhiwNruwXl3ZvUN2WFhshLga6iorXglQc
         JSInn7xCHbnpWVW401OifOVs2PG7owu/RShzAMvT7Jjy26oHl6KrfViO1ixlOZ5rVvnq
         rprw==
X-Gm-Message-State: AOJu0Yz4NZ4CPWzOlDxdbGKv09sRrrjTjf/+z+R3llQIfgRhRjdBKhrF
	EnyOC2409UOy+JJrfg56CAGdHcVyMpmmo2R/7g==
X-Google-Smtp-Source: AGHT+IFH/3iIKuhgJURtlanPFm1lyxsjMB85egFxSZXFz5VcqFxHpgjXvUYrMgAahsBcBHntAZu8fNpdp6o=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1348:b0:dbc:c697:63bd with SMTP id
 g8-20020a056902134800b00dbcc69763bdmr99703ybu.0.1704849335881; Tue, 09 Jan
 2024 17:15:35 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 17:15:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110011533.503302-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: Async #PF fixes and cleanups
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Fix a use-after-module-unload bug in the async #PF code by ensuring all
workqueue items fully complete before tearing down vCPUs.  Do a bit of
cleanup to try and make the code slightly more readable.

Side topic, I'm pretty s390's flic_set_attr() is broken/racy.  The async #PF
code assumes that only the vCPU can invoke
kvm_clear_async_pf_completion_queue(), as there are multiple assets that
are effectively protected by vcpu->mutex.  I don't any real world VMMs
trigger the race(s), but AFAICT it's a bug.  I think/assume taking all
vCPUs' mutexes would plug the hole?

Sean Christopherson (4):
  KVM: Always flush async #PF workqueue when vCPU is being destroyed
  KVM: Put mm immediately after async #PF worker completes remote gup()
  KVM: Get reference to VM's address space in the async #PF worker
  KVM: Nullify async #PF worker's "apf" pointer as soon as it might be
    freed

 include/linux/kvm_host.h |  1 -
 virt/kvm/async_pf.c      | 79 ++++++++++++++++++++++++++++------------
 2 files changed, 55 insertions(+), 25 deletions(-)


base-commit: 1c6d984f523f67ecfad1083bb04c55d91977bb15
-- 
2.43.0.472.g3155946c3a-goog


