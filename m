Return-Path: <linux-kernel+bounces-32420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D04835B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DB31C214B4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C1FF505;
	Mon, 22 Jan 2024 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bs0puiRU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBA2FC17
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705907854; cv=none; b=uKuafUJFexxwUoOJiWonA8MtFR3LxvVdOtgPJfKa10xU/y0N41y3asURJR+B57Lf0SCV1L/xINsTLXiDlMfYM/QtXZOiQIjTR/WND+0KRcK0T8e2k5v/izkt1fPD93KpOwiSPpZE3YeWpw4Yr9+48hZeu5K7eeK7HG1NXf31DKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705907854; c=relaxed/simple;
	bh=cuRhoD25kV5AtO2UPG+DNNvqeNk47kF0D6+CgaIKqg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SeWTTfvBeEWD1oSCvYhUH5w8VJXsIz9pDPUIA84vVgyYmVti9AGOxro6orFpnF1ZX+AaNPoaiBRU6tImwdc9d1pkw+zcbWDtUPFWD+LzwV11JDxV/nT/9ZhOHZL4dAwUlUxEGFz+4F8EHyTaW0HSm6v8SFEEiLxdvIshVvvD1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bs0puiRU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso37121925e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705907849; x=1706512649; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgtcM0W/h7dz9GnGdFCBPRNX03Z4V/NkqN0UrdV3BGc=;
        b=Bs0puiRUjJAVc1Qdn1esaggL9ifhYvoZJYhxzeeRYdjDTK3fpfz9VFMTGj8j6DQjuW
         gUO3SIyPqbhIgivppTiK3YWyl3kMQZw/S+JvzvQT03j/IDDE8FsjSm8+43qbFQmEbmid
         ZF+0IBT0jOcYB1BrhLXNkn51b12BoPg4uzoqmOQTKJR2Qo/P2fbt9v/KvcQa4jyHE/Rp
         LE3UQaUkOOjJLOX8NDefUUH0r2eehPL7cRYERg/ATC46J2b2RpVVhOE6M/ZGUkwFtNGW
         aV7jMsU7TIXBungu3BKB84BMJDaswBqJLBpXXnlC+p99dJFWWYp2nZIR85Q5cBKGv97Z
         y4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705907849; x=1706512649;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgtcM0W/h7dz9GnGdFCBPRNX03Z4V/NkqN0UrdV3BGc=;
        b=EgnHRkzsUI7UrpWLPJde2ORNfeTHbpmeBsxD1a20ugLP2lDQ9sVDxQkGP/pirRuPds
         TZ0bHovh8cWghUp2XiXsnhiDWpwTuyiD6bgM39ENU7Lv7XiW3mRN/CuVkrdpzm34G5HI
         QgyLSks3miXZlj/Np7JwVcSnulI1gTJpkf4rQ/6Cij1dC16fEM1BmUHffceW6d/u66cD
         a8Ryd1s3kHPnkm/hAxfsmZMaX/vmCGsscaPZViA77xkA9myraDopg9UxTIHOBsJI4bCA
         WSQ2Up39tngtyuKULNtvZzFt1YqMvpLuXQaFrY+ml5GyZ3UYKJibBMbm81sCne4XKDb2
         I48w==
X-Gm-Message-State: AOJu0YzvFWEXLOT7hKuPfoqiRFPAOKGFbZXAnFuHQb27x+sam5OjGF9v
	+qc8UnuKD75oeCdDxcacDVnQU23pbt7aNJSKk5UBSATIkNWA9+ii+cpCs0Cq01s=
X-Google-Smtp-Source: AGHT+IFsPYePyh4MiR1Zs+B10Cs0JfvYc19AdlDGwYR24yPPdyHjYSD2i1XOCIX0PSyBS1BzXa7vbQ==
X-Received: by 2002:a7b:c454:0:b0:40e:44ad:2e47 with SMTP id l20-20020a7bc454000000b0040e44ad2e47mr2087634wmi.185.1705907849606;
        Sun, 21 Jan 2024 23:17:29 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id hn33-20020a05600ca3a100b0040e621feca9sm35726315wmb.17.2024.01.21.23.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:17:29 -0800 (PST)
Date: Mon, 22 Jan 2024 10:17:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Patrisious Haddad <phaddad@nvidia.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c:170
 ipsec_fs_roce_rx_rule_setup() warn: missing error code 'err'
Message-ID: <57817f40-9979-44d7-9f76-d1bf1e06cf39@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   80fc600fafee8ba981da6ed41a572800c8e11de6
commit: f2f0231cfe8905af217e5bf1a08bfb8e4d3b74fb net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
config: x86_64-randconfig-161-20240120 (https://download.01.org/0day-ci/archive/20240121/202401210739.xiykyqPN-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202401210739.xiykyqPN-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c:170 ipsec_fs_roce_rx_rule_setup() warn: missing error code 'err'

vim +/err +170 drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c

899577600b25b3 Mark Zhang        2023-01-04  122  static int
899577600b25b3 Mark Zhang        2023-01-04  123  ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
899577600b25b3 Mark Zhang        2023-01-04  124  			    struct mlx5_flow_destination *default_dst,
899577600b25b3 Mark Zhang        2023-01-04  125  			    struct mlx5_ipsec_rx_roce *roce)
899577600b25b3 Mark Zhang        2023-01-04  126  {
f2f0231cfe8905 Patrisious Haddad 2023-09-21  127  	bool is_mpv_slave = mlx5_core_is_mp_slave(mdev);
899577600b25b3 Mark Zhang        2023-01-04  128  	struct mlx5_flow_destination dst = {};
899577600b25b3 Mark Zhang        2023-01-04  129  	MLX5_DECLARE_FLOW_ACT(flow_act);
899577600b25b3 Mark Zhang        2023-01-04  130  	struct mlx5_flow_handle *rule;
899577600b25b3 Mark Zhang        2023-01-04  131  	struct mlx5_flow_spec *spec;
899577600b25b3 Mark Zhang        2023-01-04  132  	int err = 0;
899577600b25b3 Mark Zhang        2023-01-04  133  
899577600b25b3 Mark Zhang        2023-01-04  134  	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
899577600b25b3 Mark Zhang        2023-01-04  135  	if (!spec)
899577600b25b3 Mark Zhang        2023-01-04  136  		return -ENOMEM;
899577600b25b3 Mark Zhang        2023-01-04  137  
899577600b25b3 Mark Zhang        2023-01-04  138  	ipsec_fs_roce_setup_udp_dport(spec, ROCE_V2_UDP_DPORT);
899577600b25b3 Mark Zhang        2023-01-04  139  
899577600b25b3 Mark Zhang        2023-01-04  140  	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  141  	if (is_mpv_slave) {
f2f0231cfe8905 Patrisious Haddad 2023-09-21  142  		dst.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  143  		dst.ft = roce->goto_alias_ft;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  144  	} else {
899577600b25b3 Mark Zhang        2023-01-04  145  		dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
899577600b25b3 Mark Zhang        2023-01-04  146  		dst.ft = roce->ft_rdma;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  147  	}
899577600b25b3 Mark Zhang        2023-01-04  148  	rule = mlx5_add_flow_rules(roce->ft, spec, &flow_act, &dst, 1);
899577600b25b3 Mark Zhang        2023-01-04  149  	if (IS_ERR(rule)) {
899577600b25b3 Mark Zhang        2023-01-04  150  		err = PTR_ERR(rule);
899577600b25b3 Mark Zhang        2023-01-04  151  		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec rule err=%d\n",
899577600b25b3 Mark Zhang        2023-01-04  152  			      err);
f2f0231cfe8905 Patrisious Haddad 2023-09-21  153  		goto out;
899577600b25b3 Mark Zhang        2023-01-04  154  	}
899577600b25b3 Mark Zhang        2023-01-04  155  
899577600b25b3 Mark Zhang        2023-01-04  156  	roce->rule = rule;
899577600b25b3 Mark Zhang        2023-01-04  157  
899577600b25b3 Mark Zhang        2023-01-04  158  	memset(spec, 0, sizeof(*spec));
899577600b25b3 Mark Zhang        2023-01-04  159  	rule = mlx5_add_flow_rules(roce->ft, spec, &flow_act, default_dst, 1);
899577600b25b3 Mark Zhang        2023-01-04  160  	if (IS_ERR(rule)) {
899577600b25b3 Mark Zhang        2023-01-04  161  		err = PTR_ERR(rule);
899577600b25b3 Mark Zhang        2023-01-04  162  		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec miss rule err=%d\n",
899577600b25b3 Mark Zhang        2023-01-04  163  			      err);
899577600b25b3 Mark Zhang        2023-01-04  164  		goto fail_add_default_rule;
899577600b25b3 Mark Zhang        2023-01-04  165  	}
899577600b25b3 Mark Zhang        2023-01-04  166  
899577600b25b3 Mark Zhang        2023-01-04  167  	roce->roce_miss.rule = rule;
899577600b25b3 Mark Zhang        2023-01-04  168  
f2f0231cfe8905 Patrisious Haddad 2023-09-21  169  	if (!is_mpv_slave)
f2f0231cfe8905 Patrisious Haddad 2023-09-21 @170  		goto out;

error code here?  Or perhaps if not an error code, then a comment?

f2f0231cfe8905 Patrisious Haddad 2023-09-21  171  
f2f0231cfe8905 Patrisious Haddad 2023-09-21  172  	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  173  	dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  174  	dst.ft = roce->ft_rdma;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  175  	rule = mlx5_add_flow_rules(roce->nic_master_ft, NULL, &flow_act, &dst,
f2f0231cfe8905 Patrisious Haddad 2023-09-21  176  				   1);
f2f0231cfe8905 Patrisious Haddad 2023-09-21  177  	if (IS_ERR(rule)) {
f2f0231cfe8905 Patrisious Haddad 2023-09-21  178  		err = PTR_ERR(rule);
f2f0231cfe8905 Patrisious Haddad 2023-09-21  179  		mlx5_core_err(mdev, "Fail to add RX RoCE IPsec rule for alias err=%d\n",
f2f0231cfe8905 Patrisious Haddad 2023-09-21  180  			      err);
f2f0231cfe8905 Patrisious Haddad 2023-09-21  181  		goto fail_add_nic_master_rule;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  182  	}
f2f0231cfe8905 Patrisious Haddad 2023-09-21  183  	roce->nic_master_rule = rule;
f2f0231cfe8905 Patrisious Haddad 2023-09-21  184  
899577600b25b3 Mark Zhang        2023-01-04  185  	kvfree(spec);
899577600b25b3 Mark Zhang        2023-01-04  186  	return 0;
899577600b25b3 Mark Zhang        2023-01-04  187  
f2f0231cfe8905 Patrisious Haddad 2023-09-21  188  fail_add_nic_master_rule:
f2f0231cfe8905 Patrisious Haddad 2023-09-21  189  	mlx5_del_flow_rules(roce->roce_miss.rule);
899577600b25b3 Mark Zhang        2023-01-04  190  fail_add_default_rule:
899577600b25b3 Mark Zhang        2023-01-04  191  	mlx5_del_flow_rules(roce->rule);
f2f0231cfe8905 Patrisious Haddad 2023-09-21  192  out:
899577600b25b3 Mark Zhang        2023-01-04  193  	kvfree(spec);
899577600b25b3 Mark Zhang        2023-01-04  194  	return err;
899577600b25b3 Mark Zhang        2023-01-04  195  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


