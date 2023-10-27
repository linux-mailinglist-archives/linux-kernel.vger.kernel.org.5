Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6173B7DA0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346357AbjJ0Sjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbjJ0Sji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:39:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4689712A;
        Fri, 27 Oct 2023 11:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYY7sE0sVKrf3YsPB1FPW3f9Ch1aUCpcDtA8+icdz3CYGaIq+X9xGS9PKjgBRGnXzQ49LUK1kqbsvNTzOip4IrtgeYthyzIr1SnqC9RTgd4zEcxsS1UVro6WqTlECCz6AxfBLi+xTZSk6iWT6LdNomrmvtTct7DQIwxva6M8Z1XMfKgBX/td3Wkb5lNuBYGFcdavOlqxIQH+RuyHeVlXTZNY097yhaHbOTwNMrINScPIkcH02BYlMt5N+r9QXCegCzahN7sSSlKinlI9+3KMf3I45xqaTY0WrPFZKGqt/e2Jq0bP0SZKDACfUREjctQW55PPkWhh6Pm0oVjJV3Sx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1ZQ1XvEkrhkMMzc+DSUrXBJnED9qfMmknHmI9nD9MM=;
 b=WaSQl8QAfgr86Q0TR2W+/a6s6mCtIY0hgDINT1dTMPB52s4M5vv3meQ2tvqXu4lgV1u8/+lEVxFxdx1QExA9OPneP4MgbIUIhGafCxyfRz2orZJiIGZ4vEedU7fESCT3341oEFIuuUXfQVXNJL1jhmNBJBsqITicZ8qVxULSr6C//TMVcCs3bRGY0Qy+xCSQoC2TlOjTLoxI/HyToZUUzzdJZ0TLoyqK9U4PUiBK8ELAoIofq18kEWLEgCUxrNFByFgVGbyv1j9MHnHN37yYS7Nh1GEzk+ZaTimRwHN+F74bSVOFyIDjxMuqDPbABir66lUm0q9as1kBAu9Me5NNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1ZQ1XvEkrhkMMzc+DSUrXBJnED9qfMmknHmI9nD9MM=;
 b=JW+j65J6WAR/v9MU3JVspXn+C49l7iL5YWE/NR79k3301X5HwEtwse33l5Oi3UM1oVtf8qXBR4GGzpMSroulJHzFTMyQmg87EDl54MVtpDEsBEdPQHl6JcZiWwx0XLqAQ3CR0w5pEhHUdG/VpL+LUbv6uOnkFodwqfFjjqsNJrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9196.eurprd04.prod.outlook.com (2603:10a6:10:2fb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.11; Fri, 27 Oct
 2023 18:39:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Fri, 27 Oct 2023
 18:39:31 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     imx@lists.linux.dev, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] usb: cdns3: skip set TRB_IOC when usb_request: no_interrupt is true
Date:   Fri, 27 Oct 2023 14:39:19 -0400
Message-Id: <20231027183919.664271-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 68056964-25c0-4e95-1166-08dbd71c0f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uh0fNC6eVvdI46Dc3fAwey3TsNbhduWDUtyLrdJDmzgomAoECMK0mXElI2AJU08CYOXXKIR2Wytb9iPGANLo91Mtx8Z2wpcX0wrf3PtIKwhI01XYxmuVPJEr+oxep9+rF3k/PFmBWbgyXF/cOeqUsqaEC///Bgrgulrc/pVmcA9Mv39LUwMdt8Huv5lnzPyF+AiHjsDyDCIY3Vvvw+81UQ/1CN3/h9wTTfWOgHcZZehuV/gaeuH5mv8zJf9Sc2fsVUQkUeY+Bbk+3CehnfAPC1K3Zo8T7wGT5TyUAN2utExioR9ydyDQzBH2PRDstYKMCKzkQeQdd+4CwUeED4OO+eYwmvkELxJ0FpztUXtO+yq822sLElwPPXDE0l5HBSaUtaZ3dMn/lC0heeDd0fsOz9O0jKRT13XdOy3uDfM+CpOQJOHPnAMdmLhznIkiZlVos5PJKkgOSq0TWcNPFeOH+ybtKJLfn69AWHIb3upMczFtfMUGxbrXbOS0IjvlVuvVqtLUx04OmNkHPhiVt6n+E0yrDYIb8dmgvVRrixrSO+mWiQB5IUwlg0jAsZGWLV73pDjGg6fnBJhoZyx9ga+8tjQptyhMNEzyHiM0ECgCPAOgqVc7oq/6QNkPLciJLTjUhejs1cN8geX9iDfACDKuRKmsfmbum8XuT84iAQAHZ2I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(1076003)(26005)(52116002)(2616005)(6512007)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(6506007)(478600001)(6486002)(6666004)(2906002)(8676002)(8936002)(41300700001)(316002)(110136005)(66476007)(5660300002)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TQuUYNF+QwDTojnCqVsBeZmDUrJS7t8Cx7Qbz2E3fLBf0enZWR2liSh4oJ7X?=
 =?us-ascii?Q?qptgfz00uZ2s04oKJ9mpEuSGmWBTbwvXAlsO8R9vIjxsYnHk9thxNNbB714O?=
 =?us-ascii?Q?nBD8JfWOLk8MHpOQzGP4/ErVaG/nItRdrpXTe1OM1AuQLRU2iAetsz1mR7ei?=
 =?us-ascii?Q?qAkNkoBHNDScZvtovhvOXnM6VleaACB6lF1lxhGP2kQyj+WeberiirQKQi+9?=
 =?us-ascii?Q?5Y9XLiT3kFtE8qCg+gYA7+N4aUwsjK3aQc1ZEZtMWb25ywNeqSHfk2P9ZNaK?=
 =?us-ascii?Q?09+m8hTHX//wF3WYiAFVhkuDhrX58u81bKmGhPcz3vk8lvf9ih5fqcakVFbj?=
 =?us-ascii?Q?+j9jbBFoMGMo9IQZP7BY28Q7wVC7Fja14+zX03wm94v9yMuMXADmL9+tKCTJ?=
 =?us-ascii?Q?tVzC8y2TRfYynr2DXPF2Cu7HNALywtqyP4oBRDJc1L0ptr1XEDzwHl5up9WC?=
 =?us-ascii?Q?llIFx6FUXrJCtsavXtucJE1l89sU+A6YYKI/KR2rfgLSVl4hj8nPinqC8qYn?=
 =?us-ascii?Q?Xd+afwqUOL6t6CYxzc/VztLQeaQe1TRmY2zuruq3tL5CNTG/4E2DaIPwFguH?=
 =?us-ascii?Q?AxmMI91P2RL9Le7tomxBA9KLldQg4kDfxcC014CiQxzFX4C9ZMEu4WBceFRC?=
 =?us-ascii?Q?XiM7kYC4f76lH16HAYc2v7WCvYK1XLnqBFEaRATIb2GsB8Cf1vlQrUiG+SYL?=
 =?us-ascii?Q?aSNlkwyVj0TvHHBaaRIt0oC6ikrxHgQIFzO+RAOxQlf+b4vABoM4a4PtfMD5?=
 =?us-ascii?Q?8Qjk8tEGdYpQGJbQrvka3fWcgs4gVblY3cL6PH3pKD6FKgWXfL1HL1GcoDNN?=
 =?us-ascii?Q?2w34UW5Zgvi7bgXgiZglc1BHXFriLIFLABwmxwMrfe7zxynLgjJzwPWRjPW3?=
 =?us-ascii?Q?CrSxdZ6EILiLFFRv9Rv8HnydeCF4csqkPeOBM7XwPrT5mkoTzrnXFH3WJjNC?=
 =?us-ascii?Q?vH6U1Neoo8k+zXzIJoRXigbg9vaaxf42YnahoJMIdQ+mXLEF7bsPC7mVcO5z?=
 =?us-ascii?Q?TaKLvEs1M0dqgJFNVNpR38tWsSkM61MrE4wvz1WnF+Nw+X58+anPRb0X4bPJ?=
 =?us-ascii?Q?W3i27c7pBAOmnqR9TVyrucyB7YEj+14VVEHaiD39PQ52+xMJoarg/v5NgfN/?=
 =?us-ascii?Q?4tbg11P7YMxn9XoZ4pWyd3QhKW4MiBXctHbEE5CnJhTc0j0UEn+VKb6/DdLw?=
 =?us-ascii?Q?CqkvqP07xN+GAlieU5qi2tuogC5CVQhScGCkH9b5akDh/lnebvims9C3EsLp?=
 =?us-ascii?Q?l2Jcv0wbWm/dZWFr6B+N8CZ2unP78lBsC9fRtghn2AmKBOq1562cl6gd6Ac+?=
 =?us-ascii?Q?mmi26ti+qt8ACWTJoERmCsH1Y8qW/FW9R3LPntTLKC79/EQvb0iNM13HTstN?=
 =?us-ascii?Q?X39KuMbcGVl3CgmojwdoeCOD9bHfs8ex3CUn3lKWgFPztAY46uvF4dSbT5Xt?=
 =?us-ascii?Q?SlbxG/kMT0BqIlAhDO4ZOVDdAVtJRGLHK/+qoIQSSiIJj+hwwMJkWsvC/wBe?=
 =?us-ascii?Q?dn21nVrF1G7T9N/B+17BUqd7DaVWzZTmDXpatrkykhR5DT8K7uP3cGO/zu76?=
 =?us-ascii?Q?lpGwJgQVLqz+1l7wp+nE1P4339b4yKbeBfWjtR1a?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68056964-25c0-4e95-1166-08dbd71c0f10
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 18:39:31.8586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czg2pLSrutwGmDMzA5u7SiCTWDfPwrfUwGivTUPVsdfEFVYeqSLBmppACtDJlwnL7OkIBcQ9RxSMLGmgkt1pWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No completion irq is needed if no_interrupt is true. Needn't set TRB_IOC
at this case.

Check usb_request: no_interrupt and set/skip TRB_IOC in
cdns3_ep_run_transfer().

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 69a44bd7e5d02..cd08897f8da8b 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1124,6 +1124,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	u16 total_tdl = 0;
 	struct scatterlist *s = NULL;
 	bool sg_supported = !!(request->num_mapped_sgs);
+	u32 ioc = request->no_interrupt ? 0 : TRB_IOC;
 
 	if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
 		num_trb = priv_ep->interval;
@@ -1233,11 +1234,11 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 			control |= pcs;
 
 		if (priv_ep->type == USB_ENDPOINT_XFER_ISOC  && !priv_ep->dir) {
-			control |= TRB_IOC | TRB_ISP;
+			control |= ioc | TRB_ISP;
 		} else {
 			/* for last element in TD or in SG list */
 			if (sg_iter == (num_trb - 1) && sg_iter != 0)
-				control |= pcs | TRB_IOC | TRB_ISP;
+				control |= pcs | ioc | TRB_ISP;
 		}
 
 		if (sg_iter)
@@ -1268,7 +1269,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
 	priv_req->num_of_trb = num_trb;
 
 	if (sg_iter == 1)
-		trb->control |= cpu_to_le32(TRB_IOC | TRB_ISP);
+		trb->control |= cpu_to_le32(ioc | TRB_ISP);
 
 	if (priv_dev->dev_ver < DEV_VER_V2 &&
 	    (priv_ep->flags & EP_TDLCHK_EN)) {
-- 
2.34.1

