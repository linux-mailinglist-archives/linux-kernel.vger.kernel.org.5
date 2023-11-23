Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A27F5D32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbjKWLCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbjKWKzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:55:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FDED44;
        Thu, 23 Nov 2023 02:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700736945; x=1732272945;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KN/dn0/rO4MRcaj1xAw32HIFdCZyC10cW87xz3s8pzU=;
  b=UG5yUoSIKiuuzr3EU1lchmxHCWHprz+8jB0VLie3yAH47Z/r4/W750fY
   V3/XDEkaDXvrdhIYQMLDHIMaj84oMFLQgBKjZ0ay74DIo0uuAg85NBJCe
   3X3tHOIU5C+VVDW32NBxKT3iGuZcdQb3SXNwnRIrqj3aAvX6jWnnouKJA
   yuskRd6nhdDmfZ5MKlDisk+SNHWMnFNA8tHrzz/lN5Mw8y9dgT0MgskuL
   HuS67T0sGuWhJVtwZfSiW1vVNYQGXoILHwLL4ANpbWw5otsyhBZjHv7ol
   aniGVrckGHmQL2QUIUCni+hR2FcGKSTCNBdD3i6DLXgqumqUzCjhiJ7YA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="371599452"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="371599452"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:55:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="770957896"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="770957896"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Nov 2023 02:55:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 23 Nov 2023 02:55:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 23 Nov 2023 02:55:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 23 Nov 2023 02:55:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evu9MSQ0jnFiJPiuTVIrI+lyWBwzypEntJwll8r2LWVspCdR5QsS86gI1TfGvEkgSPmO3+ISaZkhNHBT+3Rb4LbD8HeaGgDCH9Gzhq5phHyamo1sVpxTNXNivp1Aluugrd4Fm2RlDz6DNT5ztUz4uGcicPabagPiJqB7tRISHePBA0bHw1RL0+15ZlpKrXUgQuiCWjkuHNUq5JNXu23cctHR8pTHpvjMWvMXMq6Yk0zJ7QX32XlMw6YBGdmsp4LZQMHnU8LkrXe4KcouIaJRcJwyVcX+W275vgVsxCPvw2Eha1vEInwIPigBge0kq6CxynyphrhTrcLJXIOXdS5Y6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFT7/OHiv+dISkyy83CFgX26fJSBMhwKHDVSD9zu+LE=;
 b=GgECT8fh6qNLTSVwKqe8H0eKJUPoT4OHBMyVxkuBeWkh+tLZB7H2RlU84wZo4lkRPvkmO587BWv2LiwfIMe7J6k/h283et/ER0WfW5ljInwvL0qyXfpdkOOGy0hDsN/s1dv406w4ay2M18CfYGfEB+HhcqS/fQImSoQbe55rkO4WGfMYk/AFbH0j60wQNAs1r6kuwN6BccLihDGw4x1jvTHfk9wGCvFdhLcdoirUUxTyV8no1Ey5vyizk1tuy903TA2iD9fmKN1ROin/VZaNC3nKIjKtDB+izBR17+vsnzmmo+VWN37hE4zGIb7pqIXxeWnbfY6J5VBc/P2vrsYxhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:55:37 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 10:55:37 +0000
Message-ID: <559918e5-0c06-4962-a2d0-05b377aae2db@intel.com>
Date:   Thu, 23 Nov 2023 11:55:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 4/5] octeontx2-af: Add missing mcs flr handler call
Content-Language: en-US
To:     Geetha sowjanya <gakula@marvell.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
 <20231123055941.19430-5-gakula@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231123055941.19430-5-gakula@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0055.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::12) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d7d021-b979-4ca6-ce08-08dbec12b9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jijQ2mxhiNi9eb/QdqmswyTHYYPmqEMV6B4B352o6xo+qltZyhqpcoR0Bf8xzB1gR4zsvwchmTU4YaPJdY+KYaVszrPCqkwxU3mlrR8XOoSk4edyK9Ns2g0UcsRxy17HjXINzEq/tlXi/P8oKtan9zW1cRLRvrYd4LwN0ZQTNYi0fT+SwTJEno7T3F9CszTFEIHrD65Oyokl6bdBqeuSVwdF53qKOzQ+bnxjWVtv1Lbf7qVrTctMNdb1s3SHFiMkHu2JjfnpMwgrnEjVoBi+N2+F+64ZIXe7qClE3GLog3ujQT4ezbxgoYrfnIcmMAZmEGLZeXtFCUThZS5g7fOxSb6e9dJP5RdoGA4XxFJYAY8HKjmE5lPbe1w+Kjr7Ya5LFQcTRdSdZJXw3SMr32U9oWzwqHQZpfrh3sr/BjJBZRVdSHF31aXfkB89OHUqnfQK+5mJVNt+5cCkoSW8Bfvd0lspsHAFl4grrSkuOwCQs6oacPCzLu4B23eKtxVMNZzv+Zujf3EkXjmNzNV7lGHC15lDue6Lz/Ufi4cdwvUBNLGQoU3+6vdfUVybzdpFFeWGjO4XweQ6Z0e8tl+y35o/olgzpl2Kd/RCrzDAgwwls7UNhU/8L6rAct4wS0LSjfMivZdBDCXa0FLUGX8Nppp7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(53546011)(7416002)(6666004)(2906002)(6506007)(6486002)(478600001)(4326008)(8676002)(8936002)(44832011)(31696002)(66476007)(66556008)(66946007)(316002)(86362001)(41300700001)(83380400001)(26005)(82960400001)(38100700002)(36756003)(31686004)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1hIOUI4YkM0ZzVkWkh5d0tGdEZocjRDa3JSM25NSXdhS1ZVT3JLQlppdGNK?=
 =?utf-8?B?NHBNRDQ3aXJJa3ZudGVQZFpkbFJZYklBZ0tMQkZYZW1vVmQ4aVRkT3VkRmxs?=
 =?utf-8?B?MWIrZWRmK1FySGh2QzNqck5lb3BGcHFPU0tDZGJZOGtVU25KU0dFdURRVjQx?=
 =?utf-8?B?a1NJdUJXakdjU3pmMk1IVUxOMHpic2xnbFk5UzFxYkdFeEV2Sit1aGp4RGJu?=
 =?utf-8?B?RXM5dXpnZUFRSDIxM0pleTMxczNESjhtKzJKaW5jODRDMXAwN1FBYkNGRGY0?=
 =?utf-8?B?N0N3Q0h4SDFsaWM2eXhxL04vMEI3cDNPUHFibUhPdWNENFloMnUybW16SlNh?=
 =?utf-8?B?NTdqS1FnNEhnZDR5cWRldE9tQnliTDEreVJZaDdiV1dEVTV0RURFdXloVEFN?=
 =?utf-8?B?ejgxSlNtRmpUTGgrZDhXS25TdXdoMmpUWDMzRUtyOEo3VWFHekx4TTIwRWNt?=
 =?utf-8?B?cUJIQWR2blgwU3YreWpnMU5qK0dBRWl5N0tOSzF3Y3dDd2tPNkJ2TnZIMmRr?=
 =?utf-8?B?RktXdkFOZGxzOWdGYWJoNWZQL2tjQ082Mi9YWHlVQ2Fzd2tVWGpVUDNlTXYz?=
 =?utf-8?B?OUhITkJIOXZ3MVhIeVRkTHhjcGZDK3dGWTFUdEQ0blRJRWluQU9HSndJTEkx?=
 =?utf-8?B?K3RLR2F6b0dGMzB3S3phemowcVFwTlRHVnozRDZRYnNieFZwVGtSeXNuSU5J?=
 =?utf-8?B?UTNwc2oySmlScUVoSXJNU2RFL3YyTzYzMUF0OHJmTmIwc0MrUlJZTVBCSGtZ?=
 =?utf-8?B?ajVjZ01mNDdtZ0ljZ1NBNSt5M1haSXVVWmt2MlB6cmprNStpK3B5d3ptZkJ3?=
 =?utf-8?B?WjU4aEFOelhhRzNBeVJrd0FlZTQ1dG5jUGd2N2ZBeVBZYjdiSVJlV1gyYnUw?=
 =?utf-8?B?b29BQU85RzBTZXlhZmNvRVFFcE1LNzlCaDBnV3F2QTJ5bVdZU1U5Qk5MTi8y?=
 =?utf-8?B?QXJ0UW03dThVdzFWczQ4ZmRpbGZGQXZpbnk1MDV0NjYyckVjVVNGR1UzdHY2?=
 =?utf-8?B?UVFDR2NDWWJVT2JCbktqYnMxTG1LMjZkVmVDVFU2WXBKL3gyUU53djFXT2tv?=
 =?utf-8?B?aEFNV3hidnJyak8wY2VTWVZ4ckNtMlJxemhwL3JBa29PZUdwTk1hdFpxNW8y?=
 =?utf-8?B?VUJzRHJjR2NGSWV6cExxTm9KV0NsN1c1dFFxVDdvTnNnUHRYKzN3VnRxOHBi?=
 =?utf-8?B?cUdFNk8xVkZTSkxpUy9VV2xwSFpzYTkxZVJsalhQUTZkSXJETzBCRGR3YTEr?=
 =?utf-8?B?WWxjV0UwalJJZ2RGN3o1a3hWeTNoTExneVEvMGh6ODMrVzZ1R1dXWnZIOTNG?=
 =?utf-8?B?eG1TdE5CaFZBVkI3c0E2S3BGK0pESVpPWlJiNzAwUm9DcVFZY09hVDUvdzBR?=
 =?utf-8?B?K3V0TFd0aytvdTNJRENBRGhBbWxBeCt5eXlGVDM1bGRlVzU4c3I2eUdJT1hY?=
 =?utf-8?B?T1JMYzZydkMyUloyTzFjQjV6aXl2WVRqdnArd29UVHJ2VTk1bC9QSVJEZkNl?=
 =?utf-8?B?V3k1RGF3bXJGNlQrdFdmc0dFa2EwVUh1aTNUNmtncEp0Yy85M3dMRWlhSyty?=
 =?utf-8?B?bFZoaTZ1bk5SNUtmOUovR0oyVHh6cWNKMFdaVjVGMnNEVzhVY3B2VFR4RzBw?=
 =?utf-8?B?UUZPd1QvZnR3MkM5cGZFREVwNnkvczQza1dVSllDYmtCRXVadVp2RC9hVnRv?=
 =?utf-8?B?ZG05bnNoazVTWUtIK3dvQWxXblNzcm1PbTBZdXE1U1BNOGVlTnB5QWFrcVZ2?=
 =?utf-8?B?MmpSWktoMW5hNmM2S1FuUVVsRjdxemlCaTBlWTRlWGdnangxenp6dVRxLzR0?=
 =?utf-8?B?T0dMTmZwRlliSTZqRjNFR2VBTDlwQVRsNlZEcjQrTDFJS0dHdytTWjJHb0pt?=
 =?utf-8?B?VzFWdEVyOUs0YVVmOTVjYlcwaHdjVjV4VmUxaXlmeEw5Q2t0OUpGSEFFa01u?=
 =?utf-8?B?UHhDUlpSR3FoQmdLbHcvL0oyM2dtaEM2SWtad08ySlZDWDVOUjJnTE5wTHlp?=
 =?utf-8?B?Z1V4dlhzUGtsL3B3OVZHSU1SeWgxNG0zOHpDdk9qbnBwQWpTR0o2bnZtdXRY?=
 =?utf-8?B?Q1dtKzFvWU9xaUZRRm9Gem01SjVzSzVtMXZudWdXczV1VnppSUtnVXBsUFMw?=
 =?utf-8?B?UUpMZldTempMTmk1U3JiTUU2clkrZE4wdGR2aXJWRlEvemx1TzZuSm1KYUJs?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d7d021-b979-4ca6-ce08-08dbec12b9be
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:55:37.5179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3PQqNI6WoaOD14qxS+EouMz+fgsFUKN1L/SFYScoHvQp+Ti+VAAxN+aiQw8GjBFSqlYUE+F09R7QNUXLA6iZ1bOL9buZTukioT9Qvr5A5ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.11.2023 06:59, Geetha sowjanya wrote:
> If mcs resources are attached to PF/VF. These resources need
> to be freed on FLR. This patch add mssing mcs flr call on PF FLR.
> 
> Fixes: bd69476e86fc ("octeontx2-af: cn10k: mcs: Install a default TCAM for normal traffic")
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/marvell/octeontx2/af/rvu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> index 22c395c7d040..731bb82b577c 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> @@ -2631,6 +2631,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
>  	rvu_npc_free_mcam_entries(rvu, pcifunc, -1);
>  	rvu_mac_reset(rvu, pcifunc);
>  
> +	if (rvu->mcs_blk_cnt)
> +		rvu_mcs_flr_handler(rvu, pcifunc);
> +
>  	mutex_unlock(&rvu->flr_lock);
>  }
>  
