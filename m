Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586067CC971
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343873AbjJQRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjJQRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:05:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAA3B0;
        Tue, 17 Oct 2023 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697562322; x=1729098322;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wAKkFcJxkdlBC64QyTEttA9An4whR8bdJdT6ajiELsU=;
  b=F43824X5PFW6PE0yeLJVws/2mK7fI4Q499qHiY7L0+vfhhhIe3POJS7D
   C0vTHtGVsoa1VZA3a4gFCAFRYsbXB2rrSaHXPZm3lp6yQ9Ev9LT73Derz
   siBmqjISTwkWOH7ySwAPmXEYSenJpjRyJu26xmMd5qzRvMQaNjDFERXPy
   kYdQHWsv7NrbwDoz4Xt9lfVzf41idrRqBqtU4kXjLU4yNZnIwamyPxLkZ
   +h4JQ7u4yd4z08IY4hcZHa8JRQEFMQpAWE7UIXZmZCYhFOctxomKiy5w+
   KgqWiRdBj4yokEhcNX+CR9jEBaXzehlz+TolsYeSPBIcvpIWWE1qCBcQE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="472057265"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="472057265"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 10:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087578413"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="1087578413"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 10:05:19 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 10:05:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 10:05:19 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 10:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdiWdtxGYK4NWyAjMYxOxyIc9MgZ4yydK/Pp+5xk91pqrHdaSNKguZhq/J8UDk/pLSIPnphoFnOUzyeOqn4UzYcErFLOa+PHJwC5vS+GmZwOsDtmUaLdKFjchHwgkGrKlIGspQ9WEbQkOP4/WESZkIz0nK+vTEynkiGC1vvUmeqI88Z8GtTkbupCpcG+tMtWZO/eZkzcqq7bfHe0abaOF7BH23kMqREdGHY+17Hs+lyWglSToPJFEEcZfGcZ0+8ubcqf133GU4ncDxKEqdmBi68mR0HD6V+gsFmhtfPrbfG9pmHHPVipa2xDIbrR+g9GivhIDDEXc36w7mRZZcW3jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRNPRkD1trr77dqbjzssPmFVMWoAvhVa+3HDYGfx7B8=;
 b=hBarfgIJzCWp5xhOaED8zz/Fx3xgad4+AyzWkPiMkyvNx4isEkS0yzdqNl90rNCFSRyW9uElJ8WPnukY/Sk5ic6d6E/dhvYAQNGNUUCFM3gA+YoKFekEIz10J7+VG0FXgSNGDofWltUHOevJeM0fWR1Z8MkQYdUMkizXKR6tL4q9nR+r0xA5coHeWcUBlLf98NXWXVLGgV3t46PwV2CiCEWq1ds5bOe0z2S3U1tfhE/rxH5nhXvT6eSQGC11f9tTApu1ZYvf4kDBFB13JSPsm4HYwMeBhNrijEez3/3Q2P77NVlGUjnNeRSbNkqDkpSm7bsZRFmJ7VNWPNIyYds+3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7604.namprd11.prod.outlook.com (2603:10b6:806:343::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 17:05:15 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.021; Tue, 17 Oct 2023
 17:05:15 +0000
Message-ID: <75d7c5fb-2cbd-479c-bc9b-3730223e77db@intel.com>
Date:   Tue, 17 Oct 2023 10:05:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/5] i40e: Add handler for devlink .info_get
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, Ivan Vecera <ivecera@redhat.com>
CC:     <netdev@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>
References: <20231013170755.2367410-1-ivecera@redhat.com>
 <20231013170755.2367410-4-ivecera@redhat.com>
 <20231016075619.02d1dd27@kernel.org>
 <b1805c01-483a-4d7e-8fb2-537f9a7ed9b4@redhat.com>
 <20231017082120.1d1246f6@kernel.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231017082120.1d1246f6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 009b5d53-130a-45b0-9963-08dbcf333b52
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pkGBPhFVzvPEz/ZF0EvIzkglOru4aVbU2oYuDWHC53FWHyQrBRPhFexf5lSFPCSzWG4lXANec9sk32REfU/MDNs0OHfKQXW9hc1A7Ti4ZWpt/TN1UtQ3yH3TWN2EYmWE64q8LDjBThfbQwPu3FgYzRJ2dg21iZ9h68DXh6Qm/hM5IGSs3MIw+JX43BgPB7Zy0KBZsXfm9SJCihZoUWiqQ5uL0+FNObthu32UmrWbJz2UrzWf0MkxmQg8jJXvhxkoi8k9ntztDXmTb/+S/JEdy5j+q6r/oaLS9dagrqtqx1u8WLoiPH9E4tCHPxwWvw13AvNf6hUSWezal7BEVdP20952wBPj0NFY5KFuZPl2Ck7PbpPt7gDUKzaUEQEyUfTDNl/g6oiNV1EnK66Ap24Qw495BCLwi5rPlKBzQAJWBjGWqHG0uv1PTvCxdcOYExjYHspRSquXIj1e9LtswVZQQEb19sq+p8HqDvTYh1UelibxA06GCMJ5S2/M9mzLUWxWUl8Y/ejkuydeML2Z2eTrNGx9ozBJQnktuwkhC1N7X+HexHA3vrjmnh3fpji2nBbWajlg9LlV7JU1Vr7sQvLPZF3LOVPiDktABXQv6sgHuoddNjsUrlMxHbe9jeA65cw1bO5sDYH7WbM5ooK3VBSKp5FvO1Eo6c/A7xNpw629ULeoyUcG7+WJogXxNm5yDRQO2JTAFL5k0/oSP+qEPvqaIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2906002)(8936002)(8676002)(66556008)(83380400001)(66476007)(110136005)(316002)(66946007)(5660300002)(41300700001)(54906003)(966005)(4326008)(478600001)(6486002)(31686004)(6512007)(6506007)(2616005)(26005)(53546011)(36756003)(86362001)(38100700002)(31696002)(82960400001)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFZpMk9WV0pKUU03dGpJTVMrU1lsV0VHWFkvekduUzI0a3VzU1RDNlp5N3J0?=
 =?utf-8?B?TzZNMHhoZXRiOVhWZUV0QWJSM1c2bnFHRHRlenZvWW5GLzl0R2ZraUlybHlS?=
 =?utf-8?B?RDE2eThEVnc0NVUvSUNTL1VBMzNNcVBRQ2lTcHB5NWRKVVp6cWNqTDlNTDJa?=
 =?utf-8?B?ZE1pc1pZMTc1WTRiL1hQQkZqZ3FmUExUSzEvbkljZ2dQN1lwaGw2b2tjSTZ6?=
 =?utf-8?B?Y09heG5BVk15S0NHWnZWdDlMMlN6NVFEV3lYdnVjZmt6dlBYa3BldDNhMndj?=
 =?utf-8?B?RUNGQ255bDlUa291dmhZZURLN3l5TVJ6eUIvYTdaL0tJZWRSbWlTdTNvN2JF?=
 =?utf-8?B?Q25sT1dnYmxXWFdDYkxrWFFTMHJpbUlONE5CTjB5RnR2SXFFMktCRUEvUVA3?=
 =?utf-8?B?eGxQR0dOemw0eEtJQ0dJYjR6eVM4bHMwQks0UVhLT2V1a3BRWUh1R0x4MWpk?=
 =?utf-8?B?SWdyTVRIUTkyeWhFeEZyRGU2QURzUUlpRE1zRTMxMXoxeFYzYmUwVFZjdk1t?=
 =?utf-8?B?a1dzNllVN0lxLzVuclhibCthU3djV2xEcVJLTFdaYnZQV29BUzBEcWVEdlpL?=
 =?utf-8?B?ZjZabjhNdkFEUHljY2wycnNtN1hoZEN3cno1Y2oyUW9tY09LQlRSZXFDQ0lJ?=
 =?utf-8?B?dDlZV3pBQXByUEZYSm11UXI5SkVuZy83WThtY0k1MWtFS0x2TVVDa3VqTURO?=
 =?utf-8?B?WVV4T1BTWTVpMmtlbHNQVnJ5KzkvK2lVS3dLZUJvTlRFVzZpczBPVmhVTC9S?=
 =?utf-8?B?ODVqLzdvVWNjMGtQZjNBbWhoOGc5STJPTEV2RUk0a3Z6SGhNZkF0Q3FxeWgr?=
 =?utf-8?B?S042V012SXRNbHg3YUZ6V0RPNENFNmk4aUczcGhPS29lc3dycUl1dTN3TC9F?=
 =?utf-8?B?V2NGUDRGVVIrYmFHR2Fjczh2cjh3cGt0cHhZYXdIeThNTGJmelpoTUNXei9X?=
 =?utf-8?B?VWNlRXlxcGRRbThUeGc3NGFnYlZ6c2N0M0t2S3Fldk10U2gwaDg4RCsxOUZ0?=
 =?utf-8?B?MytvMlBMUDNoQk5pdUJZRDlneXlQWlVvdVdZUlFna1NYcnJFdFFFWEVTT2Rz?=
 =?utf-8?B?QlA4cHZtMjlvdnZEamdLaGNsNm4ramI5N3lGMmVETURSK3JXZTNxbHhFWDRH?=
 =?utf-8?B?RVJrNDd6RU1GdHRJZWlOQXU2MVN0Ri9uekZ4bkNuZUZSSHc4QTUrV0dQY2ZO?=
 =?utf-8?B?YjViL2NacVcwRDVYUm9PYmROTUd5MUV5QzdVN28ybGZteTBkdVI2ditjT3Ez?=
 =?utf-8?B?bThxVnc2dGpxOGZWY0U1U05ZdFNCTWNiemw4SlphL0ZnOUpwVlRtZUM3MmQz?=
 =?utf-8?B?UjZodGlkckp1OEMzK1VMYnIrRmg3SVdTemNxMFpyejI3Tld6OEZLaHdRUUpK?=
 =?utf-8?B?M255Z0hlRGtjaXIwL2ZHRE42RWhQTHJMNW5zMXVWV2Mvc3ZvOUYzWFlDQ3E2?=
 =?utf-8?B?NTE0UENIZ2RJYTRtWEIzUXJNUm45allhRTI1aG44RlBCeHBNV3p4Z20vejZT?=
 =?utf-8?B?MTZrNjJNTEc3c0xBakh0bXVaNzhvSS92MW5qUjVueE9XWFM4aUhLVFZoZVRB?=
 =?utf-8?B?SllmbUx5QW43ejlZNnNNVDIxNFdOVXd4QnBROGE5b1kzVE5QWXZLV1FiU0xP?=
 =?utf-8?B?a2pzM0U1dlZXSEk4S1RJTTFlNDltL0RvNVRqcEhnQk1FZlFUdWx1ajBCVGk1?=
 =?utf-8?B?OTloRE9ObGFHM1NFU0FQckJZWlpIU0xRRnhHWU1aVUtxUHhrWmtCdGd2NERP?=
 =?utf-8?B?ekgrOVZ3VktwZjJncHUrZ0g4NGc3MUNyYmRVQmhvcVNPOGRCTmUyaEx2UFF4?=
 =?utf-8?B?WkcwQXBESDdGRXk0OHM2WTBUZHhTaUdNUWJ6VnhCazBhYmwvUlJVNGcvV0hP?=
 =?utf-8?B?bkVTdnpQa0VWWFhBVWhCc0FGcldiY2FsZHNETG00QWlPOWdGUUJMOVdmNWpm?=
 =?utf-8?B?QWZEZklGZTc0MTNRdTQxZmd1ekVKYnYyNU0zTlV3d0ZGUDBnRStxcUUwb0da?=
 =?utf-8?B?T1VTSkpJdVNYR0ppS2cwT2dzS3RSTnFDcXd5a1ZaeFJpM0xqNFF2Vk1nVHpk?=
 =?utf-8?B?emdERlNadmp4eFZOUldIQU5aVWlreFVXZXJjTDBoTFVFMVJtQkJCTFB1bFFE?=
 =?utf-8?B?bmVWaEt4MFFNc1cxSmlmZjFjS3Zub0pIb0p2UjRIOXRTL0RGY0lMT3hKTktS?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 009b5d53-130a-45b0-9963-08dbcf333b52
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:05:14.9740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fIxU1omiSr69kP2BNwKO3ddyyJCOKaxa4Zxngg7EHnzAyNjcoaKAyL1ZCOwsj/zeLUelJF2V1DeuZBaWQunMwMjOS73CCUXo2tPb/bSrpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7604
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2023 8:21 AM, Jakub Kicinski wrote:
> On Tue, 17 Oct 2023 11:56:20 +0200 Ivan Vecera wrote:
>>> Your board reports "fw.psid 9.30", this may not be right,
>>> PSID is more of a board+customer ID, IIUC. 9.30 looks like
>>> a version, not an ID.  
>>
>> Maybe plain 'fw' should be used for this '9.30' as this is a version
>> of the whole software package provided by Intel for these adapters
>> (e.g. 
>> https://www.intel.com/content/www/us/en/download/18190/non-volatile-memory-nvm-update-utility-for-intel-ethernet-network-adapter-700-series.html).
>>
>> Thoughts?
> 
> Hm, that could be better, yes.
> 
> Jake, any guidance?

Hm. The ice driver has 'fw.psid.api' which is documented as:

    * - ``fw.psid.api``
      - running
      - 0.80
      - Version defining the format of the flash contents.

I think we settled on this as well back when I was working on the ice
version.

See
https://lore.kernel.org/netdev/70001e87-b369-bab4-f318-ad4514e7dcfb@intel.com/

However, looking at the code more closely, this does appear to match the
ice driver's implementation if you use "fw.psid.api". I believe the
intent for this is a version that indicates the format or layout of the
NVM contents.

Given that ice uses fw.psid.api for what appears to be the same purpose
I would propose that here as well.

> 
>>> UNDI means PXE. Is that whave "combo image" means for Intel?  
>>
>> Combo image version (aka CIVD) is reported by nvmupdate tool and this
>> should be version of OROM that contains PXE, EFI images that each of
>> them can have specific version but this CIVD should be overall OROM 
>> version for this combination of PXE and EFI. I hope I'm right.
> 
> Sounds good then!

Yes that sounds correct. That's what we do in ice as well.

I'm going to review the whole patch now since I hadn't noticed this
previously.

Thanks,
Jake
