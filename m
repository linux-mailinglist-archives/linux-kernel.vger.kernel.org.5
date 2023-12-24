Return-Path: <linux-kernel+bounces-10773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B86D81DBA1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E954E281FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 16:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40960C8FF;
	Sun, 24 Dec 2023 16:54:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8E1CA68;
	Sun, 24 Dec 2023 16:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from localhost.localdomain (unknown [39.174.92.167])
	by mail-app4 (Coremail) with SMTP id cS_KCgA3OaRAYohlOrPzAA--.30851S4;
	Mon, 25 Dec 2023 00:54:26 +0800 (CST)
From: Lin Ma <linma@zju.edu.cn>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Ma <linma@zju.edu.cn>
Subject: [PATCH net v1] net/sched: cls_api: complement tcf_tfilter_dump_policy
Date: Mon, 25 Dec 2023 00:54:13 +0800
Message-Id: <20231224165413.831486-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgA3OaRAYohlOrPzAA--.30851S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW7Aw1fAr43ZF1UXw17GFg_yoW8WF1xpF
	ZrW348C34DXFyUJws7G3Z7ZF9IgrZxZw4UWrZYk34IvwnxWrnxGayftayak3ZFkF48Arsx
	tF98t3yDWa1DuF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	XdbUUUUUU==
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In function `tc_dump_tfilter`, the attributes array is parsed via
tcf_tfilter_dump_policy which only describes TCA_DUMP_FLAGS. However,
the NLA TCA_CHAIN is also accessed with `nla_get_u32`. According to the
commit 5e2424708da7 ("xfrm: add forgotten nla_policy for
XFRMA_MTIMER_THRESH"), such a missing piece could lead to a potential
heap data leak.

The access to TCA_CHAIN is introduced in commit 5bc1701881e3 ("net:
sched: introduce multichain support for filters") and no nla_policy is
provided for parsing at that point. Later on, tcf_tfilter_dump_policy is
introduced in commit f8ab1807a9c9 ("net: sched: introduce terse dump
flag") while still ignoring the fact that TCA_CHAIN needs a check. This
patch does that by complementing the policy.

Note that other functions that access TCA_CHAIN, like tc_new_tfilter,
are not vulnerable as they choose rtm_tca_policy as the parsing policy
which describes the TCA_CHAIN already.

Fixes: 5bc1701881e3 ("net: sched: introduce multichain support for filters")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/sched/cls_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 1976bd163986..2b5b8eca2ee3 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2732,6 +2732,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
 }
 
 static const struct nla_policy tcf_tfilter_dump_policy[TCA_MAX + 1] = {
+	[TCA_CHAIN]      = { .type = NLA_U32 },
 	[TCA_DUMP_FLAGS] = NLA_POLICY_BITFIELD32(TCA_DUMP_FLAGS_TERSE),
 };
 
-- 
2.17.1


