Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D455E80328B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjLDMZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjLDMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:25:22 -0500
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn20800.outbound.protection.outlook.com [IPv6:2a01:111:f403:281c::800])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEE7CD;
        Mon,  4 Dec 2023 04:25:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkpxHpDHyqaPPOtZC1Jnb5b23VtEaxsjEihAITQ+NW7Hbl1iREopjZ8kgNQ1V+NxgvxiW8DPlLb9TDXs41P47wzl0/EMhNk3ZDa2/ZePNhFDWRvyRLOHlTikgpU0UaJMX9ENSwaPUkja33iO+AKfCpzX3bsPoUeHxtDDdKNmG86srBNmCyWE3KieMoX9u7wkBOXa3RwR+kTJw0kSYBaPq1MJbrYv44+EXqyTDRCMvZqbePGWR9cjJNxkW9jsBQAEKaFe3tQreLnhOoDFL2keTZ5hY30BtW22zDBT9+EJSh44fe5QDrJOWt8QxJpQM45JpcLA98kKmaLHM4BFwDeFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B43zteGYEB+Svgl8FbBTODYFMHVkgWDwDnQxnZU/N5g=;
 b=UfN+ci5fcvotjL0jap0Q0jfqQcL7xZbF/3TI+Ch00f+xjdheT4pH6iGWNLizBZ5h4+3ms8XE5V5UydZsh8EL+1B+6hBv+i3vGvFnOY0yeehaX2Q9PAPK14+olkbc9e27G2IhiVm+Ca7Wbag5543DB1wdI+WSMZij4fkDzUS7TjCnjv+nkZGcHf+aulk+h9ILsh+RNBBUT+03mZTidskdBULnvTMnMZzo3LKqspsg1zZ4CiBjcRB5bKwxUQPZAaESb1OXoqL5nfpwgXbwHwWN0UJhMUDWUJ2eNN7rOg04ZjNinSyBH74A/LCfiKonOOJrromeI/A5Z2ggyVaZNCcZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B43zteGYEB+Svgl8FbBTODYFMHVkgWDwDnQxnZU/N5g=;
 b=Xy+uhazpOLK9rWSLVYDM4Xvbn43ynIILzEEVSOUb4/DYtXdQ6y69tYkZdx6u/RDpPFW97tsdZxLXBdQdM4BnQSl102AKzGPTaCHHYdEDzvIFClq7Yy77bDoGXoIhWXYctrP7/myV4c1zi41ag7zqVG0lj2Us7t9b1NwI7F0YK3iX1e1LNTee0jOHPz7WLfaQ5LNT5tU3FyuWLwTEQ0mlssrLFTytXKz4uPNKWWtKb+X6+fwhy5qJBuxq3SU0w0V5KJlmuQSKbLaBfhCiWRT2q0djP7JYPehZKTYsYPGflQUAlRzcKYqGpGgtZF46wMh/mRDQ7IqGq9RTSfiEO/6fXA==
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5) by
 PN0P287MB0601.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:163::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.33; Mon, 4 Dec 2023 12:25:19 +0000
Received: from MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3]) by MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
 ([fe80::b1a7:eee7:e903:9ef3%7]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 12:25:19 +0000
Message-ID: <MA0P287MB0332862DC235652C83B4EC2EFE86A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
Date:   Mon, 4 Dec 2023 20:25:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add Huashan Pi board support
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Conor Dooley <conor@kernel.org>,
        Chao Wei <chao.wei@sophgo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Anup Patel <anup@brainfault.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <MA0P287MB033290A6C8B15202E31E43CCFE80A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <IA1PR20MB49537B177B6F3614D8D1E3E6BB87A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <MA0P287MB0332AE2378D633B8A2DCFB77FE86A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <20231204-crane-wolf-95f32865db62@wendy>
From:   Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20231204-crane-wolf-95f32865db62@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN:  [AoBE0TxFN4rZphkfgfxLIZjer/394qBm]
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To MA0P287MB0332.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:ab::5)
X-Microsoft-Original-Message-ID: <5eb4c63d-6af0-4f4d-b918-d6af42a9ea62@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0332:EE_|PN0P287MB0601:EE_
X-MS-Office365-Filtering-Correlation-Id: d49b98dd-ba98-4738-f89c-08dbf4c4139c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyMeu96QqvkX3cgt7Fni6F6YsKh8BImv6c1MXTc9nV8eXkexzmb3wonUUBW0JSLX3roXwe6yCk/MV66oTdm98jedf9PVb9moiJNAL/yAZyVvcOGFLL92ewQFFeNiT+STrpZGbPIXpeRpzlX+kU6WLg3TuB5HitSAmhfMTcpNNWqfnMo/y6mOrMVWZKXRXcakPujvC3LU6cjEK/75HGpH1gcwXgV5TunuYl4vQWwx170rcOJmFJBk6vjm9FFit73+oIdq819vZySxRl9SOiFL7OyLJLszCAdid672k/WonopI3HYIyUTWlYcxryvN9nTWBcRVPvuUjJvqDVKP7hmAF0+leXFf/+6R0YQC+smrtnpPQvRsIRpSKysEAoUwy/4RyKmLDidICl+cCcjZm0Sf16iK9M7n5QEn0z13AZ4bL8NF6GhWOCVpHDsMqwikv+vfes0AjiRb8z17eKN/saG5Aou6eRdghVFlbctSUCYqXCdOg4ODRaFVNLtQNgNVZNbeJg98ChGdC6yrRhLj1PgvFgzoSiQV/+lw93Pdl5pIXT2os927czoYnC2vqohOuDN1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTd4eEd2TmhqZUV3OVRWQlVyN3pBYTZwSVpEK082dFNzbm56S3JXOXB4UGxs?=
 =?utf-8?B?SCtldlBCeFMzNzROZ3ZGeW5tL0Mrdi9oVWtSNHJYK2QwcjA5ZGJDdUF0MTl5?=
 =?utf-8?B?a0JvbktRWDAyTHFZU1BEdDJzRGlaL2J2ZGRoMFBzUUdwQ0dGWGI1ZlBhWVJH?=
 =?utf-8?B?L3RydjROZ01jUkJXK2ttdk9HN2ZlNk1iTVB5RVRCa3d5OGNMbmlneFk1WkUw?=
 =?utf-8?B?Y096YW1SWmhQL1Z4aHhRK0pTVEJDV2t2WmxydWc5MDlkbkZQZTFYNklkODNJ?=
 =?utf-8?B?eEtTVXpHWVAyaEpObzl4TEZjZjFsckRBeDNwSE85ZlFnVjNEeEVlbExCYTZC?=
 =?utf-8?B?UGdOcWxlMjY0clhmSEY4d3RwUFVzNXFsS1ZSTUtIdW1tbjRLQklKa05QMkpv?=
 =?utf-8?B?ZU1tRXpMQThjTjBRUkV5WHYzODNQOGI0Z0hHbHhIeUlIM3dNNHA2dDI3M0th?=
 =?utf-8?B?SnJLdFNwbjlQZEM1ODMxZTdndFFWdlhFRWRyeUN2L0hoS3NEcFEzQ0h3NW9N?=
 =?utf-8?B?dVAyMUJvR1BVeGw3LzdzYjRKbGhtTWNndjBGLzJtWEZBZy9selQzK0FjU0xU?=
 =?utf-8?B?ZTFzUGVONi9wUCtaU2hBVFFMTVJQZ01EVUNJZGsvZnQ5ditMcllTaktLaVVs?=
 =?utf-8?B?STFzRlpzbWlSejE3MHlBb21OM3FHcEVrYnhoQ1RkVnRwaDJyRHRCdTRiMGpp?=
 =?utf-8?B?eGo4dHEyVXhKdnZCN250RUxSdGltUTBpZjNzMnAra01xMm04SHRqWWZYYWpj?=
 =?utf-8?B?MmJlRXkrNzk3eVVDR0ZwQ0lESzc2bVpvd29OSEtBVm1yREN6WW50WGtUU3dq?=
 =?utf-8?B?VU0rbDdic1o4dy9qR3loLzVxbUVCS1J4NUpYL3lFb1dadU0wY2FxZUd0VXI5?=
 =?utf-8?B?YVhLOXk0aTFoT0l1MHIwQ3JEUlg0cFBsKzdxZEJyNENsWDZtNWp5V0FiUlY5?=
 =?utf-8?B?RkJxZCtITjY3RlNrWHByMXRMSDJEdllmcjZ0Zi9JOWxBdFJObTJxbm1hL0p5?=
 =?utf-8?B?eXJJWW5wVDR0RDBRZ1QyUzQzSnBHR00vMi9leWhSU3hTNHZBcDBEWEk2Qnhu?=
 =?utf-8?B?WlZReWs4OEFTZHlGbm9tazV1cDBpcU0xakhwWDRpa1hzZW42UnlKb0g3NXNt?=
 =?utf-8?B?OXlEeE85QXdBRkhySVV4d1BEdzB5eVIwSWx5T0JJSE15WTVjZFFQV1R5VTM1?=
 =?utf-8?B?Z3JmdnRJcXFwaXlUTStiai8yNlRDZDFXYThPdTk1cDVhSnBZU1kwakRpN0hR?=
 =?utf-8?B?ZTB6QytNaDllZ21ueVZmQTAyUXEvVDNQeUVlRk14T0twZE1QaERETHVXRkRW?=
 =?utf-8?B?OFRHbFdNTjFPbTd1Q01ybG1LaGhlNGp5d1ZPVDZKWW5odHdIK0JhQUxLaklP?=
 =?utf-8?B?ak5maG1LK0pMTXM3Sk96NG9YdjlrMWd3WFBoWlZPbCtYMTlKUWdPU1BoYmV4?=
 =?utf-8?B?aU1TVDA5NmJuMU9kUFg3bW1uTHNoZ2k4dVM3NlpDY3pjNkV4enFRUlJQVXNm?=
 =?utf-8?B?aVU5bkZQMkFTS1Y3ajNDZUVadXFPeTM5V0JyUlZmNkwvSWp3czdPcVovNEF3?=
 =?utf-8?B?eitOTUxWQVJKWHp3aWp3WHR0bzhOSzBFVjdxUjAwUmlnUzJOTzcweDVwSmdz?=
 =?utf-8?Q?e6zCZ6sasrMLR5yp9w3XRMQMLrSAJeON3NK4odQuOK7w=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49b98dd-ba98-4738-f89c-08dbf4c4139c
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0332.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 12:25:18.9745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0601
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/12/4 17:32, Conor Dooley wrote:
> On Mon, Dec 04, 2023 at 05:15:36PM +0800, Chen Wang wrote:
>> On 2023/12/4 7:32, Inochi Amaoto wrote:
>>>> On 2023/12/2 0:21, Conor Dooley wrote:
>>>> As far as I know, sophgo's SoC product names all start with "sg", while products starting with "cv" come from CVITEK (another chip company). CVITEK was acquired by sophgo a year ago, so now many SOC product names that originally started with "cv" are being repackaged and changed to start with "sg".
>>>>
>>>> For the cv1800b adopted by Duo, Sophgo has made it clear that it will not change its codename.
>>>>
>>>> But I heard that for other products, such as the cv1812h used by Huashanpi, sophgo may change their names in the future, but sophgo has not officially confirmed it yet. Looks like sophgo themselves are still in the process of digesting cv's products, ;)
>>>>
>>>> Since we have just started to support cv1812h and have not done much work yet, I suggest not to merge this patch into the mainline, and wait until there is clear news before doing this to avoid introducing unnecessary modifications later.
>>>>
>>> Hi Chen,
>>>
>>> There is a update for you. The cv1812h does not have the A53 core as the
>>> sg200x does. Maybe we should treat cv1812h as a trim of sg200x, not just
>>> a reband.
>>>
>>> According to this information, I suggest to preserve these code for
>>> cv1812h, it can make upstream the new soc eaiser. Also, adding a new
>>> compatible is not too hard, and it is necessary if we have new soc.
>>> Otherwise, the one with Huashan Pi now may be confused because it have
>>> a old version.
>> Thanks Inochi for your info, let's just preserve these code for huashan pi
>> now and keep watching on what's going on then.
> Could you explain on what you mean by "preserve"? I'm a little unsure.

hi, Conor,

I meant keeping your changes on riscv-dt-for-next and continue 
submitting this patch ([PATCH v4 0/7] Add Huashan Pi board support) to 
upstream.

Sorry for my poor english, hope I have explained it well. :$

Thanks,

Chen

