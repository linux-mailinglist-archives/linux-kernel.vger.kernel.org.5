Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D757D9DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbjJ0QLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjJ0QLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:11:12 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2161AA;
        Fri, 27 Oct 2023 09:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUFbhibYywzVw5OShReH70fCvAbc/9LTf27TEq2jwD2VAhf5Q6XtrZFdnBCOlPzRn2IvChqyWbppipA7Am9ZZ3GNX00PKgKkKsgVDAaMj+FOy0E7+yNC8isdiUhUxc8bIhJ427FC+A3irA0T+jgyOcMtEHUbJA3n7W5rOwBRzUIEQIqAM5FmmRS83cmGJnd9lmo82zjaVMVrQvHyr+b8ij+waLyFGQ8X2XX2gcB90xmA7HULf/5pABKvpARJevtoPashHXhmsdcZHmug+Tk7v4/ZW8Jaq+ozopnzL3Ut5nrxmrCLsj5qyFJDVuEvsUVAKttiaSxhIXmRxONShHVkmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWXw4SvB6tHPZ7CSptVCnZLmNA8+hdDH/Z2BcGnqMPA=;
 b=f4Xwddu13Ykdr6j91Lfc8HDCl39a2Dc/xkIZLfSKbMldY1GFSaS2lJw9K0dawUmstFB4EbcoWAtU8jGcLbbPkKaTCuc6aaUq769S5wLwMd1fStqEnsZBE/X44l348VjV4ebTg37oO4fMvN6QYFbhCQC4Hbu7mEXDop+98cXoF2uWl/A9VxDHTeOcl6FnFkIilU5PasEFwXOiu8h2PKaVHWImoijBf8TRjQEpJpUz9+ID8K3hB7ayoEryFrnV9/diTGKiOOZGQLU89sE1Apgl/kvBzsYH6FrvENK7uMNumfHi7fEFksqGtwLjmAEezQduvF/m+ISjzYV73hW6yHHiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWXw4SvB6tHPZ7CSptVCnZLmNA8+hdDH/Z2BcGnqMPA=;
 b=QoSukLAO20qgb/7HzM6gziY8mVbaOh9vuarX+oAvmimVzYjwHRaXc0trTup+aBGfHBu6CJ4arZeyPxOUER+JEKaSCgRhvPusbTHWKOhW40R6oKJrFQ9g33z41iTDAqloDv30yQkmwkEV+0XGO6d0k03PRTj80CiGAP4A+belxmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 27 Oct
 2023 16:11:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Fri, 27 Oct 2023
 16:11:06 +0000
Date:   Fri, 27 Oct 2023 12:10:58 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     pawell@cadence.com, peter.chen@kernel.org, rogerq@kernel.org,
        a-govindraju@ti.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        imx@lists.linux.dev
Subject: cdns3 uvc first ISO parkage lost problem
Message-ID: <ZTvhEl+JcnhJXcrl@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 327b96b6-5762-4c6d-f11c-08dbd70752f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v7bi1/dy50Eif5feuoD3wDVaPJb5QEqG53PtyTRXIY9O34dy80odt6noe8gZbTBkdmA7hmnNShkQCkZHErZ+nARvyhsK1gK6gRccSxNKNo4/fXkCSJSDfI5fw+4Ou5FXnOltzI3Y9sXeCTMIWKDVy/0vSxudmyMuojuFSGmEdTE9m3cmuRZFNa+FnWhz5vVn6I7BUnxLnVOl3V69HSIowG0WmKtzShmYJ2Y88r3bzF4w+5oPvUGdopbARQmj5bMad8zRi1sGFVi/hucpj/yjWcCoZRTrLv+UcMEOLgKPbp82p2AW02IsAqEOmSky2dOt3qvKyxnycagHVd+yBMzYWAWc1RddYga+6rj/qz0v2xFPmpdK/JXCtqxmw9W3xtQb5qe6pPFmUm1YSBCkK2NJoFxWsNZxXF6JESchg8UtQqDbJvjrqaY3kD5uFjwAoW9oSJTuR00fH3ukitrQ6QBheDTZTkPcBpi/E6X1LNfkNUpFDk4f7h/HcNhYgR7fSu63u4sxBeljqKQFpnmFfOR8AiSYqvKBrpyXvUqov0xovVIZHaQfiMoYnI83nUInbIhzrfceP3U2xLvKFXAtSolSkqt29corzSdWVBh8nJLukjYBA8R3u2adVUG9xhhwsnNW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(316002)(66946007)(2906002)(966005)(52116002)(6666004)(8676002)(86362001)(6512007)(8936002)(41300700001)(38350700005)(66556008)(26005)(66476007)(33716001)(6486002)(9686003)(6506007)(478600001)(5660300002)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LQTK+xcWpO2yNiQC/FiYXXcTH0epYtWazlNaT5mesuYoWtv4FjfN39B+KZmm?=
 =?us-ascii?Q?pj7/9IA3wmO2h/u7DEhPTxLU8nTW4CWOeHArc2umStc11/nJCd2+8Q/zmkCI?=
 =?us-ascii?Q?nv5wqj7RfMWDfC2mV4b0vCheOWXu3Wu4TKKl2VoRKIjkKzQJxbNZ9cq3G2ym?=
 =?us-ascii?Q?kBVHPiZOmxOFOOJyfW4VTrsGNqtOVw/bw4rF29Ba0Wk9gq01HOhfWeuKXJ0F?=
 =?us-ascii?Q?2GB1yKf4/yiD/dBachiA2nQg3A7bfKXL01Vjy8oDIho0Nv6WnGGNu64JogY3?=
 =?us-ascii?Q?pYN6pWgH646JTHWRVowbjZRNWSWFWYy6wWKQsoyJEHxmTXEfOqWka8Dk8ATg?=
 =?us-ascii?Q?QYP9AEHV5a1kLb9rfnuiEugTl/d/tjzIlcoK4ikZENNLeAhPS8lUopvjl0+k?=
 =?us-ascii?Q?Cm79TZlS6jyayzpZfZH9l4f0elizxU7vsJdRjKfqW+Q6rPb8+7wsRrMcHmIf?=
 =?us-ascii?Q?pwpCLVIq69WhfvdTGLK9jSvjc/2l5W65YdETHupbiVs6LSdlLNrm2pPa/w3T?=
 =?us-ascii?Q?oC1UDx4VSatQzkzCWVEjw1B6hdcZ4rlX54gyM7b72ky1BmV41svlwNUIW2jz?=
 =?us-ascii?Q?Pxn0jUQJefs0FnF1K8aQdhABdHCbcZ+o864pDQpp27nOIDM3lGxZzNIIU46H?=
 =?us-ascii?Q?dqbeh9hkJh9Lkh0CVYDg6Gsxc4NezaRZQEqQDnh6e0hT8xOe9zd01/LpAu9Q?=
 =?us-ascii?Q?9Tz8+RWm8nNycWAa9L3+jjFZjQMQY0fJM5urYxxLgOosgRaMJGAnxg5t8ARE?=
 =?us-ascii?Q?G/taatE6jE/+jvZ+qy95rqh3S4+qxEo1JBPzaGK4p3U9uX6cMziD2uYXgUh5?=
 =?us-ascii?Q?C15UkQO2BFeyBi73blaALoA/Jjn9JS52se1ZHw889TcPiQimmHNFth7qGH+H?=
 =?us-ascii?Q?8mnhgZ9sQx+ybi75dow7A0Y5QTJBdE0Z7kuR6eh+mm+gLEaSn8vvnSLrgCTv?=
 =?us-ascii?Q?NLCd3sJ+zTa1DVN7tzZ3j8Em6w3nT2SVPYwyJz6rPdt5eRDaTrHP2wu8GUZ6?=
 =?us-ascii?Q?m8l927Ug0q/4FIEJusP1sen9xxe5tbQw4KZGK8+kNNXfrZ+QjO9NFqrTSOTj?=
 =?us-ascii?Q?ZVF8FUK9AQcaTll6/EYCuKUXkCX85xsp+aXRFH6CQU5e3WDroBft6eQ7ML0W?=
 =?us-ascii?Q?CwsBpmGJJ1B+SWWvLgNQ1lFqkEKnx1RzJ1Sq5yQ+K0pU3yLwp7xINVX6qW9F?=
 =?us-ascii?Q?yhOrHjkDGFt27rJMLvTAGl3lFfqwsiVhMdLWs5FuI6ZCMRaU/PjRk8oZRbb/?=
 =?us-ascii?Q?E4OIF91dLVRIhzeeOMUsVypLGwR8WOwG9pDW8jYxWp/BI0U95xayQ7tg9CDr?=
 =?us-ascii?Q?nrNjKYl9bLmtrGAAoT/zPafIQIY+9Trjj/JemmaBh8tebc1G1qFXFXgLxQcK?=
 =?us-ascii?Q?qUEeaszeqry0B+o/OOTSyESButN76smRSuPhRa3oNm0LV2k+90tSzdwQVFkV?=
 =?us-ascii?Q?5I2IsbRctMbTE5wDMqUu4XKvkni8tH5HlSnpX6xVVMeV5ljHDFM0weLTopaZ?=
 =?us-ascii?Q?SbPvcDfZwnZrDKpKti+vAo2eqNuL1OOzHWXgM+X1pISjwv9LH2bGJCvU1tZs?=
 =?us-ascii?Q?TQWv4UGki68upM6akMvWXgy+E7RAVVWkSyl0Yw6O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327b96b6-5762-4c6d-f11c-08dbd70752f8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:11:06.2862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCqrDArIzRXd2AA3RTNfWwTp6Bpr7LHsYLH+3xDQzUnErpk0fPA72ClWtA5+tb8wT6nik2XWczQMZhMh/2xCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Pawel Laszczak

Recently, I met the problem when use uvc. UVC report jpg header error.

Basic reproduce steps.
Gadget side:
1 - 
	https://gist.github.com/kbingham/c39c4cc7c20882a104c08df5206e2f9f?permalink_comment_id=3270713
	uvc-gadget.sh start
2 -
	https://git.ideasonboard.org/uvc-gadget.git
	uvc-gadget -i test.jpg


Host side:
	https://github.com/thekvs/uvccapture2
	uvccapture2 --device /dev/video0  --resolution 640x360 --count 1 --result 8qxp.jpeg

	It will report jpeg header error.


After debugs, I found two problem. 

Problem 1, sg is enabled. so uvc driver will use sg. each package include
two trb,  trb0 is 8bytes header, trb1 is 1016bytes. total 1024.

num_trb here is wrong.
it should be 
	num_trb = priv_ep->interval * request->num_mapped_sgs.

because priv_ep->interval is 1, I just simple set to request->num_mapped_sg
as below patch. USB analyer show one whole 1024 ISO package sent out as
expectation although document said only support one TD when use ISO (Maybe
my doc is too old).

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 69a44bd7e5d02..8cc99a885883f 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -1125,10 +1125,7 @@ static int cdns3_ep_run_transfer(struct cdns3_endpoint *priv_ep,
        struct scatterlist *s = NULL;
        bool sg_supported = !!(request->num_mapped_sgs);
 
-       if (priv_ep->type == USB_ENDPOINT_XFER_ISOC)
-               num_trb = priv_ep->interval;
-       else
-               num_trb = sg_supported ? request->num_mapped_sgs : 1;
+       num_trb = sg_supported ? request->num_mapped_sgs : 1;
 
        if (num_trb > priv_ep->free_trbs) {
                priv_ep->flags |= EP_RING_FULL;


*** Problem 2 ***

According to doc and my observation, looks like hardware fetch data into
FIFO when get SOF, then transfer data when get IN token. Each SOF will
increase TRB regardless it is ready or not.

When gadget complete equeue ISO data, so SOF will increase TRB regardless
if there are IN token. 

   SOF       SOF       SOF     SOF  IN    SOF ....
      TRB0      TRB1      TRB2      TRB3  ...


Host may start get data at some time after gadget queue data.

So TRB0..2 data will be lost.

If it is audio data, it should be okay. But for uvc, it is jpeg header, so
host side report error.

I checked dwc gadget driver, which start equeue ISO data only get NYET.

I check cdns spec, there are ISOERR. But it is never happen. According to
document, ISOERR should issue when IN token and FIFO no data. 

I tried below method
	1.  Delay queue TRB, but no ISOERR.
	2.  queue a lenght 0 TRB,but no ISOERR 

My question is how to delay queue TRB to ISO IN token really happen to
avoid lost JPEG header.

Frank



 


