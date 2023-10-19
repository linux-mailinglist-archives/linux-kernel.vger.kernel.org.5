Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857F37CFAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbjJSNSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345498AbjJSNSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:18:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2107.outbound.protection.outlook.com [40.107.22.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED2112;
        Thu, 19 Oct 2023 06:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH2mzJNjzLaSQWLkKBUKZ0KAGqvU0M7euq/Zy/qxa8JSFfGzfaXRrYv0/qL5SZsSaQaTge9AJbp5uY8F5jdADs5SulBKs8ZCh06wUO51QUzGO3LzOHIjsW/LCoMcvAGrIWNQKuMOpkJdTw+N2YHgMSHaTxWU8/uIkMyrjVp1H7a08MW+UBc2VGTvgmSgzftBdHVixmpJlUsOlTJFYnVZFYgsjMuWq9DkdtA6R6foSmp5BIas5lyi/YirQusgie2MHpCcC4zqQmUURBa8r6s+zSPZkqGAd3NsUzn2GX87lpkvyJLd15x3v7t91coA8mHzE+jZjMr55wpICvhf6cSPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=636Mc32tqRNmV8TbexkRE3H0xWQi1CCimZiV7IahXRg=;
 b=J369lS2/7nPEmXhwg1N6uvNTZNmRfWStHf7P69Uo5z9CLY1bF5JP+iGHXJ+8i5TxclLSYvI9J5PzLuJ3xlfY5mt9AC/TFOOVXg2pkYiW1zWLbI/PSkyx2EBfToLQq2OFpZq6z0810mGlVVOy731zpzOvvjhNTQU8UWZXmsQLYDSIV2skJN/Aisuef6zBhMT8nmzzox9/MnXlhYnvz9KqtUEBCBy0JzjkETd3XfTtf4PJfp9roScbxCIaaeQp3k0LUSJBgGsp5S8QHysGgWZVgqDlDXvDi5SQmdqNCt6l+FIzUGF3O/jwgd3X0naspy28Cqwyje8myOTKzEHyKyLAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=636Mc32tqRNmV8TbexkRE3H0xWQi1CCimZiV7IahXRg=;
 b=cqUi44LsSxiNSIjIedk8wyYAzmZIBRSc+K/yi31cGxLVrXUPjwjEcfaDcjv2uwoBVKT4HHujtzVAr9iKZS89vH3JPnAp7cy/cTDvuDTkqj3+9gC8LjUrSgYFNeL0TLssCMnGYO38vX0PydLp/VsaKYxWOkQKyXX9oom+oxI6xiEt/1J9wWVBODb7sFSq+7OEvpRC47bgC8khSY4EaDQtof0idVx0ew6s3vf1/ZWKVexPxCgI52kZOOiCRV2ePK2jXdk6v+Q2sJi+SgFDdD7sGjM8uwu3hDLhOABySuao5nvQHUAxDs/AvRsVsxit1ZRFbE0JP9DoSxy1j6mswL0OnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB3PR0302MB8966.eurprd03.prod.outlook.com
 (2603:10a6:10:435::20) by AS2PR03MB9954.eurprd03.prod.outlook.com
 (2603:10a6:20b:62e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Thu, 19 Oct
 2023 13:18:44 +0000
Received: from DB3PR0302MB8966.eurprd03.prod.outlook.com
 ([fe80::6af6:9028:723f:f66c]) by DB3PR0302MB8966.eurprd03.prod.outlook.com
 ([fe80::6af6:9028:723f:f66c%5]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 13:18:44 +0000
From:   gerz-1 <burak.gerz@mt.com>
To:     linux-kernel@vger.kernel.org
Cc:     markus.burri@mt.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org
Subject: Re: [v0001,1/1] input/ts: ili210x: send abs-mt-pressure for untouched
Date:   Thu, 19 Oct 2023 15:18:30 +0200
Message-Id: <20231019131830.41116-1-burak.gerz@mt.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231017131057.1034956-1-markus.burri@mt.com>
References: <20231017131057.1034956-1-markus.burri@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0175.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::17) To DB3PR0302MB8966.eurprd03.prod.outlook.com
 (2603:10a6:10:435::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR0302MB8966:EE_|AS2PR03MB9954:EE_
X-MS-Office365-Filtering-Correlation-Id: 68246688-5961-449b-9993-08dbd0a5ebcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VW8NkzrncA07bYXcgVxKlLOn4qIffCSXY/sdyTWfeeGDcxpgk6AGBLWQ5n3/YLvys5GA5g6WMobJEMkV/P4nMXhFHYoc/+rlgfCZnC1YYHPCWQFJMGDZypG3YQ64AEwvuuttrQOBiSNt7q2IQ+oHCRMEqkyXJbgtesZrsH4Y35AtZcMliFprrswS/MdPDf57MY7eTEci49i7pTvjmTZDWYUr0Y4no6xKlYyOVVBNEyuqUrYHoNKvPYXyUqHb0I0+81H7cP3r1Qgv+CC10Qpr4wdnTQI2eDg77GZKwr/h498j0PomLxnDaC8G/KTiymPo6BAOwkILdPf1mzswiF7QSubLC5T5oXrzA5xdunTd5M9C+8AOA/8W+vX29wLrHTMksbWXiCirWxBNSSdciJF3XbSQQyvOKieRfGnT7Xz/DJZdqN3pUl+QOIXxIE4cpCIGTiXVc0YQjuPWWVfwAyDF3PyACJOGMTVt7wsnxwICjKEwpY1IY/sZBHYbEhS+Z59czj+sYbmb13txqdSOB6/2r3foos5/aoe70doKPyGQZkje8vAUtN9PUhpazWZfcaXYDeFuh3OveXzv/wk0b2gmpviw9xF10CLNDb+tp02JcSUS7h7CJ/CR6MVlG9AJtFqpa4XDLNB7RjaMhs4UHWC8mPeGAZocOZwuOttYdFoeTR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0302MB8966.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6506007)(6512007)(6666004)(36756003)(478600001)(52116002)(6486002)(19618925003)(2906002)(41300700001)(86362001)(558084003)(5660300002)(66946007)(66476007)(8676002)(6916009)(66556008)(8936002)(4270600006)(4326008)(38100700002)(316002)(2616005)(38350700005)(26005)(1076003)(43062005)(15477505002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8OkOed2g2fgeiPtsLMI+JG+PpguIsQK0z+TSWsNiTKJrD4eX8suO7x48bF/S?=
 =?us-ascii?Q?rICJRD+kICpQAB0zXu7jMSH4Nowy/UTk/6QqofeQtcmaQM2iYtgXUOgVCukH?=
 =?us-ascii?Q?/+WPXfcqCI65Wn95KFTrPoiOO5zhn9o4rgN1C0OFlMHyoDuIpkuy2QfwW8zL?=
 =?us-ascii?Q?1yXb4QR1NwMDjNmm9+/BsC7se5dcDWLZkHi3zWpLVPKfcuZ39YKSK867+Rrp?=
 =?us-ascii?Q?foFYCTz7iyNfYM4s7X8D9DM9U1EOKHUb2bvtPze7gikZu2oR6W4hcFdNEjRC?=
 =?us-ascii?Q?r95+V1tTLA9a61FNumv6oIb602B/T29xmrKs1AkIdGLoigAufZ2fgbiTM0Ct?=
 =?us-ascii?Q?qzYQTLvGMPpLWsRqdgNswyCzblh9ksYlW2VBm+nHqMCagjzZXaAKG/9/U/KV?=
 =?us-ascii?Q?3lpikM33uQaORHAQH/WLa+eFJ4LGDQNMy52TUZML/j/v1rsxERRKKFfN+xTA?=
 =?us-ascii?Q?5MSwKdRH+AY/NFt0cXE8DSLM5dpUJsam6BU5vkXhaQYRfhGTAujhfUNeUSfa?=
 =?us-ascii?Q?PyeJ+x0I953DG0n49OaQN5WAW9zeFrPro2DTkfscRTfrpZmM7OM5qTSUk8um?=
 =?us-ascii?Q?J1jynsSeTBLVhE0x/jHC8kAYkHTvAP7piFP3CQDDslxHfLWgXgFOYnU9ABvC?=
 =?us-ascii?Q?+tU9uQXy4PdKJL93wvUCMqVuNz1ykI+T2INBOidk0J6Osf7tcGIuhosGmz45?=
 =?us-ascii?Q?ioAojEUHej8907KLiKt/ds4UqEkPpRAiBd03tPCfflsaBM6skjAEpZPowdNf?=
 =?us-ascii?Q?Ady8NIt4ZTfNROMvMghP20NJl3c6qsaGUwEBy7zcvBfl1M3OqQwP+v/R1GWl?=
 =?us-ascii?Q?Lg5peOStK+b1gIwzTMwXnXZB/O7XMzh3cidkhg+pbwHnLkghrVf5cegW+3+S?=
 =?us-ascii?Q?A1X46TXrGRU1O1KY7hjiAUtTJ+9r9LlDywAZAWXyUlgVLT7pdSBw3sN5T/wO?=
 =?us-ascii?Q?bDEHdEunlBg+KgGszOICWKPvHY83vbMWV+FSxUr2S1D+tVv6UEO/E6uOMubn?=
 =?us-ascii?Q?266zpKqr1TLiHFmk71jTovMGh1whNzZ6kcR0iGX1yZt9EZhh4PPJO6coSlEC?=
 =?us-ascii?Q?SGStBKtjGd+ISEmKS96MTiIAOI9M+1OPg9TYKQqEJUNX4x2wXTk18l0c1RFD?=
 =?us-ascii?Q?/JOASY235MUZhd552tLRJ8uVeFQEShrOx3pzsKAsPYzB9NEZQPEUs3kr2b2r?=
 =?us-ascii?Q?Gjk+QaQxCnRgAK/fRhhVp7r1WSGgLm8cq/MXAnMC7SRGPbsbT55wIN52aTag?=
 =?us-ascii?Q?aOoiYCFMTPsTmsNTE1rwgarf1FPWIV9uPxTpRKKw7vUbgY70Qu9J2CeGEJCT?=
 =?us-ascii?Q?Lk06vNwxwW4TIY9GWq3Ugujc10QP5vyK/sLqpXIskFuLIkTK3+ZXo44Ukbla?=
 =?us-ascii?Q?xWqj73rR75touE2nIjI5pNw5KXw132diuBjfEgIamfokQtf6OE5h+lXyi8iu?=
 =?us-ascii?Q?7i2tluc8U+HqxR3oLveYGh19DD+ySYklp9NqkpcZoXByxcFMOH2O+8XaOYSD?=
 =?us-ascii?Q?vT+eMBdKXgadzaqwng2o2avyA42zp/dCKxPLBvWejdbY4b1NC6hAStTUzfGJ?=
 =?us-ascii?Q?/0mCkGzYqL5X2ZKU6zT3FMOCvmwJqE70Y3kn/iA/?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68246688-5961-449b-9993-08dbd0a5ebcb
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0302MB8966.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:18:44.8140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyGsm7zHazNcAP9uZgQFuW3W+rcuvc4OX8pVwkgzeXc6g3qIKn9BNOUhv0SShVVu+016APSfF4BJ5qE1Pkutaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Burak Gerz burak.gerz@mt.com
