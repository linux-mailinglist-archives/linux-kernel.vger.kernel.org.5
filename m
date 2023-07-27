Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF11764556
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjG0FOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjG0FOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:14:03 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E656D2D43
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:13:55 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fc02a92dcfso5431805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690434834; x=1691039634;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms4Imiuy8EKPlBwbhJcl0rqifwGh1e3doJx4I3vmVvQ=;
        b=RwB4ctSiG4gotI8gXGOmkJ+YY04bn9dQ6ZNptpH2irOhCFc3WKZBcplvhvPsw7t4a7
         qo6n7fTSFM2b116LQmxEACCBJvtPv8S8B0h22kY8Exjlz85LghJeKYWopaglEptRJVln
         cjTL2Mudx3ttff8X1zsJtjwtHIL5gkCl4zDdMC+7deCcIB/lZfHTAuWV8s0Sc+VyW8ha
         aMZmAp9e82TyyW915sj1lIRul94HUIZXFkupT/M8S7YVsu8hw7jthNahRsuz3tqZli5w
         U6ap6A19S2LHjLt54BKtzqQBYLPHjyQSOpHihTClM9tIbMcePJQunEcsFOShoPH191Qq
         5C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690434834; x=1691039634;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ms4Imiuy8EKPlBwbhJcl0rqifwGh1e3doJx4I3vmVvQ=;
        b=avwBOWToeSbOEcrdcUNMajrBsBwWaD0/Qlg5kOYtk98mIUAdeVda4XyEzPSKs5oylt
         q/CstaxqpxEVsrYhzyjB1dLbfIxVyddk/Htepy4EJmUSg5kPhsf7XSmsnwJH9lq1ME0W
         y2Kxa/qXc+ivUK/t0IzXbKIe0OP9vn/eiGUl3o+elo/nJuseCTeM704hMhMAcJNS8N9d
         UcAgelOhNeFTDMDncolL4Vi8U+RZ7dnryBvyUUMl5I7Ih4Kac3XQWmNBPEk08ASRKsZA
         2TO0NBV/1HWQYzVU+AXpaGi7pVnuhBhItPMd+hez4VgM6yb92Qm++eadkH++8E6+2Keb
         Gb1w==
X-Gm-Message-State: ABy/qLZHDbVFTL2rjPtdZ0Sz9R9P6/Zjz6n5pbfpZgcqOiNo44Qrt9Mk
        Gynezy+HKunBfUpDh1eNrVIWhw==
X-Google-Smtp-Source: APBJJlGaZecOr21g+QCaQjqbhPKMTK925noBExwDyAVrGeBj5YNKzUHzMh7YpOPgqhhCNdberX0jdQ==
X-Received: by 2002:adf:fece:0:b0:314:2735:dc13 with SMTP id q14-20020adffece000000b003142735dc13mr895897wrs.47.1690434834323;
        Wed, 26 Jul 2023 22:13:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y8-20020adffa48000000b003159d2dabbasm798202wrr.94.2023.07.26.22.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:13:54 -0700 (PDT)
Date:   Thu, 27 Jul 2023 08:13:51 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Aman Deep <aman.deep@samsung.com>,
        gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        laurent.pinchart@ideasonboard.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aman Deep <aman.deep@samsung.com>,
        Anuj Gupta <anuj01.gupta@samsung.com>
Subject: Re: [PATCH] USB: Fix race condition during UVC webcam disconnect
Message-ID: <8961ae64-35c4-4092-8bbe-6e903feaacd4@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720113142.3070583-1-aman.deep@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aman,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aman-Deep/USB-Fix-race-condition-during-UVC-webcam-disconnect/20230720-202046
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230720113142.3070583-1-aman.deep%40samsung.com
patch subject: [PATCH] USB: Fix race condition during UVC webcam disconnect
config: parisc-randconfig-m041-20230726 (https://download.01.org/0day-ci/archive/20230727/202307270834.rpaexQSs-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270834.rpaexQSs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307270834.rpaexQSs-lkp@intel.com/

smatch warnings:
drivers/usb/core/message.c:1668 usb_set_interface() warn: inconsistent returns 'hcd->bandwidth_mutex'.

vim +1668 drivers/usb/core/message.c

^1da177e4c3f41 Linus Torvalds                2005-04-16  1528  int usb_set_interface(struct usb_device *dev, int interface, int alternate)
^1da177e4c3f41 Linus Torvalds                2005-04-16  1529  {
^1da177e4c3f41 Linus Torvalds                2005-04-16  1530  	struct usb_interface *iface;
^1da177e4c3f41 Linus Torvalds                2005-04-16  1531  	struct usb_host_interface *alt;
3f0479e00a3fca Sarah Sharp                   2009-12-03  1532  	struct usb_hcd *hcd = bus_to_hcd(dev->bus);
7a7b562d08ad6d Hans de Goede                 2013-11-08  1533  	int i, ret, manual = 0;
3e35bf39e0b909 Greg Kroah-Hartman            2008-01-30  1534  	unsigned int epaddr;
3e35bf39e0b909 Greg Kroah-Hartman            2008-01-30  1535  	unsigned int pipe;
^1da177e4c3f41 Linus Torvalds                2005-04-16  1536  
^1da177e4c3f41 Linus Torvalds                2005-04-16  1537  	if (dev->state == USB_STATE_SUSPENDED)
^1da177e4c3f41 Linus Torvalds                2005-04-16  1538  		return -EHOSTUNREACH;
^1da177e4c3f41 Linus Torvalds                2005-04-16  1539  
^1da177e4c3f41 Linus Torvalds                2005-04-16  1540  	iface = usb_ifnum_to_if(dev, interface);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1541  	if (!iface) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  1542  		dev_dbg(&dev->dev, "selecting invalid interface %d\n",
^1da177e4c3f41 Linus Torvalds                2005-04-16  1543  			interface);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1544  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds                2005-04-16  1545  	}
e534c5b831c8b8 Alan Stern                    2011-07-01  1546  	if (iface->unregistering)
e534c5b831c8b8 Alan Stern                    2011-07-01  1547  		return -ENODEV;
^1da177e4c3f41 Linus Torvalds                2005-04-16  1548  
^1da177e4c3f41 Linus Torvalds                2005-04-16  1549  	alt = usb_altnum_to_altsetting(iface, alternate);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1550  	if (!alt) {
385f690bc058ba Thadeu Lima de Souza Cascardo 2010-01-17  1551  		dev_warn(&dev->dev, "selecting invalid altsetting %d\n",
3b6004f3b5a8b4 Greg Kroah-Hartman            2008-08-14  1552  			 alternate);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1553  		return -EINVAL;
^1da177e4c3f41 Linus Torvalds                2005-04-16  1554  	}
f9a5b4f58b280c Mathias Nyman                 2018-09-03  1555  	/*
f9a5b4f58b280c Mathias Nyman                 2018-09-03  1556  	 * usb3 hosts configure the interface in usb_hcd_alloc_bandwidth,
f9a5b4f58b280c Mathias Nyman                 2018-09-03  1557  	 * including freeing dropped endpoint ring buffers.
f9a5b4f58b280c Mathias Nyman                 2018-09-03  1558  	 * Make sure the interface endpoints are flushed before that
f9a5b4f58b280c Mathias Nyman                 2018-09-03  1559  	 */
f9a5b4f58b280c Mathias Nyman                 2018-09-03  1560  	usb_disable_interface(dev, iface, false);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1561  
3f0479e00a3fca Sarah Sharp                   2009-12-03  1562  	/* Make sure we have enough bandwidth for this alternate interface.
3f0479e00a3fca Sarah Sharp                   2009-12-03  1563  	 * Remove the current alt setting and add the new alt setting.
3f0479e00a3fca Sarah Sharp                   2009-12-03  1564  	 */
d673bfcbfffdeb Sarah Sharp                   2010-10-15  1565  	mutex_lock(hcd->bandwidth_mutex);
8306095fd2c110 Sarah Sharp                   2012-05-02  1566  	/* Disable LPM, and re-enable it once the new alt setting is installed,
8306095fd2c110 Sarah Sharp                   2012-05-02  1567  	 * so that the xHCI driver can recalculate the U1/U2 timeouts.
8306095fd2c110 Sarah Sharp                   2012-05-02  1568  	 */
8306095fd2c110 Sarah Sharp                   2012-05-02  1569  	if (usb_disable_lpm(dev)) {
1ccc417e6c3201 Joe Perches                   2017-12-05  1570  		dev_err(&iface->dev, "%s Failed to disable LPM\n", __func__);
8306095fd2c110 Sarah Sharp                   2012-05-02  1571  		mutex_unlock(hcd->bandwidth_mutex);
8306095fd2c110 Sarah Sharp                   2012-05-02  1572  		return -ENOMEM;
8306095fd2c110 Sarah Sharp                   2012-05-02  1573  	}
7a7b562d08ad6d Hans de Goede                 2013-11-08  1574  	/* Changing alt-setting also frees any allocated streams */
7a7b562d08ad6d Hans de Goede                 2013-11-08  1575  	for (i = 0; i < iface->cur_altsetting->desc.bNumEndpoints; i++)
7a7b562d08ad6d Hans de Goede                 2013-11-08  1576  		iface->cur_altsetting->endpoint[i].streams = 0;
7a7b562d08ad6d Hans de Goede                 2013-11-08  1577  
4682bbb9e2f196 Aman Deep                     2023-07-20  1578  	if (dev->state == USB_STATE_NOTATTACHED)
4682bbb9e2f196 Aman Deep                     2023-07-20  1579  		return -ENODEV;


mutex_unlock(hcd->bandwidth_mutex); before returning

4682bbb9e2f196 Aman Deep                     2023-07-20  1580  
3f0479e00a3fca Sarah Sharp                   2009-12-03  1581  	ret = usb_hcd_alloc_bandwidth(dev, NULL, iface->cur_altsetting, alt);
4682bbb9e2f196 Aman Deep                     2023-07-20  1582  
3f0479e00a3fca Sarah Sharp                   2009-12-03  1583  	if (ret < 0) {
3f0479e00a3fca Sarah Sharp                   2009-12-03  1584  		dev_info(&dev->dev, "Not enough bandwidth for altsetting %d\n",
3f0479e00a3fca Sarah Sharp                   2009-12-03  1585  				alternate);
8306095fd2c110 Sarah Sharp                   2012-05-02  1586  		usb_enable_lpm(dev);
d673bfcbfffdeb Sarah Sharp                   2010-10-15  1587  		mutex_unlock(hcd->bandwidth_mutex);
3f0479e00a3fca Sarah Sharp                   2009-12-03  1588  		return ret;
3f0479e00a3fca Sarah Sharp                   2009-12-03  1589  	}
3f0479e00a3fca Sarah Sharp                   2009-12-03  1590  
392e1d9817d002 Alan Stern                    2008-03-11  1591  	if (dev->quirks & USB_QUIRK_NO_SET_INTF)
392e1d9817d002 Alan Stern                    2008-03-11  1592  		ret = -EPIPE;
392e1d9817d002 Alan Stern                    2008-03-11  1593  	else
297e84c04d76b9 Greg Kroah-Hartman            2020-09-14  1594  		ret = usb_control_msg_send(dev, 0,
297e84c04d76b9 Greg Kroah-Hartman            2020-09-14  1595  					   USB_REQ_SET_INTERFACE,
297e84c04d76b9 Greg Kroah-Hartman            2020-09-14  1596  					   USB_RECIP_INTERFACE, alternate,
ddd1198e3e0935 Oliver Neukum                 2020-09-23  1597  					   interface, NULL, 0, 5000,
ddd1198e3e0935 Oliver Neukum                 2020-09-23  1598  					   GFP_NOIO);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1599  
^1da177e4c3f41 Linus Torvalds                2005-04-16  1600  	/* 9.4.10 says devices don't need this and are free to STALL the
^1da177e4c3f41 Linus Torvalds                2005-04-16  1601  	 * request if the interface only has one alternate setting.
^1da177e4c3f41 Linus Torvalds                2005-04-16  1602  	 */
^1da177e4c3f41 Linus Torvalds                2005-04-16  1603  	if (ret == -EPIPE && iface->num_altsetting == 1) {
^1da177e4c3f41 Linus Torvalds                2005-04-16  1604  		dev_dbg(&dev->dev,
^1da177e4c3f41 Linus Torvalds                2005-04-16  1605  			"manual set_interface for iface %d, alt %d\n",
^1da177e4c3f41 Linus Torvalds                2005-04-16  1606  			interface, alternate);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1607  		manual = 1;
297e84c04d76b9 Greg Kroah-Hartman            2020-09-14  1608  	} else if (ret) {
3f0479e00a3fca Sarah Sharp                   2009-12-03  1609  		/* Re-instate the old alt setting */
3f0479e00a3fca Sarah Sharp                   2009-12-03  1610  		usb_hcd_alloc_bandwidth(dev, NULL, alt, iface->cur_altsetting);
8306095fd2c110 Sarah Sharp                   2012-05-02  1611  		usb_enable_lpm(dev);
d673bfcbfffdeb Sarah Sharp                   2010-10-15  1612  		mutex_unlock(hcd->bandwidth_mutex);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1613  		return ret;
3f0479e00a3fca Sarah Sharp                   2009-12-03  1614  	}
d673bfcbfffdeb Sarah Sharp                   2010-10-15  1615  	mutex_unlock(hcd->bandwidth_mutex);
^1da177e4c3f41 Linus Torvalds                2005-04-16  1616  
^1da177e4c3f41 Linus Torvalds                2005-04-16  1617  	/* FIXME drivers shouldn't need to replicate/bugfix the logic here
^1da177e4c3f41 Linus Torvalds                2005-04-16  1618  	 * when they implement async or easily-killable versions of this or
^1da177e4c3f41 Linus Torvalds                2005-04-16  1619  	 * other "should-be-internal" functions (like clear_halt).
^1da177e4c3f41 Linus Torvalds                2005-04-16  1620  	 * should hcd+usbcore postprocess control requests?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

