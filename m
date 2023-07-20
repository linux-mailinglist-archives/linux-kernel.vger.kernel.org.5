Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5903A75B208
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjGTPI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjGTPI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:08:27 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA662127
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azGvbN5/bqQyi/1qyCqWoeGMUzDGTr0TADCNX74EPHGxRbl9FqWQ2d1lLZjSa1j4ZvsVd6QXTK5eHEQ0shOV/7idDLgoTNA4gDIKLpnMdzNtOO2xrdB79g5mhLpK8Aq5yFDLQRsR8mtQCDrNiSzL9Lg4CaTLZ0jSnD9gq9kwfKzwuf/1eKoODcN453gCUL4oLU+w2atZRfWVcPF3NqYXym393oSLjrMTgFtZn2tQYCq0zooWBcL9yWp/JALZYSze3bvZ4eh9WK91QcFFGOBrKlLrV01A5cSWXZ36BxLpTwYQDAKhyYS8r/heJTFkiRXZ7JEGa6ASEJ7Ph6LZcb5EPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++k7uob6zs9JBZqkPllu/DqfIWAlZ2YgLhD2ICdg64k=;
 b=cap0ed40cEATbnzam3kpIBr/+wBJdGPs2Y6KVGvIP2eqZc010feXrM/6Gxy3vvtYjS98m3D/6h1c2p09NEz6uUDm0Jo5+KvVwFOcS+SkHCtzYDLzFUf0afpTGvkaB+NLnxPtGpXoLCBSLAJ266VjDkfhemhUAL/k8gtKWsxHCBt+O/dAxWZBkCACFuHj6amSRSVp3uMCTMTJdhtM2qqhIZ8/0l2HTY0aEBhVu6EQPioc3bHhnbZoXcoNUs/PD5Z4+JD3JzY/ez6Qu6WF0mII3PbLd1kesBkU1Dzz663z8D3GgPt10V/DhuMXC1k/okiF0q/x0hQ06mj12ORPybZtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++k7uob6zs9JBZqkPllu/DqfIWAlZ2YgLhD2ICdg64k=;
 b=y0NfF7IbBJYuqi14OTwolX/UFhgjkEmjHRNNJRzv5AG6LdzmqfVCGUAWG9pSEZqjdJgswir5wK7mlzDWAjkFZlXYP+JJWZh3OmC8pgXkhN3nUdfpcjhKrFcUfnpqcjzyN65eq/GOh0InYZx4HkHq36IYtNF2pMqZVrV1X0T6WdI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SA3PR12MB9108.namprd12.prod.outlook.com (2603:10b6:806:37d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.26; Thu, 20 Jul
 2023 15:08:23 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::be39:45a4:cd9b:4684%3]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 15:08:23 +0000
Message-ID: <c93becf7-c3e8-090b-1f59-d9c1f68d75af@amd.com>
Date:   Thu, 20 Jul 2023 17:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: zynq: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230717225358.3210536-1-robh@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <20230717225358.3210536-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::14) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SA3PR12MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 9055fed9-4ffd-4c84-86af-08db8933290c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkGtcPZ72RbvAcP+I5sINng41+IaYLoEXwLWBKp2S6VUV8jcHcAHgGMwgDJlWq/6o6ue+qZzrH0A+kOPDY8/6EGMOU7jOsmM773paH6jHCPuKarXaV/KB141UsV8ggFaZQLhg93IfJ44/zui3AH+89C7g76RbdB1bvjK8wOnbSyhdE2zZpch+Pn75qLanp1SOHeX1BQf4WuW9aRVwLZHbIl9bUL0Dw4zn09e/UV969I0EmVU+hBPDpCGi+FsMYQZEGmGa/u1P8Q+qwjzqWjsSUEsZdbyPGt3MC6oAwUHqbDNuK3QzonSjSAHBcH3NCbRqs/Of4PMUHdQ4YQUBxPp1ajlOsD9lnpwz5Bjzveu9BVMaZ8g/B4SBd8UvTgJxMxZDb4xtP91WhIEFp6sy3Vv7ZA+w8076jHNpRNJyAs8GEdIKtmSOxzPl81yTcZWR1GL7OCm8fTFMABx2BlIkJ6iG5LEwopI8phchJ4EytGuF8HcUyvgEPhZBrdpm7On89LrNIea5HNSST4MrEG+im0TLSpD6aDt78u1VfErj3rRBD59GLS+vAPUBnIa9PeP33iqHGrZVP1glHAguiIPicAylP7kIXqu3YrWIksj7zR9h8+SF/8vWGvsLZgo7jh4o3YY+rg0K1ko1L7bQ78PxPTEcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(6666004)(6512007)(66476007)(26005)(186003)(66556008)(66946007)(316002)(4326008)(6486002)(41300700001)(53546011)(6506007)(5660300002)(44832011)(110136005)(31686004)(478600001)(8936002)(8676002)(2616005)(83380400001)(2906002)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEl0cnVmVHgwRkpBdTI5b2RNYTdBQ0pIMzZqZ2NsNy9BeDZ6QThBWm5VU3lC?=
 =?utf-8?B?bWhVMUpPZzhlVFVZTEJCZTBhOTQvSENvZUNpdGVWbmw1RjJDbktUa2tjbzVS?=
 =?utf-8?B?b0o4NVZwYjVTRDJjZDIwcHBiM3I2Ti8wTzB4QThwbmFzckJtdm5SeG1vUlR3?=
 =?utf-8?B?Z3RNMFBZSVdYTWxvUFJNalUwL0hMQ3g4SVZWUmQ3Tzlia1RhbkhiOTR0SFdY?=
 =?utf-8?B?MnRjWnJpbWJqTHM5ZE5TVlpucXd0ZnRxbXZVdWdTVkUvNUdZMUxMVm1GR01h?=
 =?utf-8?B?N1lnYW4xaHFrMWh5QTNRaUVGTVlhSitaelJDQnNlaHc4YlJCeWVXMStyM1F5?=
 =?utf-8?B?SnRTRVNiTXlaS2ZjaVU3bGUzMGQrK3o4MWJqMENvWjVJa1YvTGZFbFo5WnZO?=
 =?utf-8?B?U1V2bzZ5dGdSelZpUXpXOHcwSUVNRG1IcTRiN1lqdG9qL0lUMU5OWkd1SmJP?=
 =?utf-8?B?NjhaVVpmZEJ6dDhMSnk3N2tvbVZUeTVDb1dHQnZHcGo3bG5vbmdhTUdvdEd4?=
 =?utf-8?B?dUhtakE2aHIzT2YvdEw0a1A1YkhlMmU0R1BmTnRnUFlGdE1iZmdUWXBtc3d1?=
 =?utf-8?B?ZWM0U0lGYU5MU3NYaVc2VVdzYVUxZFZwMmRnOGlTZUVraU10alJqRWxOeDVy?=
 =?utf-8?B?UTFRRkxKMDJpU1hBS1h4dVZBZmxkTFp5S250S2ZTUmo1VFN0MDFtSVZqQlNH?=
 =?utf-8?B?SW1OTFdSN2ZuTHNhTWlvMFgvK3hEZDMzZFBLYXJYdlBFZmFtWGFoeDJrenZW?=
 =?utf-8?B?NFFuWUpjTzZvZjR1cElUNHd3UlRJMU93RW9LSS8zWDVkRUsvNFgvWEVsc2hL?=
 =?utf-8?B?V2c4VjZsOGZQRGpmdEFBUWRpSGVyajkwZWVhNWJCRWlqVmQzb1prUm1hUzRh?=
 =?utf-8?B?NU41ZG15QkJUbEJJZEl0K2htekN4SVdRU3VYZFpUVmt0UVVDTzM4STNOM1NY?=
 =?utf-8?B?VGJIdXRoMC80MTZEK3ZwR3MweS9Udnl1aEZ5M2tuODJMVUttUzdmZ0pscGZY?=
 =?utf-8?B?ci82cmE3NVFHMXhDakxQUlZuV0llZExLcFFsN2NBUWJlclJucHdPQ2xMbjdV?=
 =?utf-8?B?MTZMMGJVRXcrbkFtek1rb1FJMExyR1BmTHpkejNpbXdOMld6Vkk4VTFuYUVx?=
 =?utf-8?B?MHh6ODVzSDc2Q3Q2MjAyaERPSTIzR24wR2lHQUp1LzZuTXVIM3g5akRsKzBs?=
 =?utf-8?B?MVNPUTlSQXZZMFBRaUtDN0VlWmpnRGhVa2E2MXNwL2x3SEdWcU1CWjN5L0FJ?=
 =?utf-8?B?R0VzemJraDkvSkxMVytBd2NRUGxMS3RDRndseE5CT0w3WW9oUytBYVQvTUNv?=
 =?utf-8?B?amtObmxGdkUyYTA4Nk9wcEdBMU1zZ1gvY1daUGtjdWdOd2ZxdmtpRUJFUVdD?=
 =?utf-8?B?ZmFzVTJ2YlNGOXFWMExTeVJ4UWJReGU5RkREVnI3bzRJMHF2YlVja0I3d3VR?=
 =?utf-8?B?ZnhjSVJwSlNrY3NIWFBNSFFjUGNWZ2JTcEovbHlNMG1kN3hmUWZqejdvc2ZB?=
 =?utf-8?B?ajFJNi9ReE01a3BNZG9iSnhGekkrWFFzSGlwWms4WldIR1JQcGxidkl1OTRm?=
 =?utf-8?B?NkJGTGJmblZIN1JIUnlIMXhTZUIzNm5rZ2U4Tm1YR2tGVDdOQW96WlFlYmln?=
 =?utf-8?B?SWxzWTc2SkhDaWRWYkk3ekcvREs3cStzQmltRjY0Ly9BQ1Q4NC9oS1ZBMkFq?=
 =?utf-8?B?Q0twbHF4bFRHZzY3eitEVzNUZk1DZWtwazVFZ3R6bWllR3JPZmRqamlFenQ1?=
 =?utf-8?B?ZDlOMGFGWlNXdTc1bFhpSUMyR1QyVWZ6WGZSWkpaQ3V1d3JvQXNtdFNzc0sv?=
 =?utf-8?B?WlBaVkp5U3VtcWg0cUdHTDk1UXZtWGc5N2o3Rk1PQWVvdm43VHQvSkN6WUFK?=
 =?utf-8?B?K2t0Wm5mQ2Q4VGJJbDFBZXVPT2xrOUVZMDFheXlOdDYvMFhSZXhlY1N6UTlm?=
 =?utf-8?B?dThrbENFL1ZlZnY2UXBOSUpRRlM5bm9CRERxNEtBVUg2Q1pFVGY0dk40dkl0?=
 =?utf-8?B?ZXloT1g4Sll2S1JoUVh5dXQxUHRYcDFuNXBubHBGaEhBcFBXWUFCdURiS21T?=
 =?utf-8?B?cUJ0cHZRYlR4U282dHRyNnBSTkFwNkdCc09JMmVPdzJSZTU5VzQ4cVNRN2hD?=
 =?utf-8?Q?By+TEnkmQi6C8lJB6RGGnx2FT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9055fed9-4ffd-4c84-86af-08db8933290c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 15:08:23.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wr113oPjdG0Jmam7q2vYVd741CxL/hUmP2zK4CsOlAsMSBauwbHjOHxkzs/gX4mE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9108
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/23 00:53, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   arch/arm/mach-zynq/pm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-zynq/pm.c b/arch/arm/mach-zynq/pm.c
> index 8ba450ab559c..61ad965ef3ac 100644
> --- a/arch/arm/mach-zynq/pm.c
> +++ b/arch/arm/mach-zynq/pm.c
> @@ -8,8 +8,8 @@
>    */
>   
>   #include <linux/io.h>
> +#include <linux/of.h>
>   #include <linux/of_address.h>
> -#include <linux/of_device.h>
>   #include "common.h"
>   
>   /* register offsets */

Applied.
M
