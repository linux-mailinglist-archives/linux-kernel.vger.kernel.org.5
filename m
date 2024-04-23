Return-Path: <linux-kernel+bounces-155537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7D58AF3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82761287A03
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE7313D254;
	Tue, 23 Apr 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIE8LRDu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80413D503;
	Tue, 23 Apr 2024 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888882; cv=none; b=FGhqfbozAV0w3AFGiJhoK1aCZe+LugiqHmu+gRlKTtQybO50fCUQTA+hbRKqPfNMRwcEkC5jb+TubFBYBmHeWr/kw+2MgJO5+04/zPagvWcnA9Hx8EaFimPzhGH9jJKcxJuf1hgLuBakrNgNB8sFzo3iPA1jQBhjsVtbwycLafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888882; c=relaxed/simple;
	bh=Vv3Pzh/tN2YWuj6VkDSluT/ePBD6u8OspryaSNQWcRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agbuo2DZ4ZXNacqRbhGYpv64cFA9j9YsTRXUmwI7Ge/n1NkxNyzJS6HgVaOHvZfxEJnu17qmu+NVopARp0S1VVDUcw2d0rDUx2M2T3A1hcEbYcp2xcvtQi1EjMXBi9Yw/uPGq3oSJANykODNhswNOFBVL+csCv0y2HZypzBYfe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIE8LRDu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713888879; x=1745424879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vv3Pzh/tN2YWuj6VkDSluT/ePBD6u8OspryaSNQWcRw=;
  b=FIE8LRDusZT/64f6dle62V0br9FMckHgrXIHb7Ryhq2nlLPikDrJPTGZ
   /m/aG6Ln7zyHvMMt25AOov2u9wzKdbWU+JXc5j0XDZNOZkcqL1u5r4i7P
   xY/G0sXZkCfDozFlSclOwVRMKEy1Ne8yZaEG6ZEvWwfSu/pdiOj7hkvWS
   GJ+wau+biIbTPJzKqkeZc4v+gcJFATi1xmToWxdC3JnKmhtSE0QyFsKvK
   b8XpLURI0O22boBOauoVte4YDXCkEhi4Oc/x8KGRU+ygtF7ZMk42KkWLK
   kfdO3WKmaoH/XsSd/bdkSAbRQ/p8CwtUN44dRZDUZaCtYCcBDOzUqKBSR
   w==;
X-CSE-ConnectionGUID: vARbTaijTZm9nbIwetNcRg==
X-CSE-MsgGUID: d0fs90R3QP+hcLDknxElUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="31978014"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="31978014"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 09:14:39 -0700
X-CSE-ConnectionGUID: OyVmfELgT4+8rSOzi26oTg==
X-CSE-MsgGUID: fz3MNTTYSMOIFOVkv5qZ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24414604"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 23 Apr 2024 09:14:35 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rzImv-0000JI-1k;
	Tue, 23 Apr 2024 16:14:33 +0000
Date: Wed, 24 Apr 2024 00:13:39 +0800
From: kernel test robot <lkp@intel.com>
To: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org, davem@davemloft.net,
	pabeni@redhat.com, edumazet@google.com, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 5/9] octeontx2-af: Add packet path between
 representor and VF
Message-ID: <202404240058.p4HzPiSt-lkp@intel.com>
References: <20240422095401.14245-6-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-6-gakula@marvell.com>

Hi Geetha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20240422]
[also build test WARNING on v6.9-rc5]
[cannot apply to net-next/main linus/master horms-ipvs/master v6.9-rc5 v6.9-rc4 v6.9-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Geetha-sowjanya/octeontx2-pf-Refactoring-RVU-driver/20240422-175819
base:   next-20240422
patch link:    https://lore.kernel.org/r/20240422095401.14245-6-gakula%40marvell.com
patch subject: [net-next PATCH v2 5/9] octeontx2-af: Add packet path between representor and VF
config: alpha-randconfig-r122-20240423 (https://download.01.org/0day-ci/archive/20240424/202404240058.p4HzPiSt-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240424/202404240058.p4HzPiSt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404240058.p4HzPiSt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:39:38: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:39:38: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:39:38: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:39:38: sparse: sparse: cast to restricted __be16
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:95:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [assigned] [usertype] vlan_etype @@     got int @@
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:95:31: sparse:     expected restricted __be16 [assigned] [usertype] vlan_etype
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:95:31: sparse:     got int
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:96:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [assigned] [usertype] vlan_etype @@     got int @@
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:96:29: sparse:     expected restricted __be16 [assigned] [usertype] vlan_etype
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:96:29: sparse:     got int
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:97:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [assigned] [usertype] vlan_tci @@     got unsigned short [assigned] [usertype] vlan_tci @@
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:97:29: sparse:     expected restricted __be16 [assigned] [usertype] vlan_tci
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:97:29: sparse:     got unsigned short [assigned] [usertype] vlan_tci
>> drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:98:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [assigned] [usertype] vlan_tci @@     got int @@
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:98:27: sparse:     expected restricted __be16 [assigned] [usertype] vlan_tci
   drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c:98:27: sparse:     got int

vim +39 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c

    25	
    26	static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
    27				       u16 vlan_tci, int *vidx)
    28	{
    29		struct nix_vtag_config_rsp rsp = {};
    30		struct nix_vtag_config req = {};
    31		u64 etype = ETH_P_8021Q;
    32		int err;
    33	
    34		/* Insert vlan tag */
    35		req.hdr.pcifunc = pcifunc;
    36		req.vtag_size = VTAGSIZE_T4;
    37		req.cfg_type = 0; /* tx vlan cfg */
    38		req.tx.cfg_vtag0 = true;
  > 39		req.tx.vtag0 = etype << 48 | ntohs(vlan_tci);
    40	
    41		err = rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
    42		if (err) {
    43			dev_err(rvu->dev, "Tx vlan config failed\n");
    44			return err;
    45		}
    46		*vidx = rsp.vtag0_idx;
    47		return 0;
    48	}
    49	
    50	static int rvu_rep_rx_vlan_cfg(struct rvu *rvu, u16 pcifunc)
    51	{
    52		struct nix_vtag_config req = {};
    53		struct nix_vtag_config_rsp rsp;
    54	
    55		/* config strip, capture and size */
    56		req.hdr.pcifunc = pcifunc;
    57		req.vtag_size = VTAGSIZE_T4;
    58		req.cfg_type = 1; /* rx vlan cfg */
    59		req.rx.vtag_type = NIX_AF_LFX_RX_VTAG_TYPE0;
    60		req.rx.strip_vtag = true;
    61		req.rx.capture_vtag = false;
    62	
    63		return rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
    64	}
    65	
    66	static int rvu_rep_install_rx_rule(struct rvu *rvu, u16 pcifunc,
    67					   u16 entry, bool rte)
    68	{
    69		struct npc_install_flow_req req = {};
    70		struct npc_install_flow_rsp rsp = {};
    71		struct rvu_pfvf *pfvf;
    72		u16 vlan_tci, rep_id;
    73	
    74		pfvf = rvu_get_pfvf(rvu, pcifunc);
    75	
    76		/* To stree the traffic from Representee to Representor */
    77		rep_id = (u16)rvu_rep_get_vlan_id(rvu, pcifunc);
    78		if (rte) {
    79			vlan_tci = rep_id | 0x1ull << 8;
    80			req.vf = rvu->rep_pcifunc;
    81			req.op = NIX_RX_ACTIONOP_UCAST;
    82			req.index = rep_id;
    83		} else {
    84			vlan_tci = rep_id;
    85			req.vf = pcifunc;
    86			req.op = NIX_RX_ACTION_DEFAULT;
    87		}
    88	
    89		rvu_rep_rx_vlan_cfg(rvu, req.vf);
    90		req.entry = entry;
    91		req.hdr.pcifunc = 0; /* AF is requester */
    92		req.features = BIT_ULL(NPC_OUTER_VID) | BIT_ULL(NPC_VLAN_ETYPE_CTAG);
    93		req.vtag0_valid = true;
    94		req.vtag0_type = NIX_AF_LFX_RX_VTAG_TYPE0;
  > 95		req.packet.vlan_etype = ETH_P_8021Q;
    96		req.mask.vlan_etype = ETH_P_8021Q;
  > 97		req.packet.vlan_tci = vlan_tci;
  > 98		req.mask.vlan_tci = 0xffff;
    99	
   100		req.channel = RVU_SWITCH_LBK_CHAN;
   101		req.chan_mask = 0xffff;
   102		req.intf = pfvf->nix_rx_intf;
   103	
   104		return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
   105	}
   106	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

