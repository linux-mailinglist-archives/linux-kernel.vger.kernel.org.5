Return-Path: <linux-kernel+bounces-7046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8132581A0EC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23680B21035
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9938DE7;
	Wed, 20 Dec 2023 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jvD9Jf4Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EBD38DDE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=47DEQ
	pj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=jvD9Jf4Zv+vrDmzEx3r37
	E16J9u0uDVXVoPGRvo0Z/0U75Gs30iFufZL9bkzYSmQ2Gd6H/KPhUrk9TV5f3+Ec
	yxWV7982Lp59Fm7kHekb1hzqDKjHBmu/Bm+jQCi1N81KTi/hm0cVFAszApIrEMOj
	/spNc2Y1FMDv5nzgwXlgEI=
Received: from localhost.localdomain (unknown [120.229.70.191])
	by zwqz-smtp-mta-g5-3 (Coremail) with SMTP id _____wDnj7Ko84Jlw2XSGA--.9712S2;
	Wed, 20 Dec 2023 22:01:14 +0800 (CST)
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
Subject: Re: [PATCH v1] sched/rt: Fix rt task's sched latency statistics in sched_stat_wait trace_point
Date: Wed, 20 Dec 2023 14:01:12 +0000
Message-Id: <20231220140112.821992-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CALOAHbDY0dkohOudFL4UAK2XBn0FKe7uKLmbWUzmDeEdTq8M9w@mail.gmail.com>
References: <CALOAHbDY0dkohOudFL4UAK2XBn0FKe7uKLmbWUzmDeEdTq8M9w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnj7Ko84Jlw2XSGA--.9712S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUb189UUUUU
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisQ5MbWVOAlB8pQAAs+



