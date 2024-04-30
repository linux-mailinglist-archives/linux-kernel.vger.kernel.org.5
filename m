Return-Path: <linux-kernel+bounces-164658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79EF8B80CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59981C23A98
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D5E1A0B17;
	Tue, 30 Apr 2024 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kExedZgB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F0A19DF5E;
	Tue, 30 Apr 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506673; cv=none; b=Vpv8Czz6bzbJrWwxtavchBvBENRmLB1SSYH2/S3DCrZm1KyrVWgdOWJ1x7+Qo19clLNrdSe1s1vi/GpNuOD6Vu1hyKSjepo1Y64vLWvk10AvZFq6SIBSeXxNUu/3ajj4t78C436LV+1AxhFQAMM39uJj/eMDFi7jqUaoFOzRZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506673; c=relaxed/simple;
	bh=FiuxKeDzaIT6o2ExoNnP4zdRxGfrm0SktFxj+ktBG5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZA1pNtHKNdR+zKJoTeZYOCi2P+A53OGlWVH5RvACbmn/bJXnoJi8Ffa0hYCHXtoYPI5I1EZcn8LazCMrvMPLnqYgKKa1SJQHL/1kIYZRanHtSETEI7HAuCxPM+xnnvrZAGUb4bqQWAVcrzq2k07i3i/dKVreJb9ooJ4wCWit/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kExedZgB; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714506672; x=1746042672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FiuxKeDzaIT6o2ExoNnP4zdRxGfrm0SktFxj+ktBG5g=;
  b=kExedZgBmGq+koPCsdij2UZbzjQLBe3jU8KZNnRXkfaA6YQ/QiEmzggL
   eT2PCJ1VbpXB0qv8iJrrcPbgpL/Lje3AiY+lRJNZBItz0vebEpYKEa8VB
   s4yVodiANTy8ce6VBpQgI+c3ftz+GMIUPpQq+wN113QLVxAin04kHj2K8
   7NHDchk7mN7CZx8y5UeJ6iMWguGRislmjTZIyzptWB+Hc32aM9gp71oQY
   1RBAH5OcjWRsLl6YMCNg1RLyRyC3w8pvN/MON5lEowDYSs4m1ulo7pyrn
   McwmuCJLzS7iEZcq8FZhiQEUAhJd8a+3mYouVHCch1J05sUyi/iowJmfr
   Q==;
X-CSE-ConnectionGUID: ss3/HclnT7iLK3PRIGy39g==
X-CSE-MsgGUID: fqzvTCXhQg2Cyduhfa32Nw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="10355569"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="10355569"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 12:51:10 -0700
X-CSE-ConnectionGUID: GTj3wyjfQYuxWh3/H1JmSA==
X-CSE-MsgGUID: 8RreDekoTSi9bDMYsmW4+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="31280300"
Received: from b4969161e530.jf.intel.com ([10.165.56.46])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2024 12:51:09 -0700
From: Haitao Huang <haitao.huang@linux.intel.com>
To: jarkko@kernel.org,
	dave.hansen@linux.intel.com,
	kai.huang@intel.com,
	tj@kernel.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	cgroups@vger.kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	sohil.mehta@intel.com,
	tim.c.chen@linux.intel.com
Cc: zhiquan1.li@intel.com,
	kristen@linux.intel.com,
	seanjc@google.com,
	zhanb@microsoft.com,
	anakrish@microsoft.com,
	mikko.ylinen@linux.intel.com,
	yangjie@microsoft.com,
	chrisyan@microsoft.com
Subject: [PATCH v13 02/14] cgroup/misc: Add per resource callbacks for CSS events
Date: Tue, 30 Apr 2024 12:50:56 -0700
Message-Id: <20240430195108.5676-3-haitao.huang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430195108.5676-1-haitao.huang@linux.intel.com>
References: <20240430195108.5676-1-haitao.huang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristen Carlson Accardi <kristen@linux.intel.com>

The misc cgroup controller (subsystem) currently does not perform
resource type specific action for Cgroups Subsystem State (CSS) events:
the 'css_alloc' event when a cgroup is created and the 'css_free' event
when a cgroup is destroyed.

Define callbacks for those events and allow resource providers to
register the callbacks per resource type as needed. This will be
utilized later by the EPC misc cgroup support implemented in the SGX
driver.

This design passes a struct misc_cg into the callbacks. An alternative
to pass only a struct misc_res was considered for encapsulating how
misc_cg stores its misc_res array. However, the SGX driver would still
need to access the misc_res array in the statically defined misc root_cg
during initialization to set resource specific fields. Therefore, some
extra getter/setter APIs to abstract such access to the misc_res array
within the misc_cg struct would be needed. That seems an overkill at the
moment and is deferred to later improvement when there are more users of
these callbacks.

Link: https://lore.kernel.org/lkml/op.2kdw36otwjvjmi@hhuan26-mobl.amr.corp.intel.com/

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
---
V12:
- Add comments in commit to clarify reason to pass in misc_cg, not
misc_res. (Kai)
- Remove unlikely (Kai)

V8:
- Abstract out _misc_cg_res_free() and _misc_cg_res_alloc() (Jarkko)

V7:
- Make ops one per resource type and store them in array (Michal)
- Rename the ops struct to misc_res_ops, and enforce the constraints of required callback
functions (Jarkko)
- Moved addition of priv field to patch 4 where it was used first. (Jarkko)

V6:
- Create ops struct for per resource callbacks (Jarkko)
- Drop max_write callback (Dave, Michal)
- Style fixes (Kai)
---
 include/linux/misc_cgroup.h | 11 +++++
 kernel/cgroup/misc.c        | 82 +++++++++++++++++++++++++++++++++----
 2 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
index e799b1f8d05b..0806d4436208 100644
--- a/include/linux/misc_cgroup.h
+++ b/include/linux/misc_cgroup.h
@@ -27,6 +27,16 @@ struct misc_cg;
 
 #include <linux/cgroup.h>
 
+/**
+ * struct misc_res_ops: per resource type callback ops.
+ * @alloc: invoked for resource specific initialization when cgroup is allocated.
+ * @free: invoked for resource specific cleanup when cgroup is deallocated.
+ */
+struct misc_res_ops {
+	int (*alloc)(struct misc_cg *cg);
+	void (*free)(struct misc_cg *cg);
+};
+
 /**
  * struct misc_res: Per cgroup per misc type resource
  * @max: Maximum limit on the resource.
@@ -56,6 +66,7 @@ struct misc_cg {
 
 u64 misc_cg_res_total_usage(enum misc_res_type type);
 int misc_cg_set_capacity(enum misc_res_type type, u64 capacity);
+int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *ops);
 int misc_cg_try_charge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 void misc_cg_uncharge(enum misc_res_type type, struct misc_cg *cg, u64 amount);
 
diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
index 79a3717a5803..4a602d68cf7d 100644
--- a/kernel/cgroup/misc.c
+++ b/kernel/cgroup/misc.c
@@ -39,6 +39,9 @@ static struct misc_cg root_cg;
  */
 static u64 misc_res_capacity[MISC_CG_RES_TYPES];
 
+/* Resource type specific operations */
+static const struct misc_res_ops *misc_res_ops[MISC_CG_RES_TYPES];
+
 /**
  * parent_misc() - Get the parent of the passed misc cgroup.
  * @cgroup: cgroup whose parent needs to be fetched.
@@ -105,6 +108,36 @@ int misc_cg_set_capacity(enum misc_res_type type, u64 capacity)
 }
 EXPORT_SYMBOL_GPL(misc_cg_set_capacity);
 
+/**
+ * misc_cg_set_ops() - set resource specific operations.
+ * @type: Type of the misc res.
+ * @ops: Operations for the given type.
+ *
+ * Context: Any context.
+ * Return:
+ * * %0 - Successfully registered the operations.
+ * * %-EINVAL - If @type is invalid, or the operations missing any required callbacks.
+ */
+int misc_cg_set_ops(enum misc_res_type type, const struct misc_res_ops *ops)
+{
+	if (!valid_type(type))
+		return -EINVAL;
+
+	if (!ops->alloc) {
+		pr_err("%s: alloc missing\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!ops->free) {
+		pr_err("%s: free missing\n", __func__);
+		return -EINVAL;
+	}
+
+	misc_res_ops[type] = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(misc_cg_set_ops);
+
 /**
  * misc_cg_cancel_charge() - Cancel the charge from the misc cgroup.
  * @type: Misc res type in misc cg to cancel the charge from.
@@ -371,6 +404,33 @@ static struct cftype misc_cg_files[] = {
 	{}
 };
 
+static inline int _misc_cg_res_alloc(struct misc_cg *cg)
+{
+	enum misc_res_type i;
+	int ret;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
+		WRITE_ONCE(cg->res[i].max, MAX_NUM);
+		atomic64_set(&cg->res[i].usage, 0);
+		if (misc_res_ops[i]) {
+			ret = misc_res_ops[i]->alloc(cg);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static inline void _misc_cg_res_free(struct misc_cg *cg)
+{
+	enum misc_res_type i;
+
+	for (i = 0; i < MISC_CG_RES_TYPES; i++)
+		if (misc_res_ops[i])
+			misc_res_ops[i]->free(cg);
+}
+
 /**
  * misc_cg_alloc() - Allocate misc cgroup.
  * @parent_css: Parent cgroup.
@@ -383,20 +443,25 @@ static struct cftype misc_cg_files[] = {
 static struct cgroup_subsys_state *
 misc_cg_alloc(struct cgroup_subsys_state *parent_css)
 {
-	enum misc_res_type i;
-	struct misc_cg *cg;
+	struct misc_cg *parent_cg, *cg;
+	int ret;
 
 	if (!parent_css) {
-		cg = &root_cg;
+		parent_cg = cg = &root_cg;
 	} else {
 		cg = kzalloc(sizeof(*cg), GFP_KERNEL);
 		if (!cg)
 			return ERR_PTR(-ENOMEM);
+		parent_cg = css_misc(parent_css);
 	}
 
-	for (i = 0; i < MISC_CG_RES_TYPES; i++) {
-		WRITE_ONCE(cg->res[i].max, MAX_NUM);
-		atomic64_set(&cg->res[i].usage, 0);
+	ret = _misc_cg_res_alloc(cg);
+	if (ret) {
+		_misc_cg_res_free(cg);
+		if (likely(parent_css))
+			kfree(cg);
+
+		return ERR_PTR(ret);
 	}
 
 	return &cg->css;
@@ -410,7 +475,10 @@ misc_cg_alloc(struct cgroup_subsys_state *parent_css)
  */
 static void misc_cg_free(struct cgroup_subsys_state *css)
 {
-	kfree(css_misc(css));
+	struct misc_cg *cg = css_misc(css);
+
+	_misc_cg_res_free(cg);
+	kfree(cg);
 }
 
 /* Cgroup controller callbacks */
-- 
2.25.1


