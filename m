Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD54E7FB422
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbjK1Ibw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344113AbjK1Ibp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:31:45 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C7310A;
        Tue, 28 Nov 2023 00:31:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Td/9Q4oyZiirnjMjBdyipb9QVlwtNDEN6hJQalzTlMpAlup6lHaElLbJLQ8MecfANabdik0mDCsHusj2YVK6sJBi4z1OjPBU+/d39Fmmzq+m8bNh3MERGJ0SVYGQTwFfICTiP5NsJFPl2JfnKXBSi/gzmRfbFgbXsgnwBmH7tuPnjL4lmT9OZxhfyIW/guLF2sZMadu86O9aMVcBzDvsZxn7HKfUPgjDabJhMsaTT/xi14pCjroAlUahnji6m9i0ZQ8CSg1KYr9F8rUY/XFJ8qRixKY1F2MO/FaGcBNCUHkcNVq6aoseG8Ro6utZq47ACJGrHai7k2sGyc8Wmhe43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxItSBETnnmXjEaTJwHElt0Mk07zDwQCGCjI3sW3zLs=;
 b=nzRKpu0n8uh+gXAOWwkYqVZV2kIaiHPcHR4pmUNDVoKhgF4iTNKRLQuz82sbNC1kG74eHrDAnNsa2Q3/IUL2TZIBszmUp3KW0X9/LCZVwSEHSx97rRhRks0ltu1rt0is8/DB0DFz+PwnR+cnKGsStji1X5L9KjN/jPHAGkyVBQiNz/IdTtIYS8OL1FKsr2iN+eqLY3jNcbt04Mfm76F1XUl47v63KVgGWSwDXsUi2PEPfCgp0HmTko/0FXxbvePEhRbAd4ND/PNH0A60VnUKdZBCkHR1AHnx/hqc4j4rsLrPjgJnqTlAUEZ7Pvnjl7wIBTBjffU1g64O+BdPjwu5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxItSBETnnmXjEaTJwHElt0Mk07zDwQCGCjI3sW3zLs=;
 b=EqHLnXwGd8yQGIfDMW6yek7R4rqMQcEAT7rHMFBdec5EOgMhwahKkIGMg4ZvLnh2C8SFAwPMgztKIdAr6tUEgaYmVuyjPxEbJG6Q63oNS93PXLoPFqbcmWnYqNcolWbsC8E1uSvMKq7k28x1K7wgI1gUvwm4IEJ0OGVYLf8rJDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS5PR04MB10043.eurprd04.prod.outlook.com (2603:10a6:20b:67f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.18; Tue, 28 Nov
 2023 08:31:49 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:31:49 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey issue for WPA3.
Date:   Tue, 28 Nov 2023 16:31:05 +0800
Message-Id: <20231128083115.613235-3-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128083115.613235-1-yu-hao.lin@nxp.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS5PR04MB10043:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c3d87f1-b2d4-407a-9f55-08dbefec770d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cDW1EbHZ9voPHvjUZWaGe5B5I7p0YFT8GNNxxxKIz6aPvj5oJPPyxXDCBP4wWC/1xbaCkXqMHOq9XNUDhOXlJ3G0rHBokcXRJMbL0szNY5TiNDeD/1NpmElf90umOYEDav41IhQuyXvTKwuvpLzhOa61YWz1Xc9Rl0RqSa/BcM8I/1U4gOdq5Q3qENasEpMv4YDQcpnwuiEZkteZTCrBJCIiVIviNg2vLqjGwa9UvHVGaU/NFVch+uneatU5BAES4qnv662OnQGjzkyk22Jzb2NhvHd+0AxrkH8H8oXggRUzjcZLymcEeBD+Qh3r0/dtJqG5Pq7Tp7eXs4ZHHerZmhoI9UeQZvsUoVddKZ07S9yTyEec4ydBemDtoqMDwWt4Urxq5CMuN1IemC/f+u2CzNmwznuJK6/4rh+z61l986Fz3qqKmBw9rEIPswjyIc5/qrlpP6n60IQcmbu9OZ5JniT8OB9oXGq6ln1pakUHcXqKNC/pf7VxCB4bSgLSN+WUAKCt1fZGfE+3lpR8SkO0QBsD7GMglboO1JJOD47b8FXD7XvS4L2MPTOpqafcuGi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(2906002)(5660300002)(6506007)(83380400001)(6512007)(52116002)(41300700001)(38100700002)(36756003)(6666004)(1076003)(2616005)(478600001)(66556008)(66946007)(6486002)(8936002)(6916009)(8676002)(316002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BkgnWb1fl5BZgtuuNU3KcLcIzZ+0X2Ly35a3lm961B9nq/SZ6KozAanSl8sv?=
 =?us-ascii?Q?7pjRUvDz8+6BqPlOFH1Q6O5VlLSx2Y1PEpbUUEWRtkNF5r8Ajzu9q2dzN5rE?=
 =?us-ascii?Q?s/MkkAmsZNFWQSQ3P4Z3tGRKP8DL/jyfOqFx2rSltD0rUqKtW2dRgh6bNGGR?=
 =?us-ascii?Q?hCJ8t9jDgLcec7Ks+BygkZ8lcFjL8DHwLnlkxckyg3dEzLpcxLBNEytafE6t?=
 =?us-ascii?Q?QFguSTurlN5C2sOaKfFhua3ylpW9lHA5HppHJHO00Nn1spKDZrweQkVSSwjw?=
 =?us-ascii?Q?cu5/flX07alXaJ3ab2u5oWR3+r9FrcYXLhcwJfjMWDlf6Rz2RjaSOh0cZbVY?=
 =?us-ascii?Q?2KC7feE/ee0Nkt9vYYcQSSXgaK10NgEb793v9jnDfVkavpUWbF8I3oDEQeh4?=
 =?us-ascii?Q?W36nwZBwmpkSp4uYoDsHxH51kFJmW/gDATB6mlB2lHsRN7zSvAJ2vKQdaj1B?=
 =?us-ascii?Q?tlFI9zE1Tof0n9EFRWmRoe+7M03fQUPmVnfngTlGaRJ4v6kATokAws+AXtZq?=
 =?us-ascii?Q?V0LsTfyrqbMRCXEJoWIdEKdgcJARVErRQv/dspSZ0e0aq1lKJ3AHs9mT15kV?=
 =?us-ascii?Q?BZqsesSY+GJiO3O/TJ4KIjzWzmkGyxZMbz74mUTI+za7BezMPdVnG/t5EEqd?=
 =?us-ascii?Q?AyTGNMSNgkJ+vC/ND+de0KZd7hYKp8vWXVV8PXBxyP7M8/m6HuLeBAWtqsmS?=
 =?us-ascii?Q?d8juPgliYd7lBUKZr1aD8HVE9UtZr3IWIFyRaDwd0JkFWa6IpwBlLSI9fF5i?=
 =?us-ascii?Q?IHoceWu/8ECtHh1Tz28dAzzSKOAftNK/LgEvqWdSF1OwcFnR5n2jysZC9Y94?=
 =?us-ascii?Q?uq+i2EIjPgzxZz04Oai/r0hBe+HLOCvjcn/55Rmv8C/kczZbkfb0JuPQxz+8?=
 =?us-ascii?Q?rsrOi3plEZ7l1BvDKzH5X7jJIL0F/IRcEqg6KTbYvXBrySAYTWt2DNmVYhBD?=
 =?us-ascii?Q?R+uQUYuXcOEffETKBYrSB6rPDR82fuMjSVelDX/j8dz86nPYBA8AsT69i+ql?=
 =?us-ascii?Q?iYYfV3sw43AuQmIfffPM4pDJW65/DgXrBqaVQuMIv9ciwZSdJth5nzYcIEtu?=
 =?us-ascii?Q?PR9rPsCizjsFh0ZMNBkOv3zFusp2ppND472gD4tpFxUKMl/FyB6o1aiPthh2?=
 =?us-ascii?Q?2pwRX75SI3lNDTbPCbICSK+7/qXm9mhyfgFdyP7bOZ3x61RhTiYxCSD6ytut?=
 =?us-ascii?Q?llk800gbUNNA99RcEMquprYH0Sp9IvmuIKUNFsIVM8/DKWQdzte7k1LXP1Ni?=
 =?us-ascii?Q?UE463c8XIF7pdmjoyantJ8/xbd97OkCPbxJ8SPuq/bdR4lbOpNLhOqeYfM+z?=
 =?us-ascii?Q?YbgnOJxbfRnbqslZk2HopNWvYQs4AqvAtZk3OweGapblVk1ZJLwM1OivXDJJ?=
 =?us-ascii?Q?fGTfuBO5mqcD/qJmmwlTHpPL2J3pva+oT3wu/48ufvzxDN5YhesFgH0eRQsd?=
 =?us-ascii?Q?yozKx03MtUk9xD6307aL+XSBMI1yHuw1se3nyNa7EdGsbkWHmrSxOPNeZTau?=
 =?us-ascii?Q?fxfKNTSSX2w+vojGrpruGuydft4p9FLEXNDyAs1CAETV/2Cl1EpB+U1Hau65?=
 =?us-ascii?Q?tZf6pHtiisz3yVkrxMxEGF9QdFoqpDtVlB55LIjl1X7VrPK/hMiuUPkTOaI5?=
 =?us-ascii?Q?Z6pWKcJkwuiJBm2eXpQC0sN1sN9rzekQ7QJvSJ7USE3i?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3d87f1-b2d4-407a-9f55-08dbefec770d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:31:49.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yitNFNEbo4K3yXvC20RCUHLcxa4B2vEvD14kYVMSGcutu6kg6MmsXg5XH7y75Cq77pYDT5tSRTwsBMToc+ld5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10043
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If host mlme is enabled, gropu rekey offload should be disabled.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 3 +++
 drivers/net/wireless/marvell/mwifiex/main.c     | 4 ++++
 drivers/net/wireless/marvell/mwifiex/util.c     | 7 +++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 40c39e4765f7..3d59e6a441b9 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -3657,6 +3657,9 @@ static int mwifiex_set_rekey_data(struct wiphy *wiphy, struct net_device *dev,
 	if (!ISSUPP_FIRMWARE_SUPPLICANT(priv->adapter->fw_cap_info))
 		return -EOPNOTSUPP;
 
+	if (priv->adapter->host_mlme)
+		return 0;
+
 	return mwifiex_send_cmd(priv, HostCmd_CMD_GTK_REKEY_OFFLOAD_CFG,
 				HostCmd_ACT_GEN_SET, 0, data, true);
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index d99127dc466e..3bebb6c37604 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -802,6 +802,10 @@ mwifiex_bypass_tx_queue(struct mwifiex_private *priv,
 			    "bypass txqueue; eth type %#x, mgmt %d\n",
 			     ntohs(eth_hdr->h_proto),
 			     mwifiex_is_skb_mgmt_frame(skb));
+		if (ntohs(eth_hdr->h_proto) == ETH_P_PAE)
+			mwifiex_dbg(priv->adapter, MSG,
+				    "key: send EAPOL to %pM\n",
+				    eth_hdr->h_dest);
 		return true;
 	}
 
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 23675c1cecae..ff1b2f162c30 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -482,8 +482,15 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
 				return 0;
 
 			if (ieee80211_is_deauth(ieee_hdr->frame_control)) {
+				mwifiex_dbg(priv->adapter, MSG,
+					    "auth: receive deauth from %pM\n",
+					    ieee_hdr->addr3);
 				priv->auth_flag = 0;
 				priv->auth_alg = 0xFFFF;
+			} else {
+				mwifiex_dbg(priv->adapter, MSG,
+					    "assoc: receive disasso from %pM\n",
+					    ieee_hdr->addr3);
 			}
 		}
 
-- 
2.25.1

