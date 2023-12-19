Return-Path: <linux-kernel+bounces-5439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D32818AAE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796E51C21F88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEC3B187;
	Tue, 19 Dec 2023 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WAcnaf+b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855438FB7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NbQRR
	3fzXjxMb9nup6DBvh+Q3eLqj302uu5PCto+x+Y=; b=WAcnaf+b40iti7ioCk7U6
	YpL4lCoyF3/N+e3Hv+9xHKW/d2X6V3ZyN7PcnsEaw6pmJ9NT6+6dFGFKUoYo5ncY
	PxgBKe5IsohiEjrUlgIrwuhcvkKcJ86vPLenuFDkluwJbrDb9DnBPTcj3llShg1H
	P5C9lqc+jpxAI3x/NB9xuo=
Received: from localhost.localdomain (unknown [120.229.19.171])
	by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wAH0UWCroFl808OCQ--.5704S2;
	Tue, 19 Dec 2023 22:53:56 +0800 (CST)
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
Date: Tue, 19 Dec 2023 14:53:54 +0000
Message-Id: <20231219145354.801900-1-wudaemon@163.com>
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
X-CM-TRANSID:_____wAH0UWCroFl808OCQ--.5704S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUn189UUUUU
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBzQdLbWVOA62jPQABs2

ok, I will take your advise, and test my platform.

--
Regards
Junwen


