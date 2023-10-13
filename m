Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8F7C8884
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjJMPX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjJMPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:23:25 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07939BB;
        Fri, 13 Oct 2023 08:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzsjkOy3ChmGQR6UklBCSKFTpHDVkpC0kK8g3xtU+32cUpDA2maiDog26Nd2PPHPMNO5Ba9YSbecU6SGhBfAu02+Ionp240frpdA1tAWBFkGxe2jAdjCQnYi0YGR8dOCfZaLqBiH8ClGxzL1I1CZhiRxRPsusFtdOgIIYd7VAaVIA7ogwfWgK5usG9CWoR2KBSlblkyJcgJslaLd1rZ6ZaIYVOaX+9kH0Kto7ap8k1U05+yTAD5mMVzf8AERRQAWedwIHpNO0aKje65T6p9jWEjSDFIaR8+osmSdGGiPReZo+B06cBV7OabEZ1TO5V2V7aDMyE8PD4/z2vPy6gmA+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6v0E1LfqCcx00v6JW09WV4ETImR3/JT0PBFuq1zkw58=;
 b=n2FHj6QsD4RFmsLMTeaOV9xXvou22NbxIHDNZNycc8uI3+OXc9hyj1Jxsn+xaoRY8KpSSahz1ncuz1zrgJJ5tQbLm9S08vRKF92h3ZrKjhpvZEMGVtktAZcKOj3gBKqukapZcHdvKORWCAwetNscoz5VjS0N0rca9VG6yZ9Li6/6NMw69NnXhuMblFXSUTe8+cbGMwgbwLWiH6WAOvEgRL9k/rZ/RcqmzmYgq7wnG9oec+5HOfudLOdugY/OauMqvj8pLKne3ARDApKlSRfY+HJ32o2lywhtsDHSdAjBsb7OEq/fy2SOKEpabNJaUNkWC59OB53ew0fOKoSbG9AKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6v0E1LfqCcx00v6JW09WV4ETImR3/JT0PBFuq1zkw58=;
 b=RU50sOHtApxcGC4wbrw43QV1dTZCjEbmpd+osx+HC1BT28NgPbSvtNjNJRgGiy6dVFy/ohlZ/n7B9nHbit5xD6mhXD2dsgj2xzBV+mjbwGXLGu+Al8ae+ZJNYtoBNV9g3pSD+y5//9DpLN2JmrdE8EGRozIi3U9KcPehloLjgic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3407.namprd12.prod.outlook.com (2603:10b6:208:c5::18)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 15:23:21 +0000
Received: from MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98]) by MN2PR12MB3407.namprd12.prod.outlook.com
 ([fe80::3008:be4:e9a4:2a98%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:23:21 +0000
Message-ID: <c58fbddb-cda1-e0de-8ad9-e4701c2c73cb@amd.com>
Date:   Fri, 13 Oct 2023 16:23:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] dt-bindings: w1: Add YAML DT Schema for AMD w1 master
 and MAINTAINERS entry
To:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     thomas.delev@amd.com, michal.simek@amd.com, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
References: <20231013093109.37165-1-kris.chaplin@amd.com>
 <20231013093109.37165-2-kris.chaplin@amd.com>
 <f864dd17-7848-4a83-bd8b-2093d11a153a@linaro.org>
 <20231013-january-caliber-2e7acbee15ec@spud>
From:   Kris Chaplin <kris.chaplin@amd.com>
In-Reply-To: <20231013-january-caliber-2e7acbee15ec@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0650.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::20) To MN2PR12MB3407.namprd12.prod.outlook.com
 (2603:10b6:208:c5::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3407:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 89533070-dbe9-47e9-5fe8-08dbcc0055c1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mXGkm/j7mGhykoLJsyRMPd7OyN0K/ogP0YtLZZyGeh4AQdIUgjIBcutqeOjus2bF23d6u2sobzicCKYr5mVw63RNw3BPEgb+wegMWr0MfET5GgtDjFnWL2Q/vFu8VC+KgZJsTGXk5tDo/9IWeDOCeiBgLCoG0pg2ks5+lCXg9iq13jRaFc1fKJkjTiJeqEhQeGb+5OjYbsiU2zYuo8iFKO1Xx7kjwuCKx8aKAKM5xEr3WbIUkj0orRKPWGrlIVSGZWFFnVmuiMI5ZOyVWXhBkfbx0mrUnuAEFDyqZZ5eRrFKJVDKFZHtn6suyxe4OqSnF4W4ppFLDQmQnNQrQ0TegbDsPPAXS7mPJlKJeOCZMy1MLwnGAmz/LhNW4iuwXG/rK1fAq/mPRLJawrAgcAW+d7xaqLQqoGGK0f/dlOj8J9vg8XLsN/DZQspu3/zCDX3N+wqan3N0TaPs8wi5s+87HRtsi0SoxZFrw+0ySIVX6t5JuLisqe613wJPjYfFMS6S28BixKikGAAg0Ld1XaHmxRyT5RGmgPZiIkKoJ9o+DAitUYBgK9y9zce9KznLEOUVtYcu3exFk5toONf0U4KfB673X5OcNjHaojbnur/JAN5pqsf0tlNpXlDbuE+wOErh8C/hoqDu9nOwmB5DZ+h6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(38100700002)(26005)(2616005)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(31696002)(2906002)(4744005)(66476007)(66556008)(36756003)(41300700001)(316002)(66946007)(6666004)(110136005)(53546011)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2YwVHYzb0p5MUlTWlBYQU9XL2xnZjVaWlF3dEFkaFVWVTRKMlJJWm1ON0lm?=
 =?utf-8?B?SElib082RlI3WlN4SytRZkI1eHBHRUtjZUY3N3cwZW5seWY2ZVZkNjlyeXR2?=
 =?utf-8?B?SXBDY2d2N2hOeEY3SFJJNjViQmdmaDN5KzlxUGlMbEVhdjI2OFZvaGtQdXBB?=
 =?utf-8?B?SDVLNEJsVEFMVzBLNnVwY3dhdlFndzdwRVc5S2t6UHU3Y1dZNmRSWWFYUjJF?=
 =?utf-8?B?RFZ4Y2ZIbFA5Z1FwTXFra3pSeVV1SHlteFpEOUhPSkZpZlpwejg4QUlLcksw?=
 =?utf-8?B?aGpJQlFBcHBaeVFTQ1phS2M1dm5Vc3c5dWgycVlzL28zdDRJaVJJV3BvNGhs?=
 =?utf-8?B?VExxQ0lPUWpCZzg3Mnh0RVVrMDNPQVJoYlV4dnhXc1pERjlUazBnTWY2dEJO?=
 =?utf-8?B?bHNKY2o2cVN3TUhYckhlUHhwZU00bTFUM1hrVlNjSFM1bzZ6Uk1iUWowRVRY?=
 =?utf-8?B?UHA3Uk1uZnEyclAyQ25DdXRBMDJyWml1ZEgzTDRLdnhFSDhQdkF5MXp5SHJp?=
 =?utf-8?B?dTJLRllXT2s5ZkJsY3V5SnVLSXhRTUNKd2xCVFREYk9DWXZVbkZIeS9JR1Vy?=
 =?utf-8?B?MllVZUU2bnNNeFNzUU85dG11SDVuT3QyWEFGeDNaVlpDR3BrM3g3VExVSjM5?=
 =?utf-8?B?R2p3eU9qdERSRFdqdGdlTXJRTklTMzR4YXp6UFhMN3F3R1JUc29KcGdTOS84?=
 =?utf-8?B?NkdkdmE0VGxxMnhLRHl0U3VzTFRsR0hYU3lSNlBmR2M1NEJuNWRQWkJ2Qk9p?=
 =?utf-8?B?VGxhZ2hKUDdIV3REOEk4NlF6SmtIczRLNDdISEhhSVNSTmQzRkZ0WHZNcFZv?=
 =?utf-8?B?N21qR3M3bWtYR282VVhaSlFKbURvZnptNUlFRUg4TzRBbXZvSS9GcTRRMkNt?=
 =?utf-8?B?NGtORnRrR1Y4dnZCQ2JTakJFZk84MTdIeEYxZGVuVEY3cWFjTUJDVnE4aFJt?=
 =?utf-8?B?T0dBQ2pISUNDRmJ5bnpaUkRpcGdlVDd6bWplZUc2TUZvMDFZdmVwbDdxeEVI?=
 =?utf-8?B?Q2tyNjU0QzRXVHFRQnpDcXl0dmFSb2MrRWJqY2tQNGNRenJ6KzFaWUNLeEdW?=
 =?utf-8?B?dUZJWkMwYzhoa3MrODUyNnFQZFBHc0FmZjJHbmJQaG54U253NXpFc0VwSkRi?=
 =?utf-8?B?UDVkTUszNmVCZEg2RVM1TndsNjlwQmRhcGhpam80M1ovcU1hOGNFSUdmcjZI?=
 =?utf-8?B?NkZpemY4cTg5Zk96MHhEekpISVJPUWxaMTlveWRoaXh1dE85TWg4WlJwU2I4?=
 =?utf-8?B?R0hSWG96alU2Q21DY1ZseUNhMWw5c1N5Qm0wN1ExbDJwZi9lZEpERWhPOVdw?=
 =?utf-8?B?ZTd6aHlURTg0RDQ2U05wTUo3aWRvWW5EeUxxWTBpdG84UHJabXhxN2p0TlBD?=
 =?utf-8?B?bk1vYVNTRkhDdGZzZGEyZGphM0lVVFlzSzVEdGJxNlBnTGpRck9wZW0wVGRo?=
 =?utf-8?B?cTc4V1YwcXY0LzhqdnVPOEM2WDByWmZPMmpsczIvVWhQSXdJdXFhZ084OSts?=
 =?utf-8?B?eHVnQm1INUxHOXZoSTU2Y1Z0YVpMZDB5RmlMakRpMm9LbmE3cngxQk10M21w?=
 =?utf-8?B?OWRFUnFnNlJoSStsL3pETUIwSFhybHI2TUxmL01WMTN0bVZNc1JmWlM2c2N5?=
 =?utf-8?B?QjQ5MjN0VjFjNTZCb2xBYTFvd2RsOTFzZzF2L1ZqcUkyWlNyb3c2aVZoTGVE?=
 =?utf-8?B?QVJpR3JuaDUva1JWRE83ckw3R1JYcG92Mk8xbE5EM2FqM1VaRXBQUXN0ZnlS?=
 =?utf-8?B?WFVPMnZRTHcwSy9aem5xTWdvOGFJMDJMcTM4U2R1dGt0eVRGN25RUFFtdVlF?=
 =?utf-8?B?VlZQOThYbTNIQ1Z2eXRma1lPY21sU05NblUwajhoZWdCQzByY2RyQUpnamVw?=
 =?utf-8?B?WlNQWHI1aU5VdzlmNkk4b05PbFlNTHdVQzQrZnljZWJLRGhCMlduT2hTTEl6?=
 =?utf-8?B?NGJrNDJYWUV6ZDNHRFNpc21JODkwMEV2N0ZtWGZZenRabzU5Nml1NzYwTUN1?=
 =?utf-8?B?WTEyY0hzdDhlOEU1ZnMvUGYxSGUyZmNrWjB2MkZEcG1rYng2SDdINk8vZUFB?=
 =?utf-8?B?WVluQmIrWEtwM3NoZDhaRS96ZWVKYzIveENteWZ5N0hyZy9iNXpxSmV2bmty?=
 =?utf-8?Q?p7zrh/YEmqpW/JhWI//+9RdKW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89533070-dbe9-47e9-5fe8-08dbcc0055c1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3407.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:23:21.4761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQIkRVilruqDk0mQq5HLXkTy5aY1RZuZ4HKsB8zeiv9NrScjfJSdAF/RSOrdCU6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/10/2023 16:07, Conor Dooley wrote:
> On Fri, Oct 13, 2023 at 05:04:32PM +0200, Krzysztof Kozlowski wrote:
>>
>> That's a quite generic compatible. axi is ARM term, 1-wire is the name
>> of the bus and master is the role. Concatenating three common words does
>> not create unique device name. Compatibles are supposed to be specific
>> and this is really relaxed. Anything can be over AXI, everything in
>> 1wire is 1wire and every master device is a master.
> Given the vendor (and the title of the binding) this is almost certainly
> an FPGA IP core, so the generic name is understandable. Using the exact
> name of the IP in the AMD/Xilinx catalog probably is the best choice?

Indeed this is an Programmable Logic IP core - the official name of the 
core in our catalog is axi_1wire_master.  It is a soft HDL core.

regards,

Kris


