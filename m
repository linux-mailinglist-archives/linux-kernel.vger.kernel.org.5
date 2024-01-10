Return-Path: <linux-kernel+bounces-21825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 367AD8294E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94F81F24EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 08:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6D3DB85;
	Wed, 10 Jan 2024 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnZ7Geak"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF23EA74;
	Wed, 10 Jan 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3b84173feso7685995ad.1;
        Wed, 10 Jan 2024 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704874339; x=1705479139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEtNO/s9qWzzZLj+pP+PNiDw2Ouv7qEofg9cP5+hVdg=;
        b=HnZ7GeakBk4cIN3obIYqw0Y7LtEfeqn2GG691LapQ6WrNWpDDhwI4jqO/XGADGjBdA
         wDkdiVmv+BgAK844wlLFLdDOpZQn6KCsWzTGhR135nLESKgPMU/AUZpgm+6dAExiFYSu
         jqang/u6dyC2khgo2z21J/KFFPfCFlHWmrAUOfM5RwdVtrWqE9KQhfS9S/FE6ANsWQed
         ouVsxajxigtRZiRy8S9UzjduhfKLbEeQ1aRLaFqWyt3g5oS6YMLmfwM71qTDL/OPM1eC
         ybXRl45cpxRSyBWuQkHlvU4HCsMoL1pK5ul1ed+AQcPmyheERtQiEx6uOB9kMYKnp0hj
         KXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704874339; x=1705479139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEtNO/s9qWzzZLj+pP+PNiDw2Ouv7qEofg9cP5+hVdg=;
        b=EXHZBCtx8wt0s/Fh29Qy5u3gZ4tyVTrv9Sg+YcOYnc8zS+bx5f4Tt9lJazcN2Uczcb
         fjAL6JKhO9tTqe7kep7DZU1m2n3g0gPYnKxFeI3LWRhVoJKVxF68YbzhRI64iGlGKGgw
         177GTNVXOoD57owTwlgG64hMSy5PPhdWh3kyDw5M9ZTPZWzEDfznx3X+NEpX/AFAA0l1
         9oIJNezyPmsbfYphAd1YkbOl1eeobWODxK91SJCn9qiJS5Qh+z6KC0IQwOaZ9YrStSe7
         Mny1zUhKkcR7CObxeqE7rWQFNpeV4Xaw9v1aSllvFWu19hGKV2hJM/ecO5J8xE8ZAdVl
         slHw==
X-Gm-Message-State: AOJu0YyD7y7T1vvOoneE2fNBAlVBKSpXpYUe0YnilhCSgwTbchCF+oaS
	ZQ8yET7t/8QYRIJFBpHfv8k=
X-Google-Smtp-Source: AGHT+IHH3KFeT9GqsO58o+Uq18WMywWmnCvxZjPxrJxnbD2bGa4nyS+NN5fOm3j128NHbk/TFYkBjA==
X-Received: by 2002:a17:902:ecd2:b0:1d3:cf95:fd4b with SMTP id a18-20020a170902ecd200b001d3cf95fd4bmr1209787plh.6.1704874339211;
        Wed, 10 Jan 2024 00:12:19 -0800 (PST)
Received: from localhost.localdomain ([140.116.154.65])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902b68c00b001cf51972586sm3044243pls.292.2024.01.10.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 00:12:18 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [RESEND PATCH v2 0/2] lib min_heap: Min heap optimizations
Date: Wed, 10 Jan 2024 16:12:11 +0800
Message-Id: <20240110081213.2289636-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

The purpose of this patch series is to enhance the existing min heap
implementation. The optimization focuses on both the heap construction
process and the number of comparisons made during the heapify
operation.

Thanks,
Kuan-Wei Chiu

---
Changes in RESEND:
- CC the mailing list

Changes in RESEND:
- CC performance events subsystem's maintainers and reviewers.
Link: https://lkml.kernel.org/20240103205259.2108410-1-visitorckw@gmail.com

Changes in v2:
- Use a more consistent title: "min_heap:" -> "lib min_heap:"
- Refine commit messages
Link: https://lkml.kernel.org/20231220083224.3712113-1-visitorckw@gmail.com

Kuan-Wei Chiu (2):
  lib min_heap: Optimize number of calls to min_heapify()
  lib min_heap: Optimize number of comparisons in min_heapify()

 include/linux/min_heap.h | 44 +++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

-- 
2.25.1


