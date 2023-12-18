Return-Path: <linux-kernel+bounces-4030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15F08176F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E638A1C259A8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE9D498B6;
	Mon, 18 Dec 2023 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgCZBDjv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645CAE57C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702915607; x=1734451607;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1ZbmZcYT2WQyDxcbmJwgS8Tne/xILXZ9OilHnK+eZfI=;
  b=QgCZBDjvjizITLhkfw/NwwO8ouascFOjqx7Itf85eJY3lxBPsTTZSkKx
   GmsZhSXPiGsG4F9IG2MUWcyuW9DFFrDr+OdSojJmdxitfvlWaEId8Ljrh
   8qiQ9WrVibwzBqg6DgYgZGZpFK9ELOJNUIN+E8MBy6oNgQINNBwyIUC4V
   8P3+Eli//L2SLTiivbuCwDSfLW3/Y7EGWqM4rBkzqMwRL/6Uo5rZlC9pj
   Cr4tHtW3FOdXl92iKT4cblLRcHeQmJ+SoETY0m5pAteyVuGR+Q5tYvcr4
   Nytgz3sUfa3KnCoKWoPNRGwBdlskG7CCkprK1iygasz/+gcU9BAoCfcRk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="394404008"
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="394404008"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 08:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,286,1695711600"; 
   d="scan'208";a="17229641"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 18 Dec 2023 08:06:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFG8U-0004HV-2k;
	Mon, 18 Dec 2023 16:06:30 +0000
Date: Tue, 19 Dec 2023 00:06:22 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <quic_kvalo@quicinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
	Carl Huang <quic_cjhuang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	P Praneesh <quic_ppranees@quicinc.com>,
	Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
	Sriram R <quic_srirrama@quicinc.com>,
	Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
	Wen Gong <quic_wgong@quicinc.com>
Subject: drivers/net/wireless/ath/ath12k/dp_mon.c:1244:24-34: Unneeded
 variable: "hal_status". Return "  HAL_RX_MON_STATUS_BUF_DONE" on line 1260
Message-ID: <202312182311.pZjA9dgQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: d889913205cf7ebda905b1e62c5867ed4e39f6c2 wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices
date:   1 year, 1 month ago
config: csky-randconfig-r053-20231218 (https://download.01.org/0day-ci/archive/20231218/202312182311.pZjA9dgQ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312182311.pZjA9dgQ-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/wireless/ath/ath12k/dp_mon.c:1244:24-34: Unneeded variable: "hal_status". Return "  HAL_RX_MON_STATUS_BUF_DONE" on line 1260
--
>> drivers/net/wireless/ath/ath12k/dp_rx.c:3866:3-6: ERROR: invalid reference to the index variable of the iterator on line 3856
   drivers/net/wireless/ath/ath12k/dp_rx.c:3866:29-32: ERROR: invalid reference to the index variable of the iterator on line 3856
--
>> drivers/net/wireless/ath/ath12k/wmi.c:6517:30-35: ERROR: invalid reference to the index variable of the iterator on line 6499

vim +1244 drivers/net/wireless/ath/ath12k/dp_mon.c

  1231	
  1232	enum hal_rx_mon_status
  1233	ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
  1234					  struct ath12k_mon_data *pmon,
  1235					  int mac_id,
  1236					  struct sk_buff *skb,
  1237					  struct napi_struct *napi)
  1238	{
  1239		struct ath12k_base *ab = ar->ab;
  1240		struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
  1241		struct dp_mon_mpdu *tmp;
  1242		struct dp_mon_mpdu *mon_mpdu = pmon->mon_mpdu;
  1243		struct sk_buff *head_msdu, *tail_msdu;
> 1244		enum hal_rx_mon_status hal_status = HAL_RX_MON_STATUS_BUF_DONE;
  1245	
  1246		ath12k_dp_mon_parse_rx_dest(ab, pmon, skb);
  1247	
  1248		list_for_each_entry_safe(mon_mpdu, tmp, &pmon->dp_rx_mon_mpdu_list, list) {
  1249			list_del(&mon_mpdu->list);
  1250			head_msdu = mon_mpdu->head;
  1251			tail_msdu = mon_mpdu->tail;
  1252	
  1253			if (head_msdu && tail_msdu) {
  1254				ath12k_dp_mon_rx_deliver(ar, mac_id, head_msdu,
  1255							 ppdu_info, napi);
  1256			}
  1257	
  1258			kfree(mon_mpdu);
  1259		}
> 1260		return hal_status;
  1261	}
  1262	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

