Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A511E7D822B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344860AbjJZMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJZMCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:02:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABCB91;
        Thu, 26 Oct 2023 05:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YktaywQNXibZhGUpAvRFa2VOn0qbpkiWS0rOUjtmFJB3w47Pnm0+OM9RuETF4Kgl6jJ8zj1mtydnRe5DGOpC1EfujBIXl8sJ7Cw0DHRzFgKiGLuN24XwYLNu7N8w/wytDdIkuDgTvZIaY4wH2gSTbnatwMiWdFGHpr8r4so+MaAr9SRprqfGkgQtam0uVYP91rwrVssC0TXPR2UchUgT82NAqFzSThO6zmQrMZENTbGTgHyqOw1u5j1tcanzPtavpqNhyfwzMPbDFBop0gfATd7ipYJio1+z9WWRAWWmHyWySTUQHLvHBJLNHr5VJyVtisrGLIbipWssT96i/1Kv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn+X8sriLu7lJa+E4kosjzKv2U6i+pMhBjOAWIkMtRU=;
 b=i2IjawAxB9PrAsP7ILBicQYB5pwBXIGOt0kLlNroAm0ru9D3Sw47tfECoKm2eeM9kcR3gm9NkMKbtuL54Og9ehkE75IEQJeAYNtH/8nYvRNY37ETKhEkqRjrGeefHXPKpyNQvvGDkaPcka3h/ZbG74RYFbHvV+C69vqxcXGaDzsifeg7cIPgYdGhMXZ9U/LfZwsDFZgNW5KPqe2Kz1Cufkc8VbVqQvoV0RHGGyodQNarnW1Nn3lsZz/NKhPxyO5TrWebpssIgxBaf4C5MXXF3pDyr5ze3ro4wV9/j/RXNLhXtsiYSkbdQhw2MOZaehhF6V+zY33n0O7g+LrT2HtEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn+X8sriLu7lJa+E4kosjzKv2U6i+pMhBjOAWIkMtRU=;
 b=RckAcnh15SofvRFYicEBkGYO0QHx6T3i8TNQknekt7RgpDr5tT1Y9/WlprkVNpcyZP+9RNTitSQssJ1DpnoNGsDG4hq8LNEcH7Hp9Wcl849f7JSeb4BbViPF9yxhsFGe6E18ExlafAEhEYWj9HuGYILB4RsjB4CLbkjlqF4U/M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 12:02:26 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 12:02:25 +0000
Message-ID: <850a3e78-f663-c696-2141-7aefb043b6da@amd.com>
Date:   Thu, 26 Oct 2023 17:32:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
 <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
 <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
From:   "M K, Muralidhara" <muralimk@amd.com>
In-Reply-To: <20231026111448.GAZTpKKLI6LG1/COFE@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::34) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: b79dd6b6-443f-4bdb-3681-08dbd61b6b39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJUwLDED1z6K9ES7MhD4MfW6Ob+kLxWXbFHpwkvk0Wca01Kyqz2uMNYKSWmUGN8YBiNm1AbxdRFOssk30HzK4bbRXYb3cAre2eEuy4b87uePC39r5miGU7G71WCm3UT70Gj31OJSjdgDVXXUa5XQBFAT2+24ygIWNZmVn2LLbxRpdRhKIPUXhx8+j4HCodabkkasHJVJVcGuT7y4iQJDbALtXntpNazF1wchjbMfq9ckaHcKXroHdswCant7oMRtU+9/NEqj0UgWGcwz343EhKNL9t5Xl2v+/U6YQv67m9N3T5SqARohSKsGQErgVTNdW71Z8cerl1Lcb7cf7SFyassdYMtgDrjKzay9gLrMfNzY8LZykEZ0EdWs2RFkRu0Mnf9qJZvS6uX4wXS9hUsoKLTrYbiLvjQfKUA+H9tmMNH7i63/xjxvnN/b+pAnbK77QrhTwEpQzNE12lXlCACp7s6Lox8M/MMKT0uQzwhTKz0KrCiNM6z3CFLWEsDxMroid1l85ji1xvEAAWPTSs054ADM6iXdYHk30vZPOxn4SWU3d8KUnq/8/nhPh6reMImAcf/6GeBXKgCMJdE/VuvFRpoNDtLz9cFh29JFwLwPWply36dJCJW5RZ+rdG+QsJ9v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(31686004)(41300700001)(38100700002)(2906002)(6506007)(4744005)(31696002)(36756003)(5660300002)(4326008)(8676002)(8936002)(478600001)(6916009)(2616005)(66556008)(54906003)(6666004)(66946007)(66476007)(83380400001)(6486002)(6512007)(53546011)(966005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFJDdlJxdE5RbVRxUHZMME5DMzlleDFVdTRmQnhpMVlxK3dyYWtwaG1IN3Zn?=
 =?utf-8?B?K1lzQ0lNRXpnRmY5Y3haN01DcXh2aGNXTFBoVkF5ZUlaa1RxeFdvU05yOVRR?=
 =?utf-8?B?MTZFR1k4N3JHSEdBTFdQdkpjNElIakVhSW5IeThZOHNuL08wWENqZVJCRmdo?=
 =?utf-8?B?NDNtbm9LMHJyWmx3Q0hKZ213SEY5M2RVaG8rVytUZm9iZjRBeUtQYmJwMHJn?=
 =?utf-8?B?U2F6RTJSSnkzTHdFUW51aW9KZ2RKQmVMN2pIRWlRZGJRVHBYc1IxYWFRb0Jk?=
 =?utf-8?B?MGNCTXBjUmQzTS93MEtiSTluZWZjTGt5eGVoUXBnK1EycDdaQmo3K25qVTVQ?=
 =?utf-8?B?TzVaVUovVDMwVzRWZkI3djFCU3Q2T2VYY0RpajNqellHU2poK0E0VFozbVor?=
 =?utf-8?B?OVpOSDVxbGxLZVZsYzZBRGxXcSsxcEkybFdOZTN3SnlaU2V0OXZJRW83Z0U2?=
 =?utf-8?B?U2NxYU1Yck5DMG1DbDhFWHduTEExY1M1NmlzdXNBRWNQZnJtaDJVNjk5V0Rx?=
 =?utf-8?B?Z3o4d3kwa2N4d1djYVFBVzY1alBwUlhQN1hvOVFXOFpNQnIwRnc0S0Q0Ky9l?=
 =?utf-8?B?MmQzdVJvMW1mdWFUaVlFRUxKSU1aUHBVdlBFY1pKMWE2SnVjMG9TdFpzeXM3?=
 =?utf-8?B?bmV6d284dXVPZmQrSHlXaDhLV1I1RWpGcHRXZTE2V2d2VEVsZGtEOHBITVZK?=
 =?utf-8?B?dFRISkw2cEkzVi9pMldDeFo4RTlnZVlaNzkvdUJ4MWJValkzOXZwVWo3NmFk?=
 =?utf-8?B?VWhBZmNvaEtiaURFMmRleVVycFZGenUwWmROVytBb1lxSUhJUFpKRGpnU0tG?=
 =?utf-8?B?ZXVaU3l1d1hDM1IyVHFuUm9CNHZZalBLWnZnejJ3ZjRzYmVIZHY2ZytDRXZS?=
 =?utf-8?B?dXdDRFN3VE1EM3JnaFo4bGlBMEYyQ2hzU0tTVVNlTXNyTS9xMmlKMXFtUnBn?=
 =?utf-8?B?STY0TkxwUnA1djB5eSs2czZMT1pmOWg3K2c1OVJqNDh4VzJReFR0c1MzOHZv?=
 =?utf-8?B?OHYzYWg4YnJYT0FvNDEwL0hVT3Nobk9Zam1OMnFWTnNhdHdqOFE4M3R2ZUt5?=
 =?utf-8?B?a0Fyb1dmR296ZmFTMGZyVnBkQ0hRSzN1VUMxa2dnUitqcytwQWJDYm1zcU01?=
 =?utf-8?B?bGVmQlVBSnJBUjFtb0hFeDBWelRsY2tmMnNyOGRQWlZ0Y2hNSU5tTXVWZVFD?=
 =?utf-8?B?b3FRWU1ib3Bsc0kwQTViSEJhdVFQYzFObzJkblJMd2o1R0t0RnA1OFBwbFov?=
 =?utf-8?B?R280UUVaQmVjVFBDQWZVM2tVKzBVOU9CNWl2NUsrTmFUYWdJUWw4ejB1UDYx?=
 =?utf-8?B?UU1CLzBZdWlHdjlDRHpDV0psWXNKMWxyNlFlNURrN1RoMTZIVUhQdStlL2c3?=
 =?utf-8?B?UVR6R29BdWRvZHdiK3NrdnNOY0hXQU5qN3NGaTVqbElDeFEzRFY2N0RyUlhz?=
 =?utf-8?B?T3RObFFnS3lEN2JOZXRHZURNT1lITHNLSCtTb3B4UzRtdzdlREYxSEwrczZ0?=
 =?utf-8?B?UHpGaTJEbTFvV24wOG5LblNmWUdSQkJ1ZzY3UmVPUVBHWkJ4N1hJN2ROZ3No?=
 =?utf-8?B?M2ZvS3F0WnozVlJ2dTIwdGYwYWlaRnFOZ1ZJNTU4ZGcxeHg3UVBpamxjSDJ6?=
 =?utf-8?B?czh1Z2FFTnNiV1JncDc4ZDI3QWVWVHBvUWJLT3RVb08vMzNFbFlxOFVBdnpM?=
 =?utf-8?B?cHdid296UVd0RE5iRjhUKzlxaE5hQ2hnckFMOUhCYlQvN0J6TG4xZ0ZEUnFv?=
 =?utf-8?B?SEVKcUhjQlRmVzlCMjdqaGN0Qm02LzdtL1c1eHdHTDY4YWxDREo2ZVNGZ0Z6?=
 =?utf-8?B?bUpWUmxoTTNiYnFidlVlQ1hVeHFRU2toekdrLzF5UVBTeUNrK0UyeE5CVU5p?=
 =?utf-8?B?RlAwQ1pkUmViNnhGaU5IM25qSnZRUXpyamluOENJNlEwUmR2bkZ3RUFtSzMy?=
 =?utf-8?B?eEErMHQxN0dFcWVTRUJUekZUWDhPeVhaMnlUdUsrMkxZMk9EU3BXUkFkUFBz?=
 =?utf-8?B?eUlseGlLZVdrVUtWRnRjdzRKbWNDYW1iaFl6R3NqcE41ejZGNzJKUjQ5RTcy?=
 =?utf-8?B?WnkyejlQTit0QnFqZ1FzWDVQU0M1V1RwR1lsWkthZDZhaCt0ZUxYbmM1dGsz?=
 =?utf-8?Q?uKAQZseztu5uIuk1Rv8znEmLI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79dd6b6-443f-4bdb-3681-08dbd61b6b39
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 12:02:25.7887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPCGiB4QxiS3OU1c5Ckrc/kyeKWzbOuujOA7ffFmzsw/FhyQvw0bCyFb/LqDuZ93GbvjIxZtlUHyhqmP1RT02w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/26/2023 4:44 PM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Thu, Oct 26, 2023 at 03:12:22PM +0530, M K, Muralidhara wrote:
>> Executed rasdaemon:
> 
> How do I decode the error with rasdaemon when it wasn't running while
> the error was triggered/logged?
> 
Not possible.
User has to check the kernel dmesg log and using "Ext. Error code" user 
has to refer the "error string" in the PPR for a particular Error code.

> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
