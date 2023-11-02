Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F927DFAD2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377167AbjKBTVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKBTVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:21:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82C412D;
        Thu,  2 Nov 2023 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698952890; x=1730488890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4aDocD7TV5qDTqX6O/0RElVFY8KP0asSIkNfWDNs/9s=;
  b=iSB0J4lxgDB5cMq9Qs8vUJUfAZRjCEvP232d/C1zwTLYyD+vHyd+HHpN
   Re7bRGG1vBN5e2do2/dOuNSJCc3hRrXvDYGjl+tXt8XjLLLdPai1BdxaQ
   k6d7IwW7+43krM/eziHO3tsU9Rk9igrDwr30oeuDZ0bL15qQu2yIYqzrT
   UoB1NWnYlNb4MQMvtYRwmKoXc7SKy3c0lyTrsyGQggoGVoYkhFBb1R9o/
   71DI1FztGcVBVUQn2/bSkkzEuXYXiGLVOLwh7kZafzgmdNccuTtbdFmGg
   sJ0bPS19h5FbGKcR2d8FwPXBRfTCONr8ZvxUIDKCIEOpJE8TQ2Z0avnDy
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387671513"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387671513"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 12:21:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="737855631"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="737855631"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2023 12:21:25 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qydFr-0001nk-12;
        Thu, 02 Nov 2023 19:21:23 +0000
Date:   Fri, 3 Nov 2023 03:21:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
        Robert Marko <robimarko@gmail.com>
Subject: Re: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load
 support
Message-ID: <202311030347.asaThH7R-lkp@intel.com>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101123608.11157-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,WEIRD_PORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-Document-bindings-for-Marvell-Aquantia-PHY/20231101-203944
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231101123608.11157-1-ansuelsmth%40gmail.com
patch subject: [net-next PATCH v2 1/2] net: phy: aquantia: add firmware load support
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20231103/202311030347.asaThH7R-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030347.asaThH7R-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030347.asaThH7R-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/phy/aquantia_main.c: In function 'aqr_fw_boot':
>> drivers/net/phy/aquantia_main.c:857:13: warning: the address of 'version' will always evaluate as 'true' [-Waddress]
     857 |         if (!version) {
         |             ^
   during RTL pass: mach
   drivers/net/phy/aquantia_main.c: In function 'aqr107_chip_info':
   drivers/net/phy/aquantia_main.c:619:1: internal compiler error: in arc_ifcvt, at config/arc/arc.cc:9703
     619 | }
         | ^
   0x5b78c1 arc_ifcvt
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.cc:9703
   0xe431b4 arc_reorg
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/config/arc/arc.cc:8552
   0xaed299 execute
   	/tmp/build-crosstools-gcc-13.2.0-binutils-2.41/gcc/gcc-13.2.0/gcc/reorg.cc:3927
   Please submit a full bug report, with preprocessed source (by using -freport-bug).
   Please include the complete backtrace with any bug report.
   See <https://gcc.gnu.org/bugs/> for instructions.


vim +857 drivers/net/phy/aquantia_main.c

   789	
   790	static int aqr_fw_boot(struct phy_device *phydev, const u8 *data, size_t size)
   791	{
   792		const struct aqr_fw_header *header;
   793		u32 iram_offset = 0, iram_size = 0;
   794		u32 dram_offset = 0, dram_size = 0;
   795		char version[VERSION_STRING_SIZE];
   796		u16 calculated_crc, read_crc;
   797		u32 primary_offset = 0;
   798		int ret;
   799	
   800		/* extract saved CRC at the end of the fw */
   801		memcpy(&read_crc, data + size - 2, sizeof(read_crc));
   802		/* CRC is saved in big-endian as PHY is BE */
   803		read_crc = be16_to_cpu(read_crc);
   804		calculated_crc = crc_ccitt_false(0, data, size - 2);
   805		if (read_crc != calculated_crc) {
   806			phydev_err(phydev, "bad firmware CRC: file 0x%04x calculated 0x%04x\n",
   807				   read_crc, calculated_crc);
   808			return -EINVAL;
   809		}
   810	
   811		/* Get the primary offset to extract DRAM and IRAM sections. */
   812		memcpy(&primary_offset, data + PRIMARY_OFFSET_OFFSET, sizeof(u16));
   813		if (!primary_offset) {
   814			phydev_err(phydev, "bad primary offset in firmware\n");
   815			return -EINVAL;
   816		}
   817		primary_offset = PRIMARY_OFFSET(le32_to_cpu(primary_offset));
   818	
   819		/* Find the DRAM and IRAM sections within the firmware file. */
   820		header = (struct aqr_fw_header *)(data + primary_offset + HEADER_OFFSET);
   821		memcpy(&iram_offset, &header->iram_offset, sizeof(u8) * 3);
   822		if (!iram_offset) {
   823			phydev_err(phydev, "bad iram offset in firmware\n");
   824			return -EINVAL;
   825		}
   826		memcpy(&iram_size, &header->iram_size, sizeof(u8) * 3);
   827		if (!iram_size) {
   828			phydev_err(phydev, "invalid iram size in firmware\n");
   829			return -EINVAL;
   830		}
   831		memcpy(&dram_offset, &header->dram_offset, sizeof(u8) * 3);
   832		if (!dram_offset) {
   833			phydev_err(phydev, "bad dram offset in firmware\n");
   834			return -EINVAL;
   835		}
   836		memcpy(&dram_size, &header->dram_size, sizeof(u8) * 3);
   837		if (!dram_size) {
   838			phydev_err(phydev, "invalid dram size in firmware\n");
   839			return -EINVAL;
   840		}
   841	
   842		/* offset are in LE and values needs to be converted to cpu endian */
   843		iram_offset = le32_to_cpu(iram_offset);
   844		iram_size = le32_to_cpu(iram_size);
   845		dram_offset = le32_to_cpu(dram_offset);
   846		dram_size = le32_to_cpu(dram_size);
   847	
   848		/* Increment the offset with the primary offset. */
   849		iram_offset += primary_offset;
   850		dram_offset += primary_offset;
   851	
   852		phydev_dbg(phydev, "primary %d IRAM offset=%d size=%d DRAM offset=%d size=%d\n",
   853			   primary_offset, iram_offset, iram_size, dram_offset, dram_size);
   854	
   855		strscpy(version, (char *)data + dram_offset + VERSION_STRING_OFFSET,
   856			VERSION_STRING_SIZE);
 > 857		if (!version) {
   858			phydev_err(phydev, "invalid version in firmware\n");
   859			return -EINVAL;
   860		}
   861		phydev_info(phydev, "loading firmware version '%s'\n", version);
   862	
   863		/* stall the microcprocessor */
   864		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
   865			      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL | VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD);
   866	
   867		phydev_dbg(phydev, "loading DRAM 0x%08x from offset=%d size=%d\n",
   868			   DRAM_BASE_ADDR, dram_offset, dram_size);
   869		ret = aquantia_load_memory(phydev, DRAM_BASE_ADDR, data + dram_offset,
   870					   dram_size);
   871		if (ret)
   872			return ret;
   873	
   874		phydev_dbg(phydev, "loading IRAM 0x%08x from offset=%d size=%d\n",
   875			   IRAM_BASE_ADDR, iram_offset, iram_size);
   876		ret = aquantia_load_memory(phydev, IRAM_BASE_ADDR, data + iram_offset,
   877					   iram_size);
   878		if (ret)
   879			return ret;
   880	
   881		/* make sure soft reset and low power mode are clear */
   882		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_SC,
   883				   VEND1_GLOBAL_SC_SOFT_RESET | VEND1_GLOBAL_SC_LOW_POWER);
   884	
   885		/* Release the microprocessor. UP_RESET must be held for 100 usec. */
   886		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
   887			      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL |
   888			      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD |
   889			      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_RST);
   890		usleep_range(UP_RESET_SLEEP, UP_RESET_SLEEP * 2);
   891	
   892		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_CONTROL2,
   893			      VEND1_GLOBAL_CONTROL2_UP_RUN_STALL_OVD);
   894	
   895		return 0;
   896	}
   897	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
