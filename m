Return-Path: <linux-kernel+bounces-21502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F14829082
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDC73B2607A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BB47F6C;
	Tue,  9 Jan 2024 23:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0GbSmzp"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9A447A76
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ee22efe5eeso48123577b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 15:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704841398; x=1705446198; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=1kUdagJS0RkwSIGsouIbjCNUHXTtDF8gUa99CW8Gru4=;
        b=f0GbSmzpYP+33Jvp0fC6ebWL69OIh1Zmrq0XRjXlFYhxzSAknu5Tvy7H97AW7P/lVV
         mJvZJG2gsBo1F3g5dQgJOCeWCcN8Sudi29YVi0YsqekdniDOj6ZKXgEkNpw5mpRNBvER
         AYrL6gptOBEle8pzG1fUzKtApkdo62DkMVMNqvRxTO1KkfJ3Su9QhZKFvuH0s3I9qMo6
         n7qDRZSD70opkx4ZpcCbz4oYkLrdJ1gx4ApRQUbUetgQFX7tqjQDPOxxCXr46CV6XAZT
         8Kpj4Alxaz1I3Wi0t5zHKHTaZ6HyxXjaGWTFqZt5t/6iWQDsh6oiJb5nYm7fi8REoN70
         F4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841398; x=1705446198;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kUdagJS0RkwSIGsouIbjCNUHXTtDF8gUa99CW8Gru4=;
        b=qnu1QUGMWhFJoDLSFqTvmwQvn1W3CmBdwvZMxJ13CUQVsTu+fxwXyE1hNFJTTSq/SG
         9WQMpzwvtpxIUqQpy8oo34YmddBpnNnUJhmzShRT5lP+n+svEflRe7QDE4X3bDH4KQDu
         UBRjdjx0wXQOiY/ENBhwhKmhDhjLvXVze24rsrn3UAfJDxF5eCQ2LBvGRPaNqgJo6vtr
         VhPyLhnm4dSbZknBnhjU99fkwLKV7tJFFPTBfJvguck6bejntCauM3f4dGqbfRQttTQ8
         D3Uh8f5CIOpuCdGdWxl+YDMWRJSzRNbEnk5CvwDmUYk91h+SyJD49IhouOqfszi4Qslm
         JWJg==
X-Gm-Message-State: AOJu0YxJirli+QP0pkm/yRIM0yyw5+e1v496uvwp3MhEeNAiM0FLicov
	qu0s62rId5GX8Q/ck0USy88gpjwol/6XKJP0Hw==
X-Google-Smtp-Source: AGHT+IFsXlkZ/mWbUUU9rSMx5+slIt6MS5Dp98xqW8gbGhoVNbmoxfLEh3pqfw8x0zQGWEJxxkp/3+iECYE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8211:0:b0:dbe:387d:a8ef with SMTP id
 q17-20020a258211000000b00dbe387da8efmr5333ybk.1.1704841398399; Tue, 09 Jan
 2024 15:03:18 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 15:02:33 -0800
In-Reply-To: <20240109230250.424295-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240109230250.424295-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109230250.424295-14-seanjc@google.com>
Subject: [PATCH v10 13/29] KVM: selftests: Drop the "name" param from KVM_X86_PMU_FEATURE()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Aaron Lewis <aaronlewis@google.com>, Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="UTF-8"

Drop the "name" parameter from KVM_X86_PMU_FEATURE(), it's unused and
the name is redundant with the macro, i.e. it's truly useless.

Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 932944c4ea01..4f737d3b893c 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -290,7 +290,7 @@ struct kvm_x86_cpu_property {
 struct kvm_x86_pmu_feature {
 	struct kvm_x86_cpu_feature anti_feature;
 };
-#define	KVM_X86_PMU_FEATURE(name, __bit)					\
+#define	KVM_X86_PMU_FEATURE(__bit)						\
 ({										\
 	struct kvm_x86_pmu_feature feature = {					\
 		.anti_feature = KVM_X86_CPU_FEATURE(0xa, 0, EBX, __bit),	\
@@ -299,7 +299,7 @@ struct kvm_x86_pmu_feature {
 	feature;								\
 })
 
-#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(BRANCH_INSNS_RETIRED, 5)
+#define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED	KVM_X86_PMU_FEATURE(5)
 
 static inline unsigned int x86_family(unsigned int eax)
 {
-- 
2.43.0.472.g3155946c3a-goog


