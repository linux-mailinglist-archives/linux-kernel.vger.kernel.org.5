Return-Path: <linux-kernel+bounces-21663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1CF82928E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 03:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF721F26BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F98123DB;
	Wed, 10 Jan 2024 02:56:34 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7384A3E;
	Wed, 10 Jan 2024 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W-KUuV9_1704855379;
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0W-KUuV9_1704855379)
          by smtp.aliyun-inc.com;
          Wed, 10 Jan 2024 10:56:21 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Cc: james.clark@arm.com,
	coresight@lists.linaro.org,
	suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	alexander.shishkin@linux.intel.com,
	linux-arm-kernel@lists.infradead.org,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	leo.yan@linaro.org,
	al.grant@arm.com,
	mathieu.poirier@linaro.org,
	tor@ti.com,
	acme@redhat.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v2 0/1] perf scripts python: arm-cs-trace-disasm.py: print correct disasm info
Date: Wed, 10 Jan 2024 10:56:16 +0800
Message-Id: <20240110025617.66646-1-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
References: <20231214123304.34087-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now the instruction flow disasmed by arm-cs-trace-disasm.py is
ambiguous and uncorrect, fix them in one patch set. Please refer to
each patch for details.

Changes since v1:

Applied all the suggestions from James and Leo of v1.

James: https://lore.kernel.org/lkml/912a39f4-025e-26a1-7786-091fa211f293@arm.com/
Leo: https://lore.kernel.org/lkml/20231224083332.GB13521@leoy-huanghe.lan/

Ruidong Tian (1):
  perf scripts python: arm-cs-trace-disasm.py: add option to print
    virtual address

 tools/perf/scripts/python/arm-cs-trace-disasm.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.33.1


