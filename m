Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91887809298
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235577AbjLGUlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjLGUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:40:46 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD62696;
        Thu,  7 Dec 2023 12:40:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eudLE4wfvNeP9zJjQWs+9UC9e2PgBSqK4ejtDuXp1ipSmTXEgN5yuUiQsnf/smiiK8u9p/9zyKB9hx9KwAYSCyW/8N4usvkOTPEYqQDm+9vZdPpZ4i4A+cHx1aGh1R8rivCyUDrSLKkV1Oxea3Da8Mb5G4V1OVaG+PGEV/Y6vhWM4xbbjpFAw9Lu9rE04bVNgmMQp4/l/xFE0dzr1njFeu3nSMtSGpFaPAcqXjBqN1hLya2orA5KsAUBUiAZ3VWPCMqUBsHIbsRzUBK+7PwO3qtf+wy7fLZJXFKQh5ZSjAvJuSPnPP+GOta4EDSm52bYN5hkgECX8TAEjP1CaS1rpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpqrz7o5XkvGXnJRCw/3mTYxN/4dZWCKY94kZ8LbBz8=;
 b=H/FYj/Wpm1gjQnzI6o9ijB7q31fMmA1JI1YpdWvuofrZFcdby1S4j5X0AoY2iUCv3DowMJXkdDnU6huNXmMKX9aGKLDzslIrypxZoiB6AK38XcYaycN0HCI3DoZQoYOgy/SOM22RIal/CfCdtJuMnXr3y2uYLjg6ISGge/bjLrOQr+RHfwVF949tODkJfYuFXrO0CtOcZR6O1+fafK+2SMBRWi3CpPjmdOE2ICSKr2VSnT8M0AwAlHgX5rGQ8YcnN6r45xd3zjJ0+V1/D73r444ctij23Nnv2gbOs1339qJ7JQxSk6f4SuF1Vf7hj4L6eDimAieWiDNXWRKc4UVHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpqrz7o5XkvGXnJRCw/3mTYxN/4dZWCKY94kZ8LbBz8=;
 b=XU2zP+1ZVCYsslCiI7oEC5zMtEAa+KtfrRjfOupd4ong10OK6zqPPog8dB2MjeKbB00hz3bBuArnIAj5xPUOR/Mlmo37z/uar5Qr0hG3aOqyh0UQTS4T5J2tH/gAtrnwkrz3vbz4Bd12KRZbesMza66h5c9MLvDpZg8+ohqHnd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 20:40:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 20:40:01 +0000
Message-ID: <c7296e7c-8920-4bd7-b2a8-c5dc6ffdee03@amd.com>
Date:   Thu, 7 Dec 2023 14:39:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Input: i8042: Avoid probing if no keyboard and
 mouse are set in quirks
Content-Language: en-US
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231206212140.7458-1-mario.limonciello@amd.com>
 <87il5bgfmp.fsf@nvidia.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87il5bgfmp.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::22) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 323791d4-a5b9-43cb-4e28-08dbf764af40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dW7qcSRVZFIABL1MNwHQ6Gv355zqnTAOVjhFmyUiAocZPY9m6ows95Gil48Jwd3wjNaQGblTl5okXc78jVDvHzo7ZtcCogVKX2u8WnQoab8Ymap2bipGS6TwEhyZlhgk07JnNuISPIsW3h/nHeW2RbO51fislX4moXKDfMEzEFqrfhcXzPFIu5pnGmFYtgmkJFTOPV4BTPi9n/K+o9qXL+LPkroGqqvrUNQ4N2r6JaAmPhboINPDEKmU6ZPsW9wiLrhcVO4VnD9RvqLHbyW2Mb/N8T/q0M0tMtiKMFuzuLXiJugmQFSk2UDUJg7uWoT5hGzogtbBxUGaKOxVnc68uGVKuZJTHjwb5dMP2ujIEFNkiTzDyjgQKG+lBWxk14GdmFHF/MlaMdVfiUXie2NQ0lXgZon8rbsOUdJpixlAzELQT8rnTcPPKdjRt6r4aKVdvHistpUVbCBK9nlNYO4CcqBMks1w/FxpYCV15o66IkXoiqvU7BI/3eVkZX2NXUwtQNt1r7O7gmw0HVzoDHZDTf/BjKUdK1qI2yWqEBNwkj72VbQmyJ5PMaeRjLhmlahL/LzUtCjHoRTCcuZ2OXUvhdnvgNmTFalGqmlO0cXJaoP6W4Xx65DXoPa1Lu3VA7uh9RApwgfPtDvyzwuNKjyGkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(6666004)(6512007)(2616005)(53546011)(26005)(6506007)(66946007)(316002)(66556008)(66476007)(6916009)(5660300002)(4744005)(2906002)(4326008)(86362001)(31686004)(8936002)(44832011)(38100700002)(8676002)(36756003)(41300700001)(31696002)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXJRQTFkRHNCM0xYZW1kRWhuaXFUVHNQTlJwa28wOXJBdGhwWE52N3lyQWM0?=
 =?utf-8?B?Y2JaRFBXRHl5SFBadXcycnhPT3VIZHhqdkRRZzltWWpqMDBXQ0hoQndYRCtC?=
 =?utf-8?B?RlVOQjEvZ2ZqU0N3OVcreWRIR1plRk9TWTJnYWFiUDV0TCtJVlhEN3lyZk13?=
 =?utf-8?B?MXRiejlmcmtQdElTSk5lUFBkVVlVdWpiNXdlUTFhbHNzbUcxNGhxQlZ3aS82?=
 =?utf-8?B?WjZnUUJmUlRia2MvbWhTYnNwTGdScDhmdE5Sci9IQ0lwRGxKd09kb0wrNjFp?=
 =?utf-8?B?Z0FoWk5VUTdDS20zbUFqaUcxMzBrMnVLd3VYNGloNUR6Z3QxRXFMY1c3clVm?=
 =?utf-8?B?eWk3bnI1TklLaUROcEcvK0dWZWxVL1Vnb1hDM0t6MkpyQ21RVlJpUFVCdVo0?=
 =?utf-8?B?VGRTOHhLL2F3RDY2YXFqaDJlWm1yU1RyQ3NzMDRBRGExU2UvNkhDMHEwdW1F?=
 =?utf-8?B?UXlCb0RoMlkvdmZ5a3Y5ZnF1azJHdlNTMjc0UkpvSjBnSVdMdEFsclBnZVlO?=
 =?utf-8?B?eVR3VnhZMXV6Q1JxK2tsMFVQc2F6cEhRendESjV0ZUlxR3FpSUtDTzU0VUF2?=
 =?utf-8?B?TVgrMFJBZDNaOHhZMVBBVTBVQUZlN0RSaVdPSDVRaGZtTTRzMDNtd3dtRjNI?=
 =?utf-8?B?VDc4ZDBWRi9Nd01iWS9TMURFeWJ6aDZsY2E5cXRtNkVKS3BqVEFpK2VURXNa?=
 =?utf-8?B?c2xibDJybHlEdnRHQVZ5bTJ1RmFKbzdYaTl6VEo4Q3FqMkFzSkFORSt0dlBD?=
 =?utf-8?B?YVZwRDRGOC9kc1lvNDZOdUpVTGQzdkUzSk9nZFhxZGQ3RW80TExOSWNFOWhS?=
 =?utf-8?B?VjBOTmZqNVJBc3lDNjdQdVZWM2lQdDFuSHJCcFJPQUJXaFlpZWt4N2x6Z05m?=
 =?utf-8?B?blBOQkR4MWdHT3lIWkZ0b1NZU1RERzJrWW9rSlpZbEsxVzBaZlJGVVYrVmls?=
 =?utf-8?B?c2VyeFlyeXczYkc5UGJDOWpzU2VHUVpPUHV2bkNaTEZHbFY5bGhoY3RkNFRr?=
 =?utf-8?B?c1lEcDFZTVFYd1hJazJ6OEdFbXU2SmF3NFZDUjRCYiswaDVodVFodS92MEgw?=
 =?utf-8?B?Y0VvcUdVRTRxbmNJcUVOcVE2YXpwQUxlVGNCcFhOajcvMVROaTlBR05YNi9F?=
 =?utf-8?B?amJ2T1NtdnI2a1VEUDhnRko1aVZKbTR2U1JwWkhrQThLbW9nVjl3K2haZHQ4?=
 =?utf-8?B?K1E3ZURleWhRWjBTV1ZWMnNPVTJPZUZaWnFqWENZRkc4Z2RnYUFwK3ZJbU5y?=
 =?utf-8?B?NFRxYnBpKzkyK01xeHFnV0RNdUZSKzdiWlFVakgxRWdsKzZ0TXRMbmJRNHJq?=
 =?utf-8?B?eGg5cElWY3pPVmN1cW16bXA5dVM3UWRTR0d6SXlleDRSWUVqaU9oK3grUzUx?=
 =?utf-8?B?NHd4WFN2a2srNXA1dDlzZ0laYkZGcXQyc3g3OFlkT09Bc3BBSnNtb205TjBq?=
 =?utf-8?B?Rk9wT1hQN3hzZXpQaDF2QVN0M2Y5VXd0VzZlSFNnbFFMZ0N2aHZYRTVRbktH?=
 =?utf-8?B?anZDcnJvQUNuRzZwaEhXTm53Sy9ONG5BQ2k3UGFRcDdhcUVRN0wzUTlncmEv?=
 =?utf-8?B?bFQxSDlaV01sK0NTSlNKcG4xbjEwM3prWkVBNHF1TjdkeURYdDVQcnoxV0Jo?=
 =?utf-8?B?ZkZneUFqNURMV0ltdDAyTFA5M2ZCUU9ncVE5eTB3SFB1TGt4akN4cHRHOVVD?=
 =?utf-8?B?MS9mQXUzRXlPVnpQbTJuaXR0YmhaRm01dytjMGpLV2M5Tk5wbGVvTElOVWVw?=
 =?utf-8?B?S3NMN2o4SGpwN2NRWjFLMms4RjkzMDlpZ3NEWUM3aDFqaXQvU1pzTDh6dVNq?=
 =?utf-8?B?Ym9RQno1eGxkd3RkUW94MVNOWFR4YTB1S3czQVVrb0E0NDNqbmFpaDB6R2Ni?=
 =?utf-8?B?a3JnS3FzME5FYUVkQXhFWWF2SlFtcDZDR1pMQjZ5Ui84UGx0Y1RMRUU0Rndw?=
 =?utf-8?B?a2MyRUtBRDBBODkyMHhiSjFqeHZ0bFNJTm1BbU5wS3hTSXZuRHgyaVV3OTJO?=
 =?utf-8?B?ajV1R0tybm9oQTNDT3pPSjVuRFF5cDdpZzVORDVJYXNnbGpTVFNueTBwU1lz?=
 =?utf-8?B?UEJXRjJKZFZNUCtPZlRlNUVSTzdpa1ZmM2V4QkIrU2prTzB6aWxyUjJYRXkr?=
 =?utf-8?Q?WHgtb8aWFFipTWQTk3E6D/yBw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323791d4-a5b9-43cb-4e28-08dbf764af40
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 20:40:01.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAlJ/7pCOKLBG5KKI7exm9YSrMXqdHQ89xoJNamqPG0ItiIFmxnSxcTzXQGMzpk9U9opX6xRO81yAHunWfncuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2023 15:55, Rahul Rameshbabu wrote:
> On Wed, 06 Dec, 2023 15:21:39 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
>> Some laptops have an i8042 controller in the SOC, nothing mentioned in
>> ACPI PNP and nothing connected to the controller. Add the ability to
>> skip probing in this case.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
> 
> Thanks. I think this is a good choice for handling the issue you
> presented with the Framework 16.
> 
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Thanks!

Dmitry,

Are you OK with this?  The other direction I considered was to add a DMI 
BIOS year check and "only continue to probe" non PNP devices on systems 
older than 2023.

That could let you cut and run without needing to continue to add quirks 
like this but it could be riskier.
