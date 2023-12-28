Return-Path: <linux-kernel+bounces-12844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE3881FB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDCC286518
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F310A1D;
	Thu, 28 Dec 2023 20:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6qTVTvP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EBE10950
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5e7467eb93aso40915817b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794183; x=1704398983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZXxoyrdPME2Vm14lDGLzixuTAYKwkD/pDvmny1lU3w=;
        b=f6qTVTvPQ9p3f2VrmgZNP5CSz1wdgcEriZ51p7lkhAEACQfjIceDNaZt4en6IfQVLy
         GFcRTPL6qda5sKU/DCBbxaSHrARmMP2I0ug1xjrFCLvjgSLeXdt8A2RRM/BbdDVzpfyl
         tf5//xiBBYsVoLNp0VVrAdY7Q9bEthvZvpdUHwO+3O9hZYBOR+7wTkoJCHVHz/+mVCWP
         CyyI87QDVRCNWVAF71GUdz/tj3O+kr2tV8ivkQqrdnceMIs43ekaWpejoFPf2/ZgoK6X
         mYge7sv7BVaf4/sLuOHP9eVWvJL5lbV9b9tXH+WcTD3L57w664/D+2qoMDP5rgWW6bsQ
         KXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794183; x=1704398983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZXxoyrdPME2Vm14lDGLzixuTAYKwkD/pDvmny1lU3w=;
        b=c2RXw+uUDM3tf6/gBu4n1PEH/mg7xOiO31P47YGmEji9CcO1G76KZuYZj+3qoRMLrf
         9pXchiCrDRcSF4B8jiaakv3XHH1blEqYPJlDm6YDKJ01eQHRlWc6ikif4QEX6uRV7KQp
         2DT8bbJHyGWw2rIrd+kGCAl1Omg/JYu9k2RMvrHj0UWXhENPQE2WwxVNztSEByA2z0vx
         0a1wOKo22YI2Ya9UQcS5CcqPhy1HpM9Qdh6rBvD8AFBfVXbI975b/sUq4rjpK0pbLfC6
         +YzX9w3ZtN75sX6uE+whrd0xv3hoYJsuUZro6Nqfxe8u3gvefo5jp22qJHGDcxp1kOmD
         OnlA==
X-Gm-Message-State: AOJu0YxcgldXAMCsDexmc2FGpJ36zFEXkRKmN9lAqsVurXgRI2P7KdjH
	wsvN5cEtPxu5hd5XEH8ApJs=
X-Google-Smtp-Source: AGHT+IHK+WvFUJwAhNJSbh8vOeu0A2orn641t053fR5bpXBgUUW8PuXjjIX63e66VFNzLoWJUKfmAQ==
X-Received: by 2002:a81:de0d:0:b0:5ee:7299:e2cf with SMTP id k13-20020a81de0d000000b005ee7299e2cfmr1564530ywj.52.1703794182867;
        Thu, 28 Dec 2023 12:09:42 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id l17-20020a814011000000b005ed71d004b5sm2887863ywn.62.2023.12.28.12.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:42 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 3/9] lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
Date: Thu, 28 Dec 2023 12:09:30 -0800
Message-Id: <20231228200936.2475595-4-yury.norov@gmail.com>
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

Because nmsk and irqmsk are stable, extra atomicity is not required.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
NAKed-by: Ming Lei <ming.lei@redhat.com>
---
 lib/group_cpus.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 063ed9ae1b8d..0a8ac7cb1a5d 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -24,8 +24,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 		if (cpu >= nr_cpu_ids)
 			return;
 
-		cpumask_clear_cpu(cpu, nmsk);
-		cpumask_set_cpu(cpu, irqmsk);
+		__cpumask_clear_cpu(cpu, nmsk);
+		__cpumask_set_cpu(cpu, irqmsk);
 		cpus_per_grp--;
 
 		/* If the cpu has siblings, use them first */
@@ -36,8 +36,8 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 			if (cpus_per_grp-- == 0)
 				return;
 
-			cpumask_clear_cpu(sibl, nmsk);
-			cpumask_set_cpu(sibl, irqmsk);
+			__cpumask_clear_cpu(sibl, nmsk);
+			__cpumask_set_cpu(sibl, irqmsk);
 		}
 	}
 }
-- 
2.40.1


