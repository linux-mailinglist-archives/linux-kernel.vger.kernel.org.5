Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFC76FD47
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjHDJ32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjHDJ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:29:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059E73581
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:29:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso29514421fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691141359; x=1691746159;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dnn3YjqK0gYS2d3cBmIF54I2GW/nHeks1WnBWbPsCqA=;
        b=LSoxPSq6PqUSUyUwQor3UO7ej1NFQ1w4NXKg0U9UgkTQuNs7Wc5AVke2/McAMrWT+4
         /DtkaJ4zVQshHs/utXvU0hppM4B988NMvyyIH3sk1n0Vq4mrLnt8dQ4oa8goPba7vExa
         vx2slalXu7r2P1NFZ2LlJ1BDujQihTqO19ZhgRyF1Vb6ZVovAFIEI6Ujb6w+vQBiKb2Z
         urt5JNTo3bq83k1jYouWXynVOT80QpAKIYfO4qigVB7bRH8siqUZLzd3wXljoqbGC3R7
         aL43JH45KlCDdUmPkbCb2oNJ4Ea3wLh1ubtIOAj/QGX/sNXtlNGZd5JADjXRL/Thgpe9
         23CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691141359; x=1691746159;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dnn3YjqK0gYS2d3cBmIF54I2GW/nHeks1WnBWbPsCqA=;
        b=VF73yBUaPYL95HcIg6uNM1iviBMo/eBSXuB1JOLVwxpxbNNTIpm/rm+mFqVmRARzvJ
         k907G9UpEYnwT/4FyZRKCS7RXbzQuIeQNs4HEj6Tl8aQLJerInFwLMmXXMVaNxC++1eb
         ahzkUeS5WqLkWrBb6/cECilrBf+eS8WWSpobAfrbOTUX8B0YBqzDqxWMmWfB9otojREL
         kM/dBShb+8OUYMQKu0/Lne4Ec+IX+Ehwr2K7OHL6sbYloqGSkr+4OsiEOT3qfHmtTKXO
         nSeaUjdb24grB3Y2mGkq/v3Xl//IPbnTXo1W+HR2sj0oP9Rh/bjfjYVMVm0BNDAw5HjX
         IYmg==
X-Gm-Message-State: AOJu0Yw3wAyhjMp+lp89Vu+GN6vqihHyhszVOPvKo1V+ggnrqPG5CsTT
        l84XOxgJHUmZsx9FBdbNb15cjBLlXZFOXhnS5+Y=
X-Google-Smtp-Source: AGHT+IEHiVe4K3MqLOjm+DVCGQ3jTlV9XKFXZSedQKFKvv1j9d815up6QRwY2QCphNtBD8WAdX0iUw==
X-Received: by 2002:a05:651c:102a:b0:2b6:fc60:776f with SMTP id w10-20020a05651c102a00b002b6fc60776fmr972258ljm.30.1691141359043;
        Fri, 04 Aug 2023 02:29:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600c11cd00b003fba6709c68sm1877070wmi.47.2023.08.04.02.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 02:29:18 -0700 (PDT)
Date:   Fri, 4 Aug 2023 12:29:15 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Rob Clark <robdclark@chromium.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        freedreno@lists.freedesktop.org
Subject: Re: [PATCH v3 4/9] PM / QoS: Decouple request alloc from
 dev_pm_qos_mtx
Message-ID: <1085ed08-ac8f-4847-b232-0dcea6a61d77@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803220202.78036-5-robdclark@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Clark/PM-devfreq-Drop-unneed-locking-to-appease-lockdep/20230804-060505
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230803220202.78036-5-robdclark%40gmail.com
patch subject: [PATCH v3 4/9] PM / QoS: Decouple request alloc from dev_pm_qos_mtx
config: i386-randconfig-m021-20230730 (https://download.01.org/0day-ci/archive/20230804/202308041725.Npwswh0L-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230804/202308041725.Npwswh0L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202308041725.Npwswh0L-lkp@intel.com/

smatch warnings:
drivers/base/power/qos.c:973 dev_pm_qos_update_user_latency_tolerance() warn: possible memory leak of 'req'

vim +/req +973 drivers/base/power/qos.c

2d984ad132a87c Rafael J. Wysocki 2014-02-11  923  int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
2d984ad132a87c Rafael J. Wysocki 2014-02-11  924  {
b5ac35ff4296f7 Rob Clark         2023-08-03  925  	struct dev_pm_qos_request *req = NULL;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  926  	int ret;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  927  
211fb32e3a0547 Rob Clark         2023-08-03  928  	ret = dev_pm_qos_constraints_ensure_allocated(dev);
211fb32e3a0547 Rob Clark         2023-08-03  929  	if (ret)
211fb32e3a0547 Rob Clark         2023-08-03  930  		return ret;
211fb32e3a0547 Rob Clark         2023-08-03  931  
b5ac35ff4296f7 Rob Clark         2023-08-03  932  	if (!dev->power.qos->latency_tolerance_req)
b5ac35ff4296f7 Rob Clark         2023-08-03  933  		req = kzalloc(sizeof(*req), GFP_KERNEL);
b5ac35ff4296f7 Rob Clark         2023-08-03  934  
2d984ad132a87c Rafael J. Wysocki 2014-02-11  935  	mutex_lock(&dev_pm_qos_mtx);
2d984ad132a87c Rafael J. Wysocki 2014-02-11  936  
211fb32e3a0547 Rob Clark         2023-08-03  937  	if (!dev->power.qos->latency_tolerance_req) {
2d984ad132a87c Rafael J. Wysocki 2014-02-11  938  		if (val < 0) {
80a6f7c79b7822 Andrew Lutomirski 2016-11-29  939  			if (val == PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT)
80a6f7c79b7822 Andrew Lutomirski 2016-11-29  940  				ret = 0;
80a6f7c79b7822 Andrew Lutomirski 2016-11-29  941  			else
2d984ad132a87c Rafael J. Wysocki 2014-02-11  942  				ret = -EINVAL;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  943  			goto out;

kfree(req);?

2d984ad132a87c Rafael J. Wysocki 2014-02-11  944  		}
2d984ad132a87c Rafael J. Wysocki 2014-02-11  945  		if (!req) {
2d984ad132a87c Rafael J. Wysocki 2014-02-11  946  			ret = -ENOMEM;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  947  			goto out;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  948  		}
2d984ad132a87c Rafael J. Wysocki 2014-02-11  949  		ret = __dev_pm_qos_add_request(dev, req, DEV_PM_QOS_LATENCY_TOLERANCE, val);
2d984ad132a87c Rafael J. Wysocki 2014-02-11  950  		if (ret < 0) {
2d984ad132a87c Rafael J. Wysocki 2014-02-11  951  			kfree(req);
2d984ad132a87c Rafael J. Wysocki 2014-02-11  952  			goto out;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  953  		}
2d984ad132a87c Rafael J. Wysocki 2014-02-11  954  		dev->power.qos->latency_tolerance_req = req;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  955  	} else {
b5ac35ff4296f7 Rob Clark         2023-08-03  956  		/*
b5ac35ff4296f7 Rob Clark         2023-08-03  957  		 * If we raced with another thread to allocate the request,
b5ac35ff4296f7 Rob Clark         2023-08-03  958  		 * simply free the redundant allocation and move on.
b5ac35ff4296f7 Rob Clark         2023-08-03  959  		 */
b5ac35ff4296f7 Rob Clark         2023-08-03  960  		if (req)
b5ac35ff4296f7 Rob Clark         2023-08-03  961  			kfree(req);
b5ac35ff4296f7 Rob Clark         2023-08-03  962  
2d984ad132a87c Rafael J. Wysocki 2014-02-11  963  		if (val < 0) {
2d984ad132a87c Rafael J. Wysocki 2014-02-11  964  			__dev_pm_qos_drop_user_request(dev, DEV_PM_QOS_LATENCY_TOLERANCE);
2d984ad132a87c Rafael J. Wysocki 2014-02-11  965  			ret = 0;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  966  		} else {
2d984ad132a87c Rafael J. Wysocki 2014-02-11  967  			ret = __dev_pm_qos_update_request(dev->power.qos->latency_tolerance_req, val);
2d984ad132a87c Rafael J. Wysocki 2014-02-11  968  		}
2d984ad132a87c Rafael J. Wysocki 2014-02-11  969  	}
2d984ad132a87c Rafael J. Wysocki 2014-02-11  970  
2d984ad132a87c Rafael J. Wysocki 2014-02-11  971   out:
2d984ad132a87c Rafael J. Wysocki 2014-02-11  972  	mutex_unlock(&dev_pm_qos_mtx);
2d984ad132a87c Rafael J. Wysocki 2014-02-11 @973  	return ret;
2d984ad132a87c Rafael J. Wysocki 2014-02-11  974  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

