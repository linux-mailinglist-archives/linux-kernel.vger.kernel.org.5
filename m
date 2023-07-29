Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E86D76796A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235860AbjG2ASz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjG2ASx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:18:53 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F692680
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690589932; x=1722125932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=M+XjeYYdle1XjIGnmqQaD6gcRIf0x8giaqL9V6JijeY=;
  b=b6Xvo3v9Aw57Xrp5Yp1jALH2SEa7LzfCmPLsevhiHfoB0aIQUZGof19q
   ziM3HI3mJMdlY0uxkcdNzPOOwUXBuTPWBxtSaWaP56iF2hPhRojOVGC1K
   1PcR0C1oiaLsn8xuIMuMBWjsi4ZfrqDaL2jnUyuE3s/bcJ9QIRXr7DFSN
   gjjGIJHespMb9tB3XwarIzrsv5cflJFxq+Yi/msa4XgriedpBX1M2RBOO
   TbD9QkxQohutK4IjePVSUPgQQc8f37xS1J/WXf7pFTciAOl6zwFD+eMkh
   Nuh56O0SbYaSnxaa+70NG3cx939vj+/SrHG4F6lZAlFqFPh7nDZvSo8qu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358739582"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358739582"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="704756048"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="704756048"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2023 17:18:43 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPXfO-0003hc-2S;
        Sat, 29 Jul 2023 00:18:42 +0000
Date:   Sat, 29 Jul 2023 08:18:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lior Nahmanson <liorna@nvidia.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Raed Salem <raeds@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c:1183:13:
 sparse: sparse: restricted __be64 degrades to integer
Message-ID: <202307290849.M3MmKSWk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f837f0a3c94882a29e38ff211a36c1c8a0f07804
commit: 3b20949cb21bac26d50cdcc58896802a890cfe15 net/mlx5e: Add MACsec RX steering rules
date:   11 months ago
config: loongarch-randconfig-r073-20230728 (https://download.01.org/0day-ci/archive/20230729/202307290849.M3MmKSWk-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290849.M3MmKSWk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290849.M3MmKSWk-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c:1183:13: sparse: sparse: restricted __be64 degrades to integer

vim +1183 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c

  1105	
  1106	static union mlx5e_macsec_rule *
  1107	macsec_fs_rx_add_rule(struct mlx5e_macsec_fs *macsec_fs,
  1108			      const struct macsec_context *macsec_ctx,
  1109			      struct mlx5_macsec_rule_attrs *attrs,
  1110			      u32 fs_id)
  1111	{
  1112		u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
  1113		struct mlx5e_macsec_rx *rx_fs = macsec_fs->rx_fs;
  1114		struct net_device *netdev = macsec_fs->netdev;
  1115		struct mlx5_modify_hdr *modify_hdr = NULL;
  1116		struct mlx5_flow_destination dest = {};
  1117		struct mlx5e_macsec_tables *rx_tables;
  1118		union mlx5e_macsec_rule *macsec_rule;
  1119		struct mlx5e_macsec_rx_rule *rx_rule;
  1120		struct mlx5_flow_act flow_act = {};
  1121		struct mlx5e_flow_table *ft_crypto;
  1122		struct mlx5_flow_handle *rule;
  1123		struct mlx5_flow_spec *spec;
  1124		int err = 0;
  1125	
  1126		spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
  1127		if (!spec)
  1128			return NULL;
  1129	
  1130		err = macsec_fs_rx_ft_get(macsec_fs);
  1131		if (err)
  1132			goto out_spec;
  1133	
  1134		macsec_rule = kzalloc(sizeof(*macsec_rule), GFP_KERNEL);
  1135		if (!macsec_rule) {
  1136			macsec_fs_rx_ft_put(macsec_fs);
  1137			goto out_spec;
  1138		}
  1139	
  1140		rx_rule = &macsec_rule->rx_rule;
  1141		rx_tables = &rx_fs->tables;
  1142		ft_crypto = &rx_tables->ft_crypto;
  1143	
  1144		/* Set bit[31 - 30] macsec marker - 0x01 */
  1145		/* Set bit[3-0] fs id */
  1146		MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
  1147		MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
  1148		MLX5_SET(set_action_in, action, data, fs_id | BIT(30));
  1149		MLX5_SET(set_action_in, action, offset, 0);
  1150		MLX5_SET(set_action_in, action, length, 32);
  1151	
  1152		modify_hdr = mlx5_modify_header_alloc(macsec_fs->mdev, MLX5_FLOW_NAMESPACE_KERNEL_RX_MACSEC,
  1153						      1, action);
  1154		if (IS_ERR(modify_hdr)) {
  1155			err = PTR_ERR(modify_hdr);
  1156			netdev_err(netdev, "fail to alloc MACsec set modify_header_id err=%d\n", err);
  1157			modify_hdr = NULL;
  1158			goto err;
  1159		}
  1160		rx_rule->meta_modhdr = modify_hdr;
  1161	
  1162		/* Rx crypto table with SCI rule */
  1163		macsec_fs_rx_setup_fte(spec, &flow_act, attrs, true);
  1164	
  1165		flow_act.modify_hdr = modify_hdr;
  1166		flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
  1167				  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
  1168				  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
  1169	
  1170		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
  1171		dest.ft = rx_tables->ft_check;
  1172		rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
  1173		if (IS_ERR(rule)) {
  1174			err = PTR_ERR(rule);
  1175			netdev_err(netdev,
  1176				   "Failed to add SA with SCI rule to Rx crypto rule, err=%d\n",
  1177				   err);
  1178			goto err;
  1179		}
  1180		rx_rule->rule[0] = rule;
  1181	
  1182		/* Rx crypto table without SCI rule */
> 1183		if (cpu_to_be64((__force u64)attrs->sci) & ntohs(MACSEC_PORT_ES)) {
  1184			memset(spec, 0, sizeof(struct mlx5_flow_spec));
  1185			memset(&dest, 0, sizeof(struct mlx5_flow_destination));
  1186			memset(&flow_act, 0, sizeof(flow_act));
  1187	
  1188			macsec_fs_rx_setup_fte(spec, &flow_act, attrs, false);
  1189	
  1190			flow_act.modify_hdr = modify_hdr;
  1191			flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
  1192					  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
  1193					  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
  1194	
  1195			dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
  1196			dest.ft = rx_tables->ft_check;
  1197			rule = mlx5_add_flow_rules(ft_crypto->t, spec, &flow_act, &dest, 1);
  1198			if (IS_ERR(rule)) {
  1199				err = PTR_ERR(rule);
  1200				netdev_err(netdev,
  1201					   "Failed to add SA without SCI rule to Rx crypto rule, err=%d\n",
  1202					   err);
  1203				goto err;
  1204			}
  1205			rx_rule->rule[1] = rule;
  1206		}
  1207	
  1208		return macsec_rule;
  1209	
  1210	err:
  1211		macsec_fs_rx_del_rule(macsec_fs, rx_rule);
  1212		macsec_rule = NULL;
  1213	out_spec:
  1214		kvfree(spec);
  1215		return macsec_rule;
  1216	}
  1217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
