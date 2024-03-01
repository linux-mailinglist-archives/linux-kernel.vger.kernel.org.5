Return-Path: <linux-kernel+bounces-88514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57286E2B9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6547B22F48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C049570033;
	Fri,  1 Mar 2024 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6mXlCCM"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA16F535;
	Fri,  1 Mar 2024 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300824; cv=none; b=CVXvTHF7sb9kDeuHr0ZDUVdlmtaFrTWl79kV5gMHklZ8Q/jmCeKMJZzP1HmUfSAuCHxSOC72Vqg4Gev0v2a1GJ/sS1iFPViOfc7cqq90Zg0hnaitAxt/rj85Q6dVPkETbu7d3qqXJE+5W/mA/YeOT8tgZXCqfWjnumI/MXkcU4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300824; c=relaxed/simple;
	bh=vOW0UB9ncHeY6Hu9BHeSk0oc30qDNRInvrcsREBGnFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR+8lJtLwnNWSxumTxXxaRUrp3671lwUtsqUIf0vvH6Wn+9G3y5fV4ou1P6LCcb4nsHL9WJHzDrpn4mAsjlkBNbInyG1RFta7bmIS40scJySVPztLDVCzXm+gjytDPTpQj08i2l3n4+6gfNB+9K37O82wn0qg9abHr41nXOlswM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6mXlCCM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56648955ac5so2987710a12.3;
        Fri, 01 Mar 2024 05:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709300821; x=1709905621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDm5k9rOGj0cj/KUk66W2xhuESI746YZPYTqLDHnmNc=;
        b=g6mXlCCMT0ypylCZNy3m3eHnuxWE9Q71CzA2RfMAWWu4wMANKGbHTFcY0JUtgH3d0M
         7+e5irAnmYaqh2+Co8RleIEDh65IEx4l/BwAIu5SMAgQJft6TJmp3Cygqb6ZKbmsGDH2
         ZXYcF+XDCgHy0wAOqtz77UtDVbt71uJFoGlEpSO//inhMG35CDOOdYUEwPWNC4b1mjq5
         0XLHMe+vE4hQV0F1Lu/RlYrzQFOTPB7nmv3mXQ8gVvjIiGEYAn8Z9myC2XaJyI5Fdd4j
         gQWFLTxVuBY69p0/CatNMzkfgn47G3t9UB9boy9gepdJg7LBVpL0JWQf9Y8K762ou7ev
         tdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300821; x=1709905621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDm5k9rOGj0cj/KUk66W2xhuESI746YZPYTqLDHnmNc=;
        b=hQEdDL63MecmxgZT936FSf4Lx3gOdrEPIP72mjFkC52djMAYsWwkr0dgvcv6yhyb3M
         gc8M4YgLVweWqxDZdNn1aIHqyfn3mfIacYKZfsV0MsRONMuQo4k0DvP24bgguAu3voWg
         gafE2WDVPicEt6rYxFg7JP1CPc6wZsRtJGGWRBYUBnuaWHKte/kkpP2P4+MnYAp6hr15
         xMmAe9bZJQYJSKRpMU+0BozB40P/vZYnuqOKR+vEWf3CUXJJVYp/44W0rv3FKYkyxI6n
         T8H5r6feHDZoYfoUaq/abTDeBchvnkbwBWTs+24/02SHoglmzumgYvGmYSmA8GWI7YKl
         X8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUn623tJ0OOA7msP7YR2JBtlwODqMXNKNtjFn4bmpFN5sgfXTueBpEjJCl6vgZ0M6cFesu2dw1fR+y+QDEixbKLj67UBsvadNE6MsVbazgQJgSDv6G7i+WeUiesYvt3aWL48KfOM4QcWaGYj3MagMlQHB3eCAMbiAqODpNysD2EwWFm
X-Gm-Message-State: AOJu0Yx+knNEsu+iAFOUplPCknz3h9cnesLp271Y+LnWNkVr6jAk3Yyn
	/l6BtwXEK2IeGHknXnquuTTSyQl4dnpNdn/NzMzXeEfiBuy4S7u0Alo8y7HKJD4=
X-Google-Smtp-Source: AGHT+IHpGK8EdKBk4bALZ/3wCj3KPRWoqvuxFz9QwQe5xWxU3WyGvVi8cVQ5EReSVPw5LqYyjjR7hw==
X-Received: by 2002:a05:6402:5c3:b0:565:7edf:41b0 with SMTP id n3-20020a05640205c300b005657edf41b0mr1356102edx.6.1709300820610;
        Fri, 01 Mar 2024 05:47:00 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id fj10-20020a0564022b8a00b00563f8233ba8sm1584107edb.7.2024.03.01.05.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:47:00 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 3/3] docs: submitting-patches: move backtraces to patch description
Date: Fri,  1 Mar 2024 14:46:37 +0100
Message-ID: <20240301134637.27880-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
References: <20240301134637.27880-1-lukas.bulwahn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The top-level structure should basically be along the temporal order of
things: Prepare a patch, Post a patch, Respond to review, Send reworked
patches, Be patient before resending.

For that, content from the canonical patch format needs to dissolve into
the pieces along the temporal order.

Move the subsection on backtraces in the canonical patch format into the
'describe your change' section.

As we would like to keep backtraces as a subsection (maintainer-tip.rst
refers to it), let us add another subsection in the 'describe your
change' section and turn the title into imperative form.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/submitting-patches.rst | 47 +++++++++++---------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 37925cacc5cc..584bcd8638ea 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -130,6 +130,9 @@ instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
 to do frotz", as if you are giving orders to the codebase to change
 its behaviour.
 
+Refer to URLs and commits in common style
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 If you want to refer to a specific commit, don't just refer to the
 SHA-1 ID of the commit. Please also include the oneline summary of
 the commit, to make it easier for reviewers to know what it is about.
@@ -197,6 +200,28 @@ An example call::
 	$ git log -1 --pretty=fixes 54a4f0239f2e
 	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
+.. _backtraces:
+
+Distill backtraces
+~~~~~~~~~~~~~~~~~~
+
+Backtraces help document the call chain leading to a problem. However,
+not all backtraces are helpful. For example, early boot call chains are
+unique and obvious. Copying the full dmesg output verbatim, however,
+adds distracting information like timestamps, module lists, register and
+stack dumps.
+
+Therefore, the most useful backtraces should distill the relevant
+information from the dump, which makes it easier to focus on the real
+issue. Here is an example of a well-trimmed backtrace::
+
+  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000000000000064)
+  at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
+  Call Trace:
+  mba_wrmsr
+  update_domains
+  rdtgroup_mkdir
+
 
 Style-check your changes
 ------------------------
@@ -742,28 +767,6 @@ patch::
 See more details on the proper patch format in the following
 references.
 
-.. _backtraces:
-
-Backtraces in commit messages
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-Backtraces help document the call chain leading to a problem. However,
-not all backtraces are helpful. For example, early boot call chains are
-unique and obvious. Copying the full dmesg output verbatim, however,
-adds distracting information like timestamps, module lists, register and
-stack dumps.
-
-Therefore, the most useful backtraces should distill the relevant
-information from the dump, which makes it easier to focus on the real
-issue. Here is an example of a well-trimmed backtrace::
-
-  unchecked MSR access error: WRMSR to 0xd51 (tried to write 0x0000000000000064)
-  at rIP: 0xffffffffae059994 (native_write_msr+0x4/0x20)
-  Call Trace:
-  mba_wrmsr
-  update_domains
-  rdtgroup_mkdir
-
 .. _explicit_in_reply_to:
 
 Explicit In-Reply-To headers
-- 
2.43.2


