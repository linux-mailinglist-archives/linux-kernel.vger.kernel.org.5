Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B787D5E9D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 01:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbjJXXU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 19:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344484AbjJXXU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 19:20:26 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE6810C6;
        Tue, 24 Oct 2023 16:20:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6KOrzd3KI9yC1qEDzEz06p03dvm6++rzsvto5xvn9sGB4ujS3RonnsmDjNoq8SLnbKB1VKWFjV2+g2R2ej/HByPkWqtVjrkyhPTbaEw2y+MRa0IyiX7a2Fpeu94pCEikTqFi2SLNIJ4wkSMosuls6eYq5vMymZnyj6LDrLj86W6MVqFaidXeagXlNUf6sQWtCrCTQ/PoFCL3jWAANwCsWV+w1RpySpRm7DlXgYVF2lfdTRklYMeUZBSb5U+p0FweyL6tjDvTlW6sd05tiX9DXCC6mhMz1irMa3S2ZzTMtN6tq8MXEtDAEYqXrf3J9XbmcBHmLxj/CCKxZHa5yWLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvpzJvdpXxUNyLe6bTXSZ8Wdc3mpZOq6LJ0DVQKoAOw=;
 b=UHtjJGyP+uKvPLnm6J75oVXJal4mlPl93f6/xZG+S8VkjCTRHqgGiealTcGa9xvZtKE2eJmlJHUrE+35uEGSvnoenFIvUvGs7AbGXS+GVunFrr6Ey95vVroBtVhpZr7q8vWGmitdW3HxAsthX10FGqCtin0fOTFpgBZbpiJSWw84b1I99bf130pv15bnOrmZxFxZiyXNrR+iPrAhMX3UejcGlPiA9F4POcWCAcilsFTAQ6eN69/4zS5NW2mjVBUX5dhH9kVwHBVSzhoj3nMJ01xb9mzjbIqCiSx71f7z2A2ienUnV1BwcK3VySJQQj4UHgzr/7W2g0Q1UsFLHM1+1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvpzJvdpXxUNyLe6bTXSZ8Wdc3mpZOq6LJ0DVQKoAOw=;
 b=CoykoVViCuhjQocmP5AYhLkAHjLWrcYsvr9FCFnRuBT3faI5OXdjwHBgY70EOkAt56t60+WohE0yf9KMl0UATO9pw9EO0TO6/DKTLLYtm5wS1q5sqFaatfBjHvxvI7JvaWZ1cSpOMcvLrNsQYoiNqOhhoBufIY8QUCq0XF6A3y4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 23:20:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%6]) with mapi id 15.20.6907.028; Tue, 24 Oct 2023
 23:20:20 +0000
Message-ID: <2504daf3-16fa-9474-e9c5-cd6aa99d4776@amd.com>
Date:   Tue, 24 Oct 2023 18:20:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231024181600.8270-1-tony.luck@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <20231024181600.8270-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::33)
 To MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: c400ac07-f29a-4433-0117-08dbd4e7ca78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ltCdu/+sOlrDy3VWqWDOjhpVrO6hxcD8bxUC0TCsQTX6tLnvuqfUNfd0YBrPhU8Zs3kXp9+/oQiBAhombS4/wMzQrx7H0tEFVEF1a1Bm9hzNL/or4wTypSETBAT177Jqro/8KB0bf0koILhjymXdgPS9V1fMK3HLXP+nx1OYg56fMGqdISZC3WRFwJoyUoTP8xUGsx2QlwYL8yGKkyDHfggXTs6OVkJNSrs5d7NEq37wYoZ+Nr4sYyAIF4raVDTeGQub8aMirQf9t6yasi7GiAXgFpt4yZ+FYMVwvzUmWJljReVyhphD1ZaaRDcPZguEE9ug/Xrq9ucjytuzcB5el4AqV/kBfMRx3bCtablcHe55eV5HH/RG9xH1EFpVl4s1ShmTZD1PZYk/eQqQqY+XWbik3Er802+Q0l+4gxVT4a8G9dYHu3LBvgaQSNgK6O7OzzmM9sn6EucBLtchjQykOXcIafqXhuEoJ5EXsqSPPlhyn0NgUFcJXQyDoqG1gzImeXN7SmsPK0/S3TYcZ98gGPHjK10atez4Mg+FSlgId7lMwU20U8O27j6c5/hnsc42EskgNFpyKbSiBKRHyrWPik0Gtyn75FmMMEI9ixB2ENsYaBYfUEgBqiW5f19RjAktzOUMkd1U9uZ+2JAS9xo35w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31686004)(5660300002)(7416002)(6666004)(2616005)(83380400001)(4326008)(8936002)(8676002)(6506007)(41300700001)(26005)(2906002)(38100700002)(6512007)(53546011)(110136005)(31696002)(66556008)(36756003)(66476007)(54906003)(316002)(478600001)(66946007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWJONlpYOE5JNUNBOGdjZ3BxRXpMdkxmVCtpaktXODAxVDlaRm9NVXA1WUdD?=
 =?utf-8?B?OG9Na2Nia1dRRWQ2YzYzWUlyUjhRdmdGSGQ2MDFuWGRJMEluOU0walZOTFla?=
 =?utf-8?B?c1M4SkRLcWdIUTRQOW9MdktrWGtlSE5obWhUWm1nVzJxSGxjd2M4S3NDTE8z?=
 =?utf-8?B?VVRlUlBCbExYVGhsdmhYc3V3Tm15Rjd0NnJMNkJ0UytqeHZUdSszdWpPK1cy?=
 =?utf-8?B?RkMxWWUvdnpnYXZNWDAzVHNwZjMvSml5QmNtSEl3MnlXM2E4d1hpTDg3VDV1?=
 =?utf-8?B?SFhkbFRFcU5LYmVlMW00NW9wZXZZR1RjdldCbUtRaUtINDl5QThseWNqa3l3?=
 =?utf-8?B?WWpuUnlVbkJIZzBlVGdiQS9BRU9nSFZXclFDY01Bd20xUFRWbWZSWkFwckhk?=
 =?utf-8?B?QmNIclNGT3RSbS9tbHZ3UmdBckdGeW9TdldDS09QZTBuYmNXMWQvbDk4alJs?=
 =?utf-8?B?YWJOYzlyM2lucWlmbFRyQ1ErYlRRWUdYdjhDcmc3VlZlOUtKUG5WclFHak5J?=
 =?utf-8?B?QlEyclFCaDlLc251cjJLaDNOSHRMV0pjZXNhODdVVThVUEEwRTBiSUIzRkEx?=
 =?utf-8?B?dEVxSzh3VWlOWjJxVk5uVDA0eE1Xc3Z2bnQwb2xNR2dsc0dRb214MXFGYmpK?=
 =?utf-8?B?dkMraGQ1dlU1YzlYWmROWTNHeEExZnRMUXZjZ3VKMHMyRlk0QndFNDFsZ2xh?=
 =?utf-8?B?QnhZRXFxYk12bFlvMDZNUEhtdTdlWllUamR5U3lwNkowa1NMZ0daWTlHeHhR?=
 =?utf-8?B?UzN0TWIxcnVYVGFBUXlHRHkvNHdmaEZCaUowVnRtYWVURGc2T3o3c2wxT3U5?=
 =?utf-8?B?cXlOV28vVElYb0ZTR2tEVUdla0NmcE81QzE5SXVFaHh3WUhHZ3lyc1V0bGMw?=
 =?utf-8?B?R2xuMGZ5dXBLdjFxby9IS0VLTEp4cUMvUXRKa1c3RTNrRDMyeVFyQ3VCTm1w?=
 =?utf-8?B?VGJnZStja2JDMElNY0tyc2hpbzlIN2NZZHJKT0xzeGcydm1XU3BmS1JxVjJQ?=
 =?utf-8?B?TC9TVi80KytsL3ZXZ0FUL3hMRGQ3c2JQZ2JyeG4raUpZUUZQanJ1RHhCM3ZD?=
 =?utf-8?B?VldoZ3JzaVVja2ZRRlpwcDdMUEJYME5GV2tKME5pYjR4NWt2VGdaWkFKUTd0?=
 =?utf-8?B?clpLR0N1QU8vNU13Z0pQUkRJQ2FNUENDd2JVZUJ1TllSN3RVSERCOHp4ZmRH?=
 =?utf-8?B?bTZyQ2phNTVwMko0N0ZlaW5OZVFtS2RMQjI4a29TYVFsVDZlRDNzUzFVVHdr?=
 =?utf-8?B?bUpZTWF0L3dtejJ4dldvN0UvcjVqejIxWWJkMnNPOHZINlRYZ1VXSGVTaU8y?=
 =?utf-8?B?Z3FDYysvbFZpNzllOWxxUGtPRVhxR21EZUR2REVYekJJTkVucGNFMmpwQ3g1?=
 =?utf-8?B?WXUxdHpEMmJaZjlpQjBnZTZDUjNTWXBENm5tOGducVd5WlF0TDRwS3p3MnIy?=
 =?utf-8?B?US9iWFBlYXNhK0tzWjZ6dlpLVGxxbkpmTXYwNkF2U3VZRmRTN3VWQ1hDV3k3?=
 =?utf-8?B?K0F4c2NuVUdwTUFwWU8vTi95T0NWNjNuVVkxZFJ0V1hFdUdWL1ZPMGkrMm5o?=
 =?utf-8?B?RUhTL0Z1WkhqZmlqbFJhYlNMYm84TEsvUEZKVzFBcitQMi9lQWRHbDVudnFH?=
 =?utf-8?B?cVU5b0FxTWdZUXhiRkpRYzlJVDE2SVlkd2hjOGxpclBTdHBrcFpKako1VVBs?=
 =?utf-8?B?VVlDeFJ6VlFsYVY3bmtXRkcvU3R2SDdQZmVQRmtFOGFNTVZkUDZRc09Reklw?=
 =?utf-8?B?aVJMdEM3Rk5DVTMzamd2UVkrWm9wcHM5eWpvU1k1YXE2ZGQ3ZTY5T29mVnY2?=
 =?utf-8?B?VXFBOXpyMUtzSTF0T2N5NFNkVEMwSEdvbmVXWVZxSnV2VmdJTXhFNTdtcG9m?=
 =?utf-8?B?QlhKc2ZiU0lHR3ZNWkdLd0E1MERWNFU3bVROK2JmVS9ydGRMUUJ0NjZZNkNo?=
 =?utf-8?B?dGxPM01OSTFyVjFYaHM2S3ZESDgzWi9pOXhyeHZmM3prbER0bGltUy82OVRt?=
 =?utf-8?B?VUF6c3hwdFpYWHZJUENXNGpPS3U0bFdiS2NWbTUyS3RmQ2hnMVJPeTlUaVVx?=
 =?utf-8?B?TEkxVzAzZStkOHl3YUZvMDh6Uy8vWnJha1VjVmo1ZVROUEZCbW9xYndsNC9D?=
 =?utf-8?Q?ejFk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c400ac07-f29a-4433-0117-08dbd4e7ca78
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 23:20:20.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ytAAkkEqasuCZFiyV5vXv+WzWDHx4EvNEcDyi2uLHPkfHUlm1bsMiVrOSHbsXtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

> -----Original Message-----
> From: Tony Luck <tony.luck@intel.com>
> Sent: Tuesday, October 24, 2023 1:16 PM
> To: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Peter Newman <peternewman@google.com>;
> Jonathan Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>;
> x86@kernel.org
> Cc: Shaopeng Tan <tan.shaopeng@fujitsu.com>; James Morse
> <james.morse@arm.com>; Jamie Iles <quic_jiles@quicinc.com>; Moger, Babu
> <Babu.Moger@amd.com>; Randy Dunlap <rdunlap@infradead.org>; linux-
> kernel@vger.kernel.org; linux-doc@vger.kernel.org; patches@lists.linux.dev;
> Tony Luck <tony.luck@intel.com>
> Subject: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local b/w
> unavailable
> 
> On Intel the various resource director technology (RDT) features are all
> orthogonal and independently enumerated. Thus it is possible to have a system
> that  provides "total" memory bandwidth measurements without providing
> "local" bandwidth measurements.
> 
> If local bandwidth measurement is not available, do not give up on providing
> the "mba_MBps" feedback option completely, make the code fall back to using
> total bandwidth.


Is this customer requirement ?
What do you mean by " If local bandwidth measurement is not available" ?
Is the hardware supports only total bandwidth and not local?

It can get real ugly if we try to handle one special case.

thanks
Babu

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 34 ++++++++++++++++----------
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  2 +-
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..3b9531cce807 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -418,6 +418,14 @@ static int __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>  	return 0;
>  }
> 
> +static struct mbm_state *get_mbm_data(struct rdt_domain *dom_mbm, int
> +rmid) {
> +	if (is_mbm_local_enabled())
> +		return &dom_mbm->mbm_local[rmid];
> +
> +	return &dom_mbm->mbm_total[rmid];
> +}
> +
>  /*
>   * mbm_bw_count() - Update bw count from values previously read by
>   *		    __mon_event_count().
> @@ -431,7 +439,7 @@ static int __mon_event_count(u32 rmid, struct
> rmid_read *rr)
>   */
>  static void mbm_bw_count(u32 rmid, struct rmid_read *rr)  {
> -	struct mbm_state *m = &rr->d->mbm_local[rmid];
> +	struct mbm_state *m = get_mbm_data(rr->d, rmid);
>  	u64 cur_bw, bytes, cur_bytes;
> 
>  	cur_bytes = rr->val;
> @@ -526,14 +534,14 @@ static void update_mba_bw(struct rdtgroup *rgrp,
> struct rdt_domain *dom_mbm)
>  	struct list_head *head;
>  	struct rdtgroup *entry;
> 
> -	if (!is_mbm_local_enabled())
> +	if (!is_mbm_enabled())
>  		return;
> 
>  	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> 
>  	closid = rgrp->closid;
>  	rmid = rgrp->mon.rmid;
> -	pmbm_data = &dom_mbm->mbm_local[rmid];
> +	pmbm_data = get_mbm_data(dom_mbm, rmid);
> 
>  	dom_mba = get_domain_from_cpu(smp_processor_id(), r_mba);
>  	if (!dom_mba) {
> @@ -553,7 +561,7 @@ static void update_mba_bw(struct rdtgroup *rgrp,
> struct rdt_domain *dom_mbm)
>  	 */
>  	head = &rgrp->mon.crdtgrp_list;
>  	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> +		cmbm_data = get_mbm_data(dom_mbm, entry->mon.rmid);
>  		cur_bw += cmbm_data->prev_bw;
>  		delta_bw += cmbm_data->delta_bw;
>  	}
> @@ -595,7 +603,7 @@ static void update_mba_bw(struct rdtgroup *rgrp,
> struct rdt_domain *dom_mbm)
>  	 */
>  	pmbm_data->delta_comp = true;
>  	list_for_each_entry(entry, head, mon.crdtgrp_list) {
> -		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
> +		cmbm_data = get_mbm_data(dom_mbm, entry->mon.rmid);
>  		cmbm_data->delta_comp = true;
>  	}
>  }
> @@ -621,15 +629,15 @@ static void mbm_update(struct rdt_resource *r, struct
> rdt_domain *d, int rmid)
>  		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
>  		rr.val = 0;
>  		__mon_event_count(rmid, &rr);
> -
> -		/*
> -		 * Call the MBA software controller only for the
> -		 * control groups and when user has enabled
> -		 * the software controller explicitly.
> -		 */
> -		if (is_mba_sc(NULL))
> -			mbm_bw_count(rmid, &rr);
>  	}
> +
> +	/*
> +	 * Call the MBA software controller only for the
> +	 * control groups and when user has enabled
> +	 * the software controller explicitly.
> +	 */
> +	if (is_mba_sc(NULL))
> +		mbm_bw_count(rmid, &rr);
>  }
> 
>  /*
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 69a1de92384a..0c4f8a1b8df0 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2294,7 +2294,7 @@ static bool supports_mba_mbps(void)  {
>  	struct rdt_resource *r =
> &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
> 
> -	return (is_mbm_local_enabled() &&
> +	return (is_mbm_enabled() &&
>  		r->alloc_capable && is_mba_linear());  }
> 
> --
> 2.41.0

