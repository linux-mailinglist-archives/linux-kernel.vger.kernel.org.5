Return-Path: <linux-kernel+bounces-126390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA88936B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 03:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC014281E1B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 01:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1C220EB;
	Mon,  1 Apr 2024 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/aOAOGP"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED3B137E;
	Mon,  1 Apr 2024 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711934508; cv=none; b=hMAzbtVvXw6rbGa83sSMB3gV5/JtY+68KbsJ3/LSjRgMR06HE29y0T2fhNwljAgq05stwq18R4751gpmn58riHjh9lThdjZPC2HJf1RyrzMCvsh3514QU3C6PFZzn7nRaY4A5LNWLSpmz6YTl4TKYgjvAzmz8u1bsanMeXohfvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711934508; c=relaxed/simple;
	bh=unzQm1turv5bj8RHF2YAVrF2BvkUneIVqzFMMTJHDrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SmofF/gUB5vRnG3NkSYm6xub/4ED6Roh9TrSYwsw0GLu3eqFCbe8bfm8q5KMdamm2kHCApulO13wyuLSyH4cka+Jqk8m+onTIZiQDr953dxGhn2jbGyN69YbT8ssGrOyadwlDSspvc9qmiMFVXc0hc4DPXInkzn26EMUnL/Fr4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/aOAOGP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1df01161b39so31348995ad.3;
        Sun, 31 Mar 2024 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711934506; x=1712539306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBa7l+CzOA9jnCnr5oQ88KbLKn50a8/qLNlk9spk4K4=;
        b=J/aOAOGPo07wNVQ0zk/Chikke6uKf3gomOF8CDM+GGhN6h/37yqCnRvwVL2ZIcpCtT
         jpYOrU88uxWXL3UwVdMiuo2B8PLqlB431uRgkBu3uZw77Gx3JZRpT94JRgNROjdwc3Ma
         Kq0TAQB23pBRd/zjErry+Owv6IytCPqDqbGwpoUoSJr1/m5I60C8FVjb/xKayfe5sHhw
         t+Mfz2raFNGeEQpsLP6uyXWexTrGd8HeKwEEdzK8DF1anRi0FzivC+G6UTh/XvgyZBPg
         XND6HtnaTLrCMBl+boBHse3VyP3V2a/jJ729VTE0uQMEwo6/DSMvXaQgFo5QBoUFvzgK
         urgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711934506; x=1712539306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBa7l+CzOA9jnCnr5oQ88KbLKn50a8/qLNlk9spk4K4=;
        b=Dfq45cYaJ1KoatY2imWCTahTG39w6563jbrOAdjWuqSK86XB8cYfLZDQ8/LlF90Yhj
         4IePqbvEBu5wr5bG0PL+Q+S/4bN2imUSKDcSDy9giVQ37XOdLq2MF7RmYYbx35LHjhMz
         Hsz3SoyhWjRG8XIzdOTtI8MR+XP2Cqb4pWXt7Hia8dBvk8EkyDbgrk9/qla90/CSFULm
         bO+YcEb0Y8cXZEGmRBaCHbh5j1e/P0Mu/dTHElfrL9i6bIH97tv3tkbNBE7UYHiHBh58
         DPD7yZ7QYYgghE56CvT6UIbupIBmemOrQBVSVMDZsn4gp4Qg/IJSoj2Chm2e2R1BrS0p
         /JVw==
X-Forwarded-Encrypted: i=1; AJvYcCVykBahek7lfsWXkM8Y8UWnY55eQ1EwIU0PsXmVcDaG1QctMHE0F2J3l8MhJEoxv09y/eS3QCfumMatp030Aaaw4X9jKs8YXtZUh4geSFn8rKUoTFc88OzlpNbOaCvqEEiYWVw+kHdM5QGp3afzzAU5wuub0mKVFsHFFUBqD2IAJafp
X-Gm-Message-State: AOJu0YyGweuEJf1DdYNsOnWR3dMW3zvf6SisHRD5GZVw/si2Vq12H/wG
	sJj3DlPUdZ2zZbjjLF3220L2j0L0M5oqzmXLy6pJwW8Gyst/jIGt
X-Google-Smtp-Source: AGHT+IHmIxvo43OOmyfOAVdqDuy6BSASt8f117b0FSV57RrYjDj0pj9zT2UhiM2M3+7qByKKb0XsJw==
X-Received: by 2002:a17:902:e94f:b0:1e2:306c:32e3 with SMTP id b15-20020a170902e94f00b001e2306c32e3mr12866334pll.2.1711934505953;
        Sun, 31 Mar 2024 18:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id e15-20020a170902784f00b001dde004b31bsm7694357pln.166.2024.03.31.18.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 18:21:45 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: apw@canonical.com,
	broonie@kernel.org,
	chenhuacai@loongson.cn,
	chris@zankel.net,
	corbet@lwn.net,
	dwaipayanray1@gmail.com,
	herbert@gondor.apana.org.au,
	joe@perches.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lukas.bulwahn@gmail.com,
	mac.xxn@outlook.com,
	sfr@canb.auug.org.au,
	v-songbaohua@oppo.com
Subject: [PATCH v5 0/2] codingstyle: avoid unused parameters for a function-like macro
Date: Mon,  1 Apr 2024 14:21:18 +1300
Message-Id: <20240401012120.6052-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v5:
 * Simplify the code for Patch 2 according to Joe's suggestions.
 * add s-o-b of Barry according to Jeff Johnson

-v4:
 * fix Xining's email address, s/ma.xxn@outlook.com/mac.xxn@outlook.com/g
 * fix some false positives of checkpatch.pl
 * downgrade from ERROR to WARN in checkpatch.pl

 Thanks for Joe's comments!

 v4 link: https://lore.kernel.org/all/20240328022136.5789-1-21cnbao@gmail.com/

-v3:
 https://lore.kernel.org/all/20240322084937.66018-1-21cnbao@gmail.com/

A function-like macro could result in build warnings such as
"unused variable." This patchset updates the guidance to
recommend always using a static inline function instead
and also provides checkpatch support for this new rule.

Barry Song (1):
  Documentation: coding-style: ask function-like macros to evaluate
    parameters

Xining Xu (1):
  scripts: checkpatch: check unused parameters for function-like macro

 Documentation/process/coding-style.rst | 16 ++++++++++++++++
 scripts/checkpatch.pl                  |  6 ++++++
 2 files changed, 22 insertions(+)

-- 
2.34.1


