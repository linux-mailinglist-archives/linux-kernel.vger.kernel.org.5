Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59357CFCFE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbjJSOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346125AbjJSOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:39:46 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B492119;
        Thu, 19 Oct 2023 07:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPrNMPC+M+k+G1rZ4ggEVy7i34z1W8vNV/vSK1qMf4D17FUE2kKh3cM9eHLPBh+Mxjl5E5w26FSTBfc08CxBtIR/rgQwGUKR1pW1JFbaIsqULehV2w7twpy1LucrvygzOXJaumH/I0cXDXyEIGl0OIIUsjCPocUoMrrmFVK3I6b3Y+75Odh07iLL3IlYeyiGgKXiBgf83c/W/V0h9MqjQu+pmDD3DZqAL9i+sfNWybZQtFaZu+JFsSU3wAV7F0mXnL5+T+Yw3vkKT0eQ/0rX2Q7t2NKyZ5liRqHu6iwJb2cpQosuYoWjC6EqDW/EBz8yi+jaZqXKh3aSHr4D8ED5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6MWxtWYUdrRiOFIXGBotUQVd0GUrxxxpNL30rwxyME=;
 b=L4/BPmztulpXiZR9KYq8eqa142Z5/s6KI5/lJncC4vd4K5xJlp1hlLpf19vZukgqBOEczevN8Dt21ZGSjaa8hEIgZEM0bDGhAMZM0axAXhR58qxeKBB4q1ITXzwjF1TsuJVJyPazlVpmXs2kH87c6+pUDZrlSGeDAPEJHR2tRKXql7aYf6nczm0V3ENWb5Yq5js4g6RtLBW88pk67+3Q7f+G5/LxriOzwvytn2My7uPcmXUXEowe+onW+SLfPQXmS1EZtlwZx/GNQyJjO3dlw11deXOwacUAaYIvHWT14wbyh9fljYj6H9+kkgLC4OdtTj1sDrncRHdEc/fVLsVz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6MWxtWYUdrRiOFIXGBotUQVd0GUrxxxpNL30rwxyME=;
 b=ORihGNplh70RdJ3owXhAq5XqCQbJ4Ip9V/W5EZLjlrTasPEgqU3kGK0xq8Fc8+gYQLi1P1ahWh9K+BAnx3FwtTp2BK7bxxVRRqlAxuQz6ZfMw+KDAQpJVfdfvw7jboPVhqyTd8EsRnSigq1dZRT3P8v2+iOGemHC7QVB5yx7n+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 14:39:41 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 14:39:40 +0000
Message-ID: <c6d8b03a-ebc3-46a8-9262-d95a278ecd03@amd.com>
Date:   Thu, 19 Oct 2023 15:39:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI w1
 host and MAINTAINERS entry
Content-Language: en-GB
To:     Michal Simek <michal.simek@amd.com>,
        Conor Dooley <conor@kernel.org>
Cc:     thomas.delev@amd.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231019142526.10592-1-kris.chaplin@amd.com>
 <20231019142526.10592-2-kris.chaplin@amd.com>
 <20231019-expand-supreme-ba8c17d05eb4@spud>
 <9f0be064-c857-4310-8ca0-27c16b8c5757@amd.com>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <9f0be064-c857-4310-8ca0-27c16b8c5757@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::7) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d510f20-ccba-4159-945f-08dbd0b13a2a
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6hLQcNhrK3mCxrs9dz0drevJwgtfMoRcx3GsOIOrQt4LyF423UqqLuNL2zMfYjmSjdyMBL4CTymWpOIwastwGu2qPbr6WJk9DPa10Ib0D6hGtLA/a6QtKlxd6pnVeTZhQFzODSC0kuU4gUigQQwPjvi8ld/7DVMDXSVXAbFuD8u0C9OnFBiMkgglSE1kbHy1QCCR7LL0xtDSd9tiB8v5cUXsS2PlOBAY4ZMjqNGdben9N4ojlAx2Y/sKdKp1Jta90hkq+W92ivj9DmcvlEAivPq4TG42Y6RY6EiU4aBVWTyJ/ib0EVA9kXfog6ct5AIP6uLSb4SJSB9c+S8ucck16i6zVoyvbOtbY8W3c8nXzIiJ5qkwoYHG2weyOrJfoJWAugtG+s6Ute/P4tVyYDtLa60Bs/Zndt/T1zyWJJIBwMpzekpWgY28xJGVd1h2zgujUx7wjdGkzC94psOZTd/z8inoC/7QicTPkYsw149XxGDG6x71d7CiqMGqCWoS67OIk5CyqPIGgqIGmRAtH98pDANSMtEI9/NuagJbzfnFidQs7LnlgxvHJJB5ddTIe0HVz4HulfjJUMDqO3TSgvFmJ5BJ7qDFZuSF67tN++HL82S03acc+uFsl9Om7QxPngf2Mw5KPrIYpgy8aGl0oRs1eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(4744005)(316002)(110136005)(31696002)(66556008)(2906002)(86362001)(5660300002)(44832011)(8936002)(4326008)(8676002)(66476007)(36756003)(41300700001)(66946007)(2616005)(31686004)(38100700002)(6486002)(478600001)(6506007)(6666004)(6512007)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnY5NVN0dUZXWDdnOWZ0OFNLZzE4b3dQZFFvOW1FdHREZklFZVd1NlVUSXdy?=
 =?utf-8?B?TmtLQVRqeFZERU42WEpGYVZqMmJuckVZQ01Tblg4cnNzd2dHUGFYcmFSL3FP?=
 =?utf-8?B?YjZ6OEs2dWM2YnVBeExPYUJmeGV5VXAwejlzMjVVdEliZzE5cUhnQ3Zqc2po?=
 =?utf-8?B?Ymw1UEw3dDkzTzlyRVdPVzFXL3hLQVR3MENyNzlMZTVINUZPUVJOVjEzSFZN?=
 =?utf-8?B?VzhLUWtYSm9iRGdWQUdLalNYSjRkeTUraGhQYWNCR1FWa2RqSFNIOXoyMzM4?=
 =?utf-8?B?L1hFazYweFJQMWg0Z0o3ejRiQytIYUMvY2ZJeGdTNmJDc3VKc3c4SHM5aFFx?=
 =?utf-8?B?ZUhlb1Z4UDBqeTFxTllqSm80OVJiaWlCV2kzV0hDaDZ3cFBmU2l0b3FzdzRl?=
 =?utf-8?B?ck5NeFRNL29KaG5ZNHB5RmJlR3p4TW5ieER5SnRObGEwSk9QK1I3OElHWHJC?=
 =?utf-8?B?UzVKK3lTWnBlTFlicUxtRjZkRFBsNzFhbHlObHdIbHF5bE5GY2liMmM5dUJJ?=
 =?utf-8?B?MFVvSG14NnRhUS96dGhqSGl6RHMydldlR0I4cVdHZXBrV1VUYXh5eUNrQkZr?=
 =?utf-8?B?QVBEWS81V01XWHdBQnJrRVYxZkdJTTZDWHFGN3RBcXJFOUJEelNKc2s4Wk1i?=
 =?utf-8?B?VFZyaU5FNktXWVdtc2VVaDJWTHZneHpqWHY1RkF1eHJiQWxWR2wzMHIwcXZ5?=
 =?utf-8?B?SEV2dSs0cWp4MEVFeXYrSTBpMUVJS25pMmt3SmlsQ0NESW1SV0gyaFVmT09H?=
 =?utf-8?B?allhaFg4L296UWxnb2lEVjlpeis5ejBOd0g2WUwzWHNEOU1KaFVOeEhMb2VM?=
 =?utf-8?B?RkxBRDhvMXkvZEticFhIcnJZS1RsYmNoR2ZjdlZ5SndmWnlSS3pnWGVBcy81?=
 =?utf-8?B?dFlkWjFHK0djUnRBL0diWGtkUHY0UzgwZUcrUFhuS1dkYm1pa2Z4ZXJJVEFF?=
 =?utf-8?B?SXRuU3kvU3RWRW5zRHAwejZZTmJZTllLekg4MGdVM0s1NVJ2UGk4Z0JrSFNk?=
 =?utf-8?B?b2M2UHhtU2I4ajlYYjN1ZTRWWG51UHg2dE1CRFVIbG82V1FiSERUNDFQaDZo?=
 =?utf-8?B?WUZDaWtBdnQrSmQwZWhSTTVLUVJ6YlRjanlnek9FNkVmZERReUs4aXpJOWdQ?=
 =?utf-8?B?cGx4bXJaajBVVEtvTlJLVkVlYm0rcG90b0VEQUdPQlNYUk41OTBRTW1pcWMw?=
 =?utf-8?B?RXNnRDVJOGJneUl5bWdBeDdjcEZwWG1VNit3Q2JzOG14Y2g2ZWZtUm1VQ0k2?=
 =?utf-8?B?Y2lMaVJpa3NQcVBHZi91MmFPU2Y2RWxkb2Q2R2xmbHArQVRMamtOa0FUNjI3?=
 =?utf-8?B?M1U3aU10Rktua1VOeTU3a0grL1RiQmdyWlRueWZZTXRta2dnd1E2bXN6cmsy?=
 =?utf-8?B?Lyt5VEVvQ0ptYXl2NjliUSttRjNDMWFEV0RaTDFkTkdpNUxIRFBEU2ZIOEtt?=
 =?utf-8?B?OEdKb0VIbVh2WHB5R0dvamdFMVlPeFNQekxZTDNJYklJRVZGSm51dzEvNnBV?=
 =?utf-8?B?WFUxVFJ2ak1SZXArQVVLcitzQ1c1WmFFbExkbjlNQzdZdng1SmlBK3ZlREdu?=
 =?utf-8?B?dVdwODZBTWhCT2lic2xEVFpESW0wVEtmckdyeUw5Uk0yc1lpQ1pmeDRCVXNJ?=
 =?utf-8?B?Y0RSMTBJNkZWOFg3UVVEemZsNmJqbk9OalJZRU8ySkV0VTRBNXFCVTE5dml1?=
 =?utf-8?B?VDlqK3lrcTBRUGZWOUx5cElpMDFSSG1PblNHaXZxNUNPaU5oZ0JjUlBGdlo5?=
 =?utf-8?B?eWRiMnlVbVF1Y2dtM2ErbUVTaExvWkVqWWdrYUhXcTl0MFdMd29TSitjMFN2?=
 =?utf-8?B?STRLVWh6Zm5IZnlKQTdONzJIdlhLQ0JCd00yZjJpOGo4Z3ZsNTcvUVo2RDhh?=
 =?utf-8?B?bDNPY1U4UFdEbUw1ZUtWN0RwMS83cklBT2pqcWw4cHNjTURxa29WaEhJWHA1?=
 =?utf-8?B?VS9wYS93cDdSbWNUendFYm1vWkZpaGtFYSt2K2gvcm1BSFFOcHZRaTBHcFdT?=
 =?utf-8?B?UWRGNVNXOWh3Y2tTdk4zU3U5TWNiRjJUVnI4K25RT1d3MEpCOVFUdHhVTW1X?=
 =?utf-8?B?NStUN0xCdSt2a2xTUWtsOFo5TTl0MzBkR0tuTGxBR1paci9YSHFOZmxRS3NN?=
 =?utf-8?Q?7xrU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d510f20-ccba-4159-945f-08dbd0b13a2a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:39:40.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5D+ReSHYGOwqcfAkoaO1b848dvsp0Mualb5j/fKTwN/Gj7ky1nJsQY74YopuBaVt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Connor and Michal,
>> I was happy with it before, and still am I guess, given that there is an
>> IP version register that can be used to determine which version of the
>> IP is in use.
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> I think we discussed that already that identification register should 
> be described as the part of commit message to make this clear.
>
Yes we did - thanks for the reminder, and my bad for the omission.


