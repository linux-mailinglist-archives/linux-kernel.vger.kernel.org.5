Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527267AF15B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjIZQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbjIZQyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:54:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3F3DE;
        Tue, 26 Sep 2023 09:54:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9o4UJ2FX3TlNaV0AYZ1fcnpWfFAeOovjBo4Jpl6BgBWKg8ZHZoqwHOr7Q2R/i8vTei+5psZSFaKDUy4bEzBV9gEA0jIUTKsYOGPCtfu3sgSRJSMwl2cG80TMVNpYdl64fQBSAhdXU3T3mi2wHvt2pdwd33hknAA9y8oH+iAYteaEwY6rs4rm2D1ZrMd7dLwinZjnjdnhNgJKIJshziJzgHCVbmjBm+Pv17yLTu44DVj+nMYv/Lrj1cOivYF84IflFyGJazVcZt/9QoKZhYFQzK4d4fpFmk6tPGlc/TV4kHS3wQjM21KgitJjpWDKJRN2zAnasXX13DZklp5HELkhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMR3KLyqLarJEpsxu/KtttBPCsxRlEX6ux+HVbCbPVY=;
 b=GUNM9V4xKxC96PVHXQOBe8zdbZBsqc6lxorC/4y7w082CAUN5csz1eMWNrenblQl0e5eLbR3udB5JIrVJth0qgzfO8whTSoiXvEKFfhCPWIYGiV31DCupW7chq3r+/Ec7KBbziu+mqVSW/bTvtENbk5mLoxXXtlSlIW5hAvICx+YuqzD7kXOxdZbSsMtVZzrs1ncruHzf9wHv50mInS5c3Fezd2SKYrx+hfQgm9VEyZoQ3U27YE+JmmiE2WEYkJLg/ey1axnRJxeLS/zIAqOwyeAmZ8Hc5XPGte4x94mjwxKwsxyonVcUV4elAbJb9htVZQ9iYmms5OmMdPYYQtdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMR3KLyqLarJEpsxu/KtttBPCsxRlEX6ux+HVbCbPVY=;
 b=WvNUCv2eQKtX1aO2AH8ojn1OM+D1mbxv5cmI7yX3eQm9lE5VL8aFOMqWKDWQGRjiiWGMf+7xR/vgBorOqpNPaGu46tVXudDe4ig6Hezh/UXAX5zgTsJSrZUQ78ajOPRVNbQafIRXpnDZ32/08kJzKc1GLGcgJQz5lN7PFf68Q3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH2PR12MB4230.namprd12.prod.outlook.com (2603:10b6:610:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 16:54:20 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.016; Tue, 26 Sep 2023
 16:54:20 +0000
Message-ID: <ce890031-2478-ad40-a016-03657bc5f0e3@amd.com>
Date:   Tue, 26 Sep 2023 11:54:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 2/8] x86/resctrl: Prepare for different scope for
 control/monitor operations
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-3-tony.luck@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230829234426.64421-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR02CA0168.namprd02.prod.outlook.com
 (2603:10b6:5:332::35) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH2PR12MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: 677e0416-32cb-4afb-67b3-08dbbeb13a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6R7CZHhcfOzKNUtyUZw+/y4QvUgg1KenvZf6eMaiivhZP1L66v0LTZLnPiSlAFdf7zU5tJ4F++SqcWFOAmu/TocXf7TWzeoLWXAQiJSzrcyf2AsKjrFcLYrD/PRRl9rb7ViMweqf9NtJ6K3QzRUXA1Zbi014aaq9pm3VvTNd8OB6OdbTsbzXSmcU3Q0K6nj5aqKjHiG85c+S1yrCgXdxjs8uC2YOpS3zvahbuPzK9aoSmrjV7ZzRVB5bPWdvoil+mjhfUX7awbBuBhrLp/QQG52UC700zpKTWRbKGFLLJY3ehQv3w4HyTG/TOfvN4V/pXiUS9MmtsWN/Mw+/kfPSXdlaEePUzVprz475Xi+s/dqPyaUaXE/X0Vz1Gq1n1lY943Ncdu+KABtnk3oOx2l+LCZuEZKnY/FJJJmTN4U/3oYNaZjipritEkK5/SCCz7fkEIc46EyuXEOc50y2FDBmD0tpcky/UrKkb68jGTGG9/UXl25Lhpo2NtvZ5WbKMENjbF2fTXtmVNXhWRxqB9tR3K03BZWeHLm9nw/nAZ6wIwot5xBunN0Xwd9PUHVKEB31JxpJc53xMJX9eXsld4n45VplNMF3Tvo4uL3cOlAjUymWH8gF6fI6mDmoOlUA6MhiFWilYuMTy9qrm29aRpT/+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(376002)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(3450700001)(2906002)(31686004)(7416002)(5660300002)(110136005)(66476007)(66946007)(54906003)(66556008)(30864003)(478600001)(6666004)(6512007)(53546011)(2616005)(26005)(6506007)(6486002)(8936002)(8676002)(316002)(41300700001)(4326008)(83380400001)(38100700002)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUtScUlkdXEwNHp1SUFNaXd0RUhRQzFDNkdWVlpwYjZxRjZlV3JJbDlSSU1v?=
 =?utf-8?B?cERwZStPS0lLWlNwTlVPam1LOFRpWDdLYXJ2aTkzWEZONXJTSnRGTHJzZDV3?=
 =?utf-8?B?d1gwcEZYQUdwWml0b0o2ck5GRU9GYVN6ellYT0pKSWxSVUZBZUNrWWEwaTcy?=
 =?utf-8?B?cUppNWpNbGVsWlhoaElHdUMxOVNjQkNZMWJQS1JaVlp4Y2FiT1VsNHk3U2tr?=
 =?utf-8?B?cStXaStPWjJpUVc4Vzl4QTcxR2lOa0RTdnNJUzlmSVNnU2lZZTFOaklnOFdK?=
 =?utf-8?B?elQ1NENkLzZuU1JEQUZWQVc1eGdZemN5NnptY1RtQjlyK0hjSElpRHJTbWpt?=
 =?utf-8?B?Q0tTS2lRMEtBS3psaEV3MU9Ebm53U0hQdTVqQ2VxUEhEaHlacndpd2pKRUpG?=
 =?utf-8?B?amJFUjJlRTJjTUpULzV0SklzUGF3ZzVmc3Z1R2FxUjhTWDdISEVnZWJTdzNw?=
 =?utf-8?B?NDRSQXgrNmszN2ExRFZvcTVZOVhPb0o0YVhKU1hrMUo5alFHT1k3N01rTU95?=
 =?utf-8?B?WnkzNGEvNFpRekdxMHlSZnhzamRtODhEVDZFNkpqdS8ycDFhenl6QlNxR2hl?=
 =?utf-8?B?bTBrVGdhVGVlRytOMkN2VkdJMW9sZFN1aFRZWml0R1prY1VuQUo5SDlSdjJn?=
 =?utf-8?B?OEI4U1lEVHpjRndUQUFMZmpteldNV2YxNExQRU9WOWVNOEJmZk5RY09NUTlK?=
 =?utf-8?B?QXJNekVmVjFNUkVIUDdXUE40djE0dWMvN2NScEdldTBDWEQvOVpjVll2cDA2?=
 =?utf-8?B?WnlDOEtpdmt6UFdiQmQ0RjBFdnBwMHArazZnUWxRTmdLd0h5bVR1K1did2ln?=
 =?utf-8?B?Z2xwNHFVMWZkelFWaE93ZFNiTWFxOURhcEZobTRmMS9VMWd1ekRCVzlodFJN?=
 =?utf-8?B?NUxmUTY2aDViNyszOGFaeHhNZHlSam5Jbi9HTml4enBQR0hFWlhXTlBoa2VF?=
 =?utf-8?B?bzd5SUNMWXRZN0wzM2N3QXV3QTZMNHdZUktuMmR1Mm9hcVdmMTJ3bnkvRm9K?=
 =?utf-8?B?S2Q3cTV2TVlnc3RaNUdTWk1ZZnlSQXQ0ZFlkdVZLejhDVktpS1QwSnJoMVZw?=
 =?utf-8?B?MnQ3V3BiQ0psQnd6eVZUOUlDelpIeWNFb2ZjRDR6SGFGaEFFN1V0MXpoQ2Jp?=
 =?utf-8?B?Q1BjV0pUbXViRGMrWm5uSk1hT0UwS1pyTjlUalJUWTY4aUFxSHVOQjFodm4y?=
 =?utf-8?B?UTZOS1A1dEx4aGhyYmVselJ6bXpyVUpNdzd2Y0s2ZlFBeElFN1N2ZHRBTWlr?=
 =?utf-8?B?S1lpa0lmMU1FL3hBdUIvNk03MXppT3VpNzJ3UUtXNlpIZDN4TWtUQXhyUTRO?=
 =?utf-8?B?bXdhdUs1R3dJVmlHeFdKMDl5NXRtVWVhVlVoZVFqZGp6VWNVZDVYZTJNaUIv?=
 =?utf-8?B?OHZ2WnVPcTJQZXhHakF0TS9mZGJlU1hham0xdmw3ckNwTTBiVXZQYUZEZVI5?=
 =?utf-8?B?SGpaY2hEL2lVekljQzZwcUNRSTV4ZzYwakdBTWJPN3dpODFpa2RrMDVna3Jt?=
 =?utf-8?B?TndCSkwrVSt5Z1RtVlVXOVpJbU0rMTYyb29kTS9RSjN1ZkJnV3c1MmFnTWtx?=
 =?utf-8?B?MFlpVmloUmNlQ3lxVzVsRTJiL0tjMVUrekE3Tis3VG00cnROa0o2SDl2MDVE?=
 =?utf-8?B?Uy9TYWVTQmUyMFBraE5TRys5eHMrOWUyclk2dHBDaXNxVW4vT213MTJtVk45?=
 =?utf-8?B?cWF6UUtYZXFaQzNPSEc4VnB6YzkzRHNOWWpKVG5CMXVZenZRdjVmNHRhMksz?=
 =?utf-8?B?NnEzU1YzV25KcU5NblVZY2gvMmNJL3V6SW1oWER3eEREMkIxTjJmS0Z2TTVX?=
 =?utf-8?B?cEF2c3dwTjBtbWJBdlBRUG16eDUyUU9yMlpNb1lHVDJweVFHUWhXZldmUC91?=
 =?utf-8?B?cmhBTWtPS3M3VmxCb2h6V3ZQenkxQjdTK0FkdFN6UGkvSUJDcTlsL2laVk1n?=
 =?utf-8?B?NXZyZVVyM2tSby9Ca3drbTIvb21mdWt1ZjFabzNWc1pIZXJBcTFpTWVKOGJB?=
 =?utf-8?B?N0VWQWQ4Vld6Q1VoWEVkeHNVVDh1UjE2d2E2VkUvTUFsYzhoR0tTVmdGMzlU?=
 =?utf-8?B?T1RGSGtKZTVoMXA2WjR4T2lvSGJLNDNPTTNSbS9ZbmtlVWxxSUVmdUdhM0xH?=
 =?utf-8?Q?Nc2U=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677e0416-32cb-4afb-67b3-08dbbeb13a63
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 16:54:20.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaLrTSwHW6+2Ntn2N8w+glhZT8uKhL6HXXWqJFOlCIAg72h+RU9cQBUq9+UqN8u1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4230
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/29/23 18:44, Tony Luck wrote:
> Existing resctrl assumes that control and monitor operations on a
> resource are performed at the same scope.
> 
> Prepare for systems that use different scope (specifically L3 scope
> for cache control and NODE scope for cache occupancy and memory
> bandwidth monitoring).
> 
> Create separate domain lists for control and monitor operations.
> 
> No important functional change. But note that errors during

Its better to remove the line "No important functional change."

> initialization of either control or monitor functions on a domain would
> previously result in that domain being excluded from both control and
> monitor operations. Now the domains are allocated independently it is
> no longer required to disable both control and monitor operations if
> either fail.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  include/linux/resctrl.h                   |  16 +-
>  arch/x86/kernel/cpu/resctrl/internal.h    |   6 +-
>  arch/x86/kernel/cpu/resctrl/core.c        | 227 +++++++++++++++-------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c     |   2 +-
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |   2 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  32 +--
>  7 files changed, 199 insertions(+), 88 deletions(-)
> 
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 2db1244ae642..33856943a787 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -155,10 +155,12 @@ enum resctrl_scope {
>   * @alloc_capable:	Is allocation available on this machine
>   * @mon_capable:	Is monitor feature available on this machine
>   * @num_rmid:		Number of RMIDs available
> - * @scope:		Scope of this resource
> + * @ctrl_scope:		Scope of this resource for control functions
> + * @mon_scope:		Scope of this resource for monitor functions
>   * @cache:		Cache allocation related data
>   * @membw:		If the component has bandwidth controls, their properties.
> - * @domains:		All domains for this resource
> + * @domains:		Control domains for this resource
> + * @mon_domains:	Monitor domains for this resource
>   * @name:		Name to use in "schemata" file.
>   * @data_width:		Character width of data when displaying
>   * @default_ctrl:	Specifies default cache cbm or memory B/W percent.
> @@ -173,10 +175,12 @@ struct rdt_resource {
>  	bool			alloc_capable;
>  	bool			mon_capable;
>  	int			num_rmid;
> -	enum resctrl_scope	scope;
> +	enum resctrl_scope	ctrl_scope;
> +	enum resctrl_scope	mon_scope;
>  	struct resctrl_cache	cache;
>  	struct resctrl_membw	membw;
>  	struct list_head	domains;
> +	struct list_head	mondomains;

For consistancy, its better to rename it to mon_domains(to be inline with
mon_scope, mon_capable).

>  	char			*name;
>  	int			data_width;
>  	u32			default_ctrl;
> @@ -222,8 +226,10 @@ int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_domain *d,
>  
>  u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>  			    u32 closid, enum resctrl_conf_type type);
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d);
>  
>  /**
>   * resctrl_arch_rmid_read() - Read the eventid counter corresponding to rmid
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 85ceaf9a31ac..31a5fc3b717f 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -511,8 +511,10 @@ void rdtgroup_kn_unlock(struct kernfs_node *kn);
>  int rdtgroup_kn_mode_restrict(struct rdtgroup *r, const char *name);
>  int rdtgroup_kn_mode_restore(struct rdtgroup *r, const char *name,
>  			     umode_t mask);
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos);
> +struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
> +				       struct list_head **pos);
> +struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
> +				      struct list_head **pos);

For consistancy, it is better to rename to rdt_find_ctrl_domain and
rdt_find_mon_domain respectively.


>  ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>  				char *buf, size_t nbytes, loff_t off);
>  int rdtgroup_schemata_show(struct kernfs_open_file *of,
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 0d3bae523ecb..97f6f9715fdb 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -57,7 +57,7 @@ static void
>  mba_wrmsr_amd(struct rdt_domain *d, struct msr_param *m,
>  	      struct rdt_resource *r);
>  
> -#define domain_init(id) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.domains)
> +#define domain_init(id, field) LIST_HEAD_INIT(rdt_resources_all[id].r_resctrl.field)
>  
>  struct rdt_hw_resource rdt_resources_all[] = {
>  	[RDT_RESOURCE_L3] =
> @@ -65,8 +65,10 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L3,
>  			.name			= "L3",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L3),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.mon_scope		= RESCTRL_L3_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_L3, domains),
> +			.mondomains		= domain_init(RDT_RESOURCE_L3, mondomains),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
>  			.fflags			= RFTYPE_RES_CACHE,
> @@ -79,8 +81,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_L2,
>  			.name			= "L2",
> -			.scope			= RESCTRL_L2_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_L2),
> +			.ctrl_scope		= RESCTRL_L2_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_L2, domains),
>  			.parse_ctrlval		= parse_cbm,
>  			.format_str		= "%d=%0*x",
>  			.fflags			= RFTYPE_RES_CACHE,
> @@ -93,8 +95,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_MBA,
>  			.name			= "MB",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_MBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_MBA, domains),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
>  			.fflags			= RFTYPE_RES_MB,
> @@ -105,8 +107,8 @@ struct rdt_hw_resource rdt_resources_all[] = {
>  		.r_resctrl = {
>  			.rid			= RDT_RESOURCE_SMBA,
>  			.name			= "SMBA",
> -			.scope			= RESCTRL_L3_CACHE,
> -			.domains		= domain_init(RDT_RESOURCE_SMBA),
> +			.ctrl_scope		= RESCTRL_L3_CACHE,
> +			.domains		= domain_init(RDT_RESOURCE_SMBA, domains),
>  			.parse_ctrlval		= parse_bw,
>  			.format_str		= "%d=%*u",
>  			.fflags			= RFTYPE_RES_MB,
> @@ -384,15 +386,16 @@ void rdt_ctrl_update(void *arg)
>  }
>  
>  /*
> - * rdt_find_domain - Find a domain in a resource that matches input resource id
> + * __rdt_find_domain - Find a domain in either the list of control or
> + * monitor domains that matches input resource id
>   *
>   * Search resource r's domain list to find the resource id. If the resource
>   * id is found in a domain, return the domain. Otherwise, if requested by
>   * caller, return the first domain whose id is bigger than the input id.
>   * The domain list is sorted by id in ascending order.
>   */
> -struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
> -				   struct list_head **pos)
> +static void *__rdt_find_domain(struct list_head *h, int id,
> +			       struct list_head **pos)
>  {
>  	struct rdt_domain *d;
>  	struct list_head *l;
> @@ -400,7 +403,7 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	if (id < 0)
>  		return ERR_PTR(-ENODEV);
>  
> -	list_for_each(l, &r->domains) {
> +	list_for_each(l, h) {
>  		d = list_entry(l, struct rdt_domain, list);
>  		/* When id is found, return its domain. */
>  		if (id == d->id)
> @@ -416,6 +419,18 @@ struct rdt_domain *rdt_find_domain(struct rdt_resource *r, int id,
>  	return NULL;
>  }
>  
> +struct rdt_domain *rdt_find_ctrldomain(struct list_head *h, int id,
> +				       struct list_head **pos)
> +{
> +	return __rdt_find_domain(h, id, pos);
> +}
> +
> +struct rdt_domain *rdt_find_mondomain(struct list_head *h, int id,
> +				      struct list_head **pos)
> +{
> +	return __rdt_find_domain(h, id, pos);
> +}
> +
>  static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>  {
>  	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> @@ -431,10 +446,15 @@ static void setup_default_ctrlval(struct rdt_resource *r, u32 *dc)
>  }
>  
>  static void domain_free(struct rdt_hw_domain *hw_dom)
> +{
> +	kfree(hw_dom->ctrl_val);
> +	kfree(hw_dom);
> +}
> +
> +static void mondomain_free(struct rdt_hw_domain *hw_dom)

Its better to rename to mon_domain_free

>  {
>  	kfree(hw_dom->arch_mbm_total);
>  	kfree(hw_dom->arch_mbm_local);
> -	kfree(hw_dom->ctrl_val);
>  	kfree(hw_dom);
>  }
>  
> @@ -502,6 +522,93 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>  	return -1;
>  }
>  
> +static void domain_add_cpu_ctrl(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
> +	struct list_head *add_pos = NULL;
> +	struct rdt_hw_domain *hw_dom;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	d = rdt_find_ctrldomain(&r->domains, id, &add_pos);
> +	if (IS_ERR(d)) {
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}
> +
> +	if (d) {
> +		cpumask_set_cpu(cpu, &d->cpu_mask);
> +		if (r->cache.arch_has_per_cpu_cfg)
> +			rdt_domain_reconfigure_cdp(r);
> +		return;
> +	}
> +
> +	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_dom)
> +		return;
> +
> +	d = &hw_dom->d_resctrl;
> +	d->id = id;
> +	cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +	rdt_domain_reconfigure_cdp(r);
> +
> +	if (domain_setup_ctrlval(r, d)) {
> +		domain_free(hw_dom);
> +		return;
> +	}
> +
> +	list_add_tail(&d->list, add_pos);
> +
> +	err = resctrl_online_ctrl_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		domain_free(hw_dom);
> +	}
> +}
> +
> +static void domain_add_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct rdt_hw_domain *hw_mondom;
> +	struct list_head *add_pos = NULL;
> +	struct rdt_domain *d;
> +	int err;
> +
> +	d = rdt_find_mondomain(&r->mondomains, id, &add_pos);
> +	if (IS_ERR(d)) {
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}
> +
> +	if (d) {
> +		cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +		return;
> +	}
> +
> +	hw_mondom = kzalloc_node(sizeof(*hw_mondom), GFP_KERNEL, cpu_to_node(cpu));
> +	if (!hw_mondom)
> +		return;
> +
> +	d = &hw_mondom->d_resctrl;
> +	d->id = id;
> +	cpumask_set_cpu(cpu, &d->cpu_mask);
> +
> +	if (arch_domain_mbm_alloc(r->num_rmid, hw_mondom)) {
> +		mondomain_free(hw_mondom);
> +		return;
> +	}
> +
> +	list_add_tail(&d->list, add_pos);
> +
> +	err = resctrl_online_mon_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		mondomain_free(hw_mondom);
> +	}
> +}
> +
>  /*
>   * domain_add_cpu - Add a cpu to a resource's domain list.
>   *
> @@ -517,70 +624,28 @@ static int get_domain_id_from_scope(int cpu, enum resctrl_scope scope)
>   */
>  static void domain_add_cpu(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> -	struct list_head *add_pos = NULL;
> -	struct rdt_hw_domain *hw_dom;
> -	struct rdt_domain *d;
> -	int err;
> -
> -	d = rdt_find_domain(r, id, &add_pos);
> -	if (IS_ERR(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> -		return;
> -	}
> -
> -	if (d) {
> -		cpumask_set_cpu(cpu, &d->cpu_mask);
> -		if (r->cache.arch_has_per_cpu_cfg)
> -			rdt_domain_reconfigure_cdp(r);
> -		return;
> -	}
> -
> -	hw_dom = kzalloc_node(sizeof(*hw_dom), GFP_KERNEL, cpu_to_node(cpu));
> -	if (!hw_dom)
> -		return;
> -
> -	d = &hw_dom->d_resctrl;
> -	d->id = id;
> -	cpumask_set_cpu(cpu, &d->cpu_mask);
> -
> -	rdt_domain_reconfigure_cdp(r);
> -
> -	if (r->alloc_capable && domain_setup_ctrlval(r, d)) {
> -		domain_free(hw_dom);
> -		return;
> -	}
> -
> -	if (r->mon_capable && arch_domain_mbm_alloc(r->num_rmid, hw_dom)) {
> -		domain_free(hw_dom);
> -		return;
> -	}
> -
> -	list_add_tail(&d->list, add_pos);
> -
> -	err = resctrl_online_domain(r, d);
> -	if (err) {
> -		list_del(&d->list);
> -		domain_free(hw_dom);
> -	}
> +	if (r->alloc_capable)
> +		domain_add_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_add_cpu_mon(cpu, r);
>  }
>  
> -static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +static void domain_remove_cpu_ctrl(int cpu, struct rdt_resource *r)
>  {
> -	int id = get_domain_id_from_scope(cpu, r->scope);
> +	int id = get_domain_id_from_scope(cpu, r->ctrl_scope);
>  	struct rdt_hw_domain *hw_dom;
>  	struct rdt_domain *d;
>  
> -	d = rdt_find_domain(r, id, NULL);
> +	d = rdt_find_ctrldomain(&r->domains, id, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
> -		pr_warn("Couldn't find cache id for CPU %d\n", cpu);
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
>  		return;
>  	}
>  	hw_dom = resctrl_to_arch_dom(d);
>  
>  	cpumask_clear_cpu(cpu, &d->cpu_mask);
>  	if (cpumask_empty(&d->cpu_mask)) {
> -		resctrl_offline_domain(r, d);
> +		resctrl_offline_ctrl_domain(r, d);
>  		list_del(&d->list);
>  
>  		/*
> @@ -593,6 +658,30 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  
>  		return;
>  	}
> +}
> +
> +static void domain_remove_cpu_mon(int cpu, struct rdt_resource *r)
> +{
> +	int id = get_domain_id_from_scope(cpu, r->mon_scope);
> +	struct rdt_hw_domain *hw_mondom;
> +	struct rdt_domain *d;
> +
> +	d = rdt_find_mondomain(&r->mondomains, id, NULL);
> +	if (IS_ERR_OR_NULL(d)) {
> +		pr_warn("Couldn't find scope id=%d for CPU %d\n", id, cpu);
> +		return;
> +	}
> +	hw_mondom = resctrl_to_arch_dom(d);
> +
> +	cpumask_clear_cpu(cpu, &d->cpu_mask);
> +	if (cpumask_empty(&d->cpu_mask)) {
> +		resctrl_offline_mon_domain(r, d);
> +		list_del(&d->list);
> +
> +		mondomain_free(hw_mondom);
> +
> +		return;
> +	}
>  
>  	if (r == &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl) {
>  		if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {
> @@ -607,6 +696,14 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>  	}
>  }
>  
> +static void domain_remove_cpu(int cpu, struct rdt_resource *r)
> +{
> +	if (r->alloc_capable)
> +		domain_remove_cpu_ctrl(cpu, r);
> +	if (r->mon_capable)
> +		domain_remove_cpu_mon(cpu, r);
> +}
> +
>  static void clear_closid_rmid(int cpu)
>  {
>  	struct resctrl_pqr_state *state = this_cpu_ptr(&pqr_state);
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b44c487727d4..468c1815edfd 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -560,7 +560,7 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
>  	evtid = md.u.evtid;
>  
>  	r = &rdt_resources_all[resid].r_resctrl;
> -	d = rdt_find_domain(r, domid, NULL);
> +	d = rdt_find_mondomain(&r->mondomains, domid, NULL);
>  	if (IS_ERR_OR_NULL(d)) {
>  		ret = -ENOENT;
>  		goto out;
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index ded1fc7cb7cb..66beca785535 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -340,7 +340,7 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
>  
>  	entry->busy = 0;
>  	cpu = get_cpu();
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->mondomains, list) {
>  		if (cpumask_test_cpu(cpu, &d->cpu_mask)) {
>  			err = resctrl_arch_rmid_read(r, d, entry->rmid,
>  						     QOS_L3_OCCUP_EVENT_ID,
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index e79324676f57..be8b5f28e638 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -297,7 +297,7 @@ static int pseudo_lock_region_init(struct pseudo_lock_region *plr)
>  
>  	plr->size = rdtgroup_cbm_to_size(plr->s->res, plr->d, plr->cbm);
>  
> -	switch (plr->s->res->scope) {
> +	switch (plr->s->res->ctrl_scope) {
>  	case RESCTRL_L3_CACHE:
>  		cache_level = 3;
>  		break;
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index f510414bf6ce..f2aec39c49df 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1346,7 +1346,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
>  	int cache_level;
>  	int num_b, i;
>  
> -	switch (r->scope) {
> +	switch (r->ctrl_scope) {
>  	case RESCTRL_L3_CACHE:
>  		cache_level = 3;
>  		break;
> @@ -1509,7 +1509,7 @@ static int mbm_config_show(struct seq_file *s, struct rdt_resource *r, u32 evtid
>  
>  	mutex_lock(&rdtgroup_mutex);
>  
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->mondomains, list) {
>  		if (sep)
>  			seq_puts(s, ";");
>  
> @@ -1632,7 +1632,7 @@ static int mon_config_write(struct rdt_resource *r, char *tok, u32 evtid)
>  		return -EINVAL;
>  	}
>  
> -	list_for_each_entry(d, &r->domains, list) {
> +	list_for_each_entry(d, &r->mondomains, list) {
>  		if (d->id == dom_id) {
>  			ret = mbm_config_write_domain(r, d, evtid, val);
>  			if (ret)
> @@ -2538,7 +2538,7 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	if (is_mbm_enabled()) {
>  		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> -		list_for_each_entry(dom, &r->domains, list)
> +		list_for_each_entry(dom, &r->mondomains, list)
>  			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
>  	}
>  
> @@ -2932,7 +2932,7 @@ static int mkdir_mondata_subdir_alldom(struct kernfs_node *parent_kn,
>  	struct rdt_domain *dom;
>  	int ret;
>  
> -	list_for_each_entry(dom, &r->domains, list) {
> +	list_for_each_entry(dom, &r->mondomains, list) {
>  		ret = mkdir_mondata_subdir(parent_kn, dom, r, prgrp);
>  		if (ret)
>  			return ret;
> @@ -3721,15 +3721,17 @@ static void domain_destroy_mon_state(struct rdt_domain *d)
>  	kfree(d->mbm_local);
>  }
>  
> -void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +void resctrl_offline_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
>  	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>  		mba_sc_domain_destroy(r, d);
> +}
>  
> -	if (!r->mon_capable)
> -		return;
> +void resctrl_offline_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
>  
>  	/*
>  	 * If resctrl is mounted, remove all the
> @@ -3786,18 +3788,22 @@ static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>  	return 0;
>  }
>  
> -int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
> +int resctrl_online_ctrl_domain(struct rdt_resource *r, struct rdt_domain *d)
>  {
> -	int err;
> -
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
>  	if (supports_mba_mbps() && r->rid == RDT_RESOURCE_MBA)
>  		/* RDT_RESOURCE_MBA is never mon_capable */
>  		return mba_sc_domain_allocate(r, d);
>  
> -	if (!r->mon_capable)
> -		return 0;
> +	return 0;
> +}
> +
> +int resctrl_online_mon_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	int err;
> +
> +	lockdep_assert_held(&rdtgroup_mutex);
>  
>  	err = domain_setup_mon_state(r, d);
>  	if (err)

-- 
Thanks
Babu Moger
