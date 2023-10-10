Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4597C440C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 00:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbjJJW2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjJJW21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 18:28:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3581189;
        Tue, 10 Oct 2023 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696976885; x=1728512885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ls5dTIwY9SExragtwCKiEHREQnZIGV0jhQsOapCE07k=;
  b=VELRPuo49Qp0I/bttBY9/HcRAcri5g/WYoEUT8aVMO6X/JpWzu3DCuEH
   AR/dPmkZhWcgwf6L5/vTyd1Ce3V/dN2Pb1zWsLKuF4ALigcJXlSBGgUP4
   9yOEt7VVgQMEY2IaP1yLt6hkW0gGW/1wWr7JaifhFSCBHInPYkk5RMRRy
   EEmFtCFK6prKh/20Wpl1N5Nxi14Prq9acZjquio6en/i4qyatVbQ9wiZp
   1rzxHwc2YJsZdlRIKt/OTN3wNB7Nx2zeXUWlwDzv1pHZfiTdNgAXg6/RU
   CtXXFJeTiSz69HWbjDxWjcuXPx2rSFXFqiGfH60W+7AZ7UmXDGHslJw/K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388388031"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388388031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 15:27:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788752394"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788752394"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Oct 2023 15:27:30 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqLCK-0001IU-1q;
        Tue, 10 Oct 2023 22:27:28 +0000
Date:   Wed, 11 Oct 2023 06:26:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
Message-ID: <202310110658.n9yg3tJy-lkp@intel.com>
References: <20231009142005.21338-2-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009142005.21338-2-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc5 next-20231010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/usb-gadget-ncm-Add-support-to-update-wMaxSegmentSize-via-configfs/20231009-222315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231009142005.21338-2-quic_kriskura%40quicinc.com
patch subject: [PATCH 2/2] usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs
config: i386-randconfig-062-20231010 (https://download.01.org/0day-ci/archive/20231011/202310110658.n9yg3tJy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231011/202310110658.n9yg3tJy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310110658.n9yg3tJy-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/usb/gadget/function/f_ncm.c:1475:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 static [addressable] [assigned] [toplevel] [usertype] wMaxSegmentSize @@     got unsigned int [usertype] max_segment_size @@
   drivers/usb/gadget/function/f_ncm.c:1475:34: sparse:     expected restricted __le16 static [addressable] [assigned] [toplevel] [usertype] wMaxSegmentSize
   drivers/usb/gadget/function/f_ncm.c:1475:34: sparse:     got unsigned int [usertype] max_segment_size
>> drivers/usb/gadget/function/f_ncm.c:1669:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] max_segment_size @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/function/f_ncm.c:1669:32: sparse:     expected unsigned int [usertype] max_segment_size
   drivers/usb/gadget/function/f_ncm.c:1669:32: sparse:     got restricted __le16 [usertype]

vim +1475 drivers/usb/gadget/function/f_ncm.c

  1397	
  1398	static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
  1399	{
  1400		struct usb_composite_dev *cdev = c->cdev;
  1401		struct f_ncm		*ncm = func_to_ncm(f);
  1402		struct usb_string	*us;
  1403		int			status;
  1404		struct usb_ep		*ep;
  1405		struct f_ncm_opts	*ncm_opts;
  1406	
  1407		if (!can_support_ecm(cdev->gadget))
  1408			return -EINVAL;
  1409	
  1410		ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
  1411	
  1412		if (cdev->use_os_string) {
  1413			ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
  1414			f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
  1415						   GFP_KERNEL);
  1416			if (!f->os_desc_table)
  1417				return -ENOMEM;
  1418			f->os_desc_n = 1;
  1419			f->os_desc_table[0].os_desc = &ncm_opts->ncm_os_desc;
  1420		}
  1421	
  1422		/*
  1423		 * in drivers/usb/gadget/configfs.c:configfs_composite_bind()
  1424		 * configurations are bound in sequence with list_for_each_entry,
  1425		 * in each configuration its functions are bound in sequence
  1426		 * with list_for_each_entry, so we assume no race condition
  1427		 * with regard to ncm_opts->bound access
  1428		 */
  1429		if (!ncm_opts->bound) {
  1430			mutex_lock(&ncm_opts->lock);
  1431			gether_set_gadget(ncm_opts->net, cdev->gadget);
  1432			status = gether_register_netdev(ncm_opts->net);
  1433			mutex_unlock(&ncm_opts->lock);
  1434			if (status)
  1435				goto fail;
  1436			ncm_opts->bound = true;
  1437		}
  1438		us = usb_gstrings_attach(cdev, ncm_strings,
  1439					 ARRAY_SIZE(ncm_string_defs));
  1440		if (IS_ERR(us)) {
  1441			status = PTR_ERR(us);
  1442			goto fail;
  1443		}
  1444		ncm_control_intf.iInterface = us[STRING_CTRL_IDX].id;
  1445		ncm_data_nop_intf.iInterface = us[STRING_DATA_IDX].id;
  1446		ncm_data_intf.iInterface = us[STRING_DATA_IDX].id;
  1447		ecm_desc.iMACAddress = us[STRING_MAC_IDX].id;
  1448		ncm_iad_desc.iFunction = us[STRING_IAD_IDX].id;
  1449	
  1450		/* allocate instance-specific interface IDs */
  1451		status = usb_interface_id(c, f);
  1452		if (status < 0)
  1453			goto fail;
  1454		ncm->ctrl_id = status;
  1455		ncm_iad_desc.bFirstInterface = status;
  1456	
  1457		ncm_control_intf.bInterfaceNumber = status;
  1458		ncm_union_desc.bMasterInterface0 = status;
  1459	
  1460		if (cdev->use_os_string)
  1461			f->os_desc_table[0].if_id =
  1462				ncm_iad_desc.bFirstInterface;
  1463	
  1464		status = usb_interface_id(c, f);
  1465		if (status < 0)
  1466			goto fail;
  1467		ncm->data_id = status;
  1468	
  1469		ncm_data_nop_intf.bInterfaceNumber = status;
  1470		ncm_data_intf.bInterfaceNumber = status;
  1471		ncm_union_desc.bSlaveInterface0 = status;
  1472	
  1473		status = -ENODEV;
  1474	
> 1475		ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
  1476	
  1477		/* allocate instance-specific endpoints */
  1478		ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
  1479		if (!ep)
  1480			goto fail;
  1481		ncm->port.in_ep = ep;
  1482	
  1483		ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_out_desc);
  1484		if (!ep)
  1485			goto fail;
  1486		ncm->port.out_ep = ep;
  1487	
  1488		ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_notify_desc);
  1489		if (!ep)
  1490			goto fail;
  1491		ncm->notify = ep;
  1492	
  1493		status = -ENOMEM;
  1494	
  1495		/* allocate notification request and buffer */
  1496		ncm->notify_req = usb_ep_alloc_request(ep, GFP_KERNEL);
  1497		if (!ncm->notify_req)
  1498			goto fail;
  1499		ncm->notify_req->buf = kmalloc(NCM_STATUS_BYTECOUNT, GFP_KERNEL);
  1500		if (!ncm->notify_req->buf)
  1501			goto fail;
  1502		ncm->notify_req->context = ncm;
  1503		ncm->notify_req->complete = ncm_notify_complete;
  1504	
  1505		/*
  1506		 * support all relevant hardware speeds... we expect that when
  1507		 * hardware is dual speed, all bulk-capable endpoints work at
  1508		 * both speeds
  1509		 */
  1510		hs_ncm_in_desc.bEndpointAddress = fs_ncm_in_desc.bEndpointAddress;
  1511		hs_ncm_out_desc.bEndpointAddress = fs_ncm_out_desc.bEndpointAddress;
  1512		hs_ncm_notify_desc.bEndpointAddress =
  1513			fs_ncm_notify_desc.bEndpointAddress;
  1514	
  1515		ss_ncm_in_desc.bEndpointAddress = fs_ncm_in_desc.bEndpointAddress;
  1516		ss_ncm_out_desc.bEndpointAddress = fs_ncm_out_desc.bEndpointAddress;
  1517		ss_ncm_notify_desc.bEndpointAddress =
  1518			fs_ncm_notify_desc.bEndpointAddress;
  1519	
  1520		status = usb_assign_descriptors(f, ncm_fs_function, ncm_hs_function,
  1521				ncm_ss_function, ncm_ss_function);
  1522		if (status)
  1523			goto fail;
  1524	
  1525		/*
  1526		 * NOTE:  all that is done without knowing or caring about
  1527		 * the network link ... which is unavailable to this code
  1528		 * until we're activated via set_alt().
  1529		 */
  1530	
  1531		ncm->port.open = ncm_open;
  1532		ncm->port.close = ncm_close;
  1533	
  1534		hrtimer_init(&ncm->task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
  1535		ncm->task_timer.function = ncm_tx_timeout;
  1536	
  1537		DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
  1538				ncm->port.in_ep->name, ncm->port.out_ep->name,
  1539				ncm->notify->name);
  1540		return 0;
  1541	
  1542	fail:
  1543		kfree(f->os_desc_table);
  1544		f->os_desc_n = 0;
  1545	
  1546		if (ncm->notify_req) {
  1547			kfree(ncm->notify_req->buf);
  1548			usb_ep_free_request(ncm->notify, ncm->notify_req);
  1549		}
  1550	
  1551		ERROR(cdev, "%s: can't bind, err %d\n", f->name, status);
  1552	
  1553		return status;
  1554	}
  1555	
  1556	static inline struct f_ncm_opts *to_f_ncm_opts(struct config_item *item)
  1557	{
  1558		return container_of(to_config_group(item), struct f_ncm_opts,
  1559				    func_inst.group);
  1560	}
  1561	
  1562	/* f_ncm_item_ops */
  1563	USB_ETHERNET_CONFIGFS_ITEM(ncm);
  1564	
  1565	/* f_ncm_opts_dev_addr */
  1566	USB_ETHERNET_CONFIGFS_ITEM_ATTR_DEV_ADDR(ncm);
  1567	
  1568	/* f_ncm_opts_host_addr */
  1569	USB_ETHERNET_CONFIGFS_ITEM_ATTR_HOST_ADDR(ncm);
  1570	
  1571	/* f_ncm_opts_qmult */
  1572	USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
  1573	
  1574	/* f_ncm_opts_ifname */
  1575	USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
  1576	
  1577	static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
  1578						      char *page)
  1579	{
  1580		struct f_ncm_opts *opts = to_f_ncm_opts(item);
  1581		u32 segment_size;
  1582	
  1583		mutex_lock(&opts->lock);
  1584		segment_size = opts->max_segment_size;
  1585		mutex_unlock(&opts->lock);
  1586	
  1587		return sprintf(page, "%u\n", segment_size);
  1588	}
  1589	
  1590	static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
  1591						       const char *page, size_t len)
  1592	{
  1593		struct f_ncm_opts *opts = to_f_ncm_opts(item);
  1594		int ret;
  1595		u32 segment_size;
  1596	
  1597		mutex_lock(&opts->lock);
  1598		if (opts->refcnt) {
  1599			ret = -EBUSY;
  1600			goto out;
  1601		}
  1602	
  1603		ret = kstrtou32(page, 0, &segment_size);
  1604		if (ret)
  1605			goto out;
  1606	
  1607		if (segment_size > MAX_DATAGRAM_SIZE) {
  1608			ret = -EINVAL;
  1609			goto out;
  1610		}
  1611	
  1612		opts->max_segment_size = segment_size;
  1613		ret = len;
  1614	out:
  1615		mutex_unlock(&opts->lock);
  1616		return ret;
  1617	}
  1618	
  1619	CONFIGFS_ATTR(ncm_opts_, max_segment_size);
  1620	
  1621	static struct configfs_attribute *ncm_attrs[] = {
  1622		&ncm_opts_attr_dev_addr,
  1623		&ncm_opts_attr_host_addr,
  1624		&ncm_opts_attr_qmult,
  1625		&ncm_opts_attr_ifname,
  1626		&ncm_opts_attr_max_segment_size,
  1627		NULL,
  1628	};
  1629	
  1630	static const struct config_item_type ncm_func_type = {
  1631		.ct_item_ops	= &ncm_item_ops,
  1632		.ct_attrs	= ncm_attrs,
  1633		.ct_owner	= THIS_MODULE,
  1634	};
  1635	
  1636	static void ncm_free_inst(struct usb_function_instance *f)
  1637	{
  1638		struct f_ncm_opts *opts;
  1639	
  1640		opts = container_of(f, struct f_ncm_opts, func_inst);
  1641		if (opts->bound)
  1642			gether_cleanup(netdev_priv(opts->net));
  1643		else
  1644			free_netdev(opts->net);
  1645		kfree(opts->ncm_interf_group);
  1646		kfree(opts);
  1647	}
  1648	
  1649	static struct usb_function_instance *ncm_alloc_inst(void)
  1650	{
  1651		struct f_ncm_opts *opts;
  1652		struct usb_os_desc *descs[1];
  1653		char *names[1];
  1654		struct config_group *ncm_interf_group;
  1655	
  1656		opts = kzalloc(sizeof(*opts), GFP_KERNEL);
  1657		if (!opts)
  1658			return ERR_PTR(-ENOMEM);
  1659		opts->ncm_os_desc.ext_compat_id = opts->ncm_ext_compat_id;
  1660	
  1661		mutex_init(&opts->lock);
  1662		opts->func_inst.free_func_inst = ncm_free_inst;
  1663		opts->net = gether_setup_default();
  1664		if (IS_ERR(opts->net)) {
  1665			struct net_device *net = opts->net;
  1666			kfree(opts);
  1667			return ERR_CAST(net);
  1668		}
> 1669		opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
  1670		INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
  1671	
  1672		descs[0] = &opts->ncm_os_desc;
  1673		names[0] = "ncm";
  1674	
  1675		config_group_init_type_name(&opts->func_inst.group, "", &ncm_func_type);
  1676		ncm_interf_group =
  1677			usb_os_desc_prepare_interf_dir(&opts->func_inst.group, 1, descs,
  1678						       names, THIS_MODULE);
  1679		if (IS_ERR(ncm_interf_group)) {
  1680			ncm_free_inst(&opts->func_inst);
  1681			return ERR_CAST(ncm_interf_group);
  1682		}
  1683		opts->ncm_interf_group = ncm_interf_group;
  1684	
  1685		return &opts->func_inst;
  1686	}
  1687	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
