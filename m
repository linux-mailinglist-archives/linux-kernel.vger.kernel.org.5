Return-Path: <linux-kernel+bounces-38959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F91583C904
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76345B24E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902C134725;
	Thu, 25 Jan 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="OFwQydct"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8812FF9E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201475; cv=none; b=qdSkIZk6e6qWoRvFb2zAXjOtJAhBdA49z7A5NWnl/do2Ay0iVqpVwuyOkFMdbulfKjyK27w5zYRZQfwWDZLoLgnOeEfJhLDv5v9Essb4HDhzrHAz5a5eFRR8/Q+USnDUdWiQAkwLMH3XvIcJR9lyRsgdhZilfRcQQZg4WfLS090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201475; c=relaxed/simple;
	bh=wSNm6Xh0Kv6xNGeHlessTPYueGwqo9gLQQdnOQjO1MI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=gAlfMCVGaAZhinp5rsqeD0NSkCL3AgJNAywk3y64ydjwFMX29TWCIweS3BO1z3nP01qcoTjkB5Ve6l7QkYEZGnw4bXp35722zT/XB01n0JBlWCd80yBiETeAeG9PGeYZ9fCRYNqyjyEf73JguVTdLolZIQz+q+LR2rETsvezI8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=OFwQydct; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=01YbcNr3zUn5oUzSBs2ZmnTlYzYz468PcoxCYgN5+uA=;
  b=OFwQydctMArl5HkPfD3Eal74dCNLQsCZzIdZMT3jZ4/aQ8M+4KeOVrea
   RIihX1YUKEyMW5GBsuyRIqM5q3CKN9nOGs001R6/7U04yW8OmUU9P8CL/
   gg0v26FcBoLQpCM2Y+IltbskWGoTkhnCUW+YKGciD3hN4Ye1OPbaNO5Ax
   s=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="148667153"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 17:51:09 +0100
Date: Thu, 25 Jan 2024 17:51:09 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Matthew Brost <matthew.brost@intel.com>
cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-kernel@vger.kernel.org, 
    oe-kbuild-all@lists.linux.dev
Subject: drivers/gpu/drm/xe/xe_guc_submit.c:1144:1-7: preceding lock on line
 1100 (fwd)
Message-ID: <7d27bca-d2f9-3a8f-18a6-15ad8117c0d6@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Please check whether a mutex_unlock is needed before line 1104.

julia

---------- Forwarded message ----------
Date: Fri, 26 Jan 2024 00:47:54 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: drivers/gpu/drm/xe/xe_guc_submit.c:1144:1-7: preceding lock on line
    1100

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
CC: linux-kernel@vger.kernel.org
TO: Matthew Brost <matthew.brost@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6098d87eaf31f48153c984e2adadf14762520a87
commit: dd08ebf6c3525a7ea2186e636df064ea47281987 drm/xe: Introduce a new DRM driver for Intel GPUs
date:   6 weeks ago
:::::: branch date: 16 hours ago
:::::: commit date: 6 weeks ago
config: powerpc64-randconfig-r052-20240125 (https://download.01.org/0day-ci/archive/20240126/202401260056.LFLxAl9Z-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202401260056.LFLxAl9Z-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/xe/xe_guc_submit.c:1144:1-7: preceding lock on line 1100

vim +1144 drivers/gpu/drm/xe/xe_guc_submit.c

dd08ebf6c3525a Matthew Brost 2023-03-30  1067
dd08ebf6c3525a Matthew Brost 2023-03-30  1068  static int guc_engine_init(struct xe_engine *e)
dd08ebf6c3525a Matthew Brost 2023-03-30  1069  {
dd08ebf6c3525a Matthew Brost 2023-03-30  1070  	struct xe_gpu_scheduler *sched;
dd08ebf6c3525a Matthew Brost 2023-03-30  1071  	struct xe_guc *guc = engine_to_guc(e);
dd08ebf6c3525a Matthew Brost 2023-03-30  1072  	struct xe_guc_engine *ge;
dd08ebf6c3525a Matthew Brost 2023-03-30  1073  	long timeout;
dd08ebf6c3525a Matthew Brost 2023-03-30  1074  	int err;
dd08ebf6c3525a Matthew Brost 2023-03-30  1075
dd08ebf6c3525a Matthew Brost 2023-03-30  1076  	XE_BUG_ON(!xe_device_guc_submission_enabled(guc_to_xe(guc)));
dd08ebf6c3525a Matthew Brost 2023-03-30  1077
dd08ebf6c3525a Matthew Brost 2023-03-30  1078  	ge = kzalloc(sizeof(*ge), GFP_KERNEL);
dd08ebf6c3525a Matthew Brost 2023-03-30  1079  	if (!ge)
dd08ebf6c3525a Matthew Brost 2023-03-30  1080  		return -ENOMEM;
dd08ebf6c3525a Matthew Brost 2023-03-30  1081
dd08ebf6c3525a Matthew Brost 2023-03-30  1082  	e->guc = ge;
dd08ebf6c3525a Matthew Brost 2023-03-30  1083  	ge->engine = e;
dd08ebf6c3525a Matthew Brost 2023-03-30  1084  	init_waitqueue_head(&ge->suspend_wait);
dd08ebf6c3525a Matthew Brost 2023-03-30  1085
dd08ebf6c3525a Matthew Brost 2023-03-30  1086  	timeout = xe_vm_no_dma_fences(e->vm) ? MAX_SCHEDULE_TIMEOUT : HZ * 5;
dd08ebf6c3525a Matthew Brost 2023-03-30  1087  	err = xe_sched_init(&ge->sched, &drm_sched_ops, &xe_sched_ops, NULL,
dd08ebf6c3525a Matthew Brost 2023-03-30  1088  			     e->lrc[0].ring.size / MAX_JOB_SIZE_BYTES,
dd08ebf6c3525a Matthew Brost 2023-03-30  1089  			     64, timeout, guc_to_gt(guc)->ordered_wq, NULL,
dd08ebf6c3525a Matthew Brost 2023-03-30  1090  			     e->name, gt_to_xe(e->gt)->drm.dev);
dd08ebf6c3525a Matthew Brost 2023-03-30  1091  	if (err)
dd08ebf6c3525a Matthew Brost 2023-03-30  1092  		goto err_free;
dd08ebf6c3525a Matthew Brost 2023-03-30  1093
dd08ebf6c3525a Matthew Brost 2023-03-30  1094  	sched = &ge->sched;
dd08ebf6c3525a Matthew Brost 2023-03-30  1095  	err = xe_sched_entity_init(&ge->entity, sched);
dd08ebf6c3525a Matthew Brost 2023-03-30  1096  	if (err)
dd08ebf6c3525a Matthew Brost 2023-03-30  1097  		goto err_sched;
dd08ebf6c3525a Matthew Brost 2023-03-30  1098  	e->priority = XE_ENGINE_PRIORITY_NORMAL;
dd08ebf6c3525a Matthew Brost 2023-03-30  1099
dd08ebf6c3525a Matthew Brost 2023-03-30 @1100  	mutex_lock(&guc->submission_state.lock);
dd08ebf6c3525a Matthew Brost 2023-03-30  1101
dd08ebf6c3525a Matthew Brost 2023-03-30  1102  	err = alloc_guc_id(guc, e);
dd08ebf6c3525a Matthew Brost 2023-03-30  1103  	if (err)
dd08ebf6c3525a Matthew Brost 2023-03-30  1104  		goto err_entity;
dd08ebf6c3525a Matthew Brost 2023-03-30  1105
dd08ebf6c3525a Matthew Brost 2023-03-30  1106  	e->entity = &ge->entity;
dd08ebf6c3525a Matthew Brost 2023-03-30  1107
dd08ebf6c3525a Matthew Brost 2023-03-30  1108  	if (guc_read_stopped(guc))
dd08ebf6c3525a Matthew Brost 2023-03-30  1109  		xe_sched_stop(sched);
dd08ebf6c3525a Matthew Brost 2023-03-30  1110
dd08ebf6c3525a Matthew Brost 2023-03-30  1111  	mutex_unlock(&guc->submission_state.lock);
dd08ebf6c3525a Matthew Brost 2023-03-30  1112
dd08ebf6c3525a Matthew Brost 2023-03-30  1113  	switch (e->class) {
dd08ebf6c3525a Matthew Brost 2023-03-30  1114  	case XE_ENGINE_CLASS_RENDER:
dd08ebf6c3525a Matthew Brost 2023-03-30  1115  		sprintf(e->name, "rcs%d", e->guc->id);
dd08ebf6c3525a Matthew Brost 2023-03-30  1116  		break;
dd08ebf6c3525a Matthew Brost 2023-03-30  1117  	case XE_ENGINE_CLASS_VIDEO_DECODE:
dd08ebf6c3525a Matthew Brost 2023-03-30  1118  		sprintf(e->name, "vcs%d", e->guc->id);
dd08ebf6c3525a Matthew Brost 2023-03-30  1119  		break;
dd08ebf6c3525a Matthew Brost 2023-03-30  1120  	case XE_ENGINE_CLASS_VIDEO_ENHANCE:
dd08ebf6c3525a Matthew Brost 2023-03-30  1121  		sprintf(e->name, "vecs%d", e->guc->id);
dd08ebf6c3525a Matthew Brost 2023-03-30  1122  		break;
dd08ebf6c3525a Matthew Brost 2023-03-30  1123  	case XE_ENGINE_CLASS_COPY:
dd08ebf6c3525a Matthew Brost 2023-03-30  1124  		sprintf(e->name, "bcs%d", e->guc->id);
dd08ebf6c3525a Matthew Brost 2023-03-30  1125  		break;
dd08ebf6c3525a Matthew Brost 2023-03-30  1126  	case XE_ENGINE_CLASS_COMPUTE:
dd08ebf6c3525a Matthew Brost 2023-03-30  1127  		sprintf(e->name, "ccs%d", e->guc->id);
dd08ebf6c3525a Matthew Brost 2023-03-30  1128  		break;
dd08ebf6c3525a Matthew Brost 2023-03-30  1129  	default:
dd08ebf6c3525a Matthew Brost 2023-03-30  1130  		XE_WARN_ON(e->class);
dd08ebf6c3525a Matthew Brost 2023-03-30  1131  	}
dd08ebf6c3525a Matthew Brost 2023-03-30  1132
dd08ebf6c3525a Matthew Brost 2023-03-30  1133  	trace_xe_engine_create(e);
dd08ebf6c3525a Matthew Brost 2023-03-30  1134
dd08ebf6c3525a Matthew Brost 2023-03-30  1135  	return 0;
dd08ebf6c3525a Matthew Brost 2023-03-30  1136
dd08ebf6c3525a Matthew Brost 2023-03-30  1137  err_entity:
dd08ebf6c3525a Matthew Brost 2023-03-30  1138  	xe_sched_entity_fini(&ge->entity);
dd08ebf6c3525a Matthew Brost 2023-03-30  1139  err_sched:
dd08ebf6c3525a Matthew Brost 2023-03-30  1140  	xe_sched_fini(&ge->sched);
dd08ebf6c3525a Matthew Brost 2023-03-30  1141  err_free:
dd08ebf6c3525a Matthew Brost 2023-03-30  1142  	kfree(ge);
dd08ebf6c3525a Matthew Brost 2023-03-30  1143
dd08ebf6c3525a Matthew Brost 2023-03-30 @1144  	return err;
dd08ebf6c3525a Matthew Brost 2023-03-30  1145  }
dd08ebf6c3525a Matthew Brost 2023-03-30  1146

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

