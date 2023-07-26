Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA52763539
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjGZLjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjGZLis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:48 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7F52698;
        Wed, 26 Jul 2023 04:38:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iaGMFiKD81G4dUHVALxda9JhjRmX/GBk57vEExK5xtwEdXyKval2w7/w6YZqVJV3aQptuIkrRYYHVqVw6yzYvDMkLx9+3FzL0fhCAQt7OslVG1q8Bt9PWUS2ERfl/Hbb8IUMt3vLCJl9IXWNgyP8C3TRGMe8Ky3u7TDyqth2o1yssTBrrgBxOMKwI6oIlg5faquLYAdLh8n7X6cxqTeOt+fvRBjz/I3B6OK1nUJkUo6tPy1tAKQrzAJLAwKJLyW0AWsQxnPDhaqiGXWSNZ7NXpf4dxktlfATBDjUhV6DNs3uGwmOtl/qrtaYURI8bn/BzbiIMoqeHJ7MMwQYF7V+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWGbg+68sOkomjajgVLEDktAz8LH+dcpflNDWU93c2Y=;
 b=i4PEKrODqrBwhUi1D8SSl0M2RvglGEzfhSioxTd2DYj99sS3sfa4Ngz69d6A/a13AafQtWoeNNFX8zbPbjxfc9BEcHzqerVQVNdEYaxiVJA0QPfCymLOJATUbEaoH7FrW9xn+drvioHD1RDGHoMk1Ax8eSwzSl7lyQWHdFMjs/omK/QDyJ86xv1+0NeIyVMzlrhnlj1cEpi9lsW2fmvG9UC1bJjMXQJI/Q7ojQSKGziioCqdSc7eUIkE4/FJyEuWe2jSOMIm6GKHIqBoEsVnELi6i3Yu5rjBFt0AZDIaj0hUpmO5m22spc2rqCyThDJGW424Q/JdUYcLMl9l793IEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWGbg+68sOkomjajgVLEDktAz8LH+dcpflNDWU93c2Y=;
 b=fH5TEtWsHEFa2KD6nkM9M7VkMoPFRZINupmhJAvmPL5jNjTCAUCIoarB0957Pui8O3RB5XFsWB8jGDhu+xWN6W4AVv2g7LYMorpaXJmOg5o3iqXpxW7UQSvojYfL636SB4oc+8hzQwQEuH6dYcrj9cMTUknTLu0sygZKYwR4mRfK710dsSJ6PCAC/cCmJNqIii1mMHUv2qHarsIlzC8p+tHBj7i/YFCwvNHRfN+g46M9xjri354iPlpB1+5jwvtq2aUsK0Da0/Whhzh2BW9bcRM/ZVnFZU+a/fsqlQrS0cdzQAsKb2xUOEabPQpSxrNXjCc4gjUTunlZDCumDiInlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/30] usb: gadget: aspeed: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:52 +0800
Message-Id: <20230726113816.888-6-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230726113816.888-1-frank.li@vivo.com>
References: <20230726113816.888-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0033.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::21) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|KL1PR06MB6210:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a450bfc-7ba7-4e3c-dadc-08db8dccd8bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: srYEMBzwQSD63l/Um8pEYDU9t7fYjESCN8ZCHoknSI5pq+Qo04n9NJBW7R0bAYoVyGMdlSSOR0A2q9SoNcvK764j38yOCvmGnZjtP65W68ZLaPq1WDQSJFKCjwUfLwOvcG7RKl6oTzJV8qLEZpyliFnfivvpuZ1d98+itn/yl2eXzTTBtMOSZSi89RrTa9rV5Xi+0a7c+rj8/ADuc3JCgtBUUjm3VilzYRDm2n1kjui0Hbf31BfXGF4Nz58BaA+pCsCpC97gdfM7pG4U/WpLL4MBHBCu8cmtUBZTA7MqjcGMOHPiBUZDu37+SprCXHUuWSWoH4r0ju2GsY65qdB3kyy6Y0m5Ye0RFMtKcYIKjYq+0yYrN/ku31r2TUB3ijaGQTBvh5oDA1XOwa8U1XthoBt1foWbPDPbSmtKmVX0pQ4rWFbFQpmYf1gVfTVF1tQ2HyBc4EIXJXaaaPlJ34fKnNzDp2CDzNjN6OaOCmdQ9p4ub/03xq55AE1Pff1zDh5iCjPGFiISCBMwCM+xGkQy4FtUcMIlCcIYEragw+8I2xazhubduDMHzFmgpe2g9W8fdRfV3HZWgro29yAY5L3dn4T5S/TJ6ObKnnotQh+j/uAnmcNBMicI3tSLlUG989XL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hf9NmXenDNsYTz17remZZpO+UogXKEO8+qTymVgj1BcMMG/QeJTmR8ZmEBFB?=
 =?us-ascii?Q?QN0ZJgCrZ3FW66mXsXl1MAOpIhvqLAE4Sn+VA07nmiBuSfZWpNi83nDSuk40?=
 =?us-ascii?Q?0dpO7ucIInX0DKRD8vLL5gsSz8jL/R87UHMTL4HpAf2lnHuw/eQ0Sm75pEGb?=
 =?us-ascii?Q?kxXcpt2mzWrC/c37l5EMyP25csQB86RkKzjgL9CkT8y/OJnm2bWo0oa7MHM/?=
 =?us-ascii?Q?IbUOcre/ulHlTdkvN0cpwuGKQ2M/lZwZEqA6iEf4WZB1DNcNjar51ypZXEx+?=
 =?us-ascii?Q?sJuQE5GNYbTCj+iAoJEv3ZkAWT39bt8LuSK3ZAmbBfhsIjX/j+ixXRPOppnH?=
 =?us-ascii?Q?Bd8mnQuaQtdwR16h3j4xoUEzrzO1aK4pUyZK8DdnZtac1JJ4O+PqiYgZp70y?=
 =?us-ascii?Q?SorHl1dhmSwl0kLaEx35Um5cgnZzKPFnDFkOXEKwrTE7xmJczbe33xUpjYNr?=
 =?us-ascii?Q?nqeBy5m7QQw6JJeTk4bQEgGL/NN7/c+HOtUzKRYQOK/yvPuAFOFUVlJYb06g?=
 =?us-ascii?Q?ehlKpe7ZtdWaVO2o4z4wFZSrjUc6aA1TYCJJnvUFnD7bE8jutzVaupBKdxim?=
 =?us-ascii?Q?07Y3n9u4TpsY82xd6Jjx8oZ3ePO0S1th7q2QZqLNfoymcya1jyblnkHPuc5b?=
 =?us-ascii?Q?5gj2a91jvl8qgPbf+YIupCFbHyeh1sDzzpGMFFFndbzYyxX2aP5Agkn7OnwH?=
 =?us-ascii?Q?U/7WgdwEqKswrMST0b8L4x2eDwC39n/8tp0Sz8ul686DwLyayWy7iJEKHlcW?=
 =?us-ascii?Q?QNizMxCZdRdXCDirrBzhZpKinqmhkB1tcI8fwWTQf0fgrSh0Hg4X8OGYIEwJ?=
 =?us-ascii?Q?RrJ6iskJ99Qd7uA5UFXb1QeHzkZZnsx6LqUnnCDbBaStm1ZLPxAREY2X2l1f?=
 =?us-ascii?Q?FgQTa4TWCbqr8jBJydviEHz4nDAKmATVDZvsWvYdnBgF2aDUhCr1N9svB6BD?=
 =?us-ascii?Q?0iKrhQDmr9wmLYLWI8KxrkV226eV1APuwBlTAp6i+IoeEp+lqb5dXAlT48Xl?=
 =?us-ascii?Q?3GGtxeDBP+HZYngURHMMHwlWgfr8H0044gfDhJPj4fmy+hVMBrbfikLcX5nr?=
 =?us-ascii?Q?v2vGaw0EW5SuLiH8RwsXDZ0y244BHuqaMk6rLvsZdpz2yRJEOfW3GYju19H6?=
 =?us-ascii?Q?NaXNN9ezHuYuaib4vBEF1Eh1TIn/QVQFvKgUBCdDFxFKoKcqPI8x8MWAVouv?=
 =?us-ascii?Q?87Ae626zYxO7MbtVE1MaLhkwh4zxcU1upaJTF6KnRvA8vAPdLVtcD4rixj8L?=
 =?us-ascii?Q?SzqdJVa0OE79RuutWcxhuM+A255248nwXwKbX9+rAv3HMSfFdQhoQYVxS1KF?=
 =?us-ascii?Q?87x3F8I5PJUROujMjF3yO1iMLKbLZwuhxIXH1oEtP+Ktc9pHxgjDk6jDfXTl?=
 =?us-ascii?Q?wTCGWrot7T9gKGr5fYGx/r+C3nAHWfp65+gDJrAO6QFvtoqhpNOa2+2Ppgye?=
 =?us-ascii?Q?Cu3Ds0cH4e8mEFyyp9rpw1wCbvz8HStvJ/3YTWeVqNwYlssxf6aTv+8XD8q2?=
 =?us-ascii?Q?E3lkNBJEgtnOnGF71SuGYgDOBsvDU7duF3ChHZjWvGsHyKqSw3v3zaQh/aN3?=
 =?us-ascii?Q?SOCqfGhQRwpjy3QECejh72KGMglo62Kws2H65rro?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a450bfc-7ba7-4e3c-dadc-08db8dccd8bb
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:35.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTPFbEEC3dv+Ha6S3duzggEembJKGnxP3FO3df9JROgBZ78Ig7vKrkNnCs6aukXwCQgqb2ysUIDJJ6+Grk5rNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6210
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/usb/gadget/udc/aspeed-vhub/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index 16f2db8c4a2b..f60a019bb173 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -328,8 +328,7 @@ static int ast_vhub_probe(struct platform_device *pdev)
 	vhub->port_irq_mask = GENMASK(VHUB_IRQ_DEV1_BIT + vhub->max_ports - 1,
 				      VHUB_IRQ_DEV1_BIT);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	vhub->regs = devm_ioremap_resource(&pdev->dev, res);
+	vhub->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(vhub->regs)) {
 		dev_err(&pdev->dev, "Failed to map resources\n");
 		return PTR_ERR(vhub->regs);
-- 
2.39.0

