Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFB7DFE8A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjKCESm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKCESj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:18:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59949112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 21:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698985113; x=1730521113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dX3xfEOVCaICj0UaSWc3WZRDgV4paeCfCFGLU2rsjMU=;
  b=E8k1bl9k10CbBcpnjjZwwKbHjCfOpBtiuQpmpoPPBbDW2hfsaK3ZFAEO
   boLEMXkDFD1j1UZzEa1ze+fkoLbv7hVxaPehpT65Y+xJwX7xcpcx2T+Xp
   pO2ySGzBoBuzxuvRfyPiXnZlneiUQtMnl4PokPV3um9wD6cwPLenRiguX
   q8HcBT/ZFsX5lS84AjkqxwCdnTuTlv2nRXccezzEhAlAKz5GpZOU6UOs9
   NUYgDYf6ezvdmUzkRJUFUEhreVEHuRBIQMd/cs61gBNkGk1nj+BtQQUTb
   1WwYLFgNrfW/o7gq5KBqA78DAUbV5SFLmoPgLp3HX19F9r5e76pQ4EQW2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="453171147"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="453171147"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 21:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="885105189"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="885105189"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2023 21:18:30 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyldc-0002D8-1q;
        Fri, 03 Nov 2023 04:18:28 +0000
Date:   Fri, 3 Nov 2023 12:17:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse: sparse: incorrect type
 in initializer (different base types)
Message-ID: <202311031255.lmSPisIk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   431f1051884e38d2a5751e4731d69b2ff289ee56
commit: 2e5a6c3baccd31476ed00c3fbc413b48ddd87993 scsi: bfa: Convert bfad_reset_sdev_bflags() from a macro into a function
date:   12 months ago
config: i386-randconfig-063-20231103 (https://download.01.org/0day-ci/archive/20231103/202311031255.lmSPisIk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311031255.lmSPisIk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311031255.lmSPisIk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/scsi/bfa/bfad_bsg.c:2391:25: sparse: sparse: cast to restricted __be32
   drivers/scsi/bfa/bfad_bsg.c:2414:38: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfad_bsg.c:2415:38: sparse: sparse: cast to restricted __be16
   drivers/scsi/bfa/bfad_bsg.c:2417:33: sparse: sparse: cast to restricted __be32
>> drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int const [usertype] scan_flags @@     got restricted blist_flags_t @@
   drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse:     expected unsigned int const [usertype] scan_flags
   drivers/scsi/bfa/bfad_bsg.c:2553:50: sparse:     got restricted blist_flags_t
   drivers/scsi/bfa/bfad_bsg.c:2562:51: sparse: sparse: invalid assignment: |=
   drivers/scsi/bfa/bfad_bsg.c:2562:51: sparse:    left side has type restricted blist_flags_t
   drivers/scsi/bfa/bfad_bsg.c:2562:51: sparse:    right side has type unsigned int
   drivers/scsi/bfa/bfad_bsg.c:2564:51: sparse: sparse: invalid assignment: &=
   drivers/scsi/bfa/bfad_bsg.c:2564:51: sparse:    left side has type restricted blist_flags_t
   drivers/scsi/bfa/bfad_bsg.c:2564:51: sparse:    right side has type unsigned int
   drivers/scsi/bfa/bfad_bsg.c:3407:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void * @@
   drivers/scsi/bfa/bfad_bsg.c:3407:34: sparse:     expected void const [noderef] __user *from
   drivers/scsi/bfa/bfad_bsg.c:3407:34: sparse:     got void *
   drivers/scsi/bfa/bfad_bsg.c:3561:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got void * @@
   drivers/scsi/bfa/bfad_bsg.c:3561:27: sparse:     expected void [noderef] __user *to
   drivers/scsi/bfa/bfad_bsg.c:3561:27: sparse:     got void *

vim +2553 drivers/scsi/bfa/bfad_bsg.c

  2376	
  2377	static int
  2378	bfad_iocmd_qos_get_attr(struct bfad_s *bfad, void *cmd)
  2379	{
  2380		struct bfa_bsg_qos_attr_s *iocmd = (struct bfa_bsg_qos_attr_s *)cmd;
  2381		struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
  2382		unsigned long	flags;
  2383	
  2384		spin_lock_irqsave(&bfad->bfad_lock, flags);
  2385		if ((fcport->cfg.topology == BFA_PORT_TOPOLOGY_LOOP) &&
  2386			(fcport->topology == BFA_PORT_TOPOLOGY_LOOP))
  2387			iocmd->status = BFA_STATUS_TOPOLOGY_LOOP;
  2388		else {
  2389			iocmd->attr.state = fcport->qos_attr.state;
  2390			iocmd->attr.total_bb_cr =
> 2391				be32_to_cpu(fcport->qos_attr.total_bb_cr);
  2392			iocmd->attr.qos_bw.high = fcport->cfg.qos_bw.high;
  2393			iocmd->attr.qos_bw.med = fcport->cfg.qos_bw.med;
  2394			iocmd->attr.qos_bw.low = fcport->cfg.qos_bw.low;
  2395			iocmd->attr.qos_bw_op = fcport->qos_attr.qos_bw_op;
  2396			iocmd->status = BFA_STATUS_OK;
  2397		}
  2398		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2399	
  2400		return 0;
  2401	}
  2402	
  2403	static int
  2404	bfad_iocmd_qos_get_vc_attr(struct bfad_s *bfad, void *cmd)
  2405	{
  2406		struct bfa_bsg_qos_vc_attr_s *iocmd =
  2407					(struct bfa_bsg_qos_vc_attr_s *)cmd;
  2408		struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
  2409		struct bfa_qos_vc_attr_s *bfa_vc_attr = &fcport->qos_vc_attr;
  2410		unsigned long	flags;
  2411		u32	i = 0;
  2412	
  2413		spin_lock_irqsave(&bfad->bfad_lock, flags);
  2414		iocmd->attr.total_vc_count = be16_to_cpu(bfa_vc_attr->total_vc_count);
  2415		iocmd->attr.shared_credit  = be16_to_cpu(bfa_vc_attr->shared_credit);
  2416		iocmd->attr.elp_opmode_flags  =
  2417					be32_to_cpu(bfa_vc_attr->elp_opmode_flags);
  2418	
  2419		/* Individual VC info */
  2420		while (i < iocmd->attr.total_vc_count) {
  2421			iocmd->attr.vc_info[i].vc_credit =
  2422					bfa_vc_attr->vc_info[i].vc_credit;
  2423			iocmd->attr.vc_info[i].borrow_credit =
  2424					bfa_vc_attr->vc_info[i].borrow_credit;
  2425			iocmd->attr.vc_info[i].priority =
  2426					bfa_vc_attr->vc_info[i].priority;
  2427			i++;
  2428		}
  2429		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2430	
  2431		iocmd->status = BFA_STATUS_OK;
  2432		return 0;
  2433	}
  2434	
  2435	static int
  2436	bfad_iocmd_qos_get_stats(struct bfad_s *bfad, void *cmd)
  2437	{
  2438		struct bfa_bsg_fcport_stats_s *iocmd =
  2439					(struct bfa_bsg_fcport_stats_s *)cmd;
  2440		struct bfad_hal_comp fcomp;
  2441		unsigned long	flags;
  2442		struct bfa_cb_pending_q_s cb_qe;
  2443		struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
  2444	
  2445		init_completion(&fcomp.comp);
  2446		bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
  2447				   &fcomp, &iocmd->stats);
  2448	
  2449		spin_lock_irqsave(&bfad->bfad_lock, flags);
  2450		WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
  2451		if ((fcport->cfg.topology == BFA_PORT_TOPOLOGY_LOOP) &&
  2452			(fcport->topology == BFA_PORT_TOPOLOGY_LOOP))
  2453			iocmd->status = BFA_STATUS_TOPOLOGY_LOOP;
  2454		else
  2455			iocmd->status = bfa_fcport_get_stats(&bfad->bfa, &cb_qe);
  2456		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2457		if (iocmd->status != BFA_STATUS_OK) {
  2458			bfa_trc(bfad, iocmd->status);
  2459			goto out;
  2460		}
  2461		wait_for_completion(&fcomp.comp);
  2462		iocmd->status = fcomp.status;
  2463	out:
  2464		return 0;
  2465	}
  2466	
  2467	static int
  2468	bfad_iocmd_qos_reset_stats(struct bfad_s *bfad, void *cmd)
  2469	{
  2470		struct bfa_bsg_gen_s *iocmd = (struct bfa_bsg_gen_s *)cmd;
  2471		struct bfad_hal_comp fcomp;
  2472		unsigned long	flags;
  2473		struct bfa_cb_pending_q_s cb_qe;
  2474		struct bfa_fcport_s *fcport = BFA_FCPORT_MOD(&bfad->bfa);
  2475	
  2476		init_completion(&fcomp.comp);
  2477		bfa_pending_q_init(&cb_qe, (bfa_cb_cbfn_t)bfad_hcb_comp,
  2478				   &fcomp, NULL);
  2479	
  2480		spin_lock_irqsave(&bfad->bfad_lock, flags);
  2481		WARN_ON(!bfa_ioc_get_fcmode(&bfad->bfa.ioc));
  2482		if ((fcport->cfg.topology == BFA_PORT_TOPOLOGY_LOOP) &&
  2483			(fcport->topology == BFA_PORT_TOPOLOGY_LOOP))
  2484			iocmd->status = BFA_STATUS_TOPOLOGY_LOOP;
  2485		else
  2486			iocmd->status = bfa_fcport_clear_stats(&bfad->bfa, &cb_qe);
  2487		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2488		if (iocmd->status != BFA_STATUS_OK) {
  2489			bfa_trc(bfad, iocmd->status);
  2490			goto out;
  2491		}
  2492		wait_for_completion(&fcomp.comp);
  2493		iocmd->status = fcomp.status;
  2494	out:
  2495		return 0;
  2496	}
  2497	
  2498	static int
  2499	bfad_iocmd_vf_get_stats(struct bfad_s *bfad, void *cmd)
  2500	{
  2501		struct bfa_bsg_vf_stats_s *iocmd =
  2502				(struct bfa_bsg_vf_stats_s *)cmd;
  2503		struct bfa_fcs_fabric_s	*fcs_vf;
  2504		unsigned long	flags;
  2505	
  2506		spin_lock_irqsave(&bfad->bfad_lock, flags);
  2507		fcs_vf = bfa_fcs_vf_lookup(&bfad->bfa_fcs, iocmd->vf_id);
  2508		if (fcs_vf == NULL) {
  2509			spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2510			iocmd->status = BFA_STATUS_UNKNOWN_VFID;
  2511			goto out;
  2512		}
  2513		memcpy((void *)&iocmd->stats, (void *)&fcs_vf->stats,
  2514			sizeof(struct bfa_vf_stats_s));
  2515		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2516		iocmd->status = BFA_STATUS_OK;
  2517	out:
  2518		return 0;
  2519	}
  2520	
  2521	static int
  2522	bfad_iocmd_vf_clr_stats(struct bfad_s *bfad, void *cmd)
  2523	{
  2524		struct bfa_bsg_vf_reset_stats_s *iocmd =
  2525				(struct bfa_bsg_vf_reset_stats_s *)cmd;
  2526		struct bfa_fcs_fabric_s	*fcs_vf;
  2527		unsigned long	flags;
  2528	
  2529		spin_lock_irqsave(&bfad->bfad_lock, flags);
  2530		fcs_vf = bfa_fcs_vf_lookup(&bfad->bfa_fcs, iocmd->vf_id);
  2531		if (fcs_vf == NULL) {
  2532			spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2533			iocmd->status = BFA_STATUS_UNKNOWN_VFID;
  2534			goto out;
  2535		}
  2536		memset((void *)&fcs_vf->stats, 0, sizeof(struct bfa_vf_stats_s));
  2537		spin_unlock_irqrestore(&bfad->bfad_lock, flags);
  2538		iocmd->status = BFA_STATUS_OK;
  2539	out:
  2540		return 0;
  2541	}
  2542	
  2543	/*
  2544	 * Set the SCSI device sdev_bflags - sdev_bflags are used by the
  2545	 * SCSI mid-layer to choose LUN Scanning mode REPORT_LUNS vs. Sequential Scan
  2546	 *
  2547	 * Internally iterates over all the ITNIM's part of the im_port & sets the
  2548	 * sdev_bflags for the scsi_device associated with LUN #0.
  2549	 */
  2550	static void bfad_reset_sdev_bflags(struct bfad_im_port_s *im_port,
  2551					   int lunmask_cfg)
  2552	{
> 2553		const u32 scan_flags = BLIST_NOREPORTLUN | BLIST_SPARSELUN;
  2554		struct bfad_itnim_s *itnim;
  2555		struct scsi_device *sdev;
  2556	
  2557		list_for_each_entry(itnim, &im_port->itnim_mapped_list, list_entry) {
  2558			sdev = scsi_device_lookup(im_port->shost, itnim->channel,
  2559						  itnim->scsi_tgt_id, 0);
  2560			if (sdev) {
  2561				if (lunmask_cfg == BFA_TRUE)
  2562					sdev->sdev_bflags |= scan_flags;
  2563				else
  2564					sdev->sdev_bflags &= ~scan_flags;
  2565				scsi_device_put(sdev);
  2566			}
  2567		}
  2568	}
  2569	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
