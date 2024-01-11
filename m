Return-Path: <linux-kernel+bounces-23771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7382B176
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F971F29FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0064D127;
	Thu, 11 Jan 2024 15:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZVhE1lGb"
Received: from m16.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB924CB43
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=47DEQ
	pj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=ZVhE1lGb6mqyfCmOJjKqU
	Iiqn0MrjYKQj/nZ8Ne4i5HLIIpjHGE4zACHHI9KXnfUMcoaHu0pf6e5OivZi9lbs
	ZCwQcUHmhskp96jvI/IJY96tkbtsrG2qWXQchuV2h+Hqf5/SeLptV2oU7JdI3avo
	7c2sNLVCndTW2rU7jX/dXc=
Received: from localhost.localdomain (unknown [120.229.70.38])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3_9+oBKBlOjKrAA--.19914S2;
	Thu, 11 Jan 2024 23:09:29 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: wudaemon@163.com
Cc: bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH v4] sched/stats: Fix rt/dl task's sched latency statistics error in sched_stat_wait trace_point
Date: Thu, 11 Jan 2024 15:09:28 +0000
Message-Id: <20240111150928.185678-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110133038.46903-1-wudaemon@163.com>
References: <20240110133038.46903-1-wudaemon@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_9+oBKBlOjKrAA--.19914S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfUbg4SUUUUU
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/1tbisQtibWVOBBV0+AADsA



