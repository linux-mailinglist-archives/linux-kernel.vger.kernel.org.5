Return-Path: <linux-kernel+bounces-88513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D2886E2B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1F628C72B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9E56F517;
	Fri,  1 Mar 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIRWvoZI"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11F6F506;
	Fri,  1 Mar 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300818; cv=none; b=Ufm8EvC7sUC9DZYREl1rvVrqQiOhtKMJq0a1ISM0EJXlUUy7sXu2hMHMO9QuHpyVZDPtI50Ppl4u62vRmhJR9HWpPxIJGx7Qih51ADrZLx+22FPy6qqvyr7zqNy4q+Ap6lZ84sa5fd6/Uxucin1POKzQeOIjiD1rHkUr7KIcTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300818; c=relaxed/simple;
	bh=g9uDef4vVL6k6nFEC5av3vPwaQXbIVgn1scOl2YNKpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jUR8rLZZ9rxl1d19z4ObIOrDBqGc4CloQOk5AQ0fK/e36qLZzmepUl+vAMpcmvvuZNPw6zGBHB2kMAjKJ1itcozeWWHtkO5+oP3Sz1CtNACDSih9duS2wFE5pOCY8RsUa4lK1ywKJnmsVJdy9GktmzNN39J54wapkWEdKzTZioI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIRWvoZI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so2936150a12.0;
        Fri, 01 Mar 2024 05:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709300815; x=1709905615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv07MvdmzdWImM+lzkVs9nrKyyN8RT3mxKng/XcK/HY=;
        b=lIRWvoZIiR/VxwHoe+nl7qWe84tjQKi4WMRbHCyTEJKjlR2US25lV7yGVR6W/aulNa
         jD3qH0r8aNvhLq4r8pRY7tS0AW9vI/MWmxT92bzOawexTRmp72UIxkYsMySaLQ/Ite3P
         yfwRn2WKCAnpkTXMkTsOLrpqTKsqukU/+wJQxRG/YgOxKgdIVAUaO35W6VIwXFOPIgiE
         hEGq1aDW9ioHjYNddDNW1EHrUqQy7b/r6xpudRwdFc/2V//pfdTv6pOYbXamQvB7+UqX
         fG/SkowulRAeRk1DFywEl6de4YL0sYlh6lhKL2PRSNVeUx6WFn24YBOv74rJ7YATsH/n
         nD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300815; x=1709905615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv07MvdmzdWImM+lzkVs9nrKyyN8RT3mxKng/XcK/HY=;
        b=dEBX3n7rn363uxlSKBc2UjPw8VTyjottvlN6lDswbNdrDzY0AtZzqiO4Okx4ySu7fM
         HHkcnFFjtsChUWecr29pVYaWuHidPcqvxyz2PzOeDoA0FPux7YufBqWfThMRco6S2VI7
         HlL9PQagJ2j+QY4X+BLDF40fjTv7KV6jdboB5UfIPLmOpHB/eE+Vy/NGFNZtL9youChC
         ubSiE6g7ZVVnLVEuviEEb4CEel372WvBw5d3aDqwnnFdpVMdmKn3TZ75WJNQEjBygqpl
         xZoAa7C2AHtFAE3aGauJvbfIdWyxXW6LhInEoarIqDaEycqtt4WQBGQV79geeHQX8pbR
         MjCg==
X-Forwarded-Encrypted: i=1; AJvYcCVMNeft6dkxcUZq89Vr5YqztQtOA1JwUWC7HIv0hosMhSIwrRpL+JS8nAopQjl1jvqoKVE7MK4EVBSBjAF5aKyhbrzWHHFBIfeqVFJDjw6vu2XyN4rjGmdg8JUQGs8zj/tpOzzRmWLztIWxJOthAkH4DSw6+VWRKKD8TfadGJg/P+vX
X-Gm-Message-State: AOJu0YxV5/UnoFP5b1+1cF7/Uzuf14orWro/sMgrK8m/g7MnOhUJzoKG
	AjrFBvGsa/+ELJL0RaB9EC4VboTpCJDvVgMiOm5D16/PtgK5GVjq
X-Google-Smtp-Source: AGHT+IHCvM2X9fjICLt7870wldgQLiFxsPnygAKRDst4ldsRl4n46dNl2RH7KiE4VeuMdmjRKuHecw==
X-Received: by 2002:a50:cac7:0:b0:564:ded0:6072 with SMTP id f7-20020a50cac7000000b00564ded06072mr1322911edi.1.1709300815510;
        Fri, 01 Mar 2024 05:46:55 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id fj10-20020a0564022b8a00b00563f8233ba8sm1584107edb.7.2024.03.01.05.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:46:55 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/3] docs: submitting-patches: move split_changes before describe_change
Date: Fri,  1 Mar 2024 14:46:36 +0100
Message-ID: <20240301134637.27880-3-lukas.bulwahn@gmail.com>
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

Start bringing submitting-patches into this clear temporal flow.
Move 'Separate your changes' before 'Describe your changes'.

Note that this is also the order in 5.Posting. The same content is there
covered in Patch preparation and Patch formatting.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/process/submitting-patches.rst | 68 ++++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 2ec0c0d7d68f..37925cacc5cc 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -40,6 +40,40 @@ patches prepared against those trees.  See the **T:** entry for the subsystem
 in the MAINTAINERS file to find that tree, or simply ask the maintainer if
 the tree is not listed there.
 
+.. _split_changes:
+
+Separate your changes
+---------------------
+
+Separate each **logical change** into a separate patch.
+
+For example, if your changes include both bug fixes and performance
+enhancements for a single driver, separate those changes into two
+or more patches.  If your changes include an API update, and a new
+driver which uses that new API, separate those into two patches.
+
+On the other hand, if you make a single change to numerous files,
+group those changes into a single patch.  Thus a single logical change
+is contained within a single patch.
+
+The point to remember is that each patch should make an easily understood
+change that can be verified by reviewers.  Each patch should be justifiable
+on its own merits.
+
+If one patch depends on another patch in order for a change to be
+complete, that is OK.  Simply note **"this patch depends on patch X"**
+in your patch description.
+
+When dividing your change into a series of patches, take special care to
+ensure that the kernel builds and runs properly after each patch in the
+series.  Developers using ``git bisect`` to track down a problem can end up
+splitting your patch series at any point; they will not thank you if you
+introduce bugs in the middle.
+
+If you cannot condense your patch set into a smaller set of patches,
+then only post say 15 or so at a time and wait for review and integration.
+
+
 .. _describe_changes:
 
 Describe your changes
@@ -163,40 +197,6 @@ An example call::
 	$ git log -1 --pretty=fixes 54a4f0239f2e
 	Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the number of pages it actually freed")
 
-.. _split_changes:
-
-Separate your changes
----------------------
-
-Separate each **logical change** into a separate patch.
-
-For example, if your changes include both bug fixes and performance
-enhancements for a single driver, separate those changes into two
-or more patches.  If your changes include an API update, and a new
-driver which uses that new API, separate those into two patches.
-
-On the other hand, if you make a single change to numerous files,
-group those changes into a single patch.  Thus a single logical change
-is contained within a single patch.
-
-The point to remember is that each patch should make an easily understood
-change that can be verified by reviewers.  Each patch should be justifiable
-on its own merits.
-
-If one patch depends on another patch in order for a change to be
-complete, that is OK.  Simply note **"this patch depends on patch X"**
-in your patch description.
-
-When dividing your change into a series of patches, take special care to
-ensure that the kernel builds and runs properly after each patch in the
-series.  Developers using ``git bisect`` to track down a problem can end up
-splitting your patch series at any point; they will not thank you if you
-introduce bugs in the middle.
-
-If you cannot condense your patch set into a smaller set of patches,
-then only post say 15 or so at a time and wait for review and integration.
-
-
 
 Style-check your changes
 ------------------------
-- 
2.43.2


