Return-Path: <linux-kernel+bounces-6341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98785819777
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017F72884A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB94C121;
	Wed, 20 Dec 2023 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjnGVK7V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E594ABE5E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbd9abdfaf6so413460276.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 20:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703044863; x=1703649663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RfI9o+sdacyJamab4VjillVwnGfP6Fsc9NLEUsg0Lgg=;
        b=JjnGVK7VT8hVKI3X4A5AYRUn7/fLNA/2V5vERbyvTTYFjCLPwIHNaEw0sotD8g9IZJ
         moGvDCBJs1qKzzEPCWGLuSf3bf1+6vA3tYzFXZhqmyA2s0buAlJiZDJ94o/vvaDJoNjI
         Ax32abNkiDpl47oo6dPzldfN4ndZMUZmcumyj5I0voONcW6BTmO7VgZR1omUoGRGtHGl
         jsR5o0J7VRtm2QpqUhi1QU2QdcFf6LtfYm1YDtlj2S5VQmh3TB53DJ8HDVkJNRNMgcx5
         YNdCECp/TPDEfBcvwL6Eh1kUnHR+0VYz2CzluXGH7zXhUKaqBgvdk0oSjX7QI39eps26
         ON2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703044863; x=1703649663;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RfI9o+sdacyJamab4VjillVwnGfP6Fsc9NLEUsg0Lgg=;
        b=qYeKqX31E29Fq0p5dKBy+0eOLkliFIF7Aza1u87ZNYFLC/5xm7TFu8fzx+GUXdmqbo
         4aIxRE0Md+Nb5GjTBF1HfWJ4uCLlSzmC+0IU7IQEExxUvJ4Zo4kpIoNcmaoa8r1jll9W
         nV94lw0FBecmvKXOLT9v4Oy8mJkGaun3nTFa7omhyxbD28bPLdcsPUG6JrliSZBJwSqA
         Lx8a+zBT5xrvfoNdsVBFJPOe3Q3oz8Oin/2UppgItRdmGy8UZSuHT9EDe09PYywWVepl
         wv2Ln7/hAonQrZxgrZIS4xb9VY2JVhfKJZP7sdIVvcEZU70DXvcRZ98sfqyLVTsI8vor
         vX0g==
X-Gm-Message-State: AOJu0Yxo+7kRELkMQX47uRin1Aqiguy+sF27Cxj5FgG3N9phql5myArn
	nTVaH3qLrLIveWeSU4HkV+iJmuhcvScx7A==
X-Google-Smtp-Source: AGHT+IFCSzZn60eF2tPq5Ty4bdq4uMHXhhsxaUp4ogQAlGqyyg+0Ty4tPmUq952Nmq6077HnESZxoyUA+KCbJg==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6902:343:b0:db5:f536:17d4 with SMTP
 id e3-20020a056902034300b00db5f53617d4mr2527722ybs.11.1703044862876; Tue, 19
 Dec 2023 20:01:02 -0800 (PST)
Date: Wed, 20 Dec 2023 04:00:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231220040037.883811-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 0/4] mm/mglru: Kconfig cleanup
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, yuzhao@google.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

This series is the result of the following discussion:
https://lore.kernel.org/47066176-bd93-55dd-c2fa-002299d9e034@linux.ibm.com/

It mainly avoids building the code that walks page tables on CPUs that
use it, i.e., those don't support hardware accessed bit. Specifically,
it introduces a new Kconfig to guard some of functions added by
commit bd74fdaea146 ("mm: multi-gen LRU: support page table walks")
on CPUs like POWER9, on which the series was tested.


Kinsey Ho (4):
  mm/mglru: add CONFIG_ARCH_HAS_HW_PTE_YOUNG
  mm/mglru: add CONFIG_LRU_GEN_WALKS_MMU
  mm/mglru: remove CONFIG_MEMCG
  mm/mglru: remove CONFIG_TRANSPARENT_HUGEPAGE

 arch/Kconfig                   |   8 +
 arch/arm64/Kconfig             |   1 +
 arch/x86/Kconfig               |   1 +
 arch/x86/include/asm/pgtable.h |   6 -
 include/linux/memcontrol.h     |   2 +-
 include/linux/mm_types.h       |  16 +-
 include/linux/mmzone.h         |  28 +---
 include/linux/pgtable.h        |   2 +-
 kernel/fork.c                  |   2 +-
 mm/Kconfig                     |   4 +
 mm/vmscan.c                    | 271 ++++++++++++++++++---------------
 11 files changed, 174 insertions(+), 167 deletions(-)

-- 
2.43.0.472.g3155946c3a-goog


