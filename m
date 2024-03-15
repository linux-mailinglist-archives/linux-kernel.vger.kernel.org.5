Return-Path: <linux-kernel+bounces-104356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7687CC8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965271F21E3E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C28C2C1BF;
	Fri, 15 Mar 2024 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="k2dDmT9v"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7C1E4A6;
	Fri, 15 Mar 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502747; cv=none; b=aKTXB4Sz5gU1sG+Y9Z4K3PzFZTdjtuRVKLDcW4zaEl10Hl2fusgFOs7eg8qWJs9SyFleA9g4Ba1QAlhkNMto+4IZQgevhTRKRy7MeAi9cD2Q4a9IkZ4ywOFFSizZONsXDdp/Tdc29Ztr3MOjLxms4F4JhgW+TIaRcqp95TsiVnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502747; c=relaxed/simple;
	bh=SGbM8zfCNboFS2Tv1SvFRCpvBhbIOFnNPOkzkFdW9ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hOEk1B5LCe64+d5AnRJXN7oouuPdX7GiGEaVWnSoLW1Lky0VzjKAgg5ezfuxYFsiJXc4ZiJqRioHI40WjFVqypAwcwJeWeeWl+SAgwdHeCl/VNm+XQ+v06CANloqjMB7hHJdMbv934I3wwqZI9uwuF6gqbZPsdazFZrFqsM3tT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=k2dDmT9v; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso2537206a12.2;
        Fri, 15 Mar 2024 04:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502744; x=1711107544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4o/PLmolwqQui1v9BtbvmoTXcWRlKh99YDBIUOT6h3E=;
        b=k2dDmT9v2Bdn6jke46j+uNxkDTh/Mr+IhcLuDl03QMAaRSoXjG9pDBdhcmxEQTeyOu
         0AinhVKuvrukGvuwa4b4AbaH1lEub4DlbG1ek4rYL3xF4nLH6bMfKiB7uUuPZ7Cd6Ybs
         L+U+IjO2asxdHDg0RuoLHpsR8mxycp8bV32vzmJqAejs5RN0M54Fzt8rd8f/DYP0STMj
         gG1s8ptPKGKYgaEqb3eqVLI+q30UU9L50/cZ33xmhAIwdwS68P76ZpsQ23badgtDKonZ
         YW/kiEBIRfFBVT/ylOf3HbxXMBHGgM6k0ylrvXh+ZdJFBLAJXuHSWAUSo12kawZpx8Jq
         c3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502744; x=1711107544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4o/PLmolwqQui1v9BtbvmoTXcWRlKh99YDBIUOT6h3E=;
        b=hRYXihg0VJwAa25vsKZMVDRK0vpkUC8nAxLPaDvKDGxPl5nqNYv9fAcygzdBA6sit1
         ReDKONIcrvmOFqa5UrOzRCdQ+56ZS81A4pGGsx1i9mPytdRdpSLy3z1e6pDUTfe1mu/i
         pMKvuYvGg0rWO/yo7/6YPtNG/kobBXn4JZL1rwALY8BR7qVCLzYt2TMzpbuch/3rw1pX
         wilQ054lmSucrvPQX6qxUchR16/F5Aft5oyHm8el0jh9ygi8cJD0vAopt3bPVyfOLZYz
         0WnDgSMQNDhmOkIKHzuyUK0/IvRuDlVhYlMy4zBHjsPgygG7qIHv1kkrIhE4ReuNxGDV
         f+ow==
X-Forwarded-Encrypted: i=1; AJvYcCUeI4KufGjOTsA3SbKaYwFcYFge8MZGVr0cclQA+508NiR+2Fo7HdHPHDGB/s1XGND0SPankAgs7nQyo4YZsIbuu/65pgj7TQ0gp5fCTJsLZAAF+og9bDEAIrnMJag1c/w0
X-Gm-Message-State: AOJu0YzUQfs9fnaV7q79hEBZYMr9pB6LBND7q28dfukRQeo0hgLfMEi8
	qs+abMT2Ssb1fvvwyG7aPyGWiVKyHRx+Gl1zMpDEMO0J4ANZSKSMXwHJEHDDShWphw==
X-Google-Smtp-Source: AGHT+IFssJXK7fUBhPEWYJ4FZnZi94EshcyFHVKx/OmG5S34CCy31+hNK0pm83Gmc3J2FTlMeFZ6Yg==
X-Received: by 2002:a05:6402:3981:b0:568:9b13:77fe with SMTP id fk1-20020a056402398100b005689b1377femr3968225edb.37.1710502744061;
        Fri, 15 Mar 2024 04:39:04 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:39:03 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 07/10] kernel: use new capable_any functionality
Date: Fri, 15 Mar 2024 12:37:28 +0100
Message-ID: <20240315113828.258005-7-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
v3:
   rename to capable_any()
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 39a5046c2f0b..645ab8060407 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2257,7 +2257,7 @@ __latent_entropy struct task_struct *copy_process(
 	retval = -EAGAIN;
 	if (is_rlimit_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
-		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		    !capable_any(CAP_SYS_RESOURCE, CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
 	current->flags &= ~PF_NPROC_EXCEEDED;
-- 
2.43.0


