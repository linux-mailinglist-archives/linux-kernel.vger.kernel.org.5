Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2699B7DFC0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377435AbjKBVe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377444AbjKBVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:34:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D31B4;
        Thu,  2 Nov 2023 14:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698960888; x=1730496888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=91QX+cqj0SXsyCjCzmHMAZhyXBLZKPq8j96yDnZwMSM=;
  b=ZO9XZOh5v5JyoU2U2na22PBl8mDVt4Xr1QWjwGe6LCvSrizzjgSjvql9
   0e9i/3NviIzuOgl7ZWHDM2N1tkx1hJFZRfAE9JnNuUl8ETxNNlXl4JOSJ
   8QSbNYM0elFeld5yaOSgrZ1U1HBAyTeJJFy/uQ/ibzkOdFz7g/nNYYSi/
   rQ+BuCPtqeUJrsnXlD3kY6iUGDzUOwywX+1FABLA4laGSi6YTNlOpi4DB
   +nLuPwJAfTaQaMfR6gWrnL/D/ffobuFBWluPl5KApzKLPvOYMOXn1GP3z
   fepIeb6OBnqR7WDqyBOhCK6TLgR6JR7GKOzPFdI1EOtZED8jJMJ8NP9hV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="369031026"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="369031026"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 14:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="1092862311"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="1092862311"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Nov 2023 14:34:43 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyfKr-0001sf-0D;
        Thu, 02 Nov 2023 21:34:41 +0000
Date:   Fri, 3 Nov 2023 05:34:13 +0800
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
Message-ID: <202311030505.vv0uoWBW-lkp@intel.com>
References: <20231101123608.11157-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101123608.11157-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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
config: i386-randconfig-062-20231102 (https://download.01.org/0day-ci/archive/20231103/202311030505.vv0uoWBW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030505.vv0uoWBW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030505.vv0uoWBW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/phy/aquantia_main.c:746:14: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/net/phy/aquantia_main.c:746:14: sparse:     expected unsigned int [usertype] addr
   drivers/net/phy/aquantia_main.c:746:14: sparse:     got restricted __le32 [usertype]
>> drivers/net/phy/aquantia_main.c:776:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [addressable] [usertype] word @@     got restricted __be32 [usertype] @@
   drivers/net/phy/aquantia_main.c:776:22: sparse:     expected unsigned int [addressable] [usertype] word
   drivers/net/phy/aquantia_main.c:776:22: sparse:     got restricted __be32 [usertype]
>> drivers/net/phy/aquantia_main.c:803:20: sparse: sparse: cast to restricted __be16
>> drivers/net/phy/aquantia_main.c:817:26: sparse: sparse: cast to restricted __le32
   drivers/net/phy/aquantia_main.c:843:23: sparse: sparse: cast to restricted __le32
   drivers/net/phy/aquantia_main.c:844:21: sparse: sparse: cast to restricted __le32
   drivers/net/phy/aquantia_main.c:845:23: sparse: sparse: cast to restricted __le32
   drivers/net/phy/aquantia_main.c:846:21: sparse: sparse: cast to restricted __le32

vim +746 drivers/net/phy/aquantia_main.c

   737	
   738	/* load data into the phy's memory */
   739	static int aquantia_load_memory(struct phy_device *phydev, u32 addr,
   740					const u8 *data, size_t len)
   741	{
   742		u16 crc = 0, up_crc;
   743		size_t pos;
   744	
   745		/* PHY expect addr in LE */
 > 746		addr = cpu_to_le32(addr);
   747	
   748		phy_write_mmd(phydev, MDIO_MMD_VEND1,
   749			      VEND1_GLOBAL_MAILBOX_INTERFACE1,
   750			      VEND1_GLOBAL_MAILBOX_INTERFACE1_CRC_RESET);
   751		phy_write_mmd(phydev, MDIO_MMD_VEND1,
   752			      VEND1_GLOBAL_MAILBOX_INTERFACE3,
   753			      VEND1_GLOBAL_MAILBOX_INTERFACE3_MSW_ADDR(addr));
   754		phy_write_mmd(phydev, MDIO_MMD_VEND1,
   755			      VEND1_GLOBAL_MAILBOX_INTERFACE4,
   756			      VEND1_GLOBAL_MAILBOX_INTERFACE4_LSW_ADDR(addr));
   757	
   758		for (pos = 0; pos < len; pos += min(sizeof(u32), len - pos)) {
   759			u32 word = 0;
   760	
   761			memcpy(&word, data + pos, min(sizeof(u32), len - pos));
   762	
   763			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE5,
   764				      VEND1_GLOBAL_MAILBOX_INTERFACE5_MSW_DATA(word));
   765			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE6,
   766				      VEND1_GLOBAL_MAILBOX_INTERFACE6_LSW_DATA(word));
   767	
   768			phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE1,
   769				      VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE |
   770				      VEND1_GLOBAL_MAILBOX_INTERFACE1_WRITE);
   771	
   772			/* calculate CRC as we load data to the mailbox.
   773			 * We convert word to big-endiang as PHY is BE and mailbox will
   774			 * return a BE CRC.
   775			 */
 > 776			word = cpu_to_be32(word);
   777			crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
   778		}
   779	
   780		up_crc = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_MAILBOX_INTERFACE2);
   781		if (crc != up_crc) {
   782			phydev_err(phydev, "CRC mismatch: calculated 0x%04x PHY 0x%04x\n",
   783				   crc, up_crc);
   784			return -EINVAL;
   785		}
   786	
   787		return 0;
   788	}
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
 > 803		read_crc = be16_to_cpu(read_crc);
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
 > 817		primary_offset = PRIMARY_OFFSET(le32_to_cpu(primary_offset));
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
   857		if (!version) {
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
