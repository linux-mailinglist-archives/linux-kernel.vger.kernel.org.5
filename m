Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC767BEA88
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378394AbjJITZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378353AbjJITZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:25:05 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C2893;
        Mon,  9 Oct 2023 12:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tts1Imwi9DcpETlzNVNUusCiixOxsQxHAbT0RAM3B9czRZRGaSKB8nNNof68M7wf5fkZNkkvNzbKNWsCVzmnAuHkjIQ4BuaXEUJnWWzRpJI+dzHJKejdYWyYnnpvKwP8CAcqK5K1DwdCNl3WaXvJTLptxG7sGRHz+M4gdtox5M9OAhX8XM3bL0aKADcFDKt+KSJP3u942ijf00ueSbK08fiedxx0qVGn8rQ+jqz8FEL3zjDzBMxrs+vmeI/6zGJ43MHspdvxShT5JPm9TzLsTw6fufpAKs3X5tArB77m7x3ejHGMHsrwV50Cp3SzifsoM/ShcbA/S0EC4ZFMg0oQeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qqcGTJeYiWdb1zEbeAAj9rO77Q1FwDuemz9LN4leLM=;
 b=Gtbl2CJ2pRMM5u1LR8ww7BFCT1pICA5wR3IEiF3HtBAzHcB5sBtL+ZA/oKBlFGpmiamSH4Yf1GwMWBY7FklIFupox6jgjFqHa6UllWwjyA7WHKSNuwwrrASgRzWyl53iomNNwyvUjnEUWl1Ftxub3M7lVyM+WxzjEs319U9Nc+Bz4LwunW5Rty6LUuZDsSHwWawcXHAt4ph2r/onF7otJ5mdagDsnlYHXFauY/R9Y7sT8tS8SFl5gNTL5cs7o/K4PuWeUbhywT9JTNnTFtJwtBX8gg2BX5997aTJSdjs4c8g54Nz00i2qNrrhld+W3bPcSqZS/pb9Z2ygtOQ/tL44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qqcGTJeYiWdb1zEbeAAj9rO77Q1FwDuemz9LN4leLM=;
 b=jycR+zO0deI283TxCSOZXvK8MW9MStr1IDFlcmu1K5ttzo9NxiqyOA/dMgilfQzlwEKqXLO/r4cvfEdv1UBA5+boWx2JpsHyQ8lIWxMSGboFj005EZp9YM/gMNuSAnWBoDdHDxAipfJik5mfjJ/3k80rEgkIjuDyzipgGOmOTzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 19:24:59 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:24:59 +0000
Message-ID: <66b7cdbf-7f47-4a2d-9f3e-dfc783b53d9f@amd.com>
Date:   Mon, 9 Oct 2023 14:24:56 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 03/10] x86/resctrl: Rename rftype flags for
 consistency
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-4-babu.moger@amd.com>
 <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0051.namprd06.prod.outlook.com
 (2603:10b6:5:54::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: ada35935-4ec8-485e-f9f3-08dbc8fd6dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OM2KkKD1tNsM54CN3YmBbm4PjDAi3sChlDGRsbSgzZ3Lh790TfztJiqkFaJsSc4xqkpcKp0u1NzsvsY1IMvsPhG+sauGuzMqd/c03yNUjdxsUcDMf5XfT2hCwshdD3U+69WKFI5/aAYwXR1IR/IypobbjHlFuqOTqDOI3yDX7KVWiNpnvNeBjIcsIoLj3HkZEhWGOVay6Bqiw5iS6vsEq40KY4kh8Pe01EawLqDq/7yOqAW9s2bB5jZ+CUQIz8gp14C6sr9OfUmhJLxqfVY0+3mVE+XFpTtR4Xq9FIVDXS/SGmJ+FclXaBFrB421DrFwu1kV8+KnqNFl2GUX+QuU6TRpSizmK9AU3OymGzZtFZjHYhqT6M7g/dzzQghEWGh0yaBtZ2A3OLTqMtE+fLi4aOYYGS/Zrvs64XmQAU0jUU0Muwr5TCoC2hCS8noOD0wP+aVY1akMHajTE/ndBJTnxUA+ikNeD1BBDxMkZj7BUoN3WYvhJBlV9QarL3aGgZoQalrvgOLeLajQbWPyoYXjMese7A3X1Rz9fhedxUDHCm13VpLXLeeSmJpPgk5Qy8f4xxH2oyJFcBu04VxfzSQHjfLBXFGkEjgANA3JVkM8yOMT0Q5MC2Oj4UahccR7E+9hWTPhGIUvmNTkqAZEymSl2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6666004)(31686004)(53546011)(6512007)(38100700002)(36756003)(31696002)(26005)(86362001)(3450700001)(83380400001)(7416002)(7406005)(2616005)(6486002)(6506007)(478600001)(8676002)(8936002)(4326008)(2906002)(316002)(6916009)(5660300002)(41300700001)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDdTN0ZxK0ZhYmhsSTBIUURZaDdQR0V4RkxsbGx6ZjRWUHVwUlY3S25BN1BJ?=
 =?utf-8?B?cVR2aVVGWGt0bVQ1TmxzR2x1QlR0UUtBK2FXNG9OQnJ1QUFMTVBjZEEycTFn?=
 =?utf-8?B?WStVSzg2eHBRUWpvWkY1Y1djRXp0alpvaHJaVjY1Uk0wWUkxcHByczBkRkVG?=
 =?utf-8?B?Rm1GT3dpSWRJR1VBaFI1NVFzZnlFSlpxY2xPbVV4UXhBT1JiQW1IRHhDL1Qw?=
 =?utf-8?B?bitwaXJSTnpReER3RVRzbUdQZDAxN1BDdUNCZFVEd0hGeTVZVmJBNFpIUktR?=
 =?utf-8?B?VnBMTFkxSGgrS0VuNzhXZEF1aWtaem9BcUljdEl5T3ZXNjNscGVUamRPbmxT?=
 =?utf-8?B?Z3ZIT0RxbENUbDNJNUIzcXBWbExEaFJaNHF3ekFZV284K3hQVmw1K3VLL205?=
 =?utf-8?B?WkRjQjJmU2hDY2R4SjdDKzZTN3g3UjN5eFZTcGpHSUEraUhBdFNQTmJzaktv?=
 =?utf-8?B?OWZSRllSa3RHMUZZL1ErU2l3K3FwWjdQTlZMSXhNeVVHSHUvbHUxOXcwU2cz?=
 =?utf-8?B?MDZZVFBmY1lIMzlCUzljTTNmUDFlaTQ4MTREb3FBa2dKYkhxcHpKVGdDWUox?=
 =?utf-8?B?azJRSkt5emZoczZ5NldPUHZUTUFIL1dlNG9Na2lPY1hmejFrUlEvcUNZRlF5?=
 =?utf-8?B?WURDY2ZQNWZGWTRLd05JbzVPUDFrQTY1YjN6VEdxWitnVzlEVFdQNjlkTVdq?=
 =?utf-8?B?WUlvL3drM0d0RWQ4eGtNOUNudnUyRmJ5eWNWcUNwT2pnTFVhWVJ2d1BkNHRV?=
 =?utf-8?B?MDYwUjJPYmpXUW9KbzM4a1V4ck1kVFVUdE1WdWlMVHlZdWU4RnJORjIzNTFo?=
 =?utf-8?B?dlFsaWFDc2dIL1Z4ZEowKzdXQTVUZXZZVlY5MkR6elU1K2J3cXBrcE1tdXZx?=
 =?utf-8?B?USt3V3hyVzl0LzRYNDcvYW0xdkYvYUE0aWUrTGRGUmlWWE9QTE10eWE5NUNW?=
 =?utf-8?B?RU11ek1oTEZubGNoRys3Vk8waDhRa0YvendEak1KY0hTVjB2UzYyVlJYdVVn?=
 =?utf-8?B?dDVocW1rQnA5Y1BnOTZtdVIxWEtpb21XTTlRSnhDTCtxK0hubE5iVTlBdmtX?=
 =?utf-8?B?ODFDYkdhY1R2QnlyRUd1dkZJNzhWYlExYXF4MlhSTUQzN2EvbGJQOXhUdGRK?=
 =?utf-8?B?dWROdEhaZUdrSlRWaS8waGpQakdsUndrYVY5KzZZZmx6MGwrY2V2MHpSVEtS?=
 =?utf-8?B?a3lZZUdMeUU1bGVsb2ZPU1ZUK3JoY2pGdklxTTh3T08xYmQzK2ozNUZOUFV2?=
 =?utf-8?B?YVBLYUpqUThDaHhjOU84SmdJMys0bkRyY1NXQXhxTmRkTE1ibS85dk9TSDIv?=
 =?utf-8?B?d1pWaDVyUVR5S1VKSFAwWTY2cU01WThKS3IweUVvWlg2akVmS3g1Slljd290?=
 =?utf-8?B?bWQ5dXRGZnFOa1JOdVNhWUVTQ0s4RnFONkV3NkhkTVFnekFjZnJ1aW5xWnli?=
 =?utf-8?B?elQzdU85Yzg3aUNvR1JEb3NOdlc3b0lxZDBOZitvVVpBT3ovdVFUeHprQndZ?=
 =?utf-8?B?ZWxmaHhnNThoeHVoa0NJOENua1g4bjVsai9pNGUzU2tra01wOVdMYnlVR0xx?=
 =?utf-8?B?WlZOUDVmS1pJQlBMbzgrUDZDVG51UFhFQm5HejRSenVYbERYU1IzTmdOdDUv?=
 =?utf-8?B?ZUFQYUlLbWQ0NHJOYjNzNUd4a3RqMTYxR2dRY21SMkFRQ3I2cUdtcGVQN21v?=
 =?utf-8?B?U0VEZDczVU9neXBoL1F5ZU5LYzg5RTFJUmhBOWQ1TWtxbUxCVTRRWUw3Nlhr?=
 =?utf-8?B?MGZ5Yzd3QWJPdUJpUWJHQUNvOXJ6ZWhDUWhrbWhxRUJUOXJmb1ZHMUJaTGdL?=
 =?utf-8?B?NGdFaU80S3dmQlZpS3hKS2trYWZFSEpJUUMwQk1pOVFVRTFaK0xXSzhIcjdI?=
 =?utf-8?B?cW42dXhVMmw5VlBQZmV2UVdDYVVXaisyRFQrUGlKcUMxU0JLcnpQdU5XWmhl?=
 =?utf-8?B?Q0tQRFZlZEVYa1IwRXBkN3dERkpxR29IWWUyMWtvR2hwUEtFUGJLQWQ4bzZ4?=
 =?utf-8?B?dnFkU0xLZlJPeGE2cnBieE16SmpBS1R1RTRhL3BwRWtDY1NORGFwYS9PV3lq?=
 =?utf-8?B?MEdkRWhUN1l6OE9lNjJoSjkzMngxcVBPMzB6UG1DZ0RmeDVFc1o2dlNqZEQw?=
 =?utf-8?Q?t6bU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ada35935-4ec8-485e-f9f3-08dbc8fd6dbb
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 19:24:59.7491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEsSIXjoYlD6r8NqP+1or5qIr5KVVnSQwHS6k7OrzsvLPxxAci9EIKRktrR1eQWH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/23 12:19, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 06:54:23PM -0500, Babu Moger wrote:
>> resctrl associates rftype flags with its files so that files can be chosen
>> based on the resource, whether it is info or base, and if it is control
>> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
>>
>> Change the prefix to RFTYPE_ for all these flags to be consistent.
>>
>> Add RFTYPE_MON_BASE that will be used in a later patch. RFTYPE_MON_BASE
>> complements existing RFTYPE_CTRL_BASE and represents files
>> belonging to monitoring groups.
> 
> First of all, the concept of "later patch" has no meaning when the
> patches go into git, depending on the listing order.
> 
> Second, why isn't this define added in the patch that's using it?

ok. Will move RFTYPE_MON_BASE to patch 10 where it is used and will
changes the text accordingly.

> 
> A patch needs to be a logically separate, possibly self-contained
> change - remember that.
> 
> Thx.
> 

-- 
Thanks
Babu Moger
