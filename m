Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17D0763536
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjGZLi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjGZLir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:38:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2126.outbound.protection.outlook.com [40.107.215.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258326BB;
        Wed, 26 Jul 2023 04:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFz2HOb0ztKVuSF3kwbcDq8GQHA8wDsCz6OFOWi5qR0vF/7f6At64Khi8D+l+xlfV0wpRW8nJLkA81EeBYh/ee/S6D3x34UYDJ49n1UJGjSPoaXjDjdb3S1rh3Gq9f1hA374h/1ov6OPtPbE4DwIqw4befQNfV5bI9OHZmX6+GENDfI/VS+mEpGW4qHZeQm4RH15kYIIQfYUkcsXPghNxX0I/E5ffd7vPyVolzPx2vpvIy7mGjOaG51f+guqPzGwZ8TQ73+GmQ4YRm9XvpBwvQdKbtfrg/lpGpa4y7YhNWIVLGtwNMVt21tMTGGAwEpthMnQ6p7B72jOcFjPHBY34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ijtDtmCquRetTRk6TmjDJqMefBniOVpLTkJ1i61IfM=;
 b=V6PXerj7xZr6t4+/UcwCDmt7twcDLj+4eNQBRvXPtNayqX05/5xG1bkBQ7eplCTRTgeJzoCITeyAfRKUzlOqZj4kKcb4vZGQjWKAl8jyXcZ75t1s9CcRu1WSyFJ0Hmb0SEeLZ3fNlPaJPPWpWELckNSDePoI6vmX/m81SQr5/wLTYUzKDpVSRmwVsUOVvC6tIRy4XaOpojttfil6SJPJIYLJuOPHfpMfur/914/6fyhEOGphIGi10CNN1T/+xgUAs2YO1pmJKbSFujZacHCKU2Jd/ss2SoDcKR4MmPl1v10oL+sGTZyjjjn0POTEIUwY28FnOjRcOWWcGhW3LZMeiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ijtDtmCquRetTRk6TmjDJqMefBniOVpLTkJ1i61IfM=;
 b=T1qmDHlDvJqqq3pa3Mmf6sDi0qjS+pu/NuzInKpoCu3APLH1N65V5vZb7meV1ZJQ6xhCMcC50GCN86A1XdudQkDXJHjDYCLepveEmryHTuC5In90+zuPw/AYKETXCAiBVJwWTIOje7POIuYoFg5Yjx6/4X7f4zdaLfyChzgRj/evRO2tm8l11O6Dii78WdiGyG5ran1xa/wrU1JLpZ1WJHdRCp66ZoYTYkiLcxZptWNn6sokCEOu92oaWuge+HnKCK9NrUA9JXz0n+VSmWJLgLQsNvPz86gHKCH1NQbTo5/fLJIAnxEKGJ1gGDDGNoRC8o4NJ7jQOlvYEEijI4k6aQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by KL1PR06MB6210.apcprd06.prod.outlook.com (2603:1096:820:d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Wed, 26 Jul
 2023 11:38:33 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::732f:ea1d:45a1:1e0b%3]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 11:38:33 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/30] usb: gadget: udc: udc-xilinx: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 26 Jul 2023 19:37:51 +0800
Message-Id: <20230726113816.888-5-frank.li@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1319c9ee-f913-4276-7e44-08db8dccd7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7JOhwo01ysTWEt310w8zL0HGFkHe+H7Cl1LQ80JWrdMiHjHZdpwlvD9SUun1FpsmTyVcKILFw85/o7U+wRtvmkmwbXg17OmE8ee8XQND15zNLE6SJgIR/G83HkkaC2+fd5JIypkE5/oG3V1d8AlQt5fFNJ9pytziHbrdRDs2lgzYkF49hRdcA7UWMA7apj2N2tCMSP5gfq9247BINzxr1ysMN+VOIo9tON4jpdpmMj/nRK+CM7z9FjH1GtPHoEzsOX6PN2qfzPuc6bMsbyLUlFtpSpqSB+8IwUpcdNzBQyd44vb160oUQt2erez1D9sY06ecBQR8OjtmTyBk0qp7lzaLOW5lK/VWysNlZ4cOXA2Cz/+8NLSKtAc6rRc1OjXxtqvWjUaBL00gbor5jogZ6MJHPxwfDFJqM65cE4SJEWuROYHbofk36uGpHuA/a/IEJHJFPTirH5CtY/x+B1eEcccLOXl0o51PqOnwqSzVmkYsTeDlbl9USIQHki1YJ7v9w/VJpxP3bYUcdgXiPQcmiimK/ug7XJH+HY72RBPS2G5jyzOIe7mAJgIRiyvNgh6Ia3I9fjzgUyiG3FYYgFSE38NKEDv6a5CuhzwvNMUqggK1YD6Ke/Wuo0Z0E1MnUlcr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(451199021)(6506007)(8676002)(5660300002)(8936002)(41300700001)(316002)(4744005)(478600001)(52116002)(110136005)(2906002)(6666004)(6486002)(186003)(1076003)(6512007)(26005)(2616005)(66556008)(4326008)(66476007)(66946007)(38100700002)(83380400001)(38350700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kVDpf7tkOkqTk2Xbz3N1RVHdQrb9xeo3dPEqWxcWKLIJ6wG40MQcHztWutqd?=
 =?us-ascii?Q?l2TU9jC7UjZVYeG6CavER1qjpYO352SwzDazrfnozpT92p8qxlHDZXKVmJLm?=
 =?us-ascii?Q?pBMDMGOv0uzy+4EggEgZZvv49tmkjjV9D9NS3uCg+jsKfQJym/bbQZ6SgCJA?=
 =?us-ascii?Q?HRKL5KqfvdHoYOWbnFFPAlNClTxPw+KBor3+6T4x+mOnTlCBcvDk493rm64b?=
 =?us-ascii?Q?61UJbzXfvn4aJZuxv56C2avb0nTmg2nj7ldgACxTWdQZ7Cn1cp5vAsNX27bI?=
 =?us-ascii?Q?UDQmDO2QVlRktVRHJtpu8fxdZ9WRduSoI8Ncyx1Cmgn++aMhK8/3L6EijB0x?=
 =?us-ascii?Q?ZqhY1R4i6tQS0cFxWAdh3jQhWR7tmTDg1eNXWzRrEDiKMo07zNozMiHnNgF1?=
 =?us-ascii?Q?2fDs++Vbw+ph8JqOh5lkjplUuFcZhXvaBrr+DJPYrJ3q8CVkRh+KGRFgWjAm?=
 =?us-ascii?Q?s1SfoaA3lH3680FdBkatLogt0wWnqtOi6R2tiKyM617zb12SccvgVj81TXhO?=
 =?us-ascii?Q?dHLcre+c/x5C7bL77OqN3agYsJZpI5Y05z1auq4zKdPs/MRtZj4me46lYnAK?=
 =?us-ascii?Q?KZ/r3ZeVka/PksOK4kJwsKUkGNqpZmYJDwgjWw5sqFv4IE9NUZcf1c9Df3K4?=
 =?us-ascii?Q?NfPKM1xS+pIPqJYu7G0D7qtzD/EBVK1/yUPQQ/U3dnWoJ+zqGdfaJMRwLC8E?=
 =?us-ascii?Q?kjNG9nWvpKDxegeexoIQrGzAklBnjZl1ZdwU4sEhw3/73v6gQr6uBT4bJ1ok?=
 =?us-ascii?Q?qOUlQqTqxVngJ8qiA9Tky+2O8iR0kOiEWv79rG7pEfpxT2YKjCMINSDmGriG?=
 =?us-ascii?Q?VVmWHu1v9S9BwWkwyuZhTrXo9kw7otGdb8Pu2UGm9xHnfE2VptFMtQUS7a08?=
 =?us-ascii?Q?fgCfPKOX7eajOPDGFPhgpZgOSFWy6D3rT6lI3k+UmfI4/lLOJHWVTFsQDHiV?=
 =?us-ascii?Q?LKs8jP+CUyck/ZdMkq/SMbhCUrA/nvemieZXaThI+RDoyCkP79H//JHCN1nh?=
 =?us-ascii?Q?sZCPYMHDLVCJB/p0TNgHwRWZahzzNj7dYCvtC0cm69oO8WZqiI6DYeFwPTvn?=
 =?us-ascii?Q?HIA4KO1Y1o79BqNPuxGy1mKCVoilkzoafFrbfnOmDvLm59ObRuiIZklsx/OR?=
 =?us-ascii?Q?w4JaPbIMA0Nj2+Q4hFR6XVv00OcHlX0y0X6lY3ZlMUXpg2cM3MEbF9a/QN0t?=
 =?us-ascii?Q?d5q4oHHjoZdcXFB/wO8IM260/4Q3Zfz/M/tqEwy9jzVENZjLuAuFbmwL2yF5?=
 =?us-ascii?Q?zRKv+Zx8fafjQgwXA1xP8Rv6U4lhf+xq5lmeC8jChWeVwRQ+WAm1GIW+TmSo?=
 =?us-ascii?Q?y7HuY+RqQ0I+yFHYlROya+AA3dC4B7PtK8TjClEKjJ4J6qRHYIoCNpe4YGr6?=
 =?us-ascii?Q?PuPqwiUnMJnT9Ln0I6qw/H6D3xMkREpHvM4/IjP366ubGHutWv5n6K4wwLEw?=
 =?us-ascii?Q?Ahqe704sDaxFmXY6BJ3AtrcinVf1y6DfNxpOfPlufb2ahxJzhrmu60kPGvmZ?=
 =?us-ascii?Q?Yyd6CwwWhoCiDSKg4efaGpWq+w1AUycxvOE6S3VRl4sSYZ0OW0asKT+rvG0m?=
 =?us-ascii?Q?6bCvHO/dh108pZOhjMXGNQ1colwPljF1MItL1x22?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1319c9ee-f913-4276-7e44-08db8dccd7ae
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 11:38:33.6342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxn+dIkkr6RBAXxWoGrJcaCdHo4+SYSJLITl919mn/YwfsY2kGZM5DWPrahZ9knvTKbe+hB6eyMg2cInDEQJcg==
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
 drivers/usb/gadget/udc/udc-xilinx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index a4a7b90a97e7..8c249e31dfca 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -2080,8 +2080,7 @@ static int xudc_probe(struct platform_device *pdev)
 	udc->req->usb_req.buf = buff;
 
 	/* Map the registers */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	udc->addr = devm_ioremap_resource(&pdev->dev, res);
+	udc->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(udc->addr))
 		return PTR_ERR(udc->addr);
 
-- 
2.39.0

