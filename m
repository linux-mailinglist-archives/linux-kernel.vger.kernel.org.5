Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5532E793143
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjIEVtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240546AbjIEVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:49:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF371730;
        Tue,  5 Sep 2023 14:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnmVB0s25dM/x5fensxGK6469be7bxii2E2WWh7hCoRn2IzPIQDzVKlO0rjO0hJgc7VZ7E2prsW/KFE6Oevgh1m97wuCBIp7ql207JD6lu8WpFkaZdmHXDuuGi2YX2IJc4rWxP/IuHGmcJFQWqJfw92m+niQIQqlaNv16xTXl+cnIxB9Zbhy240sjDxg1FU+x4BMwZ4JTC2aEHYx2wUzMB22siMRH49jS5QVD2vXNAQ0YLU7ebL+DtHUJi5Ta1/uS+Da3G+UF7ooRPLyRij4e/1vbFdwjjT8PhP8eUKjYTfKXCG+UyVlXSyAQn7vdt9l46ufCCJm9BmuY++zaamj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1CtQ+IjBx5JtAx923jfjONs08eotnjyONy9sX9IKk4=;
 b=WMIrtnKi8Tu2HF0eHSFfsfTcmYbUZB2RvZ0DW01U47l6TqNqpzC9ir9s9dGVRo787tyx0cDHqBWQKwzHNyskqod3AaMZ6MmBIZ7cTKWu4lAJvVwlTmoHhp8O51E2uLoIGYC1Xv9Q3n8i1o/mhWto5eCcZQ6E/PzlQvfGDYeTZWQXwAwgrM9Q45hh9l62/J38pZvDXJDk32/M52MDDcWQwzrW63Tw/yqI1928e9SZbFeWMv9m44M3Q5J7NnJ7ZNK5a2gDmHeAT6Jmrnxf5lDNF7PyDI2ggM3RxVq/e4dwalbRkmPD6lzdeT3nd7myi+LYH92SR8NgGLc2sEv+2lcGdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1CtQ+IjBx5JtAx923jfjONs08eotnjyONy9sX9IKk4=;
 b=1pj4bj4gf9iUUd5UlkqPj4m7R/Rjn67G27uFu53lg4M08r9P9ZKSOs+KfjgTIJBWPYox/J1KKrwU+0jf7oxpBXw0iHd3fXAe7VV1bjRkCC/b8eiZEOyiWQqtjsega2p4L6S1JZGO1oBt8OOb+ATMYsK8DGSiG21rVT6ELYzGKl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB3683.namprd12.prod.outlook.com (2603:10b6:a03:1a5::16)
 by DM4PR12MB6591.namprd12.prod.outlook.com (2603:10b6:8:8e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 21:48:58 +0000
Received: from BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::a486:ca1e:8c99:ee9b]) by BY5PR12MB3683.namprd12.prod.outlook.com
 ([fe80::a486:ca1e:8c99:ee9b%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:48:57 +0000
Message-ID: <a88a0240-30a2-4c99-baeb-091b44e4c2b7@amd.com>
Date:   Tue, 5 Sep 2023 16:48:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] remoteproc: zynqmp: get TCM from device-tree
Content-Language: en-US
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@amd.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>
References: <20230829181900.2561194-1-tanmay.shah@amd.com>
 <20230829181900.2561194-4-tanmay.shah@amd.com>
 <f6943509-25c5-b4fe-2218-638cc06a4e04@linaro.org>
From:   Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <f6943509-25c5-b4fe-2218-638cc06a4e04@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:a03:100::22) To BY5PR12MB3683.namprd12.prod.outlook.com
 (2603:10b6:a03:1a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB3683:EE_|DM4PR12MB6591:EE_
X-MS-Office365-Filtering-Correlation-Id: 698549a3-1522-4316-6fd9-08dbae59e849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuGt5oSSwkbuJl4cTEPXHhncJQVl1rfcnL047Z/S+tuiOfe110zr0zlvSxDQvN7kY7JLxllGKz3UW2JeMsQAtbmFof+DuoF4Lf2FGruyanVj3uUhwW+QVFgC8iOJiSS76m8wHZCTpD8raAGIVvn072h8/chcx/O2LOdqdd82YCuPi89US0Jw8PRlFt/gttJ1rrjHCs8Dv/jHhWr3F9Xt2f4ny2G0DVHaBgk9ZUPWRUeM/AQYWeonwfpIrg3RahZXoHjVr3cANNXnkOtDKeZ5uJb8YB96IWQHbBsiWtRNLWNx/l5ff0Ujzez1eMI0WAj9FMEFmz3tvWqCnQAv4qIacQstu/vUOofC/3oAJwSEELLD/0g0vSXbF/byLI0TWYc9y17RsyC8rAcJNXPiU4eYlQNW+5moVZ+0L/KzrIbZKe97BZd4tAaT015WOqPATbLvWDcuS79TK8eyQHdLcArj5lMvsGl5/h7iLBDRvJmH/wRW+4mBYDQsGpGC3HVibqpKy+/tGSZXSHn0ocL9EwMGmfxIQTkkeUwOiPRFxxuEMfbrCAg3bpiLEaBQs9G3MH13OWZewVzzDCkdpSk9w97V+VfQETNAJuSNzv5WWsvy56lmOuAtJWZMOe9SnmxAIzvU5n4f61PzFzHBGIXqkf4lMpXdM60XNbwUrivyI6RcSiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3683.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(346002)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(26005)(921005)(6506007)(83380400001)(31696002)(8936002)(7416002)(41300700001)(86362001)(4326008)(5660300002)(44832011)(8676002)(2616005)(6666004)(6486002)(6512007)(53546011)(478600001)(110136005)(38100700002)(2906002)(316002)(66556008)(66476007)(66946007)(6636002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck95YjByUDYzWG9ESzVQMFhzd2hzT2FIUWpwZ0hoQ0dpUW1jYy9Nc2Q5TSsy?=
 =?utf-8?B?Nmozb3hTQ1pwOVVadEdZQ1AvWUZxc3BRTDlUZGtENURRbG45bkVEY3Z0YllL?=
 =?utf-8?B?NE43OE9QM1poazNQQ1RYMGpBTEdwTm12ZEk4QlNTbHFjNFIwZnBKU1ZVcFNB?=
 =?utf-8?B?b0hzUVViS1NIakpWK1ZHdkxvYmpSWThGN0NVVnBNck9HTEM1UVg5V2hWd241?=
 =?utf-8?B?Vko3MWwzcDh5Zk9sdG9GODN6cmFGQm54MjROL3ZoQStHbnRoS1hKQnBGSjI3?=
 =?utf-8?B?M2NmdkNueTM5dEk2SW1LQmxTRUlFZXVRTjVXMnkzTzhvL08zdkFDR203QWls?=
 =?utf-8?B?Zy94Qjc3OEVkSzQrbkduUVhtdVZkYS85MjRGT1EySzBlUHJEZzlrMmE5RTVw?=
 =?utf-8?B?WXg4QUZSMlpMWE9obDdjZ0RVcGExK3VpR1VyUnJDY2s3SndHZW1VQ1VleWRn?=
 =?utf-8?B?bjE5WHc0WHAxTTRwVmR2c0VYdlFCTkxIS29PcHh6S2dQbHF1V24vNXBJdXhJ?=
 =?utf-8?B?eTRPUC9lS1plMUJvWWgvSXdBMjVnY3oydEZ4ZndUOVhpV3lqbVdjY1VPNlp6?=
 =?utf-8?B?WW9BUGN0YnAwUzVzNldBUHB4MDNUUkRZQXRjS2p5eCtNeFh0YTc4U1A5dElI?=
 =?utf-8?B?Ukc4STY3R0o4ZFVxd2VFaThkSHA5QjM0TUp1M3ZWaXlZVVJhNXg5eHZJZzI5?=
 =?utf-8?B?RTM3TjZ5WS9mVEJ4RlhidUVoQS8yNlg2cTNQWExhaVY0MG4wRnQwVk43QjZB?=
 =?utf-8?B?aFZtUzFYQWRBLzUvWXhsQk9xSjh3R0VOUEltR2RaQ0lwbENoeXNNTlpTYlVj?=
 =?utf-8?B?Ulh2V2l4T2JCenJlRTdEbGdnNkxpY1dlRCs2Q1JYc3d5NGE4bTQ0bisxMGJz?=
 =?utf-8?B?ZXhhTmhWemwvNU1GbEVaQnhLbzM2SG04cXNxQlNtU1Z0LzEzVlp3a3JTMGZ3?=
 =?utf-8?B?OGtJYmhoZGhPdDZCK0M4c2l2Z1pOOXZ4Z2wzL0xuQkxnZ0FNeXBwakEwWXRP?=
 =?utf-8?B?QTNQUlFXWU9OekhTS21uY3lSVFBXRzZrL1pnSVpQQjVsdVBXMTdIUTJUMFRP?=
 =?utf-8?B?OUNsTWlzMERwQnBvemlWYWhKZVdLM25KdUVqcG01MEk3bnZab29BWFAwQjZB?=
 =?utf-8?B?UHdKYnoxUUp2aWFJbmdpb0lTRnNDb0JCNVB5NnBMcDdvYW1rQno4bndSdmhS?=
 =?utf-8?B?aHRkR3gvTlpXWHFLaklQalZZNzY5eUJJaURtdTRhV3NXa1JRbUh2elhJZ3BH?=
 =?utf-8?B?WVN4K1VPcE9vd0lKZjJXUysvNXJzOXg4U0p4akM1bTN4bHVrRWt2NXlVd2Mx?=
 =?utf-8?B?U0l4ODZvaDg4TUVmMlhMRzNxeWhjdWV3aHhpRHVESGpMTzZueXd5L1NVMjFK?=
 =?utf-8?B?cUVXRnIwYVV4NnpaOWpuM3lxVGdmc1dwamxaNEU1OWRHa2tWNVRVZ0RUQThV?=
 =?utf-8?B?TDVSUVBvMWYrek1heUR5UVY3L2xCSTdjbkd2VFdZN3hQR1M5Zkx5T09MYTJi?=
 =?utf-8?B?R3NxVSttNzZDYkx2V09uQ3BaL3N5VmtuYTM1Q2tmeEdGS3dTak1uV0l2ZFpY?=
 =?utf-8?B?ZFR1dCtYUWlpZy9sSnlVeDB6bFFIcTJaMm5Xd05GVTNKc2RDY282aHo3enNM?=
 =?utf-8?B?dXZIQ1pFNTl3RTNTOW9BaVplMU96d0tyS2FkQnhrVUFycDFmL2t5bythOUhC?=
 =?utf-8?B?aGVSSmFVd3VMTDR2cWttbCtXbjdkVEpnSDlyb1ZCWm9LY2M1UC80UUszQ25l?=
 =?utf-8?B?eVIwRWkvSGR1cUxJU2NZUWY2ZGw1MXYyWXpyOVVQbHNwREZvMmZFWGRuOFJw?=
 =?utf-8?B?ODBaVGRYWGd2TXFyTVRYNDBpQnFKU0xwcE5ubmFFcDNhY25YaUY3MGliR2VF?=
 =?utf-8?B?VFJaNytFWG91MnZSM3NqTlVLRnowMGRScEFaOTlQVEd4ckk5emJ1REMxRUhr?=
 =?utf-8?B?Vm1zOHhoN3Y4U3JhYVo3bGpGWlg4VGZjT21mbk02Qmw1OUVCUTJSN2c3cHhW?=
 =?utf-8?B?djhsaGNHemxsRjk5RlVXUzlDMmxRbHdaU2d2c3NXWWVZWk4vWVhPZzhTMzZM?=
 =?utf-8?B?NU9nam93V1pERlpPaFJDQjB5c3NzcmVwNEtkV3dJRUFGQjF0bkRTRHFwWGVw?=
 =?utf-8?Q?PHP5Z/Gd5zwGerdQ49HjzZM6i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698549a3-1522-4316-6fd9-08dbae59e849
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3683.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:48:57.7530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6PeDitbcE9ORKmDqvzMJOHf/gN5V2u0jz3euxe92mbMP78b5d4TI/XbKAIh8o4l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6591
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/4/23 2:50 AM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 29/8/23 20:19, Tanmay Shah wrote:
> > Use new dt bindings to get TCM address and size
> > information. Also make sure that driver stays
> > compatible with previous device-tree bindings.
> > So, if TCM information isn't available in device-tree
> > for zynqmp platform, hard-coded address of TCM will
> > be used.
> > 
> > New platforms that are compatible with this
> > driver must add TCM support in device-tree as per new
> > bindings.
> > 
> > Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> > ---
> >   drivers/remoteproc/xlnx_r5_remoteproc.c | 279 +++++++++++++++++++-----
> >   1 file changed, 221 insertions(+), 58 deletions(-)
>
>
> >   /**
> > @@ -75,11 +79,17 @@ struct mbox_info {
> >    * Hardcoded TCM bank values. This will be removed once TCM bindings are
> >    * accepted for system-dt specifications and upstreamed in linux kernel
>
> Just curious, for how long this fall back code has to be maintained?
> (When/how will we know we can remove it?)


I believe we should never remove it. It's important that driver works with old bindings as well.


>
> >    */
> > -static const struct mem_bank_data zynqmp_tcm_banks[] = {
> > -	{0xffe00000UL, 0x10000UL, PD_R5_0_ATCM, "atcm0"}, /* TCM 64KB each */
> > -	{0xffe20000UL, 0x10000UL, PD_R5_0_BTCM, "btcm0"},
> > -	{0xffe90000UL, 0x10000UL, PD_R5_1_ATCM, "atcm1"},
> > -	{0xffeb0000UL, 0x10000UL, PD_R5_1_BTCM, "btcm1"},
> > +static const struct mem_bank_data zynqmp_tcm_banks_split[] = {
> > +	{0xffe00000, 0x0, 0x10000, PD_R5_0_ATCM, 0, "atcm0"}, /* TCM 64KB each */
> > +	{0xffe20000, 0x20000, 0x10000, PD_R5_0_BTCM, 0, "btcm0"},
> > +	{0xffe90000, 0x0, 0x10000, PD_R5_1_ATCM, 0, "atcm1"},
> > +	{0xffeb0000, 0x20000, 0x10000, PD_R5_1_BTCM, 0, "btcm1"},
> > +};
>
