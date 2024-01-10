Return-Path: <linux-kernel+bounces-22218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 781ED829B08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191431F24D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0115548CC8;
	Wed, 10 Jan 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oSjWTJ2M"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184E848CC0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SnWxI
	IZoT2+9NwtCVXP3nMqr5IrKTVI4AnhzowzhThg=; b=oSjWTJ2MWRA8ilepHlsrK
	EM+qxn8N2dujb3rUqu21ybEU8k3XcUJDXupOlGvu2nNvfa5gsFi+oqXbYzG37tiM
	QqacMYDE0iuJ+1sZDWaGrgP8NFnkpX5B9KnUYsVFaD6+sjlObv5ra1Lgt2JYylqj
	Hc8npjbg+0MzqYdsZ6atW4=
Received: from ubuntu.lan (unknown [120.229.70.208])
	by gzga-smtp-mta-g0-2 (Coremail) with SMTP id _____wDHD60ujZ5lR2ZVAA--.7604S2;
	Wed, 10 Jan 2024 20:27:28 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: bristot@redhat.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	wudaemon@163.com
Subject: Re: [PATCH v3] sched/stats: Fix rt/dl task's sched latency statistics error in sched_stat_wait trace_point
Date: Wed, 10 Jan 2024 12:27:26 +0000
Message-Id: <20240110122726.4309-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87d33909-ef8c-43a6-a556-d01fe692d5cd@redhat.com>
References: <87d33909-ef8c-43a6-a556-d01fe692d5cd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHD60ujZ5lR2ZVAA--.7604S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRMFALUUUUU
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBzRRhbWVOBWrIugAAsj

>This error happens when the rt task balances off the source CPU because
>the dequeue operation is not updating the sched_statistics. So, follow
>update_stats_wait_end_fair() and update the stats. Do the same for
>SCHED_DEADLINE.

>[ feel free to change ]

ok


>> +	/*
>> +	 * Mark the end of the wait period
>> +	 * if dequeueing a waiting task.
>> +	 */
>make this a single line comment.
ok
--
Best regards


