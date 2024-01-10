Return-Path: <linux-kernel+bounces-21579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306E382916A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B631C25355
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D4C3D71;
	Wed, 10 Jan 2024 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bbCMQfhk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C03222
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704846560; x=1736382560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iyJl9eeH/UsQN8l9ZBxofSoBYvOZbe3lcYZBrnye7oo=;
  b=bbCMQfhk8jegC4HpzhcLwjgHehDwkrl8AO9fxSeURa2GXpusqId73CNu
   QiESP++OLdJzctMMHjcotLelh0UCl7jzjiAkVXsBsz1Rz/C+MqVw8uzw7
   4uGklFDqM2v2iRX1pdNNAIRejXSBqu4fZv3pKOMMR/wR6ymoaluydDY0o
   uPQzXIDVEZA8xbH2kWErEg7EYYCZ1JPSt1hxU5jSgG365CGxcVp+hxzPg
   4HVO13RlerM0I7aRCA/RzMO9DiL/iYY0qdcTmxSNgBE/wAy2UZsV2P7c9
   tAZBOsp9SmndNJaUoo+mX8ISiYcHjdnQQMhJCIvCjP6OzxRe224hw45XC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5112026"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5112026"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 16:29:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785422316"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="785422316"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jan 2024 16:29:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNMT6-0006QP-2R;
	Wed, 10 Jan 2024 00:29:16 +0000
Date: Wed, 10 Jan 2024 08:28:59 +0800
From: kernel test robot <lkp@intel.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: drivers/soc/qcom/qcom_aoss.c:230:9: warning: function 'qmp_send'
 might be a candidate for 'gnu_printf' format attribute
Message-ID: <202401100855.UYl3HPPt-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bjorn,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c1dd1fe5d8a1d43ed96e2e0ed44a88c73c5c039
commit: 8873d1e2f88afbe89c99d8f49f88934a2da2991f soc: qcom: aoss: Format string in qmp_send()
date:   5 months ago
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20240110/202401100855.UYl3HPPt-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401100855.UYl3HPPt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401100855.UYl3HPPt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/soc/qcom/qcom_aoss.c: In function 'qmp_send':
>> drivers/soc/qcom/qcom_aoss.c:230:9: warning: function 'qmp_send' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     230 |         len = vsnprintf(buf, sizeof(buf), fmt, args);
         |         ^~~


vim +230 drivers/soc/qcom/qcom_aoss.c

   204	
   205	/**
   206	 * qmp_send() - send a message to the AOSS
   207	 * @qmp: qmp context
   208	 * @fmt: format string for message to be sent
   209	 * @...: arguments for the format string
   210	 *
   211	 * Transmit message to AOSS and wait for the AOSS to acknowledge the message.
   212	 * data must not be longer than the mailbox size. Access is synchronized by
   213	 * this implementation.
   214	 *
   215	 * Return: 0 on success, negative errno on failure
   216	 */
   217	int qmp_send(struct qmp *qmp, const char *fmt, ...)
   218	{
   219		char buf[QMP_MSG_LEN];
   220		long time_left;
   221		va_list args;
   222		int len;
   223		int ret;
   224	
   225		if (WARN_ON(IS_ERR_OR_NULL(qmp) || !fmt))
   226			return -EINVAL;
   227	
   228		memset(buf, 0, sizeof(buf));
   229		va_start(args, fmt);
 > 230		len = vsnprintf(buf, sizeof(buf), fmt, args);
   231		va_end(args);
   232	
   233		if (WARN_ON(len >= sizeof(buf)))
   234			return -EINVAL;
   235	
   236		mutex_lock(&qmp->tx_lock);
   237	
   238		/* The message RAM only implements 32-bit accesses */
   239		__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
   240				 buf, sizeof(buf) / sizeof(u32));
   241		writel(sizeof(buf), qmp->msgram + qmp->offset);
   242	
   243		/* Read back length to confirm data written in message RAM */
   244		readl(qmp->msgram + qmp->offset);
   245		qmp_kick(qmp);
   246	
   247		time_left = wait_event_interruptible_timeout(qmp->event,
   248							     qmp_message_empty(qmp), HZ);
   249		if (!time_left) {
   250			dev_err(qmp->dev, "ucore did not ack channel\n");
   251			ret = -ETIMEDOUT;
   252	
   253			/* Clear message from buffer */
   254			writel(0, qmp->msgram + qmp->offset);
   255		} else {
   256			ret = 0;
   257		}
   258	
   259		mutex_unlock(&qmp->tx_lock);
   260	
   261		return ret;
   262	}
   263	EXPORT_SYMBOL(qmp_send);
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

