Return-Path: <linux-kernel+bounces-27962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3462482F864
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7CA0288A50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032C8131E49;
	Tue, 16 Jan 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RbmnggF/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1749131745;
	Tue, 16 Jan 2024 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434694; cv=none; b=atnRxaW+SCJ/sVVoMdPwYv/PhIeJqeVh5lpNmup7oj4WkYqtA/ynUYyciXi0aMLcGkRYDyU3rY7p6eCzCXM9bqeGvDTaqWZqWuwldrYFugVkRx60PKypCtFZpKg2f9nAx4CvfjfWmJ6Nd6Aqamp6Qp8hNHpNWw/Zsv/DwC7413A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434694; c=relaxed/simple;
	bh=LYFKZ7TRuYk1pl41vPfkzt1g9GP165KZ2d+LPbo5cvk=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rzp7GM1z/1QoZm8wN9K8ZU7Ku4muncPBl4JJYW3pC3EkWtHm7DvvqBSXh/9Zxnxhsvcz+IC4AJdx4AYdvHTYGCj9ax24NC0LoNMMgIyQiiDpTxtOgL2ydYGwz5RuYxZ5QQe8pjzkDFAvJvvOOQSDQGz75Rzg7W/RsbtRHdSULa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RbmnggF/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705434693; x=1736970693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LYFKZ7TRuYk1pl41vPfkzt1g9GP165KZ2d+LPbo5cvk=;
  b=RbmnggF/qb4euGFspfd8dksFx7iB6jZlhwTgWHYoaw5z7Ytk2jiXrHLL
   ADYyOL7qK7GibbMkeQzhGdD0rFQgfMITiVdlOaS9ENdLEMzZ3LIN26HbU
   TIthaAzpacSclhdAPbn9fqoq43X4ZhXTs32yQgofEIgWWqTW0ZiZppAkP
   YK+uH3WQkbzpLk/dkTRXzLKzrt2vxAqSZU8SFLU4mQG1KxjD03mIyjst8
   MHv54LrUwCorB261Zcv8AM/HZsnNheVzkONyieMrYCniyhlDQD9R5vTII
   2Q+PbBZ4hFOnfR/pmLANz9dVQ/RhdEJH+bvLoizUzKofpJ69WWLnH/ga4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="18562463"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="18562463"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 11:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="907479092"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="907479092"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2024 11:51:28 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rPpT4-0001AK-0z;
	Tue, 16 Jan 2024 19:51:26 +0000
Date: Wed, 17 Jan 2024 03:51:19 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, v9fs@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, kernel@pengutronix.de,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: Re: [PATCH 1/3] usb: gadget: function: 9pfs
Message-ID: <202401170342.VrKVlN1a-lkp@intel.com>
References: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116-ml-topic-u9p-v1-1-ad8c306f9a4e@pengutronix.de>

Hi Michael,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 052d534373b7ed33712a63d5e17b2b6cdbce84fd]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Grzeschik/usb-gadget-function-9pfs/20240116-095914
base:   052d534373b7ed33712a63d5e17b2b6cdbce84fd
patch link:    https://lore.kernel.org/r/20240116-ml-topic-u9p-v1-1-ad8c306f9a4e%40pengutronix.de
patch subject: [PATCH 1/3] usb: gadget: function: 9pfs
config: alpha-kismet-CONFIG_NET_9P-CONFIG_USB_F_9PFS-0-0 (https://download.01.org/0day-ci/archive/20240117/202401170342.VrKVlN1a-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240117/202401170342.VrKVlN1a-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401170342.VrKVlN1a-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for NET_9P when selected by USB_F_9PFS
   
   WARNING: unmet direct dependencies detected for NET_9P
     Depends on [n]: NET [=n]
     Selected by [y]:
     - USB_F_9PFS [=y] && USB_SUPPORT [=y] && USB_GADGET [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

