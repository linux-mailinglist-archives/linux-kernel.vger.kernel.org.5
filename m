Return-Path: <linux-kernel+bounces-78658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFBD86169E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BC1C25463
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E5C8595D;
	Fri, 23 Feb 2024 15:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KFKNFmPH"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74482D7D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703900; cv=none; b=qjgkfmq4cTuXEkdPqyFdc6ck1fOXmL2UW87VbboveKP0q7jXuUTqeDT6pkc/CUW2IE/s36kjDma8+wlyi1mwoaNOQl3j5py1LoMR5DsGMjUpbitDk+PDqYjMX4ZgTVp6BjEi7AxEcAM/GjdLcPlpU5ds7FD3+fDf2dWAsRIuk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703900; c=relaxed/simple;
	bh=ZH381XWq1zBTkACBF2//KeafUWHfw67mulBGzDmiY08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bp1SzpVVjakw4n2Wp2HFf4p+UruLx3QJwBBIJ+u+7Y0+sWaAnxYQ9wk2Ey6U4P9D4Um+PIeNie1gVOWpA6wBeu6IP9olDh2NkhlVkbH994A3h/04acLC8BSnyUOpc1PtWwn/hPXJaXgT/aRqDVHhLCY9n5iuA9F++OG00i5vhD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KFKNFmPH; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so83094866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708703895; x=1709308695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6OU9fCSyWEEzN1u8BEFct7dyiCVhZczrHs1XtVuYnk=;
        b=KFKNFmPHFQvnDtcs/LTdD3HuBYePSJheE7tvw/U+T3yLpjCPJNM1YC7hGoaOnohm/3
         jVe/bz5W3TJj/JlbiKG3vuIVXEkzxilb8KUVOpSUfWlGYNlJZepoI8CIBRgA9K0wGqio
         v0NznsX88neTPiQms+BZKv0WeISNc4E3xrl/UUWTRUbzp1UWAzwC+pKRljfgTJAXz7Se
         jQQ5gVRZlwJgGLGDl+riICyZT9kZIu23m8ikbY8c/i3rAm/+MU0pKGbtbG8pWkGhhCQm
         J34aQYBkGW5NUrPmM1XLf8OQTs3o3w11yFl46Z9sDjJQcpsxWzpWwk6VJbIEBR499BFG
         pjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708703895; x=1709308695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6OU9fCSyWEEzN1u8BEFct7dyiCVhZczrHs1XtVuYnk=;
        b=SiruqKScV2a0Y5hVxITyzR4xfjh8waMhRdP6SWAGTYliegO2NdoYTmeRd/SZitAxWT
         djHaoKBMv7SdSqARBZwkdljM0fHWWsXhw8qSLJRknTempD8Z3cMvP6hvLxFilf9BT4OS
         Qhph76upJnmeHO2wVsAaZcU30fo480NsWAzI3efMJFtgFX/+PCHrA2o1Eqw/W7QNfzaJ
         Srw0TjJayBsFiOxYY9Cvy6STrGZ7CCT0cY22YMXVD31MMCEalJxH23TzTmpZIIeVOoSP
         G1SWrVoxXoGKkmn9as0zDI9k7+0g26f9AIqFQKWqn/AHblYWZy+Iar3LTtMgA4b6AYMR
         l14g==
X-Gm-Message-State: AOJu0Yy2oh+Enzxi53Z/izjMOmm026FERZmD1FXGbUr4yL2+wpLpWrFX
	1JLPZ3OaVjaIxm9P1zg/ld7IJLmOFs2voFHhrfB4Ezim34l5DcvN+rufVFT7ETI=
X-Google-Smtp-Source: AGHT+IFOrob8ed9f5/s0soRamhpTRgugIXA1/sDn/fhSiVJwNaqHd65cLwVQZcDbvzNuhb8zX2rujA==
X-Received: by 2002:a17:906:ae54:b0:a3e:f7c1:5f21 with SMTP id lf20-20020a170906ae5400b00a3ef7c15f21mr147674ejb.52.1708703895503;
        Fri, 23 Feb 2024 07:58:15 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id rg8-20020a1709076b8800b00a3e28471fa4sm6461293ejc.59.2024.02.23.07.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 07:58:14 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Jens Axboe <axboe@kernel.dk>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Wei Wang <wvw@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@infradead.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 0/2] sched: blk: Handle HMP systems when completing IO
Date: Fri, 23 Feb 2024 15:57:47 +0000
Message-Id: <20240223155749.2958009-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to recent changes in how topology is represented on asymmetric multi
processing systems like big.LITTLE where all cpus share the last LLC, there is
a performance regression as cpus with different compute capacities appear under
the same LLC and we no longer send an IPI when the requester is running on
a different cluster with different compute capacity.

Restore the old behavior by adding a new cpus_equal_capacity() function to help
check for the new condition for these systems.

Changes since v1:

	* Split the patch per subsystem.
	* Convert cpus_gte_capacity() to cpus_equal_capacity()
	* Make cpus_equal_capacity() return immediately for SMP systems.

Qais Yousef (2):
  sched: Add a new function to compare if two cpus have the same
    capacity
  block/blk-mq: Don't complete locally if capacities are different

 block/blk-mq.c                 |  5 +++--
 include/linux/sched/topology.h |  6 ++++++
 kernel/sched/core.c            | 11 +++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.34.1


