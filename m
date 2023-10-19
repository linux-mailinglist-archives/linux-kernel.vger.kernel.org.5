Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44637CFCD8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbjJSOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346082AbjJSOfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:35:12 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713E12A;
        Thu, 19 Oct 2023 07:35:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7Wu6fCcXCQLNcqQitJsEQ8z9P7GGjCCJlDyyKyPqX8oidu4eiG2mrziYMUXSHBMQimnXNYvhgcOThO4G7cI0Dtg+89Il/B1NXCGU5E5wzZ2Z45Uh9ZzvgPz4Erfw41wA8jc0Zl+pypDA307rdggdCh6caSKV6kt9VslYis/PaV0ZnQxBJ4YMaUaY+KeqNeRs17LvIv0ySCbL8roeno6PQjOAiouNKc+x0BfNSwndOmbhy5CF7dmv6GAnGZCfy13eoTVFjTnnET+Jo7engB+vmnfGHqRzQU9mYUwVb36LsnjMjgNoOsQ5sE4sGtLw2E9s/cFnaNFsEa0AogMTP4XAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjubFerehFlMwVyrfDhTGDy5fYMYlBhWtz170IaW3qo=;
 b=KkhPeOfpsfFREOkFhOptdVwfu2TB2pgecl9WplaDOdWAaS1hADFc8bUJNXSHX1BNeYNYgKdUdm3CQ5CYSK8giZUS1D+yD8uQu8/qZ6+FQ8ynimXAONpFq17l8ycHI+uPkqKWzmkIXUWGy7N4e3w3ZmByqQJc/Vr5Rzz2cnRl7c5ab66+qlCRs8mDMU27oMRlyesoPfEmhNOwEyuLJKx5euaH8ah7V3fAb4LQgPbVeBwhmW0qL9J1GZRXHG++87XO+oxxUj3ESWGgK02xiuzXmvC1S/kP2j7fMVf/0X4INZJdkxwenn5ywn9NdxWFa7UMXsypDwHBwjqcmViHwhf1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjubFerehFlMwVyrfDhTGDy5fYMYlBhWtz170IaW3qo=;
 b=QYJ1M7K3QxKKfaFHKLFBTQJeXqFGL+lWL24MAj/V6+UdvXBgNkLXd8E3Is7njAk4qHkodWbhbMlXKRKfkqlT+hNrYTC++LdCQ6tT6I7Lp8cC4xiNz2pwpVrO/A1hu2qTn6Z2EVYaQUztVypjuwLfwsuJ8cLZhDRZhiHM4LExFjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 14:35:07 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::b220:eeee:98e7:a62e%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 14:35:06 +0000
Message-ID: <9f0be064-c857-4310-8ca0-27c16b8c5757@amd.com>
Date:   Thu, 19 Oct 2023 16:35:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: w1: Add YAML DT schema for AMD AXI w1
 host and MAINTAINERS entry
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        Kris Chaplin <kris.chaplin@amd.com>
Cc:     thomas.delev@amd.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231019142526.10592-1-kris.chaplin@amd.com>
 <20231019142526.10592-2-kris.chaplin@amd.com>
 <20231019-expand-supreme-ba8c17d05eb4@spud>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231019-expand-supreme-ba8c17d05eb4@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::17) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0ff75d-200b-4505-d0a8-08dbd0b096d0
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VpZ/t1OjScbwHztGvJ6Ljgo9uumjxE8cz16+gr52DwnGrvGDofsG3Dr4Hf1qnA/pGZk6RkiLLBLN3Plv2vExgrbD7yDCSsrhI8/u0avipSAU0LwTIqffCEV/zIFrEpTV0aVeqIR86ZPU72Gofp8Ty84+SBou0Bn2lT00rNOm19pyPaCphcnKGbmiQxOC/eGZNs/jwzLMLIGsK7XkpPymviRVoEh+CJljor5IB8k7X7ySDos9Y5g8ghFzn5CBoTYVY3GePS8VQqbXYs3P083muT0P0f/w3NBAkW8U0t8PN7pNTscAIi6/I7pKTW+aSeKdr6Ba+4828X/gtAvVsIqSZmiYcaW0bpWjot4v1FuVkQSr9J6YEYxNdpUXsa8LXfVLkGzUSvz+Jv3JN10+SqKsfjoU8t+p92m6Zin+c0z28ZByXL7vlV3rO/o9S3tJfpmxfsRmivZhXeQTL5RKRFGq1l1wlgs/h0fQCDPA9RUzBAgWDPW3ugBvesMCSl8EWUILu6N28HVe2JF7iJ4SPb588y72a6u14v+d6tf0alZG9j458PVG6p+5hjvGnIMt6zQnBT0t82OrAPFLHW4AwWx3YxDgMGkz/rk0NrdUMdKn5QoqlwGq8sl1s8a7bdh6SNwErcFRYp0K9sJV7z7h+PPyOj/7KIkwsTAcMP2+R5OE6PtWAHsxoex+J3OEYln0UDbq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(86362001)(31696002)(36756003)(31686004)(2616005)(6486002)(38100700002)(6636002)(66946007)(478600001)(316002)(66556008)(966005)(66476007)(110136005)(53546011)(5660300002)(26005)(6512007)(6506007)(6666004)(8936002)(44832011)(4326008)(83380400001)(2906002)(41300700001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REJmci9LU2dxWlNGWkJPSHByME5sdjY1N1hDd3VLZXM0TWFsNEVQNml5YjlZ?=
 =?utf-8?B?K2JTU0tIVXhXc2U5U01lbU1EaDNaNkh6Mm9ZcTc2bDVEZnlDSXBrTTVGTWIv?=
 =?utf-8?B?RjltNkVsWjE0VkxBNlJjS3BSdGI2WHpqQUpzT0d5SVV6d0U5cHh5RG91VVRL?=
 =?utf-8?B?dEdCMGRUUlhzbEhJVy9lRHhyQVlONlFmQWcwdnJvV0ZHeEtjcHdKNTlhQVdU?=
 =?utf-8?B?MkJaZHZ4WUN6ZlEzNXNBWVdJYncrYWRLR1M0ZjZsQVUzSk92c0pRSmZkM0Jv?=
 =?utf-8?B?MGR5Um1zUmFpWGNwbFdaU0x6N3Bhc0J2N2pQYzhYWHdaRklGZ3J0Mk5aSjBa?=
 =?utf-8?B?T0xNZ04yM25HZ2l5bFNXQTB5WSt6OXZSbnFWOTZmdGRTbUxUYVIyazNIQ2gr?=
 =?utf-8?B?aWZIeTRubFlQdWhFMzZzVzdGN0VabWFsZ0ZobGp0NlU0VndmMTF5NjBvMVdR?=
 =?utf-8?B?Z1VzNzAzQ0lTZzRaSXNzbGFSek1uNmFKcVlLZFlJWGw4emRNemF6MFBSZ0kw?=
 =?utf-8?B?S2JpZ0RkVXhWMXJMUHgycmlTT3MrQjJnVWZGTCtuZU9IVXpFelhzZ3c0WXBu?=
 =?utf-8?B?VTIrUUJ3SVQ2YUoraENwSnBhdDFpL1k0OHBaUzNMRER4SDdrdXBsazRyS081?=
 =?utf-8?B?TE56WlppWVNNL0IyOGsrOCtqN3JnZzBpMlFXK0IzZ2EzaUJPV0FGdFNjV01T?=
 =?utf-8?B?dDhpOWFLdDUyUHJndmE0L0s2REt6ZnBKdWFwZWpXMVpXMmNCcnVWTjBoSTMz?=
 =?utf-8?B?VTNtQWYrNS85MEl6YlJ4bzRCZkM2b3h4azJlWkNmOXRoSWd2MTY5ckVBZEVw?=
 =?utf-8?B?a1djN3pzRk8zMlZURDM5MEZPTUV5dFZNQjNHSWgrU1RpWnltZnhwQ0cweTRi?=
 =?utf-8?B?WU9SNlYzbHFjbmhjbU83SnhlLzUwU21jcER2TWZ4N3kzbjBUSFgvNVQ0ejZo?=
 =?utf-8?B?eDVQNmh3YXRVVTFXc0tFV0xXTDVuYWowdHdDYThZbk8zcVh6REhiV2p2ak9B?=
 =?utf-8?B?RVJrU3g1cjM2cjZjV2cvN0V1ZUJWaU9RTVFTdUNPVU44eDlnKzNwb0dFNVM4?=
 =?utf-8?B?M1hXNjU4TllhbDEzR3FGcE5qOWMzVHFXYnJXcTh1aDFYTUFYU1lqcG9MZ01U?=
 =?utf-8?B?eUY5MW5zM1JKeDRVNlJQZjJiMUV2c0hQSERPalArQ3pRanQrb2ZkbkNEMmRM?=
 =?utf-8?B?aHlIUFVBTndpbXUyOXlpQ1lVUzM3Nk5tVVNBeVl6TFg5UW9JZFkwMlJqdmkx?=
 =?utf-8?B?TVJqUi94YmxMM1ZIcHdqSm1PS1E2ZzJwUDd2b3N1ZmNDalNxUll5Sm05a3ZK?=
 =?utf-8?B?Z3FZN253V2o1U3I5SnVuYlVBdGxqNWQ0MGJBMXZTRktPMFVXbEd1SWR2dlpa?=
 =?utf-8?B?Y1pGYjNzTUlGc0dqWDR3ZVlWa28rWDVoSnBNM2ZwdmZoQ2t3OU1ucXBmZG9F?=
 =?utf-8?B?SmRtREtHRGhjR21rRUlZTDdSMmw0M0NTZ09QQitJNFpXZ3haalBQTWRhNnF2?=
 =?utf-8?B?MklqREN6SmhPZTNvNTF1cVV3VzMrRkVVVjdabFJTcXZyUmJQVUFJa1djamRY?=
 =?utf-8?B?djRIT29QQ09VSDRyZGt3NGdkUWNvM1JITC9nYjZFcjZvMjREVkp6MDNvTkdD?=
 =?utf-8?B?NkxIS3p5K0dwK0s1RC8wbmpabDYxNXdWV0prbEVzMmMyOUtOcHU4Q3ErS2Qw?=
 =?utf-8?B?R29RZHZwK09XMXdjZElYdEF1U2NHWlJ1cjNyVVZ3eDZnbkZ6WHpEVEVIVGZ4?=
 =?utf-8?B?TWdVVWh0cHdlZ2hrQ1RZT1BtdjlFeFRkSUJONnNmdXhXMllRSFRlUk0vYnky?=
 =?utf-8?B?K2d1b3pJckhJQzhCQysxUnh6UFhkOTU4WjgydzRsSDlmVGFydExBbHRZS0JQ?=
 =?utf-8?B?TzltR1VQdEN3RTZYSVRobWFFR3FxYy9YK29zQjF1ODRMSU81UFJjK2xiKzE2?=
 =?utf-8?B?ZTRxQzdBTERvUG5UbHNhdXZPOEJKd2RlWkt2Q1BSOTNaY2FudHNjbi9YUHR6?=
 =?utf-8?B?bVRRdGl3OEljMGlVSDJ5VUJ2WmNDOVVRN2RvOG1DOGtNcUI3S1JMc1Nab3Q5?=
 =?utf-8?B?S0JEejZITWRicG53TXIrWk5MQi9adVdZWGtSSERQRWRDU21URWZQWGVTRkZu?=
 =?utf-8?Q?4yY1RY6AkPLq3KH/wDen44Ou/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0ff75d-200b-4505-d0a8-08dbd0b096d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 14:35:06.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0m0ZGDra+f5IAEyOa/NGd5DGESjMisfG7lXExli4TKiUx3aJJHOdJWvOg2fr/gL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 16:30, Conor Dooley wrote:
> On Thu, Oct 19, 2023 at 07:24:17AM -0700, Kris Chaplin wrote:
>> Add YAML DT schema for the AMD AXI w1 host IP.
>>
>> This hardware guarantees protocol timing for driving off-board devices such
>> as thermal sensors, proms, etc using the 1wire protocol.
>>
>> Add MAINTAINERS entry for DT schema.
>>
>> Co-developed-by: Thomas Delev <thomas.delev@amd.com>
>> Signed-off-by: Thomas Delev <thomas.delev@amd.com>
>> Signed-off-by: Kris Chaplin <kris.chaplin@amd.com>
>> ---
>>   .../bindings/w1/amd,axi-1wire-host.yaml       | 44 +++++++++++++++++++
>>   MAINTAINERS                                   |  7 +++
>>   2 files changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
>> new file mode 100644
>> index 000000000000..ef70fa2c0c5d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/w1/amd,axi-1wire-host.yaml
>> @@ -0,0 +1,44 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/w1/amd,axi-1wire-host.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: AMD AXI 1-wire bus host for programmable logic
>> +
>> +maintainers:
>> +  - Kris Chaplin <kris.chaplin@amd.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: amd,axi-1wire-host
> 
> I was happy with it before, and still am I guess, given that there is an
> IP version register that can be used to determine which version of the
> IP is in use.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I think we discussed that already that identification register should be 
described as the part of commit message to make this clear.

Thanks,
Michal

