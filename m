Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973907601FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 00:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjGXWCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjGXWCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 18:02:01 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D8E118
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690236119; x=1721772119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SJlj8GnFLnio14S0CRO9n8WnZoBWKVSR9zwwsRhQPJw=;
  b=JZnCj77DaO+F75sJXmJhnvWw8awyAwhwd3te2RF1qyh3thf3jN+az0TK
   giXsUxjYqzacD6txy5If9shou6iKx4mfoOLK98gDMfM/TY4bJFCEM5YAb
   ip3xJdICO4FSfH3dzedbAe3ijNLfWFBskeDvRcWzUSaW44uyecS6rZCvU
   SgPctQVyj2HDdcVou6au3f38KOlyREA8HvP9FDyVVUWDU/CQpUce3QMIH
   L/e/UowJRqfIDFlcDYjylYE37EpTenyXYIPI4yvanqedE1FkZ00/BrsZy
   /gGk0BzWZ7HN9GMdxXCicQcoZDmvtVXpF4OUynNtw6YkQwnA2LquB2/zd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="431358372"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="431358372"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 15:01:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="675984365"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="675984365"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Jul 2023 15:01:57 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qO3cr-000A3s-05;
        Mon, 24 Jul 2023 22:01:57 +0000
Date:   Tue, 25 Jul 2023 06:01:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/media/dvb-frontends/cxd2841er.c:3376:12: warning: stack
 frame size (9592) exceeds limit (8192) in 'cxd2841er_set_frontend_tc'
Message-ID: <202307250554.zGR0JlFR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   20ea1e7d13c1b544fe67c4a8dc3943bb1ab33e6f
commit: fa35198f39571bbdae53c5b321020021eaad6bd2 fortify: Explicitly check bounds are compile-time constants
date:   10 months ago
config: x86_64-randconfig-x015-20230725 (https://download.01.org/0day-ci/archive/20230725/202307250554.zGR0JlFR-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307250554.zGR0JlFR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307250554.zGR0JlFR-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/dvb-frontends/cxd2841er.c:3376:12: warning: stack frame size (9592) exceeds limit (8192) in 'cxd2841er_set_frontend_tc' [-Wframe-larger-than]
   static int cxd2841er_set_frontend_tc(struct dvb_frontend *fe)
              ^
   1 warning generated.


vim +/cxd2841er_set_frontend_tc +3376 drivers/media/dvb-frontends/cxd2841er.c

a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3375  
a6dc60ff1209df2 Kozlov Sergey   2015-07-28 @3376  static int cxd2841er_set_frontend_tc(struct dvb_frontend *fe)
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3377  {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3378  	int ret = 0, timeout;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3379  	enum fe_status status;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3380  	struct cxd2841er_priv *priv = fe->demodulator_priv;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3381  	struct dtv_frontend_properties *p = &fe->dtv_property_cache;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3382  
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3383  	dev_dbg(&priv->i2c->dev, "%s() delivery_system=%d bandwidth_hz=%d\n",
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3384  		 __func__, p->delivery_system, p->bandwidth_hz);
763f857e40f3711 Daniel Scheller 2017-04-09  3385  
763f857e40f3711 Daniel Scheller 2017-04-09  3386  	if (priv->flags & CXD2841ER_EARLY_TUNE)
763f857e40f3711 Daniel Scheller 2017-04-09  3387  		cxd2841er_tuner_set(fe);
763f857e40f3711 Daniel Scheller 2017-04-09  3388  
bd2355b8efc684e Daniel Scheller 2017-07-11  3389  	/* deconfigure/put demod to sleep on delsys switch if active */
bd2355b8efc684e Daniel Scheller 2017-07-11  3390  	if (priv->state == STATE_ACTIVE_TC &&
bd2355b8efc684e Daniel Scheller 2017-07-11  3391  	    priv->system != p->delivery_system) {
bd2355b8efc684e Daniel Scheller 2017-07-11  3392  		dev_dbg(&priv->i2c->dev, "%s(): old_delsys=%d, new_delsys=%d -> sleep\n",
bd2355b8efc684e Daniel Scheller 2017-07-11  3393  			 __func__, priv->system, p->delivery_system);
bd2355b8efc684e Daniel Scheller 2017-07-11  3394  		cxd2841er_sleep_tc(fe);
bd2355b8efc684e Daniel Scheller 2017-07-11  3395  	}
bd2355b8efc684e Daniel Scheller 2017-07-11  3396  
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3397  	if (p->delivery_system == SYS_DVBT) {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3398  		priv->system = SYS_DVBT;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3399  		switch (priv->state) {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3400  		case STATE_SLEEP_TC:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3401  			ret = cxd2841er_sleep_tc_to_active_t(
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3402  				priv, p->bandwidth_hz);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3403  			break;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3404  		case STATE_ACTIVE_TC:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3405  			ret = cxd2841er_retune_active(priv, p);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3406  			break;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3407  		default:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3408  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3409  				__func__, priv->state);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3410  			ret = -EINVAL;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3411  		}
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3412  	} else if (p->delivery_system == SYS_DVBT2) {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3413  		priv->system = SYS_DVBT2;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3414  		cxd2841er_dvbt2_set_plp_config(priv,
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3415  			(int)(p->stream_id > 255), p->stream_id);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3416  		cxd2841er_dvbt2_set_profile(priv, DVBT2_PROFILE_BASE);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3417  		switch (priv->state) {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3418  		case STATE_SLEEP_TC:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3419  			ret = cxd2841er_sleep_tc_to_active_t2(priv,
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3420  				p->bandwidth_hz);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3421  			break;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3422  		case STATE_ACTIVE_TC:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3423  			ret = cxd2841er_retune_active(priv, p);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3424  			break;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3425  		default:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3426  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3427  				__func__, priv->state);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3428  			ret = -EINVAL;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3429  		}
83808c23e51a61f Abylay Ospan    2016-03-22  3430  	} else if (p->delivery_system == SYS_ISDBT) {
83808c23e51a61f Abylay Ospan    2016-03-22  3431  		priv->system = SYS_ISDBT;
83808c23e51a61f Abylay Ospan    2016-03-22  3432  		switch (priv->state) {
83808c23e51a61f Abylay Ospan    2016-03-22  3433  		case STATE_SLEEP_TC:
83808c23e51a61f Abylay Ospan    2016-03-22  3434  			ret = cxd2841er_sleep_tc_to_active_i(
83808c23e51a61f Abylay Ospan    2016-03-22  3435  					priv, p->bandwidth_hz);
83808c23e51a61f Abylay Ospan    2016-03-22  3436  			break;
83808c23e51a61f Abylay Ospan    2016-03-22  3437  		case STATE_ACTIVE_TC:
83808c23e51a61f Abylay Ospan    2016-03-22  3438  			ret = cxd2841er_retune_active(priv, p);
83808c23e51a61f Abylay Ospan    2016-03-22  3439  			break;
83808c23e51a61f Abylay Ospan    2016-03-22  3440  		default:
83808c23e51a61f Abylay Ospan    2016-03-22  3441  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
83808c23e51a61f Abylay Ospan    2016-03-22  3442  					__func__, priv->state);
83808c23e51a61f Abylay Ospan    2016-03-22  3443  			ret = -EINVAL;
83808c23e51a61f Abylay Ospan    2016-03-22  3444  		}
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3445  	} else if (p->delivery_system == SYS_DVBC_ANNEX_A ||
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3446  			p->delivery_system == SYS_DVBC_ANNEX_C) {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3447  		priv->system = SYS_DVBC_ANNEX_A;
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3448  		/* correct bandwidth */
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3449  		if (p->bandwidth_hz != 6000000 &&
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3450  				p->bandwidth_hz != 7000000 &&
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3451  				p->bandwidth_hz != 8000000) {
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3452  			p->bandwidth_hz = 8000000;
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3453  			dev_dbg(&priv->i2c->dev, "%s(): forcing bandwidth to %d\n",
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3454  					__func__, p->bandwidth_hz);
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3455  		}
3f3b48a0c6caba3 Abylay Ospan    2016-05-14  3456  
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3457  		switch (priv->state) {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3458  		case STATE_SLEEP_TC:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3459  			ret = cxd2841er_sleep_tc_to_active_c(
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3460  				priv, p->bandwidth_hz);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3461  			break;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3462  		case STATE_ACTIVE_TC:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3463  			ret = cxd2841er_retune_active(priv, p);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3464  			break;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3465  		default:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3466  			dev_dbg(&priv->i2c->dev, "%s(): invalid state %d\n",
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3467  				__func__, priv->state);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3468  			ret = -EINVAL;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3469  		}
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3470  	} else {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3471  		dev_dbg(&priv->i2c->dev,
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3472  			"%s(): invalid delivery system %d\n",
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3473  			__func__, p->delivery_system);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3474  		ret = -EINVAL;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3475  	}
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3476  	if (ret)
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3477  		goto done;
c7518d13f70e62e Daniel Scheller 2017-04-09  3478  
763f857e40f3711 Daniel Scheller 2017-04-09  3479  	if (!(priv->flags & CXD2841ER_EARLY_TUNE))
c7518d13f70e62e Daniel Scheller 2017-04-09  3480  		cxd2841er_tuner_set(fe);
c7518d13f70e62e Daniel Scheller 2017-04-09  3481  
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3482  	cxd2841er_tune_done(priv);
e3943aa6d8023bb Daniel Scheller 2017-04-09  3483  
e3943aa6d8023bb Daniel Scheller 2017-04-09  3484  	if (priv->flags & CXD2841ER_NO_WAIT_LOCK)
e3943aa6d8023bb Daniel Scheller 2017-04-09  3485  		goto done;
e3943aa6d8023bb Daniel Scheller 2017-04-09  3486  
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3487  	timeout = 2500;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3488  	while (timeout > 0) {
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3489  		ret = cxd2841er_read_status_tc(fe, &status);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3490  		if (ret)
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3491  			goto done;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3492  		if (status & FE_HAS_LOCK)
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3493  			break;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3494  		msleep(20);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3495  		timeout -= 20;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3496  	}
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3497  	if (timeout < 0)
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3498  		dev_dbg(&priv->i2c->dev,
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3499  			"%s(): LOCK wait timeout\n", __func__);
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3500  done:
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3501  	return ret;
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3502  }
a6dc60ff1209df2 Kozlov Sergey   2015-07-28  3503  

:::::: The code at line 3376 was first introduced by commit
:::::: a6dc60ff1209df29ee4668024e93d31f31421932 [media] cxd2841er: Sony CXD2841ER DVB-S/S2/T/T2/C demodulator driver

:::::: TO: Kozlov Sergey <serjk@netup.ru>
:::::: CC: Mauro Carvalho Chehab <mchehab@osg.samsung.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
