Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE07B7345
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241220AbjJCVXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbjJCVXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:23:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA17BB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696368197; x=1727904197;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZH6AvUee5eMubYNKHEfUmg/cGKYB350Ni4dmYZZVfBM=;
  b=hPOD9Mn656eKYA1h1MVv7qLAX9LGB+AC52xT+EUappaA5QUB0x+8ww3F
   u7D10b4xfvE832MBj8fMI0ZleYGiiLglcqtfm0bEjTTOUUhhViGEf9aRB
   SS8BZKSW5dIbp8rKUbkulGg0/vP6QkEUx96IxgKTy4n6EYwdKk9OlZmC2
   4PFEpuQ+rX8txiGAU1AsLv1cYZlrHUBbidKX4EXVMlV81jIQYY5T7dbBj
   xtC0OckivF90IUYBDkm+xmfQw35o3NpIZoCN+bW1yMyW73UV61es01A2Z
   hepsgDIgoS8qc3pEyXuiq7zjsgZqDtGF6Tq+Nd2dO0lALbcaMMAVnGNsH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385800831"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="385800831"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:23:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786239227"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="786239227"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:23:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:23:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:23:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:23:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:23:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsVWntJ3UPLXPy4CB2c82z3Ge6V6pucFdxItPVZEjucu0Jl77MDIDLDN2l6d+iW9ky0tgvLDkUfgd+IU+buVTs+czc0MgU6C5XDZL8WaeXsVK8qX0HHIDilgQdsSZsIYDfuksBbpVyxZ5tovk03TzTL6HH874uFLs9yRl77O7AzurkjXGaUIxTmGXI2emZa8GJLIz8Sxlt8SVpUQ1tKuQTcXGpatDydVOxXRvUVd2uTu9+AL4hpz3asydqOWhEwcvqma/cJqvSpEZ392MxBiHbPAzcWYnoLai33sCnFTcj2aS46sqOOsqFULrJwSQbLrxZLv63fQBgqfmYk803XBvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPemIfEwNdZQ5w9MZdkd5W5TLCsTyBr2cd9I6gcf+9A=;
 b=jnEG3B1mCkFl5rnukESqIZRKUJqgVsi96rA2V8x8lc/EpsKIntu9u+Ib2rkUpRZg+5mJGwffBpdC6S3gfeG2htjDaAW7Xqy/aK2oatAW07JuaaVr7iqNU2GWDx7X5+BQCISfBWha4k2Y/G5fj+ngyDw6osIzJNeMkVF0xU95fYU1Pb3uO7iaqmtF7mcOpu1DFzt+whSeC5+PkbxVZ4Jgv3HumXMyWzQaU0KaA4iif/IgyLZpVmwqKTwfCBpusxzj6mJhQBdqAUbgMizMkhP1Ug/l2zw2tZ2+8SMgO4PMjamPSdeeDuKVY9z5RsYt1px2ou98rEMPxvjlvc2kjG2s2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SN7PR11MB7603.namprd11.prod.outlook.com (2603:10b6:806:32b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32; Tue, 3 Oct
 2023 21:23:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:23:13 +0000
Message-ID: <fc437191-0fb6-92fc-c5c6-5387c254e065@intel.com>
Date:   Tue, 3 Oct 2023 14:23:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 22/24] x86/resctrl: Add cpu offline callback for
 resctrl work
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-23-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-23-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SN7PR11MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7efde0-640b-440d-083c-08dbc456f383
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F30aTJKUo8jIiwB6vMvfCnpmstrtpdfPDMiwcm5TtEde08EN2d5UrDDg0VuTt2GFsOELrnE6+XK7gEZkvlEjcoGTZ99Zh5q11Ea403mOYVNT/f3kNGd/sLTXaY7Ij3mLFIbKRxRl2HpQIilyg8r511xpVGcXlPTD00V8ZAyt48z6bre3fFpvbxfj3kWGy3kG5EyOgEcwoL0EjAWSt8CX3l8SsIaZJfhXM+dpEBePJU0NAmbaA4g4YpHJ7K+0+h+jEGO4Wu3E92OkZTYasPef3aWRyKJ8YyX57ix3D3+gCwnBJEXWzyf7teqknL+0LEqNbrrqgvtiLvYR3fD8LmYlK3DjKS04YaiLD/NEx+sjKnoU33JqLfn/otbGEsSEwv6baStUNz+qSQqk+8X9WOHQjvZLYJh+uAuQUqDBvJSDPp8gh/FafNkV/d12oKJzKth+cqx0ustpz7P615lAX0KN8lABaCj4tzGHO16vaysje8fWjnElGbAu4O/Pnw4jwgTIRHo7Nq6JkIOyUJwdfcPiIn36SIH0FR2cr62zxEleMIIIx10CbcY0sqCo6GKbenvc2AvtDJiIExH4E6WSEWMP4AMD1KvNvUJ/IFShvgMFrKG7lN7jM772VvLllR6TE39o71WHpOBEm3V710uR661VxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(6486002)(6512007)(6506007)(53546011)(2616005)(83380400001)(38100700002)(36756003)(82960400001)(86362001)(31696002)(2906002)(7416002)(6666004)(26005)(4326008)(5660300002)(66946007)(41300700001)(478600001)(8936002)(66476007)(66556008)(44832011)(54906003)(316002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnByMUZlbUFteHp5L1F3YVA0bEtuMzk0elpWOEJRZ0pxOVZ2Q3FYZkZQWVBj?=
 =?utf-8?B?SVJvVDhWOEZ2ZmxtdEpvdVNOU2VtZlFtdXJCN29qMzBwWllWVUZOSUluenJz?=
 =?utf-8?B?cmFKRVgvRDVLSnZsMU1ZUkN2azlNMEZRcGRjNHNVM2VPNUJPbU02OC9WQmQ5?=
 =?utf-8?B?NTJ3QjgydjZMRldKeC9mOThVQS9ZNklaK2FQWlNSemNGTGE3Wm16Um5XdE9B?=
 =?utf-8?B?bFdDcktieUJkcEtBYTY4RjlSd1N1OGxHb2crSWx3WjJRb041MEFkUEFXNERF?=
 =?utf-8?B?RkpxLzRqYXY5LytUd0E3U0Z6UUJmdFUyS0gwNGJ3T2lLSjhrMTJ5VURlLzNH?=
 =?utf-8?B?eWNyUk9DTnk0NkxJdFpTc1FIanpUZVpGZWdVQXBTampmVUYzUkxha08xQkVJ?=
 =?utf-8?B?QjZYd2k3dHJzYVkyY2I4Q1VKRVpZdncyc3NvbWtGa2NzcEo5TjdydHpKampl?=
 =?utf-8?B?UVgwaVBlS0x2S0hPcFA4a2JPMFdDcWZ6R2RlU1F2d2dOWFRJNHo0dXRpUHF0?=
 =?utf-8?B?QXRhY0d4T2Rxa2M1T0pPS1M1TXBRNnh4Z0NLRU9IZXo5bmVlVXlUWFpRYVRL?=
 =?utf-8?B?WFFIR2h0V1lPTkk0UldGbTlNTGx1RDJUSmp3OEdHSEtTMFhZYlFmSCtGV0Vv?=
 =?utf-8?B?U2QvbFU3Y3ZLVzh2R2lFajFYMXdNNHk5amJmTzBSTzVBeVZ4R3NlQXVqeTJs?=
 =?utf-8?B?ZmxnUEtheHd1RTg4b1duRVdtRGZndEhpTzQzUGcxSDY5RWxFNlQzK2tLb3FU?=
 =?utf-8?B?cXV5aS9CQldMeld2a1lBUm5mWUl3aXZ1cENHVUpaK3daU1VsRnhxZFBSZlF3?=
 =?utf-8?B?NXQweFZ0UnQ5Zk8rTitGU1daZEZTalQvSVRuNURUajBPdUZYVUJWVDNyTUkz?=
 =?utf-8?B?M01YeGZSaGF3bE13dG9qZVNkaEVzKzBkUkhjTEptN1I0VEtpeUdYbEN4TUtH?=
 =?utf-8?B?TFpmOVBHVGlSTEloall1SmxmSDRRVnVwai9yZ2JvMXQvYkF6Y29WRjV1NW9F?=
 =?utf-8?B?NGJMNy81bUlJRnF5Q3hXY3NyVUhndGJwazhQQ3lYMkxsSHJzemlUMHJGYklV?=
 =?utf-8?B?QXNSTkhJMXpZREd5SGdSVURoK1BtVXNyaU1JREg4TEVBVStuc1d6MlFGTDBG?=
 =?utf-8?B?dmErU3BTNjhtWXNseUJMRlFtamFBUmN5UmZqb2Q2bVdFY3N2L2U0dktGZzdy?=
 =?utf-8?B?Q0FmQWUvaHJ5bCtKWUdUVXNOYWQvVS94cEZ2aUV0a29GaWFSelhpK2RvR2Ir?=
 =?utf-8?B?NDNveFpqTVZMSUgrbyt6cFBnc05paVU1ajdQbmxlSFh5c1R3aXlwS2VYNVIr?=
 =?utf-8?B?NDE4ZnVEZ2xGbGp0UnJCNmxpay9hZjQzbmN6a2xJVW9DU2NHd3RJMHpPUmdp?=
 =?utf-8?B?ZFE5bVpRenRXNzVRSnhTMDU0cVRDV0krOGVFNWhOdm9ZczRneHpPb1M3TzRY?=
 =?utf-8?B?aTJ5d0FKRmV1WnR6aDRDdkpjcXIwQmtIcHBneHJ6QXRqMnBpZTVWMmt6TDRi?=
 =?utf-8?B?dGcxQWtqNGdSbWFacnVDSVZuMEJvdSt0U2lWVjZBdFdlVlVRWkpNMERrcnBI?=
 =?utf-8?B?WVBlaUVKK0Z2Y0Zyd2J6engrYjhYZUlZd0FmRzhZUVJWYkNLODl6S0hsZzdJ?=
 =?utf-8?B?T09RckZYUURyNHIrUDJ4eDB0eFR2UVhmR2xqaGhWYUMydXdXazFqTjRVY0Fh?=
 =?utf-8?B?YzFFR1BrR0ZHU3UwSjVjUUU1R3pGRVNnbEkvbXBPYXRSek9TWTRTRTU4TG0y?=
 =?utf-8?B?UDhTQWVyemlHcUtGTzlRWlpqWVNnMWxpKy9WaEJpUFpKK2hLUkpsdy82STZ4?=
 =?utf-8?B?Q21aWUk5K1BKT2UwWWpncWpETU9Pc3JSUjNvcnIyL3N1THk5cXZZMGs1WGtH?=
 =?utf-8?B?MkdHU0Q4Zzh3dmUrNWdKZ0VUZzlDb2oxZWJvSWFIZytvcmIvNGZkakRsUktU?=
 =?utf-8?B?cFhjamFHWkFkTzdUNFo1MTZFbE43aGRxMEdjQWJjRFJ2dVRhUXdIRVNwejBT?=
 =?utf-8?B?TVNWZlhBWlZ2OXNmVEEyWmpiMGdOK2ZHRmx1ai96REhwY25BVzRKNFprRlJ1?=
 =?utf-8?B?TXRlZjFXaFhZN0t3WG1yWWhpV0lwcVhZVzBRZVNtSk9MNU4wTmJ5NmJXUFRI?=
 =?utf-8?B?TWN1MjNUZHBEa1k0ZHlZczd3WW4zU1B6aGRncnNteXFYdkpYTEhpcmtIaDJU?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7efde0-640b-440d-083c-08dbc456f383
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:23:13.7099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyngC42yu2gttt3n87OXZ0PapQDR5PxOi7BdzCKl/osTaVeYge2zLWcEml5oiwEgsHLSsyxgf7036yCErmw3+MWPb/3sy7AhkhYvq/QpKeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7603
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:
> The resctrl architecture specific code may need to free a domain when
> a CPU goes offline, it also needs to reset the CPUs PQR_ASSOC register.
> Amongst other things, the resctrl filesystem code needs to clear this
> CPU from the cpu_mask of any control and monitor groups.
> 
> Currently this is all done in core.c and called from
> resctrl_offline_cpu(), making the split between architecture and
> filesystem code unclear.
> 
> Move the filesystem work to remove the CPU from the control and monitor
> groups into a filesystem helper called resctrl_offline_cpu(), and rename
> the one in core.c resctrl_arch_offline_cpu().
> 
> The rdtgroup_mutex is unlocked and locked again in the call in
> preparation for changing the locking rules for the architecture
> code.

This last paragraph may cause some confusion since this refactoring
is not changing any current locking. I'll defer to you if you prefer
to keep it.

> 
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-By: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
