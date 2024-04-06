Return-Path: <linux-kernel+bounces-133851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA689A9BA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDFC283880
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A21249FF;
	Sat,  6 Apr 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="M9jj1B+l"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242A81EB40;
	Sat,  6 Apr 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712391129; cv=none; b=Tz6T+K9bgvWyaWxk//JPfAny1/+zOHqLFBFhylKZA7uvHjGTE4FXb4vLhpAa2WWWmypbFN5GV8c1OBFfdPDW/jlhjLUqToZWN0T2Twh0H+oaH3XvSYdzxwj2MakgnZRgYCzk5jXn+78TSv5hZ4Nf9Zo8bKkg6aGq2biz9/6vPMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712391129; c=relaxed/simple;
	bh=aWf5pSZLUsdnn16jPhoQuV6DiBeHMtampzsnziXCRVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=reETpE163DInVWDtmK2R6PkBfsSj3oxkyr6L6mRD29lSAVQLYe6udJWBkv58/LrwO4SoB5yrHAuXiOKNBB0VK46zQy1VxsrhfrbEeoDlHY4vNVkQvIsrD0uUtxwY2jIIL8GFnjs0QiZg9uLx/jgibnZvh/9q9MMPPFo8XFkF08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=M9jj1B+l; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 17E5E1B24BF;
	Sat,  6 Apr 2024 10:12:05 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1712391125; bh=ZxNgUKAyIwv4+Cogy0VobezkIMJAIKV1c3sCN/kVg+8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M9jj1B+l+y/zOaBW84NSfFbxs8Yh4JohdWvQi/fzdCRHES5AbuoNrhI+NOZqOqvy1
	 r9VfMkAa50tYDQmkx8XGEGH4bkAroyDaqZu4G6oH+1bm/Rfh9YWpkxYxCPBcL7TExc
	 cFWF8lpahQr+v08yC9r9rBLMJF7472dyFmkjpJprhMYwunHt1y+WpFXCJM7yxWeT+S
	 8GPvWTgUM8d2W4q+ssEtxT6X+XFxjUvIPO8hA7gdCyB0DkcuFn+84WEs/kMtInC4vU
	 foJU0To0HvAYRFxVLVcRxznZ4lhEiHkOxy0T9rGOTMXEonTUt6jtxgFFLBnrxJYwnL
	 Z3NIkoDgoRldQ==
Date: Sat, 6 Apr 2024 10:12:04 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, open list <netdev@vger.kernel.org>, Linux
 regressions mailing list <regressions@lists.linux.dev>, open list
 <linux-kernel@vger.kernel.org>, "Linux regression tracking (Thorsten
 Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net] u64_stats: fix u64_stats_init() for lockdep when
 used repeatedly in one file
Message-ID: <20240406101204.1f7827ae@meshulam.tesarici.cz>
In-Reply-To: <20240405195117.GV26556@kernel.org>
References: <20240404075740.30682-1-petr@tesarici.cz>
	<20240405195117.GV26556@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Apr 2024 20:51:17 +0100
Simon Horman <horms@kernel.org> wrote:

> On Thu, Apr 04, 2024 at 09:57:40AM +0200, Petr Tesarik wrote:
> > Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> > initialized in the same file.
> > 
> > With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
> > 
> > 	static struct lock_class_key __key;
> > 
> > Since u64_stats_init() is a function (albeit an inline one), all calls
> > within the same file end up using the same instance, effectively treating
> > them all as a single lock-class.
> > 
> > Fixes: 9464ca650008 ("net: make u64_stats_init() a function")
> > Closes: https://lore.kernel.org/netdev/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/
> > Signed-off-by: Petr Tesarik <petr@tesarici.cz>  
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Interesting bug. I'm wondering if you also looked over other users of
> u64_stats_init() to see if any of them can result in unexpected aliasing of
> lock keys too.

I didn't.

I have now run `git grep u64_stats_init | sed -e 's/:.*//' | uniq -d`
and there indeed appears to be some aliasing in other files.

block/blk-cgroup.c:
- struct blkg_iostat_set.sync
- struct blkg_iostat_set.sync

drivers/net/ethernet/amazon/ena/ena_netdev.c:
- struct ena_ring.syncp
  struct ena_adapter.syncp

drivers/net/ethernet/aquantia/atlantic/aq_ring.c:
- struct aq_ring_stats_tx_s.syncp
- struct aq_ring_stats_rx_s.syncp

drivers/net/ethernet/emulex/benet/be_main.c:
- struct be_tx_stats.sync
  + aliasing between this struct in
    - struct be_tx_obj
    - struct be_rx_obj
- struct be_tx_stats.sync_compl

drivers/net/ethernet/google/gve/gve_main.c:
- struct gve_priv.rx[].statss
- struct gve_priv.tx[].statss

drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:
- tx_ring->syncp
- rx_ring->syncp

drivers/net/ethernet/intel/i40e/i40e_txrx.c:
- tx_ring->syncp
- rx_ring->syncp

drivers/net/ethernet/intel/igb/igb_main.c:
- struct igb_ring.tx_syncp
- struct igb_ring.tx_syncp2
- struct igb_ring.rx_syncp

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:
- struct ixgbe_adapter.rx_ring[]->syncp
- struct ixgbe_adapter.tx_ring[]->syncp
- struct ixgbe_adapter.xdp_ring[]->syncp

drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:
- tx_ring->syncp
- rx_ring->syncp

drivers/net/ethernet/marvell/sky2.c:
- struct sky2_port.tx_stats.syncp
- struct sky2_port.rx_stats.syncp

drivers/net/ethernet/microsoft/mana/mana_en.c:
- struct mana_txq.stats.syncp
- struct mana_rxq.stats.syncp

drivers/net/ethernet/netronome/nfp/nfp_net_dp.c:
- struct nfp_net_tx_ring.r_vec->tx_sync
- struct nfp_net_rx_ring.r_vec->rx_sync

drivers/net/ethernet/nvidia/forcedeth.c:
- struct fe_priv.swstats_tx_syncp
- struct fe_priv.swstats_rx_syncp

drivers/net/ethernet/realtek/8139too.c:
- struct rtl8139_private.tx_stats.syncp
- struct rtl8139_private.rx_stats.syncp

drivers/net/ethernet/socionext/sni_ave.c:
- struct ave_private.stats_tx.syncp
- struct ave_private.stats_rx.syncp

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:
- this was the trigger ;-)

drivers/net/ethernet/ti/netcp_core.c:
- struct netcp_stats.syncp_tx
- struct netcp_stats.syncp_rx

drivers/net/ethernet/via/via-rhine.c:
- struct rhine_private.tx_stats.syncp
- struct rhine_private.rx_stats.syncp

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:
- struct axienet_local.tx_stat_sync
- struct axienet_local.rx_stat_sync

drivers/net/hyperv/netvsc.c:
- struct netvsc_channel.tx_stats.syncp
- struct netvsc_channel.rx_stats.syncp

drivers/net/ifb.c:
- struct ifb_q_private.tx_stats.sync
- struct ifb_q_private.rx_stats.sync

drivers/net/mhi_net.c:
- struct mhi_net_stats.tx_syncp
- struct mhi_net_stats.rx_syncp

drivers/net/virtio_net.c:
- struct virtnet_info.rq[].stats.syncp
- struct virtnet_info.sq[].stats.syncp

drivers/net/wwan/mhi_wwan_mbim.c:
- struct mhi_mbim_link.tx_syncp
- struct mhi_mbim_link.rx_syncp

drivers/vdpa/vdpa_sim/vdpa_sim_net.c:
- struct vdpasim_net.tx_stats.syncp
- struct vdpasim_net.rx_stats.syncp
- struct vdpasim_net.cq_stats.syncp

HTH
Petr T

