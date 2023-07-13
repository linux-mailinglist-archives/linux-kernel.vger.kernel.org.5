Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0774751BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 10:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjGMIe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 04:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbjGMIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 04:34:36 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on20721.outbound.protection.outlook.com [IPv6:2a01:111:f400:feae::721])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7BD4492
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 01:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXCebpks//lSQkAxvnrRRLhUgPbaaU6Tew3NS0vcrne9Be+WaCqvAqiSfoX0oASnQondCH0JlL/JDIPfQ9EEBbWYElUc/qzt5mxSFqdqH6toOmxaTDaTVSK6mjjRbvySfgeF1uLfZthmyoOGFk3LTU8647IC3fk2DFQTvDedMRWu4mEQNY+JNlGP4o3lXs/pndP1uAFdIU6s8nmbpOU3IGjT8Dc0oYXO7jbbOArr9TQMgkorisEAlwggTNn1hcam5MBUH4bINtzKeXio9M/HvSbr9k//lxtE2gKq+vaxgMJw8KXCLKWuuri4gPRakz9uOzqOA45MV5MVWZqCFBrbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cb/sulSHZQzDki1lMlAG5Gldferyw4/fyA081FD0IQ=;
 b=k1+XTx93dmTzeEkgAj0RNlQWCblzokWauufhGqyi0OT7m2i9Uq44GRFfVUaibZEtgZpNYEkld7y6cTr08jkm00lDfFsrwE8cGPj3+P8tIa2zVefflGOkrTc77cOwpaA/rqNOLXSW5C7VPSroPD1TypCgzCa0YO4mTvxwUrWwACeJ3PWN3ffYgtQLxtEqtsplpXjbbQhUjhkbKSkHnbhor/LixpWu+dfDyr6dCJx7B406b24VAfU2Urm/7SEMMbufr2ZBAb/9xeCPFhmqW6/W7fl5tsW3kO8ybZ2fv8Gs525JeVv7rDidrV+XmhdUUYYrHs7qedGd7oRDbag2MwPm0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8cb/sulSHZQzDki1lMlAG5Gldferyw4/fyA081FD0IQ=;
 b=Y6A3RTSk0Z+t6MAx3zKcWQkDBmlN/q+/uAoag2h7FC+hQjCtzWs8uwquDPCWfUhhy0W249qs67A+k22lx556yHMUOZFZuDh5us5eyT0JNMLE3u2xg/UEkzm+C1+Ttf6kajUDrRcBD1qdMrqK3+Kfdqy1YVzHZCXMKbLbi9jGTxdnzmfhKlEZ05H3obQp9ZXbXnc9c1NOfdia4GUZ9EoLBXJdxwGCSkdAjcZdjU5IocnvJ6wFZzo60BDxycqc9a6EcEwM3lZiswRNuhZTEbNIsV9n51C2shfCUNcD++7sFmREqCth47YywKEJ1ZWUv5hrY/jlW//4psxgzwSws92ckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by JH0PR06MB6437.apcprd06.prod.outlook.com (2603:1096:990:2d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 08:26:09 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 08:26:09 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     miquel.raynal@bootlin.com
Cc:     frank.li@vivo.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH 09/18] mtd: rawnand: davinci: Convert to devm_platform_ioremap_resource()
Date:   Thu, 13 Jul 2023 16:26:00 +0800
Message-Id: <20230713082600.75251-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230712140953.30b5309c@xps-13>
References: <20230712140953.30b5309c@xps-13>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:194::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|JH0PR06MB6437:EE_
X-MS-Office365-Filtering-Correlation-Id: f577c24e-c38a-40d9-4200-08db837acf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eSy29pl+4XQRJU5qE3NHPD49KWwRuEHDXc9Rixxh5WBxwNosMjBR/lQrwSzosapSkLTdWsGebg7CglSeywazSeEq0VxJa+61d17ohtMbn/v762/vz5R2fKQCBH1Qb7sssVvFN2ZCF4ob+BE1t4oavlodRpXuLgMQ1y1pxZVOF/FF+SC/xzaz+c2Xy5TIG9uCRg4Cs6JEzfb++Y61vHKjn7jS+fxKh1821R7MphH7z5CX4zcA1CK8EZAkJn6puvN8oT3ydZmBuxH1SluxA4NHKNGQuagpi7A7Xb37B8YG7+7h8x1Amd2/hGxTwjy6KLyVzOt1P/wk0pMTTwpRbjTs49wnoo7h3AXulmHzztCk68GD5vVF/TTgAOvcQ51CgWR9pX2NaVnXkZXs6oTbNiFzo9cYtSNHjohKl8j6DLkSU5TWkMO69yy4fIS/Uc0GbY1YxkPv4sfJEdvaMlpyaIGVpPiVwovG99ArnHtXnDivjC+YtCDFi5npWsUpZ722byu06zffKMpGjIbrOxWpawgP8yeGnsRVdi/Q7MYKdOptTPdIwRT1HtGNED75veHZAhQsVQGGimDH1wcglKmkK/Qh9a1dP8R24XT8RJeNIThL8emdKpTPk3LGmof45eWVivC5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(316002)(6666004)(52116002)(186003)(66946007)(6916009)(4326008)(6486002)(66556008)(66476007)(478600001)(41300700001)(6512007)(8676002)(8936002)(86362001)(1076003)(6506007)(26005)(5660300002)(83380400001)(2616005)(36756003)(2906002)(38350700002)(38100700002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i53bSy6/tsAwzA+/dS8LBwfcXm+RRSPVEV+HPs1PXzfxBidBYO8SQiBUJrtF?=
 =?us-ascii?Q?ztzGbR8a46jEB9zDiy5qw3GkSBdPOpcj7uQATnBHWTJEcK0wBTT9GAjzTNsr?=
 =?us-ascii?Q?WaiMV3/DHmPoJpSgWD8X/W+h8uzztgCAfekB9aD9bu22HEu535v/5UIG1wRd?=
 =?us-ascii?Q?ZKSag/QyMCul+9cDPOhbRCtuBU6yYlphLaZ++o0dU/XL1WnYlDCGkBAsiDHT?=
 =?us-ascii?Q?tWw15naxMRD3A7oRmffQmW8dNGFqRrE/gs69C26xgkuu/cEj0xGMkErr/Bc+?=
 =?us-ascii?Q?Sqwf74Ri+MUa5D1gczetwWpp2XWogV1OYkCEeGrAc+QUtXS4UFLSpc6hhDqK?=
 =?us-ascii?Q?97F6E72fUOCjmsKDp+XXXEpMM9Nz+NzhVmv5f78lnQ8vd1giMoPU8mXuFSky?=
 =?us-ascii?Q?9zg8dLFx/3ZtZbqUFy9XATmRdlHLXl/J5M2E8nFzATm+03p3HmVzwwKHziwz?=
 =?us-ascii?Q?Qvcs/bHcUIP6dqSeUhLlsIzWSpLSjo5NhdyErYdQLozev17V+CQr8q2etu/S?=
 =?us-ascii?Q?myeOnqePzT/lcfarrZKYcyPbfDuq/ptvYry51TA6M47z7sGTJ9aD9mY18s/C?=
 =?us-ascii?Q?YSGasrDOFVHSi3c3E1n82Z6kITMEvswt+LZB8NrDQryRbsSYUt9Wh54d3QXB?=
 =?us-ascii?Q?exvX1Gyl8+WTxZLpMUrlFvBTQKvEHctX2ZBJYHDTKIyC8iumCLK0V5w1OYcH?=
 =?us-ascii?Q?B5YnJxHSyXHHAdK6E8PNXY5m5n3JwMQenM5u+OrrJuhH+Ww8fAz+tqBymnEg?=
 =?us-ascii?Q?VuZQyDsk+mMHXOBjtErsfTGfGsjX5zQjCmUl0VH080pPu68+bQOORsSuVt/S?=
 =?us-ascii?Q?UyhCpXVFUDLpkUko4T9c9RIBZ/C1YSk6gglbUe4bAyaPqsgAcD/9QLBXAScf?=
 =?us-ascii?Q?3DVrYmGSv5f8gkKNoDFNOtdM6wlH/VDMR/Ww/rYz51HPjnMzko/GW1WFm8Lb?=
 =?us-ascii?Q?oVvZLd6Wlv78SgxeTWuEdPrEKBtkYNYG4+UntK2e/PKf296x7LKwtDOwTfyB?=
 =?us-ascii?Q?TXlnq8AoUy08T5VecQeC/Eab2IYkvkCxtTSSKoxpsnMy5mbDu89ztO6SY1j3?=
 =?us-ascii?Q?FRwK2wENQpaxXJIYoAqckQxJi/qDPWnM3O1s3VsyFhhTlD6iRe48J8K7Y3UN?=
 =?us-ascii?Q?NlKv8GFiFHmubBI1tfZ862kuQYERUaKzQfBrXKddG+n9jVGRNFpLVfzVTE+I?=
 =?us-ascii?Q?+nhTCTquPvpUPPNsjLjFtCsYWnxNLbQibrO22G2lqHJBBAFBjtLB9YPJkLr9?=
 =?us-ascii?Q?SN0B7aLaeHmVOzXy5c1pWsZ6N/Z1HE/yUoS4pvF+6/QYd+yaqKdxz4KNSmup?=
 =?us-ascii?Q?OiYz99M/Kbkaq5jg4VuDw4wdsb046ylBXCOclAbr5NaDN1fXEb4XkQ9eQe0k?=
 =?us-ascii?Q?DCuI1Jg9h7KeqRQmN+OXtggtH+bVKrO8MWpLcVXOpGeEWm/8AYhX7GJEnoJj?=
 =?us-ascii?Q?0M79hrKH/s1CTlptNFxk5ZIBqfoddOSSDf0jqIiGmWGDck+cKMEpeOxTroXK?=
 =?us-ascii?Q?aAmJLNSBPN1Ovfnz/BpaRjEM/Ap9U8h0FGFE3AJWOma9QwEApwE9Aopaa4lF?=
 =?us-ascii?Q?oWalRs4SqpNsURRUm1VxU+th7ntBg4+oSSSbFV/t?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f577c24e-c38a-40d9-4200-08db837acf65
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 08:26:09.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybxhZTwID6G9yyojK/ydOltDSAka/B48VjUOmeq+6Ftcoqzm2l2fmeUmdTfOZ/uIdwKF+lLmSwZbdE9guAh4Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe this is the only use of the resource, I am in favor of just
> using the regular devm_platform_ioremap_resource() helper here and just
> drop the reference to the resource from the message.

I guess maybe you can apply this patch directly?

It should be noted that devm_ioremap_resource is not the same as devm_ioremap,
here is devm_ioremap (devm_request_mem_region will not be called, and there are comments explaining why this interface is needed),
which means that we cannot simply replace it with devm_platform_ioremap_resource.

MBR,
Yangtao 
