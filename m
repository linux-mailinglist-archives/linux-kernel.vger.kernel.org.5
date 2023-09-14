Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE40A7A1096
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 00:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjINWKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 18:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjINWJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:09:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259F2120
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694729394; x=1726265394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i4f2hEwbc51rFz7HU9r9ZVQR35g2MfAlU7DdAx6oyjA=;
  b=hF8Pr58gCjrLlRLeLw3Q6YzmVJkzqbEWkjNyuiC841lUlIcunJSCAKRl
   HE3MetDmsK1yqr2w20FBl+9HvMnyDrCc/bU5i9PL0M0Gzc4/LrDc8uU/+
   Ca0i4J0tdwA7BJCMHsvJ8Y5DDT6rE+kRIduw/7RSdLd0QAUaUJRfVviYU
   ha71oqPraZzFR9L5+hegz/cf4jaL+qIfJ5j5ncigRrkTLY7K6Sk40GmOz
   xvC81Zg7doBDCzg1kVB/q0bvqkTQ55sqgI6Vh40MEskVcPVDssSeKbeps
   XudiiRTyogdAKxl63KzXOZajWyxk/xmt6a4wUCW1LabgimXTy69D7SR3m
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="410028991"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="410028991"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 15:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="1075550995"
X-IronPort-AV: E=Sophos;i="6.02,147,1688454000"; 
   d="scan'208";a="1075550995"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2023 15:09:51 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qguWz-00026z-0P;
        Thu, 14 Sep 2023 22:09:49 +0000
Date:   Fri, 15 Sep 2023 06:09:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ondrej Zary <linux@zary.sk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: drivers/ata/pata_parport/comm.c:64 comm_read_regr() warn:
 inconsistent indenting
Message-ID: <202309150646.n3iBvbPj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9fdfb15a3dbf818e06be514f4abbfc071004cbe7
commit: 72f2b0b2185099dce354c805009f591dda3ab73d drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport
date:   8 months ago
config: x86_64-randconfig-161-20230915 (https://download.01.org/0day-ci/archive/20230915/202309150646.n3iBvbPj-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230915/202309150646.n3iBvbPj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309150646.n3iBvbPj-lkp@intel.com/

New smatch warnings:
drivers/ata/pata_parport/comm.c:64 comm_read_regr() warn: inconsistent indenting
drivers/ata/pata_parport/comm.c:164 comm_write_block() warn: inconsistent indenting

Old smatch warnings:
drivers/ata/pata_parport/comm.c:168 comm_write_block() warn: inconsistent indenting
drivers/ata/pata_parport/comm.c:172 comm_write_block() warn: inconsistent indenting

vim +64 drivers/ata/pata_parport/comm.c

^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   48  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   49          r = regr + cont_map[cont];
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   50  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   51          switch (pi->mode)  {
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   52  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   53          case 0: w0(r); P1; w0(0);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   54          	w2(6); l = r1(); w0(0x80); h = r1(); w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   55                  return j44(l,h);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   56  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   57          case 1: w0(r+0x20); P1; 
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   58          	w0(0); w2(0x26); h = r0(); w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   59                  return h;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   60  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   61  	case 2:
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   62  	case 3:
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24   63          case 4: w3(r+0x20); (void)r1();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  @64          	w2(0x24); h = r4(); w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   65                  return h;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   66  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   67          }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   68          return -1;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   69  }       
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   70  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   71  static void comm_write_regr( PIA *pi, int cont, int regr, int val )
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   72  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   73  {       int  r;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   74  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   75          r = regr + cont_map[cont];
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   76  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   77          switch (pi->mode)  {
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   78  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   79          case 0:
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   80          case 1: w0(r); P1; w0(val); P2;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   81  		break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   82  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   83  	case 2:
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   84  	case 3:
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24   85          case 4: w3(r); (void)r1(); w4(val);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   86                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   87          }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   88  }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   89  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   90  static void comm_connect ( PIA *pi  )
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   91  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   92  {       pi->saved_r0 = r0();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   93          pi->saved_r2 = r2();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   94          w2(4); w0(0xff); w2(6);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   95          w2(4); w0(0xaa); w2(6);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   96          w2(4); w0(0x00); w2(6);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   97          w2(4); w0(0x87); w2(6);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   98          w2(4); w0(0xe0); w2(0xc); w2(0xc); w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16   99  }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  100  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  101  static void comm_disconnect ( PIA *pi )
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  102  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  103  {       w2(0); w2(0); w2(0); w2(4); 
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  104  	w0(pi->saved_r0);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  105          w2(pi->saved_r2);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  106  } 
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  107  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  108  static void comm_read_block( PIA *pi, char * buf, int count )
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  109  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  110  {       int     i, l, h;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  111  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  112          switch (pi->mode) {
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  113          
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  114          case 0: w0(0x48); P1;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  115                  for(i=0;i<count;i++) {
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  116                          w0(0); w2(6); l = r1();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  117                          w0(0x80); h = r1(); w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  118                          buf[i] = j44(l,h);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  119                  }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  120                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  121  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  122          case 1: w0(0x68); P1; w0(0);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  123                  for(i=0;i<count;i++) {
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  124                          w2(0x26); buf[i] = r0(); w2(0x24);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  125                  }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  126  		w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  127  		break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  128  		
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24  129  	case 2: w3(0x68); (void)r1(); w2(0x24);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  130  		for (i=0;i<count;i++) buf[i] = r4();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  131  		w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  132  		break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  133  
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24  134          case 3: w3(0x68); (void)r1(); w2(0x24);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  135                  for (i=0;i<count/2;i++) ((u16 *)buf)[i] = r4w();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  136                  w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  137                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  138  
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24  139          case 4: w3(0x68); (void)r1(); w2(0x24);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  140                  for (i=0;i<count/4;i++) ((u32 *)buf)[i] = r4l();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  141                  w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  142                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  143  		
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  144  	}
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  145  }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  146  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  147  /* NB: Watch out for the byte swapped writes ! */
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  148  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  149  static void comm_write_block( PIA *pi, char * buf, int count )
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  150  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  151  {       int	k;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  152  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  153          switch (pi->mode) {
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  154  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  155          case 0:
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  156          case 1: w0(0x68); P1;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  157          	for (k=0;k<count;k++) {
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  158                          w2(5); w0(buf[k^1]); w2(7);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  159                  }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  160                  w2(5); w2(4);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  161                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  162  
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24  163          case 2: w3(0x48); (void)r1();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16 @164                  for (k=0;k<count;k++) w4(buf[k^1]);
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  165                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  166  
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24  167          case 3: w3(0x48); (void)r1();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  168                  for (k=0;k<count/2;k++) w4w(pi_swab16(buf,k));
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  169                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  170  
10e705f83c3e79 drivers/block/paride/comm.c Takashi Iwai   2006-03-24  171          case 4: w3(0x48); (void)r1();
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  172                  for (k=0;k<count/4;k++) w4l(pi_swab32(buf,k));
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  173                  break;
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  174  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  175  
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  176          }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  177  }
^1da177e4c3f41 drivers/block/paride/comm.c Linus Torvalds 2005-04-16  178  

:::::: The code at line 64 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
