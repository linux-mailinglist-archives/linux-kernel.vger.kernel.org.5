Return-Path: <linux-kernel+bounces-84429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AB286A6B7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E874B1C26060
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7C220DC1;
	Wed, 28 Feb 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzOej303"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580B12032C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088118; cv=none; b=sDGxqBLPjach3qPJzfejTM4uU9SnNKFuYLGv1sfbXl+lljAULS+MHbc8m7fYPyqAa0IeXiZeUTMFb8j80NPQfL+V31enkfQ9LRnUBf8aZVFurP++MkLKZo7ab3jEgy2DxSyw5srX2iNwS+nD1udhnuj4SeIp9gh9+3e2my+rxSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088118; c=relaxed/simple;
	bh=1Uryw7EIyGaADMbLf4vJNKsPqM+n7z9iSFQFR6i45EA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=P39aJS30NGrThQgaUhR8Q1FiabkCoSnRSPKvhRuEMRs3nw5es0IKWbuhFdq+d8XR1r6AX1cFzmG8AxfgqsaJqtNt/xzw9LjAff2SijS4en+5WWv75OQ5vXo5VaFL7pKf1hLIV7BkU9TyXeho+9QxvkQ13DPBCTG2Qt04h5d36js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzOej303; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso8087216276.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709088116; x=1709692916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/L3RUGH7+uAkBQWkVD/RBnetvTxq10PRbhVuv1Z2Es=;
        b=VzOej3036cWOSrvGRqAPgWv+JRFfg3UqbQbz7+hR+4Xemu0wsHujaiVIcyXVY5LpQ2
         wG3YWgkutM/LxE5TSOTdY9TH2uI8+2q1sjiH413EJVakMlLz7CKbb1nT8Aw5xxdzvtXH
         HF5SckaMUWXFu4RteSnflqvKLchokpKsoAzVqKsqbrh52AX0ZuE6A3jwjbFgQ5Fh78wp
         xaUO5yO4JBPBUG3+RT+tuZpv49+Zv4U5UU18fyx2HFXJGDRfUQaUcjGX5baSFYAT6Ufv
         xNo9SrKH2LJgLH/5MQPJaB0t2Z7bdnvJz/OzolCk7oDEfwOuviut0uKLmf2jyXodz9+o
         IJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088116; x=1709692916;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:reply-to:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5/L3RUGH7+uAkBQWkVD/RBnetvTxq10PRbhVuv1Z2Es=;
        b=VYz95Lyx+0U8xSp/YnO6UT6uHLzI9wjAeDSIfdXccz440X+2N5dEXaC5D9DBdXRoBL
         wFBdM2V3pE+dnvOezlg2XyS/+UY55L/w7umtjR1fYhtePLubZbOvM7aPIa16m4CFNoNV
         ZKng3BsZeAd++XeA7Ch8diBNoZw4dZR8ZKWsUxhiKK0ozJbW0X0JdMS5d8teRlLV5G8b
         lmtjwnTTq0xQ+XHBeFQx5lJ0hcc6364dRrI+CKeOZazLPeXoqoOew5rv+7pCY90pLyZJ
         VPxDh1xr4xNACe3DtxVRV6vuNPwXnHKqUPRZk6qs0qhR7EzoQLfTUKUF/3AgeNXOaTBs
         5S4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7+kYNMfn+sGyL2bFIBlQMklUz/ie5fKfuRHmlzd9wCRItvtDI5wT9M4HV44h4gt0YQ2rSt/AFy3cy6Qmap2rjswKaKNNrhJK16+Cf
X-Gm-Message-State: AOJu0YziJeKnur+zVkIzD60jJwpBOdxLbXwnEJXEI/gdaBP+o63parhD
	hSj1kd4WbbEE0hW4403IKDRhGnQrXBWqvkGswzl6YOZV9PQSpUJCHw61fv1voB00XOvzJHYY5Mq
	RHw==
X-Google-Smtp-Source: AGHT+IHHsJM5lRH1Wgjj5L2FJEo06HzdA8kv6SKdx8rA1dzoB6Dy3aQiZHQWtax/vHxL1ZgCk9HefZp45BM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1001:b0:dcd:b593:6503 with SMTP id
 w1-20020a056902100100b00dcdb5936503mr102444ybt.2.1709088116351; Tue, 27 Feb
 2024 18:41:56 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 27 Feb 2024 18:41:34 -0800
In-Reply-To: <20240228024147.41573-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228024147.41573-1-seanjc@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240228024147.41573-4-seanjc@google.com>
Subject: [PATCH 03/16] KVM: x86: Define more SEV+ page fault error bits/flags
 for #NPF
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yan Zhao <yan.y.zhao@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	Chao Peng <chao.p.peng@linux.intel.com>, Fuad Tabba <tabba@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Define more #NPF error code flags that are relevant to SEV+ (mostly SNP)
guests, as specified by the APM:

 * Bit 34 (ENC):   Set to 1 if the guest=E2=80=99s effective C-bit was 1, 0=
 otherwise.
 * Bit 35 (SIZEM): Set to 1 if the fault was caused by a size mismatch betw=
een
                   PVALIDATE or RMPADJUST and the RMP, 0 otherwise.
 * Bit 36 (VMPL):  Set to 1 if the fault was caused by a VMPL permission
                   check failure, 0 otherwise.
 * Bit 37 (SSS):   Set to VMPL permission mask SSS (bit 4) value if VmplSSS=
 is
                   enabled.

Note, the APM is *extremely* misleading, and strongly implies that the
above flags can _only_ be set for #NPF exits from SNP guests.  That is a
lie, as bit 34 (C-bit=3D1, i.e. was encrypted) can be set when running _any=
_
flavor of SEV guest on SNP capable hardware.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 88cc523bafa8..1e69743ef0fb 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -261,8 +261,12 @@ enum x86_intercept_stage;
 #define PFERR_FETCH_MASK	BIT(4)
 #define PFERR_PK_MASK		BIT(5)
 #define PFERR_SGX_MASK		BIT(15)
+#define PFERR_GUEST_RMP_MASK	BIT_ULL(31)
 #define PFERR_GUEST_FINAL_MASK	BIT_ULL(32)
 #define PFERR_GUEST_PAGE_MASK	BIT_ULL(33)
+#define PFERR_GUEST_ENC_MASK	BIT_ULL(34)
+#define PFERR_GUEST_SIZEM_MASK	BIT_ULL(35)
+#define PFERR_GUEST_VMPL_MASK	BIT_ULL(36)
 #define PFERR_IMPLICIT_ACCESS	BIT_ULL(48)
=20
 #define PFERR_NESTED_GUEST_PAGE (PFERR_GUEST_PAGE_MASK |	\
--=20
2.44.0.278.ge034bb2e1d-goog


