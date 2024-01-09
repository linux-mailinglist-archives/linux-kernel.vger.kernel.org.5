Return-Path: <linux-kernel+bounces-21456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DAA828F61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6DF9B23712
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF54D3DBAA;
	Tue,  9 Jan 2024 22:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRDxdm9z"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A63DB86
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f874219ff9so29145187b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 14:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704837784; x=1705442584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrVZv+MUJLeYZ11n86dHXoyW3l+lTS8ohIoWXN+hW7A=;
        b=bRDxdm9zpsUrdNtxEu4dXTtEoVsRF0sjcwM22OjC1maLrPT19fOeFtD9pIXM3lrBvz
         w8gZLiP6XOwc44bD6nopEEfG6w9TNzkMeY/6nw4sEKE9OgCUnVoMvRbvL8G4w+vfTxHa
         BnhdZNXkicF6m/AWQ6dPCf6+K6g66AfDPzaNJCPM6vZHRgGFSUmVLjIfn/ETWNFihEvf
         qurh3103ci6nmo7UVeWBwEHpH0lPMtXjMuYsNndWfA68DOjsUi7T8d0NILfOoCFAitNi
         aV5so06p4+XNlC7OHl5o0SoaupESh3f2a/q8DpweCtjQZlBM6aSlwePOx8vF6Q31Vs6s
         FM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704837784; x=1705442584;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrVZv+MUJLeYZ11n86dHXoyW3l+lTS8ohIoWXN+hW7A=;
        b=ec33hEMaTIhfJU7ajrqmZwe5+xXra01w1futSfTzWSG7SNGp5Q+nKodYn0vwyLTtm6
         MVi4tuY8QGX2c2R/6zUz9/DdU7lVtUpCfxZrbIm1nv9MnBDCfltkE7rGxoCQyBp1j4SV
         tyz/qMBmRX7APfLcW4/dfyeWq3wyUJ9OzdEfeZD1T72GuFa4DUpqbYOEzdDZKEWDvWNd
         vidMm/bQmQgDt+Zai+5n3jS4hbu2FCsjI9Z1mVq6R4rx1SauF7rltopNbsU16Pld6ZDz
         3bbJ0TAoyY3pbnClrFLDl02C9EYMHwCAg7/53PgPNTT/8cY33BzijYLKCOuAVuSxZTpx
         pg/w==
X-Gm-Message-State: AOJu0YygpPfF01lH7sVbF4VFCVlL0hPb21JWqAXEzMi2IVlckj2LzATb
	QrG6xGFkvWs1sthRE6yH9QHJzrSkWgRL3fspkw==
X-Google-Smtp-Source: AGHT+IGQ6JSiSvkBHs+zj9h5i2g6UpszdWvJQeKMwoZF0FHD3plsI1CEe7cxVkt/AMMKZi6/6Ei4tRUeoXk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4483:b0:5e5:ff2b:3945 with SMTP id
 gr3-20020a05690c448300b005e5ff2b3945mr84393ywb.1.1704837784802; Tue, 09 Jan
 2024 14:03:04 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Jan 2024 14:03:02 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109220302.399296-1-seanjc@google.com>
Subject: [PATCH] KVM: selftests: Delete superfluous, unused "stage" variable
 in AMX test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Delete the AMX's tests "stage" counter, as the counter is no longer used,
which makes clang unhappy:

  x86_64/amx_test.c:224:6: error: variable 'stage' set but not used
          int stage, ret;
              ^
  1 error generated.

Note, "stage" was never really used, it just happened to be dumped out by
a (failed) assertion on run->exit_reason, i.e. the AMX test has no concept
of stages, the code was likely copy+pasted from a different test.

Fixes: c96f57b08012 ("KVM: selftests: Make vCPU exit reason test assertion common")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/amx_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/amx_test.c b/tools/testing/selftests/kvm/x86_64/amx_test.c
index 11329e5ff945..309ee5c72b46 100644
--- a/tools/testing/selftests/kvm/x86_64/amx_test.c
+++ b/tools/testing/selftests/kvm/x86_64/amx_test.c
@@ -221,7 +221,7 @@ int main(int argc, char *argv[])
 	vm_vaddr_t amx_cfg, tiledata, xstate;
 	struct ucall uc;
 	u32 amx_offset;
-	int stage, ret;
+	int ret;
 
 	/*
 	 * Note, all off-by-default features must be enabled before anything
@@ -263,7 +263,7 @@ int main(int argc, char *argv[])
 	memset(addr_gva2hva(vm, xstate), 0, PAGE_SIZE * DIV_ROUND_UP(XSAVE_SIZE, PAGE_SIZE));
 	vcpu_args_set(vcpu, 3, amx_cfg, tiledata, xstate);
 
-	for (stage = 1; ; stage++) {
+	for (;;) {
 		vcpu_run(vcpu);
 		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
 

base-commit: 1c6d984f523f67ecfad1083bb04c55d91977bb15
-- 
2.43.0.472.g3155946c3a-goog


