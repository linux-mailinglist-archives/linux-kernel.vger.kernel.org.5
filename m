Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54B7EA0DA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjKMQEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjKMQEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:04:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA810E0;
        Mon, 13 Nov 2023 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699891471; x=1731427471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UdkN8SAfBpH02zQkollG8VPGzspJGCrccWU1tYOSG0Y=;
  b=bvbWD6/ReDiNKVx2kkbl6uOKFdeS0qBdIpQYu6H+HYf+Rrx4PFHyjjnO
   UJmzqRsGDeCx6XOEqIlIE0co+kAHiQQeBAbk7dmhLo8NFRIN/eD8/qfTy
   Kgxk0pdyRkW0bSppVqBJO8AmzPDgQZOF9QlgJAzP15Oa4jIuSEKp8HRCL
   Z7zkhsBqKSjxPDhjKGVfH7/XRLrjkkzYQw7Su4CBakbj44y3xPRJ+pw+V
   O4HmqjKUDLIxO3LdINGCspBRTmE+W0ebgk6tJgvw18XEalSovVFuZBArF
   LwI3DjY6aV2Yl+k4GuB+mgpyOiLctw/frZfj/AR4oEEMpls0VNFYaqBVS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390261707"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="390261707"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:04:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095789129"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095789129"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 08:04:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2ZQ9-0000000DbIO-31UC;
        Mon, 13 Nov 2023 18:04:17 +0200
Date:   Mon, 13 Nov 2023 18:04:17 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        AVKrasnov@sberdevices.ru, r.czerwinski@pengutronix.de,
        jaimeliao.tw@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
Message-ID: <ZVJJAReXiEVc35HZ@smile.fi.intel.com>
References: <20231113131634.614467-1-debug.penguin32@gmail.com>
 <20231113155354.620298-1-debug.penguin32@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113155354.620298-1-debug.penguin32@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You are too quick with v2, below my comments (new and old).

On Tue, Nov 14, 2023 at 01:53:51AM +1000, Ronald Monthero wrote:
> Under heavy load it is likely that the controller is done
> with its own task but the thread unlocking the wait is not
> scheduled in time. Increasing IFC_TIMEOUT_MSECS allows the
> controller to respond within allowable timeslice of 1 sec

Missing period at the end?

> fsl,ifc-nand 7e800000.nand: Controller is not responding

> main/smp_fsm.c:1884 <inrcu: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
>         (detected by 1, t=2102 jiffies, g=7729, q=754)
> task:irq/31-arm-irq1 state:D stack: 0 pid: 116 ppid: 2 flags:0x00000000
> [<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
> [<8064bb01>] (schedule) from [<8064dacd>]
> [<8064dacd>] (rt_mutex_slowlock_block.constprop.0) from [<8064db57>]
> [<8064db57>] (__rt_mutex_slowlock.constprop.0) from [<8064dbf7>]
> [<8064dbf7>] (rt_mutex_slowlock.constprop.0) from [<804b2047>]

At least above 9 lines are not important and may be removed.

> [<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4a)
> [<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1d0)

...

> -#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
> +#define IFC_TIMEOUT_MSECS	1000  /* Maximum number of mSecs to wait
>  					for IFC NAND Machine	*/

While at it, you may improve the comment, e.g.,

  "Maximum timeout to wait for IPC NAND Machine"

-- 
With Best Regards,
Andy Shevchenko


