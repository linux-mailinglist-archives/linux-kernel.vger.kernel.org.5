Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D0276BCF7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjHASv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjHASvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:51:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4700E71;
        Tue,  1 Aug 2023 11:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cw6F54qxI+MMNQgVimnc8bBkp6bVtIGuaQr86F9WruRYt5f4n4xrMQR44yEn0b2ospksrMukUjf+R0f2ezJ2tuSIzn1w8CN81nTx5it9+Pfg/fJg/w4Q5FJPvqU+3aZDj+UaNvSBjrw4R2Hqqgwft0tBBygos5aOz0kHiDyv+IFS2/CLmJZqNTlKAYGY1BzuSl9Id9eiKifar0ECg3/a7cV5IDOcKurNMVJemVHtN25Fc2jgUsLG4yyvp7qqt/nV+POh1pK21NT4u4b/3W6m8dcSULmu4rGQYZ9L8hr1iMacQOlQ5Fi/5miLrzMsBCGJwjiCWQm/9EW/4ugXCleXHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnnqky6U657OnYpFUuKjX2xn0UDmgOYtSanNFIn0NtY=;
 b=OYhjdPvOPBbqjVYDvfcJIKKHXf30EcEWggbhndpL/B4E72N/q8fBo/ldTCjpqvB2f0Hr0BIPp709Yi622TIJ+Tq0psx7kEc1WPn1sdC3ZVhg5V7ggV/JGIukmBvQbemjCcT1/2ZU8BYwp07WBQhiwbqn2+yDM/74hfD3cOER04mHeYxrrtMuU23pDbJOuxfmDAljLS3KO1PI0O+d25uzdS75N/CJo+2mcLcW+wu4642kj3vFQt1fgChyZ4Mm2KYsnEOzFSG87/6/bQ97MSqgLd65nYkAZR7Q9QekVSGxuUoBRhJqF3Js2M+HAbiXE4cgpdTVTUKh3/YP4B7c9LQhrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnnqky6U657OnYpFUuKjX2xn0UDmgOYtSanNFIn0NtY=;
 b=g/D25Rga4Z3VUdTXC+0zozJVN2oMi7R9POKOYmt4lIMMJoD+Vo3H8gle49kN2wmfjDwyN5wQCTbxWsgpDxwnkgagX/QxCV6nI2A76G5A6eFo8VQS85/35rbTIwhb8M0KRW8QsZlzr7HqTPpUedn1eDfRACT1hCpTiSl8PyIHpB8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CY5PR12MB6370.namprd12.prod.outlook.com (2603:10b6:930:20::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.44; Tue, 1 Aug 2023 18:51:51 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::44a:f414:7a0f:9dae%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 18:51:51 +0000
Message-ID: <6a80d9e9-aec9-2cbd-d65b-bb1e84b77b2b@amd.com>
Date:   Tue, 1 Aug 2023 13:51:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Daniil Stas <daniil.stas@posteo.net>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@leemhuis.info, stable@vger.kernel.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
 <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com> <20230727195019.41abb48d@g14>
 <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
 <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
 <CUGAV1Y993FB.1O2Q691015Z2C@seitikki>
 <CAHk-=whphk8Jp=NYmnm7Qv+vZ6ScYCz+rV8a2G1nD-AQY3z+mQ@mail.gmail.com>
 <CUHF67ZOFOTN.1UFE7Q1IFRQMX@suppilovahvero>
 <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAHk-=wgK0Z-LrJGExwG=e=oxjD93LJhY3jMmi_2O2_Pkjf8Tsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0019.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::24) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CY5PR12MB6370:EE_
X-MS-Office365-Filtering-Correlation-Id: f6360b17-99af-4065-bb6f-08db92c05e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmPByrTqVRhg08Vi0+VHNb6HiNDhYkfSUQRdNLew2m6bP2OL+wyAuRZ8UCKzaOON9D1zk4f1lAxRUWNmUKClCU5QWRgRv3Nycs5lvVXU8LOO1121HGiHwBgY5a8R3UqeoKqIPgqeDbwLzAA/FM4j8q6NImjJkCYzqvGcyOSJixotYn2hjCHKt5fIBZT8qNVZ6mS64DrzW9xtqpCSFFimng0yEj5F+wQhEocRiXxcuPIW7sLPqNTjaXtv+2NpKCtVTWQLxGRbGRqUnEtlCgoWzm1n0Mbhy9unL5OjUAhutvOudLPsjBp6c2S7CEzqyLi6mkoqpO4HF03eEW+tRTsdKkXPZF2P9PNkYdiDaeiye5xiZ/D/oYzZNv6B1enaoHCdzXvFtYU2bT27oeA+1GFjm0vvvDwIvPy1ROYyvptWdW0IMgLicTWZvZtaUd6QrDd1GoW0UEctAwz557J8HbbOcR6AHKWeuMg3XzS0Ml6kbpQrWbusx25dG6EIRnTAJZjYz1CXM5EEModXIMJ5IjlTTuCy0oO9fz1ZPzKWTCeG1AhLeGhQTX5vHtUEjVOaT3lK1Egahmp41BRg1QowhDr4jbT0aMmBpQ5F7kvakWABxMwYm5p5ZXoOz1Jhf56yEJnuwKGkTeaUFmWYoLzLR3ar5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(451199021)(2906002)(4326008)(2616005)(83380400001)(186003)(86362001)(31696002)(44832011)(316002)(478600001)(31686004)(41300700001)(38100700002)(6512007)(110136005)(5660300002)(66556008)(66476007)(53546011)(26005)(6506007)(8676002)(8936002)(66946007)(6486002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkFMY0s5M3JBU2lRMnJkYzJuOFlEQ3ZIdGZlUlhEVTBFeWt3LzFrNkpCUnN6?=
 =?utf-8?B?ajVhTjU0cVlmWEZnbkdZZERzZXAzdkEraElpWm5ldmJSY2U4dFhsVDQvb2VU?=
 =?utf-8?B?M0h4bE1ZZVlnUjlKSmpldDJWNDFHYzk0TE0zK094YTl2MEVaM01SUytyVVZw?=
 =?utf-8?B?Mm5QS2RVNWtrd0M4aFlSaC8xSXhPK1BuYkt6MzZRR1lJbmFsdVJXeUtIdnRS?=
 =?utf-8?B?aFVXMktBY0ZDT3cwdjJRc0YxS3BxYnZ3SWhTbnRSTGpybFBlYVo4eTdLNTVI?=
 =?utf-8?B?WmJFcVBUckszTXEyNm04Nkd2bFZDeE5sUnplNkg4V3RqWFR6SWNlQTlHR2pR?=
 =?utf-8?B?MDZqNFA5WTh4WlJ6THZCMkx0NXJEOWNkNzd4c3E3bG9GUGd1MW0rVUU3aXhT?=
 =?utf-8?B?aXM1YzZRUE0zTUlpZmlNcTlBbDF0UXBSTlBiQWk2OWZTQUh3VXZMY1Q4ZDh3?=
 =?utf-8?B?empOUFhkUFBMQTRlNlgrK2VVQUUvR2lobmhLM1dTS1JpNWZGeGdPZDNtTFlI?=
 =?utf-8?B?bXlDZGUvbHd1TmZqdzVoemhCeWE3WDZlR2tWdEZrRXdHKzhRcFpoNWhYc2l1?=
 =?utf-8?B?L1I0UTc3VWlPUjQ0TEhIOTBiUjhWMGlPMDVaSU4zNWdYcWF5ZW9yR0d2UDRB?=
 =?utf-8?B?YmNGclcweHEvZzV6Z3o5aXJNTFJaekZSTlZidkhlUDdRUUZBcngzQ0srcEhR?=
 =?utf-8?B?T3QwUHh3c0lMQnBZNjhXR01UMUgxekd3T1BnTHh2SS9MWkZCTk8yWWJJR1Jp?=
 =?utf-8?B?REpTNFBPeVlIbUZGV0FrWjBtU2dkTUVGRjBuQ2lydzJ3aTFjdjY0cW94YzlL?=
 =?utf-8?B?azdFRnkwNG1kMnJPTmhVTU1ZMFdjc1VOb0ZuRWozeW5wWVRuSDJTaUhDL2o2?=
 =?utf-8?B?S1cyNEJPUVFUV0l3WTdQY3padndHUjErbzVmb0prRUp6V2JHcGs4WUMwOVVz?=
 =?utf-8?B?dlZlUWFGNVQxNE4zR1lybzBUQ0ZlM0cybFpsK3ZQdWR2SUNVbjF2dm13d1VX?=
 =?utf-8?B?VlNEWU5GT2F5QisxVWttNWRFZUpmSWUrcHl5TWVsZHNaRWxhekwrb3UyVEI1?=
 =?utf-8?B?OGhMN0h3b095U29yZEx5Nlh1c05WaWRoNWJSR3RmbTBrQ0JkcHp1Qk93SGZm?=
 =?utf-8?B?SlQxWHZXK1BTWkkwU0dUUDlQVW41b2s4eFZTdThPTTAxWTVQS3lHT0lzV1hL?=
 =?utf-8?B?TG1UWm4zTTdhTlF5azFuOW1iVzF4RDI0WmRDZ00yTnJqbFZ4ZXFQQ055TFhx?=
 =?utf-8?B?aUJSbjZrSy91Q0lQOVZWSll0RWdMdDVucktJQytVd2JzMzhVVVhoMlhBc2N1?=
 =?utf-8?B?RWFFQzFhdWxhajBPM2JFbS9PLy9XNStOaGlQVEtoc2Q3S0lHa1RPK2lNM0V2?=
 =?utf-8?B?OVB3OVMyZ3ROaHVQd05TQjYyT1NhY2o0T3RVRE1jRTI4UnhBQUJjdXlCVzNH?=
 =?utf-8?B?R1p0ZTBtRUdTZzRNcVJKQ3lLWFhXQ1k1QWZDdnU3VGxTajFtUU5KSlBSemFw?=
 =?utf-8?B?UnAwNGxYN2FzcDFZcGVWemwreU1YeVZOaEh1dExEUGJSTEpnaThsdmNWMDRO?=
 =?utf-8?B?bjIvbXdtRlBtQ2gzMURKMnI0U0RjdXNSTE51b2NIdDYxamkyQ2tZWTVrQ1R1?=
 =?utf-8?B?dWVabVVSdGZRcXozM3RhTW5ORE50dkg2WEY3dml1N0lXVzludEZBTUlwdTBD?=
 =?utf-8?B?QW1BeE5ERWxKYlRmUlJlckR3dDZ1OWRGMmlFWlVubTlYZXEwa0RRc0hBRzNx?=
 =?utf-8?B?RUhocjJEQUpSWkE5UlIvUVFzUGd5RXI2UEdpQXdvVFdEMWRyUFdkdk5FOVdX?=
 =?utf-8?B?d3Z4ZFgyQitvVTdvT1NwR1RyS1VvUEJFVkdWdW5HbWRLZXdIU2YyUTJ6Uit4?=
 =?utf-8?B?aGJPQzd6d1BOZWhWd0dPUEV3emdMakx5RE1nUCt0VFowdnorNUlhTWsrbkV6?=
 =?utf-8?B?OWVtcWsyTjhrV2FsbGcrTTA0WkZuTTVmbCtLSE9sMWNEaGJTT0gvTGgrblMv?=
 =?utf-8?B?ZFBJQnByVWFJdEFnczVrdUZDdmRVaGdScTEvbzgxbk5scXBpN21GRXdWbjBY?=
 =?utf-8?B?ZTRQQmF2UG9QSHB2d2dYSVNzYlRjajdlS0ZHYjI0MkFEcEJPRmM5SXpCUkhY?=
 =?utf-8?Q?HPHKJnGPRsfMGJHV/yc0+/c4I?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6360b17-99af-4065-bb6f-08db92c05e37
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:51:51.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuvmcHG5eMvs0RrPmwNF2ZR39eoPjhxYfih+vh2aObcxbcbrlNwNnCrR1j2IAWl7O1i819FryPP1nehQAgR6iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6370
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 13:42, Linus Torvalds wrote:
> On Tue, 1 Aug 2023 at 11:28, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>>
>> I would disable it inside tpm_crb driver, which is the driver used
>> for fTPM's: they are identified by MSFT0101 ACPI identifier.
>>
>> I think the right scope is still AMD because we don't have such
>> regressions with Intel fTPM.
> 
> I'm ok with that.
> 
>> I.e. I would move the helper I created inside tpm_crb driver, and
>> a new flag, let's say "TPM_CHIP_FLAG_HWRNG_DISABLED", which tpm_crb
>> sets before calling tpm_chip_register().
>>
>> Finally, tpm_add_hwrng() needs the following invariant:
>>
>>          if (chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>>                  return 0;
>>
>> How does this sound? I can refine this quickly from my first trial.
> 
> Sounds fine.

This sounds fine by me too, thanks.

> 
> My only worry comes from my ignorance: do these fTPM devices *always*
> end up being enumerated through CRB, or do they potentially look
> "normal enough" that you can actually end up using them even without
> having that CRB driver loaded?
> 
> Put another way: is the CRB driver the _only_ way they are visible, or
> could some people hit on this through the TPM TIS interface if they
> have CRB disabled?
> 
> I see, for example, that qemu ends up emulating the TIS layer, and it
> might end up forwarding the TPM requests to something that is natively
> CRB?
> 
> But again: I don't know enough about CRB vs TIS, so the above may be a
> stupid question.
> 
>             Linus

