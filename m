Return-Path: <linux-kernel+bounces-15341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA5822A65
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C1C284C57
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D9A18640;
	Wed,  3 Jan 2024 09:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V6TRokKm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BD71863B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2814fa68eeso154552766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 01:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704275138; x=1704879938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1XFro0zDE33nuxg1ml/0DMiVoso4Wj1BQrGtGR63iVA=;
        b=V6TRokKmzjOXZ+tleY9yYMIhWcucqU5pn6GccoCbFQPjsWrbyyW3i37kGHAxGW1sn8
         SJAyhyqTQdu+01WwN5XLBG4gPfVEZF7olXI8hvdP13LHkUEji4PCXPalVnlUEqbp4oyZ
         MHMaDzmiMDURbxaLV9tPqqQ2tNHN3QCMuAJPuepnm12fG1IQqEepaxnbftzNTs2gFzi3
         8k9i1/j0ckpeFu68XZu7FEcEK0YwKP48pWUM+moVniL5/yqQkbdPxjpqsPyj3pYHD5ho
         2aQ6sWnrt8lpqB3vKf1BVf6eLJiT4VtRrydJXSN3JOlQQ7TPzddQv/cfQc8gk46iYyhX
         oaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704275138; x=1704879938;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XFro0zDE33nuxg1ml/0DMiVoso4Wj1BQrGtGR63iVA=;
        b=W12e9JkYUmSQlOjuAsxCAPhakWzdKYRkEy4IamN6nZo0TL4HHAz2Jk/rxp399xc3+H
         6JHKle0xHLmqx9fDwqtCjvKgOEIL38HrhjzCTwmafnXNvIGNsx9WdZCIHx42XJHHgzVW
         Ny+Bi6F35fH+lG2VH4sxJ/+709tbqSh0YWHNdcarx5JpYVE3tSGQqvP/fXwyPbdo8hmH
         sd8Rgcr1GYeA2WiEmalHBw1zkq2qCUkMoAGEhB2QDM89TVFuJP4AwfsArDAbBNJ05Edm
         Q5lhml9a7FyL/N/+e1tKMAUZc0xLcsExvLz02AP96tcF7xpprvoLjHpwLrpR3guHAOtf
         7VUA==
X-Gm-Message-State: AOJu0YwChdiJJDM8CgW0jOQKNn5g9SDfICOPoAcyT8XQrK56Afct1xWB
	yzJEpT8SWrGbB/P4uTKwU9QAaAnjd2rfFg==
X-Google-Smtp-Source: AGHT+IEJZtiOe8S7Hm02u5QiHa9HqT4SSVlifY1Jy9f4gxVxzrACTb8d6jybuGtZDZaFQiT2nUhP4Q==
X-Received: by 2002:a17:907:984:b0:a27:af7:bba5 with SMTP id bf4-20020a170907098400b00a270af7bba5mr8336282ejc.22.1704275138083;
        Wed, 03 Jan 2024 01:45:38 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id t15-20020a170906178f00b00a28acfac149sm56045eje.53.2024.01.03.01.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 01:45:37 -0800 (PST)
Date: Wed, 3 Jan 2024 12:45:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, James Tai <james.tai@realtek.com>,
	Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] irqchip: Introduce RTD1319 support using the
 Realtek common interrupt controller driver
Message-ID: <edcbb1d9-ba72-496c-90c5-57948efe23f4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117162709.1096585-4-james.tai@realtek.com>

Hi James,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Tai/dt-bindings-interrupt-controller-Add-support-for-Realtek-DHC-SoCs/20231118-003036
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20231117162709.1096585-4-james.tai%40realtek.com
patch subject: [PATCH v2 3/6] irqchip: Introduce RTD1319 support using the Realtek common interrupt controller driver
config: nios2-randconfig-r081-20231120 (https://download.01.org/0day-ci/archive/20231217/202312172011.8iKGuYB9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312172011.8iKGuYB9-lkp@intel.com/

smatch warnings:
drivers/irqchip/irq-realtek-intc-common.c:179 realtek_intc_probe() warn: ignoring unreachable code.
drivers/irqchip/irq-realtek-intc-common.c:187 realtek_intc_probe() warn: 'data->base' from of_iomap() not released on lines: 176,182.

vim +179 drivers/irqchip/irq-realtek-intc-common.c

40e5ff4eaef72b James Tai 2023-11-18  155  int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info)
40e5ff4eaef72b James Tai 2023-11-18  156  {
40e5ff4eaef72b James Tai 2023-11-18  157  	struct realtek_intc_data *data;
40e5ff4eaef72b James Tai 2023-11-18  158  	struct device *dev = &pdev->dev;
40e5ff4eaef72b James Tai 2023-11-18  159  	struct device_node *node = dev->of_node;
40e5ff4eaef72b James Tai 2023-11-18  160  	int ret, i;
40e5ff4eaef72b James Tai 2023-11-18  161  
40e5ff4eaef72b James Tai 2023-11-18  162  	data = devm_kzalloc(dev, struct_size(data, subset_data, info->cfg_num), GFP_KERNEL);
40e5ff4eaef72b James Tai 2023-11-18  163  	if (!data)
40e5ff4eaef72b James Tai 2023-11-18  164  		return -ENOMEM;
40e5ff4eaef72b James Tai 2023-11-18  165  
40e5ff4eaef72b James Tai 2023-11-18  166  	data->base = of_iomap(node, 0);
40e5ff4eaef72b James Tai 2023-11-18  167  	if (!data->base)
40e5ff4eaef72b James Tai 2023-11-18  168  		return -ENOMEM;
40e5ff4eaef72b James Tai 2023-11-18  169  
40e5ff4eaef72b James Tai 2023-11-18  170  	data->info = info;
40e5ff4eaef72b James Tai 2023-11-18  171  
40e5ff4eaef72b James Tai 2023-11-18  172  	raw_spin_lock_init(&data->lock);
40e5ff4eaef72b James Tai 2023-11-18  173  
40e5ff4eaef72b James Tai 2023-11-18  174  	data->domain = irq_domain_add_linear(node, 32, &realtek_intc_domain_ops, data);
40e5ff4eaef72b James Tai 2023-11-18  175  	if (!data->domain)
40e5ff4eaef72b James Tai 2023-11-18  176  		return -ENOMEM;
40e5ff4eaef72b James Tai 2023-11-18  177  
40e5ff4eaef72b James Tai 2023-11-18  178  	data->subset_data_num = info->cfg_num;
40e5ff4eaef72b James Tai 2023-11-18 @179  	for (i = 0; i < info->cfg_num; i++) {
40e5ff4eaef72b James Tai 2023-11-18  180  		ret = realtek_intc_subset(node, data, i);
40e5ff4eaef72b James Tai 2023-11-18  181  		WARN(ret, "failed to init subset %d: %d", i, ret);

if statement missing

40e5ff4eaef72b James Tai 2023-11-18  182  		return -ENOMEM;
40e5ff4eaef72b James Tai 2023-11-18  183  	}
40e5ff4eaef72b James Tai 2023-11-18  184  
40e5ff4eaef72b James Tai 2023-11-18  185  	platform_set_drvdata(pdev, data);
40e5ff4eaef72b James Tai 2023-11-18  186  
40e5ff4eaef72b James Tai 2023-11-18 @187  	return 0;
40e5ff4eaef72b James Tai 2023-11-18  188  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


