Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E3C80E240
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbjLLCp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjLLCp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:45:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFFDB5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 18:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702349162; x=1733885162;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LzGp7e5lRNJcfZk/kZG8UfEgksYE3+20ek8qnOmVoIU=;
  b=PpqWt+w6OGar7943IYaarj0W34CKep1nobrEOJW+DMAjols+HD9VFBF+
   peEH9n9+auWjr8pWGHt172p8KWK06v9e1TGp9kCduR/ZGqGQ2vARFIn9F
   IkmKOZphbd5N7teT0DsXGsgbiYNWJAeKSAtgbpRCtdc8nJdvhCuDNulfc
   NM6875PJEuBxq265f5vrB25FkkoI8HDlDUJm3uW6jlTuYTlANfSfluuHe
   PTEGOWKu/gF6clK7HhwzZLEe7tn26JV31OlEO/P3ZYamqVh0rMQK73MKX
   yFnZUQv4zoe6QNHeQLWXbEVolIyoVnDCb6OX3eLzP7YnQLvCn/joSAvY6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="425868416"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="425868416"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="896729941"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="896729941"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Dec 2023 18:45:59 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCsmT-000Ih5-1f;
        Tue, 12 Dec 2023 02:45:57 +0000
Date:   Tue, 12 Dec 2023 10:45:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: drivers/comedi/drivers/ni_daq_700.c:163:17: sparse: sparse: cast to
 restricted __le16
Message-ID: <202312121026.69R96xQ2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   26aff849438cebcd05f1a647390c4aa700d5c0f1
commit: 30b5e6ef4a32ea4985b99200e06d6660a69f9246 m68k: atari: Make Atari ROM port I/O write macros return void
date:   1 year, 7 months ago
config: m68k-randconfig-r131-20231119 (https://download.01.org/0day-ci/archive/20231212/202312121026.69R96xQ2-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231212/202312121026.69R96xQ2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312121026.69R96xQ2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/comedi/drivers/ni_daq_700.c:163:17: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/ni_daq_700.c:163:17: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/ni_daq_700.c:163:17: sparse: sparse: cast to restricted __le16
>> drivers/comedi/drivers/ni_daq_700.c:163:17: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:173:21: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:173:21: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:173:21: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:173:21: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:205:9: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:205:9: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:205:9: sparse: sparse: cast to restricted __le16
   drivers/comedi/drivers/ni_daq_700.c:205:9: sparse: sparse: cast to restricted __le16

vim +163 drivers/comedi/drivers/ni_daq_700.c

a9f9d831454114 drivers/staging/comedi/drivers/ni_daq_700.c H Hartley Sweeten 2014-02-10  129  
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  130  static int daq700_ai_rinsn(struct comedi_device *dev,
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  131  			   struct comedi_subdevice *s,
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  132  			   struct comedi_insn *insn, unsigned int *data)
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  133  {
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  134  	int n;
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  135  	int d;
a9f9d831454114 drivers/staging/comedi/drivers/ni_daq_700.c H Hartley Sweeten 2014-02-10  136  	int ret;
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  137  	unsigned int chan	= CR_CHAN(insn->chanspec);
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  138  	unsigned int aref	= CR_AREF(insn->chanspec);
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  139  	unsigned int range	= CR_RANGE(insn->chanspec);
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  140  	unsigned int r3_bits	= 0;
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  141  
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  142  	/* set channel input modes */
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  143  	if (aref == AREF_DIFF)
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  144  		r3_bits |= CMD_R3_DIFF;
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  145  	/* write channel mode/range */
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  146  	if (range >= 1)
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  147  		range++;        /* convert range to hardware value */
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  148  	outb(r3_bits | (range & 0x03), dev->iobase + CMD_R3);
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  149  
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  150  	/* write channel to multiplexer */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  151  	/* set mask scan bit high to disable scanning */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  152  	outb(chan | 0x80, dev->iobase + CMD_R1);
ffed54dced8672 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2014-05-19  153  	/* mux needs 2us to really settle [Fred Brooks]. */
ffed54dced8672 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2014-05-19  154  	udelay(2);
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  155  
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  156  	/* convert n samples */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  157  	for (n = 0; n < insn->n; n++) {
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  158  		/* trigger conversion with out0 L to H */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  159  		outb(0x00, dev->iobase + CMD_R2); /* enable ADC conversions */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  160  		outb(0x30, dev->iobase + CMO_R); /* mode 0 out0 L, from H */
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  161  		outb(0x00, dev->iobase + ADCLEAR_R);	/* clear the ADC FIFO */
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20  162  		/* read 16bit junk from FIFO to clear */
cf695df834efc7 drivers/staging/comedi/drivers/ni_daq_700.c Fred Brooks       2014-06-20 @163  		inw(dev->iobase + ADFIFO_R);
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  164  		/* mode 1 out0 H, L to H, start conversion */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  165  		outb(0x32, dev->iobase + CMO_R);
a9f9d831454114 drivers/staging/comedi/drivers/ni_daq_700.c H Hartley Sweeten 2014-02-10  166  
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  167  		/* wait for conversion to end */
a9f9d831454114 drivers/staging/comedi/drivers/ni_daq_700.c H Hartley Sweeten 2014-02-10  168  		ret = comedi_timeout(dev, s, insn, daq700_ai_eoc, 0);
22ca19d93d92c7 drivers/staging/comedi/drivers/ni_daq_700.c H Hartley Sweeten 2014-02-10  169  		if (ret)
a9f9d831454114 drivers/staging/comedi/drivers/ni_daq_700.c H Hartley Sweeten 2014-02-10  170  			return ret;
a9f9d831454114 drivers/staging/comedi/drivers/ni_daq_700.c H Hartley Sweeten 2014-02-10  171  
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  172  		/* read data */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  173  		d = inw(dev->iobase + ADFIFO_R);
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  174  		/* mangle the data as necessary */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  175  		/* Bipolar Offset Binary: 0 to 4095 for -10 to +10 */
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  176  		d &= 0x0fff;
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  177  		d ^= 0x0800;
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  178  		data[n] = d;
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  179  	}
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  180  	return n;
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  181  }
198b0fa48b25b6 drivers/staging/comedi/drivers/ni_daq_700.c Ian Abbott        2012-09-21  182  

:::::: The code at line 163 was first introduced by commit
:::::: cf695df834efc718b2ed17e9c83e127fd63c9033 staging: comedi: ni_daq_700: add AI range and input mode switching

:::::: TO: Fred Brooks <frederick.brooks@microchip.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
