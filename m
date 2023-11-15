Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2427ED84E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjKOXpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjKOXpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:45:30 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2070.outbound.protection.outlook.com [40.107.7.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACD419D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:45:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPGu9rz3X/c/ii52kvlj4no8H9ZTOR3mq9WBWFNHh4OBdcZvfjbh9uuQrkuOWQsANSR+auw/hoxrmp2EZtrZ+TmsMrhdusx9AhWYz6b7ZgweDP9wjLb+cC4ZhNljpQWDZwqIqZpASuIB8kXOb5X/7HPnHPVe1CpH0L8OoD1Mdgoq7ZfSNTpypk4rrSquAS2sLqKKiNUsJufwHoL3a0dr4UuL3UjAyFbtXQsCHYBb+Oo2CVZv7yVhkjIzUjGoX/4ZchfJV9+r9dkWtOplwGbBoRmeKKJi8FcfvMGlwS+/eKjlFMYMoYMzXxHItSUvTtcK3/46i+AOepxDSMrg6TRNbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysLo27WFaREKC7Mwgy07V2qOSWcjrT7xLk8tBvuoVlE=;
 b=N+9WFFsyIj3Wz3cqxZ+TDCH4I+4xh6YnPf4TQ4eOg5dZTWCbRP1fwCcfZn3DDPeB+Upq7qRSfsYpoGikaGz3ih4fFsBNH5IN33ZXaOS0LUXghabne/c9/haH8nQ066I8aGDFeuTHOu7mBbxUwthhHqabOXdjkm7sdXTFgRLO3RFTMopn4GjbWCTQ+BTygBsmC+JoF8b01C6HwSkIqZ/h3eZgsfXQGr4A/cgajrHq2mCzfUpEVTXx2SJBc+Fx+l4FlNyrv/Sb0yV81EzhDMK1oXManDJkqX/XQB999W9y/IiIL1Cn7WwPohTroEj6QlScliObr7T//h9/m3W1iW7PBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysLo27WFaREKC7Mwgy07V2qOSWcjrT7xLk8tBvuoVlE=;
 b=IZ77bngx9VMzdsrSLQRkTsfuUYKVY1ipsBJo99ad+EdbCpQ4ya6ZmCF0J2aYnfZikDb6qm7Oqmqq9Xv3kJA0OzCJh+9T3ucEh0EuOH9IYKdJcWTj5AQVeQ6wQKjkQ3kkWy73SDPDCn/6gaAujrH0bIFsv47hnvYQseTYqajIvKZU2B1GxCBjIr3Lgru+0nrt2bCb4PHoOMKj75/Tjaa1uupGp6vIhWqbll7H6rEPxK3OVZCTF9b4EK+ThtmBclQ8mvZzY8TQ4X3VdwvItZwpanTR+rymQBihbQuC586D1MyUuM0IAwz1Il3zmJqBul5xOak6m2BJOi4ALGldGYcc6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 23:45:23 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::eeb0:9b32:19a2:8e12%7]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 23:45:23 +0000
From:   Chester Lin <clin@suse.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Chester Lin <clin@suse.com>,
        Chester Lin <chester62515@gmail.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH] MAINTAINERS: change the S32G2 maintainer's email address.
Date:   Thu, 16 Nov 2023 07:45:08 +0800
Message-Id: <20231115234508.11510-1-clin@suse.com>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::16) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3439:EE_|AM8PR04MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 8001d618-b3b4-48c9-c9d1-08dbe634ef1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CY+JLvr8EK33Wzfbk4lDtRjNyjldUE2YljGjeHhgsZLUg+SG8RTFK+v7GBF7HP8a8EW0leQ5yCjwta+NPfnyIHeiSHRnxyPRZxQDsKLz0vV7W+TpiskQgen8b1BVHgE2utRnrY54o7PJ9O1C40iUW13c3MLhc+GoiwulAqBGhQfqTQhbqy9SVnQ9FlhlDb4tMZVR0yFQx8ZmN+QASr97iK0feuVDpdvADGEYxqEUSDJMVCyz8abGQp6cmN5X/pT2AWXuuo0gunV7hb8Ep9xD9eICpsiEQPX0bXJiuz2LSIjT+EGj/IzuJbrRazOzIUPqsKn6Gcmakz5BF2pz/RRYDNMFBrytVlxl4VaVVtztK/mq6BCOBlIwubJHf/Zy+XLmzdEbCmWXUVwgC+/fLtwAF8k7ro3XHeqsUTAs2vShHeadzOTqBZlV2wF2XrkWd/YrT3BHtVMt/iEtw8plJ1ImOwsGijNmpurkc7U6nldJBctbx0wnTh3HirzyytnCQ2ZerECaL2+xiZpMu6tgdscpIppFLB3vXE5+n08c/gQWZ2WGxxSTCe4ucwoPYWEWiwgk6KT0sMrEU2RVCfMLUjOfu+Ldv5nNayL3N/Rxp8ZTW1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(109986022)(86362001)(5660300002)(7416002)(6486002)(6512007)(316002)(36756003)(66556008)(66476007)(8936002)(8676002)(66946007)(4326008)(54906003)(41300700001)(2906002)(4744005)(38100700002)(66574015)(83380400001)(26005)(107886003)(2616005)(1076003)(6666004)(478600001)(6506007)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHp0bmUwVU15U0gxakNwUUhCZE1vZUxBUjNhNWRNMFp3Wmx3Vmh2Yk5HY0VS?=
 =?utf-8?B?VSsvUGVYV2lETTAzMngxYlhLY0dLN3JjNHBManVoLzd4K1UzQWx0bU5qY3E5?=
 =?utf-8?B?NlNTZC92aGR4ajUzeEp3WkhvSG1Gd2RzSDNhS2lUeVQ1aHpsdW9aYyt5NXBZ?=
 =?utf-8?B?U2puMXVKRWZoQmFVUkxnaVh0SFFUVlhDWTkxYU5lVWFodjkwQ3U3aFNkM0Y4?=
 =?utf-8?B?VEtybXZLMmxqWHYyelJHSzN6ektwclhxRVVJSWtVUjNiTG1pNEo2V0xVUWsr?=
 =?utf-8?B?RklESnN4QUU1WGh6OFl6eEJXendhZmI2NmEzVWlmMmsvckJ5ekk1RWpqOTl6?=
 =?utf-8?B?TExQZDliOUo4T0xveDNiRHYyTUVuYitUbUx2RWUrVzF6TzlMZWpOSWxBRExj?=
 =?utf-8?B?ZitXNzRyOVdWTWRQOVBoMVNKa2REc0ExZ2g2N1d4SWh1Uzhya043Z1lublcy?=
 =?utf-8?B?U1RhVzQ5cE1KcVZZL2ZSMS9BUVRBRzVLZDBRVUdPejF0KzJSNWxQOHluMWR0?=
 =?utf-8?B?VnI5NDZlejc0YlRkYUZZNldUYXVCUDk4U1FnOEZBQUtpVzN1UGg3V0FCNElj?=
 =?utf-8?B?WGZ4NGlKMVhEV1E1aUlIY3duZ1pxTHJQUzdyY0NTOW5TaWNqRzBOTzZjWWZV?=
 =?utf-8?B?MCt5dXdYR2svZWovdXZmWC81UGk4R0F1Q3hxazNrcjRLRWlqUmN0RWFNeEpk?=
 =?utf-8?B?WkN5M2JMM01YM245U0xMemM1KzcwaERWanBEMGorR0svamRRYm1vMDZzQUxo?=
 =?utf-8?B?K1NDN2p0VUN5ODVZcE1DSmFWQ0I3YUsyM0lsUCtBT3Z5bXlVZXNjR2svQVkv?=
 =?utf-8?B?TmFSK0RCZzIreE9zeUN4ZTRBYktNY2JYT2dtZERPcCtreSt5TlFNUk5TcDVh?=
 =?utf-8?B?ZTV1OWxlUUxaMEJrUHZaRnRGMzY2ZUZHVXlpMWx6UElQL3pONTlVQ0t5ZURp?=
 =?utf-8?B?ZSt6SmRDVHNiR1Y1elkwcEs3ZkZTaXdaWllYNDFMVkhpK1ZYQ3plbGtLcmNB?=
 =?utf-8?B?YjAxaUp1aXpMRFhqejFTMzdsaGJUa1FJekFZSFNYZHR6SEVuakVnYUtqTUZE?=
 =?utf-8?B?OE9vR1FZaFJnZXZzdi8rNUFiSzRaNE8xWVM0Y3o1NjQvdjJKUUpPamo5dmZl?=
 =?utf-8?B?TXpVRkdYMnE3bjkvU2lKb216Nno1cDlXOUhUMWxNNjBmbWVJOXdkMERSRlZG?=
 =?utf-8?B?WG1oc1V3RXh2bS84MVE5SXJIMUdRejQrQVRIazBEZTN2VWUzeU1QUFN1Qlc0?=
 =?utf-8?B?N2hMbXh3VTFsWVpVSkFUcGZxNGhJTjhsZmxQcTdEV3ZaV2JMWlBOa0Y3VGlJ?=
 =?utf-8?B?c1c0VzFjc0V3NGd3MmQzeE9xWDYySlkvcTh6M1JLWVFxSE5xdCtCbk92OStt?=
 =?utf-8?B?Tm1mQVo4UWdCUzRTWGVFMlpzVG9JMEdjSDBGUmhGUUphTHp2aytZb05zd0R3?=
 =?utf-8?B?K1Y3ak94NlNUODFhYm13Q3ltbFpyUWpSQUN4YVdQNWdmVjYzTVFTNnBPcDI4?=
 =?utf-8?B?eVFIR0RoNlFxTlR5YlFDdFJrNkF2TlJ0ME1rUWVtdGxpallzeFFWUGdna0Iz?=
 =?utf-8?B?SDk4bFcxSW9EaVJIaG5DL3dPRmJNTnU0TkRHelNiQ2RPQ1YwdXhKb2s3MFR5?=
 =?utf-8?B?WlZHeDFTaTZnNWkwRkg4NUtwUjJ6Ujh4RTF0dkMxcDNKZDM4a1RTNXhnajhH?=
 =?utf-8?B?LzBoKzRVWVdicWdCVnZGVzUwUy83Ny9ITXdYZzhjVmdyRDE2WERraXhySFU3?=
 =?utf-8?B?NTAvVEFBYkNnUWV0WlBRbVA4ZGdaT0k1dm9MZ05XZ1JTQjBydzNIUi9Cc3d1?=
 =?utf-8?B?Tm9vbFMvUWgrdFVTN1E5cHkwbkhxSjNmSm9udG5NUXJ2ZEZHdnBBaklGQWNl?=
 =?utf-8?B?Qmd2RTlZQVZuc3NTWlg2dDR4dVZHeW9Bb2NYdmR6TmsyTlR0TnlRQnY4ejRF?=
 =?utf-8?B?anZjUmVRMFBuZDU5VGRrcjhyQ1FkazRFZ2tycU11d3VDS0hwc1RnS2VTd25P?=
 =?utf-8?B?NFFaNURWaVRkRlVhM2ZIWm1paDNqZ05uLzI0QUg0SFh6MmJrakljUHJCcVB4?=
 =?utf-8?B?czBua3RjN1lzQk9DZTBSdXlRazhtZzVZUzlsZW1tOGdqeDFZa3dvV1d0U05w?=
 =?utf-8?Q?fA8o=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8001d618-b3b4-48c9-c9d1-08dbe634ef1d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 23:45:23.1281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvdQ6zhRd6GTp4TvRpAp6J2N+GQ+d8/M5MGw/BPsWmVUfXFeLy2MOI+Ad6HXamM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am leaving SUSE so the current email address <clin@suse.com> will be
disabled soon. <chester62515@gmail.com> will be my new address for handling
emails, patches and pull requests from upstream and communities.

Cc: Chester Lin <chester62515@gmail.com>
Cc: NXP S32 Linux Team <s32@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Andreas Färber <afaerber@suse.de>
Cc: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c9f868e13b6..84de6a1793c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2535,7 +2535,7 @@ F:	drivers/*/*/*wpcm*
 F:	drivers/*/*wpcm*
 
 ARM/NXP S32G ARCHITECTURE
-M:	Chester Lin <clin@suse.com>
+M:	Chester Lin <chester62515@gmail.com>
 R:	Andreas Färber <afaerber@suse.de>
 R:	Matthias Brugger <mbrugger@suse.com>
 R:	NXP S32 Linux Team <s32@nxp.com>
-- 
2.40.0

