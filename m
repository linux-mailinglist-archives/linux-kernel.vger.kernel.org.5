Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5567C0092
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjJJPoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjJJPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:44:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED5EC9;
        Tue, 10 Oct 2023 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696952649; x=1728488649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mQdAMHJSD9QeDBBfFFi7Ka2I3dLUue9yP6ms4QhM3Vc=;
  b=E3aXiYMFMfgZMCN9LOOqwKYXoGuWvrYFH0WN1gnNzxz8s4Q8DpRJKPRj
   dpsjjtsfn8rmZcpGiN73NFm93DfmocBh/trHY66yC4N4sgG9og1rINQ1y
   ceGmNlx0Hp/C/c+6CrpDjjqbYqofMKGNv1Nx8CgsCfnnUA3zWdQGkKGey
   CXPmp8awdvlIPQ2a/s7psNkbTeW1HVA8n4Nd+JCJRqD54yKNH8Ulk+Y47
   BRKkbNvIRjj6xlL3eQS+Qhh5Zjtmt9HrENZl/4bEOb2cXxaLnOYyVQXe5
   i2+GstNxVrqtMU+3vlfapPzTydDqbd44r/Sp3cQErtc06bRBDmyoCunuk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="381685666"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="381685666"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 08:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="819284307"
X-IronPort-AV: E=Sophos;i="6.03,213,1694761200"; 
   d="scan'208";a="819284307"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Oct 2023 08:44:05 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqEtP-0000gE-0o;
        Tue, 10 Oct 2023 15:43:31 +0000
Date:   Tue, 10 Oct 2023 23:42:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_parass@quicinc.com,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH] bus: mhi: host: Add tracing support
Message-ID: <202310102355.6SEa9YSi-lkp@intel.com>
References: <20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005-ftrace_support-v1-1-23a2f394fa49@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 3006adf3be79cde4d14b1800b963b82b6e5572e0]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/bus-mhi-host-Add-tracing-support/20231005-231430
base:   3006adf3be79cde4d14b1800b963b82b6e5572e0
patch link:    https://lore.kernel.org/r/20231005-ftrace_support-v1-1-23a2f394fa49%40quicinc.com
patch subject: [PATCH] bus: mhi: host: Add tracing support
config: i386-randconfig-062-20231010 (https://download.01.org/0day-ci/archive/20231010/202310102355.6SEa9YSi-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310102355.6SEa9YSi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310102355.6SEa9YSi-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/bus/mhi/host/main.c:835:56: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long long [usertype] ptr @@     got restricted __le64 [usertype] ptr @@
   drivers/bus/mhi/host/main.c:835:56: sparse:     expected unsigned long long [usertype] ptr
   drivers/bus/mhi/host/main.c:835:56: sparse:     got restricted __le64 [usertype] ptr
>> drivers/bus/mhi/host/main.c:835:78: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected int dword0 @@     got restricted __le32 @@
   drivers/bus/mhi/host/main.c:835:78: sparse:     expected int dword0
   drivers/bus/mhi/host/main.c:835:78: sparse:     got restricted __le32
>> drivers/bus/mhi/host/main.c:836:63: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int dword1 @@     got restricted __le32 @@
   drivers/bus/mhi/host/main.c:836:63: sparse:     expected int dword1
   drivers/bus/mhi/host/main.c:836:63: sparse:     got restricted __le32
   drivers/bus/mhi/host/main.c:1004:85: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned long long [usertype] ptr @@     got restricted __le64 [usertype] ptr @@
   drivers/bus/mhi/host/main.c:1004:85: sparse:     expected unsigned long long [usertype] ptr
   drivers/bus/mhi/host/main.c:1004:85: sparse:     got restricted __le64 [usertype] ptr
   drivers/bus/mhi/host/main.c:1005:66: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int dword0 @@     got restricted __le32 @@
   drivers/bus/mhi/host/main.c:1005:66: sparse:     expected int dword0
   drivers/bus/mhi/host/main.c:1005:66: sparse:     got restricted __le32
   drivers/bus/mhi/host/main.c:1005:86: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected int dword1 @@     got restricted __le32 @@
   drivers/bus/mhi/host/main.c:1005:86: sparse:     expected int dword1
   drivers/bus/mhi/host/main.c:1005:86: sparse:     got restricted __le32
>> drivers/bus/mhi/host/main.c:1246:34: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned long long [usertype] tre_ptr @@     got restricted __le64 [usertype] ptr @@
   drivers/bus/mhi/host/main.c:1246:34: sparse:     expected unsigned long long [usertype] tre_ptr
   drivers/bus/mhi/host/main.c:1246:34: sparse:     got restricted __le64 [usertype] ptr
   drivers/bus/mhi/host/main.c:1246:55: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected int dword0 @@     got restricted __le32 @@
   drivers/bus/mhi/host/main.c:1246:55: sparse:     expected int dword0
   drivers/bus/mhi/host/main.c:1246:55: sparse:     got restricted __le32
   drivers/bus/mhi/host/main.c:1246:74: sparse: sparse: incorrect type in argument 6 (different base types) @@     expected int dword1 @@     got restricted __le32 @@
   drivers/bus/mhi/host/main.c:1246:74: sparse:     expected int dword1
   drivers/bus/mhi/host/main.c:1246:74: sparse:     got restricted __le32
>> drivers/bus/mhi/host/main.c:834:80: sparse: sparse: non size-preserving pointer to integer cast
   drivers/bus/mhi/host/main.c:1245:75: sparse: sparse: non size-preserving pointer to integer cast

vim +835 drivers/bus/mhi/host/main.c

   799	
   800	int mhi_process_ctrl_ev_ring(struct mhi_controller *mhi_cntrl,
   801				     struct mhi_event *mhi_event,
   802				     u32 event_quota)
   803	{
   804		struct mhi_ring_element *dev_rp, *local_rp;
   805		struct mhi_ring *ev_ring = &mhi_event->ring;
   806		struct mhi_event_ctxt *er_ctxt =
   807			&mhi_cntrl->mhi_ctxt->er_ctxt[mhi_event->er_index];
   808		struct mhi_chan *mhi_chan;
   809		struct device *dev = &mhi_cntrl->mhi_dev->dev;
   810		u32 chan;
   811		int count = 0;
   812		dma_addr_t ptr = le64_to_cpu(er_ctxt->rp);
   813	
   814		/*
   815		 * This is a quick check to avoid unnecessary event processing
   816		 * in case MHI is already in error state, but it's still possible
   817		 * to transition to error state while processing events
   818		 */
   819		if (unlikely(MHI_EVENT_ACCESS_INVALID(mhi_cntrl->pm_state)))
   820			return -EIO;
   821	
   822		if (!is_valid_ring_ptr(ev_ring, ptr)) {
   823			dev_err(&mhi_cntrl->mhi_dev->dev,
   824				"Event ring rp points outside of the event ring\n");
   825			return -EIO;
   826		}
   827	
   828		dev_rp = mhi_to_virtual(ev_ring, ptr);
   829		local_rp = ev_ring->rp;
   830	
   831		while (dev_rp != local_rp) {
   832			enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
   833	
 > 834			trace_mhi_process_ctrl_ev_ring(mhi_cntrl->mhi_dev->name, (u64)(local_rp),
 > 835						       local_rp->ptr, local_rp->dword[0],
 > 836						       local_rp->dword[1],
   837						       mhi_state_str(MHI_TRE_GET_EV_STATE(local_rp)));
   838	
   839			switch (type) {
   840			case MHI_PKT_TYPE_BW_REQ_EVENT:
   841			{
   842				struct mhi_link_info *link_info;
   843	
   844				link_info = &mhi_cntrl->mhi_link_info;
   845				write_lock_irq(&mhi_cntrl->pm_lock);
   846				link_info->target_link_speed =
   847					MHI_TRE_GET_EV_LINKSPEED(local_rp);
   848				link_info->target_link_width =
   849					MHI_TRE_GET_EV_LINKWIDTH(local_rp);
   850				write_unlock_irq(&mhi_cntrl->pm_lock);
   851				dev_dbg(dev, "Received BW_REQ event\n");
   852				mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_BW_REQ);
   853				break;
   854			}
   855			case MHI_PKT_TYPE_STATE_CHANGE_EVENT:
   856			{
   857				enum mhi_state new_state;
   858	
   859				new_state = MHI_TRE_GET_EV_STATE(local_rp);
   860	
   861				dev_dbg(dev, "State change event to state: %s\n",
   862					mhi_state_str(new_state));
   863	
   864				switch (new_state) {
   865				case MHI_STATE_M0:
   866					mhi_pm_m0_transition(mhi_cntrl);
   867					break;
   868				case MHI_STATE_M1:
   869					mhi_pm_m1_transition(mhi_cntrl);
   870					break;
   871				case MHI_STATE_M3:
   872					mhi_pm_m3_transition(mhi_cntrl);
   873					break;
   874				case MHI_STATE_SYS_ERR:
   875				{
   876					enum mhi_pm_state pm_state;
   877	
   878					dev_dbg(dev, "System error detected\n");
   879					write_lock_irq(&mhi_cntrl->pm_lock);
   880					pm_state = mhi_tryset_pm_state(mhi_cntrl,
   881								MHI_PM_SYS_ERR_DETECT);
   882					write_unlock_irq(&mhi_cntrl->pm_lock);
   883					if (pm_state == MHI_PM_SYS_ERR_DETECT)
   884						mhi_pm_sys_err_handler(mhi_cntrl);
   885					break;
   886				}
   887				default:
   888					dev_err(dev, "Invalid state: %s\n",
   889						mhi_state_str(new_state));
   890				}
   891	
   892				break;
   893			}
   894			case MHI_PKT_TYPE_CMD_COMPLETION_EVENT:
   895				mhi_process_cmd_completion(mhi_cntrl, local_rp);
   896				break;
   897			case MHI_PKT_TYPE_EE_EVENT:
   898			{
   899				enum dev_st_transition st = DEV_ST_TRANSITION_MAX;
   900				enum mhi_ee_type event = MHI_TRE_GET_EV_EXECENV(local_rp);
   901	
   902				dev_dbg(dev, "Received EE event: %s\n",
   903					TO_MHI_EXEC_STR(event));
   904				switch (event) {
   905				case MHI_EE_SBL:
   906					st = DEV_ST_TRANSITION_SBL;
   907					break;
   908				case MHI_EE_WFW:
   909				case MHI_EE_AMSS:
   910					st = DEV_ST_TRANSITION_MISSION_MODE;
   911					break;
   912				case MHI_EE_FP:
   913					st = DEV_ST_TRANSITION_FP;
   914					break;
   915				case MHI_EE_RDDM:
   916					mhi_cntrl->status_cb(mhi_cntrl, MHI_CB_EE_RDDM);
   917					write_lock_irq(&mhi_cntrl->pm_lock);
   918					mhi_cntrl->ee = event;
   919					write_unlock_irq(&mhi_cntrl->pm_lock);
   920					wake_up_all(&mhi_cntrl->state_event);
   921					break;
   922				default:
   923					dev_err(dev,
   924						"Unhandled EE event: 0x%x\n", type);
   925				}
   926				if (st != DEV_ST_TRANSITION_MAX)
   927					mhi_queue_state_transition(mhi_cntrl, st);
   928	
   929				break;
   930			}
   931			case MHI_PKT_TYPE_TX_EVENT:
   932				chan = MHI_TRE_GET_EV_CHID(local_rp);
   933	
   934				WARN_ON(chan >= mhi_cntrl->max_chan);
   935	
   936				/*
   937				 * Only process the event ring elements whose channel
   938				 * ID is within the maximum supported range.
   939				 */
   940				if (chan < mhi_cntrl->max_chan) {
   941					mhi_chan = &mhi_cntrl->mhi_chan[chan];
   942					if (!mhi_chan->configured)
   943						break;
   944					parse_xfer_event(mhi_cntrl, local_rp, mhi_chan);
   945				}
   946				break;
   947			default:
   948				dev_err(dev, "Unhandled event type: %d\n", type);
   949				break;
   950			}
   951	
   952			mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
   953			local_rp = ev_ring->rp;
   954	
   955			ptr = le64_to_cpu(er_ctxt->rp);
   956			if (!is_valid_ring_ptr(ev_ring, ptr)) {
   957				dev_err(&mhi_cntrl->mhi_dev->dev,
   958					"Event ring rp points outside of the event ring\n");
   959				return -EIO;
   960			}
   961	
   962			dev_rp = mhi_to_virtual(ev_ring, ptr);
   963			count++;
   964		}
   965	
   966		read_lock_bh(&mhi_cntrl->pm_lock);
   967	
   968		/* Ring EV DB only if there is any pending element to process */
   969		if (likely(MHI_DB_ACCESS_VALID(mhi_cntrl)) && count)
   970			mhi_ring_er_db(mhi_event);
   971		read_unlock_bh(&mhi_cntrl->pm_lock);
   972	
   973		return count;
   974	}
   975	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
