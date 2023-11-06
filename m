Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7367E2D1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjKFTnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbjKFTnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:43:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD234103;
        Mon,  6 Nov 2023 11:43:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo4F6wyuOjsUVT+FVgBmsZ9JKJjgeq0wbiA5lTRk2EFCBsCFh5kSEfPStFWTsujq+NavNWYS3EW4nNVUw0K37+Hh20oKmJrFNeun5VV1SJ8TpaPm7tCHc4AKo/DqsSYgJsf4Lj/+o5uDlhdU10E06XiTJtx6CWT/MaJIFXkcMtfgRle683eC72x1WfZTOTx0J0BJHln90UdBTdt+LEd3Ey2Cl5uxCj83gF3JgEyZqj48MdW/cntRLsfe5cmKmfKxLLgf72Lyp3knThrPQR07VkbdO8QKbOYE7AjqTCB4E4xPQj6Gy2iaE2jA82iZT4m31eNYWmHsRCAC00/loyzXTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkPeaYDa8TDSJEA6MF6cGdfrs6Ihdo0YkuKBqHUbBKg=;
 b=iAFflZqWStgZCGAo+IZFMl5e1mqc/7ltQpElJdnSMagG/6j4UwVpwojAONXpVzZ8fdU0pC9J5AqySE6tjRFIk2tdLlBWA/Rhxz1F0Ri4u0XK0ZcJU+DI7E6fVsFPWj8Hgdo0cR3Oo7udNYTeqfLe4lG0Nm/Bybxkp/I9nemNxV5cyJvK/+gki15gDMTUWeA2cF8H+scONXZ6phtU7QOu4ZC/U1UL+QkdvmjCk0QDG1Uv7kA+T3MCYhnwB1j+n8Zlgpp1cbE8E6QdpyaEcnWjgAuQElhb1HrAPhS/TG25pDnWdDS77DH/hJ2I3SdHfnkST8MPg9Rm7M7yK1Z8X40+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkPeaYDa8TDSJEA6MF6cGdfrs6Ihdo0YkuKBqHUbBKg=;
 b=uDi0VZmKtCiD0iGVgTzNV6pFCH8b+V1/9uosGTNCmcEExp+RUS95zkuKiTKa6qy3oTIwVVRFtFyPr0zI7a2v+av48KxaR5qqoEz0eL+HJp07nj4IXrW7jePakc5TR/QG2V3xOiWNPnHvEfR8JQeQCoJ/wmS045BpMZ2YmTanC7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8692.namprd12.prod.outlook.com (2603:10b6:a03:543::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 19:42:58 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::51d7:e9ef:b57b:f4f2%3]) with mapi id 15.20.6954.028; Mon, 6 Nov 2023
 19:42:58 +0000
Message-ID: <befceb36-dccf-4804-a185-9e40dbb1a921@amd.com>
Date:   Mon, 6 Nov 2023 13:42:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: APEI: Skip initialization of GHES_ASSIST
 structures for Machine Check Architecture
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
        Avadhut Naik <avadhut.naik@amd.com>
References: <20231002195932.2501674-1-avadhut.naik@amd.com>
 <23f0b99b-9f14-4da8-954e-5d175aca1ab8@amd.com>
 <CAJZ5v0gM5owYgRxzjy_zFH1R8Fuk53W=LDhd33mB2U7j5=Ra0Q@mail.gmail.com>
From:   Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <CAJZ5v0gM5owYgRxzjy_zFH1R8Fuk53W=LDhd33mB2U7j5=Ra0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0123.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::10) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8692:EE_
X-MS-Office365-Filtering-Correlation-Id: d15514ef-742a-4ee7-82ec-08dbdf0093f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mq5sOHeTHzIv0iPx+UtthGh8J2eEI69gkT/kPo7obXzh8adq9dcsbP0Xo7t/Qe3ljQbcxq1FL4EYsEyXv2blEecVggaWC+NDXBffRaDv2WbqbYyjKWkD5isSSwXApvKkyM0tUWe5MwKatOTh3BbrFKoxRUOdeqh9Jtbm3PQ1syhDBuQaK3sYfwcgHRVUMjIPGV67ZxEeT0652DXAdMlN5Q5NgsPZlwC2bZzxpVUuP00+bDVm0KurgHdwks/l6e4h7275QvfWAisCcLd+5SYT6P2gEReed2eWXtDhu6nwf+U3A0eyPA8Zm+Mrcd2Em2Yyi2SAD8oH6BkAZskJ9eko6NEKthJGKkTdfSHwQmrwNDPScazY2MsHESsBYlXrfh2dS/eWV1Ar9NqSyg+7oQFvWbwpvhldyMILccKKRAikIza4OJ7MN4rF/NdTFIyDAb85C21deGF9ulABqt+0h4gpKV5/oXxPfUqyS9vTNhsDeUzhC/0QOwRvYIVX6zAeHIKMCl2chE4OqMjJl77xyY/4XoWXFrrAzHVg4UmPQel2L3cSfzzksFZVani+iWXAXW5SWzjDKP8lt4LQOZzldWpznX5Q+tKweBUFVP0UVdnml/iOGvfxKPeAmzz7HbJVz9yJKmMHNxE2d3vaDAzr2Ev9Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(38100700002)(8936002)(4326008)(8676002)(6916009)(316002)(6486002)(66946007)(53546011)(66556008)(66476007)(2906002)(26005)(2616005)(6506007)(6512007)(6666004)(5660300002)(478600001)(36756003)(558084003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N20yTVF0cHFqYlNiclpacU9EQlgxNWl4VDl5RlNJTDIvNEVBeElKMUhQNGZ2?=
 =?utf-8?B?a3N5aTRoaFdrVFNsSEFJQlFIOHJpZlFtQlMvcXNKcHdNVHhSMk5YSnJiTlRN?=
 =?utf-8?B?UmI4Ynp2dlVMenNXL0ZMQ2xOQXVGODBYNUgvelJGclUzZmpWa1o3eWhsbHl2?=
 =?utf-8?B?NzJTSzh5MmZFRktEejJTNVRJb0lTQWh4dHgwUE5IS2IyNU9EZlJOZGxXT210?=
 =?utf-8?B?UHBCN05RMHpDSllCRElON1p2OHFpdkhFb3hnaGxFTERhV3pmMUw5WnNXM3Ba?=
 =?utf-8?B?L2p1ZXI5aldRNGpNaWJWQzE0Z3RDajNXNHJyRzVBbGVTSXlsYlp3dElYR2Zz?=
 =?utf-8?B?RzhuaXY1V3B5ZEtTdXJUSUFqcXdwSG1IaDEyZVZjdGxLOXlzVDIyQ3lSMlBR?=
 =?utf-8?B?Q0xidis5bE81bXZiaW5Wbi8wWFMzZE10bDRmbDUyRDUxT1B3a2N0T2NJSFFn?=
 =?utf-8?B?UGx5a3RjS1ZHMXd6WVEzUG0yVzRmdHR6SVA1YlhoM2ZaWG5tYTRyZXNZOG94?=
 =?utf-8?B?QmdZWVpWM0xqc1Q0T0VPdzA3akgza1J5RGgva3pKdTAxRlZndFU3MnU5c2hI?=
 =?utf-8?B?ZXRET2ZEaVlxL3RPcklMSHBYeFRhT0tsZ2NwUDVYUU5QZTNIWHV4Y3pQR3hs?=
 =?utf-8?B?N0xubzJCQlQ0eUUxUnQ3SmlsTGVqNHd0WGdmTmFCUVRKQXErb1o4VzRQSXdF?=
 =?utf-8?B?bHZvL2JrSEZ2SE1Oc2tHNVhiV1dvOFFCL3VkVndhYnpTM0lHUmNTTkNSeEFp?=
 =?utf-8?B?SFRsSjZ6SllYZFdTTndkRDd1andNeEZ2R3NQenNsRFhIZFdFVi94Mkpwc2xH?=
 =?utf-8?B?cStweTFLQXhDcWpaSkpwQmpweElQczk1dW1OUENhYm5jV0VrYzZESTBLdkli?=
 =?utf-8?B?WmE5TGcwOUZ1aCtiYnVTQmNNdTlOUitpWk9ZbzdQN2VSbjg4azVNWERYQXl5?=
 =?utf-8?B?RDhPczJBcSsyUUJ0RTM4d0U1Y25DQnYvK2hiZkIrTU4vVVRKOW9vNGRBdFVv?=
 =?utf-8?B?NXNJb2RiaGoyV2VsUlFMZFl5UUVVckUwR0RPV2paRmtqWG4vMTFSZm9MV3V5?=
 =?utf-8?B?emNtdTkvcnZLNmtvOTBvT1hBbElpWVFIeW04dmUvNmpHUnBUK2FSa2Juai9v?=
 =?utf-8?B?cy9JcGtYZHEyaUpIbCtlVDNQUjJNTHk1T3dBMm4vWjVSUjFCbnFJZFk1TTBU?=
 =?utf-8?B?YTZha1E5QzZDZXdsWkpXcXVJaTdQVi91OUY3SzNidFBMcTA1UE9NdUEzelU2?=
 =?utf-8?B?WFV2KzZJeW9ocG1ORXJVTDRUNkh0WFZlREhycDZOSjlFRFpBK2xHcG9BOXU1?=
 =?utf-8?B?anJEMTBXQkp3bFM0VFZIQTliczB0eXFsWUx1Y0o5RjlVK1FJOG9jVUFUZnpM?=
 =?utf-8?B?bWtxZ2NuSWdtNWx4YW00T0RnNEptSFV4L0s2OU1CckllaXQ4ZmFSV0NMNXQ1?=
 =?utf-8?B?NFJ4d2Qwc3NRVkxOb2tEV3BEZ1ZsS1lidmNELzM2VXY3eXVvZXpIQjFsVUJv?=
 =?utf-8?B?KzlXbU9zYWU2blNVdDJQTGpmRXdzM083cmd1VUxvT001WExOWTZDSGpiNTlK?=
 =?utf-8?B?ZEo3S1JPTlRnV0VER0tvZTZnZ3hHQTh5ODZzUUdnekhzL3hNckZkYWlzd20r?=
 =?utf-8?B?ZVdORk85dEVERi9JbjZ4WTNPTWR4S0Z1b05KVDlGSFpWMnVRelR1UEVDUGZ5?=
 =?utf-8?B?bHd4U0o2MVdoSTZkdlFMNEVXM2J2QkRnREVsL3R4VDJUMjNPTy9kR1J4NEJU?=
 =?utf-8?B?bEJiT3g1ZWhHRlVlM1Y2Q1ZmUkp6bmFPYkJsbzdTT2hUejZ4VXRKWUpIblBP?=
 =?utf-8?B?RlNLZWt0SWVrVW1kM2RlVG4zMTFGNzFsdE5aQnlwdS9KblE0ZlpseWlTV3ZG?=
 =?utf-8?B?emw0c0VZYkJ5UVhiTkxCT095TXlHV3VRTUdzdURVTGxJVEpOcXpxQVRpNEMx?=
 =?utf-8?B?UVU4emRjenhPeVh5ZWtkVlNtdHVsOU1aK1cxem5CcUxBQ1RJMUpoek5nZlR6?=
 =?utf-8?B?dWdVOWZLSlFmR0tHck5sNlBjQ1IyYndmYU1yTDJGZVpMeFcvL1FOKy9aVVor?=
 =?utf-8?B?dHZMT2xJeHBHdlN4RVlTZEE5ZnFJSE1JRUt2STZ4NklyalFPOVBxRTArSmRQ?=
 =?utf-8?Q?FSMdep6v4/gvwMAr++8IQCxlG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15514ef-742a-4ee7-82ec-08dbdf0093f7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 19:42:58.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ma9/hvvjto5nD6Ha1wjMWCJtAT724EEA1R+3aw5ikcUoQILqY7hb4itislP6rT47QHyD37v1e9fz9/v6DCiUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8692
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, thanks!

On 11/6/2023 10:40, Rafael J. Wysocki wrote:
> On Mon, Nov 6, 2023 at 5:37 PM Avadhut Naik <avadnaik@amd.com> wrote:
>>
>> Hi,
>>
>> Any comments on this patch?
> 
> Please resend it with CCs to the designated reviewers for APEI, as per
> MAINTAINERS.
> 
> Thanks!

-- 
Thanks,
Avadhut Naik
