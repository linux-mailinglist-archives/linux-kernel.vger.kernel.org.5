Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C22759378
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGSKyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGSKyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:54:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB96C119;
        Wed, 19 Jul 2023 03:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJGpgTQZcyaLqQXgFV+zp0urz0NiAPghB2jQXo+htqxjLN/5xeOrmFY6Ny/BvP5SEFTJmR0WRF94eRkBJ9CqZIza8/ZqHYNP2Qj9xx/0GBD2J0j6tsYDqQ6bS+q7pPs4vmAQlvRt9aAuGJjGoiYot68RV0ImyuUgH+2mndQeqmtqsaiaDWSnCKXezCoxPRNpytwZ5v4Hch6LbHAe3e8rChyFpACcyidwyECT95DSsKZViAsvbjBXKwY48dgNJyTMZonpz/m8Ok6l+zNcQyBpnoSQCPBM5JR3WShQBQ+tQ6YZlyzOpj0I128gq9JrUmqPG0jktTkH/8XNPOv1tZmIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6V2PB0KIpIwIEfNLd+uN+yHmo1WQijznWXoHSnFQHo=;
 b=I6U6Xe4CbQ0flTvXx0n5OvurKESdYWQn72UE/8P9wB/U0K3MoyZalrJSMLFgaG61Ze9Br1EBHdVQeCetfpBOL2yYKIT73PyEwKWmicfkPa63Ok3mykQVRl3Ms6knMa+ok/uOpiKsfq1v1JgBA2eklfYmX5Hu/+6CWyjQ1JFRm65NbJ7TzKTbAgc1CfWQN8j/tuQhaAQtNL/t56J3xfHtEdMlN8juNvm6UtktdqiwqM+geR4pkMnlbtVTf6wn88yH3TnewfpEdpYIl4KKeptcZNtxebm6QX7mFeugAoqG5XruSFb8QwUk9Lar9SB7Lp3XroX/A3a9Tta3ai4EW5Siug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6V2PB0KIpIwIEfNLd+uN+yHmo1WQijznWXoHSnFQHo=;
 b=DNQZit/sRkayVRLjoWCOhwXNW6s1gqdNbiwneNs6EV56tBgaysnKWeYHfinwoK0md5lL6k5MdWMRj0cDmPOOB2MsIFMGIUQXGLl4kWu2GCfO5XC5PcfGScGWzTtNFmGKwjCgkfnaVQ/MTRK6MvufsamVeKfXeJZRju2QCLuqpwHBTwEo+P3zZp9ITou3kUZJPlldtCStj8235bkzbO6+tVtq+frh9EmAa8cxPNb+pJe9FVpbhgaDz0IVak8XxowEe1pgXh1es/2ls3a/GXtrBcu3OEQTwcwruOKXyNL7E7vtypP/SA1SfqrQkHjxeCIVLATIXrpgbDwh8atQOA1vYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB9PR10MB5618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 10:54:07 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 10:54:07 +0000
Date:   Wed, 19 Jul 2023 12:54:03 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH 2/3] leds: simatic-ipc-leds: default config switch to
 platform switch
Message-ID: <20230719125403.61ce47e2@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230719084301.GG1082701@google.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-3-henning.schild@siemens.com>
        <ZLaf0Cn2kfb0qxJJ@smile.fi.intel.com>
        <20230718164308.6b7d875a@md1za8fc.ad001.siemens.net>
        <20230719084301.GG1082701@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0123.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::9) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB9PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 315be135-9610-4606-2b73-08db8846795c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /zjgwvKD/3PsmiJX69dL9bE9iqXDMQdjfX1ZV5pygNjpnSjpCBtvXXKirhjWAytuu2g13XgcGEBnDSB77j7SQe7RtfDaLYH+CZBG7GK4RTu0AQ4iR6aGiQi8Ra643TrU6XZGuHSaYeW0Syg+Z0Sm9l1ViOLcdGQ7JX0AetgKe7AsH05vAm72w+Sx9vtUF/ALpkL52wdzXMk2wUbv3i8VRRn/EFYSBLi04Ug7MDHQiNCU0fMBtR9LXQNtUn/Ug75EYnBWzp/cM1JfHtM4JqJQ7XTKffEQ6ZBBeCE9KgA33QKUXBKW72C4Y3t29Co8TZ0EvoGjOL5AO3Wbm5WT1MayFaphCwn66duftrL8M6gmK1an7yTYZoMDnJ7XzUJEHUW4zS1tV0CN/aapNq7SRt8JRSMV6THHLzXV5CSaWUfohVGmixAks7C5jchxPY1I+3pK+XJg4ua1m6Op95GvvrPs3dD551BXkdVVHcYONXPmUn0jHd2Oh/0CjYdrdLvEGxJ+nQuh5hMf30x/9piAzJ2rVB1CnpIWuZ6WSRCNHxuKX1aX8HcF/O2V4i3ZcGvUJi2e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(83380400001)(82960400001)(478600001)(6666004)(186003)(1076003)(6506007)(6512007)(9686003)(107886003)(8936002)(66556008)(66476007)(8676002)(41300700001)(2906002)(6916009)(316002)(4744005)(4326008)(6486002)(86362001)(38100700002)(54906003)(7416002)(66946007)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o4Kn1UUVpBnnEqnIbatkOsN+CACnBfvsj98tGru5P69UHXLyL4ewtNEYqN4x?=
 =?us-ascii?Q?6Wp2IGbR2C2CtwieMWWjjM2z8OcNADQvdVlo+eQnT8N5Tx9A0+1CVokR6WME?=
 =?us-ascii?Q?5GnkkwPfyFUKNL+4QI3vaDURM2dN+iZOV4H8MFZMqfkpGXPAe4fSBWsNg34+?=
 =?us-ascii?Q?zURYBBGgsdzft1pMHJ3GowQZ5OfVRy/ZLK7U6bnFRsYlLWVynAnGA0iMKNSm?=
 =?us-ascii?Q?kUAer+zXvLvp8ajb5bmTzj6LD20QbOtRraVNngZ5SUyihALvESAam6g8KC4Q?=
 =?us-ascii?Q?ufscF2W6xWc/olXWNg0erLbhtH8EnLJQPT/zWXf7aQN3LAUFUtcgX3n3pgr0?=
 =?us-ascii?Q?0rJJcDhplfyHU9hb722k+Ko/s6hjT0M5FCtnmL26nBySZjF5aGU1E4e4aunJ?=
 =?us-ascii?Q?kA3DCCfmiH1lUKZKn4G0majkjV1EBr9NOVjIXLdfGY0RTVQ+8Koa1Ki5vkSc?=
 =?us-ascii?Q?rfXFfONKjVnpZqP6NDzn48HzoZxJa3fKVEaYv+sBfUredaGfxPBHq+QaOAxM?=
 =?us-ascii?Q?8HukABxI++Elv+Vq7mzbdFPY7rEl9zHEVxsgca0Cpz64YwuqQWKFbmGNmItm?=
 =?us-ascii?Q?ild33z9KDXbvmJPHGFUPCXw2ugcxw5Hf1C6gTs+Iskond6baBWCiKtEjcUDI?=
 =?us-ascii?Q?r5kjMuINfXU5QN13LNF16QFeDS898j3IXdFYftQIrij2CE5Wp+fE6WQX4LHV?=
 =?us-ascii?Q?q3dWtK9OhpMrsDeoNe6D0kh5ewtWL4kb2Da9uWHddGFUUcXagtC2Pir+AmdV?=
 =?us-ascii?Q?7ngoXcPTyMK5d3CpW2ksPdbP4HzNHKtkhM21xvHb6jtGvySRNT1CeR6bI7zY?=
 =?us-ascii?Q?IyIWhWt6VOChPPCUXWlq+OYOKaFBudJUfTeqBGOy+JVJmpRqRfTnElDuRKDo?=
 =?us-ascii?Q?dA5ufJYQn1248sD4+ZZHlq8t+WDSYhALeY4CQhjA4IQF1Wm2w1FQ6LhAzZ0/?=
 =?us-ascii?Q?eq2fPXqRqd1WW5rvDnWfIaMm7d7CUnPCDftBxuMiyVl2XIQCYWVg48qHM14g?=
 =?us-ascii?Q?Ta1aB0jqTQoE5tX+tqDj/r1YCc5YjkdtZpJ/SgzRmY00uWK9lebjQTifxRBv?=
 =?us-ascii?Q?zpxsJkjD+1UP0a4qOx5961dIt6EGlIPuLPrL4+JsxvwUMgp4OFstjn9Z3m4v?=
 =?us-ascii?Q?3bnHS1pcxhHd9uSsMyP9NibCSa4kqnzMUN9MzkDusY4/iYZWkB0HQoxYXM2A?=
 =?us-ascii?Q?cdjIanLvIkmP4dbXLfpkHS1vPLjKpDLwW2qrT3TsO2URjSgICpM8NXyszidK?=
 =?us-ascii?Q?gINTHBqtVTHTykr9muK47fF906XCCO6Mack8lqVmcLwcpYJs/6PT+M7NYutk?=
 =?us-ascii?Q?wXR4Tjn9RVgROAb/k9oJnRl3S9Ldvc9L2T2wGdbrh+IpcD3LpVvMrSH5fGr1?=
 =?us-ascii?Q?i/aUnsgHXhudmU+WUaEDsWsj8zIzOz41lszdWApA4dvieThM8CkDKZDBktzi?=
 =?us-ascii?Q?eqPsoNl8q4Imgpm7dlZRhf1hdtyv3qnIDplxO+PJj+4fh501SqqKfL1WoFNr?=
 =?us-ascii?Q?SZFGqCBHPaE1+zhapO+gPxGVduP8WQFD1oxymiwJkLMfCttUhKm5LVIVRQGB?=
 =?us-ascii?Q?jBJjM0rA9/+0YvuAY1MDcNOWHLWNXvFgkBw+7HI3IOo9y2g7RFW73sky/auX?=
 =?us-ascii?Q?MmavqZ84Ci12+f8sTragZyYhOB0I3fhztch4QXD7ils9RzwEoTAAQmms554N?=
 =?us-ascii?Q?JszJyg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315be135-9610-4606-2b73-08db8846795c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 10:54:07.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYUaFFQMCmssE2epWZidB5JN5e9BpM9tHL3X7le4DZu1X4FF+/s7QBTWt/xqYXNUacg13753gxrnhkzx9KBxDFincRB5e15Z5tbR4am5yk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5618
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

Am Wed, 19 Jul 2023 09:43:01 +0100
schrieb Lee Jones <lee@kernel.org>:

> On Tue, 18 Jul 2023, Henning Schild wrote:
> 
> > Am Tue, 18 Jul 2023 17:21:04 +0300
> > schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> >   
> > > On Tue, Jul 18, 2023 at 12:52:12PM +0200, Henning Schild wrote:  
> > > > If a user did choose to enable Siemens Simatic platform support
> > > > they likely want the LED drivers to be enabled without having
> > > > to flip more config switches. So we make the LED drivers config
> > > > switch default to the platform driver switches value.    
> > > 
> > > Same as per previous patch.
> > >   
> > 
> > Same as per previous patch.  
> 
> Same as per previous patch.
> 

I will assume that you are asking me to "default y", as discussed on
that other patch. And will send a v2 accordingly.

In case the ordering of default, depends etc matters to you, please say
so.

Henning
