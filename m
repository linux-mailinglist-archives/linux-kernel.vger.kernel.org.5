Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D3680A3DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573759AbjLHMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHMu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:50:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A87411C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702039834; x=1733575834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rXer6BoytSzn1SuWBN+xmOkdlfRiydYnmJIq6NqsPzU=;
  b=IyE7bMhfji6MpQhdEqtuPBcdM4VqBkkOTuxs+j1j2B4hNF8I22plFM0t
   3XpKtyHADvo4nO8YxQWc8W04TL7kVUgtYoOLMLnUrN7JEL3m3JvHHxwDs
   ju8+RkmZ9HrPRRGT767VdgILJ6Dhehef6mdQFeefItLUrMCDnJ3RE0TCw
   glyBNs/rvHDRAUjNpZq8+alPzt5mePNyUStkiz8uki5/wTI0AjrfIojhC
   jf1vJ4xkIj7HQP4FkFG+wZn+ASyLKvxINqqJRSL3knE1vMszJFbIwdSxZ
   z8ULkKd4eW2C5KvfC2dgXAAdCBYqh/KvEoGJqG68j7UIIt61aNuGpdYWl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="15952845"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="15952845"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 04:50:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775780485"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="775780485"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Dec 2023 04:50:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBaJK-000Djg-1Y;
        Fri, 08 Dec 2023 12:50:30 +0000
Date:   Fri, 8 Dec 2023 20:50:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: drivers/soc/qcom/qcom_aoss.c:230:9: warning: function 'qmp_send'
 might be a candidate for 'gnu_printf' format attribute
Message-ID: <202312082016.BRzEllrB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5e3f5b81de80c98338bcb47c233aebefee5a4801
commit: 8873d1e2f88afbe89c99d8f49f88934a2da2991f soc: qcom: aoss: Format string in qmp_send()
date:   4 months ago
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20231208/202312082016.BRzEllrB-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312082016.BRzEllrB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312082016.BRzEllrB-lkp@intel.com/

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
