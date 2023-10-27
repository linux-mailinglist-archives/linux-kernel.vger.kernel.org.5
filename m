Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE97D9A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345967AbjJ0NhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346055AbjJ0Ng1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:36:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E2D7F;
        Fri, 27 Oct 2023 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698413784; x=1729949784;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fJjdgLzP7Msxusk0+860KU9V0ifqT3NSE464hji/wSU=;
  b=Dl522sIayEQYYlmIZmLVrKo03oaVbwKWWR0jWxhHrVCfM9/7yRqCFbD+
   Cr7Wt5pN3sOIkt1xF0SFXi6+dZq+AyzOFBUlYTLvJFVfCDDWv+kb56IcB
   yIpj+lUlvys+U7LdAKwJXqsyr5gttxfDCNFC3tiq1r+dViA1RRNGrFp8w
   fBb9ABXtkOl9e19AknY2piA/mrB7UOJh8IspXBKJuCmnAFMxApdATMHAH
   FTEKkw836LrXi9JFC5vRPeV1fnWnBWnSRof2BqiT0J/hZNgKICOMvsIId
   UnU6DBYr93Gbnqjq69Llc7qhW80zUp10OYfCC3zhgF6Bw2NNqK908l0Fp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="387589051"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="387589051"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 06:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10876"; a="850240850"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="850240850"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Oct 2023 06:36:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 06:36:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 06:36:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 06:36:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETxzDn9VX3rl33J/cWTYsL5L45XrzCuCldVezT/HUxKB4TrUbocm0IWeno3GztrRVDTURQcUBYnI2aZqBmfM4pBcDE3fPeCBA6DolpsJex3PiR98So+KYp9P7UNBZ9fua5Ols4r6kJTNzCX2rA8ox4yxHrazGBG5PirMGM7iqah21lSCsPOav6RsPsf8CWKAIlMWyVjA196nEhI5hwP6v3op5LueFEdsJC5MsEVe9ZpuFjVzybGCmfDy8Csuy01sER/6Ieb8iFwdSxXKAiw26TLziN/htYSg9UPL9+6QE5fYm80zffyHDee5ysew66BJfxt+lVuhaqPlovf1ZV2BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot4tI4aPa/HJR41t+Vbm69cRljh6qRUQC0qUVMkhbl8=;
 b=FJH3Ld8w30Lzxt1XIZTDK5Gk3pWySy/a5ffCVqaxiZpbwBHp5Sna2/ScxttjXkJyRFf9DV5shguA03Dhs0PTN1wfDmVGRt0xrgf5c54JOsYmoRhkUgQ2Nz4RgNCWvtiBzxk6m3xgJMIjsxXz6jddXCOmKk/XzaTen/nQ0IAKxe6MgfkhvRcCtgFOX8OgBw5y7eRwp73ekYN43/xupOKEZSGYzWZXF1CZ0w90SbEOW/+QhXuvdrSXtL+aHZxMCDWXc6VeTjfNm+2NMS7PzemtSXbPtZ26oZFinIylnj3YcNF/OOh52X1noa5ysctJwaEzBr50yuWct+QRbEmkt90xkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB6472.namprd11.prod.outlook.com (2603:10b6:8:c0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Fri, 27 Oct 2023 13:36:22 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 13:36:21 +0000
Message-ID: <4151ab3e-ee0d-44d0-adc6-e811b7d3c60a@intel.com>
Date:   Fri, 27 Oct 2023 15:36:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxgb4: Fix missing error code in
 cxgb4_port_mirror_alloc()
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        <rajur@chelsio.com>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20231027040057.67810-1-jiapeng.chong@linux.alibaba.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231027040057.67810-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::20) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: bd894489-453d-4fdc-ea48-08dbd6f1b4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kN76RzWWkMlg/vT6x44QwROxFxjFhTw+MXuf0iQ5rp6u4fk956uzWDvg+mXoo5XD962Phy++55Z8jSwHKdQIhB0QbNu31kCFuY9s9gQupuw25/7n6a0CCevtaXZfl/J/bfUz6HFfsvK4wwGap/j7fwWUIkm6859+toQlZONCteC4ChkXztza50SBS9pIXchAz6Pm01bGvXCTxGLHNwX03DeNG0x7oGJghCrCIKh0eSW8GgTAW+/YZXCFOPHNLpdMIHZKj8fXaps6kg6pWTOYSZ7m7qQpw3t1EiUo8u8ThMU2KvXOmp80WXnhCwRKdYdoOlLE4ckeMx2tA+cqrF1mnZWWxv7aOfPu4ivOQH4J+IH3gIDV15LnjqtNlTHkIBmtEDO5aBmsvmbUDm8PMUIU6sEyR78i+DJU0nx5eQy9ALWmtPwoQYzCn8t7cFkyLvw47Q5aMXMOTuSaYWaUnXPoqgJZAzudWU2+4qYXRnkB6j3m9pEV90QQ7ZsFjRLyfCc/sj0g59OJBSypBRGetQ3/TZIwJUnz6y+xiW0pL42MqBNQ6AtArmNwPCd0jjjeIPohRwpJ0XCl6Yro2rVEzn+o6js13ZASYuJbRHImnxyUzk0CntVdsqR36aITnfyEzNHz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(31686004)(38100700002)(2906002)(44832011)(86362001)(66946007)(4326008)(5660300002)(31696002)(36756003)(8936002)(8676002)(82960400001)(6506007)(316002)(6512007)(66476007)(2616005)(41300700001)(66556008)(83380400001)(6486002)(966005)(478600001)(53546011)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHluWWRyUVpLd2xnU3lRQ3pyZDE4T3U3WGlGSXE4WUc2YVhqbURiYi92SWhz?=
 =?utf-8?B?Qm5TMnhjVThhOWlYc1RyUHhmN0RsNFV0Y3BwSFN4ZnBLYndCcUpiVWdxYlN2?=
 =?utf-8?B?Y2ROVDBhZVNWdXJpVGZWYVRXWjlUN1I3YlZxZWJPTE01OVN5VVR3ZnE0NEts?=
 =?utf-8?B?VjJMS0tpQWYvTWNmcXQ2SUk4eXhrZG0xSlF1NFFmYS9odEVsOTEwdkN5eElu?=
 =?utf-8?B?UjFXTGdnUktJWGFwajNZYnJsMWU4eld5Z29OQ0dpZGtlQUVVbmVFUCs1S0VF?=
 =?utf-8?B?U0syVnBydXpwcGZ2ak5sYVlTanF5ZXFubHRMdFdZeGVZN09pZFBpZEZqcEQ2?=
 =?utf-8?B?VU0yS2hlRDhVM3ZuZTNMc0plNUVQNEgraTIvckpLZWNXSUJtN1VKODVZTzlP?=
 =?utf-8?B?YzNFd1hqT3pDRjExZFhRK0tnNEVyN01tVjNZNi9UcWs2aFJUUVgzV2dzWmlB?=
 =?utf-8?B?ZjR2VmdjSVMrMEdhU0t2M1E5b2tFRzZWMEFKbVJrSEc0S2NzL0JHck9qSEdG?=
 =?utf-8?B?VExEMDNnNzJLbGtOem1ONEsxV0d1cDZuODZpYzlBZ1pVVjFmY09TTXIxdllj?=
 =?utf-8?B?MzVnTDg4UkFBT0c3RDVMd2xTY1B2TEYwWkV1RjhNQzU0THp0NW13WU00K3hY?=
 =?utf-8?B?SlNpT01NOU92MEN6WjBqUXJxbG1SUkZpSWpUcHkwR0V0ZEFQVzZIZ2Uzdm9y?=
 =?utf-8?B?WnhSV2h0RHg2TExHeUQ4dUVjbmwzcDZKajNiNTQzZWR3aEhWMENpU3RJNHQz?=
 =?utf-8?B?aUdMNFZoaWFDTVQ3dDVSdklkUG5qWnFSZUZ1dWY1UGErbVBVMmFVMGw3cHhQ?=
 =?utf-8?B?QXlPZ0htUDNiY21hWW1oRHhwVkcwVHFXa2dvYm1Sd24wNUpSRDJuVEEvdGFN?=
 =?utf-8?B?YXphNWJjS3F4a1ZJdExsQ0EzMTdXUWdNTVc0c2FtSXdmQjFia3Q5YWNTQXoy?=
 =?utf-8?B?RG1XZm04N29SOWJ2RU00SlFrL3krUHFEZFFZdEg4TU9lOG5tRjRzMzFPSUdy?=
 =?utf-8?B?TEYrSVRtTXhNQm5YY2lhRjR0OTNMOHpZWWpjVHh3dzdMSjNGWmxCZXRqWEYw?=
 =?utf-8?B?cGpmTU45c252R2JReUZSNk9jSGZZZW1EdEpWd2R3bURvWDdpZCtJTk1hOUwy?=
 =?utf-8?B?bnpjTlM2Y0ovaWkvMktJRVFzbVA1UXpwd0RKeEp2dFZRQTlwd25YN21pOUxH?=
 =?utf-8?B?MUNBdytzL0hNTEl4RFNGNEpLSGgxbWtmeWlJd0JSL1V0cDJGT2hrUFhrNHdl?=
 =?utf-8?B?WmdtWDJtNDgrR0lqMkY4OS9mdm90d2pXekZGUWgvd2t4SXFnRGtxYTlpcFlm?=
 =?utf-8?B?SWoycENPQXcybEhsWWpsQlZRQkhYcXN5bm41QnpqMWorQ0s1dTF3UzMxTTFJ?=
 =?utf-8?B?L1FGdkFMYkxaVm44Nnl0akwvR2VvSnB2YkNDY0pSdXBYT0FzYmdwY2Zaczkx?=
 =?utf-8?B?WnZZWVo4eFJXWE5TZFppZW96cXRFMWdyNlJ0SlJaU2ZMeGZmcERUSzdDUng5?=
 =?utf-8?B?NzRsOFEweCsvaWYveDFKMEFDQUVSSkl3eGpuekFKSTBPV2EybldaV0c1OG9r?=
 =?utf-8?B?RFVWcUMrSWUwL2pOOUVOYjhEYkRqcnlia01WTkthVmxQYUM4Y0VIL2c1MXVu?=
 =?utf-8?B?UnMzTElGb3kvbmNzWGlqUHJvSWpFUDJ3Tmt4c2dJNk9iRmNVaFNMU2NEYXNr?=
 =?utf-8?B?YVNoYTcvVU1adVlzQ1VtVG80eVlxditqSUNtQTV6QkZJVnFmb1hJVWhlNXBq?=
 =?utf-8?B?VElHbzNlNjBVTkx2Z0o4ZnZrVFBiK0Q2OC9WaDVCeVI0Uit0R3VCNm0weFZK?=
 =?utf-8?B?UTNXT3lKQjc2QXczWDVRS3NnaWJOUCtEWmVaNkhXNGhOWEw4QlIrRHpjR00v?=
 =?utf-8?B?MVcxT2Q0TmF0UWRTYnpaTEdoQ0xqL2QvSEt3dFhYWU5RUndxZ1JMMzhhMmFU?=
 =?utf-8?B?eGt3WDFvY0dvd3U4KzVMM0lFbXJRMFBjZUdUSTNnaW9nWUd5V0ZacEx3bExG?=
 =?utf-8?B?cm5zTzM5dDRVblQ4bjRrV1Z5OFc5Rm5lbThTcjFJK0JaYStlSWQ0alpmNmRp?=
 =?utf-8?B?QWFaYlBIb1liTXlYaUNJUWJpSHJLazg2K09rZjFER3ozQVFRSmhVbDRBcVB5?=
 =?utf-8?B?blByWnhaaWpNVjR3WDZPa3hWc0I3K2UyNW16aHZHVnA3V1JnMXVCc0IvRHZz?=
 =?utf-8?B?MGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd894489-453d-4fdc-ea48-08dbd6f1b4d0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 13:36:21.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y1Nw+PhbB+Em6mvu3NMXdBaGsC7I6jxFFx18cLJ27rgWGAGhJPAMKKgtNtY50/OiFKgMasUfvYqXid+NScwFCQl0VLbR+oNrwxjLKrM+Gmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6472
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27.10.2023 06:00, Jiapeng Chong wrote:
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:1525 cxgb4_port_mirror_alloc() warn: missing error code 'ret'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7063
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 2eb33a727bba..e59e199184f4 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -1522,6 +1522,7 @@ int cxgb4_port_mirror_alloc(struct net_device *dev)
>  	mutex_lock(&pi->vi_mirror_mutex);
>  	if (pi->viid_mirror) {
>  		pi->vi_mirror_count++;
> +		ret = -EINVAL;

I'm not sure we should return error here. This looks like we're adding a new subscriber to
the mirror action so the function should return 0 (ret is initialized to 0). viid_mirror exists,
we're just incrementing the count of its users.

>  		goto out_unlock;
>  	}
>  
