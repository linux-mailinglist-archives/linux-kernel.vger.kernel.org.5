Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D5E7A2D42
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjIPCAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbjIPB7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 21:59:37 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2065.outbound.protection.outlook.com [40.107.105.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5861BF2;
        Fri, 15 Sep 2023 18:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlBh49j3/OsZcyYtoQ2Ehf9QPR+bcsRvfxzj0nl1gcNWFBlhUc8x5XbA+MGkP7TUfVXIzti4fTxSrmqNTzEsHaBBBvl3bhv2pVFroJ2UWEhjOo8+fEQJG2YzEoatanstj+5bqPStqyQDnaq2YyyOLialiqP9Sj4bp7JQsC31hR5yJK+OOXW7fiiQU68GLOAyGN1iwc1eTRZB1KXcLQqYCAXC/vjr2d7GuarWUG6JKocLjeTxNBUkMV2hAVqgRshVUkyl5hLVS9Nh+6Mb8X3tutHxlyEY/pkYdCJAR+guA7IL6zxtfJGQIdLs+gYhSoplY/XpkRpwtq7yYDdoY5pljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VDn4jOH2g5yfmqfvlcFfEWe8iuP434PkpGXzbFbO53c=;
 b=SnjzO6P/BhxJBLMgrfUuC92RPnnAHCq2Cie1mdpD2YUfP87ElEAndfAI+RmxOl5l/5FInvsFZs6qy86+LBzB/orLJI3UCuM9sPojKwDWgl41RtI/WUpbEfcc3RPTUtU05eWtbz5jUMEzi3Owybxba03ZBD0oQUV37kUqVyjLyHrp6hq3ypGWg5JKXypzVXiXyOYL/L0VuVoQ3P64qlpznS9WChhm9+L5Z7M0Dn5EdNU9A6+xbkWTQXLSpU6XAjN45CZrM0IUBLn539wYt9/+db3v4WpkygY/t8Uv2snp7GrtfSMLB3h8HHX0YFtYIn4baRV84J1yQVIx6nnV+GUQgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDn4jOH2g5yfmqfvlcFfEWe8iuP434PkpGXzbFbO53c=;
 b=Of/kzjwIkIHBImJ48KkhKLfn+pLlqb+4siVgdwwZlgjUCR0gjzIS0In/2+s05+1ToZNBb7/jD6TBTBx9EHhXnLYSO4NAtPaEDyb1fG+2LIEO1Dh6MhiG3v3cz+X2EQ/QSQRUA8Wx8XQsv3PR9EmNzDb527hR+jhlKV0ibTrN7zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9142.eurprd04.prod.outlook.com (2603:10a6:20b:449::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Sat, 16 Sep
 2023 01:59:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6792.023; Sat, 16 Sep 2023
 01:59:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH v2 0/6] gpio: update i.MX93/8ULP and support i.MX95
Date:   Sat, 16 Sep 2023 10:03:56 +0800
Message-Id: <20230916-vf610-gpio-v2-0-40823da788d7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAwNBWUC/23MQQ6CMBCF4auQWTumU7BBV97DsKjtALOwJa1pM
 IS7W1m7/F/yvg0yJ+EMt2aDxEWyxFBDnxpwsw0To/jaoJVu1ZU6LKMhhdMiETvD3jqvnxdqoR6
 WxKOsB/YYas+S3zF9DrvQb/3LFEKFLfuOeuq1NfYe1uXs4guGfd+/ZDEgYqIAAAA=
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694829858; l=1999;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=qrzfoZZ8Iyf3O65G1OyMKkFexcYDUMlv43NsC6vXnhs=;
 b=LjJAB5AoFYZ9Zdnw1uJwC+sNGFgwPZXK6WVGwwGafemwJwOMIdTPeE8tYvnOyBws9kXmHeeHN
 Bomc9QZ73HhAjS7s8CvtwlxDsOj4ep9LJjwOn+dqFl2MvzasF8jcACU
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3dae11-c14a-4a6f-5eda-08dbb6588ee0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gVeNQG7wuSPAwF/B908CnD2Qfh2SZLc6qZxNSJu8shxI+ppcr+78LB82+ebR8W5KbmgHpvt+RIGJjt3fCgUDqucqnmcAXDumJSnN3KoupTDfUcJbNbA8EoPuRn+WWsBR5ChV9+PE3GmOT2EAczI0Ra2XnMXFguOvHSil1vXwE6RekqEuZBKGcs8zxFd1qi1lAFwq12Zn78dAJw4nxgulVlFPXDlM8mn+ZDWYl4G5+IA3x34zRUmgf+u9Me1ePCi/xI8GMVCpgiIHjoX+HDDYc9wBWs2wgrF5yzyoZthZirxlnwc+lFkAEQMDOzWaU9zeX2Y0Q7aYuLpLbCHZMcObdU83UVAucNFaCIks/bBxG91ykqypuuWwIBaPIWUeP0qs68myv4Mtl1NrUn1ff6x0oso5cLFfRa879QWKSDLOVJ+HyIGzN5Tj0hv+5lRW0DsH50P+vKDTV4KJu7s+DkZz2c6kbSuhaBgQrVOHSeZ3DW8OQa9cA4RHKAb3Zhz2WBzXbNi5S282rz2ipbHKlr8T0dx+zURxc50w7lRKMfHDvBpH6TdMjxhZSNHi18NT2iL9NxyeANYPDlYB7+D7+jUcTdu4bJa5QLzmHj/3+WY0+cUxTZm/yzcupl+1ZLq+UAf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(451199024)(186009)(1800799009)(6666004)(6512007)(6506007)(6486002)(5660300002)(66476007)(66556008)(66946007)(110136005)(316002)(26005)(52116002)(9686003)(41300700001)(921005)(8936002)(8676002)(966005)(4326008)(478600001)(83380400001)(15650500001)(2906002)(86362001)(7416002)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHE0ajR5QTQxZTloOWhmMUZmbytBNGVSOWM0WTdCQzBrSEQ3T0t0dzN3eGRH?=
 =?utf-8?B?YkpUOXhSbEY3NGFIRU0waHBJQWlzYS9JUDRJckJOdDZOKzNPSFpxTk41YWRh?=
 =?utf-8?B?ZHJzY0sxQ1ZvUzgwMDQ1V21nOGd0ZE92MkZPQVAwektkMDlSR09GV3k2UjZD?=
 =?utf-8?B?VFNzYi94UHpyWCtzVmVvRThXREsyRFNIR0dSVCtkbWcrVWc0WTd0dEhVOEFv?=
 =?utf-8?B?RjkrTDNKU0REMjN3SDMzTUZHZk12bzlWSEl3blFOVmdrUVFOYkRNVndvS0pE?=
 =?utf-8?B?V0RvVmVrdFpuV3BTVytvdWpINStMV3ovRmtUaVJ4NTUvS1BjTjdUMk9pV3Nw?=
 =?utf-8?B?dnVOZ0Q3R29pckx6UzdHV1FTVUF5SytHdnJnWk1GRng3KzIveFB6QUhSeTIz?=
 =?utf-8?B?elZxaW1XTUxZSkNUU01QS3FFcHZ4T2tWeVdlc0NiUS9qejREQnpQbVJISmJz?=
 =?utf-8?B?d0lPWUdrWjZKMWNmWVJldlA1aDE3YnZORVdmVUFDaTJWOVJqZUJSZzFWMEg1?=
 =?utf-8?B?M1BOTWFLOXJlYnBxUTh5NDF3MU15WVpVWUR5MTdsejNNVXhYNEduMDEvSEZM?=
 =?utf-8?B?bnRiLy8zVzZvVDBRN1Y4MmhoRFNsM3ZJNW9pWndjUys2UlFqMDU5WkJjNHBU?=
 =?utf-8?B?cmkzczNCSEVYVkYxbThsRzFlNWkydE1BamUybXRhbVEvZE1EVTV1d1dOYjNY?=
 =?utf-8?B?cFR4bWxqMFJ0enZHQ3pZQ2ovVWkvK05NbTVKWmFQQkZTY010VTJ1eXA1VlJn?=
 =?utf-8?B?SFovdWl0Z2toek9yMzFGS29HMDFRTnh1MEZyWXVpdktOcXlrYk9NeE8rSWFJ?=
 =?utf-8?B?S29ydjhaYjdnQnhpYzZaSm95Nk1ZTStUeWtOVXpoSllaMTRvTmdQcG1iRGNX?=
 =?utf-8?B?U1dqYjV1Q2tFMnpSQ3Q4T2RpR055dWoyWjRlanBWK2RIQ2ZJN0JrY1g5UjFp?=
 =?utf-8?B?SHdYZndMUlRneXNBWTh1K3l1UUNkZ1VNY2htWmpvUnZzUUludVRha0xsMkpM?=
 =?utf-8?B?NWxLb2NFbHRGMEtoNURNd3BWczVkWWNjUVluQndRbHNsQTR6bnFhQ2Z3ZlZD?=
 =?utf-8?B?OTVsNXR1VStSZDlZZmMvK3RWNmo1UkNYRzFicWY4djBUV1ZScTNjSU43T1hj?=
 =?utf-8?B?MG9UVGNsbVYrMEJhcVdKTXVrMjNvbC9xa1hocy9BSS85MXNGeGRRVFhOL3hi?=
 =?utf-8?B?L1MrOEZPTjI1VXFQNFczQjl6MHFzVXFpME5xL1B4cDVhdUZXT0VjVXNtYXFO?=
 =?utf-8?B?MHZTYWdYQS9YTXRKZyttN1k3TU9pTlgzUHpxQmJDakxOSlcyQ2tNcDFMN0J3?=
 =?utf-8?B?eXJhU1QySW14VEk3UC9XeiswdkFSVEExS3BSMUh1cHVDY1NKVWh5Z1VVd045?=
 =?utf-8?B?V2JnRFpaNDdYZ1gxRFF2eFNvMXJIS1d2ZVU1RUgvazQ1emcxSHU4QndibjM3?=
 =?utf-8?B?UnhiSGdTUTlBNkZvRFplTkJTZ1duK0c4THhYbDNBclVMNlQ4bWF5QlZrUmJM?=
 =?utf-8?B?MnJHZUhtdVc5b1pCcklxWTJHcy9PUGw3cUZlWVltY1NEYnk2dVV5SEZZRzd4?=
 =?utf-8?B?b0MrUWJETW04aHh6T2hzK3c3QWlza3E5YlBQTVZ3ak16YmpKMi9KeWcrN1Az?=
 =?utf-8?B?cU1laUh4Yjc0MFdpb09YVDJIK2Q2dzFJRXIvcWx2b2VuZVdzQnVVR21pQ05L?=
 =?utf-8?B?eDBzUVB1UnFNRGhLNWx4U3MxUm1HMU5pOUd0YkJHMGp2aVVEc3lyZlU5S1h1?=
 =?utf-8?B?Wmphb1Z1N1E0ODcweEc5RkJIN0ZVVzFpSDJ1YmJ4bTQ0Vlp2VzlZR1VvQVRP?=
 =?utf-8?B?V1htVzdNQjhiR0tvcTFsRUdSUk1oM2YzQ1NFL0k5U1RzSlVVYmxvQ0V0TVVV?=
 =?utf-8?B?bkZEdGpnVy9sanpycGkyRStUS0VwVEI5V1lNWHRSOHl0blVNS01hTVlnbXU0?=
 =?utf-8?B?TEV0MlpJSUJmYy9NL1JjTkczWTZHM0NaaHdSOXpMVzFQNkZjWFU0TlU2d2ht?=
 =?utf-8?B?SWY3OC9kNVppYy8vMlR0NXZUMFM3c1ZuSnFrZlVlQlZEU3ZMWE8yWFVpejEx?=
 =?utf-8?B?YXJ0LzNFb2xOU0VqV3dFYnBKWXJjNmJGM3FoVVFtaUtUSEs2My9US0Z3dmQv?=
 =?utf-8?Q?ujpavLtsFqywizdUxYxWmfUs9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3dae11-c14a-4a6f-5eda-08dbb6588ee0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2023 01:59:27.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyR8yJtrmXL2c047toCw9/U/sUtRw5XkUreIZoFaoOFonEW3nq2vHHlxLoAL4iZ4xEbMGkiN4nZLqfzoFrcgsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9142
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From hardware perspective:
- i.MX8ULP/93 GPIO supports two interrupts, 1st for Trustzone non-secure irq,
  2nd for Trustzone secure irq.
- i.MX8ULP/93 only has one register base

The current linux gpio-vf610.c could work with i.MX8ULP/i.MX93, it is
because some trick did in device tree node with offset added to base:
  reg = <0x2d010080 0x1000>, <0x2d010040 0x40>;
But actually the register base should be 0x2d010000.

So i.MX8ULP/93 is not HW compatible with i.MX7ULP.

i.MX93 GPIO is directly derived from i.MX8ULP, so make i.MX93 compatible
with i.MX8ULP. i.MX95 GPIO is same as i.MX93, so also compatible with
i.MX8ULP

There maybe dtbs_check failure if only test the 1st patch. After
the patchset applied, no failure.

To make avoid break old bindings from work, update the driver
to support both old/new bindings.

---
Changes in v2:
- Update bindings with describe items, add one reg base for i.MX8ULP/93
- Update driver to support one reg base, support both new/old bindings
- Add a new patch 1 to update gpio-ranges found in dtbs_check
- Link to v1: https://lore.kernel.org/r/20230914-vf610-gpio-v1-0-3ed418182a6a@nxp.com

---
Peng Fan (6):
      dt-bindings: gpio: vf610: update gpio-ranges
      dt-bindings: gpio: vf610: correct i.MX8ULP and i.MX93
      dt-bindings: gpio: vf610: add i.MX95 compatible
      gpio: vf610: add i.MX8ULP of_device_id entry
      arm64: dts: imx8ulp: update gpio node
      arm64: dts: imx93: update gpio node

 .../devicetree/bindings/gpio/gpio-vf610.yaml       | 45 ++++++++++++++++--
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi         | 21 +++++----
 arch/arm64/boot/dts/freescale/imx93.dtsi           | 28 ++++++-----
 drivers/gpio/gpio-vf610.c                          | 55 +++++++++++++++++++---
 4 files changed, 117 insertions(+), 32 deletions(-)
---
base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
change-id: 20230914-vf610-gpio-46edacd2b513

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

