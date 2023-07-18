Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E069F758002
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjGROrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 10:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjGROrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:47:43 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36550EC;
        Tue, 18 Jul 2023 07:47:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6LP2Nd1bcyDnbYXyuJnjB0OsAB79HuQAQ2XS9j/hFVP4MV68oPxFu+XbFQU/fs43fznSRd3hvnfESK//eD6DLWLiB7A+Kj7DomoeWZ4Q7cQZtwXdttow0jqjbAephqXkn/QsKJXQOb5boNsnCySFxZCeNTl32y2/a1oMbIhHkkOz9VhEcQ0zI9MOYzwZXBMiJHTyLav7sNZDKhuC69R0nniUCeUYXjByNZKejrpPrqgB/BKaMR6798yAnnhQBIVMzeWYYaJOnH/4AxpoczbPHQOVVPsm2aur/xHpQA+7cEmucLKgR8xpSRCD2JkHNBIfhC2iPgDSqknEasXDlwrdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Sm0jVsmNt870YUu53mss9e9b/bJqAbyiLG7ear2pQs=;
 b=Q0cD2Wfd0JuKVVDw9285Ze891R8qyy//znNe1CD4+1OHFnBycmY5RxkPPTBmKeZTEjexpzRWSdGBRxXRsq6mmxSw+GrodYZr/RzBADgkjdVsSzNPQxmRT606x2wx2qR52ezKSviwrAo0FitmtrZgt0IYNI1I6OBPUmgW8v46c2yZyK6QwTSr7DrKszL8vu7Q84GrPCgRAfhKu4ac7+KJa2G18GArT8V9Notz1uUZjINErPVmYqwo9aVgPIMB4/HMSz2oktGIGaUJ+9XqVJrPOOPQIVCLZWT/jplhcmhvhV67m8lzFDUXDWIpOf2hS4mWmbvDVPoZgec0Qi9/RZJU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Sm0jVsmNt870YUu53mss9e9b/bJqAbyiLG7ear2pQs=;
 b=bcemxl/qIgBCnQSZO9yqpAX/xawWweq4whxRPHyeZ3zUagy8wqei+CLfiQd526q2Qm+I5Wqn5TouI/Q6K1g6EzQgww5TNcekfJWx+cWmguPAYbh4RNCJC9P4fa7qbTvKQ7XViADEkVhIQ+toOXbYNVWJh7BqzS8OczYTZ2VknW16ILqQKfXqtPoRNSOoLOFMkV5CKjBmt0gX3PXbY0MokC0PARA6zr7iFTO0NXCOr9iDLL0lEbhO0QGXxrNqfcYbJgKfmKoZrA7ASWQmcv3xatgc5B6IXKPODuby+Eaq9QbIZkObi4Q9cO2Y9MwCOZcHiMSMmJUzSV55hrm4tiNosg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by VI1PR10MB7909.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 14:47:37 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 14:47:37 +0000
Date:   Tue, 18 Jul 2023 16:47:27 +0200
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
Subject: Re: [PATCH 3/3] platform/x86: Move all simatic ipc drivers to the
 subdirectory siemens
Message-ID: <20230718164727.6a89e3da@md1za8fc.ad001.siemens.net>
In-Reply-To: <ZLagYgJT4cz4jZ5r@smile.fi.intel.com>
References: <20230718105213.1275-1-henning.schild@siemens.com>
        <20230718105213.1275-4-henning.schild@siemens.com>
        <ZLagYgJT4cz4jZ5r@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0031.namprd13.prod.outlook.com
 (2603:10b6:610:b2::6) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|VI1PR10MB7909:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b2af034-8376-4bb9-86a9-08db879dedae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uw64/MxOUMeuX2/0Qbj/y3p1QT/pbu7TKtMiWVzskyoYqSB8LjiqMeprw8f0R55Iqf3jpymNWepLDfyex5Bi18dhnoi3ckjkiNQ/IxSBtq63jNJv4EaZI39oVG7egCupyCA235TdqS0Dhrmiw0eXFDOkIXNRPryRGBnrJtfwYVQk0rw53mSmmhEvCXH5QoE3gJBpLgxmT6iariHMD4ANPVo1MMXB2iXH4RtHP0ate2Gr1WTLDT8gpG22QMP9b0P9SfTnJgkK7Db67iISWV4ExB9mVI/lSxnPwpyRWTBo956iXox6r4VdmcAqYHd/LY15Nxm5XyAXGA+DgPWHVU4frsAnQ8F/j8g0PDlSyCdagF7T4dKzWJUbTaUk6+APRMpcv6ww0ltZ4FTW05My1Nct7XHdW/IThCUvR5OALT6HqK9p5xwmQfKxSJoKm0rbSv78+copGnjXqCP3+zBKcZ4THl5/OBtxULHtJbWvq9YP/3jqtKB3WYHJg766VO3GKFuO18v8fky033+TSb6Qe6J/s1lmExxcs2OtrKnekGpoZnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(451199021)(966005)(2906002)(9686003)(107886003)(6512007)(6506007)(82960400001)(6916009)(8676002)(316002)(5660300002)(8936002)(4326008)(44832011)(41300700001)(7416002)(38100700002)(6666004)(66946007)(54906003)(66476007)(66556008)(1076003)(478600001)(83380400001)(86362001)(6486002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wzoJzuOBvfzHhfoJnLD6GtnWXXb7fc3d9irQKJC0iiLAM300MzP4wwEoPcLw?=
 =?us-ascii?Q?uG483entzeVyDDrzvyG9ZxqZZONegY6FHmCGhEUyXEa1hWSCmZHofGXKp9UF?=
 =?us-ascii?Q?Gl1kTeLl6qzATL5UGjmu8AmtUvTrsNC8xg3YOWEsVwGEZPvEnjQ/rScWvS86?=
 =?us-ascii?Q?pvoepoiiverE52k/fromLYifsH7csZ57Ofn/SgQhb4+WHoKPQcVSg0gN81kU?=
 =?us-ascii?Q?kPEY1YFbx66nQn12MLVqUiln/yai4XNuKt2+5rxt1+oclkbPuGycYiBtWOjU?=
 =?us-ascii?Q?gaQ7nHWO8NfsPAlVspwpOHKrZEtvIDhqz2V1r97xfifApkBlm73+04x7LFNF?=
 =?us-ascii?Q?cQ94PIMZOpCV4iHWt0F66GALQFcuZQsvkjJz3HUNrCYpIKdxkzC3+Fq5WERs?=
 =?us-ascii?Q?+ZQx1HBDmKLZREGrLOXtFSM0X7/TnPjTsFkpUrjhUrHWDWv7ToJkToCbkJjf?=
 =?us-ascii?Q?bizBBy/oMHA68c9iBQ9lhLb0obCFplZsKFmMfLJ2wLHUXOLizoTza3TjYjq+?=
 =?us-ascii?Q?JjocQo3De27Gs9dsM5HiA5FgOAglaFp6dLERtDE/tNq+HD38Fp+nSx2bR/I6?=
 =?us-ascii?Q?eUenuoc8d7ZShYcDUK0GJRIuFWCi9C0yWGiKYhuV5IvZslo5JZrKbjCeFQUF?=
 =?us-ascii?Q?vFtItVQ1wVkfFRBj5A1KLoUDf+moSCsff6z44p8tOZwSjuegLevMVXpPtVqs?=
 =?us-ascii?Q?yLjfbgS/TNDvXoWseWODfDDxQOegbO6sWaSVe2wSv2JkTGoJA4Ouk1/JKTtY?=
 =?us-ascii?Q?AksQyz0m/WFso+OslcWVx8Ikpa9O2hB7wKseHsNU//x+ShR8obO2vyNwGzJ8?=
 =?us-ascii?Q?Dvv+uPJdQ8yiT50L83DwM7vLn5kx7zCmv+kglLYz2QjGbc00TPJdKcdPn3Ls?=
 =?us-ascii?Q?5jbmewcefYBaOMMudc9rT7vpV6sLntLA1aGusmMtwYSMDWMVreHV7lMa8uqD?=
 =?us-ascii?Q?jFLk+ss85bcuEwhVvm4z2q/55nWLGOzXJGWxtS9NVFTLUxbszlQ333WOGVYT?=
 =?us-ascii?Q?4LDfqvqM5TV/Ld2ITzg/DY0fD0LvFZP2k2DTpRjO6Davm7/L+XSpi9ONdAN6?=
 =?us-ascii?Q?nRZ+l+dnQBvVl3OKWqOdptK4g2krn4Q0FdtcVSV7cSIFYuEor1qYEB7Lil+5?=
 =?us-ascii?Q?eO0NLko2TU/JMpzPHGA11T/6QuLazWIVIJ75G4Xdom3QsZntGfQN6NXDS/Bk?=
 =?us-ascii?Q?lQeIfek2GX+sejpWrCkJoYzaXwLJLRr6J66Sa57mrokhQy13uJ/Rmd2f5i/K?=
 =?us-ascii?Q?Fe1gIy1Yyny0Bdhtuebky/rxmbbr0evKuNjV5kA9hfIL4RsVc15NrIn6wuCB?=
 =?us-ascii?Q?WdqOT/yPHsatp/SpF3YoOl3y8YMbMYd6rN4Af1jwB/vabMywDoWDz0HauMXc?=
 =?us-ascii?Q?qiF9iusuWFNA8jF+IY9oymGM8D9ruXv9Wf3ngnkQ8aUNNnRhOSqzOsRz120H?=
 =?us-ascii?Q?vHunUsUe7oKCLlVRn+c0UxZimh8+8IZtrpawumr3M/KBzTi1OZNrnidffist?=
 =?us-ascii?Q?ltLlH9Vent3gdiX4APjeGJiwwx/Rm2Cqs4l5QxT9VQywfRkF4X2RzEZ4d9dz?=
 =?us-ascii?Q?a92ICnj8ohLymonAQkbPu9ynEQYd7pa7+NJTXw52VFMQPIueH9fIwf2GnkZy?=
 =?us-ascii?Q?DeaKFS6ZQB6wSvIplTZE4n7BRJ4d10aFtkP5fS78RxVPTAFoJIVjhd9keqq8?=
 =?us-ascii?Q?Q8H17A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b2af034-8376-4bb9-86a9-08db879dedae
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 14:47:37.2887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yejYs4eKLVoCVCC5WfV80e/M8sqD8Ol1wXl8Z+ZKXQReNlFbtXM4M0LkRpsRdZYh8SRCyET1n+I3oGOlp6Zt8UpB5CoNTZZ5IbxSOmzzTLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7909
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

Am Tue, 18 Jul 2023 17:23:30 +0300
schrieb Andy Shevchenko <andriy.shevchenko@linux.intel.com>:

> On Tue, Jul 18, 2023 at 12:52:13PM +0200, Henning Schild wrote:
> > Users without a Siemens Simatic IPC will not care about any of these
> > drivers. Users who do care can enable the submenu and all drivers
> > behind it will be enabled.  
> 
> ...
> 
> >  # Siemens Simatic Industrial PCs
> > +obj-$(CONFIG_X86_PLATFORM_DRIVERS_SIEMENS)		+=
> > siemens/  
> 
> Do you need conditional here? We have stumbled over similar for
> entire intel subfolder, it might affect the rest as well when you
> don't expect it.
> 
> obj-y		+= siemens/
> 
> ?
> 

It was requested to be done like that by Hans, he wanted me to do a
similar thing that
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f1e1ea516721d1ea0b21327ff9e6cb2c2bb86e28
is doing.

And that is what i did. If there was a y ... the whole "one switch to
rule them all" story would not work out anymore.

Thanks for the review though.

Henning
