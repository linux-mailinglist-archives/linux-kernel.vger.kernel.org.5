Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB9804DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344880AbjLEJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjLEJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:35:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDC0188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:35:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701768874; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BoiPah8NRxCrAdiYri1nVhyc+cpVw40uHdjwyg+ciZUazBmRPls3Gw0g70xf8omYcy
    jqSY/2ejnHsQilqIEEuHfOnsZ5OHCMR09WCLy3fRFQTMI4vncZkNMnDofZokDhn25V3F
    k4Pq9lhMi6smT6Ixqc6x9eSu/GhwDBkCOwVbSOgE6tVzIJfatlqdE53jbwjh53kz6rd7
    yCFtcxDey7jOKYTfoiy2X3HjY8YkPJIlw9R5HRKSCeahxyPvmGHm8CdDN60ikoxkRXtG
    BodqNcu5hbWy7lBKyRM+puQv1GxOcoPLEewsR3v5bUdQIEJ4CnVIGXRV2AbZWF/LkXMh
    idlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701768874;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=nAhG3zzPZDlzgwt6owfONL2uwCo4WkjbvcQVuDCcSS4=;
    b=Vctx6kH3WWiZ7OgDOXvlxFCxvNA5t1k88acmo5aFUnc1izBdor+UrlnqWHgYwyZNy/
    7opvocHyOUCBhhkvHZOy2oGSdNt90xE6/bCtw8O57bsHBxJkWnEct8fD7puF7crQ1Xra
    GqRhbyxxa09teoQ8Z8l88ypXNdoB5bFfs2/7QhC4CFvW8p6XrILGTkKEqer7MZR8PuQi
    tJqfTVVvhuS10FwecKyA8MiOjY+IQbdxzseuy3QtdWFhlcz891Pr+eGUiUsYH7HKDdY4
    /lIk7DrNx/2DRo5nyp4HKd/OLe3uZ1ZaLCc4SEV1rl44yyGSx8Ri2Z18hgcpAYgTVmYI
    HYSQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701768874;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=nAhG3zzPZDlzgwt6owfONL2uwCo4WkjbvcQVuDCcSS4=;
    b=Bgv8N5oFugrcHMo1TfrxKRZlFKsnYAMUr+fDSjI2fADtJOo8EYjIxxijjARzW+WDPQ
    hF2o7IYyKVoOPrHwn37u+WGfjovWteZ03+MKeQcmQdXLnAEniNn3MjSmcLRjNnjSS/ey
    T0zRiAjj2VG3PNjaml5YPBACHrbHpiP87H9+P4RC+iEjIS0nyeqb0mFfJ64D5B5susZl
    hvqIevyPVb7RR3epVs3juAfGNGKpwMnopNwMEWXsWTxN7gvEnEb7mzQOc2KMIWkEvI7P
    qMAdxEUgqBOezcq44eHNWXD7K61wjlqlaW1EqPXhYUWsVhU29sM7fj+5i2Cov83Lbnx2
    4QVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701768874;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=nAhG3zzPZDlzgwt6owfONL2uwCo4WkjbvcQVuDCcSS4=;
    b=4Ez/HqE+l3KjR6jZsBMlI+u/GbaJH6d0EQeLI60oYCtlyW5KSfg/GZrbcwmZE9vTEi
    r+EGTzhdl4mJb0aoM1Dg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.10.0 DYNA|AUTH)
    with ESMTPSA id 58bb61zB59YX0GG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 5 Dec 2023 10:34:33 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 05 Dec 2023 10:34:05 +0100
Subject: [PATCH] PM: domains: Scale down parent performance states in
 reverse order
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231205-genpd-perf-order-v1-1-6597cc69a729@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAIzubmUC/x3MMQqAMAxA0atIZgM1pYNeRRy0TWuWtqQggnh3i
 +Mb/n+gsQo3WIYHlC9pUnLHNA7gzz0nRgndQIbsRMZh4lwDVtaIRQMrHtFaQ7Mnt3voWVWOcv/
 LdXvfD/SyGxViAAAA
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Related discussion: https://lore.kernel.org/linux-pm/ZWXgFNKgm9QaFuzx@gerhold.net/
---
 drivers/base/power/domain.c | 124 +++++++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 47 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index da1777e39eaa..830dfef2c880 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -313,72 +313,102 @@ static int genpd_xlate_performance_state(struct generic_pm_domain *genpd,
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
base-commit: 0f5f12ac05f36f117e793656c3f560625e927f1b
change-id: 20231205-genpd-perf-order-bf33029c25ac

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

