Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095AE7CAD95
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjJPPd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbjJPPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:33:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2040.outbound.protection.outlook.com [40.107.104.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA5DE6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VmAUmKqK401Br0AJYvqvy2dhoSu6Jr4/dla8smGWtMbUi6brrR/zqnDLIwave4E1bgEmTNGF7/PwkzkpzznWWiK4l7Sf8NAOgc+3NBwGbq5dbwpT8Rebji7bRFVEDG1OONMXwFkripuQy8Gbi207tLUPzdat8FjwayVr97ZTQjMc1BJPiv0g8DXe+KLASzdllnozlkex6rI/wJG8bZCKGOigVXsYhqJfAwJlqHq5seNSB+G8WCu4kUkDlvvPe1c5GVTw8wMH6m9wnADGFbELLlKuT/MwX3ZNbbQLKQRp2PQBkN4Yo/q1pQn2LteMcyw7DiGAH22RxsuXts3L2vLczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jorvWz4GxmzMDIDvdhZin08SLMEa5RtSrhynf9Gb3b0=;
 b=hbBBJzrpUdsNUr3nyIYyEaS3peWMMRi8E2mi0tCB7cisHWJYO9TYeHPyxvgXzTHEAmSfDvYt+5geF4oteQcS/gtWlndfaWDAOHgmNO0bO0q2zHpUvcowHxPgstUk2tmCwtl+TxKBgaJnehyKhvP3nMW0KDYXbHHBdj5mg22E0XyNWRZMgvtYj2O4YBWeO8Wc68etqMAZgYrhvHrelVTC5rkJeDA6Z5BhGVlG6V0WvIXFpL6cqF0QJTRs190mskX4HRteCUtoscuDkqc/UqUQW83nvidP2PbQ44exixder3WwfPEhFWg7PgSOMkxi/+SPFLJnP3s0Rt7tpQGQGa4ERw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jorvWz4GxmzMDIDvdhZin08SLMEa5RtSrhynf9Gb3b0=;
 b=rXMw7J8YJAr9dIX79Jwi742ViKY2IebJHIkhjS46zoxHOWin6/j6/fvhLRKFt483vhvHs1FWn6KvOkKv3Mwzp8ro0f2szkUJknyuc73l0AEf325MNHLyMEJ5RTgTQcod1m3Hy9m2LJeAebTfHINZeBeCFu7Dcts2iHSTuEtvy5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7592.eurprd04.prod.outlook.com (2603:10a6:20b:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 15:33:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:33:00 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 6/6] i3c: master: svc: fix random hot join failure since timeout error
Date:   Mon, 16 Oct 2023 11:32:32 -0400
Message-Id: <20231016153232.2851095-7-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016153232.2851095-1-Frank.Li@nxp.com>
References: <20231016153232.2851095-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::13) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fbe925-b5c6-4cb2-63fb-08dbce5d2dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Omz6K+ukA2OsFCNQkf2lslJ4lb67m29Rgfg2LOyTuzX/C7R7xjDeKlpMGquTaz9qCcsqmhkTEZ0kM3oXw+QUxlJXqpD6YW/bSz+yKiJa0I7hf8GfSbQ/EAMD6OfZdSMUxtueeayvCg1FIFAcCPnThMEe8ORXTKrvwMuZXDDPNbiJkBOcFpMvHSYR2PJqMUbTJVsbcCgXFZXlAlVMrpSKBooWa7xIKog5KLsd2DH0lkYdpn87CIIy2/fi3MFNZxxFWKcBD0s41VvNYbAknJkgQwkbSbGVp6gepjiB87D3AZG6fhIPTwIf0AkVMsFp1p1lJWHk9vUC7KElqjPVkMFj1rSmiMGo8xse/OWuEEZnphQwoomvDbGNldr/VhKlzR66CLGKc8BetbzUEEa0vy7rvVlK/+0wtvxSTK4SaL2nnrYPLGd7M8/aHXEXd6oKaN8N1GmY8Pa6AKw3kGNXi48EJDMNtrD4VypogQyq1AkEgNcXaJfclbhMDPX7Y16MwJBUBl1EexWwW1AawmCFEdzzChJ8QeCk9Ra0xPGyuwCl+n1cTQlOo6eLUakzx3aENFWbSdRSWSifjqJmh4wRIQTyv8nPgW2HVY3FP03v39YUFu8Hd7Qlu0jVpxavlvJ5bF7+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6486002)(38350700005)(36756003)(38100700002)(83380400001)(6666004)(6512007)(26005)(6506007)(316002)(66946007)(66556008)(66476007)(478600001)(1076003)(2616005)(52116002)(2906002)(41300700001)(86362001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHpFOVBGaWZ3REJwUnpKMTVYZXprNHpBaWRkTGlySGNlWlA2QVNsTitlZ2hM?=
 =?utf-8?B?VlZXTzZJSWtSSTVqYUl0T1BKb1BWdnZDTnVoZ2tyaHVYcGVaMnR3MjBYdG83?=
 =?utf-8?B?ZkQyQWNyclZseUdaYUY4b1hnejZ6TzM4akk5M3ZJUnJ0UVF1Umc5N0phU0N5?=
 =?utf-8?B?Wkd1VXFZZXc4ZWdjVlRFZnVYZSt2WUhpWHhISHJtS21pYXF1cnlLb20xYkdX?=
 =?utf-8?B?MGhuWTFEU1VWaWkrNVI5THQ3ekNCK2ZwcGlRQ2hIVFJtWndhUU43S2xHaUx0?=
 =?utf-8?B?WklFZG5QK2hWb3ZQYTd4YUtFMkltTzhtc3hydHR2SWlVS01GNDh1bkNpbUNQ?=
 =?utf-8?B?UlhMVXpZcXMxdk1Mck9qdjJpUTlmVTB2bUJ1RE5DT3NiaVo1WVY0ZGhrU0Y2?=
 =?utf-8?B?YjJzYkhDTEJhYk9rN3d4TzJLcDArNnFEdklGR0drT2R5bzBsYjBaUlIzeVFn?=
 =?utf-8?B?UTQ3RkJROWRDV09kT0JQbXpYZlVicWlrOFlsdTNPdndGa0VBOGFYek1pTHl1?=
 =?utf-8?B?VGFCWUtqNHFkekRTSXZIYnlzK0F5OGhEdk5JSEhBVTRSMitabXFXWEFyb0tT?=
 =?utf-8?B?b3JUNGNaanVhSjhxSkoxelpLeUtsVHFmWmoydEE2dHFua0JKZ0NJeWR1RmZv?=
 =?utf-8?B?aEVraWNIMS8zMTRhZ0o0QTFGRHduSEpINDdnM1VzTzh6SUgxa3pkWWd5NVJT?=
 =?utf-8?B?NmsrdkZGZ2dnb2IzeXh5dmwrckx6ekc1YWdwVmYvNytxR29ldVM1VW55Y3pQ?=
 =?utf-8?B?TzdUdkJ4a202RXpROHZvYWpSVHFGZjhRbWJVR1h2YkJDMEcvNGVVbnJZSE5K?=
 =?utf-8?B?S3ltQ3BvRWRSZzcwYmZPb0VBWXZUK0h4VzFoU1pQd2s2MU81L0d2OTQ3cFlE?=
 =?utf-8?B?OHZ6NmVheFRYdVRDWGZXZHU2Ri9Wa1ZEd2Z5bnpRRGJzZmRZN3JPaUpPRmI0?=
 =?utf-8?B?WnkyTURMREhCK3dZam9jWnJCajJSWVpadjEyVlU4d1JZUHUxR2E1UGQ2WlZ4?=
 =?utf-8?B?YmVjZzFpY2RDcWxVVFEzcXJKbUNpaUh4Zms0TndIcThCMlNEQ3lZVzEvSUdi?=
 =?utf-8?B?Rkh2TFRwaExQU1ZVdmoyM0NFVXVGR1lMalF2VjBaVjZmWEpIOFVLY3dRTW5j?=
 =?utf-8?B?SzU4RVlGajdWbXZkRzFsblg2WHhaY1VmNmRrRGowMlZXMFRsd3RwcGJyanZK?=
 =?utf-8?B?SmtVVmdDNnVwQW9yaGlzQ1REVmF5QmNFa0orWk56a0FhVlZjNFZ0U05vWGpE?=
 =?utf-8?B?N2UvbStzRjQ0RThld0lNcFYvenBoSmpQaFByYW9jVHNnZUpoejhuSVNFaFhY?=
 =?utf-8?B?VDVUMTV1ditvN0E1TE5LVDFpTXZ6K1UvNWRtc2hoODhldXI4UlA5UHdoSVRZ?=
 =?utf-8?B?MWpKMTU0bDcrSG1qQmloOTJoTnJyL2NVTjEzZG5YOXJqZ04yVHdINFluajlp?=
 =?utf-8?B?b1V5WXJWa2lPTldZRnZSM3FUeFZvQk9Tc3VLRVY2THVFcjdhWHNyY3d6V1do?=
 =?utf-8?B?SzFUdGpEdWd2eGlxRStiT3lESXVISWQrZW1Na1FDV0Q3QTgyZW9NWlkyekhG?=
 =?utf-8?B?VDlOeVRVcXdYeGJaRUFZUXVRcStvK05EcjlSUGNNdmxRdDNRZkFFSzVEcXg2?=
 =?utf-8?B?eG1rSjgvcHB0Z3lmcXBFUlY5M3RlR1loVmUzandVeEN2SG56cEVMbmpnNENi?=
 =?utf-8?B?dzgrK1lWWjkzQmxUZ2UxVFJ1RVFHZFhMR1F2eU1UWXlYZXhEMEtBbUVpZ1NJ?=
 =?utf-8?B?VWcvV2dzaFk3SVZSSWNGWU95bFp3djRYbU1PUnBCMlZMOHFOWkxNMzZPWjBs?=
 =?utf-8?B?Q3BOb0o0NTRmei9xVU5jbXhQZFB1SWdyLzN4YnFoMlFpL01RZ0Z5MUxzOVl1?=
 =?utf-8?B?YmJFT2h2UjZrMVZmQ0NuNDNuRFkwZCtlVEJNNjVrWGhEWldQajlJQ0doLzZV?=
 =?utf-8?B?TE1zZkRNTWpBRytoTXlVaWFzUTRscURRbEczdlUxT25BcFZyUDExVnpDMlBJ?=
 =?utf-8?B?V1lIU0JRZEQ3aFZVbUtUTnlMK0M5RWR6ZnRXczRyQXBmVlNxekloN3NHdk1n?=
 =?utf-8?B?VGdJMnFHMnlPQUwwMVNZREFRRnNCbnJPTmNNaThUazVTaWZHaXUwOENVSzB0?=
 =?utf-8?Q?Hh7E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fbe925-b5c6-4cb2-63fb-08dbce5d2dca
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:33:00.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqbvfMzSso1nkE2LhfC/pJvaW4YIKna9QxITqKKFJWBikliTVEChVSNdZ1P9bHbeCTwLzvsTfflphDNHgJHNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7592
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

master side report:
  silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000

BIT 20: TIMEOUT error
  The module has stalled too long in a frame. This happens when:
  - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
middle of a message,
  - No STOP was issued and between messages,
  - IBI manual is used and no decision was made.
  The maximum stall period is 10 KHz or 100 μs.

This is a just warning. System irq thread schedule latency is possible
bigger than 100us. Just omit this waring.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5bca369d6912..18bc277edc8a 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -93,6 +93,7 @@
 #define SVC_I3C_MINTMASKED   0x098
 #define SVC_I3C_MERRWARN     0x09C
 #define   SVC_I3C_MERRWARN_NACK BIT(2)
+#define   SVC_I3C_MERRWARN_TIMEOUT BIT(20)
 #define SVC_I3C_MDMACTRL     0x0A0
 #define SVC_I3C_MDATACTRL    0x0AC
 #define   SVC_I3C_MDATACTRL_FLUSHTB BIT(0)
@@ -225,6 +226,11 @@ static bool svc_i3c_master_error(struct svc_i3c_master *master)
 	if (SVC_I3C_MSTATUS_ERRWARN(mstatus)) {
 		merrwarn = readl(master->regs + SVC_I3C_MERRWARN);
 		writel(merrwarn, master->regs + SVC_I3C_MERRWARN);
+
+		/* ignore timeout error */
+		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
+			return false;
+
 		dev_err(master->dev,
 			"Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
 			mstatus, merrwarn);
-- 
2.34.1

