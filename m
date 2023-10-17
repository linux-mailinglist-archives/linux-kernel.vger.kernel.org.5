Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DBB7CC993
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343863AbjJQRMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJQRMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:12:08 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DE994
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:12:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFkdqoJDD9s9DfYBuB619lGwJz7e3oOyu0cQGw+E/FOaQa8dNB0Pw0+zVNXXAbadBh/3zhIfpLu6MxnQ0pUGGZfkOvSm/bWLKVA3jXrfPUz7MqepgMLgt9l43jNsLzxAC+BvHnmEq1A2BHJXDy3Vnvuvj1wIUh4Zheve/nPbQv4k/nuHoFF6VjJ7AkW8YV1UjdsEwXyW4hs1nyL99OqJlk9j0Ie8EZYMZmsV0oDsyz3lO+/QExvjq9img/iiGbAsb6fm8tgqOF0rRiacIy+rYKH0Dp4HV6VdwM4ur/NFL7FNrGR4WDjzEDQ0OXaavOQS6DPLUfIvJfNfJQ4iE/yu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lftN9h7Hodn5bW/03tRUGWCgjAzpO8EjoxwzG9ItWXY=;
 b=M4HlX3eY1Uh2wHCAzCwb7WheyAsouUUs97woNN2AYJqm8X/0TcJHDPJHY8PP0yXNpYMqB0b4jpi4phLWD1NMuceVoTbIXjpLSF1ubq7dS/Wz7YixNTu1k6952ULT5AfRp/XsSXlc0+RTHbxZng72w3WwyDMDZaL7wAcTRohFa+BB4v81gnsW5xze/q8G9Fc9/mLIjDLJ4pzYnV4Iasgqy8kXcO+5l590akuBo5TfVJiiTWs1nuZl3mdkm0HG4fLqPMLdc3iE2xFLpmlp1djI6eCDTkOPSBP1gwILLHFDu8WMwnFQBP0a6IOZTTGyAJcgy4Nhv/XQZcLUQf8ImKbkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lftN9h7Hodn5bW/03tRUGWCgjAzpO8EjoxwzG9ItWXY=;
 b=NHb+jxEt6fMnLCqJHnnFfFNGEvdM7/LL7ZYHB4m09VJwvXAYdxA6W++S8NZZ+ZAJM4MABF/mmKdlCJsDyGb4eLUlHrfSPdpNyGLeTii8mig5H5cPjJM9PU677jUKNogJRT7OfK1vjkNmyz6e8kkrZQYhQ1/YFUgmmBksYG0wPdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4911.namprd12.prod.outlook.com (2603:10b6:5:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 17:12:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a7fa:4411:67a3:131d%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 17:12:03 +0000
Message-ID: <04ce32e6-4000-404b-8f9b-7c6e5ee5d433@amd.com>
Date:   Tue, 17 Oct 2023 19:12:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sched: Add description of parameters in job_done
Content-Language: en-US
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     kernel test robot <lkp@intel.com>
References: <20231017151521.12388-1-luben.tuikov@amd.com>
From:   =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20231017151521.12388-1-luben.tuikov@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4911:EE_
X-MS-Office365-Filtering-Correlation-Id: b641fb18-d3be-4fd4-d0fd-08dbcf342f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nzn8Pi/RDnwA002MbaBWvZA93FQdJraM+Ttz+KEQ/pwVK2z9y9+dmxeZwveSWCbOVTNtvnLv3r/L/4Z7bE4AKH37rTZzIxYCJ1Oyc8zNcqUHak4ggPDJrm2n1sBI1hu9sf830JrVnO/lwTDfrN00iTCuddtpJGyerLRd9FtfxNkQHJVC1O4CLXEw+G3KrFeBer4W5u4qvuizaqLBEMRiq3j5zNwvdVMuZcpIeZoDvNNm/ICV6Fohe5cIDBbYqb0E4aFrYsGP3QSB5FrlMHpEHszzYJCL/m03uukZBTcI3XmNlN2JmY7jF81Ia20qkVE2jygLHr/UMTDVVOvQkOeBE2tbKb3YtKUOQs7uxhO/kbnw9Pmops89UYiKZu0rMhlv4Osj6w44Jn/yCr9NLBvkAVPhCHBJR+W3IyT2P1auV8yGknfbbtJCEr1yEyPBQChm7nsN5GTyj94OOH/goORTtop0CLPIhXwqIwDgee5lqRo9BriIeZ/zcIdBCwUP5TJt3NVoZqH+mVDT1rsvB48K3R1F4uBiRlUsGSSX/LFoyAe9P65VyFUVOwsD+jEwPAM8kVITUI5tYg3DT2WbNhgEynjAoy9e6IPxiYXpVql8WIO1YPRQACsa6FWbfP1926bq2P4mtBnKnGfZ+GqkHxhMww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3587.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66476007)(478600001)(66556008)(66946007)(6486002)(110136005)(966005)(26005)(6506007)(41300700001)(2616005)(6512007)(5660300002)(8936002)(2906002)(4326008)(8676002)(36756003)(31696002)(83380400001)(86362001)(38100700002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0U3NnY4aWp2cnJuV0VFbmtoeGtyR1BwOG8rL1JwemMxOHpheVBpUmc4M3FH?=
 =?utf-8?B?b2d5TDdoWU9NQjZmRzlkK05tT2Zha3VaTGN0KzJWTzR2MXZXRElUVTJCa0Ir?=
 =?utf-8?B?ZGc3bGhRK0lYd3gxaUZHa1Y4Z2JxTUJnYUtoZUtOdFZDWHNtaXZYaHdpNmhk?=
 =?utf-8?B?dERneWNXTUxiSDZGdU1McStQaitsMWErKzZrWk1ja09XdGNoUHQ4bllJYkZp?=
 =?utf-8?B?WXBsTlJJbFdnSjQ3UVNPNTJXTksvUXlRUjZCVnJHOCtEY3FLNXRlRlZlb3gx?=
 =?utf-8?B?aWxKUlJmaGllVldteHhBazBNMU1xV1FXc04rZG82eC9xV0xabEVGU0Z5TEtl?=
 =?utf-8?B?Q1R5dzYySHg4SEVwR3I0Q1c4T1BBQWlJRjJLaG1GdXMwRVV6VHZPazdWSFVw?=
 =?utf-8?B?YnEyTmdOODZBYTVFR3QrMFVZbGdjTDlLMTdZZkg4Y3hHeEkxVWJiYnJWTlA5?=
 =?utf-8?B?L3YxZ3FJL044NEx1NzhJRVdXQkFRQkU2S3NZNHFyUVUzZy83R3o3Qkd0blJx?=
 =?utf-8?B?bVV2ZWhtMkxubmFnQmFSd05RQXM4aVdrRmhwWXVlMjFPaEpVV0xheEFwVTlU?=
 =?utf-8?B?S2xtR0NiWGFod3pLeGdRN0hXU0JFdnBYR3BBV0VacWlhVG5pUGNxUy9ha1ho?=
 =?utf-8?B?ZmxhTVcrQUs2R2lKcWdpc2oyWkxVT1pPYkRFMVVkWUxlZ2I0amhNOXNkeTFI?=
 =?utf-8?B?eStHQW8vWm5sSENxdEJMTURrM2prazhnKzlNWDR6dEFZVlppczZxOEZ5TTA0?=
 =?utf-8?B?WTVveEZGNlZwMDNDNGlQQ21kVS9LRDJxMWhPOEdmWWJ1aEo1T1pUU082RmV0?=
 =?utf-8?B?dGNYNXdubHRWUUROakkvZGhhWXpST1NuMkoycVJRVzFzU2djKytEWlJCS3N5?=
 =?utf-8?B?TzR3bDhqb1d1cnZQT3piWXhHL0xCTTBXVnBtR2pxeWsydkIvWnVJOHhRRmpY?=
 =?utf-8?B?dDZpU0UyMU5PdUNkQkxUZ3JSenBRNml3WDF3QVVObWlKM0gyWC8yZ0ttSSt5?=
 =?utf-8?B?YU9kQWhvMmtDaHRtdUIwOURQbkI4Z3FRd1VpSzVwV2R1OXk4VTJXMXBWUG84?=
 =?utf-8?B?L29iZnIxRGREZ2JpVGcrdUhtRkhTUmtQTGplUFQ1M2REakg3TjN4RE40VWNn?=
 =?utf-8?B?Rm9UWndqQzJxa05JanAzQUtOTmhmME5nWXZWTVlWbE1iamdHRFhhSUl3eFFm?=
 =?utf-8?B?N1U2RDcvVDkwcDRtdkcyRjlKeHhwTkxiaHBZVUpvMDNUSXVGRkovTjAvTFRH?=
 =?utf-8?B?d1owWTZoSXAvOFptdWZVbzFWbWJ4UTBDQXFjQytPTWlSaE9zVkZqRDVMTDYx?=
 =?utf-8?B?MGs1bTA2a2ErYzFHOURMWGFzNk9RL0RhVUxuSmV6SWhhTFBhU3RKeUlQd0ZP?=
 =?utf-8?B?dzF2Mnk2Mm9TdlFWdVdVaU9PWW1Dak80RkVkdGF3Yko1UE91TU9hM1FMNGFr?=
 =?utf-8?B?b2VVM1EreVIzQmEwWlFMbWZqa0hJMUloTEF5S0ZDZVpZSlNFVGYybTJKSzhw?=
 =?utf-8?B?S29vK3ZDMWRZeXBQemdBRFJiT1grTm5pc3RsU3I3Z1ZCUXNrMjNldE9GNlBI?=
 =?utf-8?B?S201NlRQdHgrZzhqLzdScGZ6K3YyYUo2dm9OTXBzNFRrV0pIQzl3bkMwMUFE?=
 =?utf-8?B?cDdzSFkxSWdXdWJES1IzaExXUzVrR3JFcVNPYlFlRGVHem1YeEorMnRIRGhR?=
 =?utf-8?B?bW9KNi9DTzJNMEVHTlVuOHZhbnJLV09CT0RwcVJ0T0VuR1JUR2N1V1NrK0to?=
 =?utf-8?B?RVg3S202K1ZyRkoxNTY0QTZBY1BwaUwycHdDK3k3OXdNcXYvT1FUN0JvUHhD?=
 =?utf-8?B?eWFQM3A3aGNLdVJVMk9BZmZsMDVsK1F2VGdhNGtRb0MyM1gxQ2hoZkU5MXlh?=
 =?utf-8?B?Zk9MY0ZVSUtZUFZpVDROUmRseFJHbWR5TXZIdkQwcEZPYmZhcW5QRytqMjdP?=
 =?utf-8?B?V2pTSnUvOC9MRklwaVBnUDhwN1NGQnFFOHcvWW5ydWE4aEU5a25aakdpWGJl?=
 =?utf-8?B?QUVhK0QvbVAydU1vTExicHFzaUtHbXRiQ0VSWFVaMG5jaTY0WG4ySUdWTWFV?=
 =?utf-8?B?cVVmeGQ0ekJLSE1pUUpzWVg1L2hRYXVKdGFUVEpXZ0hicFAyUDFtcVIwNzZR?=
 =?utf-8?Q?qOrYvZzWyTv34T1Asz2J05N/v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b641fb18-d3be-4fd4-d0fd-08dbcf342f06
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:12:03.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Faxu8G987LcHyEe4Y7okYqc7cHdmkln0YPpg4DjzmCzddZDAjyGNsKyUp+d73/jp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4911
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.10.23 um 17:15 schrieb Luben Tuikov:
> Fix a kernel test robot complaint that there's no description of the "result"
> parameter to drm_sched_job_done() function.
>
> Cc: Christian König <christian.koenig@amd.com>
> Fixes: 539f9ee4b52a8b ("drm/scheduler: properly forward fence errors")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202310172018.eaPyawVC-lkp@intel.com/
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 5a3a622fc672f3..6f2cf72e79b15e 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -259,6 +259,7 @@ drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)
>   /**
>    * drm_sched_job_done - complete a job
>    * @s_job: pointer to the job which is done
> + * @result: The result of the finished scheduler fence.
>    *
>    * Finish the job's fence and wake up the worker thread.
>    */
>
> base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c

