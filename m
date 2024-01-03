Return-Path: <linux-kernel+bounces-16025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B498823727
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9771F2819C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6115F1DA3B;
	Wed,  3 Jan 2024 21:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="Fs6Eda+r";
	dkim=permerror (0-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="cqnsFZHe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9121DA2F;
	Wed,  3 Jan 2024 21:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=gerhold.net
ARC-Seal: i=1; a=rsa-sha256; t=1704316217; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rExV4khYM1zRU7cjvMdaVI5m8LV9lavXrH9khRwoa9+hsct+KlUOy+7Mn3Lr1BATpU
    78xlKqiwhJAVIy7NygyaNk5uufVnzQLxsnnnCuBBiFwrkkYSErK1sHRZcTpDIgZlx/b3
    EZziYYyv4GWtWr0d7557XjlPlpT8bw/mcpgTWPfl+5gpMf0hz82rb8i7eW3EopFZlNdW
    eDa/WDkoSRL2y0YNLitYEa5GX+xqFHGXUp1BbGjuY9gNOdhWkeUKj1z9q6iYdSb8CfwN
    b7F9GlL1n+u071uUFkhgOfqYDEyD0hVcal9sSOV19H/WVVFkjxME5txjuNxNSsuIkxXh
    r9cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704316217;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=U74J5n70oOkdpD2USO/TKMTXE9DOo0XAlgw3xl3xdRE=;
    b=FeAgxTn5QHOvfY9YSAsU+NVItER0D1BULeZm57ZinxB+XiX/aURBLLr/qy2sjEyjcm
    J+SVc42E/+BTTM/+wH+iVVI9pYR/WVFBMQ2X2ZYQIAaT0fEnXNOhsWquQAQQF5BDf6+I
    3GOW3b+3/8nfws1/+sKtWf2gaOQcUXFFN55hs6tzszCMlJtbc7Tirf56i7s08yha6fyn
    sbZPlstykr4txTMmmWUaHABzVs9sGCsn54hFmyXf7O6tqn3mVccaZInVw3M/DtWwcWG/
    /bcApHTSyxV6o5iGRMDqm/ZhcYeIhPUOupGYbM1lQx9esh0p1P14z/C8cUXUz1Q6euSV
    beUQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704316217;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=U74J5n70oOkdpD2USO/TKMTXE9DOo0XAlgw3xl3xdRE=;
    b=Fs6Eda+rwZlBGXOzSSZuJAwHnJw9YH1SWt3JYgk7fNgwMgP1qzAcspmoIIH/XD3Bjc
    lbxnC8h4r65lWCUOjjYwJRcFhJX1RPasONW2tpa/wBtTP1DAPBWTg8zULdWvOVMSwO25
    6oW5idrSoPFamRxFc34dBa4K0goFoEmW4lj0Qj0nPGfr6scPz063264DSW0lLKoUIxAv
    u/6tLpgMYVKzf6TEQFxODh0SNiUItGdLhd3L7S7R58IWmtsVoDCXjBzBp6XoOiiY/k0X
    aa4l01U3WXY0gwtauC5crJ6uRV0sH5t2+zuG202mIqaPzv96BGzFzh69D6LxF30+C184
    0cQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704316217;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=U74J5n70oOkdpD2USO/TKMTXE9DOo0XAlgw3xl3xdRE=;
    b=cqnsFZHe4irgeHQwZ9PI5Q5l3JQkuTFnatPMYKPDp6sYzZpoFuHndOg5lryn8OZwjP
    MpcWoqkAXWwZI1jCOYBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.10.0 SBL|AUTH)
    with ESMTPSA id 58bb61003LAGNVs
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Jan 2024 22:10:16 +0100 (CET)
From: Stephan Gerhold <stephan@gerhold.net>
Date: Wed, 03 Jan 2024 22:10:05 +0100
Subject: [PATCH v2] PM: domains: Scale down parent performance states in
 reverse order
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240103-genpd-perf-order-v2-1-eeecfc55624b@gerhold.net>
X-B4-Tracking: v=1; b=H4sIACzNlWUC/32NQQqDMBBFryKz7hQzopKueo/iIk0mGiiJTERaJ
 Hdv6gG6fA/++wdklsAZbs0BwnvIIcUKdGnALibOjMFVBmqpU9T2OHNcHa4sHpM4Fnz6rmtJW+q
 NhTpbhX14n8nHVHkJeUvyOR929bN/YrtChUOvR2sHbUbS95llSS93jbzBVEr5Avg2SC+yAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.4

Power domains might have parent domains assigned that are automatically
managed by the PM domain core. In particular, parent domains are
automatically powered on/off and setting performance states on child
domains is translated to parent domains (e.g. using an OPP table from
the device tree).

Currently parent performance states are always adjusted before the
performance state of the child domain is changed.

However, typically a parent/child relationship between two power
domains with performance states models the requirement to keep the
parent domain at a performance state equal or higher to the child
domain. When scaling down there is a brief moment where the parent
domain will end up having a lower performance state than required by
the child domain.

To avoid this, we need to differentiate between scaling up/down and
adjust the order of operations:

 - When scaling up, parent domains should be adjusted before the child
   domain. In case of an error, the rollback happens in reverse order.

 - When scaling down, parent domains should be adjusted after the child
   domain, in reverse order, just as if we would rollback scaling up.
   In case of an error, the rollback happens in normal order (just as
   if we would normally scale up).

Implement this by moving the existing functionality of
_genpd_set_performance_state() to two separate functions that are
called in the proper iteration order.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
- Rebase to adjust for move of drivers/base/power/domain.c
  to drivers/pmdomain/core.c
- Regenerate CC list
- No code changes
- Link to v1: https://lore.kernel.org/r/20231205-genpd-perf-order-v1-1-6597cc69a729@gerhold.net
---
Related discussion: https://lore.kernel.org/linux-pm/ZWXgFNKgm9QaFuzx@gerhold.net/
---
 drivers/pmdomain/core.c | 124 ++++++++++++++++++++++++++++++------------------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a1f6cba3ae6c..fec9dc6ab828 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -311,72 +311,102 @@ static int genpd_xlate_performance_state(struct generic_pm_domain *genpd,
 }
 
 static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
-					unsigned int state, int depth)
+					unsigned int state, int depth);
+
+static void _genpd_rollback_parent_state(struct gpd_link *link, int depth)
 {
-	struct generic_pm_domain *parent;
-	struct gpd_link *link;
-	int parent_state, ret;
+	struct generic_pm_domain *parent = link->parent;
+	int parent_state;
 
-	if (state == genpd->performance_state)
-		return 0;
+	genpd_lock_nested(parent, depth + 1);
 
-	/* Propagate to parents of genpd */
-	list_for_each_entry(link, &genpd->child_links, child_node) {
-		parent = link->parent;
+	parent_state = link->prev_performance_state;
+	link->performance_state = parent_state;
 
-		/* Find parent's performance state */
-		ret = genpd_xlate_performance_state(genpd, parent, state);
-		if (unlikely(ret < 0))
-			goto err;
+	parent_state = _genpd_reeval_performance_state(parent, parent_state);
+	if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
+		pr_err("%s: Failed to roll back to %d performance state\n",
+		       parent->name, parent_state);
+	}
 
-		parent_state = ret;
+	genpd_unlock(parent);
+}
 
-		genpd_lock_nested(parent, depth + 1);
+static int _genpd_set_parent_state(struct generic_pm_domain *genpd,
+				   struct gpd_link *link,
+				   unsigned int state, int depth)
+{
+	struct generic_pm_domain *parent = link->parent;
+	int parent_state, ret;
 
-		link->prev_performance_state = link->performance_state;
-		link->performance_state = parent_state;
-		parent_state = _genpd_reeval_performance_state(parent,
-						parent_state);
-		ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
-		if (ret)
-			link->performance_state = link->prev_performance_state;
+	/* Find parent's performance state */
+	ret = genpd_xlate_performance_state(genpd, parent, state);
+	if (unlikely(ret < 0))
+		return ret;
 
-		genpd_unlock(parent);
+	parent_state = ret;
 
-		if (ret)
-			goto err;
-	}
+	genpd_lock_nested(parent, depth + 1);
 
-	if (genpd->set_performance_state) {
-		ret = genpd->set_performance_state(genpd, state);
-		if (ret)
-			goto err;
-	}
+	link->prev_performance_state = link->performance_state;
+	link->performance_state = parent_state;
 
-	genpd->performance_state = state;
-	return 0;
+	parent_state = _genpd_reeval_performance_state(parent, parent_state);
+	ret = _genpd_set_performance_state(parent, parent_state, depth + 1);
+	if (ret)
+		link->performance_state = link->prev_performance_state;
 
-err:
-	/* Encountered an error, lets rollback */
-	list_for_each_entry_continue_reverse(link, &genpd->child_links,
-					     child_node) {
-		parent = link->parent;
+	genpd_unlock(parent);
 
-		genpd_lock_nested(parent, depth + 1);
+	return ret;
+}
+
+static int _genpd_set_performance_state(struct generic_pm_domain *genpd,
+					unsigned int state, int depth)
+{
+	struct gpd_link *link = NULL;
+	int ret;
+
+	if (state == genpd->performance_state)
+		return 0;
 
-		parent_state = link->prev_performance_state;
-		link->performance_state = parent_state;
+	/* When scaling up, propagate to parents first in normal order */
+	if (state > genpd->performance_state) {
+		list_for_each_entry(link, &genpd->child_links, child_node) {
+			ret = _genpd_set_parent_state(genpd, link, state, depth);
+			if (ret)
+				goto rollback_parents_up;
+		}
+	}
 
-		parent_state = _genpd_reeval_performance_state(parent,
-						parent_state);
-		if (_genpd_set_performance_state(parent, parent_state, depth + 1)) {
-			pr_err("%s: Failed to roll back to %d performance state\n",
-			       parent->name, parent_state);
+	if (genpd->set_performance_state) {
+		ret = genpd->set_performance_state(genpd, state);
+		if (ret) {
+			if (link)
+				goto rollback_parents_up;
+			return ret;
 		}
+	}
 
-		genpd_unlock(parent);
+	/* When scaling down, propagate to parents last in reverse order */
+	if (state < genpd->performance_state) {
+		list_for_each_entry_reverse(link, &genpd->child_links, child_node) {
+			ret = _genpd_set_parent_state(genpd, link, state, depth);
+			if (ret)
+				goto rollback_parents_down;
+		}
 	}
 
+	genpd->performance_state = state;
+	return 0;
+
+rollback_parents_up:
+	list_for_each_entry_continue_reverse(link, &genpd->child_links, child_node)
+		_genpd_rollback_parent_state(link, depth);
+	return ret;
+rollback_parents_down:
+	list_for_each_entry_continue(link, &genpd->child_links, child_node)
+		_genpd_rollback_parent_state(link, depth);
 	return ret;
 }
 

---
base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
change-id: 20231205-genpd-perf-order-bf33029c25ac

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>


