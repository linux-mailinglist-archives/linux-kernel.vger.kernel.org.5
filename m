Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6307F264D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjKUHZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjKUHZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:25:45 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36447F4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:25:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWlfSpCoY5//UgGdN1nm6iS6qsZFEykvu2S2K5Lc0hy/5dZ+zKpMeG1I8dfBt3C21wG+lBhE51Ch87P/t3AJFvFMVKoWYuP9bh88xAxNO2xNCL3uK7F7WumOV24KB2VBKcTifd+bh69ypnMGwA/pMpzgSdbMBWQBbPMruhtKGBMROcXux2Bb8LGufuPsYisBeJPCshPDI/BjcPDfGeVQU2e+Ge/GEq+SfZ4EGWiPKlIPNHq8pcvMJrDG4jITeIz/0dbdlA9wZQwHG9yrwZkFIBIc2ny1wLOSodl9xieZBBoix/WPLFRbYguIcItOT2waKSYPnTEXWO4cUnWp5kxZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nexh/6Calg80/7agKbqCHjIrxJMUujUxAUv1wlDcxgU=;
 b=l7SA/I+7fg0m9kAzCTYd9jGGNATak8yik0Kj097jqVpLNIVeREcSHbFKiCjdmi/hTzkc/ZNthgiw2p6c4Ay9kuk87gtSypKfJ34rste3fKrNMpVrMAy5UVi6dwwbIoIf2OWX4CkP4prUHWUD4DvNYzvtdEkBDBI/fMGlYI7Z6CsdgiV5phP/6n18aVv2jGDkx//YoxSPJ9jWjr7K6AymlxqxbUrp7lxH6Y+cY9V8JopvyLWq6c/JunAH8pgEHuIRK30v8qEuaQ/TN0fvDTHK7uSWYzCkOSTYKQ5m45Ngg3hjAr9Fz7S46K8OxAmGYADi268AiQRn7eMWHFCTU77/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nexh/6Calg80/7agKbqCHjIrxJMUujUxAUv1wlDcxgU=;
 b=s+aHe8S+P4yAZwvjzFW/y/NXSar5TN+MocTzK8jqlVdWScExXKO963jtjhJY46rQhz32Eo1cQimZEev02DVHTE+G0CaUzb5fCxc4izU520BABqiCdxuuAQjCDW5fyOJLe5fJ+P7W7FsiZQzEv+3YtpylkfaMbXVPaLsMlPesBFMxFMaSId4JS+4aBPq+a0vnofh3vnYUDb/L5iWUPmLQEW2W/80BwpIVnS6NqETCjQ2dXikf9EDhaL54Zy7elA0qEoD5PqQLAOXE2FuDiob5MR0YjYvjMoNdFBQ1oWMkXh8Ob3EahoLWARshMQO8kzBUPFKLazF1/bw7jdr7434CaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9134.namprd12.prod.outlook.com (2603:10b6:408:180::21)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 07:25:35 +0000
Received: from LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::46b5:b4c0:3712:504]) by LV8PR12MB9134.namprd12.prod.outlook.com
 ([fe80::46b5:b4c0:3712:504%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 07:25:35 +0000
Date:   Mon, 20 Nov 2023 23:25:31 -0800
From:   Saeed Mahameed <saeedm@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <ZVxba6KqmPKLuZGO@x130>
References: <20231119092450.164996-1-saeed@kernel.org>
 <20231119092450.164996-3-saeed@kernel.org>
 <2023111956-strangle-pantyhose-0814@gregkh>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2023111956-strangle-pantyhose-0814@gregkh>
X-ClientProxiedBy: PH0PR07CA0065.namprd07.prod.outlook.com
 (2603:10b6:510:f::10) To LV8PR12MB9134.namprd12.prod.outlook.com
 (2603:10b6:408:180::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9134:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 225d7891-2a6c-4618-527a-08dbea630c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d93uVkWN8xq+Ln9XbEQNcoZBcgUZQFgfXUDxEiC4vrifWEXSKBgdSw8WDA3K8OQojI+AFsdeUGoewmw3q+wKQStK6IFqGVlq1ePk4jQl9EBQ5b3JfqowuDPmN1hswQX160joVuWQVscAQkANdan5/lIJUV4BU4KBOElP1Jf5IFPsTfJMVW7XOIQ7fTcpO4psPKG+a9mU2oTc7S4fN3aqfAQg+SBAKnaqxpp9NdjdjmUV/US8LktAHq2UFmp88nUiEk+GdyqdkrpjP1F1a8tqVntOPC5XoWxQr8u9+gJhKb0H1M2+yIDttnkXDYjBgXI3nEqnDUJkIpFVTSv4couG7MCyHIwll69npVQiJVYIp8VACHm8QdUeDFieqOLrnB99XIIEmYtUJOOpcNeq38E6TZsjihDKwNLf/uEXCrFyK6VJNHOLDlpW7uruABi/o46A0+8NT2F+xqn/4xNFw4y7fybLWNy38qLnrISrs2OQDcIi2bxGhqqa11QzKmWjc/P4so1aSLtt8+B1hqUTmfPMrwbvlvsFgtUdUAlllHlq0l4ftUb3lNzSAusSK3Rmhft/vUuRO6HtZ2ZHi/ECwfXuDa5nuuH99uDD9T6iOIkyW9JNWz2c+7VesYDb8VSu19+67W/A3OnrG0E+/kz7mts31IDDFUgxP6CzdQ1c7NzGXqwzc89shaSAuthE1a0V8GyL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9134.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(396003)(366004)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(9686003)(6512007)(26005)(33716001)(38100700002)(4326008)(8676002)(8936002)(41300700001)(2906002)(5660300002)(478600001)(6486002)(6506007)(6666004)(6916009)(66476007)(66556008)(66946007)(54906003)(316002)(558084003)(86362001)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z6Wy03VzDZQUI1i28YYyfEvxZd8rQDJJK6HlzNxZu54yfqjbtCaxTdKGgwWU?=
 =?us-ascii?Q?FAFDSAgTntT52+m19avmT8PFah3R+LND+8T/lews7TMi4HGOtb169tm164ov?=
 =?us-ascii?Q?UydNrwwwWP1Ltr2mKpR8FtVvB2GLgBNMWbV+flaMiIYDvivzy/l7ngSDou4K?=
 =?us-ascii?Q?Y/eBk5O6ozYhtSA74s1y7eOtNlWOAPfOLv/UfTbvqFfOkKy2alcV7Ks2bgjf?=
 =?us-ascii?Q?S/soPhvFrzuAjZTYzoENiCNw0CsADJJXUVoXaMsdKUclkcDznTizv0HCa7l3?=
 =?us-ascii?Q?zxt/VdyLz8FJ7p5pDImHMNt/Zaa+qXyQiro9knzyOkdgjmrGNWCaJ+eqfNmI?=
 =?us-ascii?Q?CbaPrU1EcWyhwJAL5/V8IsYpGYremW943sN684XqOiagwYwai3XO8w5pbZgY?=
 =?us-ascii?Q?6Xqucn4Tj2zSAie7frJ93x/dRn8Kq/W5TKeV0ll4VJSytWc2DJGR9o4s3K9R?=
 =?us-ascii?Q?aIL8tRzB7Ki8bdHC7BwffcAFMPRJLsc3V9y5xc1Sg674TIgsILsxT/zDagMO?=
 =?us-ascii?Q?skOXrelYluS30P66NHmUjbCuoaVONyfxQlxh4J9rWdfy8X9ONaJWwHOxU2gN?=
 =?us-ascii?Q?SnRxIm2Qqti4vSNaid9ym38PhN7LJWLfm5twNc+jHfUYfEneQjud1a2vH+bi?=
 =?us-ascii?Q?huZTaTZLx4A9ZMRigrPb8oVmNFr5/QgIg2IWvEtsncbt7SqeRw6Yj3liRpDI?=
 =?us-ascii?Q?hnXYmC/Hhp8SiSt/dTIY5aTQUWeY6oUxnRuHvvxnOvP1/Y4KZyqLxVWggczz?=
 =?us-ascii?Q?k2Dz+Cd2+L7O2qgeB2m5aPZoN0kKg8O6hMfLKIRKEzKhXuuyCwoKZZemdl2L?=
 =?us-ascii?Q?rRphGXKr1fkPNbpuZGKLh7gXTDmK41Bf6j7tZuwQge3HnLN4YmmUmIeSlYSy?=
 =?us-ascii?Q?CTCeSbdr0XRWkMZOV1v+lfqbtSOJSXDFMz2rt+F5XECI42beNMn3f7vp7FdM?=
 =?us-ascii?Q?H2biMmRX5B0qbAE7cQHOUFB5dm9k9mQ8TvS6Lpaa2+E2TSon8pMCXy9pS0hU?=
 =?us-ascii?Q?u7XzXACVqsNKvEQFaKZx/F3mWeA/KfZM47uZTk+LfCkMIhQfry3NL+YCoDBf?=
 =?us-ascii?Q?NzyhdlYB3lPLOX7EGvXmklBNsa4NLUV9rMdjSRchWLIUR/LCiKaPM0z6AabF?=
 =?us-ascii?Q?RUPpTfOVUJSiHMZO0V6gGIqznYH2dwJ0RsB/9eygSQpcOrKxeGnfV4atZMjI?=
 =?us-ascii?Q?WV77j9PTj+QA2Ok47r0PMfyzYrprVpYVRqgmK1dDbYr3AUjTSqTbqQb7/noI?=
 =?us-ascii?Q?3QLkO1uH7y7tg6aFjCiJE4Urk/DA+fejP4N4ZVjy/w0RnLIA9veYj5t5IDmX?=
 =?us-ascii?Q?j05DppyZ+fba3gUi1aEUm6oYbovgnDHME5pTeo8FLHMurBuX8hW0R7Y9PKqT?=
 =?us-ascii?Q?HvKxwVClytu63lvHx+ZuHqW8M7JvsYyLyPd0kexhakInSQpED+up/TQAe9qR?=
 =?us-ascii?Q?neriysH4abRBkpuQUA3Euuzhp1xKZ2gi0sivSw6MOfAU4mFR0tM+XFzkzDaf?=
 =?us-ascii?Q?YA5QlyN6q/ImgORvA+WzcewyIAjFcgN0ZLRjvXzfdQPM7gfVFGNjEZ0YFoM4?=
 =?us-ascii?Q?vo2BEdtR6J9JWBb7ssCCAYeKuBR4150/FBgGn7Vt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225d7891-2a6c-4618-527a-08dbea630c65
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9134.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:25:33.9936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuWnjKbSe2vZTmGhG21BWXAtxGMTIrEkNj04iiGRuFXYoCZhPLavavxpdVV7Ai8GTOhfjYMAv+aSIGDVjFaLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 10:51, Greg Kroah-Hartman wrote:
>On Sun, Nov 19, 2023 at 01:24:47AM -0800, Saeed Mahameed wrote:
>> igned-off-by: Saeed Mahameed <saeedm@nvidia.com>
>
>Something went wrong here :(

:(, Just sent V3 now, I needed to fix two new kernel robot warnings
anyways.

