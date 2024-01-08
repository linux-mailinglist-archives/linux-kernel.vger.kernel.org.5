Return-Path: <linux-kernel+bounces-19124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9082685A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A131281BAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D123AD49;
	Mon,  8 Jan 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqwWDey1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691D38F5C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 07:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704697281; x=1736233281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5S4isNVG9Yb7RJpP09hRnFGD7S+jYFLuPo45bW/bt5o=;
  b=DqwWDey1+T38GDYEc9VrkEvpC0el72ezITooAQ4dITstZfv/ieoMWPcv
   tBvJlNmRezOkOt71/7fLjMLXkEnliSQhcXIe7xLRXZah54ykB9lhgcuL7
   H89UQ8qfnbYfrcljsplQPB1lTswPgE8nQnkmsc9dH9d53AALG4Xy4ZwVa
   e2dhC/WWOcNIu0fVckqfKsUoFkUJibXnu2yeAn2NYO6+lH7zwrIfg23XG
   yi2IzSZYQrEg7sbiMmmRQCVD/E8Y0q8hbiDpXdNRqOYmjdFzatZJewPE3
   xbffhKWF3/3Bi7Nld0dVUjF8ybrTNBegNKz+RP2OVXyrCW3tLFu1oKAOF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="462099696"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="462099696"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 23:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="23077666"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 07 Jan 2024 23:01:20 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMjci-0004V6-1c;
	Mon, 08 Jan 2024 07:00:59 +0000
Date: Mon, 8 Jan 2024 14:59:54 +0800
From: kernel test robot <lkp@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: drivers/usb/typec/ucsi/ucsi_glink.c:258:2-3: Unneeded semicolon
Message-ID: <202401081453.4Ff5FBfw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dd3ee31125508cd67f7e7172247f05b7fd1753a
commit: 62b5412b1f4afab27d8df90ddcabb8e1e11a00ad usb: typec: ucsi: add PMIC Glink UCSI driver
date:   10 months ago
config: i386-randconfig-052-20240106 (https://download.01.org/0day-ci/archive/20240108/202401081453.4Ff5FBfw-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401081453.4Ff5FBfw-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/usb/typec/ucsi/ucsi_glink.c:258:2-3: Unneeded semicolon

vim +258 drivers/usb/typec/ucsi/ucsi_glink.c

   242	
   243	static void pmic_glink_ucsi_callback(const void *data, size_t len, void *priv)
   244	{
   245		struct pmic_glink_ucsi *ucsi = priv;
   246		const struct pmic_glink_hdr *hdr = data;
   247	
   248		switch (hdr->opcode) {
   249		case UC_UCSI_READ_BUF_REQ:
   250			pmic_glink_ucsi_read_ack(ucsi, data, len);
   251			break;
   252		case UC_UCSI_WRITE_BUF_REQ:
   253			pmic_glink_ucsi_write_ack(ucsi, data, len);
   254			break;
   255		case UC_UCSI_USBC_NOTIFY_IND:
   256			schedule_work(&ucsi->notify_work);
   257			break;
 > 258		};
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

