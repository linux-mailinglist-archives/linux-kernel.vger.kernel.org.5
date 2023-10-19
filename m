Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B953C7CFAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbjJSNPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjJSNPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:15:06 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5853F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 06:15:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcUZMPUDC8CyVmpCnExZ0ORqj1S7YclA523xmtSTJ9np0KaeQ5FY0OBhLq5QLjkzdIEPWEwH+EUiyMJYi6BXueVj6hS8gi/SER+FI8+fmmd6gsyn21UUVoIt8bkzImUmIQWmZ/IOruLmQRbNF4yNKILpU711NpTgmAZUeqwAAen5JmGFmJo7JTXVX/tUFzXElnXqxYxJSvr2o7/X4ePKtvPMuTXcmk4i5zQDDuOfe4uQE+pbU9Kxp8oveFGCULBXsyJrr8hLlS96m/ksiGg0GeQGVNwj7VO1ewe+u9FJ16wPAZU2LxU9Ov1UI2pibvm7W8WefVlWumR8odW5nLTv/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeD7GJRBVPaLEyPUpBRL+qWTsTW6KysVx0ohxWkfuHI=;
 b=SQ18xcG6tqKA0w6LeVOaP05cghtB2NELtUa4SFPxwqIQWholDZ4lPN480TTwgga723HSdPP09L7lzQbUIZG3hJOQlYAm8Kt7sSl5Yd55u75aY7MA9aTjaiglhTRZxXhKLaR1QxJpmSa2Us93vpbMJrVbTsxCy4yh7nOQ+L1a06AYTDrLhqv1GS4pQGjUl8Itn+U4Tz935CELqnTXCn8WgzzyWNuT2CYaEnBLOYayL/nZlm/jjjIfk4opfSX3CqGRfRzM5wfHKM2UBJIj+gfzgvRFwGpTTU2d28D2qPiBEWI1EKnbE05/bKfIRkukB1Y5itMR1U/cDXZw5iXbsp5mEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeD7GJRBVPaLEyPUpBRL+qWTsTW6KysVx0ohxWkfuHI=;
 b=oLzXKw574khkqySpgwwrN7z0sMcH5hC9sbm6Z+HYoOBp9+BC4rMPcM4B98dC7rFuCpDYEBTxCGm7U1hcD+miQRud6HFIsHuw89XrDYcRNUjOJsdnuArcnuk0i5a3zgiTrIuW0iBHG7rsg1inqSMcCge0oOJlGxXhWsKJ0wd+dgqn5rMbb64uHs9J459gIEbIKojEiAu7nsY6dliKh3KwvorOdf6v+6t1+k6UzawWCa1UuT3H7PitKdAoS0asGi2hPj16xVTiYtEsrjLWheNdhEw/do6XDH7soHfGjAHy6jqDtcC5U8tdWN6mLf5IRNLGWnf9ndjKToWyzvUCAmFdvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by PSAPR06MB4470.apcprd06.prod.outlook.com (2603:1096:301:86::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:14:59 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::32d4:1209:6b36:86e5%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 13:14:59 +0000
From:   Zhiguo Jiang <justinjiang@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2 0/2] mm: the dirty folio unmap redundantly
Date:   Thu, 19 Oct 2023 21:14:44 +0800
Message-ID: <20231019131446.317-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|PSAPR06MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: a14950eb-ec36-4cfa-bc25-08dbd0a564b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0VDagAjZTQz7+ysd3yUZJaifjezvEWDh6TlkdvYcBD6BFd4AfwMhPvR5WBY2htcBVmdWWpzYtiK8Ff2QGbUzlv1SbriXZI1+lMYOXIhYCh/X6SpOogpg0eOp5tf52oGPY77voVq4+lrADWBvXJPlFf6a/cUKpcr2trMgZdnbID8v25vGHZ8ZzNw91ijyAOgRyPDUng7lMkXtlSIMctlZwKsZ6o97ojMFOqn0BEc53yAVT01FWe1iyAJ0PiDg+DjPlNF6t1lj/PxQSFk38tzhWRBeaJJEketBJWDNuE+5yuwNnBgTsmHeoNmO+ZRm54R1on9W0wb9wq9mkiROauoIabGI8MrBoWMi9GJC/xAyDeiYnIyc++9Sq469PLUu4sRwdHOXHNAS3rHHeJJ4OFiLyXteXohfyb7ExniGj8IM9kAGFSs0Be8a9Tv4Oa3OdtRRsbdM4Y2Z1TSvWvD5nz93Kk/VPXaRj1/zGNTMPmJ6RkXtwN0Jf0mh0f66eaqAs9Mj0sXaJSaD4gQKkN63ToaJA47AehaDmVcp1jx8Ke/XMzM4y9uQm5f9wHNfBQaC2kG/B2EJ2yXiTazptp0cloYLcYt61DEhHfiauxfTpDwTAH9h2524lC0e00ofB1OeQGRCpCGuXPB9lKEgc7SDPAzpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(136003)(366004)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6666004)(2906002)(52116002)(6506007)(6486002)(478600001)(41300700001)(4326008)(8676002)(8936002)(5660300002)(66476007)(66556008)(66946007)(316002)(558084003)(83380400001)(36756003)(26005)(38350700005)(1076003)(6512007)(107886003)(38100700002)(2616005)(86362001)(14143004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AtplFugcW04cy9EvZN791dGcc66Ribe27rEScSwQVRxWsaiIH2Vzn/PL/bUu?=
 =?us-ascii?Q?Kt+awW51aajT72KwkXwGF23c1emn9dzuxskh2VTF6wJN0t+5jOhDZ+B9xWYf?=
 =?us-ascii?Q?epx+cWHrric6eajawkzExS7S4IogfbA7EztfKR43RaXYjYDGjF/EhdhLpri2?=
 =?us-ascii?Q?Am1cZbECC6KA11GIuhHWDvAgaHwcyek+z4QxMzlCgPm9dC4YYEBpN0vXvLng?=
 =?us-ascii?Q?ZWT5FoqqsfvxmmKoE1jYgeuJiSEHzRZnYjXN0xNxXSJxa1/zv3H6+P80C/7z?=
 =?us-ascii?Q?gIVYvqi5reqFFUk34hF9qmjQl4KF/dTLeXQgFIEzDheK4km4G+6MUkBtIUCP?=
 =?us-ascii?Q?YsGE2tsgcxxbtA+vwsb0Wb4jxP6gCCef1QxQl53+4czEEQ6ulUprUS/MhfKt?=
 =?us-ascii?Q?+U/PqtAZwkn5doGWmrkfY7Y8Ja5BGm1OMxOPwajmH4ntJrX+nk0QaDXUMJf6?=
 =?us-ascii?Q?aXslOHG+unD9c03ub+MDUsddHX0MujUoPziFX9JLxUzlrTpXjb3tqalyvxv2?=
 =?us-ascii?Q?kNSemgl+cbyfRi0J+yWZ/bdEKdcOrJz9SRFGK7G9JczmO1Iu2lDLBCLNuzAi?=
 =?us-ascii?Q?+IOa68nMfruSyu0bbgBSr3JwWjLIeaLLqg3G74wJ5M/xBVDjQdfzmhl0WtNM?=
 =?us-ascii?Q?Kkaut5T8ZMaWc3dzpB9oHeTkLGoKmdRTyrjWvcrLBk6g4Ic5TRBTwuFg+3QK?=
 =?us-ascii?Q?Hp8yTQ4/0CLxgxerAkTJ9WO6y/d2Pb/0d1CkcD2xdyWvlxNR86chGdtVsOIF?=
 =?us-ascii?Q?MVJoGkWtXimPavIGtLLNSSIw9A4MPVuJFsZyy1RKd1/JdyknmAgiviIMB88D?=
 =?us-ascii?Q?en1uxOVNQsaQ0LAGA87+LLiXDWJz8gFRrUj5lIKb199o18OPP5nAYVV3HFLY?=
 =?us-ascii?Q?gYhEP9TdWMUK7sgpOewTVm1uMYftSl8LYlZzlZGx1hTtB984QCWHsW0GhJut?=
 =?us-ascii?Q?7tNpZxNjA8uVitOhehY+NUICsrd8WNKmina0oR1DiY9vnWmGnSxZJKnYoWFA?=
 =?us-ascii?Q?reD9KvQUDlU33N7ynIHANDUMjtsVcfjiIZj4jKzDSXFB/6qds97yYPLzj5y5?=
 =?us-ascii?Q?bdrM+01Q+nbO3SqRpd30kXf7Ezl62bHs2PuUiNAm82Mb1J9Ppf8kPbdcbznI?=
 =?us-ascii?Q?vskKVUX3l7kei3WvzcoIyPjWaiCy0ijGyR6KQtaRcH1km+VP5Ig7wsEf+RSD?=
 =?us-ascii?Q?KlzO3loBkVRpsR2pj8HltIfaTU2/gkaZ2sPuF1FEBOhTDOov0fbX6iDUH5ie?=
 =?us-ascii?Q?WG8BQCNFUv8YWWogtINguqv+4yVdfJY8arHSYNgn2Mxe2FMaRLfFannDv+UC?=
 =?us-ascii?Q?CG5kqv95hpKRpl9r518aDJy9mP74xfXlkTwBQ0W16Ce2g+XI76gLCeR8r6SS?=
 =?us-ascii?Q?6jWu6auJwme3pTf71PRJz76rkuy3yt/T6cI07oh8uTNFpPeJyLS3p66C/VVn?=
 =?us-ascii?Q?YForOcSnaibYMTdIpbe+H3s9rr0PP01T1HpbXExblKtaDtp81U+8YUJ0F0Jf?=
 =?us-ascii?Q?qLpuBEBfGtczfteHzzZ456zsaDHbucQAKvYv2svV0rO645Ju7TNb4cI/8p2d?=
 =?us-ascii?Q?Mo+cmMw2nXTvH1XaxyE2VQRao0xqjpr6oBQePT0B?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14950eb-ec36-4cfa-bc25-08dbd0a564b9
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:14:59.0646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21swLdqSszPW+VEmkCryLdxqtu/RjlpSF5vCiwo5WIvmSwmL/EcgjXmGYG5rTNdMoY2QoU8O3uojkSeBAx6fSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4470
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Zhiguo Jiang (2):
  mm:vmscan: the dirty folio in folio_list skip unmap
  mm:vmscan: the ref clean dirty folio skip unmap

 mm/vmscan.c | 106 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 37 deletions(-)

-- 
2.39.0

