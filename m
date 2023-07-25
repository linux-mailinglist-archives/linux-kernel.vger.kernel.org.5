Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841E176042C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 02:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjGYAlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 20:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjGYAlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 20:41:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293D1FD7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 17:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690245662; x=1721781662;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+hYiGNTlWIkPZzPPWzzyhGPakaMhvEX9tTgfEvY+Rcw=;
  b=fE6nqpL82PaeLpkgC4u0XOwF+rq5VXIaAM3kxK7NistoswI86NrQBd52
   uzrInSCEkYMwY/RlOZLY6DWANa6tP219l9c16KfCrHt2KS90pJ/kv4Njg
   isNdpR49WxcwX5nAJieID1WnRppDOkx0c4iS/1CIlX4MlF9IkRnco9iGa
   9V6ZJS8DcdyQmVg2Uc9/SRi+SwvUQyNLvgp0ANLjEiis1utb/o+srzBry
   Kv+hCEt7CWSajKuOy3LTEPLHprZ7Hjkoxmjyc5gBWSE7vBOMObT8sF1PQ
   3tk/nzPJqwuOWAZL+joJ1avwZZ6gmZ5B6mGdkr0cKpuUMIQQyZNEMrEwt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="370255896"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="370255896"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 17:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="839653151"
X-IronPort-AV: E=Sophos;i="6.01,229,1684825200"; 
   d="scan'208";a="839653151"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 24 Jul 2023 17:41:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 17:41:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 17:41:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 17:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6/XsjAhIGBHpIbLpxzrj90MtPPpWQEDIx4TpZbZxjjUYd+HcWvolIocBXFX/FL8z5RIPiOGBj3T7eH1ra5ozwVUNgwhLRlIv6fBxseR06BWchVS7bDZphiqdQap/1HKn+RZ//SrU6/PAt2hQBxYe9OyImh7XCt9smVCzv78Wv5w+E6SXn7Gv1u13B7t6eZu+WCZcu6tVPfc8JjtbamyimtsOaU/6+/le9vJbUkVzicPKsd7PBiMLmAEAmIfLvI+eqM9tvR3yMx+FsKUAXuvScG9TIvvd5wX9VMzlEvAbcxtqU2Y5ciAwqLWJ5m+rEvC64FpKsgcSsCoqUwKT5VPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDf+ELaNhq3FeF8dDoAJO/WXdcJJQZrm62gJq4QomP8=;
 b=bPO5zoYG7Drz5JZ8BEFgwym8FjzA9nHUIUtHaaYxoSNzvkRimZrHBuRNK4rYVhFytaKEa6Pj8xSiz9Vei9sNUd74XYM0BSGkmCgzyJnHx7y7/6Xmdyg7FbBnXaACD8w0Q4ql4NuU8lMvnmNzf68tOk4B2j2QoxhiJ3zk3ZoSUaPWD/mMt60WKS2y5rIrzniIeU/GvfWOTUhcMcC+b1mf3ERTnI2OMvrUx26WpJiA1w0NhDt197Vtx4PmRNehriTDz5E+rV4Brmn5dnbnSJgax+a3aGEkuEAO5wvRVK+rBts8iJGzzPToNoDV0YUJqvL0jcqQlrNARu7zMD+wuj3iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 00:40:58 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::1245:3110:f511:6f00]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::1245:3110:f511:6f00%6]) with mapi id 15.20.6609.031; Tue, 25 Jul 2023
 00:40:58 +0000
Message-ID: <2e187cf9-9700-9f77-abd8-679b8047611b@intel.com>
Date:   Mon, 24 Jul 2023 17:40:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch V2 00/58] x86/apic: Decrapification and static calls
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     <x86@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Keresztes Schmidt" <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20230724131206.500814398@linutronix.de>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20230724131206.500814398@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|SJ0PR11MB4944:EE_
X-MS-Office365-Filtering-Correlation-Id: e47c7aa8-0aee-4ebe-0e43-08db8ca7cfdf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlAWYxEpCRgFbu+7eBWafWOEVks/lNuFOTvHn/lbpAQx38PA9h+6l/+j4t5ZsiKLwuqVW1a2EDVMhwHwin9TK9Ev7qloiHB9nS5IdrxJZhzEIm0QfmaTncrXhoueA1JTdJymQxFAbtQrKoFg3B+B/TF5Kb9xQWiXXhvvrwZTwJGyERSJjC2YxnR674IYjhqc/81XRJ0dEnxxfi1FH8hBU4LxMb5yK+Sw3G4ZMaSNf4zappNChK3sHstj7Lsn8Eqwoa8tyQOibr9YH9Ci9voz+9RSGi1XWrCARg0K1OiVOimOare2XId2AgG4GNSIsSF4UwaFe1UxOxaAXyNzarTIPqsdWced6whxoxpH3ljX7PIFaXq1CDiieeI0aIlIbX5VgRona6By7ycNeq2ZhH9P6nrXUzsoC3XuCRM5Q835fSsm6rVwPmYkzTO6x9STTspKEbuarKRTkFhbw9LJkshb/kCDF2m31MIXWGoKYjqYEB443QtJ2YsrA+7kx4PCUfCLzPwI48j4zRvdIcNBXYCEaHLfXASWk7UFyA9jyalNSX98+ycpL2V01MDVrV0m0X9W51xybB/PX29WRsKugkmiKSG6x/V6q+9iOFMDrVdo+GLufOV+zTfMKNjzJA3hC0Vu+RljqQfaxY+CX+ZOj+dwnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(38100700002)(36756003)(31696002)(82960400001)(86362001)(54906003)(110136005)(4744005)(478600001)(2906002)(186003)(6506007)(26005)(6512007)(6486002)(31686004)(8936002)(5660300002)(8676002)(44832011)(7416002)(316002)(41300700001)(66556008)(4326008)(66946007)(66476007)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJvNTR3aXFPMGJJVnVNbnJRR1ljQU00ZERKK0Z2bFJYZ09SOTRZaUhEd2xs?=
 =?utf-8?B?VkFkc1g4VXh1UTJxVitlb2V5OWlCVjB2d0Q1ZlZveFRtRkNYeEw0Q1dhcncz?=
 =?utf-8?B?VHBmQjNtYzNDdklrdENOOWgzY3Racmw5Y1F0REVSSG5tbzl1enZOK2tmaVZI?=
 =?utf-8?B?M1g3Y0hybWRUNmZ2OVd3em9naUJQclJsUkVNYUdMOTNSVEcvS0NBbUI5dDZ0?=
 =?utf-8?B?NnRUMDNubVpQMk1KQ2tXSExrUXJSbVdaQVUwV3BSck0ycW5NM3B3cGo0L0hV?=
 =?utf-8?B?ODQ2L0dLVXR0YjVUSlZianhlZUpKWDArREZqSHR5eHZraTBwdHc4TzVxUGox?=
 =?utf-8?B?OUdDWEFBdXduSjlIMVl3VG4xMzBjL2FJeDBzc0w0TS9BeEtSaHlKV1RKK21y?=
 =?utf-8?B?WXdHdlVzS0YrbWZ4SCtIdExMOVpmbnhaWlhWOGJObGdzaktnVHdnbWdaRVMw?=
 =?utf-8?B?Zi9uYzc0N3pIZ05DUkxaa2MxY3Vybmlqa2MzYnpobVBFTTZvS1g3T3pKSDFT?=
 =?utf-8?B?enBrdG4yc0pDUEFtYUpzeFcxck55S09ZdnJlaDdpY2Q1eWg3SEJsN0t3NFM3?=
 =?utf-8?B?TGxxLzFURElPK25sTDlPcGxEdWZ4dll6bWx1MFA5MXRISFQ3Y1hLZHVrM2hi?=
 =?utf-8?B?Qm1OSXRSK1dwUTREVEJEcS9UR252cG5lU3plb1k0OVVjRjVLakJoQm9LOFlW?=
 =?utf-8?B?bW9jOURBSHVscUJTeXV0NEdiQmljSWJwSExXTHZUNEdhSXVFYmJLZFB3Z3py?=
 =?utf-8?B?Y1BMSHgzRlBwOFJxeWk3NjYyaldDYTNWakNWSm80czEyNVlPTDJrRnNsWmh4?=
 =?utf-8?B?amdPM3pWZjZCRGVQKzRqOXdsRkZQM29XSjhLVkQwNEYraHZzL0I2RktKc1Mr?=
 =?utf-8?B?ODlqRkRTeE9NR2RnUXJkRmJGMitzYWVJVUJsdE1Ca3pKdEdhcFgyYmQ2MGpU?=
 =?utf-8?B?aDI3UFRkTEtUZnNsOHcyNmJUTk9xUFJEUnpia2VZM1c1RW02MGM3WmUrTy94?=
 =?utf-8?B?OVFwc0NsdlEzKzZTcmFPZ3VTcEw2WE1hR0lpQngwdlJJNHhkSnBsNHMrMUVG?=
 =?utf-8?B?aFk4S3dHcWpEQkdCTnVUTmpwM2dKVVRsMTdvcjllNi9rYUR3RCsvUzFnbStr?=
 =?utf-8?B?RVhINzVMV2oybFVmSHVhL1VXcWhqQUVyUC9WWFNOdEdxSkoyV3JKRTQ2Uitx?=
 =?utf-8?B?RjlHMXBLanJ0SUxrMUY5NkVCOFoyV1JtY0Jzd2VyUWdBMFgrdGQ0RUNXKzdz?=
 =?utf-8?B?aFE3d25nN1VEaG54SVdZa0lpSjM2U2htNzhGOUt6UnFaOWFkVTdybkcvTlZM?=
 =?utf-8?B?ejZnemN4SWFMUFJsK1U3QkNiK215dGJYemxIOTk4MFlQZ2dpc3VncWtVcndR?=
 =?utf-8?B?enpkTytsWUpyMzlMM2hObnZpQ0RlQ1JmdjdWV0x1dS95bWZ1QkRibEV3ay9K?=
 =?utf-8?B?OXpFQzJkWWR1ZkNJWFZJT3Q1b0srVERzQTF5aDNwc3VGSld4YWs2b2c5OGNt?=
 =?utf-8?B?cEwzSGpYL3d5eGdDNTBMTVNxUTRrUDlSKzhlTFpocUNWa3hXdldvdFoyekpx?=
 =?utf-8?B?Zk9nRlcwb1N0bENrd3Jha0tvaGVTdUo0WWlCbHA0RjI1RG9hbmFabjRXeXV4?=
 =?utf-8?B?Q1pHa2F6cU9NcnlLSmFRdUFoVFVzeWpEZkxmTDl2ZEJhNEY0aWxxTmY4MVp5?=
 =?utf-8?B?ang0cUg2UGlkTzNMa3dVWnRVb3B1UCtXa2dOMFhZSU56RHZQeVpmMTB4YUZE?=
 =?utf-8?B?SFZaQUdYT0pDRXBpTjNvVEpidjVyY3BiMEp0RFhwaDJ3SGhzZGZyRURubXFI?=
 =?utf-8?B?VjI4L0lYZko3SEpubVhicTI1aEJKV1hTdTdkWjdoMVVybW5RRlpYZVdGczJM?=
 =?utf-8?B?WXplcmpVSXVuSHlXaVd5SXpXcVNhTzU4ZE0rbDhrQy9EanZPM1RsTVg4OFdS?=
 =?utf-8?B?aWJyRXd4bXlvbkY1QlZTc3BVcytlM3BZT0pFdVNVWTM3eTNHQ05XNEc0VVR2?=
 =?utf-8?B?SmdTQ1lkSVB0d3hlQkdxbXZNRFVaZS9CK0EzSEtHYnIxbHE3TlFrTmxhandn?=
 =?utf-8?B?M2FKQ0pkcU9NZi9GcHFaS0t0c0VaN0xyS0cvalBnV2dLckJzRUwwT0hGa1pW?=
 =?utf-8?Q?b2Ph/6vU/VnysO5QiuV3tX1HB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e47c7aa8-0aee-4ebe-0e43-08db8ca7cfdf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 00:40:57.9481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBLCwqwjy/8dJ6n2IlOFbEURuGPFx2tEnTJZffwG5stH214APzxemJBK1HQ3RJ2t7GV5Se5DW4dpmxPq+927EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/2023 6:33 AM, Thomas Gleixner wrote:

> The series is also available from git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git apic-static-call-v2

This series works fine on a couple of systems that I have (but they
aren't 32-bit).

Please feel free to add:
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
