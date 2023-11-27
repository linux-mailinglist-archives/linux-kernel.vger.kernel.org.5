Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DC47FA42D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjK0PMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjK0PMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:12:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5623990;
        Mon, 27 Nov 2023 07:12:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gz9WNvwc2X0MMNUsjaRFvdcOhXKIlzq58vYEzKwIaGY8qXnAZ7BFfLvccV3tKFrAekHQ/dv4oxIyCv13N1DeTunTLsB3G6mn37V7vXxt8XwPJCcySAAtv0AgNI1Hlt3kYYXAunnrPFG2bSuQG44d33dxVj2dLXEvFPZ32LjHdxVZwABQcTGDDevz5x2xHN3PGpZKjPZZCcix9xsA9PJCASSyZjbVwH5OGtWtrzDVCcnN5/sc5hUScV3LQ1pel87esOtUGK9blJN+ZDN2UueM1AGFiy9Z+0sq49U8mTmc3KedWSvjCBjnwTFVNz2mkPZds9w2tVSW0f5lh+Bf+JIZ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQdtlDPT1+jA5kmF+dafsyMH2plPOkLaYXlrejzNCOU=;
 b=HeE0u5xdsYS9u/4Ke4+Fvwd3iazGdWrWUQgLFL818Dk6Y10v+oSNGLJ3qxY/5vuC7i6bRBJCJiNvN50FaC3OpgymN4tCwmrSSWaAlol5Pc6BVr3xR9ub8AG7APgOBs7faASj1K/4sqwNBRCeTME2Q/s4qo9qsEp/QaAGfa2zEiS8bVRtXskXWQde66/bPj4gwjU67BYwgCKsXQCUGl17reoFWyIDEGgExuzeB0sc4zKJqb99nrQvDBG5XtaKGo/HEfKlGZP595QGrtdIRBdL0nLCHRnBOLKx+4IXKDS18ux20JAR04fvQ6IzaKrOJdHJLk1s15Db8uXyMjJRHKYU2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQdtlDPT1+jA5kmF+dafsyMH2plPOkLaYXlrejzNCOU=;
 b=FvpdQP3ykZSAQbnihO81v43CADbDefNqX8OZYAMiJaBbvUS9VE5OfqVvHojwwkNnDY2tAlLh4MJUC+Vrs/ETK/DHlVcVDd2iN9vxWnPgfRd0TpAnceXDLxrXZ3RCv77UmZzDwrYyp0XFgE9NCqBqr/caqhoFcfdUXyCfVJRUQTg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SN7PR12MB8028.namprd12.prod.outlook.com (2603:10b6:806:341::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 15:12:18 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::a9cf:f8b8:27bd:74d0%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 15:12:18 +0000
Message-ID: <79e63555-a46b-43aa-ab2c-161e1cb80904@amd.com>
Date:   Mon, 27 Nov 2023 10:12:16 -0500
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Avadhut.Naik@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        amd-gfx@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 06/20] x86/mce/amd: Use helper for GPU UMC bank type
 checks
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-7-yazen.ghannam@amd.com>
 <20231127114648.GNZWSBqPq3AzQkwk+S@fat_crate.local>
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20231127114648.GNZWSBqPq3AzQkwk+S@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0599.namprd03.prod.outlook.com
 (2603:10b6:408:10d::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SN7PR12MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0b4a45-4a79-4f1a-55fe-08dbef5b3edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pVWmFKHr/7fAOvdWpOM7FcDP07didhi5w9ZQlBy/s9LjGpbsPd3KfKakDXPdZp8cmB3Zh0SVMCextKwPXemH6tjKnfTXIuMy3hw3s8v+rqvjVwdKKjmMT5UlQnvyyaf4ZrLkJUFSXrcIH/NqLslnObE6kgklVIBHTxV0m9Yl2wizogRMf47SkP0wrU63B69GNu9J6YGswcpGnQLonQveeRebRFeBxkNlS9kxFqTZW49aAUKDggMxvji8HyMUGvT/jQJ07HIuOaUFM9TUi/yveKMlVJgCfSIEmzPJuS+Q+y+apYe7jyG5Hfe/BQYS2gXSJcR4koLiBwh2Rpds+A8To3Dxuuxm1rGfnitYRzKcviFTyRp5D/IDIghml7TvHg2/Ymz7qr2QW9eUAHbctiZ2q9c11uQaGP9DIVPQCoMvixItkdo7zUZGbL4jtWTwbiv3nMzJ2Syspt8jrjtdrblbyRfRHj+D6z5pAl5ae46dD6FMOxhXlO5sXFkRN7GURBNTtEh4z6+QIAxBJeHEIeODbjijNMYtkRbGrNVKaZ/WSaVaAaXmJE43bUq1TjDLFW+iOvwqm75Xh16ku8f9UaPtXClAwhRbZtWOo/kzi2c6wJXbloQV/60l/32NmmgD+zL6qpwlsuVdV87PWdqNjeH1rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(8936002)(8676002)(31696002)(4326008)(6512007)(6506007)(53546011)(316002)(66556008)(66946007)(6916009)(6486002)(478600001)(15650500001)(36756003)(38100700002)(41300700001)(31686004)(86362001)(26005)(66476007)(44832011)(2906002)(2616005)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGd5cnI0VDZDa1JTVEJvcndINGhZbEpxTFhUQVUwakpIcnRtRzkzSEpKU1Zj?=
 =?utf-8?B?V0lKYUtoa3BnZXpyQUdDVDBnM20xNzNENml4dmZHaGNldFYrWkZOZHBxZWNN?=
 =?utf-8?B?MUowaFEyN2xpdHg5QzJzV0g0UkhmN3c5cFliN081MFJEUGtwTzJCNUMxTmFQ?=
 =?utf-8?B?V2FjWGhIeVppNHZlVHJlRWtBT2JjM3g3L2dYMXAzZE9xcER2amhEelV0TkRL?=
 =?utf-8?B?amtVYmhJSmZTWmR4SUZGbDF3SzBMSVdUQ0N0bkd6anluWHZNZkpKaDk4ZEc3?=
 =?utf-8?B?bzB4R1oyR0dCeGNwaDEvdExIR3plR2ZYWXNIY2RRVTB1SFBVR0pSY05BTnhZ?=
 =?utf-8?B?NElBcW1zZG1iRmdzclVRc0tyM05iNFRsTythS284QjBPdXhOck1yRks5c2dh?=
 =?utf-8?B?NWxjUTZqT1E0bWhGOE5lM1FLUnlFOXBKbVdILzMrKy9JY2JiL3FxVzFkZ0lQ?=
 =?utf-8?B?dXN4WGFyQ2RTbFZNa1padGN1T0l1NFJ5SzFwMzdHZm5xMmgvZUErR2RqWWdW?=
 =?utf-8?B?U1EyV0h2T241d05kSUdSbWhZWEozU3hkL2paaSsrVzRoR2F0WmkwQk84ZkJr?=
 =?utf-8?B?VzFNVDJ4RE4vT0Riei9GNEg1azhocWZjOUtIU1NPUUtBYlJqVXhwbzcvNFFR?=
 =?utf-8?B?TStERURXaUhLVVlpM3owbmpDeloxb1hoaWlOTHFkSUl4WnlTUkg0a21xZ0Ew?=
 =?utf-8?B?dUpEeUVsZThOTE5jUEkvRnBIMjc4MzJtUW5KaGoyQlFCOWZjQ214bzNIVmtQ?=
 =?utf-8?B?ckRqbE1XdkZmWm1rbVpVYng0L3lDTnVkcmNwL044M2dnQWlZSTFOZzRpMXpZ?=
 =?utf-8?B?RGcvK2pianM1b29hNDRTWkhoODI4K1o4aFFRK1VUY1Axd2FJRkRmT2puams0?=
 =?utf-8?B?MkhBV3UwSmxyQ1Vpc09xdWtIMVdkWXpUU2VpR2ZFc2Z1RHEvdmlQbmVHNmVK?=
 =?utf-8?B?bWg0UzlycTdSUjNhTjBkVDVzOEt1OHBuOXcvNk83UlVhYUhtbExFVFd4Zzkz?=
 =?utf-8?B?a2xRS2pKblJiSnlZV1JmTG1Kd0hUTjZCTUNjV1pyQlI2NVhGWXk0ZHpmWUZJ?=
 =?utf-8?B?MjVwYytmMFNIMjA1b0hjTENaQW8zcmt1Wk1Ed20wbE9ueXY5S1dpWG5hMWZs?=
 =?utf-8?B?N04yK0hFUmFEZGkrSHV2aWhuVlVhNDJ4dmRMWVh6cytqcjdYcTlWQldvSGxr?=
 =?utf-8?B?elRXVEYveDVwRUt4RzliZEdkN3l1eXgwWDk1bDU1QnU5bG4rUEF1QmRGVDdv?=
 =?utf-8?B?NmNXUlZucmZKU1lSVmkzUi8vNmVseUNBc2lvY1FnVGhITFFNMWJvQlZlRTZU?=
 =?utf-8?B?dmFQT3BnVCtPc081MTRTdDduZGVncXN3QXhmL0xraEd6ckcrYWNpTElISldx?=
 =?utf-8?B?VEIwQjhQTDRGamE0YkNmN1RDMC92aldtbDBtRE82T0t5dFlYL3ZZengyWmIw?=
 =?utf-8?B?d0hKSVNWMUJDT0VKay8xOWpycUZCWUt3c1dmaVh0Wk9iVjN6ODl5M3MvbTht?=
 =?utf-8?B?bjBZQUpETTQzRCtudHZGR3ppN2lmNjk5QUxwVzJIdjFFU2x5M2hQalhMVU81?=
 =?utf-8?B?bjlQcVo0S1llanFLeUpYYTQxQmJjOFNpbE50YTRibzVZNms2YkJpS0Q0UkV4?=
 =?utf-8?B?bGRXSjF2MkRhWWt4OGdrcVlOZEJDYzJoelpIZFZkQzE0eHNhUTJSYzY4dEVh?=
 =?utf-8?B?Tks4d2l2MUZ3UkhjU3lCd2ZQQ0hWdytIRnBaSWFqSEVMalNSb2d6ZjMwNGlZ?=
 =?utf-8?B?MXJueFZ1TFRBZE8vWmdydHpiNklabll2MW5lVHNhb0UrZUpJT3JiMzhmSHZp?=
 =?utf-8?B?VFRISDVnd21NdTJSTjQxL1Z1R2tsRWd3SFBoTEhVbzRoejg1MFdaNXVYZWZM?=
 =?utf-8?B?VnlXamVkWEtRTE4xajZhNHV6RVpRSmJEWXYxdWlmM2FQYUdpa1NoTFRvVjgv?=
 =?utf-8?B?ZXErNW0rUmsrbFA1eHlDOUhXZkFHb2hjeW5zTzg2SDBWcExNYlByeDNaUEli?=
 =?utf-8?B?K1Q1SmwrMm5oUzFvZmszcktIVzNtKzNvZmNzUFArZkQ0eGNvNUlGRFJ3MWRh?=
 =?utf-8?B?cjVobDNtRnNxU1FqSi9aTjc4Vm0xeTcyNkxuRmN3d2paYkFwTzlXY3dKUFVF?=
 =?utf-8?Q?UQY3K9DKG9pt4XHt2Z+PBNNJ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0b4a45-4a79-4f1a-55fe-08dbef5b3edf
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 15:12:18.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HhnYd8lOIKGI9YjzlAhgwzXWskKNfbqQQ3pNwJ5n9215iZUXd8t33SBl7MiLoy2nm2m6CDjReCL0JpyOMPGuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8028
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 6:46 AM, Borislav Petkov wrote:
> On Sat, Nov 18, 2023 at 01:32:34PM -0600, Yazen Ghannam wrote:
>> +/* GPU UMCs have MCATYPE=0x1.*/
>> +bool smca_gpu_umc_bank_type(u64 ipid)
>> +{
>> +	if (!smca_umc_bank_type(ipid))
>> +		return false;
>> +
>> +	return FIELD_GET(MCI_IPID_MCATYPE, ipid) == 0x1;
>> +}
> 
> And now this tells you that you want to use
> 
> 	u32 hwid_mcatype;       /* (hwid,mcatype) tuple */
> 
> everywhere and do your macros around that thing.
> 
> No need for yet another helper as this all is static information which
> doesn't change.
> 
>> +EXPORT_SYMBOL_GPL(smca_gpu_umc_bank_type);
> 
> Definitely not another export.
> 

Right, we already use the tuple thing. Patch 8 in this set uses the 
tuple to look up (search for) the bank type at runtime. This is in order 
to get rid of all the per-CPU stuff.

Now I figured it'd be good to have special helpers to do a quick check 
for the UMC bank types. Because memory errors will be the most commonly 
reported errors.

But it's likely not important to save a few cycles here. Especially 
since the helpers will be used in the notifier chain and not in the #MC 
handler, etc.

I'll think on it a bit more, but this patch and the previous one can 
likely be dropped.

Thanks,
Yazen

