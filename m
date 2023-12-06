Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9463E807AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377566AbjLFVzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377510AbjLFVzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:55:45 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E12D42;
        Wed,  6 Dec 2023 13:55:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGp+gdzFRmeQYW26qkTSjCShiLFrRHq0PfDT/qb1YKBB+okNCGWHuPY9QKdJUIhkiLgO++sDlr96rAWz6WJx8ndhOdvFh4v8NI6GLhYv28tfDC4jFXQwaIZJxGRytbYmca9xFAjrJWOhfHKANlDGgzejZyPZ+2xrFVLcMfJHbBNEG9TK5plFDkBb9/Cen2IsRvs4qIiMI/AZiwuatQ6xDltc6Fk2lZN2MjD+UZbTSjf1XL9Ib7BElceGrrfXTK+J6OJY8QSBkVqjspHWkZLRDhuFmcLMcInA5cFv0lFFbTb1btR0/duY6lQIN0EGYOJ1DM5B7S8++a9OIoQ/T7MJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYNaV4gjDoZ5ACHUBh89q0Js+DOxKHV7nGCsahXl7QI=;
 b=YDnjE3iorEYnrT8rz085VWQm1N0XLjVssGUd6HwLqdp11TqF2CZBWvWXRPsgJuECLFWNTat4ImeMW2VYz7OECryuybquIvq4TxO8tu1EGxt06eayely5jF8ixuSEuhEZhOtYD5HgXBh9L0pguTVMj10N82XPiXmVyzx2nQy4BY8H+wrCaJVJCKD9N4bIwkJ+XPyz7eXWgWHE9FdUhb7Fzte0ZNklfTtKKrXKKAHaJXSFZsLv3BIBy4lsu+XttqQw6pxRdG+9sYIkeYEgka/380bAhTVx6D+DSS5/q5Lc8yapFxelaWyAz2/w65zV6BKIwV0ayjGy/Ttmu1PW5aIkQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYNaV4gjDoZ5ACHUBh89q0Js+DOxKHV7nGCsahXl7QI=;
 b=C4GwWdn0kt7uTiP5gIAFY+MTCy6ZwiEdEub3zyc2mrYWgAY3Y1UT0msnelX4TjDPEfg2mSV099fbf5pLKrsm3+W7i72GHJKct5mydEf6tpDigSmOkuiAlMpqRglnSx1BUBFQQOWdNJyq+dBaOGEv+lETOxUE6mf93PhoTyDqB05BzpCAGUf7zLWQ4qTPEbOCsLhZtqGxZ3pYBVT8o1wOb0RnQOmhT9W9InE9qH+RkjEEP87yJsYgnjlvj18BFWMMU0F5GFa48LAGDJG6XbYH4cmYxBk1Yn6QHbBYm0eeCB6I26lzS/S56qmRj1L3J+FD/6hTrQQVH714MA9UCVuSRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ0PR12MB8613.namprd12.prod.outlook.com (2603:10b6:a03:44d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 21:55:48 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 21:55:48 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Input: i8042: Avoid probing if no keyboard and
 mouse are set in quirks
References: <20231206212140.7458-1-mario.limonciello@amd.com>
Date:   Wed, 06 Dec 2023 13:55:42 -0800
In-Reply-To: <20231206212140.7458-1-mario.limonciello@amd.com> (Mario
        Limonciello's message of "Wed, 6 Dec 2023 15:21:39 -0600")
Message-ID: <87il5bgfmp.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ0PR12MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: a90daf43-3bf6-46a5-850d-08dbf6a61af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJW6pxgMZuJXBhnO1p+/M/ulPxK7P9BXKDZd1HGwyC46axL72eddE1u6ytDh0mCoLfHcKAYUHo/RcqKlDUDvQoJSXEG7btJ4UPPiN3K4dOdmhynGyN2OEVuE5E+ymMp4FYtcidZ1IeqDWI7kw1OkGtmvV1Jm7RY60yMxK47UAcQAtZD9nUdqIetWfvVAB18f22uc/27aqfIeSdJsuMFxj345QmOo/R7FMmbmgilXn0uF0yuSV1YgZBzOn90uOYTLY1afvAHgGa3L0l9krpxpJQQtFDHMHHjY/p4px4OTjylwP9G2+i9jItA+pUay80Xv+2BQc5bnhwSEhR6saM7hDkznHa1KcsXYhNAkB5P7PQw9iiRReBH5O6oLF3HO5qNfLN0dxijUlKutucWfzO4t4fhsU7E/WW24+Hp0y6u8IKhTFis9EJYaFq8LGeiVELKJrj2RlCf4U1O8Xr/bba1Cmt0d16jDzqTO7O5jagXYRMme8Wz+lHTAai8/yM2bwHGsr897OUB69VbGonvLdpC427Yo4F0Zv14Rjn68v8Y7S7oWXzfohP/9Ww0F6cxYyy3O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(376002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8936002)(4326008)(4744005)(8676002)(86362001)(36756003)(38100700002)(41300700001)(2906002)(5660300002)(6506007)(6666004)(6486002)(478600001)(26005)(6512007)(2616005)(6916009)(66946007)(66476007)(54906003)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJ4JAj3sJiHKn+x9s1RYgB0Oy/6tDuvzOCmV/UaT06g30hlUQIkqE86BbDSQ?=
 =?us-ascii?Q?07QxONfLyf0BDfRFW00O4fjItQhUtq8AZTNOREavJbVLhe4yTQriykLMEsCa?=
 =?us-ascii?Q?cOXfJnKFzumuHt88iXgMLwL7QXC6Y+iv+WkvQkNHN48xjDSJYpsSoT9YmJPo?=
 =?us-ascii?Q?eZKMsNRw/QHSlQYpzY0iHha+P5kLT7vIQQfmTOaLW0I2aT4ZP/58CRkvVetj?=
 =?us-ascii?Q?jENbzo2I2xmM/yBPHVtvhP2L54Ms0YkO5SaFxr3fN0Y6TWO6GNl5C8RJ49WY?=
 =?us-ascii?Q?56ya0nSgkQS22PEhGVtLdxoMZ/+7zXXmT5tvTaS7XwwEuUOuwKs5hmq86NxR?=
 =?us-ascii?Q?6wtJ9BHHW/R+ZlhN4xx3vTR79MoFiIRZVLd1N6yBcO59LX3+JgWzlj89k+O5?=
 =?us-ascii?Q?wBVUstWv68mEDTkbrvY2Ioxuezcn4gb3lQL6j4R6WolbigP310GJ2zX/2T75?=
 =?us-ascii?Q?mJoAFXwDI49miAGKhNtUUfOhzlxxrserGwmeR7OQC7fjgOZDRHF0iqMzcSwk?=
 =?us-ascii?Q?XhNy6TE+4DAh2pXeZTmqdmCVZyUjwp/GDfgSiIeBmoR/OiyanA9ynITVL1/5?=
 =?us-ascii?Q?Wm1BYfkIqRJnKFlpBzI3L3WLTozEq67ITQpzMtrq2KuyiGJkwfj/mZ85T50z?=
 =?us-ascii?Q?7fuk8e8v2jdlA4Me712bBk8rowREcZHAq31ZB09G0+k1lDpCSS9BSbFb2WuC?=
 =?us-ascii?Q?f0mM/ctjdc8hiersG6v6ToBx1WL1gJlZSXcqOMPq1U+4LAbw57tkZb1C3CLQ?=
 =?us-ascii?Q?5QNgH+JinWhR48Kvm9mE2qbf0IS9VTjg2ZdOK1yLlZ/a05dOtbgfI+qOEwKE?=
 =?us-ascii?Q?1RjaVuoWay6mj2VgQkV2RUM+Ech4GVVy6FvGP1pAzkhlGUtaRnplLjZHQ+b8?=
 =?us-ascii?Q?7y/9hrbKLRFTJuhIKS1UZZyV6PXrp71HXvac5596CbUkfj2HI4vvm09P3Pel?=
 =?us-ascii?Q?yR0vMkzn2fYfBI+R9XR/c2AWvVQNxnjMNlBB1YKuM+shdJNGTpaRGMxsRXgj?=
 =?us-ascii?Q?sEFvjVw2MNepgqlvmXQOZqCqOGiiRsGOAshQw/+Gq+z9tQzGN5z5eCA7YBsv?=
 =?us-ascii?Q?FGJIlh39ArAbY6zd9xHCo/jBeG0gJeA2Ee3A/yHsexgDjCkV/I1DBcLZdmX1?=
 =?us-ascii?Q?owK387wS0sUoetJhH6anoiJ6eQgRB4gnhtPbsfH9RDqHBRNwFYywZkUWYeCE?=
 =?us-ascii?Q?Q3/UOhCfuj3fswBTJTDZxhbNI0m8Y+QLxQyetyGQT9YfVdSfQJV2/t9+/N+P?=
 =?us-ascii?Q?2H6InZD+E7rSY/L9NllMz+H7TqBQfxN4S7ZtKSaUzw0Db+LnYwj6qi/ue/1P?=
 =?us-ascii?Q?as/R11qQAhVpG2iF3X1C81YNeW3qjp0EHE/ho5IsN8Urd2cyS6/977coaCAA?=
 =?us-ascii?Q?ROcSvuSPWdZtD+I1VJICKF40KmqikFFqjbPXG+cKcn3h5wEvfFZEKU5k+LpP?=
 =?us-ascii?Q?unxfaGrDeGVTlHBZPN0HLB5MlIlGPfQ1enpvc3xESvbnkWHXtpS2/69OYz5E?=
 =?us-ascii?Q?YZyjOohNWhKsECAH33dsZVW1lAChXrXPfwijzIXubQVEORElgtFjdK8ZieCn?=
 =?us-ascii?Q?aEIEobMUZ/6XPVm/nW3VDo/nNtyPvR+4Qw45JaiV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90daf43-3bf6-46a5-850d-08dbf6a61af5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 21:55:48.2585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poZoA0ENvPmkztgm8m32wZGg/JiB20nixyf+fDzf6EtktzYPU1fPYMoiIjqJ5s4L6rya9ZixowK3zmH2UHtFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8613
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec, 2023 15:21:39 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
> Some laptops have an i8042 controller in the SOC, nothing mentioned in
> ACPI PNP and nothing connected to the controller. Add the ability to
> skip probing in this case.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---

Thanks. I think this is a good choice for handling the issue you
presented with the Framework 16.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
