Return-Path: <linux-kernel+bounces-122323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5488F535
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45D71C22360
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DE52C183;
	Thu, 28 Mar 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPbDV2NR"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E12577B;
	Thu, 28 Mar 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711592514; cv=none; b=P111kFpHcmw4lykJw06h50elbLAuQqKrhuLCZB/anAQN5B8CfAR6m9VFNTLLtB3NxiDNPEGaPIAJkNruoSvJsOFRw6J2NI0gHLlJBAZs4QSLohOCu9CBiCOK+Dzwi1URVnGflIPd8DmpvOa01CFe2d6Xp1/TtuIOAtH1I/+w3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711592514; c=relaxed/simple;
	bh=hzzBRWdiGWuG8Yb90Fydca7wDueo8i9XUKGhs113zKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYPJg4G74O3LqYXdoK5RZ27pthefeyTmoS0Bxxf8DT/LBiWw7Vs2NtOX6j1CpBxXBJBRL9zetuVUpvpg95ACPv9PkW7v8mHokrNKblcdSSn7e5STUdkHuOicLrthT4F+1ZRF1AeP1pYjoqbaKdJM8yYSawLV0A6T78gLSKvmYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPbDV2NR; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c3aa9ca414so337618b6e.2;
        Wed, 27 Mar 2024 19:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711592511; x=1712197311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wwjh6A6RPtwgIFd2DAl8tZSZOuIYbO20aM3+8bN09j0=;
        b=XPbDV2NRMGdp86z6MR7NqjNgSzDddQluvzuwI2kZGGoq48jF60zxAvFhZoNr/CgrC9
         02KyVIobUZkyhKUVjHO8lvasFAOlpuiZdvQxnicSrUoMgBCDV6qoChGZ+1TsjXIzF4k6
         eD/jxXYZ+kI7ZWLZxi2t/NdzZcWad/W2o+MHUEc/IDxKnhMbL7QGnRPi0v+UX9TH/CX+
         CGtTlyUwuOBa/8DAqzkI9CcZGCCCboq8F4MhtEjCq8+6USynQaz3PI/hN6aAYBVnau0A
         nExnOJRP3al4np1XfxAgFhAI5Xtvp0PoVsDeT7FK0Zltp2YBgXoSNpFHxBt1Nd49qDsi
         6jTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711592511; x=1712197311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wwjh6A6RPtwgIFd2DAl8tZSZOuIYbO20aM3+8bN09j0=;
        b=fCynmHN/VKmdOW4AxnH8PqWWwLsHt77k/tGnHBoSTpnGHDGUzsqICs4HdonxvKnfL1
         GcyrB4SDQ168DAfAivBkQ8HYxbPmzgxSmLyQnJALsx/s6j2oTXewlo1a5uOI+73zh26s
         AnGrIpbtVOcoyMVwWPOLMaVJT7OU94Cg72qa4tM6MzpGO60b2zLKQS1k+d2ypsxfA0Ib
         66KJ+yt7voYzZhk/nGMd1xGczkv5DvA2NRtT7nxnpDTZZJkNPe7kRu4hMRppkW809T53
         Tofr16m7TBLKZSof8ZCaxU5J/iP0120B93CpmvyO4VUFUILIrKufSfnQJv3sekgimsX2
         pgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsMQ1g/Y+AOc3iKZJ/XYawo5vq1kw+zXCQzOSiqB+fnUAoLGmC6Kpi5MyzCzoMVAxgXdyIAq1I1yVUTwoPcSAYWw3P25+R81eLbPtPC5Rdl/EodBGn8MEL5EuXDSyQ1thn+ed8GRTfalrGQdrWfuIxT9aJtxE/gvKFltRAL5Ut1iVY
X-Gm-Message-State: AOJu0YwrXUy8gsxMb7l1CCVLv/JpmLLAV/ncfS5uIcmh7ypiOj9njiUX
	TlQcpOEnVhJEKkINrOJKabv4efiogBZrI9TK4UHE9a2eNenb78XfJmFirxiZ
X-Google-Smtp-Source: AGHT+IG+k1TbDM0JQQJtIvL1iIb/EIijiTg8zJCF0jCKvFhoxZ3hhcIi6FgUhucwopKJh/COAKh6Zw==
X-Received: by 2002:a05:6808:2217:b0:3c3:d372:c3c5 with SMTP id bd23-20020a056808221700b003c3d372c3c5mr2135403oib.19.1711592510953;
        Wed, 27 Mar 2024 19:21:50 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b006eac233f5c2sm228113pfo.127.2024.03.27.19.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 19:21:50 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-doc@vger.kernel.org
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
	v-songbaohua@oppo.com,
	workflows@vger.kernel.org
Subject: [PATCH v4 0/2] codingstyle: avoid unused parameters for a function-like macro
Date: Thu, 28 Mar 2024 15:21:34 +1300
Message-Id: <20240328022136.5789-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

-v4:
 * fix Xining's email address, s/ma.xxn@outlook.com/mac.xxn@outlook.com/g
 * fix some false positives of checkpatch.pl
 * downgrade from ERROR to WARN in checkpatch.pl

 Thanks for Joe's comments!

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

 Documentation/process/coding-style.rst | 16 ++++++++++++++
 scripts/checkpatch.pl                  | 30 ++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.34.1


