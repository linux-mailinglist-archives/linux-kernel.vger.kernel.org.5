Return-Path: <linux-kernel+bounces-1673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7A8151F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 817E1B23D60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871048CE9;
	Fri, 15 Dec 2023 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGqvew1U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088C48CD5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702676007; x=1734212007;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gGbLu3evcIiXpn3ONliSgm5EELHP6SV7915art+0DFY=;
  b=IGqvew1UpvNFQGQpLVaLYg0turPiNwZ6w/aV0lJsrIXGJ4Pwu7lM1ifl
   HjRDMXtcdH1s0NdtAzJZ95j+0D3HLov8qcvIpYef8YhD8UB8OHEVo0gtO
   YbYcCfh/R+v9+AKOntgTxyM3gUN6OGOZOvSQi8ra8OmI5WJD1hNtSrsgD
   KRfktbdIHYvoHAdcvO3iwPkjlpYcxIfJKJr8Qt7yz//fKUdiDHtxp8Tax
   K8gaNCwBgXxlBkzK1xFl2MKpH7fXtkYs6DG1ynVT3cbrp+RopEOCKZ2n4
   6Og3smlgloDaRNnU6UCESz5vfQAyTP/7izvkeKfqQS4QEqm5RK6sg3Yr5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2169344"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2169344"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 13:33:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="774888981"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="774888981"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 15 Dec 2023 13:33:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEFoA-0000ma-0h;
	Fri, 15 Dec 2023 21:33:22 +0000
Date: Sat, 16 Dec 2023 05:33:15 +0800
From: kernel test robot <lkp@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	John Harrison <John.C.Harrison@intel.com>,
	Alan Previn <alan.previn.teres.alexis@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: htmldocs: ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning:
 Excess struct member 'guc_ids_in_use' description in 'intel_guc'
Message-ID: <202312160537.TLU3lJaE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3f7168591ebf7bbdb91797d02b1afaf00a4289b1
commit: 833210943099f5cfd9bd054ce9c5ec2e971bcc89 drm/i915/guc: Delay disabling guc_id scheduling for better hysteresis
date:   1 year, 2 months ago
reproduce: (https://download.01.org/0day-ci/archive/20231216/202312160537.TLU3lJaE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312160537.TLU3lJaE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning: Excess struct member 'guc_ids_in_use' description in 'intel_guc'
>> ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning: Excess struct member 'sched_disable_delay_ms' description in 'intel_guc'
>> ./drivers/gpu/drm/i915/gt/uc/intel_guc.h:268: warning: Excess struct member 'sched_disable_gucid_threshold' description in 'intel_guc'

vim +268 ./drivers/gpu/drm/i915/gt/uc/intel_guc.h

f18819a3c8da62a drivers/gpu/drm/i915/intel_guc.h       Chris Wilson           2019-07-01   26  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   27  /**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   28   * struct intel_guc - Top level structure of GuC.
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   29   *
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   30   * It handles firmware loading and manages client pool. intel_guc owns an
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   31   * i915_sched_engine for submission.
d9e2e0143cee8a3 drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-16   32   */
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04   33  struct intel_guc {
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   34  	/** @fw: the GuC firmware */
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04   35  	struct intel_uc_fw fw;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   36  	/** @log: sub-structure containing GuC log related data and objects */
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04   37  	struct intel_guc_log log;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   38  	/** @ct: the command transport communication channel */
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04   39  	struct intel_guc_ct ct;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   40  	/** @slpc: sub-structure containing SLPC related data and objects */
dff0fc499092985 drivers/gpu/drm/i915/gt/uc/intel_guc.h Vinay Belgaumkar       2021-07-30   41  	struct intel_guc_slpc slpc;
24492514ccbd571 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-03-21   42  	/** @capture: the error-state-capture module's data and objects */
24492514ccbd571 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-03-21   43  	struct intel_guc_state_capture *capture;
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04   44  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   45  	/** @sched_engine: Global engine used to submit requests to GuC */
925dc1cf58edcd6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21   46  	struct i915_sched_engine *sched_engine;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   47  	/**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   48  	 * @stalled_request: if GuC can't process a request for any reason, we
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   49  	 * save it until GuC restarts processing. No other request can be
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   50  	 * submitted until the stalled request is processed.
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   51  	 */
925dc1cf58edcd6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21   52  	struct i915_request *stalled_request;
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   53  	/**
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   54  	 * @submission_stall_reason: reason why submission is stalled
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   55  	 */
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   56  	enum {
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   57  		STALL_NONE,
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   58  		STALL_REGISTER_CONTEXT,
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   59  		STALL_MOVE_LRC_TAIL,
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   60  		STALL_ADD_REQUEST,
6b540bf6f14362a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   61  	} submission_stall_reason;
925dc1cf58edcd6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21   62  
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04   63  	/* intel_guc_recv interrupt related state */
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   64  	/** @irq_lock: protects GuC irq state */
eacd8391f977d38 drivers/gpu/drm/i915/intel_guc.h       Michał Winiarski       2018-03-19   65  	spinlock_t irq_lock;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   66  	/**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   67  	 * @msg_enabled_mask: mask of events that are processed when receiving
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   68  	 * an INTEL_GUC_ACTION_DEFAULT G2H message.
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   69  	 */
eacd8391f977d38 drivers/gpu/drm/i915/intel_guc.h       Michał Winiarski       2018-03-19   70  	unsigned int msg_enabled_mask;
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04   71  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   72  	/**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   73  	 * @outstanding_submission_g2h: number of outstanding GuC to Host
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   74  	 * responses related to GuC submission, used to determine if the GT is
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   75  	 * idle
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   76  	 */
b97060a99b01b4d drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21   77  	atomic_t outstanding_submission_g2h;
b97060a99b01b4d drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21   78  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   79  	/** @interrupts: pointers to GuC interrupt-managing functions. */
1e83e7a66d139e0 drivers/gpu/drm/i915/intel_guc.h       Oscar Mateo            2019-05-27   80  	struct {
9cbd51c2c0edbaf drivers/gpu/drm/i915/intel_guc.h       Daniele Ceraolo Spurio 2019-07-13   81  		void (*reset)(struct intel_guc *guc);
9cbd51c2c0edbaf drivers/gpu/drm/i915/intel_guc.h       Daniele Ceraolo Spurio 2019-07-13   82  		void (*enable)(struct intel_guc *guc);
9cbd51c2c0edbaf drivers/gpu/drm/i915/intel_guc.h       Daniele Ceraolo Spurio 2019-07-13   83  		void (*disable)(struct intel_guc *guc);
1e83e7a66d139e0 drivers/gpu/drm/i915/intel_guc.h       Oscar Mateo            2019-05-27   84  	} interrupts;
1e83e7a66d139e0 drivers/gpu/drm/i915/intel_guc.h       Oscar Mateo            2019-05-27   85  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09   86  	/**
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   87  	 * @submission_state: sub-structure for submission state protected by
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   88  	 * single lock
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   89  	 */
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   90  	struct {
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   91  		/**
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   92  		 * @lock: protects everything in submission_state,
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   93  		 * ce->guc_id.id, and ce->guc_id.ref when transitioning in and
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   94  		 * out of zero
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   95  		 */
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   96  		spinlock_t lock;
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   97  		/**
09c5e3a5e509bb1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14   98  		 * @guc_ids: used to allocate new guc_ids, single-lrc
3a4cdf1982f05d1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21   99  		 */
3a4cdf1982f05d1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21  100  		struct ida guc_ids;
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  101  		/**
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  102  		 * @num_guc_ids: Number of guc_ids, selftest feature to be able
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  103  		 * to reduce this number while testing.
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  104  		 */
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  105  		int num_guc_ids;
09c5e3a5e509bb1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  106  		/**
09c5e3a5e509bb1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  107  		 * @guc_ids_bitmap: used to allocate new guc_ids, multi-lrc
09c5e3a5e509bb1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  108  		 */
09c5e3a5e509bb1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  109  		unsigned long *guc_ids_bitmap;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  110  		/**
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  111  		 * @guc_id_list: list of intel_context with valid guc_ids but no
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  112  		 * refs
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  113  		 */
3a4cdf1982f05d1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21  114  		struct list_head guc_id_list;
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  115  		/**
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  116  		 * @guc_ids_in_use: Number single-lrc guc_ids in use
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  117  		 */
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  118  		unsigned int guc_ids_in_use;
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  119  		/**
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  120  		 * @destroyed_contexts: list of contexts waiting to be destroyed
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  121  		 * (deregistered with the GuC)
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  122  		 */
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  123  		struct list_head destroyed_contexts;
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  124  		/**
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  125  		 * @destroyed_worker: worker to deregister contexts, need as we
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  126  		 * need to take a GT PM reference and can't from destroy
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  127  		 * function as it might be in an atomic context (no sleeping)
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  128  		 */
1a52faed3131147 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  129  		struct work_struct destroyed_worker;
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  130  		/**
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  131  		 * @reset_fail_worker: worker to trigger a GT reset after an
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  132  		 * engine reset fails
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  133  		 */
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  134  		struct work_struct reset_fail_worker;
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  135  		/**
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  136  		 * @reset_fail_mask: mask of engines that failed to reset
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  137  		 */
1f73a367420c954 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-01-20  138  		intel_engine_mask_t reset_fail_mask;
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  139  		/**
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  140  		 * @sched_disable_delay_ms: schedule disable delay, in ms, for
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  141  		 * contexts
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  142  		 */
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  143  		unsigned int sched_disable_delay_ms;
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  144  		/**
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  145  		 * @sched_disable_gucid_threshold: threshold of min remaining available
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  146  		 * guc_ids before we start bypassing the schedule disable delay
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  147  		 */
833210943099f5c drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2022-10-06  148  		unsigned int sched_disable_gucid_threshold;
0ea92ace8b95f67 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-10-14  149  	} submission_state;
3a4cdf1982f05d1 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21  150  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  151  	/**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  152  	 * @submission_supported: tracks whether we support GuC submission on
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  153  	 * the current platform
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  154  	 */
e754dccbc908701 drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2021-07-26  155  	bool submission_supported;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  156  	/** @submission_selected: tracks whether the user enabled GuC submission */
202c98e71692484 drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2020-02-18  157  	bool submission_selected;
09570c5010411b5 drivers/gpu/drm/i915/gt/uc/intel_guc.h John Harrison          2022-03-01  158  	/** @submission_initialized: tracks whether GuC submission has been initialised */
09570c5010411b5 drivers/gpu/drm/i915/gt/uc/intel_guc.h John Harrison          2022-03-01  159  	bool submission_initialized;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  160  	/**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  161  	 * @rc_supported: tracks whether we support GuC rc on the current platform
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  162  	 */
216d56c5da5c93c drivers/gpu/drm/i915/gt/uc/intel_guc.h Vinay Belgaumkar       2021-07-30  163  	bool rc_supported;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  164  	/** @rc_selected: tracks whether the user enabled GuC rc */
216d56c5da5c93c drivers/gpu/drm/i915/gt/uc/intel_guc.h Vinay Belgaumkar       2021-07-30  165  	bool rc_selected;
724df646c80374f drivers/gpu/drm/i915/gt/uc/intel_guc.h Michal Wajdeczko       2019-07-31  166  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  167  	/** @ads_vma: object allocated to hold the GuC ADS */
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  168  	struct i915_vma *ads_vma;
0df0c76cc3fd99d drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-16  169  	/** @ads_map: contents of the GuC ADS */
1c0b1175e6f3729 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-16  170  	struct iosys_map ads_map;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  171  	/** @ads_regset_size: size of the save/restore regsets in the ADS */
6de12da16678328 drivers/gpu/drm/i915/gt/uc/intel_guc.h John Harrison          2021-07-26  172  	u32 ads_regset_size;
bf8900406e9e5c9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-07  173  	/**
bf8900406e9e5c9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-07  174  	 * @ads_regset_count: number of save/restore registers in the ADS for
bf8900406e9e5c9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-07  175  	 * each engine
bf8900406e9e5c9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-07  176  	 */
bf8900406e9e5c9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-07  177  	u32 ads_regset_count[I915_NUM_ENGINES];
bf8900406e9e5c9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-07  178  	/** @ads_regset: save/restore regsets in the ADS */
bf8900406e9e5c9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Lucas De Marchi        2022-02-07  179  	struct guc_mmio_reg *ads_regset;
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  180  	/** @ads_golden_ctxt_size: size of the golden contexts in the ADS */
481d458caede241 drivers/gpu/drm/i915/gt/uc/intel_guc.h John Harrison          2021-07-26  181  	u32 ads_golden_ctxt_size;
24492514ccbd571 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-03-21  182  	/** @ads_capture_size: size of register lists in the ADS used for error capture */
24492514ccbd571 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-03-21  183  	u32 ads_capture_size;
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  184  	/** @ads_engine_usage_size: size of engine usage in the ADS */
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  185  	u32 ads_engine_usage_size;
f18819a3c8da62a drivers/gpu/drm/i915/intel_guc.h       Chris Wilson           2019-07-01  186  
774ce1510e6ccb9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2022-07-18  187  	/** @lrc_desc_pool_v69: object allocated to hold the GuC LRC descriptor pool */
774ce1510e6ccb9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2022-07-18  188  	struct i915_vma *lrc_desc_pool_v69;
774ce1510e6ccb9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2022-07-18  189  	/** @lrc_desc_pool_vaddr_v69: contents of the GuC LRC descriptor pool */
774ce1510e6ccb9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2022-07-18  190  	void *lrc_desc_pool_vaddr_v69;
774ce1510e6ccb9 drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2022-07-18  191  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  192  	/**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  193  	 * @context_lookup: used to resolve intel_context from guc_id, if a
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  194  	 * context is present in this structure it is registered with the GuC
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  195  	 */
27213d79b384d5b drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21  196  	struct xarray context_lookup;
27213d79b384d5b drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-07-21  197  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  198  	/** @params: Control params for fw initialization */
2bf8fb39eb70b6c drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2019-07-24  199  	u32 params[GUC_CTL_MAX_DWORDS];
2bf8fb39eb70b6c drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2019-07-24  200  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  201  	/** @send_regs: GuC's FW specific registers used for sending MMIO H2G */
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  202  	struct {
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  203  		u32 base;
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  204  		unsigned int count;
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  205  		enum forcewake_domains fw_domains;
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  206  	} send_regs;
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  207  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  208  	/** @notify_reg: register used to send interrupts to the GuC FW */
f20c6b278d1a0ce drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2019-12-16  209  	i915_reg_t notify_reg;
f20c6b278d1a0ce drivers/gpu/drm/i915/gt/uc/intel_guc.h Daniele Ceraolo Spurio 2019-12-16  210  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  211  	/**
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  212  	 * @mmio_msg: notification bitmask that the GuC writes in one of its
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  213  	 * registers when the CT channel is disabled, to be processed when the
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  214  	 * channel is back up.
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  215  	 */
2ae70d28f27f6a5 drivers/gpu/drm/i915/intel_guc.h       Daniele Ceraolo Spurio 2019-06-21  216  	u32 mmio_msg;
2ae70d28f27f6a5 drivers/gpu/drm/i915/intel_guc.h       Daniele Ceraolo Spurio 2019-06-21  217  
4f41ddc7c7eeb0a drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-09-09  218  	/** @send_mutex: used to serialize the intel_guc_send actions */
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  219  	struct mutex send_mutex;
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  220  
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  221  	/**
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  222  	 * @timestamp: GT timestamp object that stores a copy of the timestamp
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  223  	 * and adjusts it for overflow using a worker.
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  224  	 */
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  225  	struct {
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  226  		/**
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  227  		 * @lock: Lock protecting the below fields and the engine stats.
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  228  		 */
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  229  		spinlock_t lock;
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  230  
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  231  		/**
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  232  		 * @gt_stamp: 64 bit extended value of the GT timestamp.
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  233  		 */
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  234  		u64 gt_stamp;
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  235  
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  236  		/**
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  237  		 * @ping_delay: Period for polling the GT timestamp for
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  238  		 * overflow.
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  239  		 */
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  240  		unsigned long ping_delay;
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  241  
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  242  		/**
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  243  		 * @work: Periodic work to adjust GT timestamp, engine and
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  244  		 * context usage for overflows.
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  245  		 */
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  246  		struct delayed_work work;
721fd84ea1fe957 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2022-01-10  247  
721fd84ea1fe957 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2022-01-10  248  		/**
721fd84ea1fe957 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2022-01-10  249  		 * @shift: Right shift value for the gpm timestamp
721fd84ea1fe957 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2022-01-10  250  		 */
721fd84ea1fe957 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2022-01-10  251  		u32 shift;
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  252  
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  253  		/**
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  254  		 * @last_stat_jiffies: jiffies at last actual stats collection time
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  255  		 * We use this timestamp to ensure we don't oversample the
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  256  		 * stats because runtime power management events can trigger
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  257  		 * stats collection at much higher rates than required.
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  258  		 */
59bcdb564b3bac3 drivers/gpu/drm/i915/gt/uc/intel_guc.h Alan Previn            2022-06-22  259  		unsigned long last_stat_jiffies;
77cdd054dd2ced6 drivers/gpu/drm/i915/gt/uc/intel_guc.h Umesh Nerlige Ramappa  2021-10-26  260  	} timestamp;
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  261  
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  262  #ifdef CONFIG_DRM_I915_SELFTEST
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  263  	/**
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  264  	 * @number_guc_id_stolen: The number of guc_ids that have been stolen
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  265  	 */
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  266  	int number_guc_id_stolen;
0013f5f5c05da63 drivers/gpu/drm/i915/gt/uc/intel_guc.h Matthew Brost          2021-12-14  267  #endif
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04 @268  };
9bf384c5f21235d drivers/gpu/drm/i915/intel_guc.h       Michal Wajdeczko       2017-10-04  269  

:::::: The code at line 268 was first introduced by commit
:::::: 9bf384c5f21235d039bccf5d6e497c2c27986367 drm/i915/guc: Move GuC core definitions into dedicated files

:::::: TO: Michal Wajdeczko <michal.wajdeczko@intel.com>
:::::: CC: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

