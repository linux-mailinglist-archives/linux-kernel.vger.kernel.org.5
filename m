Return-Path: <linux-kernel+bounces-14450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 822F6821D38
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299242833F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE21101C4;
	Tue,  2 Jan 2024 14:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoKoAELH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DEF11708
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40d2376db79so86824185e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704204160; x=1704808960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gr8xoz17s/BB7TieecZUfYiPuxeYJ5dbt5GBG9TEZsY=;
        b=VoKoAELHUTT8NKGmWPhINjJD1kxhBswjaCEmyDe7AIK56dHGshJ2axn/zVH76rK3ex
         bY6Zk46FJUm2ybvQatR0Q3GqXviXzUid8AZKnpFNR+dLlanwRqy3lmuKNqOsMP2lBw2d
         +zSjNf8pGaCVfQZeVvSxsl49aKlf581xbVheyHFzMlFKrPRhMqGNXTX+JsQBUV/p5Iif
         a09TauhfAjSk7M7WTFKav65RXi2YpkzQtoZU+Gxq7lEPwoFoThshQ/WfZKeYY6+2YKCn
         LXAH+wZGSaZpLmKZemE6i3z+d8/iInV/VtKxI+SHDg0Tn8Xl/LKVyLvqBhiJK1gbkI+u
         UYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704204160; x=1704808960;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gr8xoz17s/BB7TieecZUfYiPuxeYJ5dbt5GBG9TEZsY=;
        b=gO8WZw5fw6sxVswBlhGD6VazettgSlBrBh2/pDuvQ/v8G7QH3f/KrGnG9/tR4/5RS4
         ahQXb2mc7Vtb1oSf1gufW3reh5YQNji8uDPrd9AkFVGdAYuv5lVCWPCfWt82rmBj65Rw
         TtlUWulR8lXQ2ttvGbJ46U9ZEH18CrGtJc7kUwpwEeaZNDquMKBahDam/v0+vHxb6NOO
         FLTJQ2tCktvEozM8pS8XkF07WUGaJ4sUFrM/hLcGKx3xf6iXuA2WFOS+/o1jO7q1+KlY
         chAc8OGl3tv3iSloEUiJ5+4a/iR8rt/fu0XszuUazb3Rb9JenoogWc7q9v4+mSkkCGyw
         thSw==
X-Gm-Message-State: AOJu0YxTjEe2GFp2i8TtGzQfXew4Vp3kJkPsDQPfNq1BKcZLHT/Qcc6S
	HqjTj3KTc3Hax+TtvP5bHkSR+Soq6ABRGQ==
X-Google-Smtp-Source: AGHT+IFtpOEIbKNXlmkc2tSjGwdHUZnL6Caf7NVCepLhF55Ox65Xqs4fDODl+NB3TOWE3iTyA6rJ8g==
X-Received: by 2002:a5d:5286:0:b0:336:c963:2741 with SMTP id c6-20020a5d5286000000b00336c9632741mr5386059wrv.11.1704204159887;
        Tue, 02 Jan 2024 06:02:39 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d6d0e000000b00336cbbf2e0fsm19026505wrq.27.2024.01.02.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 06:02:39 -0800 (PST)
Date: Tue, 2 Jan 2024 17:02:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, RD Babiera <rdbabiera@google.com>,
	heikki.krogerus@linux.intel.com, linux@roeck-us.net,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, badhri@google.com,
	bryan.odonoghue@linaro.org, agross@kernel.org, andersson@kernel.org,
	konrad.dybcio@linaro.org
Subject: Re: [PATCH v2 12/12] usb: typec: altmodes/displayport: add SOP'
 support
Message-ID: <c1e59ca9-d2f5-4a9c-a653-f533ff5772c1@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214230850.379863-26-rdbabiera@google.com>

Hi RD,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/RD-Babiera/usb-typec-altmodes-add-typec_cable_ops-to-typec_altmode/20231215-071339
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231214230850.379863-26-rdbabiera%40google.com
patch subject: [PATCH v2 12/12] usb: typec: altmodes/displayport: add SOP' support
config: riscv-randconfig-r081-20231216 (https://download.01.org/0day-ci/archive/20231216/202312161205.sNH5M6Pz-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312161205.sNH5M6Pz-lkp@intel.com/

smatch warnings:
drivers/usb/typec/altmodes/displayport.c:317 dp_altmode_work() warn: inconsistent returns '&dp->lock'.

vim +317 drivers/usb/typec/altmodes/displayport.c

0e3bb7d6894d9b Heikki Krogerus 2018-06-27  240  static void dp_altmode_work(struct work_struct *work)
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  241  {
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  242  	struct dp_altmode *dp = container_of(work, struct dp_altmode, work);
4c93cad8cc78bd Kyle Tso        2021-02-05  243  	int svdm_version;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  244  	u32 header;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  245  	u32 vdo;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  246  	int ret;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  247  
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  248  	mutex_lock(&dp->lock);
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  249  
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  250  	switch (dp->state) {
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  251  	case DP_STATE_ENTER:
8face9aa57c833 Heikki Krogerus 2019-12-30  252  		ret = typec_altmode_enter(dp->alt, NULL);
5789051fc57bb6 Heikki Krogerus 2020-09-28  253  		if (ret && ret != -EBUSY)
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  254  			dev_err(&dp->alt->dev, "failed to enter mode\n");
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  255  		break;
92483f2f3092f0 RD Babiera      2023-12-14  256  	case DP_STATE_ENTER_PRIME:
92483f2f3092f0 RD Babiera      2023-12-14  257  		ret = typec_cable_altmode_enter(dp->alt, TYPEC_PLUG_SOP_P, NULL);
92483f2f3092f0 RD Babiera      2023-12-14  258  		/*
92483f2f3092f0 RD Babiera      2023-12-14  259  		 * If we fail to enter Alt Mode on SOP', then we should drop the
92483f2f3092f0 RD Babiera      2023-12-14  260  		 * plug from the driver and attempt to run the driver without
92483f2f3092f0 RD Babiera      2023-12-14  261  		 * it.
92483f2f3092f0 RD Babiera      2023-12-14  262  		 */
92483f2f3092f0 RD Babiera      2023-12-14  263  		if (ret && ret != -EBUSY) {
92483f2f3092f0 RD Babiera      2023-12-14  264  			dev_err(&dp->alt->dev, "plug failed to enter mode\n");
92483f2f3092f0 RD Babiera      2023-12-14  265  			dp->state = DP_STATE_ENTER;
92483f2f3092f0 RD Babiera      2023-12-14  266  			goto disable_prime;
92483f2f3092f0 RD Babiera      2023-12-14  267  		}
92483f2f3092f0 RD Babiera      2023-12-14  268  		break;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  269  	case DP_STATE_UPDATE:
4c93cad8cc78bd Kyle Tso        2021-02-05  270  		svdm_version = typec_altmode_get_svdm_version(dp->alt);
4c93cad8cc78bd Kyle Tso        2021-02-05  271  		if (svdm_version < 0)
4c93cad8cc78bd Kyle Tso        2021-02-05  272  			break;
4c93cad8cc78bd Kyle Tso        2021-02-05  273  		header = DP_HEADER(dp, svdm_version, DP_CMD_STATUS_UPDATE);
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  274  		vdo = 1;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  275  		ret = typec_altmode_vdm(dp->alt, header, &vdo, 2);
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  276  		if (ret)
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  277  			dev_err(&dp->alt->dev,
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  278  				"unable to send Status Update command (%d)\n",
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  279  				ret);
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  280  		break;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  281  	case DP_STATE_CONFIGURE:
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  282  		ret = dp_altmode_configure_vdm(dp, dp->data.conf);
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  283  		if (ret)
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  284  			dev_err(&dp->alt->dev,
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  285  				"unable to send Configure command (%d)\n", ret);
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  286  		break;
92483f2f3092f0 RD Babiera      2023-12-14  287  	case DP_STATE_CONFIGURE_PRIME:
92483f2f3092f0 RD Babiera      2023-12-14  288  		ret = dp_altmode_configure_vdm_cable(dp, dp->data_prime.conf);
92483f2f3092f0 RD Babiera      2023-12-14  289  		if (ret) {
92483f2f3092f0 RD Babiera      2023-12-14  290  			dev_err(&dp->plug_prime->dev,
92483f2f3092f0 RD Babiera      2023-12-14  291  				"unable to send Configure command (%d)\n",
92483f2f3092f0 RD Babiera      2023-12-14  292  				ret);
92483f2f3092f0 RD Babiera      2023-12-14  293  			dp->state = DP_STATE_CONFIGURE;
92483f2f3092f0 RD Babiera      2023-12-14  294  			goto disable_prime;
92483f2f3092f0 RD Babiera      2023-12-14  295  		}
92483f2f3092f0 RD Babiera      2023-12-14  296  		break;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  297  	case DP_STATE_EXIT:
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  298  		if (typec_altmode_exit(dp->alt))
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  299  			dev_err(&dp->alt->dev, "Exit Mode Failed!\n");
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  300  		break;
92483f2f3092f0 RD Babiera      2023-12-14  301  	case DP_STATE_EXIT_PRIME:
92483f2f3092f0 RD Babiera      2023-12-14  302  		if (typec_cable_altmode_exit(dp->plug_prime, TYPEC_PLUG_SOP_P))
92483f2f3092f0 RD Babiera      2023-12-14  303  			dev_err(&dp->plug_prime->dev, "Exit Mode Failed!\n");
92483f2f3092f0 RD Babiera      2023-12-14  304  		break;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  305  	default:
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  306  		break;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  307  	}
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  308  
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  309  	dp->state = DP_STATE_IDLE;
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  310  
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  311  	mutex_unlock(&dp->lock);
92483f2f3092f0 RD Babiera      2023-12-14  312  	return;
92483f2f3092f0 RD Babiera      2023-12-14  313  
92483f2f3092f0 RD Babiera      2023-12-14  314  disable_prime:
92483f2f3092f0 RD Babiera      2023-12-14  315  	typec_altmode_put_plug(dp->plug_prime);
92483f2f3092f0 RD Babiera      2023-12-14  316  	dp->plug_prime = NULL;

We need a mutex_unlock(&dp->lock); somewhere here.

92483f2f3092f0 RD Babiera      2023-12-14 @317  	schedule_work(&dp->work);
0e3bb7d6894d9b Heikki Krogerus 2018-06-27  318  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


