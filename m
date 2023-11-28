Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AE7FB41F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbjK1Ibn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjK1Ibk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:31:40 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2084.outbound.protection.outlook.com [40.107.241.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B610A;
        Tue, 28 Nov 2023 00:31:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=equ9d4BNCfQSockbNRwyYWFAu1oigbAz0xquQxyFEWMk22GZHboTa0FG3gyUGhyOGH/r0f7CqK6NE6evZk6ghwkbjb94HDA3GceSLnQetcO1Arzdibcl57LOI6yP/Db+DFaRUmgm5NhZaCWDzUQihyYjjI5RBKwAHgzYGYtmSA3+vbOnIXcguz4jO7CleXavdPwFSO6X8WUJDFuB/paaM0VMvXMpXj0TQ9f1AMtXsrBWsl/0Zac9wlZ4w0pRSp+vvoFNdAIaJ6wdOt+PZxlUsVJbC0ii1I5L8XKMQAGs5y4Nq9mIh/g6BD7pfuty3EFVRjRzTOiVd+4pisnwkPqVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbIJ9yUDbBehYS94wXgA88Qam2O8rt9xNUsNEp1N5bk=;
 b=G/3fVlKkgXtVVH0ocAL6oxn7D+sR8mbUoPoWWjDM/3iNQi99tsiMATEJuwttqiPE7zqYEqFyT0/SVpBhlTdhATCK4NIaducYG0Llk7Ue70R7Pk8nNEgCgWEj5T6zCH7vjeK5qkwIdg36La4jDJ7aSWRmWVkEOGNHeSo7Jc4CFv83xDkyQ+x3axJi8nFSZuTbLuhkZd5IfGeQ5BO/MzP6J51QhxImrA2ZRXet5FZosIlPp4ConTQBtiCxW4MOl65sPhk6xiixA4uXSRZ5jso3JpMWvLHzdjxiT66FTeCrQm4RKI6TSH5Fs8OvrR8bl5Y8+m6xa7pqNHb5E+cgKLE+kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbIJ9yUDbBehYS94wXgA88Qam2O8rt9xNUsNEp1N5bk=;
 b=dk36nVVvD08Lcijp44YB8RuaZcCzFagSo7hCZFBgDYO58gclHaIvU4W/IeiKmK5aa9kX7DlmYb4InbzTaTUaLvTgTiKtCdtjMlNoJtQtkwZT6fNlWqnovJr8nqx+nY+7fZuR3sXKVfJ63Oy+KaUwh/rLC/oNdrg+DVlVM7LGhJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AS5PR04MB10043.eurprd04.prod.outlook.com (2603:10a6:20b:67f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.18; Tue, 28 Nov
 2023 08:31:43 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:31:43 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     linux-wireless@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, briannorris@chromium.org,
        kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com,
        David Lin <yu-hao.lin@nxp.com>
Subject: [PATCH v7 00/12] wifi: mwifiex: added code to support host mlme.
Date:   Tue, 28 Nov 2023 16:31:03 +0800
Message-Id: <20231128083115.613235-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AS5PR04MB10043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e6a48c5-d639-4b31-580e-08dbefec7386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MYG70GLHIuzOcTZtg4Zf9CE73eqWa1y9GWJgd0i/wFUYEewrXGR1nIaRjGUxWeZUgdWk7AUhr/GOxlh/LwS6RNWy6cInsJrfg3Fr9rfb0BPfD3XfyOzfsIBHqwXux4ijQunhvKj1aYFiLQUqkYgAVATn0AeCg+aXVUqrVBlO4CgPDZfZFKCzh1kXfF8krr3z1FEkw/LvBEVWwP/p21CF0CmavNSuftOT2B70eiVnZP5JKmsLj6KzHaM9QwhctzyzjTL8pkauHved4wW9CiTvF5YU7foOIZPgOupHwn5mnroK9qgunbRX3mk8wbqSTk6fqqfFwx54ycfLJImP0XXoJVUPDtn+YSkOb06jyNC/F1qH81KWOngxRMKHDKNPHhjlmWws/NXiggNXdJFbg6QJcI2jTq/h/zbNYgk40CuEttMXPS+MdDJv0q1iK0dDAVEKkH1GNO4wI01zOA0CPo298VemJ3PGoKTnBTLnorNf7ZPbgStt8KH9OtLMYv8lItbiqO4UIXNKCEvbNwxae2ptNT8uOOuCkDB7dppmi9IKuFEHuxXQuUI1XJtx6Ju8l6N+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(2906002)(5660300002)(6506007)(83380400001)(6512007)(52116002)(41300700001)(38100700002)(36756003)(6666004)(1076003)(2616005)(478600001)(66556008)(66946007)(6486002)(8936002)(6916009)(8676002)(316002)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hG1Unkeb/FJrZblMeoAsL/e4lsrPrOzAeeNqxcCAmblb5QtnU6QZGJux4MVx?=
 =?us-ascii?Q?muawnZfPvpdb3gXSB88C4WxMfL9WfBXMUIPLp+LCAT16vF2Cb3GUkeEOhGWk?=
 =?us-ascii?Q?wCjmh4lHKyXBkYmTomZJ+yyV+UVRnfB6Qq+mBshVvHyJMBqY75LJQrzB2yzx?=
 =?us-ascii?Q?UFTx7BWdu101vSahqfGk74Zy/UCMgzd4uPIVsB3ONVUDxh9t9Vlh1Fbz8zj1?=
 =?us-ascii?Q?obGIoFGppIK2Iwq1CPImuX7y4YxN9qKsk+pxxkjA1YEAfi585PMnoxBfUjY+?=
 =?us-ascii?Q?2OaxhF8SburT9FS73gjGy9v2r4tlK+VY3VIx4PZ+Rc901CT5tpsGv6NlaJMs?=
 =?us-ascii?Q?atIQi2ee84S7Z8k9S6jGghvNFY8nIkYo7AO7bJ1qPZBJqMF9bkMG9fObTe9c?=
 =?us-ascii?Q?A802qYoNGtpdN6KykyHChmsvUYjqhgPySRaPkkxSLusSw6hb4E0ZpxDkc9XG?=
 =?us-ascii?Q?0jvMRHD/J8mqee3ql6Q+YTnf5T+UGjJqJYCdjGRyvoFyIYx+3HkqpD+VoRfa?=
 =?us-ascii?Q?ps81SSvgtkzFQUF9YyVEk7pL2V7Ir74hwacyjQ8NU7+gXCzg5tgmiYI6IPnO?=
 =?us-ascii?Q?LVSZJ7jELGeRO0VgdDM9qGy0y53lS3MnJYqaEIpvM/fx22cNHGEvezDvjP3x?=
 =?us-ascii?Q?KJORVQBzZwCx7AwTNbzCHwHvKcksMsSDoW9VRtHTebCrav5ifSDyc9VXGTjU?=
 =?us-ascii?Q?WT25q1INly+Rmk+0iXWeroLJUKO+fH3emeQ+gtEOVo2dRlKOKnDWMcdnQuhU?=
 =?us-ascii?Q?mkdmlle3bQtnku9JkXcCrx8WhKk9+L4Ze+Jr/wTnv99LSxKATg2n6oZK6G0t?=
 =?us-ascii?Q?fu9EF7sclp7gM+KmlXkorWrfZUantloBk568Ju6uJIktVaGPSzyEKyHZ/4oV?=
 =?us-ascii?Q?cRfpNafbhfKaJSB85pZ+m0YVABsnzVrrwRLWnI0ODdgXQhVHmtf1VppPPEQj?=
 =?us-ascii?Q?ylThSVPzpfzocCRBN0Yt/7QXLTJRycT89sdLuybLyaM2yAuRdCcQkFKNwMvZ?=
 =?us-ascii?Q?Bdq7/ujsdXejBzmu1H+LCkkODxkhXjaLl3G3pMr4BFvSgc0dtFmw+W5rD6xf?=
 =?us-ascii?Q?vv7WySRR3PRe5aDpZbrGPLDg7bpRv7Zq/TEAK6z5pvXqu8mWzooW8n5WiEY9?=
 =?us-ascii?Q?CAhqv1hIPlSGx0OtcOz0OT1pwT0SF6Y3rn6D0k1GrnLkQh0C3bom24NKcnUc?=
 =?us-ascii?Q?iIvxl2dROJTtjZRP+TQhRdthJg349eHAVXuoVwbs9nguvDJUghIGf/LAp3KQ?=
 =?us-ascii?Q?+tlWLMJ7UlVGMxtKZ/Bi0zmQ2CvVKBhfjvWutvo5l9ZCFpru/Vundkg7eAPL?=
 =?us-ascii?Q?mzRjEBjKYPEm4xVwgYuUo+5rEHRdDH3ehfMU1me4ChVYGLik8z6cg0xvsnit?=
 =?us-ascii?Q?+B51Km5no/kJ8Yxg2/0ObdW2cwyA/LEa8YZHne6sHbSgGE+QmGkXUkouLLkx?=
 =?us-ascii?Q?OCRm4hU1D0nleYJXfc7O5q9mxC9vVoISFVqnmGyFO8dJdTQ4lGfoUpbFaoby?=
 =?us-ascii?Q?amHsq1ilI//SAnhB/REFs86Y4xafTx97exZ3t23zxFFMszLxqzkPAeR6cnkN?=
 =?us-ascii?Q?Mq2xibOo1H92Z8i7jObmZxlZDsDuMcNhbxSQEorOWV501aI9EsOcWVo/QwuI?=
 =?us-ascii?Q?SmSLxBhgv8q2e2qjlPhiH663aQ+h1Lp7QHH+1uNKc3KH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6a48c5-d639-4b31-580e-08dbefec7386
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:31:43.4091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpGlmObXmf1tbhFcAQjxcvUoazxf1Ur8sCIcXDn1siT+upiizNBdGK1GRjBpb2o3Tp4la9Zczldkyxtxmi55Kg==
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

Patch v7:

Changelogs since Patch v6:

1. Fix regression: Downlink throughput degraded by 70% in AP mode. 
2. Fix issue: On STAUT, kernel Oops occurs when there is no association
   response from AP. 
3. Fix issue: On STAUT, if AP leaves abruptly and deauth is missing,
   STA can't connect to AP anymore.
4. Fix regression: STA can't connect to AP when host_mlme is disabled
   (impact all chips). 
5. Address reviewer comments.

Patch v6:

Correct mailing sequence.

Patch v5:

1. Add host base MLME support to enable WPA3 functionalities for both STA
   and AP mode. 
2. This feature (WPA3) required a firmware with corresponding Key API V2
   support. 
3. QA validation and regression have been covered for IW416.
4. This feature (WPA3) is currently enabled and verified only for IW416.
5. Changelogs since patch V4:
	a. Add WPA3 support for AP mode.
	b. Bug fix: In WPA3 STA mode, deice gets disconnected from AP
           when group rekey occurs. 
	c. Bug fix: STAUT doesn't send WMM IE in association request when
           associate to a WMM-AP.


Patch v4:

1. Refine code segment per review comment. 
2. Add API to check firmware encryption key command version when host_mlme
   is enabled. 

Patch v3:

Cleanup commit message.

Patch v2:

1. Fix checkpatch error (pwe[1] -> pwe[0]).
2. Move module parameter 'host_mlme' to mwifiex_sdio_device structure.
   Default only enable for IW416.
3. Disable advertising NL80211_FEATURE_SAE if host_mlme is not enabled.

David Lin (12):
  wifi: mwifiex: added code to support host mlme.
  wifi: mwifiex: fixed group rekey issue for WPA3.
  wifi: mwifiex: fixed reassocation issue for WPA3.
  wifi: mwifiex: fixed missing WMM IE for assoc req.
  wifi: mwifiex: supported host mlme for AP mode.
  wifi: mwifiex: added mac address for AP config.
  wifi: mwifiex: fixed TLV error for station add cmd.
  wifi: mwifiex: fixed the way to handle assoc timeout.
  wifi: mwifiex: fixed the way to handle link lost.
  wifi: mwifiex: fixed AP issue without host mlme.
  wifi: mwifiex: misc modifications for review comments.
  wifi: mwifiex: fixed compile and coding errors.

 .../net/wireless/marvell/mwifiex/cfg80211.c   | 397 +++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c |  35 +-
 drivers/net/wireless/marvell/mwifiex/decl.h   |  25 +-
 drivers/net/wireless/marvell/mwifiex/fw.h     |  61 +++
 drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/ioctl.h  |   6 +
 drivers/net/wireless/marvell/mwifiex/join.c   |  67 ++-
 drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
 drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
 drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
 drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
 drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
 .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
 .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
 .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
 drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
 .../net/wireless/marvell/mwifiex/uap_cmd.c    | 180 ++++++++
 drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
 18 files changed, 1003 insertions(+), 20 deletions(-)


base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
-- 
2.25.1

