Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20CC7F6235
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345984AbjKWPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbjKWPAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:00:45 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2075.outbound.protection.outlook.com [40.107.105.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E46D44;
        Thu, 23 Nov 2023 07:00:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlZxVaWZrhiKYk6zOr2HCTbjLG4wl4J+dxzrOFkI6DPn9BxGOyP17QjxeukF2OsHFMGtsqiYdSOHRWbvs5RvX0m14CD+yAseNPi9s80G8sdB1Qv6hQQGzwKbj/u09Dqr3+Yc63rPnWEyImHkaRIQrsarFAA9nB3cLkWxuk9tPb+CBp0MkK7cUtaWEnkHZ5CuDcSblXF9cSEgBFTIZxUPK7LwqWV7dFd2n41sVAqyakGw7OFkeo4g7Jm3oN5aw1GAg2/87Jc1vlhMsPVDOh+i6bznWkscHT2JZ33l4BW8RM8HauGQUYv/IFcLqZyMcY/unNdd74hKQCwiSj33qOjztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCm3q2drwKhwlAFBL5YS4ZiycujkfAP2/lk4sC0Sq4A=;
 b=Llv+RVU2Hdq8cAIwKvrltG4MZ+RWC99Iq/UVeGYRKRJ0VzoThcjJbZSi8eCsEnBJVcnpT2e7yLfYbZ4zpvO0KjKqzlO1Tw48xWStZIuPzK5IwffRMoX+NDwDq8lseNf9beMt4M8pkKcrC5V8Z2owoKsowmjGQ3zx4TPNjmWUrlzZg8yqMwXR5uvBySD3Gl+M6FC35kmXThjpo0se35OdAj7UGp8p/ONyRhVJlyeRM87xF056xOkE5b9NdmqGyHakpuQ0LT9x4yIEtyqDA21wTAaNcD4cEZX4Nb1fue8E/5d0Wsm4icaUinWPoB5evl5atX/xJZRyKORAStIYk2Q+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCm3q2drwKhwlAFBL5YS4ZiycujkfAP2/lk4sC0Sq4A=;
 b=ZeCD2b8xX0fauMvPi9O+0jpwpS1xGdITu4RnT8pkmpNH8DCJrGVkhxP1s+NiHlCA9JZ9UNSKZfbHBB/R39rDi4Snir/3DycZJIS3PKrv9dcq3EBRMUN8Z2MMknPM1GmIhzRb831BLGYDUxS2g7TKcEPQZnCU32XXhSQ4tJ+bH5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:00:47 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 15:00:47 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, daniel.baluta@gmail.com,
        robh+dt@kernel.org, iuliana.prodan@nxp.com, shengjiu.wang@nxp.com,
        linux-imx@nxp.com
Subject: [PATCH v2 2/2] ASoC: dt-bindings: audio-graph-port: Document new DAI link flags playback-only/capture-only
Date:   Thu, 23 Nov 2023 17:00:12 +0200
Message-Id: <20231123150012.154096-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123150012.154096-1-daniel.baluta@oss.nxp.com>
References: <20231123150012.154096-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 7968fd9c-7869-4137-45b7-08dbec34f9b7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tmO90KCnK52pNy7ekDWX4WXsg2Fd+rKbTS+bGQ5W4Cgq4CzOUl1nenEyHECrojb+jIjtmhrxwKsU2h15I8cTkrQmauovNiICLOlIShgidq3x1Qskf7CiLA6X3ZsLhk/pJ98mDU5toFw+6Dz3Tp7iXyvXu+RFCh9dOMHCdHBKDTe9xHaXl70tPHp2jciiyZq+KLQOgC2005nGHukBgETqSQ8kCgWCFVwu9QE5Oeo+V7fBJFS9URA2n831yfr56bvvnx/VTwGr37Ebi71WEmjKo71Er0kKKDW7W3LFwiY6pCA7u+VHirCQinolYQgflG2GptckIfRKJEz83L+LIIGyfodhqEpj0tthPDMdG4asPxAj0OJIlSnwvPfX6AkBpyC96K51W8Qvhx/wuzAj8rJALaqiNGg71Oga+DUMA61uwsbM3iNfQ0mutf47iPNQRITO6Mq0IgA/Fhx2arlmp9P1Hum5rIpLbm5VkFCksxK3nqUykAGuVoMS9ipZTAbUJ2ahplmZMFAL7ttgWg5WQjrOGvHSuYcdxNR/wSDdVVazq2jGqYht6QDULwWk1+2J5ntiha0GG8hy5hfguPzt/Vy0gyPfogmUsozQhH2Ao0zgJtkNXseYEyaN2IT1WTVqFkYk3JhqJj+Xd3QTBSqebXJzQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(38350700005)(2013699003)(2906002)(5660300002)(86362001)(2616005)(1076003)(26005)(66946007)(316002)(66556008)(66476007)(44832011)(478600001)(52116002)(6506007)(41300700001)(6666004)(4326008)(6512007)(8676002)(8936002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mW4EUh6PU4IDGW7obQVn8GE1l4EKq6j+vt5NZH6uRiGD6R81CWn4Uo94CUID?=
 =?us-ascii?Q?TfTfjZxelYM9I1HomKfzMHgUJ7d9ONqJoW4nB1LMRZ9anbwiImZgP63PpPg9?=
 =?us-ascii?Q?hSURCXFx7i8LTcsQ6K1NXPb9OdvhGR3WjIkwo6BKT43UdC8/MBP1y3e5Vs2C?=
 =?us-ascii?Q?1YkEeQORNix5yvrkxncSGT/FLqHX1Ju+ofYi5hMX3SIK+p8PjLxwBzFe3ppJ?=
 =?us-ascii?Q?Dr3Vp3EtZ6C4aCrlZWLNm2ktO36OrSk2HqntdmHafqGp/gxLYFeRg+ymVmdz?=
 =?us-ascii?Q?y0SHBifBWNjPAQ+EFVZMYeT/puksV1mNrS02cpiv0lJyxF9K4c+Wz2+glim/?=
 =?us-ascii?Q?hBt2Ng2jbcMCvSNuApxKSoSYCg5FzCrsBvWyMxThlT4C7DtjVe065WMNhG5P?=
 =?us-ascii?Q?zsMnxnvhi0BHd1UA2rdNg5e8hs7pYQNOYscWlfipNPWd51gbQN4Cb/GnRfrP?=
 =?us-ascii?Q?fimlVmQHF0trDgHq3u9vszZolY5pfjKjBC0WR/SvFzYLa8pkxymBnJM9s8Xw?=
 =?us-ascii?Q?BVt0TWasgBh1/r5H9kW3hld+zQ6wJokjI4ylZJYufMVnsdzJpVNH4SH+A5SB?=
 =?us-ascii?Q?eFCAbX4aZzwzmAJ7E4sFM4kW7DSdTAqx+z4rd2jVtJ/4IXADWMN1VzveP3A6?=
 =?us-ascii?Q?be9GDyPHDeSuAQM6Qch3VXPjWUdc3UoTvsiIywkJchE/Ur4q2pLMpmPKJ48f?=
 =?us-ascii?Q?M89542f7fAYvVucdUl2xOKWihdPKgLsShKI/NTCa3GbjipCMZQ62b0InfN10?=
 =?us-ascii?Q?4cW0Mx+9CuSODZ1C2Z5UGmRvlIVE2nroVRL1vGg+CCeGF7xWtCyOj/JNtcCF?=
 =?us-ascii?Q?U5iuLSfsA4v0e5gqDg784o07BVFJunrUJxr7XjzG4GeQio1swEXa7EY071i/?=
 =?us-ascii?Q?NbdwSHbF4iTLqQJrO/MkbRB1icD92PsOpKM/i5hAm8RlzFJjK06WccPdoaoB?=
 =?us-ascii?Q?nweZtWOIM1LDumNyzWQFbQkioF1LG3jCol7nrtT9ysCL6sDzMVc0BNPHDSLj?=
 =?us-ascii?Q?bwV3ZnA7qvqeA2vxeSh5djCfsp5ICxr+9m6Xnu5/ROOQf8bw1JuH9buExci3?=
 =?us-ascii?Q?8JJ4VxuzBzXPhVkeGnDI8PhBJ4yAHK8YzJQdmsQnHIyGy4+gdaIGbS8UrJuj?=
 =?us-ascii?Q?IKe1RNstzuPfqjwj5ceMvq4xULYguD7ef88HRy8U5Ykr+8QjozdS1+XuIeqf?=
 =?us-ascii?Q?LbNARf8Azfi/00iaeA9nSrvrO/i9BvY5MwbrLfq4e9YWYhmRPAwPL6/dhVz6?=
 =?us-ascii?Q?53CHBY7N+mjqSm0/pzMTJChKbUALEEVQ4Sj1Zc/AEqexdNJUMl9DKskEKqbB?=
 =?us-ascii?Q?MOI8Lfx5x433Gqp3luVAX79azeKum2cFhWCtAA7gZfP2nxjE6iq1LnkorGet?=
 =?us-ascii?Q?2WAETqMJJ1InoP1BXvQ7zv8bK6+jmD5l208fMk/3TI3KDfuYOgFCf8LqYk1t?=
 =?us-ascii?Q?qf79addKi5cXmiKme939LX5IpLMD1A2z0NhdBM4KBowlahcSGZSFXp8wLOT2?=
 =?us-ascii?Q?bto00lx1icMRVjJUCK1s6kNjP6PVhK/ug6iEvoSZ48/hpSy7+EhLZ0eIEf0q?=
 =?us-ascii?Q?n37+JWoYTj0izj5pUfiqfSiuce6ZdGI6h0mtOT17?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7968fd9c-7869-4137-45b7-08dbec34f9b7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:00:47.7229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ntI2ajVCZwqI0jVU2X3cEjd3oFIEQOh+GOvN1kR47Jfu1v11YrzD/4pbfcqwuNzzN7+/Nk72F4IQeF1vzYZdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Document new playback-only and capture-only flags which can be used
when dai link can only support just one direction: playback or capture
but not both.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/sound/audio-graph-port.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 60b5e3fd1115..0aaa8a29fce2 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -19,6 +19,12 @@ definitions:
     properties:
       mclk-fs:
         $ref: simple-card.yaml#/definitions/mclk-fs
+     playback-only:
+        description: port connection used only for playback
+        $ref: /schemas/types.yaml#/definitions/flag
+     capture-only:
+        description: port connection used only for capture
+        $ref: /schemas/types.yaml#/definitions/flag
 
   endpoint-base:
     allOf:
-- 
2.25.1

