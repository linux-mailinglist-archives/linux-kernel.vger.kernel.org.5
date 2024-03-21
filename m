Return-Path: <linux-kernel+bounces-109682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE608881C56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E23283BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EAA3D556;
	Thu, 21 Mar 2024 06:08:17 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEA3381AA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 06:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711001297; cv=none; b=r1pm//d6Leu2BGpjwUZFLZWxSR31bqtGetKyhH6r0DXHPqf/CDRbuLhcLKGZtztczCEZzuM1cmjvjIXe4OEl0eEkJfk9BY0S1TYUZUQ27l/J9+XYdPGuXFXlJ/feVr3+gFySHemTiJkwXDz1v6sgbTF0FULkHD8ACv9ID+h2vcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711001297; c=relaxed/simple;
	bh=niE9a21M2fG8af9wfgYRU3gIVnddd4hp8Zph3fA39zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DbpiUsbTcq6GA14uz1NP3M6Bz3XCw418k7jaQNrG5wZptKIJsf+it0WlaWQmiXdomcwxOXWhdb2qq7PnkDxLql5s2/69dEwDnb6ETEw4Pc8jWBcU1bsKGfmnDdHZs0IxbmiAXQjG81GkEf6iP5djzJljXnwfbgE+CL8yCqkK5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V0Zkp0QQFz4f3jkC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:08:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EBCD01A016E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:08:05 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDHGWzCzvtlvfnzHg--.10900S2;
	Thu, 21 Mar 2024 14:08:03 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tj@kernel.org
Cc: peterz@infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: remove unnecessary import and function in wq_monitor.py
Date: Thu, 21 Mar 2024 23:04:20 +0800
Message-Id: <20240321150420.37648-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHGWzCzvtlvfnzHg--.10900S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtr1Dtw1xCF15Xr4rXw47Jwb_yoW8Jr15pF
	sakF47G3yfXryUX3Z5W343AFyfWrWDAF1qgayrXr1avrs8Xr9Ig34xK398Jr95Xa4DXFW0
	9a9rWrZ0qr4DZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E
	3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsBMNUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unnecessary import and function in wq_monitor.py

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 tools/workqueue/wq_monitor.py | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
index a8856a9c45dc..9e964c5be40c 100644
--- a/tools/workqueue/wq_monitor.py
+++ b/tools/workqueue/wq_monitor.py
@@ -32,16 +32,13 @@ https://github.com/osandov/drgn.
   rescued  The number of work items executed by the rescuer.
 """
 
-import sys
 import signal
-import os
 import re
 import time
 import json
 
 import drgn
-from drgn.helpers.linux.list import list_for_each_entry,list_empty
-from drgn.helpers.linux.cpumask import for_each_possible_cpu
+from drgn.helpers.linux.list import list_for_each_entry
 
 import argparse
 parser = argparse.ArgumentParser(description=desc,
@@ -54,10 +51,6 @@ parser.add_argument('-j', '--json', action='store_true',
                     help='Output in json')
 args = parser.parse_args()
 
-def err(s):
-    print(s, file=sys.stderr, flush=True)
-    sys.exit(1)
-
 workqueues              = prog['workqueues']
 
 WQ_UNBOUND              = prog['WQ_UNBOUND']
-- 
2.30.0


