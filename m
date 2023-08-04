Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B7E76FBC3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbjHDIOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbjHDIOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:14:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3D468A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:14:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyDc75jB5OqZ04GdhXhsR8EbWhJ0pxvoQxu24i067GViTPIfBysfwMyUOKhhKtFHxqZtFB/MJVfwrLm+Kh6B9DGWHNepAI0i/Uty5oakyy6LoyGuO7SidTluU+cMO8TAfVYAP9zaT4OOtB06XJPS8EqCzNZjXBM4C3SHOrJ/tKye7WEpzGIeiLzw7mpD3gh/NcSRJjcfgwPAoWgvPIjg1tfYvipW9FiSuoX3IIkMrgtHCnP3rxQqkWgsfWcV95GqiH+SdIwQ/0a/Rf8HkBPvQwdnUs7OB58Qux1N8V96hhgV/pwL8N68nX49aPhcsk/Q1hlsHIJu+3bmbwrGq67+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdmaYYJaj7wsM/lM+11OVN6RrB7LZkDFV55Qxb92eXM=;
 b=OunAXFxtE5T6AKCF0juL8DeBY0AyM9/QOkS21eO+n63ySWPYp/sL4tiYLO/6Wkx3eBWE9I49V+p45rtz0lNhLoOoPZ6J0DeUh9deiSBJ1eNYCPy3x7EiasirpPdvfblgKQYKINSJDliZf4q3vqDagTvd8C0sTAER6aaQHbVEC111fQVbtPGYMdsaJL2+/TdhrMtGikkwoT83K2zq24oKqZo5CicAY78zuzWbJbnOsM2Py+eMVzzdQX7bPjWv4PjmbyJbUzsnnnU7z37itGt7EjVwBqpt2azl4AxPqGQ6w1hnQdp+c8VIbGfQSIzOvWRV+sn45CkFCpQrILkEFQyPgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdmaYYJaj7wsM/lM+11OVN6RrB7LZkDFV55Qxb92eXM=;
 b=OxOC6dgm251gsJmElIw+6OiMWuvCDZQXVK4kSGCf0G8w8NIYMPL5KKD3V7EoYmC25pjfr1gBJiW6OJlm8aqkG684OL03BzbHBMG+B5C2/pY6IgxgOel2uRx76cWKMLLT1cqE/x6UALMLQhluJwiQ3ExbCAa7dhpbO5hmVl5XQlk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 08:14:40 +0000
Received: from MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb]) by MW2PR12MB2379.namprd12.prod.outlook.com
 ([fe80::319e:591f:38a0:6bbb%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 08:14:40 +0000
Message-ID: <03ded839-a746-b741-02dd-c10fe37460bf@amd.com>
Date:   Fri, 4 Aug 2023 13:44:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [patch V3 23/40] x86/cpu: Provide cpu_init/parse_topology()
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20230802101635.459108805@linutronix.de>
 <20230802101934.026097251@linutronix.de>
From:   K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20230802101934.026097251@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::7) To MW2PR12MB2379.namprd12.prod.outlook.com
 (2603:10b6:907:9::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR12MB2379:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 300daf16-a5e0-43d8-7d9b-08db94c2d990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHdV4+PtXF6WA1CQ/tWoysELkSH+q3vFOPXrk9EW2VFlF05MlYRlmk08vjXrtL67Yx7gOS88y1fCSh/TKKyG2RACUSM6Z9vhvyHAHaIdk1ghLEYsYgg/BLno2muEOObvTVyDDYGx6kljSJCq1AtiEkyfU/hDWEkifCbEPPOzpFwezqKOPfl9v4lbFnzj5ojwCbq5CnaqlCndsGgurAnjXsoBqK0RgklEqXXPObdU+Jjl/dcMviMrTWQlLsSR8Lu3wGMc2G0ddcHs2DIJGCXn03lOs8dNdhkGxKO2Hm7YXsQhHXVTQDBGkx2P66o/zKLxPOUzYjsZBf0OQbKwiOtbERhvC48OAwkO5MXb29O9ZEo5+RBVNmDex1SkvmaAa2X3JrNKE2jWv4WBG+UhxxY6E4B2/3iVkoU9OBwIsKgyRVIiRA5d32kF6fA563bMr9mFpKM7eghWmUKKYGnuikqwW+2hgDCeW4vL2GlONH+HiMIxyeX/F7IyIl1vRcviw/QwEJe7VpYhNFtHiytJ+APQYLJZySdsWcVgq4/dLVM+NqotRj28W1vIlNPGu8adccaT49RbzHTfiQQuF+zY5KnsKJ9XYdaqzP89OZb7HsUFxkevElS3KKZBNGkelVMbcOZ/WvToS1K8S2i+sXld2Ztv3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB2379.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(1800799003)(186006)(41300700001)(4326008)(2906002)(66556008)(8676002)(8936002)(31686004)(5660300002)(66476007)(478600001)(110136005)(54906003)(316002)(66946007)(86362001)(31696002)(6666004)(6486002)(6512007)(38100700002)(26005)(6506007)(36756003)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWc2bXlsc3ZnUVRXKzd0dXl2VTR3SU9tdG0xTVdVek1OMTZIS2NzUlE0Sk82?=
 =?utf-8?B?bGZETE1FNGU4NWdxN010czNLb0VTYTZwMjcrT1ZtOTlFQzhFWmdkQUV5cDYz?=
 =?utf-8?B?a29wVkVQVVQ4aHZhaTdEeTlOT0NzVlJtdld3Ny9YNldsZ0oyanlRRFQ4UGoz?=
 =?utf-8?B?YmhPS3pZZmdjL3lJNGFtL0VZNGptMzlNOTFzRm85R2NSRVFkaEFvanVDajN0?=
 =?utf-8?B?MG5UR0psV0RhdFdQVThSRFZTaURVdkZMVFBRQk1QUkVYS05malFHVUNVV2xI?=
 =?utf-8?B?YU5Cbzl6TE0vQ1NhcDk4b0pXRkgzZU1nTFVhTlpqb0hPOTVtY1V4bEQvbEVi?=
 =?utf-8?B?ckRMOFZxa3J0dXlJbTdGVXRzYVdWdXlndlkzUHZuRDVjamJaZHpaRFRmdHpC?=
 =?utf-8?B?RVFxdWlRVVhzeGx6UmtnMjMwWlV5aHRaU1hld1FqMzhPZlU4ZnZJRVNacDF4?=
 =?utf-8?B?YkpYVUN1c2RzTGVpTXJNWlN6VTd6cU84cWFDKzloSFpMQndYU2hFZEZUcGNa?=
 =?utf-8?B?UFFyanl6R0FsZU9GbndUWDl4NmVpd0JScVdWVU4xWmNUdlB6VjZaTFVWdXhz?=
 =?utf-8?B?cEQvRFZEbmpRc3RwWC9LbHV5c3M4a0xJZW5HZWNsdkJ1Tm9iakZKQjQyTGRQ?=
 =?utf-8?B?YTFHWjJEd2VicTJZdG1Hb2tnS0xKaDgvOGlqd3l4VzZuTlNVZnZjMDNUeDFU?=
 =?utf-8?B?VHpyRENVWm5yTUYvRk81VWxGMVhZZjFiK1loM1BCMXp0T0pTcEhDM2V2TVlx?=
 =?utf-8?B?M2FaYVBzTXlFdGpyYjcwUC9naG5RcHF6WmRWWDJJbE8wUFMrRzZ1OVoyQVl3?=
 =?utf-8?B?dnZBNlVNcmZ0WXFVQ2pXQmJ6R2JKV1QrZlR4dW5Jd1FObENiVU54dEdCcHg3?=
 =?utf-8?B?a3h2Z3prV2pFZlkvOC9Wd1k4b0UreWJTOEhWK3RKY3lFd3l3Zk81VXh3aHRV?=
 =?utf-8?B?YnFRWFh6bERBSmdpUW5CZ1VHK2VyQTJQNHRjcnh5emtLVEZvODAyd1lXOUN2?=
 =?utf-8?B?OGJOdW9MNUxMQVJoTmVuRUhNUWV5ckErWVJjNHNoSGgxSVdvMThnbm52RHhT?=
 =?utf-8?B?aUNiYTVLN2lpOWk4MFhVTTZnU2YvL2ZFM3MvamlyR3lBTEsrajhuN0tkSWJO?=
 =?utf-8?B?UlJyZDZ6QUV4OEVsdTR6czJXUkFSWW9aVlJJajVWWDhpWVBKZUgvZEIrcHk0?=
 =?utf-8?B?LzlpWVNPQWhOa2I0RGFaTWU4UEJlbVRpTjRUeFE5NEN2Z1M1TlhKZ2dNSi9E?=
 =?utf-8?B?N3ZIUW95M3ExTEFuWDlSbzFSZjVNZERYUE9FSUljZlZIajVQSTVFbnFmdHJ2?=
 =?utf-8?B?VURYaXFwcHFHRjg2RExiYnVsZ0FjS3ptZ0ZsWW4rbFhIeGdKcGN1TTIxZ0lQ?=
 =?utf-8?B?WUVONTJIRTE3TVFuZXd6T2paMUJJZG9Rb1lKTklEdXZQS2lGWnhiclRJYldq?=
 =?utf-8?B?emkxcVhYUnE4SDNpSHNRK0VXSWlVMjJQcUxEZTNBRS9yNGR4ckNXTlA2UnJt?=
 =?utf-8?B?ckJTVnJJRjBaUzNZQkoydFBVUW5EZktVbWRZc2xJSDBWU05sSklZK3A5amNF?=
 =?utf-8?B?SzJHZzZ5ZmdodHdPUm11OVVuNlFQWks0T1dWU09VcEhaVldha0UxS05tMDN4?=
 =?utf-8?B?ZzkzLzJDN0IvZ3p4VEJUZ2lvYUdKak1QNUY4ZTZ5QThFZ0JjMndIRWJkYVpi?=
 =?utf-8?B?eHlDMjc4R2pBd25OWUgxcVNPeHptVUpocUVqTldQRnlWNlhhQ0Y0RDdpS1A1?=
 =?utf-8?B?MW9qekR2R25ibC9ZRGYzS1NJdjJkRUZ1WFdRaXFhYmM2QUxBYkxDNW1mOG1T?=
 =?utf-8?B?YjhzUkVZUktxTHhCWVFkek9xRHZVaTd5ZzVXd0sxc3VLWUJOeHltMm10S255?=
 =?utf-8?B?WFpJUWZ2VU1KbDNUVGFBbitvdis4MFNJd2VmeVE1NHYvbVFPeitwMUd6QmVa?=
 =?utf-8?B?ZmlGelgxZC9mUHlsZ21UL3FYeGpyU3pwcHBicU5KT3hQUHJ2Qy8vTHpyTitn?=
 =?utf-8?B?Mkd1cGpGZFlPd0lWVklOcVRHOUo1RW1CSFZpeWtRRDVLam1rVGpCQmdXUGxX?=
 =?utf-8?B?dzRqRFd2SjNpeHVYK3R1V2c4aVlOYkxVWXlNZWNNR1VVU2dIdTRRRGgrayta?=
 =?utf-8?Q?wC28VwMXjc46Wz7zltPdguxDZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300daf16-a5e0-43d8-7d9b-08db94c2d990
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 08:14:40.2188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gnPzDcfQjXJUfdtIhJhmfk3Im7lMhUg+8movJxAcUmR3jbNaB73N5cAcHPhfJyH+mfHS9Cxk/fGPSln5K4Tog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 8/2/2023 3:51 PM, Thomas Gleixner wrote:
>
> [..snip..]
>
> +static void topo_set_max_cores(struct topo_scan *tscan)
> +{
> +	/*
> +	 * Bug compatible for now. This is broken on hybrid systems:
> +	 * 8 cores SMT + 8 cores w/o SMT
> +	 * tscan.dom_ncpus[TOPO_CORE_DOMAIN] = 24; 24 / 2 = 12 !!
> +	 *
> +	 * Cannot be fixed without further topology enumeration changes.
> +	 */
> +	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_CORE_DOMAIN] >>
> +		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
> +}
>

In Documentation/arch/x86/topology.rst, "cpuinfo_x86.x86_max_cores" is
described as "The number of cores in a package". In which case,
shouldn't the above be:

	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_PKG_DOMAIN] >>
		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];

since, with extended topology, there could be other higher domains and
dom_ncpus[TOPO_CORE_DOMAIN] >> dom_shifts[TOPO_SMT_DOMAIN] should only
give number of cores within the next domain (TOPO_MODULE_DOMAIN).

Am I missing something here?

--
Thanks and Regards,
Prateek
