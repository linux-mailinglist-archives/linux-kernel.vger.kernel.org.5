Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BD276A263
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjGaVEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaVD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:03:58 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE69A12B;
        Mon, 31 Jul 2023 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690837437; x=1722373437;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=6sPSIgMTRq01BHEjeNcFBKmU9KLbRjobBhF4BqeVHJQ=;
  b=EeSgFqWoT7bmDpO8BTMy26SxNwiPU9OgSJluBTzHxispQMEl0EGL0wxR
   THJ9YNbOz29dF/pv8X31cHN2zbuBz2RLZHk1AGUgd4Bk2nmJ+YOWgr0w0
   T+qCjofsDqD0jJrTk1miywGciSZX9QLWiIGiPW1fCYC//Gr5APqtK4Fuj
   C0IKVuHBqMAoJbY+e1quRMlN2mTTFHIfp+1Lojz+rtc0o6kKvfWGyFv/G
   Z0tg4UllRfEZFa2S3siBVaS89I+G9uOnWToYm2xs18vOjtOq9Gv/HNkuj
   LOZJrTMsoLIoYjAkV0A8dVblX9W5T71GoJoXgfVdm4GpU8uaGBZXouBb/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="432953780"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="432953780"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:03:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678456556"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="678456556"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 14:03:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 14:03:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 14:03:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 14:03:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUBeAgEZXjOZOQ3s95GCk7p6ktoWU/Yf4Z9YHWZVMJXDjbIZJ2r5nMHReoSPhX13QpDXgIuqs7t0tzkG7z4l9ggiRb+kS0Q8AIZ6Sb+dNJ46ySsaMFfeJ1sO0/ngZWCb9MJO8Lxy5KkNmBBQYdrV3C/j/jw6SlOwkvlg6G56N9YHk3rHeeP1nT+3JL5w3EwFdmzoVOwi79VKmJoszEToGZp3+nHYWaywearjdkxH3PWE1qpezhbbXXlY8xaCXDn7DTwka+Xb6QZ2PK155uPPWNXDtWCYiFT0K053WZCsAww44Gl2wNMTzrKeYtw/ey61V5pF+2uUEvjH7X5tEXMeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXFoHUF93rRYCOFffqoMIgPkHehHpgW+K0NPW/QE/rg=;
 b=nLeuOM8ug69gh9oJM9hDJ9qcajib/jR6JjJHlfFm29gfjSbO5BwaH1cHXk7cmmk3DPJl/fqruxbo1675eGFQno79bzBFVv4UJ5C2qs9xfhsKrdUiYrBts66/JQOvi+pRHBBmEqne1baSyHl39laOpZ/7/JVuAi7aUioHqsQ2YOyDPKSEuLVxxiQvDdpPSV/XSqIoIMTx6juZBVI/8UFLOwD9OUbPManzFfn1Aq5PXiz+E85ZJLATJYWAhVLcAy/5e+PlrA0NrbU3tSFudpNo/L6GQEEBGOgfXyHxvpeQqfWuogRhtZZbd75m9XKKePrLva17O5mOFkt9uWNsFOwXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SJ0PR11MB6694.namprd11.prod.outlook.com (2603:10b6:a03:44d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34; Mon, 31 Jul
 2023 21:03:54 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 21:03:54 +0000
Message-ID: <488c45ad-cab4-db19-4c0c-efaaaa3cfdca@intel.com>
Date:   Mon, 31 Jul 2023 13:01:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH -next] net: hisilicon: fix the return value handle and
 remove redundant netdev_err() for platform_get_irq()
Content-Language: en-US
To:     Ruan Jinjie <ruanjinjie@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731073858.3633193-1-ruanjinjie@huawei.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230731073858.3633193-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0191.namprd04.prod.outlook.com
 (2603:10b6:303:86::16) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SJ0PR11MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 49e78154-1c59-4dae-cfa9-08db9209a608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQtI/O2CCwt8hLMk2GsrRwlGjdEoDCa4vhUi1SnRWZc6LL6yrMRLLbowhAzxxFsbz0skQyOiWMrSXDU7wYdDWbexXDRrON/4Cw2eIPBC7udpB54ce6rqFxCXsH/3GS2v7jxxIu5yGFw83Xxx5265cW/0S6KQrojy8OMpa3Wqzx+6IF/2d8BoXDeC7uJRO8JFQP6EItpYTar0WUpDx8IDJV7BgP2ogm+Io6jA+kbRA4tofTPSqMs7zc0/A+8l+cJuxb5lAg3ApJ4iUd/KXcEY+gdq3gEi6msBdiWYbxF6/Hr/t13q1wHt973i0p0vsq5HuFOzxKXW+p6XdkL7v+bjuk+JMAgD/vW64c3MulVDP/Ncm3n0HT2ucmhq584lrrsnqRnQXlXARVAD7G+fjYnJmRO7nymZa0AYwFakHSRdcuAQgY8sUspTes25pfDfPBr3gmH8RRhLvz3WI6UGkJ4gHtbRNNVaazuPqlNQWKA8E+mnU3kEjUPEnVzoZp+wesrlVOtI4AD/d75XS1QT20QSfi0OZQ9s695LI/X12afjjdp7/Nso4mDm5vitilgK57bhrAkhFAkRZxVYSrQhO/L2gP4eTS53W0VLPRIo2DCEoEKSERpRGaYnfRvupS72z6rtgKA/u1cYf0FqFJ+P3kjBRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(8676002)(8936002)(26005)(31686004)(41300700001)(82960400001)(316002)(6512007)(5660300002)(186003)(44832011)(6506007)(66476007)(6666004)(66946007)(66556008)(6486002)(478600001)(53546011)(31696002)(86362001)(2616005)(4744005)(36756003)(83380400001)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVlSUHlSNTVqbVEvSytrYjFVbDAzUVlwUXVsTW9VbExTdWxQd2JTMEhsdEU1?=
 =?utf-8?B?TEVVNktGVEZlZDAzU01QdHVGNXlaRExJaU4zNFhsNTRhQ2JkK281SXJZckRK?=
 =?utf-8?B?d1hTZW9Ed1l4VXlxVDJHVWMvWERLYVR6UXViUW9oTnpwV3YrTjVscHZqcUdQ?=
 =?utf-8?B?UFpvUzVHeDlVNk1Cb08vYndtNnFTWU41M2phRTFZdWJXYjREREp2UGNZeXdG?=
 =?utf-8?B?NXhRUFU3N1BxeVRhNkJkSy9OVU1Ock15N09EZmJ4aG0xK2hTRUwvMGpucThQ?=
 =?utf-8?B?ZlFiT3dTblJvNExJOVRueE04T3FDbTBoZ3ZOR3FaMXZ3QzU2TTN2azRONGR4?=
 =?utf-8?B?K1Y0NytocWQ4bEhHaVJFRTNmeXhzejVDcVFreWUreEZNQnNyY09SV0dmQVpJ?=
 =?utf-8?B?czB3N01xRXg2dEZJU0pCZmFZSVMyZzVNQ1MyQWJYdnNldDk0ZXlmY3FNTjNY?=
 =?utf-8?B?dzBVbGdyUzhvdWtESy9jVTRXb2NyNlNQeE9iOGZ2ZEFMc1lTak12MGdpd0po?=
 =?utf-8?B?YStZR2sxaGxPbS9tQlBVd0dxWTB2SzFIdTQzVm1VT3Y0a0dST2ZESkxyUUw4?=
 =?utf-8?B?S2N1TVh0Z0dBNDFIMmpwam9kblhuRU15eTJON1hSckEvQUxPUWpJeFRXYnAz?=
 =?utf-8?B?WVNQcGZ6akRIM0pscHJJYVdtVmxPMytCM0x6cVRITkxzdmNwczBSdmlhd3NU?=
 =?utf-8?B?bHViUHZ0bmo2Y1RpcEZRdmp1WGpLajNaeVB3b2cvTjduZXB5WU5Oc3J3QnJv?=
 =?utf-8?B?N0V3SFc2SkZhSkpkYm5razlMQmJ6eVl6eVN5b3J2eUJTWGtITjU0N08vejBw?=
 =?utf-8?B?NXF6YTlEL0xEb3V5V0lCcU9GT2dIYUdzVWVMZVp5RVZpRWtwVWVOTWFEUmoy?=
 =?utf-8?B?V3Fyc2kzaHRaeFh4YTJKdFZrWXo2a21mTlllaWF5RkZhbHZndzRNMzdocEJz?=
 =?utf-8?B?UjhzQURJMldjZlIwaStUSkdEWm0wS1ZWdEp6QlhHWkVpZ2Q4U3V0c0FBM1ZY?=
 =?utf-8?B?c3dtZS84R3VnblBqSjM0VHNPejJlN3RBRGFOT252WnZiQzlRMU53ZGRnV0hD?=
 =?utf-8?B?NE1VRUR4dHBPWTZ3NzErZ0p4alZCSE5ZbkQrZFE2eEVnZ1I1dkhVSUZ4UnNn?=
 =?utf-8?B?VlQ4cVIycGMwTlpDUTlFNnNabjNuQ2VtYW16bVV1RkdRWFowK0hYcmVMMm9D?=
 =?utf-8?B?WDZmQXhoZXJLdjlkZmVtaGw2Wmx3STZ1OHI2SERqZjVZM3F2VnlBbTdMYmdC?=
 =?utf-8?B?UVdVdGN0eUpRUE9oZGk0K0t4YmFDU3hlaEVsdlpWcjU5MnR1anBZVitYemFO?=
 =?utf-8?B?WnFEVXkwYWhnRTFUZlU1WTRkWElzRTMvb0FxQ2pMOXVWMDMzWWtEa2hYQzBa?=
 =?utf-8?B?RnB0Vnl2b093eTA3dzZjNFpDdmNlQmVaNVM1MGtLTy8wQlc0Zjl5SnpFRkZW?=
 =?utf-8?B?MzFvRS80VHJSbEs4Tzl2Y0NEMzBDSzdxNnRKK09qaHFrUUd5LzR0RjIrQ3BS?=
 =?utf-8?B?M0hIN1lVNGZyeEhQZGRBb2FEcFBhWjdzQTdiN2FCZ0liZjBFcHlCZUttRGFR?=
 =?utf-8?B?U0NHZFFONXMyNDlacDJ5NDM0cHY5NEY1RGhmb1hMcmIxWU9pS2V0dzdKV1hk?=
 =?utf-8?B?bDFkYjVkaG5uczhzdjBqb0h3Z3hhZWtEWUdRU05YN3JPakxLY2t0MFdBemZE?=
 =?utf-8?B?b0JXNWZrREEydlJ1Ly8zUjZ1RnRMNFFLdUtBM2psWkJXUDZOREZ1dDVTOWtC?=
 =?utf-8?B?UmFzVStQZVEzNDlqc3hJdXRId1B2OSthSkRScDVTMElTdERSMHorNW8zaWZR?=
 =?utf-8?B?dkp3YnZJQzBEckhLRHJYQ244aGxtUWF3MXYyN0ZzclBpOTFNVFRqOCttWEY3?=
 =?utf-8?B?ZFpzUml2emUySTJPRlRNUTQ5WUxmRWFWYjhIeDY1c2orY25sNUlJWmx6ZWxN?=
 =?utf-8?B?UFdRcy9nM1U5MnQ2L2lOVXR3TmpLVkM2WGJ0djA5SHFkdDRMUnZ1Nit3elJ1?=
 =?utf-8?B?OEhMcm5QbU95SVBFSU9ncjU1SEZ0NDJZaENnTTRxVVhCM0d3eXlNWEMzcWhy?=
 =?utf-8?B?VHNJVU1PODRod3dVTE1BRlozQnR1M2h2SGhnNEkwc0RWbWRnVUhiYXZRZita?=
 =?utf-8?B?WWU3VDU4YmhaZTVSZlhMdGgwVWw3dWZrS2htMjFiTjJISCtERVZJd1M2V25h?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49e78154-1c59-4dae-cfa9-08db9209a608
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 21:03:54.2902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNK35GPzuSSIwIJcu+XpBZDmBZvglHDcJZViAIYFIqe76/sbOjiZZKFDO8bYV7sOkXiIy0TK7NKhIK950asYoS9jtsfLrPSXh6KDqh94ark=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6694
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/2023 12:38 AM, Ruan Jinjie wrote:
> There is no possible for platform_get_irq() to return 0
> and the return value of platform_get_irq() is more sensible
> to show the error reason.
> 
> And there is no need to call the netdev_err() function directly to print
> a custom message when handling an error from platform_get_irq() function as
> it is going to display an appropriate error message in case of a failure.
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Makes sense

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


