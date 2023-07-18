Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3614B757FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjGROnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjGROnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:43:03 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE8FD;
        Tue, 18 Jul 2023 07:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gr7hHdqcU/RgtQ+ifVaF+f3zXrtjrVvfjb1FPYUTBKLEqYxrJJHYWBk1mtm6SaN48O9EEZdSiRUfwoa8bOweDh4Uh0bAUGK6e49thodmDecjXGLzTT5OnDGrfswM1ZB3E1lf0u9xsw1Vj1cmq6bz0gLA9h4c6tH2XvXgPw+D1abhbmXMvV+Z8h3kvxiEX57K7jY5AVICXe9qlXrrfTRtf8vZQ9Q4PaoT7gOX5/YaFTkw/0kzfzWlPlCG+8fsWYcE8nS2KGF/4C4CB0jDVfX+uqqiTTAs14f2qaqDDbN48hzMnwnFtOHLUdoIKa6WllW2KBC/q4nB/4BsgJf0pGnRzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5bfo/G+1inUN6ILddBgwpbM44u1JWXpjj/k+URZQGE=;
 b=kLrR/QnN/gEEYSPfwVN5+YkBXNSk3/T5MSB9QQiwrE3QXfk67Qb5oHmL7sO4aHkdQJth7gusXUAKxRqsa3ToGioIrwvHiVG+Fk0JDod3bpXnJfrWmRPsT/K/HqXY8IGgFgvP21Uio1T9WCfD3TATfR3mzagAsOw2dnIRZVATkMkNO1kfTuAvolhbhhLbeK29XE7yFM7zdpm0DEtz8lJDsgJcIUFKIPkGKj8TmK9uyXUE0gYGTIAeS3Roa0+i9Ii/JMLrPNiPSih/iqR4UklhSA28loD+O6KZ8bmwDvOOfw6pNlTNGqTTygREdLdrrwi+u4yhpIWhwDcJjfw8viu8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5bfo/G+1inUN6ILddBgwpbM44u1JWXpjj/k+URZQGE=;
 b=NmRI86Ph5kk0ZqlWay0b6pdBMdfgivkPSqEPJUDodFnrYAsMpAnTSp06cgI4sStcOvuLpNYs+30Ndxa423CRLOOT+2QoG84W+X3oXV3pZ6WIwjjLAsUbjJTi3AVP1pktdhiTxPArjPPAci4kuraH8JzOJEusiRrKv8HtsKscQyhyJOg3s4B7hkgwGbtcO6IcGcP0sMrXFOu5q4Qqry+nLHWS89CQvhC3uFGshLhMgN1dBuBrTvGJg9HcuHnpGA2XWyoDa5AyaQ5JCYmtwgr4brxC0tmrPp0nw0EPT/6n11uTkI+VeaPZ6n3cuoJIlVNOQtOFheMy364mh8xtBGG0xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by GV1PR10MB5913.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:58::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:42:57 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:42:56 +0000
Date:   Tue, 18 Jul 2023 16:42:51 +0200
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
Subject: Re: [PATCH 1/3] watchdog: make Siemens Simatic watchdog driver
 default on platform
Message-ID: <20230718164251.13855c47@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZLafwOPrw+puH+rF@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-2-henning.schild@siemens.com>
        <ZLafwOPrw+puH+rF@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|GV1PR10MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: ef3e3028-af24-4f67-d8b3-08db879d4698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CacBwoscOdQSW55BNlOv8x98gqzRBUuP+pK6El8qVP73OhQSS17LOT0qZT4Y2ZloFXZW8HU+3uHovb21YHIU+NRxBQlNJI986LT3wTPA+y4S/pKGvMav022y82NKWINrCSMLqybR9O2UvSNWeAw4jN5mYI4/RP3urbURl9twxtFCggRj5O+VHkczx/pRCtikZvlAsjN8k/AwmXn6WFjfDPdgZqA1+HwHrDd7kTAzaNXklD56DLq31HmvWzXNB2JK8KTcaLRfnSLAAU9I2iKkIPTSuMqhCqQ4+HUP1b3BtbbfEnmqGV9rAX+ha21WoecGH451/Dg/6COvEjZXOPWo9cwU9reQum4d7Bw/6ly6j75QP9FffAhv3bs7mZ6PoCO2QMdmqTcqvn7c5JUlHVrhulwJWOBrIQk3YX/64LNDljR1q4deJYfUjn1tql/eVBs3hU2Xqg/qsJzmmU1U5zBFhGDrVBrCP2dWhdoKRcudKnEY1yCQUCqMPgNq6ZrE7nD1+WsL3LEwlRqc6lv4AmHhIwbnudFlbev3tg1PlcWy31aKPVJUYBeKkrA6alKCrASh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199021)(478600001)(6486002)(6666004)(54906003)(1076003)(186003)(6506007)(6512007)(107886003)(9686003)(2906002)(4744005)(44832011)(4326008)(316002)(6916009)(66946007)(66556008)(41300700001)(7416002)(8676002)(8936002)(5660300002)(82960400001)(38100700002)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o07JvmlNdhxsshoFhe/gli77C9hnFjzRO35J+3ZzKB3vee0Ui1hLNAK7gnrt?=
 =?us-ascii?Q?gK0ruesPumHGio+EcjqeEPjogkD+YiDjQJolyggKkbsLwKhbBdXqmA4FDQLd?=
 =?us-ascii?Q?gZ3/ZZ10SYChZChY9f1/Aogj6X6wqQ8r+nLMzDOZQesW/n77+D+wF0QNwi9E?=
 =?us-ascii?Q?XD72NQ8Qvn+10IGvwbdH9uGqf8Y3A8K9M809ENiTWBkSFrRMARXMFS4ou04C?=
 =?us-ascii?Q?wI/cxxXwqv+MPtcIWHuexcNHE+ZJvexA/Ogl601Ur4tgJRQowbXWgEdrBsj2?=
 =?us-ascii?Q?AkVgmwlLnLvxDuQT+84BCnuzIk/MIrafPAccdNZ5jCDwFhhFLTsYj98lxAiZ?=
 =?us-ascii?Q?qah0Se0Fz7hHuA+u+sAEsUxrklgYfYkaYxJN9BjzfaeTRN/k+P90vKiociqy?=
 =?us-ascii?Q?HhUTafLVPsJcoHEfd5mgLjXLQTezAn7atVn/WkZhX9yzAc9HeWXLCNLQmo2J?=
 =?us-ascii?Q?Idsjvpe6DEm8c1kwVtX33gGtPlovEVclwYzvxrnrzIoJFB1VSzU8j7Z3gjbR?=
 =?us-ascii?Q?Eah6TMSaqSx1YUlYQuCH/lsiuyustut0EpahOv5s0l0RcWqJGYQ6/e3A/C2Y?=
 =?us-ascii?Q?AoVY6NdfZ3dcgTAK8ZUQr9MQWm8Mv9wNuPw7CFCbTzkyBAWatElqs4EFhztb?=
 =?us-ascii?Q?pUNqCWEFxl/glkJgWRNwTkXq9n5Nub9zPPYxB2KRWjPUXYRiQ0Zetuxy+1Vh?=
 =?us-ascii?Q?pBI1HhgUMZtKAygRC15+8r+u9+LPkNeI7xhxg55L4v11yHecK9uNulsPLx4I?=
 =?us-ascii?Q?VPTKYH9ew8uSx2v5QzcIiJi/dOgnMQrXmyb7EFgyvoFzlhiXm7Ib7VTaQHIB?=
 =?us-ascii?Q?Ixx5aHh45cS4lVeqFnV1ifKMzskMWeqGUKJrAhg7ATm7NV3Ab5HjV0XpY7w9?=
 =?us-ascii?Q?deH7SvkPpcL4yLSWutdnitSlMkfUet2WnomMe32aJ86nGqZhmus5heVEiyWs?=
 =?us-ascii?Q?3SAZVyiV4zL2hGtqB/l/+LTHUbpDuUjSIl4SHz5/tWmiMz5R6oEiN/prwXJp?=
 =?us-ascii?Q?32HAb4J7RnuPgtqTKW9AeDCx+APcz1XEXAAdDI7bJ7TgH6F6EQrKvuX7swqW?=
 =?us-ascii?Q?pY4v6zgWXaL/2BaJbn+CjNhyBXg/4j6SZ4tp49n+RWyhfD0rzGKbR3ck7shV?=
 =?us-ascii?Q?mMOjXX8q8QV+o4pkS8gV/gAE7DbfP8+nhsCLGqth8tv2aCrmumEd1Yhw3TdI?=
 =?us-ascii?Q?SLA4Aa6BK+n3o0rcJG0TuwwqhpqwxL33UTXBPfNxo9WV6zI+Llb7D0G3lIWx?=
 =?us-ascii?Q?mpYBKGl71nTQJU/0ndGw+g6awu3DVvRMalPyh4AgNvWO4CsCKBXZUE8vRXZV?=
 =?us-ascii?Q?I5KwN3ppAJLwx89Puy4dlnv3zkyc+IbKokomHSAmGsT+kCHXCM6gc+BTnOoa?=
 =?us-ascii?Q?zkbuco7Es5lGSNfKQQ+d3eTYSLT675+7QfzETs41ahLrzqX+4V+ifHlLxPcE?=
 =?us-ascii?Q?koRaxa0TtXEEbNCeuJRxXVAhThOvrHwtV6axzhanlSzNQ7dKUKBczz85l0O8?=
 =?us-ascii?Q?L+6ch9COvcJ8qz5bGn2Pa+bTFrNzpTGpeQ57YSw0bYx0Dbtx0ExVTBiCTd/D?=
 =?us-ascii?Q?JN3+curquX3nGqIek0naNSe5puGabxZShWJTMRgssgeXOCnBva5bMg+Pv4Jn?=
 =?us-ascii?Q?RD8IdhDg8X2ibQANtvbLgltynmk2sYWoeLuPMMbZahRbwgTpl+VHRZA8V8Nh?=
 =?us-ascii?Q?fB/ZBQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3e3028-af24-4f67-d8b3-08db879d4698
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:42:56.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFEXqdWCCCYNoDiXNlkL3pMxYGyA25tt9N4W4FhO6h/vsztNnKIOfwCgn2kZohDHm3AwS/rUjGLhpu0ybrd20KBNHm7ON9+CitMq3i2TUMI=
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

Am Tue, 18 Jul 2023 17:20:48 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Tue, Jul 18, 2023 at 12:52:11PM +0200, Henning Schild wrote:
> > If a user did choose to enable Siemens Simatic platform support they
> > likely want that driver to be enabled without having to flip more
> > config switches. So we make the watchdog driver config switch
> > default to the platform driver switches value.  
> 
> A nit-pick below.
> 
> ...
> 
> >  config SIEMENS_SIMATIC_IPC_WDT
> >  	tristate "Siemens Simatic IPC Watchdog"
> >  	depends on SIEMENS_SIMATIC_IPC  
> 
> > +	default SIEMENS_SIMATIC_IPC  
> 
> It's more natural to group tristate and default, vs. depends and
> select.

Will be ignored unless maintainer insists.

Henning

> 
> >  	select WATCHDOG_CORE
> >  	select P2SB  
> 

