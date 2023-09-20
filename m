Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A577A772F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjITJXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjITJXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:07 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDB83;
        Wed, 20 Sep 2023 02:23:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSGWnzLIL4r2ebZKbLXbfN6ygnhNIAkeXP/LpIjVfFIJzibL0u/qQFs0ehIBE1wUK0XarK5WzOO6LeCLwaTt2quroIWIkFXaj1Qsltzgzs3gps0EvWsWABj0Zho7Oehy3ZghTwiHZwxO/jkq32+Tg+oIJL4RnM+fCQykfbTgamvwmH7zpiN63dR2A2lNxD2iQ/TLVVapEcxzjtny7QDdK8W4MPOXnXBXJbhIDTBxSH0AzjhL0eY3QB0kfpX27yOtAjmQrKcMiwHUNRGOEObI/Ne8qyxfCHItpRBFMM6nMj0v1DDOH3dduI9W4OULaZlCadLZu4epZ9ZZQnwOEAhFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zl8pt38Xogqp5vRRnoSMx+wK/pjlZ+pAyb3ySUDvfm4=;
 b=f7kdSURxrzNe0n3Un5ASNqvqM/IMc2Z8v19kwNQt8yP7bYooKufw9eHjK+fBgrbtzoUh2aWiHi70l2tnYeeJyJLQPBhA/dQqNT0MKK24gmrhVSdSAQ2vZjqJxhFC0/AyvAgFInA/IdNrqXbnBNB3F+f9GPRS2ifi+20HpqalnXXMHhSK3BJia+9rLzRNI/U+vVcFADE5Z0PNWmUIfmcl5O+hIlG3/XQsxgL1+L3QYlCBVymqtznJ0iuwH05FIgyuUCDgj4rTabvPMj2UmSWTxLBC9wK2wonBth4JzpWH/4x5zS5qrbVckf0sjfPjq9IDdITT5r6hvxbhKPsxVBXjcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zl8pt38Xogqp5vRRnoSMx+wK/pjlZ+pAyb3ySUDvfm4=;
 b=Y+NpIK1F2R/E0Z3mj+YSSNSTKC+BuRVnnHcMS5FuTKk9m1N3RqX9Bu4/1Ld8/u0NF+Pdh56gWFLLluXWKYpaaZjypC8du+v1+Bf4PIeRpTLIGZIqGv6IWG8GrWkP3BsP3k50n9DLVxPoBLAuMbtwKe+OZbQC34vT3y3Nsdd1PaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by VE1PR04MB7407.eurprd04.prod.outlook.com (2603:10a6:800:1ab::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 09:22:57 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 09:22:57 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@oss.nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 0/7] Add MACsec support for TJA11XX C45 PHYs
Date:   Wed, 20 Sep 2023 12:22:30 +0300
Message-Id: <20230920092237.121033-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0019.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::24) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|VE1PR04MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 18998608-b5d4-4ea1-a271-08dbb9bb2d4b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BVyMzbro7bWAqTR8Uj+sPas9xOG2a+aTMWhR7cCyEFLrB6tC0I26VhHoUTIGtX0DHoyRD4ed5PBlCmd9RmJyih+7hLptVFUmfxysqn1CYNTxuN8b2DaxsDywfIsuWqEQ4iwb1aBTYTE9w3x2Qx79vX17rL+pqyQLAZM4gcB6WkjPGeNh63wnBb38WvNlF2kdIo6QAOeRWcLG0ExqoCJIqXBC215bEc1m2tQVwVJozKLqQJe5myFOWAZYbx12q52ABEV1t3WnXNjRKl5vqUEL5GgefOwsTKKT0vduYDcLqZWZTUEy7Y5FFDcQYagCOSRcIQZi0qujmIUYqspKb3KASB9dlJbl3nAdMIElwnRSK6N6kE+u0WRjxXWkjJZ+AsAV5HujUROmL6XyUA0HsjxWous5X/w6D8igSBooVQgSBh/xFDFTDbCqBkd7cd881FeqNUYKt9jxq3H+F3xTj0vQQF3bjlf5dhCqAx+1E6i9VyhOwSz+DAZySgLKvXRoknCMdqPRzOz4Q1lIGk2BitoNQeJU6eA9WybPnHv8SQhOeqM22twMwHyvaiA57lZSrkFP+jTiPK+ZfRlWgoRofbqlwMY7+EIcCsc0hedll4T91lS7PyN+A7TRkRi+hNMkWz0yDxXzLPLMOxv+ZxxZAtqr6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(1800799009)(186009)(451199024)(6666004)(6512007)(6506007)(6486002)(52116002)(478600001)(8936002)(8676002)(83380400001)(66946007)(66556008)(66476007)(6636002)(316002)(5660300002)(2616005)(38350700002)(86362001)(38100700002)(4326008)(2906002)(7416002)(26005)(1076003)(41300700001)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5zMO4jdmcTgkFxA4/nq2A1srcPO5zhsFJPAMOZ/8lL4AN7NZ5ULqAlTTQTJ?=
 =?us-ascii?Q?1DqMZGinXXi5sir5XWOCE3M8qlKzYMvJdvNMIKvMc1Lwj0TjNRqTnbvWP728?=
 =?us-ascii?Q?aFL8D6V7UnksbQOV3x3H3H/Af8rSxgppQuuJ3D21kJ1bhvF9CUmDDyv/Uue7?=
 =?us-ascii?Q?H3EBle7PDPQMm3TaAzXM0CkYrP+7T7dLxnzSkRRhmnvY8tRXj1SB7qnDbKAg?=
 =?us-ascii?Q?2+K5lUGzLqisTZqe/jZnU0Vaf+S26QMjBxgWbME4h98yRyUuDscUomDBxJ2g?=
 =?us-ascii?Q?/4QclFetTkjdbMPpPW3tVRsbquIyVN8You/+o4/3k1wiw0VoB7CRp5FvUBlw?=
 =?us-ascii?Q?MCh/AJiQHx8rdBS1sJm/KtnhkbMbgemTzqif7+V++rGlNiO2IPbjTG1RxdWW?=
 =?us-ascii?Q?+lLf4GKKInhD7Kybl1Vmbd46YYjngKq04ZQ/gbn1iS+NCeepYTiMXuGYhIfc?=
 =?us-ascii?Q?aQRMdCz+3IUrrsnYva8bgjjtWCwWXoZjfm9vvRrSCkSAhOpHQnVzMayHANcY?=
 =?us-ascii?Q?MdMPqWDB1oa3VNIwUKcmWDvyobQbusrT3s1VP4W4j7w4YeXQF/eG7hMzgzw/?=
 =?us-ascii?Q?f7XgvLE7Vnmap9m63byih/e1+kaVzXfC2UwQfE1PhOtxBpNMIPR5FS1+Fu4v?=
 =?us-ascii?Q?Z+YVcHR/+nIPkNCR18MkYMQyNqr5KiEeAI3T+OkRPRv/g8IW/HpCMVJLmOeM?=
 =?us-ascii?Q?Lfko7Dc+5WPfsXkpBC+ndMYo8SYCzzPASDsuOuKykuvVEsE2K4MbFb/YhG4j?=
 =?us-ascii?Q?Xo/o++z7MZyrFaxfTVmIUQyNGh2FfT8z7Esa0JRTANcAuYyA0T/paMTlBDNr?=
 =?us-ascii?Q?dynNjQgyZBhnX43eZpckaU1VCOUed5rgjCU77cZrdMHEkqIYUFeCtdGIJwi5?=
 =?us-ascii?Q?u3+t9P8xozC4JnzH8Rgs4JFKS+S4xuodjwlc2rEbp8hnYRHCHqdBhGPqJMcn?=
 =?us-ascii?Q?LAcWf8J9p0pqY3+PO3iSwtnyR29W4rsl741J7FSGeYu91DwR1qA5tlpMwpmb?=
 =?us-ascii?Q?EZKlMFMhVSS74PpM9gEKbdWBaLGYpW/tkzY9ulhG371hOB7UUqgqovMZoCIT?=
 =?us-ascii?Q?tci+VjIfn+tQx5XyrTT+dwECTshvMMmpCXAQ9otSp+uHz3w6k8+GyfOrynik?=
 =?us-ascii?Q?dJSi5gWls5bFMAgowPEd6irI3VJ2WBnvFz/2imYT4U6CpkwqkvnlC2PrzjbR?=
 =?us-ascii?Q?0+DDEjd5ywEiAwrUTXDhi+H4rmvkFTHdLeVL3iJ52nzsQteKpG4LNdIWULwl?=
 =?us-ascii?Q?0g1CGUCAij7KQoyRjJ8oJsIJnJf2gLkXyoCEHuXbwMYXNjyRE6b5DlvU03y7?=
 =?us-ascii?Q?kZ/XfGtfus5i6hSymUO/RM9V1TTtPBvSO4xFVqCqKZfXnpJgw9z+abxG+Jws?=
 =?us-ascii?Q?7A0+kvIiORd7NH9N1JcLKlp+mRvikDKoWnDnYnBHsrJijzSmllnMKAw37kFt?=
 =?us-ascii?Q?VoNEV6iHCgU7MPAdQ/8v+mBBt064WNRKnUsWcHzf5IaQ2v/8UjPeUnrFkBz/?=
 =?us-ascii?Q?Ca+MtpDXDoWpQVC8W3wfLCUqk8gzH4RjmCJa4zK8KZBmGnQTTVJCyizxhCbi?=
 =?us-ascii?Q?2JhLStzw/dJ2lQr83r2yv4nD/YEqDovh4ZdUIjgDg5zIdxfGpzaEFTY4KoqR?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18998608-b5d4-4ea1-a271-08dbb9bb2d4b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 09:22:57.4342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlevI3jyyANXBqtfzHd5auRaMZvsICK6wvMsao2vxCAtQAVzG4Z6/Axx7P87oo/TyzLUCZKfb86/0rYIVrN5UF1QRkfulLvXmWE6Rk0NzYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7407
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
the ethernet frames on the fly and has no buffering. This operation will
grow the frames by 32 bytes. If the frames are sent back to back, the
MACsec block will not have enough room to insert the SecTAG and the ICV
and the frames will be dropped.

To mitigate this, the PHY can parse a specific ethertype with some
padding bytes and replace them with the SecTAG and ICV. These padding
bytes might be dummy or might contain information about TX SC that must
be used to encrypt the frame.

Radu P.

Radu Pirea (NXP OSS) (7):
  net: macsec: move sci_to_cpu to macsec header
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: indicate next pn update when offloading
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx: add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |   94 +-
 drivers/net/netdevsim/macsec.c           |    5 -
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1724 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   77 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
 include/net/macsec.h                     |   55 +
 9 files changed, 1988 insertions(+), 39 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

