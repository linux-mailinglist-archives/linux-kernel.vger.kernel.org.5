Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA4979003D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242118AbjIAP6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjIAP6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:58:39 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40C10EB;
        Fri,  1 Sep 2023 08:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjaQG8QAyz7t7LoySZtUryqpEqdiOa3n/SqX4n/wuzS8h2kIGhRMWcG4K9KhDUm/XKStnGPzRfVrMYuNwdmvt/NVL/uQbB/7zJ5QMD1ifBTWKmAoUjuo2KvlBv+FKjpzmGlWnryzh1/LB8pC5CUcAikwhGDMtyCx1M73H4y3vT4H4cb1NMHWL9K0PTMhWUSPvcTFWhnxllKtMgSps8eqj5VsE5N1GOmz6vDCs0K/unuhvKwMJsCWxM2eYXmoO9/OQd9z6kVbszxkCp7B+04cfjhW2Ur4jK+N2OjLtUc2kQFcMTYd6vapUJtTRWHrXHAIJ1cvl2/fkdUhkt3VhPFVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12wN1R2r6I+HqYuG1gQi4eO2cCkmw8CdZnkkGx81uc8=;
 b=Fvmj83ExtO/1PzDrLR28U6fiTRNQBi26WP2CxQu3pNEy3hpzoI9mapU6/2SO4usEUJXDvkV+j9rKLILwtvwv8JbeSFb5lNvEODKHZ+nepbuumesMTB8c3zfC12rjAVs/S6SgpWr1h9HyLpowUcxKKALg7FwzOKrRd4S+N+AfDIZXcIX4T95dDPwSXP+A2H8C9lgI509OdLCKlcLe5m2GdXL3BVPWdMiR2giFg4FRSLLu9IJlnot/VJCS7dOZGwI+9wjQ0HDGgeM/jfm1w3tW/XdUIUKfUz/A0/4O4s3d+wcLw040ceY+AyXr1zWUmDzOw4xLEe6Am+/jQjeSLfovPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12wN1R2r6I+HqYuG1gQi4eO2cCkmw8CdZnkkGx81uc8=;
 b=ok68auuGO7Y4aOO88KUZ+0lsAEveVop2JAzfyOHoZhzLt9HPTLG2W+romS6AxfTTSHhEUhUt+UBaPjxHgA0ON5918hkO8R6ZOSKJZe89GLJGjUxL66lrIPhV7E30dMFRCGBp0hmWxUYcphSfpBUJOZT+0/gyWwezy6lS267m3DN1pQEb7fsVbshK8yH7oKLa5fNnviB4b/XuvdXk0lguPMQtXhNARzBAMLsESNVal7pYDaho2ZUDf0jt2tEz+TNf6GbEJF9iHevpBzfH+/nVYgGe6cRv3PU9xznHM3TPBHhwCoIUiHAFhr9Z/dxcARCyqP7138kYNA2XjkDDyUEZbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.22; Fri, 1 Sep 2023 15:58:34 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::1d1b:2ca4:1600:a865%4]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 15:58:33 +0000
Message-ID: <c2bc6447-d8de-4f0f-d735-df377ab40f1c@nvidia.com>
Date:   Fri, 1 Sep 2023 16:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [Patch] driver: cpufreq: use refclk delta based loop instead of
 udelay
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     treding@nvidia.com, bbasu@nvidia.com
References: <20230901152046.25662-1-sumitg@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230901152046.25662-1-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0639.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef86c18-452d-4944-48ef-08dbab044b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8G2MM6d0tt0CZPR6UP9B26Ltt4BOo9UsmXr1POLpYU8HBOyHACkhBNLN9J0/f96m8roUDFjvi5hmpUknlch2Q9YjsWJGrjDo+7y4IroKtlaV7KPhLF831mOxNE6+2C6mUgwdqckDwyXVLmHbcwX3zEzovyeNuI2MXalKDGb58XBsWjsQwfrCHSsvGb4Pb9UnyTtNZfHluM2fYMdRXw8FQMEDeOHLrU6TsKz/hKa2vfFxzv9JsKQCl5xiq0pt2XXAQdO952o/hFfmhBp2C2sAn/2CqzSz9esiT+g4x9BhWFzU5jpjt2BqVsz331GU5VPwwuB0jXMjr8rvTEke6GPK3OJJ2By+4rsjp8Y5TbT3LzZGBtCu85C5qQeV76enprxRZ+6IdG+kuSjWIXEMe9HhSbC1WFCjfHDx+QWu1WOexC08WsPXDg+EYRJqJ74tEjn8kopjVt1EJC+cRuXDkAuWrillY5kO7qYB1s4IHHl29c6J/fkcUnbC/qdNg1BEYx9XViay4ZmuQnCxnoGF0O8WWBSvLJ8N94QpoIwfMNuG2psvRjs0vLyrsIyqRcmgpTzpJbroECRyG4QqhnJiAPch0MULbbMWLwwOvkSQ66FL8AWFFsNcqiBwodtdN6eVA0GxVytwtdbCmo5k6ctL/a5XQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199024)(1800799009)(186009)(4744005)(2906002)(6666004)(5660300002)(86362001)(55236004)(53546011)(316002)(478600001)(6506007)(2616005)(107886003)(6486002)(4326008)(8676002)(31686004)(31696002)(6512007)(8936002)(26005)(38100700002)(41300700001)(36756003)(83380400001)(66946007)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEdqUHowbXh5NTNLVDhwTmFZOTI1N01NWTQweTdnbEFMYTNaekJGbHBnK3VK?=
 =?utf-8?B?eEpWeEF6bCsvb1lOb2w3Zk9OR0NGdVVRYnNtdCtnOFVtWncxVUgvWXhGQmxt?=
 =?utf-8?B?bENMeW1EeHgrenlNNEN5REVwM3hKN3NScENWc0Z3TE1ZODN2NmsyMlRzcnEz?=
 =?utf-8?B?MWF1TVFzbGFQajFaVkVEYUJRR0hwL0U0cjdEQjFlZlNMcm9WT3hZTWJNazNj?=
 =?utf-8?B?T3hVOTZMdHU4WVIvMkllMzhESnh1eUFqTDZYZmh6WGJNeVc5NFE2ZlNnTXRO?=
 =?utf-8?B?c21mR3FtZS8vMFQveXkrdzhNdVZGck5YVERUZ1hPWWZiRXBIamx4ay9HWGty?=
 =?utf-8?B?dEJNd3ZEam1Za3BtczBlcGpGem5NUHlpVkpzMlFSN2xEeTdSdzF2cHArcmd3?=
 =?utf-8?B?OEt3em1MVTI4QTgrdVdCYmRObUk0b2V6ZUVhWTBjRVM5YWlUVXJKS2d6aXZj?=
 =?utf-8?B?NlZSaEdId1hQN3BNSFlsZFMzeWoycjNBUXdPei83RFVVK1ppTjFhZHBiQ0ZV?=
 =?utf-8?B?eU12bi92RDN5TDRqR0NSNDVSSDl1MXRocStTblRZT0tUWWZpQVQ2bStmbDZk?=
 =?utf-8?B?WW9kQnkvdnJPR0Q0c252VDJQUncvd2l0TUs4Wlc0c0FQendLcFNQdTRaRDJL?=
 =?utf-8?B?Nm5Ncnh5bnRRWnFhL1huK1ZXY1lmZXNzY1AxdHpNUFFES0xBVjl6OFlqaFQ3?=
 =?utf-8?B?VmZKQXR0S0E2ZzBUQ0pzSFFZcDRrb2V5ZUpLVzFHc0hyM00yQzlPdU0xUzhs?=
 =?utf-8?B?bEpvaTg3UGkyck94SjI2a1FXT21BWjloTTBzcUlNV3B0Zit2ZjhjWE9WUHRP?=
 =?utf-8?B?SzNjekZQR2VOeEN5ZWtrNHVVNlJxRlRqclFlMmJqQWVoVUREZTJtVEpzbVVN?=
 =?utf-8?B?aExOMUphcWhVM0IydTNCRWR0OUdPdjR0RjlhM1hXTWFnd3NORktHQ0ZZQ3ZM?=
 =?utf-8?B?MG1md3Q0Y2dRbW1xbWk3Z05TWXphSzM4M01hMlFicjIrYXZmTFFLZ2VWWTk1?=
 =?utf-8?B?TlZKdGxoNksrOFVmQ1FPeCt6eGd0ZmtqcEVKcHZIaFpnZnpZWXFEd3FhdWlY?=
 =?utf-8?B?bG9YWVJueXZpSjBFZWdmMG1RQUpDZFJxTE5BK0JIN3FPeFJ5bURVN0tlN1gz?=
 =?utf-8?B?Y2ZxYUpqbGtWU3ZNZVViRmxTVDJlRkRSVlpHUnd4Ly83emRaYUs1L1NPMHhh?=
 =?utf-8?B?cVAwRTRRQzFqOStqS1YxenE4encrU1FXYmxEYVlpNmF3Z05BMDhia21NM2xE?=
 =?utf-8?B?UnEzKzlhbWNzeDYxQUFVbE5XU3hsbFNpV0pNaWxOTDJ0QlU3UHVYRDJkYVg0?=
 =?utf-8?B?aEk0WDNtSHRDc1VZdlNTK3Fpa2lQcTF3bm9PcG03QlN0NnU5R0E3aU5OVDNQ?=
 =?utf-8?B?VFhVNS9jYXJrall2RllEdU00T1QveTJLb1BJL3M4ME56RWRGZ1AzVDVtUFlE?=
 =?utf-8?B?MFZZaFlnSmJGSFBJcmhPUXJ1RHJqK3dZa2dtVjVGZmxSeFk4cXkraUFmMEZt?=
 =?utf-8?B?MXVnN1BxYjlSZmVHWHlLd1V2bTBWdVU4SWZRMzJWWDNFcyt5Nm1YNExhRFdY?=
 =?utf-8?B?QWwveGpYeWcyMnh1WFlwOVNWT3kvOE9PME5vcGdZemkwNExVaEVYTUJUNG1W?=
 =?utf-8?B?NEFuK2Z6OC9uakcxNFgyWU5SNFYxY3p6K25QN3BEdmtySVFlWEFTNDdhSGNW?=
 =?utf-8?B?UExhZlJRYUh4WUNPWGg1cnRxOTVRVFVlUWJOVjVYZGgvYkhXNGxLUllCdExD?=
 =?utf-8?B?QnhRaDd0bXdCWG5rNllqYWYrekUzZVRrTndmT0RKWWRrZ3FVMWdhUVhJUFdR?=
 =?utf-8?B?czkzVGJ6M2V5dkRUSTJtSDNiNUxRSnlPampYV282ZXBNbXJXem12cGZ2SHk0?=
 =?utf-8?B?N2YvMGJKM0cwcXFUY1VWZnpQbW5BOUNRL0xYNkFsTFhhMWdEOThlekh4T05V?=
 =?utf-8?B?VzVxZG5rNVdJV2dlWG4yK0lJTDdtcHRIMXhEWUdmcS9QbUZ2OVVTQnFvbGNq?=
 =?utf-8?B?aVQvcVNJZ3J3SXpqUlVTVnJ1bnUybjY0Yzlja2huS2R4bktnamgvYnNrdDFk?=
 =?utf-8?B?MGhOWnlBU0k2N2d1RFFUbnQ1ZFA1UU0xb1o3UjRPSmtLeHVWclVoVE9obnNL?=
 =?utf-8?Q?pHT+BOSyhZVbXii7gvSy9txnY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef86c18-452d-4944-48ef-08dbab044b72
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 15:58:33.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJrP5lg5LdlbigsJdb0Wvo/TNw/fOo8N9ujqgibrElExpKI7fJZTUsv6igkdJcTH5gclOOkcEpydykTO/IHsww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2023 16:20, Sumit Gupta wrote:
> Use reference clock count based loop instead of "udelay()" for
> sampling of counters to improve the accuracy of re-generated CPU
> frequency. "udelay()" internally calls "WFE" which stops the
> counters and results in bigger delta between the last set freq
> and the re-generated value from counters. The counter sampling
> window used in loop is the minimum number of reference clock
> cycles which is known to give a stable value of CPU frequency.
> The change also helps to reduce the sampling window from "500us"
> to "<50us".
> 
> Suggested-by: Antti Miettinen <amiettinen@nvidia.com>
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>


Please can you correct the subject and drop the 'driver:'.

Jon

-- 
nvpublic
