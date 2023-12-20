Return-Path: <linux-kernel+bounces-7074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013DD81A14A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C1C28235B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA003D3A2;
	Wed, 20 Dec 2023 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e86LEVcE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EAB24B3E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=r9ksr
	NXOTxgxH4c0sDif0BlwN8OMT6GeRiy6ZpC4yqo=; b=e86LEVcEicfjvtTpcWHyT
	hCbs+WBPkjlOT8Xmykl7lrlCZJY/2Hyb/dIgGKqIN20GoY+OfWQ4XM762J1VGywh
	Y1OcGJReK07QcGhJYaxjloyCVh2XOH39Mr0d4+iZA5i1nsrbezh8LJ8ER+lokWPh
	CVOZLSL6ZvqDKejKB/cHes=
Received: from localhost.localdomain (unknown [120.229.70.95])
	by zwqz-smtp-mta-g1-2 (Coremail) with SMTP id _____wDX_0Xd_IJlHRBYBw--.35742S2;
	Wed, 20 Dec 2023 22:40:31 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: laoar.shao@gmail.com
Cc: bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	wudaemon@163.com
Subject: Re: [PATCH v1] sched/rt: Fix rt task's sched latency statistics error in sched_stat_wait trace_point
Date: Wed, 20 Dec 2023 14:40:29 +0000
Message-Id: <20231220144029.836019-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220143249.833273-1-wudaemon@163.com>
References: <20231220143249.833273-1-wudaemon@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_0Xd_IJlHRBYBw--.35742S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUn189UUUUU
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisRZMbWVOAlD2jgABsG

sorry, type error.  rt_se->on_rq is still 1
--
Best regards


