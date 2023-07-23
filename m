Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421D275E506
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 23:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGWVhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 17:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjGWVhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:37:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49531B6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 14:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690148220; x=1721684220;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TR3uyfnF4yV2RdKk5YywHX4AP2c9HCPomrVu3zUMu40=;
  b=EQde1KtLoLrEEIVtZNebc/PnJm/v221P2X+8nc6aOnAoRlNTkMiEy8yW
   7yGpnwp71UopprPFentmUjoJkhamOHY1id+Rq2TPFSAHAbtwDTHe+ts/d
   /VkoPM5ZYzi3egY/q4b88ZKovYVqX5H70FkF39zhLcaCyy5RGBkRNj7fD
   pVDWUtOiUq3aImMKXetNiEG7l3h87a3sMK62M1rvhm4OhhBFwGJ4trJFB
   B6D+p0hCoheYfIxEXAJvZabXRoPj1wBl11W+dm1KvXEYbjTpuOAgw8hmv
   AI+fhWOdhhJl8yXcM+cyUxFtvuL6k/ciQhKxBQeqI/lRxVB+ULXYGXuUi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="369983358"
X-IronPort-AV: E=Sophos;i="6.01,227,1684825200"; 
   d="scan'208";a="369983358"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 14:37:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="1056192802"
X-IronPort-AV: E=Sophos;i="6.01,227,1684825200"; 
   d="scan'208";a="1056192802"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 23 Jul 2023 14:36:58 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNgl7-0009Hb-2o;
        Sun, 23 Jul 2023 21:36:57 +0000
Date:   Mon, 24 Jul 2023 05:36:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: net/mac80211/util.c:1029:1: warning: stack frame size (2544) exceeds
 limit (2048) in '_ieee802_11_parse_elems_full'
Message-ID: <202307240553.vW7TtnHW-lkp@intel.com>
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
head:   269f4a4b85a1b61e94bf935b30c56a938e92f585
commit: fd17bf041b40e3dac705c4313854becbe07b7557 wifi: mac80211: refactor elements parsing with parameter struct
date:   1 year ago
config: riscv-randconfig-r042-20230724 (https://download.01.org/0day-ci/archive/20230724/202307240553.vW7TtnHW-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230724/202307240553.vW7TtnHW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307240553.vW7TtnHW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/mac80211/util.c:1029:1: warning: stack frame size (2544) exceeds limit (2048) in '_ieee802_11_parse_elems_full' [-Wframe-larger-than]
    1029 | _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
         | ^
   1 warning generated.


vim +/_ieee802_11_parse_elems_full +1029 net/mac80211/util.c

  1027	
  1028	static u32
> 1029	_ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
  1030				     struct ieee802_11_elems *elems,
  1031				     const struct element *check_inherit)
  1032	{
  1033		const struct element *elem;
  1034		bool calc_crc = params->filter != 0;
  1035		DECLARE_BITMAP(seen_elems, 256);
  1036		u32 crc = params->crc;
  1037		const u8 *ie;
  1038	
  1039		bitmap_zero(seen_elems, 256);
  1040	
  1041		for_each_element(elem, params->start, params->len) {
  1042			bool elem_parse_failed;
  1043			u8 id = elem->id;
  1044			u8 elen = elem->datalen;
  1045			const u8 *pos = elem->data;
  1046	
  1047			if (check_inherit &&
  1048			    !cfg80211_is_element_inherited(elem,
  1049							   check_inherit))
  1050				continue;
  1051	
  1052			switch (id) {
  1053			case WLAN_EID_SSID:
  1054			case WLAN_EID_SUPP_RATES:
  1055			case WLAN_EID_FH_PARAMS:
  1056			case WLAN_EID_DS_PARAMS:
  1057			case WLAN_EID_CF_PARAMS:
  1058			case WLAN_EID_TIM:
  1059			case WLAN_EID_IBSS_PARAMS:
  1060			case WLAN_EID_CHALLENGE:
  1061			case WLAN_EID_RSN:
  1062			case WLAN_EID_ERP_INFO:
  1063			case WLAN_EID_EXT_SUPP_RATES:
  1064			case WLAN_EID_HT_CAPABILITY:
  1065			case WLAN_EID_HT_OPERATION:
  1066			case WLAN_EID_VHT_CAPABILITY:
  1067			case WLAN_EID_VHT_OPERATION:
  1068			case WLAN_EID_MESH_ID:
  1069			case WLAN_EID_MESH_CONFIG:
  1070			case WLAN_EID_PEER_MGMT:
  1071			case WLAN_EID_PREQ:
  1072			case WLAN_EID_PREP:
  1073			case WLAN_EID_PERR:
  1074			case WLAN_EID_RANN:
  1075			case WLAN_EID_CHANNEL_SWITCH:
  1076			case WLAN_EID_EXT_CHANSWITCH_ANN:
  1077			case WLAN_EID_COUNTRY:
  1078			case WLAN_EID_PWR_CONSTRAINT:
  1079			case WLAN_EID_TIMEOUT_INTERVAL:
  1080			case WLAN_EID_SECONDARY_CHANNEL_OFFSET:
  1081			case WLAN_EID_WIDE_BW_CHANNEL_SWITCH:
  1082			case WLAN_EID_CHAN_SWITCH_PARAM:
  1083			case WLAN_EID_EXT_CAPABILITY:
  1084			case WLAN_EID_CHAN_SWITCH_TIMING:
  1085			case WLAN_EID_LINK_ID:
  1086			case WLAN_EID_BSS_MAX_IDLE_PERIOD:
  1087			case WLAN_EID_RSNX:
  1088			case WLAN_EID_S1G_BCN_COMPAT:
  1089			case WLAN_EID_S1G_CAPABILITIES:
  1090			case WLAN_EID_S1G_OPERATION:
  1091			case WLAN_EID_AID_RESPONSE:
  1092			case WLAN_EID_S1G_SHORT_BCN_INTERVAL:
  1093			/*
  1094			 * not listing WLAN_EID_CHANNEL_SWITCH_WRAPPER -- it seems possible
  1095			 * that if the content gets bigger it might be needed more than once
  1096			 */
  1097				if (test_bit(id, seen_elems)) {
  1098					elems->parse_error = true;
  1099					continue;
  1100				}
  1101				break;
  1102			}
  1103	
  1104			if (calc_crc && id < 64 && (params->filter & (1ULL << id)))
  1105				crc = crc32_be(crc, pos - 2, elen + 2);
  1106	
  1107			elem_parse_failed = false;
  1108	
  1109			switch (id) {
  1110			case WLAN_EID_LINK_ID:
  1111				if (elen + 2 < sizeof(struct ieee80211_tdls_lnkie)) {
  1112					elem_parse_failed = true;
  1113					break;
  1114				}
  1115				elems->lnk_id = (void *)(pos - 2);
  1116				break;
  1117			case WLAN_EID_CHAN_SWITCH_TIMING:
  1118				if (elen < sizeof(struct ieee80211_ch_switch_timing)) {
  1119					elem_parse_failed = true;
  1120					break;
  1121				}
  1122				elems->ch_sw_timing = (void *)pos;
  1123				break;
  1124			case WLAN_EID_EXT_CAPABILITY:
  1125				elems->ext_capab = pos;
  1126				elems->ext_capab_len = elen;
  1127				break;
  1128			case WLAN_EID_SSID:
  1129				elems->ssid = pos;
  1130				elems->ssid_len = elen;
  1131				break;
  1132			case WLAN_EID_SUPP_RATES:
  1133				elems->supp_rates = pos;
  1134				elems->supp_rates_len = elen;
  1135				break;
  1136			case WLAN_EID_DS_PARAMS:
  1137				if (elen >= 1)
  1138					elems->ds_params = pos;
  1139				else
  1140					elem_parse_failed = true;
  1141				break;
  1142			case WLAN_EID_TIM:
  1143				if (elen >= sizeof(struct ieee80211_tim_ie)) {
  1144					elems->tim = (void *)pos;
  1145					elems->tim_len = elen;
  1146				} else
  1147					elem_parse_failed = true;
  1148				break;
  1149			case WLAN_EID_VENDOR_SPECIFIC:
  1150				if (elen >= 4 && pos[0] == 0x00 && pos[1] == 0x50 &&
  1151				    pos[2] == 0xf2) {
  1152					/* Microsoft OUI (00:50:F2) */
  1153	
  1154					if (calc_crc)
  1155						crc = crc32_be(crc, pos - 2, elen + 2);
  1156	
  1157					if (elen >= 5 && pos[3] == 2) {
  1158						/* OUI Type 2 - WMM IE */
  1159						if (pos[4] == 0) {
  1160							elems->wmm_info = pos;
  1161							elems->wmm_info_len = elen;
  1162						} else if (pos[4] == 1) {
  1163							elems->wmm_param = pos;
  1164							elems->wmm_param_len = elen;
  1165						}
  1166					}
  1167				}
  1168				break;
  1169			case WLAN_EID_RSN:
  1170				elems->rsn = pos;
  1171				elems->rsn_len = elen;
  1172				break;
  1173			case WLAN_EID_ERP_INFO:
  1174				if (elen >= 1)
  1175					elems->erp_info = pos;
  1176				else
  1177					elem_parse_failed = true;
  1178				break;
  1179			case WLAN_EID_EXT_SUPP_RATES:
  1180				elems->ext_supp_rates = pos;
  1181				elems->ext_supp_rates_len = elen;
  1182				break;
  1183			case WLAN_EID_HT_CAPABILITY:
  1184				if (elen >= sizeof(struct ieee80211_ht_cap))
  1185					elems->ht_cap_elem = (void *)pos;
  1186				else
  1187					elem_parse_failed = true;
  1188				break;
  1189			case WLAN_EID_HT_OPERATION:
  1190				if (elen >= sizeof(struct ieee80211_ht_operation))
  1191					elems->ht_operation = (void *)pos;
  1192				else
  1193					elem_parse_failed = true;
  1194				break;
  1195			case WLAN_EID_VHT_CAPABILITY:
  1196				if (elen >= sizeof(struct ieee80211_vht_cap))
  1197					elems->vht_cap_elem = (void *)pos;
  1198				else
  1199					elem_parse_failed = true;
  1200				break;
  1201			case WLAN_EID_VHT_OPERATION:
  1202				if (elen >= sizeof(struct ieee80211_vht_operation)) {
  1203					elems->vht_operation = (void *)pos;
  1204					if (calc_crc)
  1205						crc = crc32_be(crc, pos - 2, elen + 2);
  1206					break;
  1207				}
  1208				elem_parse_failed = true;
  1209				break;
  1210			case WLAN_EID_OPMODE_NOTIF:
  1211				if (elen > 0) {
  1212					elems->opmode_notif = pos;
  1213					if (calc_crc)
  1214						crc = crc32_be(crc, pos - 2, elen + 2);
  1215					break;
  1216				}
  1217				elem_parse_failed = true;
  1218				break;
  1219			case WLAN_EID_MESH_ID:
  1220				elems->mesh_id = pos;
  1221				elems->mesh_id_len = elen;
  1222				break;
  1223			case WLAN_EID_MESH_CONFIG:
  1224				if (elen >= sizeof(struct ieee80211_meshconf_ie))
  1225					elems->mesh_config = (void *)pos;
  1226				else
  1227					elem_parse_failed = true;
  1228				break;
  1229			case WLAN_EID_PEER_MGMT:
  1230				elems->peering = pos;
  1231				elems->peering_len = elen;
  1232				break;
  1233			case WLAN_EID_MESH_AWAKE_WINDOW:
  1234				if (elen >= 2)
  1235					elems->awake_window = (void *)pos;
  1236				break;
  1237			case WLAN_EID_PREQ:
  1238				elems->preq = pos;
  1239				elems->preq_len = elen;
  1240				break;
  1241			case WLAN_EID_PREP:
  1242				elems->prep = pos;
  1243				elems->prep_len = elen;
  1244				break;
  1245			case WLAN_EID_PERR:
  1246				elems->perr = pos;
  1247				elems->perr_len = elen;
  1248				break;
  1249			case WLAN_EID_RANN:
  1250				if (elen >= sizeof(struct ieee80211_rann_ie))
  1251					elems->rann = (void *)pos;
  1252				else
  1253					elem_parse_failed = true;
  1254				break;
  1255			case WLAN_EID_CHANNEL_SWITCH:
  1256				if (elen != sizeof(struct ieee80211_channel_sw_ie)) {
  1257					elem_parse_failed = true;
  1258					break;
  1259				}
  1260				elems->ch_switch_ie = (void *)pos;
  1261				break;
  1262			case WLAN_EID_EXT_CHANSWITCH_ANN:
  1263				if (elen != sizeof(struct ieee80211_ext_chansw_ie)) {
  1264					elem_parse_failed = true;
  1265					break;
  1266				}
  1267				elems->ext_chansw_ie = (void *)pos;
  1268				break;
  1269			case WLAN_EID_SECONDARY_CHANNEL_OFFSET:
  1270				if (elen != sizeof(struct ieee80211_sec_chan_offs_ie)) {
  1271					elem_parse_failed = true;
  1272					break;
  1273				}
  1274				elems->sec_chan_offs = (void *)pos;
  1275				break;
  1276			case WLAN_EID_CHAN_SWITCH_PARAM:
  1277				if (elen <
  1278				    sizeof(*elems->mesh_chansw_params_ie)) {
  1279					elem_parse_failed = true;
  1280					break;
  1281				}
  1282				elems->mesh_chansw_params_ie = (void *)pos;
  1283				break;
  1284			case WLAN_EID_WIDE_BW_CHANNEL_SWITCH:
  1285				if (!params->action ||
  1286				    elen < sizeof(*elems->wide_bw_chansw_ie)) {
  1287					elem_parse_failed = true;
  1288					break;
  1289				}
  1290				elems->wide_bw_chansw_ie = (void *)pos;
  1291				break;
  1292			case WLAN_EID_CHANNEL_SWITCH_WRAPPER:
  1293				if (params->action) {
  1294					elem_parse_failed = true;
  1295					break;
  1296				}
  1297				/*
  1298				 * This is a bit tricky, but as we only care about
  1299				 * the wide bandwidth channel switch element, so
  1300				 * just parse it out manually.
  1301				 */
  1302				ie = cfg80211_find_ie(WLAN_EID_WIDE_BW_CHANNEL_SWITCH,
  1303						      pos, elen);
  1304				if (ie) {
  1305					if (ie[1] >= sizeof(*elems->wide_bw_chansw_ie))
  1306						elems->wide_bw_chansw_ie =
  1307							(void *)(ie + 2);
  1308					else
  1309						elem_parse_failed = true;
  1310				}
  1311				break;
  1312			case WLAN_EID_COUNTRY:
  1313				elems->country_elem = pos;
  1314				elems->country_elem_len = elen;
  1315				break;
  1316			case WLAN_EID_PWR_CONSTRAINT:
  1317				if (elen != 1) {
  1318					elem_parse_failed = true;
  1319					break;
  1320				}
  1321				elems->pwr_constr_elem = pos;
  1322				break;
  1323			case WLAN_EID_CISCO_VENDOR_SPECIFIC:
  1324				/* Lots of different options exist, but we only care
  1325				 * about the Dynamic Transmit Power Control element.
  1326				 * First check for the Cisco OUI, then for the DTPC
  1327				 * tag (0x00).
  1328				 */
  1329				if (elen < 4) {
  1330					elem_parse_failed = true;
  1331					break;
  1332				}
  1333	
  1334				if (pos[0] != 0x00 || pos[1] != 0x40 ||
  1335				    pos[2] != 0x96 || pos[3] != 0x00)
  1336					break;
  1337	
  1338				if (elen != 6) {
  1339					elem_parse_failed = true;
  1340					break;
  1341				}
  1342	
  1343				if (calc_crc)
  1344					crc = crc32_be(crc, pos - 2, elen + 2);
  1345	
  1346				elems->cisco_dtpc_elem = pos;
  1347				break;
  1348			case WLAN_EID_ADDBA_EXT:
  1349				if (elen < sizeof(struct ieee80211_addba_ext_ie)) {
  1350					elem_parse_failed = true;
  1351					break;
  1352				}
  1353				elems->addba_ext_ie = (void *)pos;
  1354				break;
  1355			case WLAN_EID_TIMEOUT_INTERVAL:
  1356				if (elen >= sizeof(struct ieee80211_timeout_interval_ie))
  1357					elems->timeout_int = (void *)pos;
  1358				else
  1359					elem_parse_failed = true;
  1360				break;
  1361			case WLAN_EID_BSS_MAX_IDLE_PERIOD:
  1362				if (elen >= sizeof(*elems->max_idle_period_ie))
  1363					elems->max_idle_period_ie = (void *)pos;
  1364				break;
  1365			case WLAN_EID_RSNX:
  1366				elems->rsnx = pos;
  1367				elems->rsnx_len = elen;
  1368				break;
  1369			case WLAN_EID_TX_POWER_ENVELOPE:
  1370				if (elen < 1 ||
  1371				    elen > sizeof(struct ieee80211_tx_pwr_env))
  1372					break;
  1373	
  1374				if (elems->tx_pwr_env_num >= ARRAY_SIZE(elems->tx_pwr_env))
  1375					break;
  1376	
  1377				elems->tx_pwr_env[elems->tx_pwr_env_num] = (void *)pos;
  1378				elems->tx_pwr_env_len[elems->tx_pwr_env_num] = elen;
  1379				elems->tx_pwr_env_num++;
  1380				break;
  1381			case WLAN_EID_EXTENSION:
  1382				ieee80211_parse_extension_element(calc_crc ?
  1383									&crc : NULL,
  1384								  elem, elems);
  1385				break;
  1386			case WLAN_EID_S1G_CAPABILITIES:
  1387				if (elen >= sizeof(*elems->s1g_capab))
  1388					elems->s1g_capab = (void *)pos;
  1389				else
  1390					elem_parse_failed = true;
  1391				break;
  1392			case WLAN_EID_S1G_OPERATION:
  1393				if (elen == sizeof(*elems->s1g_oper))
  1394					elems->s1g_oper = (void *)pos;
  1395				else
  1396					elem_parse_failed = true;
  1397				break;
  1398			case WLAN_EID_S1G_BCN_COMPAT:
  1399				if (elen == sizeof(*elems->s1g_bcn_compat))
  1400					elems->s1g_bcn_compat = (void *)pos;
  1401				else
  1402					elem_parse_failed = true;
  1403				break;
  1404			case WLAN_EID_AID_RESPONSE:
  1405				if (elen == sizeof(struct ieee80211_aid_response_ie))
  1406					elems->aid_resp = (void *)pos;
  1407				else
  1408					elem_parse_failed = true;
  1409				break;
  1410			default:
  1411				break;
  1412			}
  1413	
  1414			if (elem_parse_failed)
  1415				elems->parse_error = true;
  1416			else
  1417				__set_bit(id, seen_elems);
  1418		}
  1419	
  1420		if (!for_each_element_completed(elem, params->start, params->len))
  1421			elems->parse_error = true;
  1422	
  1423		return crc;
  1424	}
  1425	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
