Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B49807C08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379619AbjLFXED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379625AbjLFXD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:03:59 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804E10CA;
        Wed,  6 Dec 2023 15:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701903842; x=1733439842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ixDlk72ZPsUuPB+X8lQPtiMyu5tNog+Ln1Dz5a/8l70=;
  b=FWQnQU8VBCknfy9UG3qbqNSPKlowFq8IsS8PGuWU4aaVbykqxBlAE7JV
   IgIbGfpl8PcGmhMYG+FiiePAmZXmWhj8xIIButqvfUBeFcjLZBRBH3irj
   lpwMk7/d9rKgnu5OVSejeuW31+9FHDWEQKUS5523guJdKT4/Od8cMvSHL
   2Curvf9jZokz2HsWbVMio8i0MRtKNftEoJX3fSDWwlDJFNTaQakaNeghN
   kANf8fcFwqT2oIz/tR3ol+u4O5VZ4ExQid9g6KWrUhmuX3OTMdnzUxHtK
   q2GLxhGXv6ql4WVgc1sDuDkwEbWXeUkcOi9gJoCIYDL7XQgkQmPrN8rHz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1012236"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1012236"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 15:04:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018729396"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1018729396"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 15:04:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 15:04:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 15:03:59 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 15:03:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 15:03:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPOBrPD4rw81Sd1lGK1EOf1nx+BinObMz6eWBgvtFL3zkqOkYw9m0Sl41HlRFRCw5W/ENtWzUjb7jWTtgzGiyaO3jO9SgOyGW0Ehqt545sIA+WjpzghGNRSJ7vsVWk4v7Ow9tWJw9iUruI7riVDna8ME/ySC0LGic+BVI7lTO+vV6/8p/QUogtb8qE+5zp7FzpYkuDKY3u4sETSLTMxFhDQ0uTu6hTfYNiP4sa5L451uXYDaxLDQR9j9hnB+/ZOMc1E3SyARjvgxgaj+3CT/xXvHn/U9X3N6N8mpAnj2bOsN1syzhPOvFMQbVprYJpPKKuI1gnMuAp8A7o0G8TV/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=600GwPpll8gJQlLZegCPYw954A9maWzRfL8H8DZJ/GA=;
 b=buGDB4qpYss+e4ACoz5P3XQNsuMW92JVaZ0G/i2lcnVjP7Jwn0oFpYLbJpfZ1AfdO+tLJe3YywgqMgDTj+QCJvlv61daOwOcjpd41WMAXJru5PCHD9o4fzeAeuHNfZrNmzPrrFwrZPwkX5vO18c7CDIZwXjeydw5IHVyl9BppLHq2eX505f0ehBjr4MQBW0hbJzXHD7VpCU7FNY+WNIWHLj9QWNIgGOCF1rfCYkI5C9aSqoVYMVKCsQ0PaJsSg59Xao5rZjbh9nA1pXYm69uzwlVi5neXgIf3o08aU4l6cj15xufBNxAmAKG3+LvxINomZMfIGyPHtSVR7qleQcNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DS0PR11MB7681.namprd11.prod.outlook.com (2603:10b6:8:f0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 23:03:57 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::6609:2787:32d7:8d07%6]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 23:03:57 +0000
Message-ID: <52aa01f5-5384-4e8e-9946-af6934280b7e@intel.com>
Date:   Wed, 6 Dec 2023 15:03:48 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce: Update references to the Intel SDM
To:     Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
References: <20231206013846.1859347-1-sohil.mehta@intel.com>
 <20231206101342.GAZXBJVh+3tZuBAyX+@fat_crate.local>
Content-Language: en-US
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20231206101342.GAZXBJVh+3tZuBAyX+@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DS0PR11MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: 05a2067c-2b58-4284-f721-08dbf6afa03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TC4yXg8wUcR9vLlIb+lEDfOXQWYBIxWzSJzV7Nl9kQie4ospnpztngmS9pkxHZuhWvWmN5hH7Q/LtNlUPGQdzUsN4iHRQRC5EPseADFiEJAE3eH9SwVtlO3UPgzzDq1dwxWGhZWmSmDyzTSmXD+BKnFYTL9zvIOTLi2Uy86dD2CxQx7PX2MaCwH/Cn+Vk2KDFqozuH9ufNKy0BouShnmM4A3KN1FsglWrcpVRsdsZenyUWzjWbX621LaAr7SaLyqAozHV2QISpBvjILCztLd508GeYUs4R7lA7httsuvbhsGrBo203GL3zjGEzfDVSDwHQIVi6KbNypd5nuSvcNHl2HySbimk5mEcyfjIUI2VE5cEJ/LVOfKHr5sXd5wd4/p+8ESkVaBz3zO+k3cAGAV1k1Bgz26nN33VoKkM82Rp/vCslYH0Cjsah9a34Wn/Fees8zoJnw7cDDclHw4LuLEXdiwO5uJ57gDWXXVWSQj5z3+A/+oJSkyOV3wS4+6v0UxGqTKmJXvFSG2K//Hqmrzoyxv/gShCysJrFri9Jh743x3PsJ0tRCt/qYH4+baYkBb+eg7Bzk3XfcV7nLsXkghgNwOfKNpTroWtcSj56wrNBwZqrKX6ipXFCDBwMrVTxSeHDODQ5tHsFT0NsEWbR/MWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(31686004)(82960400001)(31696002)(8936002)(4326008)(8676002)(316002)(6666004)(6486002)(6916009)(54906003)(66476007)(66556008)(66946007)(86362001)(7416002)(5660300002)(4744005)(6506007)(53546011)(44832011)(2616005)(6512007)(478600001)(2906002)(26005)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nld0amZFTllxbk5iNGtDR3B3SjhyclhBdElzMllMSVdKTVRybUlOYzljM1Rv?=
 =?utf-8?B?eXU2ZnJmWE44ZDN3SnI3QU1Ra0w4ZldheHJCUEp1bFRZbFp6bkFsN0tueCtO?=
 =?utf-8?B?eGVYMklZU0gxUSsrY09Ba2hyQnFwLzU3TGhSU05BWlgzbTUvdEFsbmRtM0Rr?=
 =?utf-8?B?UDlMUFphT2Z3RHNxN0dKVW15cTBLME5weE5YQXUwdXZpRWxKN0VyZXNkb2JB?=
 =?utf-8?B?bWNKeDlHZi92U1kyaFJBWXR5VTF4c3lDRThFK0tBdVRwVXphV3ZiYjB3WElq?=
 =?utf-8?B?V3I0K1ZZODZUUkdTRXd6RnBhOCtrTWNWcCsyRjNtNU1nZzk1WWtRNzZlb2ZF?=
 =?utf-8?B?b2VtbUJoTjlHa1p3T3FCSjBObU4vZTFtYWVQeWZKTlpRZzlTTHN5Y093UkdX?=
 =?utf-8?B?NzAxOSs1TU9lREYxOFpqcjBkVHB0NTlraHdyRzVxTi9aRUQyVmtDQis5WWUv?=
 =?utf-8?B?a1NiUy93Yzh6S3JBUmpmcWtPVGt5YmNoV1BaZzVJTjdpc3ZqeVNKcHh4dEs0?=
 =?utf-8?B?RzRSamo4MUdaUUw1bXB5RFN0SUFhZitzbXlPU09laGlPVE1TYkE0QnlNLytk?=
 =?utf-8?B?L05jQk9TalA0djVUcUd1VzNlUVFEaDhPczdFODdxODJDeVBWOHJvMytmc3d3?=
 =?utf-8?B?T3Q5SUNGSU1jRUY4bDBnb1h3TWRBNWhtcjhHUEVZeFgyUE1Zc3RzTGNnaExW?=
 =?utf-8?B?UklGVElDUUZhRThBTUllOTVBU2UwamdhZmFoazBVRUFhbW5CQjVMcWFYZlY1?=
 =?utf-8?B?ZnUzSHNKVTN6eGZUdTNlM3RyaWo1VkFtaTZHaU51WE41UE5zaWdXK09KSysz?=
 =?utf-8?B?aE5aRlJWeGFHdUpOT2xtKzhEdzFyYUtsZmJaOHc1VjhtNUVvRjlWYzFXZTQx?=
 =?utf-8?B?Nno2d090Rm40a1d4eDZqaElHUmFDYVFaMnA0L2lIeklSSmZtd2J1d1JJYitQ?=
 =?utf-8?B?bmM3WUs2SU9ibUNaVTNWdjhlbHh1UU10MUM3d1ZKZWxvVWo2NUpxTytxVDQ1?=
 =?utf-8?B?OGhJbnZOdENNYy9mZ0J2dUJkRXE0ZUhDLzVoM1hnQUtMUTRoTFpGVFdzMkJP?=
 =?utf-8?B?R2gxb2ZSUjYvQmFtU3JsbjBiWGlGTzJnbm9xand4M1A0K1EzQ0w4ZFNXTC90?=
 =?utf-8?B?anNCN2FSS3JvZExnMFdoMHpSbDFMREZySjFZNVZNTzRMT1IwYlgwTGRTWDVk?=
 =?utf-8?B?UE1pNExNMWJKYmJ3NzBvOUhsbHJFall4djFqbGkyN3dYMmdZK2trcUVDMnVW?=
 =?utf-8?B?Q2NPN1hOcUFJMnRBalNzVitVN3I1cFhvWTl4TkxHT0l5V2FTWStveHVETGRW?=
 =?utf-8?B?M3JRVU1xNWhRYndsOHJvNENvMFBpNktzNElXK2FhaW9CQUVBb3Jwb2FOYXZH?=
 =?utf-8?B?Mk9rVWkxa29FY01JMXBMUWpvMVMzQ3hialFFU2taQm4xZkJvckpucVF3YUJN?=
 =?utf-8?B?dy9lMHNCZ2hyVFYwd3RRRlhKNjVEVmphVVlOS3VIVTdsbFR2d01WVXpCbEh5?=
 =?utf-8?B?VGVFM3l1dUxvVEYrSjU0WjNQQUpwa1RKT1NBWG1VeVNNaTk4V0VmNjEvWW5O?=
 =?utf-8?B?eUVKVTNtV3JNa2I4Lys5VllkQ2hxWWRXUVBvRlEwdVNjeDdQYlBvWG5xelA2?=
 =?utf-8?B?SjNSQ2x5MlBKQWlqMjZIUlFWd2hSK0pLaWF4NUZKVGJ2OGR5c2FNU0lFZVVa?=
 =?utf-8?B?VmErMUs5QjRoOWZ4VVNwSkNJK1AyQ3BDNG9xQ282ekdjREdvcS9RaXVzRUFS?=
 =?utf-8?B?M2pwS3dFK0VaTFRRNmZ6QzVnNzlxVE9sVitIVTdPUWl2K0FLQVdKZ2czZVoz?=
 =?utf-8?B?TUVoMDB3N3NXTjh4eTBUMUNpdlRNcGlZeUVZbGs1eDk3QXExTktiaWtpK1cx?=
 =?utf-8?B?SnJmV09NQk0yNldta2pVK0FBbytycDdHZ0JNbW5SeG1xY0dnRkhrTkR3aGt2?=
 =?utf-8?B?SjR3UElrQUhBMDBLcUdqVnZYY0t3amRlUWxMMDlMM2w0USsyZ093aEtNcHZQ?=
 =?utf-8?B?MS9JSGh1SmlPd2Yvbmx5OGJwTHRTM0N0K1NrOUlhckVmRWY0NTlOcWE0N1dW?=
 =?utf-8?B?SGNKL2hzOVdOWUxxNldEek1yRmlJeHA4endEeTlBOVNaQkIvZVBHaWR0Y3BT?=
 =?utf-8?Q?OdhFHpH32g4SgltkYaNeMYmAR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a2067c-2b58-4284-f721-08dbf6afa03c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 23:03:57.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZelBBGJRC/J2VQQlUgStle0HaVbna6gm5Teg+bbRppzA+kipxmYylegT0r/E8nZrlNfzcixJ0e7Euq5H2DbiLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2023 2:13 AM, Borislav Petkov wrote:
> On Wed, Dec 06, 2023 at 01:38:46AM +0000, Sohil Mehta wrote:
>> I am open to suggestions, is there a better way to do this?
> 
> Yes, drop the references and make the comments self-contained. 

Sure, I can take a shot at that.

> 
> If the comment is outdated, drop it and also explain why you're dropping
> it.
> 

Sounds good.

Sohil
