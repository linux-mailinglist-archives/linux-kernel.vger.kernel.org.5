Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5B804254
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbjLDXFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 18:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjLDXEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:04:45 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA67182;
        Mon,  4 Dec 2023 15:04:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuC5cpBTYImZP9nbHEZr2GAkwASrLFzBDWwxrBusRWjxQnF14dcEXOgR/ckQNpRqTqnARglsAGn9+gTreojI3WZ1k6cZ8VTyDxBOZlWgLpMXonFM0yL1/fdFVwvhhCME+Z49ajPq9GcVI0iX7ekHZRLnY5Jtuw5kirb6YuYTcJtqKaoGchdTsrbDmjJCDlbQxKa+4Z8q7T16BG5YOKPWgYYUJ38ra2filN5azAmdHWkzHwITJU0KDQHnOSGaFhSuy0EFptwmAp4t4IsW0qS2yIrXIblcbHgxL0cPl/c2+4FNlDoPj045d/59XZXkNz259z9HmPPjsFKpuIiJjCFjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkaF6sFbKTDv/gCu7QRXdCItONQApiOq4CtETJqz4/E=;
 b=VYE5oFBWkl9CuGZ2ZYZ43tS+J8BDJeknEWTqV6ezcshJnWRPa5s8E/1mAayOWMOx+LPlRP/oLj1Hrl/l1r3STe6jXCbG2cxm2P3NV1OPTNhDt9Jsk4/08EOfifn/UzNpsaaTcf6DLEw8zalWAMOHLAtLhewZW0wu3Bx0nxR0Y7w4T9avFMhZ/JItx6uc4DjzOxg9gYY2gq65LGyEdmpp+aag6ewTS9SNiKE7dYD/yHfdovDe+TXu0uWFZBjFyOsTJMwP+FvhDdc5dDSPUoNEVW2wSpNOMOdx56tsHh3ypUrP7Y5qa1VXIoPvc6aQVVV+9OIeoINacIyfJP1B2YlEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkaF6sFbKTDv/gCu7QRXdCItONQApiOq4CtETJqz4/E=;
 b=h0Br3F2Qs8BXMLfjKaRF6g/bXCA2vMRpzc/GPOPXBZKIHP+r1us8doub6auJzD8jAlmItsQ36BWZx9FOCjf0jDoLV29UGuQk2Ha879Ox/PwesQnhvBfgqPM1zgDzxG6sKqkL6vWuIo1xJbOO8qf/qJIo++mhtLMXesjXJuUxhQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 23:04:13 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:04:13 +0000
Message-ID: <9ac718af-7d67-a179-6e38-d51e2d7506b0@amd.com>
Date:   Mon, 4 Dec 2023 17:04:11 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH v13 5/8] x86/resctrl: Add node-scope to the options for
 feature scope
Reply-To: babu.moger@amd.com
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20231130003418.89964-1-tony.luck@intel.com>
 <20231204185357.120501-1-tony.luck@intel.com>
 <20231204185357.120501-6-tony.luck@intel.com>
Content-Language: en-US
In-Reply-To: <20231204185357.120501-6-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb3ce24-a1c8-4b0e-a5c5-08dbf51d5545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t2ayzNFJzW0ooOrMpSSX7MzSUW4LTYHJV6ydZTjAVcQFFBaDEWWwOT4os3NQ/E0KPfyABp9kJZwOI2t92IiCB/UDrsUk64iTkLqlJ9s6BpvimM5jgfjVkdiyooUyBR8pXHgBMw+Gr4m6/tSnJMu8y++5pqFIPCrla7KskTAxs1PYqic724cmzp2cMu3i+wRhokzpbScFiS7zsemyrKlih2/R1a7X4gzUP3Swm2vNyi/AgkrsMUcO7KNIeRGHhLKovFyV+tYTu9bSQPJU207nGDcPTWNbHLVM1pgum99Gnus4HjVDAmwCnOFy/Wk/ZjxlsyWhl51ovvmfN4ysx70VdmvRKQnfo/CHsZw/dsIulR91Evs1xuLbsjg5cepTPE4N2isLwuN7osmfmdL6trPZQOet7kmINzHskDE3TFikaiKPCS9YO+mr0jT2qWYRkQ8Mzn/6mj234JmtRiE8o6iitLc9rHG5UEL00nF3EgchYovhOGCTcg5ooWzenY63ULfT3x/pxm2qGxHHk3s2oNIb+no/ZS2gGfoCRSHogG/5vy0d/Hdirl/ZhD9a8Y3IZpXqZ8XtSrcklhLhbCTirxuWC7fLsT7+SQmKDNjBnoRaOY18S/c3UGHkdlLW3inX8hvRNmVMzVAE/iowjWeDtohMEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(38100700002)(36756003)(31696002)(2906002)(5660300002)(7416002)(26005)(2616005)(31686004)(53546011)(6512007)(478600001)(6486002)(6506007)(4326008)(8936002)(66556008)(66476007)(110136005)(8676002)(316002)(66946007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFMc2o4L2NTTWt3VzB5aEJJbWwvT1JWUmg2ZFIyUUZSS2ExaHBiNFFieWNm?=
 =?utf-8?B?KzhBcGRNbkh4Wi9WUGp2cHNidXJjMm42Z2ZXbmNnS3d1a2VLQVpQc1dIUDFE?=
 =?utf-8?B?NjE4QURKbFhiOWxORHJNRlQzWG1IeklPY3lEaG1SLytRWXU5SXBwRW9xbXg5?=
 =?utf-8?B?K3VNdXE1TVVyUXkySWZuTnlrczBpWk1RME1jV0RNeVVyWEM5NWFCOFlPVnZ0?=
 =?utf-8?B?NzRQR0xwYVpLWWJxMlRGKzlZN1ozYjEwdHI5RUpFbUE0ajZuaytvWE1NRkk2?=
 =?utf-8?B?RHNHOExQby9BTE9TVnVxQXl0Y29GRWpWcldwS1RhdTlsZEdZd1gwM21uQ3RU?=
 =?utf-8?B?NDBRZjQ3UGFocmFrLy9OZmEzMjh3S1dWaEhMSkphcUNaVGFjUUExL3R6dzky?=
 =?utf-8?B?UndIWEZ5RVNOSC8rK2MvamdCVDk5a1FSbWgrcTJjNWJ3YXNjaXkxWTVMdDJy?=
 =?utf-8?B?UEJ2ZU5yWFVvb0d0SEVpWmlHQVhvOVFjaUhDaEpwQkxwWW5yUktYVkpDdDh4?=
 =?utf-8?B?RGQxZGtBU0NaMi9VKzVhQnFvKzFiY2YzM0gxU3Z4VzM3SWlWeFpMWUkxa3dw?=
 =?utf-8?B?N1FHS0ZHTzJud1hnaG1rVk5rOUJEV21SQWlkcmJ4OXJLckxNZEp2Z3V6MWYx?=
 =?utf-8?B?aG9jeHZIQXRWSy9pMytPVlRTZmptQ0xic21CRXJ1dXlVaWgrVU5IcTlmL09I?=
 =?utf-8?B?N3FkQnc1eWlqRlo5ZHhrR1JyVFY1WUs3dkdrbjAxYzNMN3oxN28waXVkTndi?=
 =?utf-8?B?Sk9PYTNYNk9tbmJHakgxTG5HeGJsYzBPNWk1WUFOY2p1Skh4NjBEalVkMlNt?=
 =?utf-8?B?Z0o4NGN2c2JraDBTSEpXc09Fazh6aU0vUllVNWdXUlJLOEJIMmxIYVVzTm1R?=
 =?utf-8?B?V1NNVWxzL1I0eGxyZktiblJ3YVR5NTVhU3dKZFU5dkxDY2xGV0ZVUHNMSW1p?=
 =?utf-8?B?cFR5Q2ozL0plaDhHVWRBWTVyQTBtTm14S2Y2KzBuYzJJZmhCWktGR25ZZTVm?=
 =?utf-8?B?OHg4UXZBVmk0K3hwa0FsaFREQUtoZ2dZcUkwaEZGS3NINVdabEtaVmxCUGpE?=
 =?utf-8?B?aEZJd2tiakNoTVQvWUU0Z1RtRlQwRDJHOUFPR2FjZUwvekFuQmlDV2pGL1I5?=
 =?utf-8?B?bHRuT1NyeHhPdkFVakZ3OEFhNS9hck14YjUxcWEvWjBXcExuOE1BSXRkUk42?=
 =?utf-8?B?ZTlFNHQ0Wkx1VS8wWGp2cEpuL2VMOVoycmN2KzFVRWpicTZzbWJUTitUTUln?=
 =?utf-8?B?Q2hNRW5lTm52aTRjVThvb1lHeDZ6U0JKSWh5VUQyNU54bXd2cFJURzdNR3NM?=
 =?utf-8?B?N29BQklHZWNyN29IMXhnbzRzYy9QTkJ3TlJWNzJZcXlOci95cUc0SGVlQ0Zh?=
 =?utf-8?B?aDBNQzdoalBGZmZOVUdjU1ZicmdkcVV0NDlQZXYvRHQvWWtGallMTXdhc1Fm?=
 =?utf-8?B?alZVZFFNSEd0UlJzRk5mcnNacTZRa3V6R1JybDFmZXdOdXNBQm9VOTFWWUor?=
 =?utf-8?B?dmlUM0FxMVFqSG9NQ1BlSmZBM0VHdFlNcElmMFppWmwzQzhBdnFWSEpRMDRz?=
 =?utf-8?B?NTc0RjZFaUdKSVo0RERZb0dHL2p1czRXVkVNNTY4QmtGbDc3WmsxTStIQkNj?=
 =?utf-8?B?aXJlTkhFK1BrT3ZObjA4YllvdHhjN29aZzFHZ3NNcmxITTRaSFVSbklIaFQ0?=
 =?utf-8?B?ZXRGMGNQSHhINWNNWXhnR2hTMWxMaXA0OVVqRnNvcVhyWlk5b3RvQUUzSTd2?=
 =?utf-8?B?WTgvQ2MwYkM3WmNBL1pFZFRGQkR5L25oMTQxOFhXc05XN0dPcnRnUVI1Nktz?=
 =?utf-8?B?VTFmcFUwdWRsM0RRVUZFcHJhMkh1WlVyY3pVb2g1SDczenVvYnZQdWdxaEh5?=
 =?utf-8?B?V1lRNmpZOVJ5WElMYzh4UzlLRlBnbWN5djdEeHh6R3FKY1YyeHV6N25DaEV6?=
 =?utf-8?B?UHQvSDdzYkVQMXFxL1VGU1JMOEk5RDdxYmpId2ZYZjRHZjdRWTA2SzNFYXIy?=
 =?utf-8?B?NlJWVFhMVEhObFFYOW9NTURWZUlIc3RXL3Vaa09EUWc0WWltWGtzLzV4ZVN6?=
 =?utf-8?B?REIzWjFKS2lmL2JSa1NzWCtQZzdnakY4NTdtT2M3T294WHhjNUxXdytUV0dz?=
 =?utf-8?Q?6bAs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3ce24-a1c8-4b0e-a5c5-08dbf51d5545
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:04:13.7667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwhnWjzpKRLTCHDhZIhhk66LwfR2kJ+CyovHp+TZzbeChWbl4HfNniZc8W5bKPeQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/4/2023 12:53 PM, Tony Luck wrote:
> Currently supported resctrl features are all domain scoped the same as the
> scope of the L2 or L3 caches.
>
> Add RESCTRL_NODE as a new option for features that are scoped at the
> same granularity as NUMA nodes. This is needed for Intel's Sub-NUMA
> Cluster (SNC) feature where monitoring features are node scoped.
>
> Signed-off-by: Tony Luck<tony.luck@intel.com>
> Tested-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Peter Newman<peternewman@google.com>
> Reviewed-by: Reinette Chatre<reinette.chatre@intel.com>
> Reviewed-by: Shaopeng Tan<tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
>   include/linux/resctrl.h            | 1 +
>   arch/x86/kernel/cpu/resctrl/core.c | 2 ++
>   2 files changed, 3 insertions(+)
>
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 058a940c3239..b8a3a11b970d 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -170,6 +170,7 @@ struct resctrl_schema;
>   enum resctrl_scope {
>   	RESCTRL_L2_CACHE = 2,
>   	RESCTRL_L3_CACHE = 3,
> +	RESCTRL_NODE,
>   };
>   
>   /**
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 797cb3bf417a..c9315ce8f7bd 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -502,6 +502,8 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>   	case RESCTRL_L2_CACHE:
>   	case RESCTRL_L3_CACHE:
>   		return get_cpu_cacheinfo_id(cpu, scope);
> +	case RESCTRL_NODE:
> +		return cpu_to_node(cpu);
>   	default:
>   		break;
>   	}
