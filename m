Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF7809686
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444099AbjLGXYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLGXYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:24:35 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C217E10DD;
        Thu,  7 Dec 2023 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991481; x=1733527481;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xoqsFo9dnxWWy6BSu4v73RRiTtczxofsXV0GmHIT9GE=;
  b=CZUOsi4MRyWo6dTjyx6dlzZvFQVxCzNSvyuTR7nYOeZrM6R1QHA8kyLv
   GDpZyQYVbWscMLzKrGqfPd2xC0Wq5PNYlea1TSoa7ln1FOHRuY5L5B828
   1COj643IiPmYYOZRr/YBvup2thxeuDNrASASSYs1ui/MKVuP3fs+pEM8k
   sLOazRxhQh95MYbNytoqZSaSJv5ZtIV3iXsTlVnvPElosyZzjtJ8Gyh1Q
   NX/k637d3jMgz0TBYIBRVWQrS//eNOBd7V4x6uLPrBU61+i+zgjGFF59d
   zHQBp8yWzLIdQRnl1SmLxNkhDodYpjyP0N09I8ehI8hS3drT9aG3sY4vY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1430969"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1430969"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:24:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="771923277"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="771923277"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 07 Dec 2023 15:24:36 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBNjM-000CyZ-1m;
        Thu, 07 Dec 2023 23:24:32 +0000
Date:   Fri, 8 Dec 2023 07:23:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     RD Babiera <rdbabiera@google.com>, heikki.krogerus@linux.intel.com,
        linux@roeck-us.net, gregkh@linuxfoundation.org,
        pmalani@chromium.org, bleung@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        badhri@google.com, tzungbi@kernel.org, utkarsh.h.patel@intel.com,
        andriy.shevchenko@linux.intel.com,
        RD Babiera <rdbabiera@google.com>
Subject: Re: [PATCH v1 02/10] usb: typec: tcpci: enable reception of SOP'
 messages
Message-ID: <202312080751.GDJHcwNz-lkp@intel.com>
References: <20231207090738.15721-14-rdbabiera@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207090738.15721-14-rdbabiera@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi RD,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5e4c8814a431d21bfaf20b464134f40f2f81e152]

url:    https://github.com/intel-lab-lkp/linux/commits/RD-Babiera/usb-typec-bus-provide-transmit-type-for-alternate-mode-drivers/20231207-171114
base:   5e4c8814a431d21bfaf20b464134f40f2f81e152
patch link:    https://lore.kernel.org/r/20231207090738.15721-14-rdbabiera%40google.com
patch subject: [PATCH v1 02/10] usb: typec: tcpci: enable reception of SOP' messages
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20231208/202312080751.GDJHcwNz-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231208/202312080751.GDJHcwNz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080751.GDJHcwNz-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/usb/typec/tcpm/fusb302.c:1470:39: error: too few arguments to function call, expected 3, have 2
                   tcpm_pd_receive(chip->tcpm_port, msg);
                   ~~~~~~~~~~~~~~~                     ^
   include/linux/usb/tcpm.h:172:6: note: 'tcpm_pd_receive' declared here
   void tcpm_pd_receive(struct tcpm_port *port,
        ^
   1 error generated.
--
>> drivers/usb/typec/tcpm/wcove.c:538:37: error: too few arguments to function call, expected 3, have 2
                           tcpm_pd_receive(wcove->tcpm, &msg);
                           ~~~~~~~~~~~~~~~                  ^
   include/linux/usb/tcpm.h:172:6: note: 'tcpm_pd_receive' declared here
   void tcpm_pd_receive(struct tcpm_port *port,
        ^
   1 error generated.
--
>> drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c:302:52: error: too few arguments to function call, expected 3, have 2
                   tcpm_pd_receive(pmic_typec_pdphy->tcpm_port, &msg);
                   ~~~~~~~~~~~~~~~                                  ^
   include/linux/usb/tcpm.h:172:6: note: 'tcpm_pd_receive' declared here
   void tcpm_pd_receive(struct tcpm_port *port,
        ^
   1 error generated.


vim +1470 drivers/usb/typec/tcpm/fusb302.c

c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1421  
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1422  static int fusb302_pd_read_message(struct fusb302_chip *chip,
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1423  				   struct pd_message *msg)
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1424  {
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1425  	int ret = 0;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1426  	u8 token;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1427  	u8 crc[4];
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1428  	int len;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1429  
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1430  	/* first SOP token */
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1431  	ret = fusb302_i2c_read(chip, FUSB_REG_FIFOS, &token);
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1432  	if (ret < 0)
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1433  		return ret;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1434  	ret = fusb302_i2c_block_read(chip, FUSB_REG_FIFOS, 2,
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1435  				     (u8 *)&msg->header);
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1436  	if (ret < 0)
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1437  		return ret;
f03d95f59026d1 drivers/staging/typec/fusb302/fusb302.c Guru Das Srinagesh 2017-05-10  1438  	len = pd_header_cnt_le(msg->header) * 4;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1439  	/* add 4 to length to include the CRC */
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1440  	if (len > PD_MAX_PAYLOAD * 4) {
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1441  		fusb302_log(chip, "PD message too long %d", len);
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1442  		return -EINVAL;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1443  	}
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1444  	if (len > 0) {
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1445  		ret = fusb302_i2c_block_read(chip, FUSB_REG_FIFOS, len,
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1446  					     (u8 *)msg->payload);
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1447  		if (ret < 0)
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1448  			return ret;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1449  	}
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1450  	/* another 4 bytes to read CRC out */
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1451  	ret = fusb302_i2c_block_read(chip, FUSB_REG_FIFOS, 4, crc);
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1452  	if (ret < 0)
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1453  		return ret;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1454  	fusb302_log(chip, "PD message header: %x", msg->header);
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1455  	fusb302_log(chip, "PD message len: %d", len);
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1456  
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1457  	/*
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1458  	 * Check if we've read off a GoodCRC message. If so then indicate to
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1459  	 * TCPM that the previous transmission has completed. Otherwise we pass
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1460  	 * the received message over to TCPM for processing.
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1461  	 *
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1462  	 * We make this check here instead of basing the reporting decision on
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1463  	 * the IRQ event type, as it's possible for the chip to report the
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1464  	 * TX_SUCCESS and GCRCSENT events out of order on occasion, so we need
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1465  	 * to check the message type to ensure correct reporting to TCPM.
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1466  	 */
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1467  	if ((!len) && (pd_header_type_le(msg->header) == PD_CTRL_GOOD_CRC))
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1468  		tcpm_pd_transmit_complete(chip->tcpm_port, TCPC_TX_SUCCESS);
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1469  	else
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21 @1470  		tcpm_pd_receive(chip->tcpm_port, msg);
ab69f61321140f drivers/usb/typec/fusb302/fusb302.c     Adam Thomson       2017-11-21  1471  
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1472  	return ret;
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1473  }
c034a43e72dda5 drivers/staging/typec/fusb302/fusb302.c Yueyao Zhu         2017-04-27  1474  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
