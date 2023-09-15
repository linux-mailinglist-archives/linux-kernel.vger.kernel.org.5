Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5B7A2555
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjIOSIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIOSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:07:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E5B1FCC;
        Fri, 15 Sep 2023 11:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694801274; x=1726337274;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bArUH44o8euJAG3df3iqQJJ/sCsi1xnbM6JuOrh3m9Y=;
  b=nH/qGTwR05LIq5NJXdczsVMLyEERPrGNT8ETJMACxYu9QO/clhd5+PGS
   dBmrW9jOa99bpTZaGgnFnrPb4rYV369BCuIClYYyEi1ZAHFD49+VDHMA1
   ifBivkJAu9If/F1JGm2UUYPFjO2tOx8WMBKzvXcW/IjyfzsJ1yjxXOWjp
   Hj+K5V5RjgklPwzK41N+XCKtqmJFwLRtrS4fjXzNdwxnmPnHM4ret0tmh
   5g/mUoEbfzZqLSJg0LHSKy+Ak5bWkbV/8sMniaiTTLuA303371wOuHSbz
   4cTvX29VX7o4O9OIDakEibgniZE+60+u15wZ06aUV+YVN9cohC+o1R2W9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="445784775"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="445784775"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 11:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="918731744"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="918731744"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Sep 2023 11:07:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 11:07:48 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 11:07:47 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 11:07:47 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 11:07:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzbZabLu/R/3bB9pOYsCRCSZBaLBXNKOseZVklJL46fwv80/SS0WCfPmCyr34loklNwQuK4kjERUcVcaK7LU0PW/ueB7cQQXa2Htn+4rW0cqUCV7a4Py2mqMutM6QoANItUt2njaDMvBvABWTU1BUIoi/v7IIeXxuIjZLHxLWhJCdyzQLH4LcErPfg7rm5Sq5DxTVaLTOeO3YMudbGQRGzNs8/N2IblLQEha3O0dpRShIpRSrfKljBoSJELNtqzHUAWTfgNjCZamiqcY7cqjkLjnMiymfSoOs7oGCOrR5iIk7nyEewoblDXwWFsAjBXyVeub6Eu5dkQIg4zk4hbChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSyrdP4Mns5jkIdYvVIWrgIcLDeeg6nOxJ2TaOcH8z8=;
 b=CXUdmrPKSHkHyLAo++BhaE0SdaWErxNiPTaahJD+CEtf0PsE/1XQzHxJn517aM4bj/LyCviCYhgB5uKwCyFTM+HREXHQuZxcRkZMZx83SBnbMmLUk4ixVPrGfEZ7VzKVJRACzrU0V6CDqn2zGpiGCki8TiSPGg3wSX36ZTHF0LL05b3/GQyPlvMKEd2Mnqe23s5l/txknPnQZN6kri3PZK5uqMZQPlSlKj58Xf2VFfUEcuRGqUVMXNNph/CsvCcliWg0p7OO7nncpa3VSc4l/9LvdpNCjQTrYPPbQG1cCvIELK8Agj5vuRgwcqgggEoIKiUKNL19bUM/IPVJW6L3PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by DS0PR11MB7190.namprd11.prod.outlook.com (2603:10b6:8:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 18:06:35 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::fca6:a86:a250:ad54%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 18:06:34 +0000
Message-ID: <215ebf8f-1b64-3b9d-1952-350939827da8@intel.com>
Date:   Fri, 15 Sep 2023 11:06:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 06/10] platform/x86/intel/ifs: Validate image size
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     <hdegoede@redhat.com>, <markgross@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <rostedt@goodmis.org>, <ashok.raj@intel.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <patches@lists.linux.dev>,
        <ravi.v.shankar@intel.com>, <pengfei.xu@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
 <20230913183348.1349409-7-jithu.joseph@intel.com>
 <b189850-ce7c-d8fc-ecd-1a843f52b916@linux.intel.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <b189850-ce7c-d8fc-ecd-1a843f52b916@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0091.namprd04.prod.outlook.com
 (2603:10b6:303:83::6) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3768:EE_|DS0PR11MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb13a82-4368-4e75-6c98-08dbb6167f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QlliCERGlKLqbmLIT2763RXqijkzrSKXrWcBPwSwbcMXk4UW6qG4YkPxixDKapd86C+Rk69jjEec3vVdzqhaNgXRjqphLTM8OMNl+FKdGPxtiGxFCKNV9NS31eog2prXReuC5Z7eCiVDXOgVo/N3prITYr8k0Ja+zclrduma7V7ZCOruZ4fyv71NMp0ops+/bk2KBtdvDEe351fqW/K3m0qOxttDdYUgrAR5hplT07XLJcXpeVosll93+EgeNb2HcJ83YKq41HDs9SZ7I96WZkrgBtgguph0PVEVXQNOEjTPdZSRmPOkL14jiWHE833DSB0VJMr00rfT/TrC5LyVDo9+fKq4StMJRFzJO6BfK74Ro8vInBVGMvqepRlyaH8QVoWjsm/qE/54J9TBSB2pGJthnSEq3Ur93LKgD1jqwp41XH06L4uKNvgw9HFaHCqPUMgC1u2G8ZXnLqgvvECTdRWAhTk84ymU4XIGMLKIDEmeVvnClGWipjj7H87tZaE54QLSTAysVRLe69exX/dnBLqpABN9W+rve6GViO292SwNKyy9+bVoILYKM939vtk5V8oRU0ppzqBd7zRgyXc4kUYhZEOfqwgiuqQNzwJQfU8ivlH8dYxE2+IP7kcNn/ZbCyC0p/77Wn/SWJSToajwLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199024)(186009)(1800799009)(8676002)(4326008)(8936002)(5660300002)(41300700001)(66556008)(66946007)(15650500001)(316002)(31686004)(66476007)(7416002)(6916009)(2906002)(82960400001)(66574015)(6512007)(38100700002)(83380400001)(26005)(53546011)(31696002)(2616005)(478600001)(86362001)(6486002)(6506007)(6666004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emFvU3JvNXo1N1RwY0duWXAxcEd2OE1CSDBNcm9NQ3ozeUtnSnZMR09qVGVY?=
 =?utf-8?B?WmdYVmFVUklBSDFWUzBDdWlUWFBsbWQwVUZmWTE4aklZNlpRamFSVzg3VXE4?=
 =?utf-8?B?T3hubzRSMUN3ci8zMzFkcmZlYkRkZU55Nmp5S2hBb29Qd05EQXVzUlk0TWlV?=
 =?utf-8?B?dlBqMmtLQTkydlNwa29hZDh1bTVuYWhYSGZ1VWdocG1YMVNSVkRUeFN0UWVu?=
 =?utf-8?B?czRYcWJaL2xxaHpMQjhvb2txM3pOUmdaV1RYWVlQK0FyUGVSdU5qMUFYS1lF?=
 =?utf-8?B?S0djSTVHSm5zYjVKRjY5RW5NemNQN0lYNDZVblo3YlR2N3ZRR09jRG54V2Iy?=
 =?utf-8?B?OXdhWlJzcitMaU8zVEpjeG5STHVjRVZQc2NzN1J2V3hoQURLSVBibUFwbENn?=
 =?utf-8?B?R1RSZFZQbE5VcFNKOUg5MmNQOG4rY0FpTGppbjIvZURUUklqemFQejhrcjE3?=
 =?utf-8?B?cDhDRFF0UkdLNEEyM2pkeFludWtpSG0yYmJKa0xBZDl3QWVUamlORzVYR0xO?=
 =?utf-8?B?ZHY2enVVQkpQZ0I2L1d1b013dTduelF5eUdLalg3eERHSlNZK2s2blZ3WHlj?=
 =?utf-8?B?RWpLbUgyc210MkdIMG1vczhFWnZTc2hkY1ppaFdJME5GNzVPaWdnbFdjdTJ0?=
 =?utf-8?B?dkpIZ21mNDBXTEFsdWVlS0ErTVdJenF4S0VFdFhUL2NhNEdtcmpkUXEyMGhz?=
 =?utf-8?B?eGtieUZRaDF1eGF2bXFRY3VBZnVlNXgwWG04Um5USlRJZ1pueUZ1VDRlSFR1?=
 =?utf-8?B?MjVRZzNwejV6MmdmaktaZVo1QVdRM3pvRExNNFdRb0NWakRRVXExbkxnMUdS?=
 =?utf-8?B?UzlLaWpEcEVvOGFvdjRyTkQ0aFFGeVF1ZVZsV2Rmbng5YXdtdXpXaC9RQldR?=
 =?utf-8?B?c0RCemJYOE5IQkdEN2NuNnBtdmtxREs5MEhrd0JxeldTb2NFYUJzNGVUUUkz?=
 =?utf-8?B?MmtMNWJWdVpaWXlYYkFseTkvUFZLbVdPaDdHbXluZElwNlkxREdkUDJlTnpl?=
 =?utf-8?B?NzBsandpcGNSZ0tJc3A0T2FhU1cyTFFOSnBvamZaVFFrM0l5N3F1b1MrNVJs?=
 =?utf-8?B?L05JZ3BuTk9JZFpEZjJuYjdnaGtTajNwOE4zY0xjK1dmNTVNYXVWWUgxNGtk?=
 =?utf-8?B?Rkx0NmVaZExqUHRGV255TjJQRERieEJKclZiZUhVdWJIRmF0bGNVNnd3N1Qx?=
 =?utf-8?B?TmM4QjF5MWRNdHl1Y2ZCNWtzTGFFcERSd3FkL0Mvd3JKdzVWbG1UZ1dVMHI3?=
 =?utf-8?B?VUJFTk81RkRiMXloMGE4RDBKbDhZdjdqd3NLQ1Z1NTdSYS9BVmd3WG5CY05F?=
 =?utf-8?B?dUk0MGRUNFpDdWZyZE9UcEtnaVFFR3NFZWFmNDV4VGl1RmM0MWs2VnNNQXBW?=
 =?utf-8?B?RVdLK0tqbDBEWXY0QXNJRmxxOWlrb0tSOEgxb1lFeUlHVW5VTEVkamd5ZUtl?=
 =?utf-8?B?WXpzT0xScU5CUElXZkNSOEVZUFRtRDJLTGoxRGtJSjN1VTZXdHlnLzhhTHdW?=
 =?utf-8?B?Uk43S1lyUENjTTlleHFLUG1EYVh3M3BOVW83UWMrQ2ttL1V6V3lkSzRuMWlu?=
 =?utf-8?B?R3prVUlGeE9RZXpremJsQkZreXdSVmJRWHhEWU5pdXV2eVlsbWVSa0lPSUFD?=
 =?utf-8?B?VXJ4MU5wWldKNkYvblE3OU5xL3BGV3VlQjNib3h3ci9JRWVPR0Z2cTFSVC9h?=
 =?utf-8?B?MEpoNkdZSmRXYjdneWtqejdWN1dHWVdXVnJpdmdzSS93TGc0ZUZrUUJDZEcr?=
 =?utf-8?B?ZVFxblJWbkFORURidE1sTzZWZ25pVUtDMlRVWFR5bmlTbHV3bXNzNFVIRVJF?=
 =?utf-8?B?eDQ4VGh6eXFCbzFGT0dKRmJ4Mkk5NGJBNkdkNW1JOW9mN01TdGxJMFhTZlYw?=
 =?utf-8?B?TFhNdXhJNWRpYUFyUHVrYjFDYmJNNFhmUWg4ckpmNnYwdUZmblFsMytVeWxI?=
 =?utf-8?B?YnhHV01FbjVDeU5Cams4aGlMcDlFY0lHVnN0cy9qNzJ3VVByY3FacmtDclJH?=
 =?utf-8?B?L2phc3hoVUZWZVgwQVc0Y25hWnQ4aHNzT25rM0NVcDhiVVFQczlZSEFkSnhS?=
 =?utf-8?B?ZFo0Z1Rma3hsaEw2MWlUQjNpdkk0cSsxUGRxNWZGSUFZMXRFRSsrRmsxQ0or?=
 =?utf-8?B?eHlWOENqT2lsbEVmVjUwR2VoV1lidW1mVGFYY0t2UnlaZDFHRXVtK3JoeTNS?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb13a82-4368-4e75-6c98-08dbb6167f71
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 18:06:34.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: by6X+f/kkVTXtkiCi+e7L7qx0UzSdfAleQHthKOPL/Ye+uwKRGmXMUtDhREo299QvMBRXMFf/ARebD1g9NwO/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7190
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2023 9:57 AM, Ilpo Järvinen wrote:
> On Wed, 13 Sep 2023, Jithu Joseph wrote:
> 
>> Perform additional validation prior to loading IFS image.
>>
>> Error out if the size of the file being loaded doesn't
>> match the size specified in the header.
> 
> Please fix these short lines in all your patches.

Will do

>  
>> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>> ---
>>  drivers/platform/x86/intel/ifs/load.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
>> index e8fb03dd8bcf..778a3b89a24d 100644
>> --- a/drivers/platform/x86/intel/ifs/load.c
>> +++ b/drivers/platform/x86/intel/ifs/load.c
>> @@ -376,6 +376,7 @@ int ifs_load_firmware(struct device *dev)
>>  {
>>  	const struct ifs_test_caps *test = ifs_get_test_caps(dev);
>>  	struct ifs_data *ifsd = ifs_get_data(dev);
>> +	unsigned int expected_size;
>>  	const struct firmware *fw;
>>  	char scan_path[64];
>>  	int ret = -EINVAL;
>> @@ -390,6 +391,13 @@ int ifs_load_firmware(struct device *dev)
>>  		goto done;
>>  	}
>>  
>> +	expected_size = ((struct microcode_header_intel *)fw->data)->totalsize;
>> +	if (fw->size != expected_size) {
>> +		dev_err(dev, "File size mismatch (expected %d, actual %ld). Corrupted IFS image.\n",
>> +			expected_size, fw->size);
>> +		return -EBADFD;
>> +	}
>> +
>>  	ret = image_sanity_check(dev, (struct microcode_header_intel *)fw->data);
> 
> It looks than a bit odd to add the check here and not into a function 
> called image_sanity_check()?!?

image_sanity_check() validates the contents of the image, whereas the new check
in some sense validates request_firmware_direct() results. Hence it was placed
outside of content validation / closer to request_firmware_direct()


Jithu



