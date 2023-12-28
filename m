Return-Path: <linux-kernel+bounces-12847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F681FB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B81E2865C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D136E1171C;
	Thu, 28 Dec 2023 20:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eja/+ae/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67DE111A0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e54d40cca2so40809207b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794187; x=1704398987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeRpHv3Rhilh+EuNYr3bORiW/nxnS2Awjr3v2Rkry9o=;
        b=Eja/+ae/XJcxuLTLIZmeaQ+OPV2QONh46htJCpY7l0ArQDois0UVMNqr2I/kpidJ0D
         l97e9PPfR45+RMCGsdBnxwFMxs6rpaPOKm08gy9c+xGzHYn+nMPEKkJd/AuuCQ2VQRk8
         cxtLQMhoQD1djjBE7a017GIe7mU9CUC4LVT6g20w2Cl0HyMXWpz8BVi7EoyPxFKPL/bZ
         3oO/9L47u6vqw9Ivcc9Cd/RIo8oujj3Ot1WnumMMAq7EvwqaTd561PvXlTvnJXhbNpUk
         bBaS28FpYo1CjkCadNhWqe0DaKZFZrJNE1skLypOw8wYIlDLW17y5QEZwscMX8fj1mIb
         OZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794187; x=1704398987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeRpHv3Rhilh+EuNYr3bORiW/nxnS2Awjr3v2Rkry9o=;
        b=CCC2VM7uEqnKL/vP/T+AyXFqVGSMj3ENpn87vDui0WxM8l+T+1y+LoR2TktJs7LI9I
         EYPJdw+P5GTsDLLO4St529/35PrvCdYXbStfWEP8nwS7fP0asdKYVOo016xEjBfngOrt
         XJfhgNMpZB6o92Ufa9FzOX+Jtj2cY0IUwdaGuz+5HZYHteJ9PcN1cvXETP2ocpbWUj5s
         nqhraYlD0meWI/dGfAVA/jL9RrK5XK0q16gMlAvNheWCHBuPPT+Ks+uk1omO1arwmLa8
         4L7bDRxWQoaxtY4QHjQjTQUlpAo2a228a+CiHW4F2umlOFleRbV/UMZnTeI2xWw2s0hV
         5T9w==
X-Gm-Message-State: AOJu0YzdwWIX2p9vknAliY3rFln3P28+2ehUqjxVhO6Du4EatYBJvK3W
	cO3haqtlGlNReDEXwEB7DSo=
X-Google-Smtp-Source: AGHT+IHcbFk05w6SJYqvEuo5VRQtvdXG7sZmGKgqL+yYU9vmUaxJMjyDmh/gtRJllpF5LyxL0d18VA==
X-Received: by 2002:a81:c603:0:b0:5ee:f221:326f with SMTP id l3-20020a81c603000000b005eef221326fmr1132194ywi.58.1703794186968;
        Thu, 28 Dec 2023 12:09:46 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id d13-20020a81ab4d000000b005e71fbbc661sm7657164ywk.143.2023.12.28.12.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:46 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 6/9] lib/group_cpus: drop unneeded cpumask_empty() call in __group_cpus_evenly()
Date: Thu, 28 Dec 2023 12:09:33 -0800
Message-Id: <20231228200936.2475595-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228200936.2475595-1-yury.norov@gmail.com>
References: <20231228200936.2475595-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is called twice. First time it's called with
cpumask_present as a parameter, which can't be empty. Second time it's
called with a mask created with cpumask_andnot(), which returns false if
the result is an empty mask.

We can safely drop redundant cpumask_empty() call from the
__group_cpus_evenly() and save few cycles.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 lib/group_cpus.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 72c308f8c322..b8c0c3ae2bbd 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -259,9 +259,6 @@ static int __group_cpus_evenly(unsigned int startgrp, unsigned int numgrps,
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct node_groups *node_groups;
 
-	if (cpumask_empty(cpu_mask))
-		return 0;
-
 	nodes = get_nodes_in_cpumask(node_to_cpumask, cpu_mask, &nodemsk);
 
 	/*
@@ -401,9 +398,14 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 		curgrp = 0;
 	else
 		curgrp = nr_present;
-	cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk);
-	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
-				  npresmsk, nmsk, masks);
+
+	if (cpumask_andnot(npresmsk, cpu_possible_mask, npresmsk))
+		/* If npresmsk is not empty */
+		ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
+					  npresmsk, nmsk, masks);
+	else
+		ret = 0;
+
 	if (ret >= 0)
 		nr_others = ret;
 
-- 
2.40.1


