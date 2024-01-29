Return-Path: <linux-kernel+bounces-42407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F88400E9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF1B6284DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B7654F85;
	Mon, 29 Jan 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZRWBCs7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B23C55E42;
	Mon, 29 Jan 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519267; cv=none; b=rB6aXhnc92lMNG+l/mzIyaDSmxCfBfV9KIBwtS2uLU6H8vtinl8WFimHztF32bI3kIGm+G8Y6C0bsPKi9c+ciTPkBiF1QwBVQKkYj3B25npsNJDNNJtJC+nUJTdxaxnsrxHQ3EGN0+QQRTgmpF6K9MzADpeDMc0iNYdjBuBErKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519267; c=relaxed/simple;
	bh=yXQJFAfFBJgQLodANwDCmt/yUv2fbA0o7Gqgyr3L6kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXXtOJRCfD1ZgGJ6YPsfLiicu9+WJAX70XG3m3m8zzpf/COcCq65OTVBGC6gvACncsRS0q2MkEE9/2gAqr8ehClwlbxMKi94ck2rKBjS3CEIBxLhX/ZV0Sehh4OyGB02qBl3b2ra7BfaoSJHt9pD4oUyuiva7NguuzPQxrp+aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZRWBCs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2923EC433F1;
	Mon, 29 Jan 2024 09:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706519266;
	bh=yXQJFAfFBJgQLodANwDCmt/yUv2fbA0o7Gqgyr3L6kI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZRWBCs7bA6tjctAtoilnrOakdMWkBDbJMFWcftyDUPG8or/oo/hp/sWhkXwFrqo8
	 0mMseT7AbRFWjdxWiDVVv9bQiK6WyoyJy89tuXwrv+6GZnlSDJyHRNfQRAkTl4wAQr
	 NKKcaIRz8PYcjmny4VSYLc4cWaIpv0mYfphM/cmrysgp2pbtPP0/+6OoYJg1SQx/NN
	 Qi+x2EX9U5cTYw2aq4ifGw3cAlgckf5F8X+6XP1TEKy9L4lhehcLgUCq7fLOB82bBl
	 r3sm+4JFLaumWD87qpqBBFKLz8vZAzfQ0vWkqjjmeAkVwbq7kJYjFmTgz+gnH9ydq3
	 ogBoodBnLrRhA==
Date: Mon, 29 Jan 2024 11:07:42 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, Patrisious Haddad <phaddad@nvidia.com>,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>
Subject: Re: drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c:170
 ipsec_fs_roce_rx_rule_setup() warn: missing error code 'err'
Message-ID: <20240129090742.GB8285@unreal>
References: <57817f40-9979-44d7-9f76-d1bf1e06cf39@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57817f40-9979-44d7-9f76-d1bf1e06cf39@moroto.mountain>

On Mon, Jan 22, 2024 at 10:17:26AM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   80fc600fafee8ba981da6ed41a572800c8e11de6
> commit: f2f0231cfe8905af217e5bf1a08bfb8e4d3b74fb net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
> config: x86_64-randconfig-161-20240120 (https://download.01.org/0day-ci/archive/20240121/202401210739.xiykyqPN-lkp@intel.com/config)
> compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202401210739.xiykyqPN-lkp@intel.com/
> 
> smatch warnings:
> drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c:170 ipsec_fs_roce_rx_rule_setup() warn: missing error code 'err'
> 
> vim +/err +170 drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
> 
> 899577600b25b3 Mark Zhang        2023-01-04  122  static int
> 899577600b25b3 Mark Zhang        2023-01-04  123  ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
> 899577600b25b3 Mark Zhang        2023-01-04  124  			    struct mlx5_flow_destination *default_dst,
> 899577600b25b3 Mark Zhang        2023-01-04  125  			    struct mlx5_ipsec_rx_roce *roce)
> 899577600b25b3 Mark Zhang        2023-01-04  126  {
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  127  	bool is_mpv_slave = mlx5_core_is_mp_slave(mdev);
> 899577600b25b3 Mark Zhang        2023-01-04  128  	struct mlx5_flow_destination dst = {};
> 899577600b25b3 Mark Zhang        2023-01-04  129  	MLX5_DECLARE_FLOW_ACT(flow_act);
> 899577600b25b3 Mark Zhang        2023-01-04  130  	struct mlx5_flow_handle *rule;
> 899577600b25b3 Mark Zhang        2023-01-04  131  	struct mlx5_flow_spec *spec;
> 899577600b25b3 Mark Zhang        2023-01-04  132  	int err = 0;
> 899577600b25b3 Mark Zhang        2023-01-04  133  
> 899577600b25b3 Mark Zhang        2023-01-04  134  	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
> 899577600b25b3 Mark Zhang        2023-01-04  135  	if (!spec)
> 899577600b25b3 Mark Zhang        2023-01-04  136  		return -ENOMEM;
> 899577600b25b3 Mark Zhang        2023-01-04  137  
> 899577600b25b3 Mark Zhang        2023-01-04  138  	ipsec_fs_roce_setup_udp_dport(spec, ROCE_V2_UDP_DPORT);
> 899577600b25b3 Mark Zhang        2023-01-04  139  
> 899577600b25b3 Mark Zhang        2023-01-04  140  	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  141  	if (is_mpv_slave) {
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  142  		dst.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  143  		dst.ft = roce->goto_alias_ft;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  144  	} else {
> 899577600b25b3 Mark Zhang        2023-01-04  145  		dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
> 899577600b25b3 Mark Zhang        2023-01-04  146  		dst.ft = roce->ft_rdma;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  147  	}
> 899577600b25b3 Mark Zhang        2023-01-04  148  	rule = mlx5_add_flow_rules(roce->ft, spec, &flow_act, &dst, 1);
> 899577600b25b3 Mark Zhang        2023-01-04  149  	if (IS_ERR(rule)) {
> 899577600b25b3 Mark Zhang        2023-01-04  150  		err = PTR_ERR(rule);
> 899577600b25b3 Mark Zhang        2023-01-04  151  		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec rule err=%d\n",
> 899577600b25b3 Mark Zhang        2023-01-04  152  			      err);
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  153  		goto out;
> 899577600b25b3 Mark Zhang        2023-01-04  154  	}
> 899577600b25b3 Mark Zhang        2023-01-04  155  
> 899577600b25b3 Mark Zhang        2023-01-04  156  	roce->rule = rule;
> 899577600b25b3 Mark Zhang        2023-01-04  157  
> 899577600b25b3 Mark Zhang        2023-01-04  158  	memset(spec, 0, sizeof(*spec));
> 899577600b25b3 Mark Zhang        2023-01-04  159  	rule = mlx5_add_flow_rules(roce->ft, spec, &flow_act, default_dst, 1);
> 899577600b25b3 Mark Zhang        2023-01-04  160  	if (IS_ERR(rule)) {
> 899577600b25b3 Mark Zhang        2023-01-04  161  		err = PTR_ERR(rule);
> 899577600b25b3 Mark Zhang        2023-01-04  162  		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec miss rule err=%d\n",
> 899577600b25b3 Mark Zhang        2023-01-04  163  			      err);
> 899577600b25b3 Mark Zhang        2023-01-04  164  		goto fail_add_default_rule;
> 899577600b25b3 Mark Zhang        2023-01-04  165  	}
> 899577600b25b3 Mark Zhang        2023-01-04  166  
> 899577600b25b3 Mark Zhang        2023-01-04  167  	roce->roce_miss.rule = rule;
> 899577600b25b3 Mark Zhang        2023-01-04  168  
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  169  	if (!is_mpv_slave)
> f2f0231cfe8905 Patrisious Haddad 2023-09-21 @170  		goto out;
> 
> error code here?  Or perhaps if not an error code, then a comment?

It is not an error and right behavior. MPV is special device which is
combination of two devices: master and slave. So is_mpv_slave is the
best comment for everyone who touches flow steering logic :).

Thanks

> 
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  171  
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  172  	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  173  	dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  174  	dst.ft = roce->ft_rdma;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  175  	rule = mlx5_add_flow_rules(roce->nic_master_ft, NULL, &flow_act, &dst,
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  176  				   1);
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  177  	if (IS_ERR(rule)) {
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  178  		err = PTR_ERR(rule);
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  179  		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec rule for alias err=%d\n",
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  180  			      err);
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  181  		goto fail_add_nic_master_rule;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  182  	}
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  183  	roce->nic_master_rule = rule;
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  184  
> 899577600b25b3 Mark Zhang        2023-01-04  185  	kvfree(spec);
> 899577600b25b3 Mark Zhang        2023-01-04  186  	return 0;
> 899577600b25b3 Mark Zhang        2023-01-04  187  
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  188  fail_add_nic_master_rule:
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  189  	mlx5_del_flow_rules(roce->roce_miss.rule);
> 899577600b25b3 Mark Zhang        2023-01-04  190  fail_add_default_rule:
> 899577600b25b3 Mark Zhang        2023-01-04  191  	mlx5_del_flow_rules(roce->rule);
> f2f0231cfe8905 Patrisious Haddad 2023-09-21  192  out:
> 899577600b25b3 Mark Zhang        2023-01-04  193  	kvfree(spec);
> 899577600b25b3 Mark Zhang        2023-01-04  194  	return err;
> 899577600b25b3 Mark Zhang        2023-01-04  195  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 

