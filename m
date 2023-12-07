Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E152D809159
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443827AbjLGTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443852AbjLGTaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:30:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF1510DE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701977452; x=1733513452;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Ni9LHcDFxpSKk37CXMF+oPjVX8r7ExfZ+aG86iqZo6w=;
  b=WrJwdS6fpf7XfsCNME700JvsV5J2M/bedmi1TX0hQW8qlaJ8b0TijHrv
   f4zDbnG1noHO37IhbtDHmMTRidAq6Gx5k3Eu1zqs4JJd4PISkKYfuVXZY
   ozXvUOmEwYZyuxLQobDOcGV6z8ioTCZxNC0hplA2wsAgULFplIb6OA53l
   6HwJTYMcLFBzo3ajhV81MJlotA+vsIY3f50nh4vK43mMHDROOyW/Ail6C
   mgIRibjr1qDBlFAbMv5Y3cXW629UyaSddpNL6bCKe1BWbeFTqzySUyrF1
   pM1tq9ydfwdQ6yPJcqyETy76FgNV7N8a8TnlkZlMPgVdJWKeEs61aEEzg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="393161445"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="393161445"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="806132943"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="806132943"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2023 11:30:45 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBK54-000Cjh-2E;
        Thu, 07 Dec 2023 19:30:42 +0000
Date:   Fri, 8 Dec 2023 03:30:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Schmitz <schmitzmic@gmail.com>
Subject: drivers/comedi/drivers/ni_daq_700.c:163:17: sparse: sparse: cast to
 restricted __le16
Message-ID: <202312080308.IqKTXDYM-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: 30b5e6ef4a32ea4985b99200e06d6660a69f9246 m68k: atari: Make Atari ROM port I/O write macros return void
date:   1 year, 7 months ago
config: m68k-randconfig-r131-20231119 (https://download.01.org/0day-ci/archive/20231208/202312080308.IqKTXDYM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231208/202312080308.IqKTXDYM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312080308.IqKTXDYM-lkp@intel.com/

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
