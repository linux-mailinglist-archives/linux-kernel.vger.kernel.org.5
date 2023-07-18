Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9935757FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjGROnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjGROnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:43:23 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E261705;
        Tue, 18 Jul 2023 07:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jg4Mcr1Km66iJDivtydH/+btpo6mEmiOhJ7KW2+C0z4BU1YyIw2OGvgpUH5Qq+QFjfvp8PrF+ieeE4nf5a8ywvuJ/trOSLN1+8izw16Vj5MWyMCDguR1Jfbcc6F5A47zuOrLE2wRFImr6nUYAMTX0oLYqtIheBSePHK6Hy28P6/hDBiHXuqnZT2uj6JiNTLW9HYW6jpICdS7YVTkE0xc8pGxoWgM2mxY3vHx46qZgBL8CpGffeGP54d9S5bEz5oPyMhZiN8xs7MKpi8hJjGk1cnZLtjLrEQMiMYROJRFze5+AAbHRc8EbjfLJtxZy2mYafoAeOZZdyMyPfR6gVNNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53dchQqrB07udqzQvUgySr46of0Kqhl73im9IHKS2II=;
 b=Ij889nR5eIZ7ZS3dU1IdjKsO+j8p08uJMx+WZzSCJdH7i0rqeXhLZUTIHJGiandpaB+hyubFTnHydWBn1diuOr/JGBa4uJNZ23pIrGDozPAImp3VSMvb1Og0EiO0xwvI09+G+tLR7qIVBJO99v68fNCPrZbWa4kXdGHs0ftw7NCJ+yafRJAxyi5UpPzZfPhN/yylkCntauofhYMSTA+Gxd9AKU48SGjEWBddHX2JCJKGaChzpdMavlTumJk+1UojZhh0EY00xEYeXOdZDP5oiyEgpqk+tuJXIbnrsQjXYQWFo8HNuh4lwxLBZO0Pqi81DNzJ/+05h6j79KIVRa6J9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53dchQqrB07udqzQvUgySr46of0Kqhl73im9IHKS2II=;
 b=aLCdC2c6E4SKGVr//HUrWLG9mePbscygwKpEEWdrZtFK7eBQkY3hGmlQh7wbN3v+O3NYrI+/iMW2D98iPkxz//0CynYeWpDRreoodz6bcxqr7kiCTUoyDa0Qkt6ySUaYC4oXIHcm+EhQw/mBJDUybJsPIemZqnI9pJr4hNfecalzQxmmAaEw1sMKn5LKX5FvTyRvWKIgkAD0Xnp2projEDT19Oq5naFnZLgyvD0f+KC5Y5vAOnsNWYWiKcwa/EM878bDzk3xDDAXJellYo24gehdS8dZkTCs4cT1nJ8HYsDU3lYAZm7PcZf20oRP9euoxyh1ad29lO0viw1NHtSm7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GV1PR10MB5913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:43:19 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:43:19 +0000
Date:   Tue, 18 Jul 2023 16:43:08 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lee Jones <lee@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds: default config switch to
 platform switch
Message-ID: <20230718164308.6b7d875a@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZLaf0Cn2kfb0qxJJ@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-3-henning.schild@siemens.com>
        <ZLaf0Cn2kfb0qxJJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:610:59::36) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|GV1PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: f2aec05a-d326-409a-e595-08db879d53d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5/sHsBGYL3rzbfx2dDL9qkrMn5M9HAbTob4CCocNFjprRdi0tzZWwK0noKXmq1kBJZ5Mesif/jP7okoxbKt/pf41jeRTaIHFFD+YzXe9YpewZ0IsOD5323uteiuRHpC08BH6R6RI4YXJP69iMdM1YfOWqNOIPs1z0878wa+xa+V+SCLR9Us8SN4M7+l63C4XAah1gjiN1BU/v1uZTCjKnNcgjBU1ubbwclMiwsq8JoJKJLv/DdzraFo9D2CScL3LqCRFWC8Qb86erQbe4Spn2xenSNdQfcfOmC8YvhVT5GSllRHWElE1vEt07AA5O2suUOiUp2HA++y9/2Sazr7e4VCZN0PbZ4JNl7MYrEQe10MlI5CYop+wpOCuNoziIkopUcJ7h6W/Ea5s0vP6Bfx/iWhGuKge6r2e7lPxRKS8s7rBpOuSDkbiny4+Fl3BWsXoo4VPTvytWsHVr8zMoTuyXjpwVQL5wByM61mmT6ZhOkPgg9xpZWElyr+dJKpGN2ylIxxju+coSfDuRLPHU9U6Y/EKtj6X/ygQfgid088jd1xoOunAW02Qh5ciVKw0bcE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(478600001)(6486002)(6666004)(54906003)(1076003)(186003)(6506007)(6512007)(107886003)(9686003)(2906002)(4744005)(44832011)(4326008)(316002)(6916009)(66946007)(66556008)(41300700001)(7416002)(8676002)(8936002)(5660300002)(82960400001)(38100700002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZdnLbXLb9esC67T/FxQrJ48mJ9TtkWGx5sDgaSNFlqr4rRC1mefd78lodiQb?=
 =?us-ascii?Q?Dw/OxNDyqiaqYK1dyl8/sYBGMKPBZICNhNS+Kggq3gphezNQhungTkqkvC1s?=
 =?us-ascii?Q?C/Z4n1lNK6lkScgptNrTUPSlJItpKgTwK2fEtM9gMUU5zetPOJRTVK4xtWJU?=
 =?us-ascii?Q?HJmGQJRcg9oZPV1wpFxrUCAx/9EYjaVpvgSVllAuF4VVMkjpXMd1aZ6p59uh?=
 =?us-ascii?Q?kOrc/Uhz8gi9Q5GyaNjmCc0mdXvEMI+24OZf2SivY9FLcqkGTQUQOSpASafx?=
 =?us-ascii?Q?mbuEn2g912KwclyNdaV1gWdA24rooTNE3o8CekA4r/UF4qQmcFsX7GrsPviE?=
 =?us-ascii?Q?/TagK60Bibp7zj12hRA87xu0SEiMjJ0Iiq4DoHIyeayGtW4Owa3VfGl3aKpq?=
 =?us-ascii?Q?/C86BNKyc5Df7S3YX3BkXKRmroBK8TycuBi4UL+vPV7asbe4OrVYFXaGylgD?=
 =?us-ascii?Q?bMMeulXerkkzzaudCdtqccqnQKTtMYpDaXeTGqL+AOzxhZYvueYkRrG+6vAd?=
 =?us-ascii?Q?7u0qo17D2dkiRv7Nm9ejtfCb3bSW8W2/OiFpdohZnv7xlP4/A2NI/5elt/yL?=
 =?us-ascii?Q?QL/JHeImE+n90Fbl0/x2jB5Pq7s3GEPNzWZ48NY9xM+ZGSgFUvBNoyWaTsBN?=
 =?us-ascii?Q?RC5OWAU96uD2Gc0v+AVFysrczoRjc1G/e7k3wQqNFYdrilHfoLo+1FFQYGw4?=
 =?us-ascii?Q?yNObrGin2TfeAzs6G4/YkpONwBmgPhx8Y5GGF2wzq1g3g/JivDaH4ueqwD9+?=
 =?us-ascii?Q?vswUAEj2FJ9DPH7PP8RblDwUqOvbeojXqcOpTQ3pzwsX6Zvz0GeMJGidp4sj?=
 =?us-ascii?Q?GCBjN2XJ5EYp9h9s+jG/blJ6kG3mHrpOqIhGwhfG7Lvnvb9BR/cPg3TrHRjm?=
 =?us-ascii?Q?v7T9mBsB697gTrYpMuvQZEUGXEXSTGM1ay2L/E5A6acQ5ddHt61vucGR2e/z?=
 =?us-ascii?Q?ogxTFEwPzkkXZJdxFXOb+I9LLdD+GFlLJJwG9ICc+hvxFG+v8J8r6BBAF/5I?=
 =?us-ascii?Q?2cV5QqJBBIOLwgXLyGPwVMJL7EmtRwgKHDkXNFBkHwoBvaxMTpBQVn1q5k5t?=
 =?us-ascii?Q?MhIAEyT+CwvNVxOQMqcAvZ7ZpXY1QWfVKUBeF8ntEIoPZG5SeG6xckQarvr7?=
 =?us-ascii?Q?sTmQR4Q8g2GtIbva6KZ6KNmt0zkEGNzuMA7FCtaWhXJGcideT+dEER3z6GhL?=
 =?us-ascii?Q?8Yxqw613ON/2bD1k2Y+iZAZco6R2H2AztTph/EJU0OnXN9SFi1t3J72ktAFC?=
 =?us-ascii?Q?vruIIQjPPvb3b2I8I9+5J9KBF2UUQ+ILMmRvOulMAyzEdJ93k0bGCCt0Rzqe?=
 =?us-ascii?Q?qVhFcfxXAjA6vlwpyrqI5dya2VCC9wHiWc3Q5bMtcqOVNTdGhC3ZutwO272p?=
 =?us-ascii?Q?x6gq4Y6jFsE231EkbkXzRkMlAKWFnayCkx2BxQS1KQuDgmXp1cBb+6bKluKO?=
 =?us-ascii?Q?s+53JgO9savg1sHbsZZOsPHz7aPhgavfiRwQJQTrcR86vtlpD3RNC4KlMu40?=
 =?us-ascii?Q?fcfyb0ZADASwLHSNERBbNFsb+w+NHegqnxrM2QXGC3NvtXZhS6l1G04LxKd1?=
 =?us-ascii?Q?8MpZPFuKoL17P3O2vVPxuGVv9CzdSFF4ov5+2F9ZmvVAbo4y7BKUYdD4c3TV?=
 =?us-ascii?Q?7dJ1U9MIkOw2hrrZjCooeCMMo2NE9+TeRGTIXDEdFpYU8A51w2lzxaHov7Sp?=
 =?us-ascii?Q?gLl1bw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2aec05a-d326-409a-e595-08db879d53d8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:43:19.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqTNBHN96Mjhuvv2sJSHN5uoBHvlJgq63RxMT23phfg3WAOvlMUwvqcLRraoBvXuJYqEQ2+u/DLKzpPAA4olcIIlQEPxh3EYsfx61u1PbTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB5913
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 18 Jul 2023 17:21:04 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Tue, Jul 18, 2023 at 12:52:12PM +0200, Henning Schild wrote:
> > If a user did choose to enable Siemens Simatic platform support they
> > likely want the LED drivers to be enabled without having to flip
> > more config switches. So we make the LED drivers config switch
> > default to the platform driver switches value.  
> 
> Same as per previous patch.
> 

Same as per previous patch.
