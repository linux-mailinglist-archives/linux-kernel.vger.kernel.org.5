Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5079C6D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjILGWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjILGWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:22:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935A4AF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:22:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso59380205e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694499724; x=1695104524; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WHZmX0HdVaeA7e+GTMUWOnquBG2VN2h00kw4Wwdycoc=;
        b=qFKjCYCJLdwpzb60Mwf+GQTNqioIHWgJEeDCZa8IYH97nj0hCP+bKp/5Z3ny0FI2/e
         SFHrajJYnmLy7TW52YiwW8K6VXeGz7s/F5Gief1FiK7QEJlTuvx0WXfTFrvSHp8Za4/H
         nh3GtNA1jHOZq9w2stgD3wiPfOWuyarFf2EoJY5l3EjYvW5pxqkOu9AwQVUsUsl4WzNV
         dAR7S5wo6tkXPUq8ulXBH4gv6xn7Zy89nRi+pncix+rhJaCOE31hZpQZ9PypTjkqRFkv
         uyQRODU3mfS6fRaTJtOIub5Xx8AuGRm9fs4fJdAsS9NEd5Rqs9OEjEWVwTY6yZmSxKAc
         8oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694499724; x=1695104524;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WHZmX0HdVaeA7e+GTMUWOnquBG2VN2h00kw4Wwdycoc=;
        b=qR8ENCuO9WhDxUUqvE+ySBFgLLdzskJpb+GlQkkQwh6KXOh8XdUmcngf3zAVmP/yGA
         GAG7gViHpx6nsrVVTL66I7/qZeVY9Bhh5pl0YE3fbpAoGltCOOrisTX99pY3A6Ticlqq
         1Zj+Z4TKUmRtx3rf6bbTUc4eSeB/oyF69IFyI/c6rSxC19VMgPNa42pkpwg+dLHmG+bN
         hfnsbvinpfYOZRam6/JOoba6I32jVhPhNyH85YtCGVcqrCFH71/0Jse6W9UU39il57z2
         6bAIuXJhrDq/kRFGD2iefmK33yGKbOpZZVWBC07N1YfRI/LMsYWNgcJJhzjoUNq53kEi
         puqA==
X-Gm-Message-State: AOJu0YzUDI8B38EhwU8gDiHulKh0Tpg6rzNUjTQBvJqmmownCbWHN5TK
        WInUe903s/S1YgtfZEZvJG/dYg==
X-Google-Smtp-Source: AGHT+IG+I5BM37b86sq3KhHg2M4gwi+dJ5j0QXzcWb/eRJJdZtbiMZShPPawrSYbiYVy5fd/1WoMtA==
X-Received: by 2002:a7b:c7d5:0:b0:3fe:d1b9:7ea8 with SMTP id z21-20020a7bc7d5000000b003fed1b97ea8mr9409877wmk.28.1694499724016;
        Mon, 11 Sep 2023 23:22:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003fe2b6d64c8sm15036691wmg.21.2023.09.11.23.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 23:22:03 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:22:01 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Cai Huoqing <cai.huoqing@linux.dev>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/huawei/hinic/hinic_port.c:459
 hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'
 (see line 453)
Message-ID: <dce439ac-bf77-408a-b017-1ffe5ccdd755@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bb80ecc33a8fb5a682236443c1e740d5c917d1d
commit: 2acf960e3be6177f437baade6d1883ebe4c641b2 net: hinic: Add support for configuration of rx-vlan-filter by ethtool
config: x86_64-randconfig-161-20230911 (https://download.01.org/0day-ci/archive/20230911/202309112354.pikZCmyk-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230911/202309112354.pikZCmyk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/

smatch warnings:
drivers/net/ethernet/huawei/hinic/hinic_port.c:459 hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev' (see line 453)

vim +/hwdev +459 drivers/net/ethernet/huawei/hinic/hinic_port.c

2acf960e3be617 Cai Huoqing  2022-11-03  450  int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
2acf960e3be617 Cai Huoqing  2022-11-03  451  {
2acf960e3be617 Cai Huoqing  2022-11-03  452  	struct hinic_hwdev *hwdev = nic_dev->hwdev;
2acf960e3be617 Cai Huoqing  2022-11-03 @453  	struct hinic_hwif *hwif = hwdev->hwif;
                                                                          ^^^^^^^
Dereference

2acf960e3be617 Cai Huoqing  2022-11-03  454  	struct pci_dev *pdev = hwif->pdev;
2acf960e3be617 Cai Huoqing  2022-11-03  455  	struct hinic_vlan_filter vlan_filter;
2acf960e3be617 Cai Huoqing  2022-11-03  456  	u16 out_size = sizeof(vlan_filter);
2acf960e3be617 Cai Huoqing  2022-11-03  457  	int err;
2acf960e3be617 Cai Huoqing  2022-11-03  458  
2acf960e3be617 Cai Huoqing  2022-11-03 @459  	if (!hwdev)
                                                    ^^^^^^
Checked too late.

2acf960e3be617 Cai Huoqing  2022-11-03  460  		return -EINVAL;
2acf960e3be617 Cai Huoqing  2022-11-03  461  
2acf960e3be617 Cai Huoqing  2022-11-03  462  	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
2acf960e3be617 Cai Huoqing  2022-11-03  463  	vlan_filter.enable = en;
2acf960e3be617 Cai Huoqing  2022-11-03  464  
2acf960e3be617 Cai Huoqing  2022-11-03  465  	err = hinic_port_msg_cmd(hwdev, HINIC_PORT_CMD_SET_VLAN_FILTER,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

