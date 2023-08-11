Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84815779BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237238AbjHKX6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 19:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjHKX6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 19:58:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A61719
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691798310; x=1723334310;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wTw0WWyF3DA5OF+Cpu9fNbEgNXwlBVt8JOphfumThwM=;
  b=LBIJ4x7FVPhU9ssAaOPXybvA+DnE+m8bB38QjrIWniV6m+D6cVPr+L0V
   APQQjAa1pjC6xp27U/5m0+gSapWKWtpbBReazHaooSDU9uf7HrLqoZzyz
   na9Salb+qfQy+nhMw/eFGrJ+DraFPpc4MUtYr9WVIrwWCIA/VKVaTWmyX
   g17ZFj6W7ZvEO6T5Kgy0XANhjDyD0dQlvrTrBTIkDYWI1IHibbsWdRqWU
   G3q1zE+rkigVmuldZ7RS4B7q6jPmLXTENBm1Et/oKSO9QcjR2lSUXe7fl
   6a9r55bHS81jdk4e1+rtK9sbwuzF4SZJiRqKKO6yIBx+jCBI8gdbECrJs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="361930105"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="361930105"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 16:58:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="798202716"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="798202716"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 11 Aug 2023 16:58:28 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 16:58:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 16:58:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 16:58:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 16:58:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSVs8ew1jNvec+Nt0Vap5sxYwlKV55VDF/r71F++i2cZ2dMa9zYAvJdzGZw/JMtnxeWeVaMtG4GS2SjakCO/qYD0EHhAtv5iQ3gIUj5wyHQmGiQ1PBjlFA2bUBzN+2J9WU95aDkTjar+vkbJ/EM41k4jaBcOB/TbKlDm+i/UzQ6O70gpYgKEBJ6+bmH+N5bUtyDQUJ8CW+xfO+/mE6+rd/fNSNmB2sf1yy8C97aaP9O+3ZBBvaN6qFQNJPGl7/GUbZsnpPsJBqtVr5sc5ZGD7dOPVsPYciuOXQEhyjmoI4tr/M5XL+38397LFsLkb/AUTKbRZ0mqiFubzLTxzPhaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkNAVdRUNbRTWEH6JhUtAqP7yQ+bbVcVNx0gooSIgOc=;
 b=SiYP/9BeuHUwjrW6W+brcP3p9RCM7RwPbWjFol9OldoqXz8Lwb+nVnqEcGOoyfEmZs8vL3xEXxVvOxh638rMUz3FMrKkL9xbZtA/hA1tDn7l+LqhqP/f+yoiD1zYgprYzSzNNb5K5oQ8+4QsSjUp9vALt/ue7AEAW9g6W/HJLtLyIILkaTyPnAN8VvOa87uW2WR0blbwWxhLASXP1/fbOFG1Tl/aT+T+v1gf9ODLJ97jEDgZsm/ZLT6AIASeHA6J8nzxvBbzEXY0BVgpZt4kE6gVZesIm+E5TUhHmcaJHRC/0NTwW2XIijBO7wS9Jhilts60VaUfQ2My7EhOIZHIRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by DM4PR11MB6044.namprd11.prod.outlook.com (2603:10b6:8:63::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.20; Fri, 11 Aug 2023 23:58:25 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::ad4c:86ce:d99e:9740%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 23:58:25 +0000
Message-ID: <3a4bf401-0781-492f-a952-3c96c1507551@intel.com>
Date:   Fri, 11 Aug 2023 16:58:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/1] x86/pti: Fix kernel warnings for pti= and nopti
 cmdline options.
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>
CC:     <x86@kernel.org>, <bp@alien8.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>
References: <20230811213628.40428-1-jo.vanbulck@cs.kuleuven.be>
 <20230811213628.40428-2-jo.vanbulck@cs.kuleuven.be>
 <295ea2ef-3480-856b-b93a-9ae36f7b2286@cs.kuleuven.be>
 <d76126be-9eda-d426-1fa5-a35fd4ca3d57@intel.com>
From:   Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <d76126be-9eda-d426-1fa5-a35fd4ca3d57@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0094.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::35) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|DM4PR11MB6044:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1827a5-d907-41b8-4370-08db9ac6da0e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K4sQ1b5354MhQE25LcqNW9fhnVhFtdPFct+eAkXmPoMaA8SPdXCtw4G7PWcHHuzpaPwPg9z2lU9OyNC4z5PM1vdcmWhL9p41IiNoLrMDr/HUJPE1JX4eTbdCc2Pw51+Rc0WPvtHon6UHSqHHuXC4ZFn4rr0p28clxdPQpvnt4i7lGelGFmKirzIl16rDbqYvXaLT1igk0ji+JSVSzwAb9EIWHh92sBA1rj+H1D8uWpTQLys5YMiNAOXDSMhAfabaX75xLKuRmTQSa2WpC0JMogHkzS6C4KGa+PTqgGmb6kfq5LYt2rtv8s4yIskCV419rOas38adPssN980Cv2ZFNBedgQ4zus6jKIhErj+nQrkYo2E69eAHeauAnmbWj8wyPJB+CzTml3+44G5rZNADsQFm7oQH/qZbgu2YtYX8iGnoDrUnuog1W4aoVOWcDI4uzRiKzXY623VFhPDdZf3GY0I/ieSfm6N73gvdKlEaUWFz6N4v+94nhCk0S6cZ4SxHPwTc8OJUyZeZuyowLIIxXvzZDJJacvN0RFITaJq909luriAGIvg+vwXGZCMiRHmsH8J1oRxH++3ZycCD6UDqu4FGFauQf0WG6nXeyU48lmD9JdKA7SqrurqZ3foHAk1WCvbDBng8IQGi3JKlZ/zSQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(346002)(366004)(376002)(186006)(1800799006)(451199021)(31686004)(7416002)(44832011)(83380400001)(110136005)(6512007)(38100700002)(6486002)(2616005)(31696002)(86362001)(2906002)(5660300002)(4744005)(8936002)(41300700001)(316002)(478600001)(4326008)(66476007)(66556008)(66946007)(8676002)(36756003)(82960400001)(26005)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0orRm1veFNSNWt3Sm9zS0UvMjNtZUpONWJQT1hpWTdtTUE3R1dRRUE2Z1lx?=
 =?utf-8?B?Qk91dkhGWUc5Mkgzb3FkQTd2NGJZbTBIall1R3R1UTM3ZXpxdktyeGtXNjZL?=
 =?utf-8?B?eEFwT1Voc3poMi91U2VxN3ROdzhzS2FsNGYva0JvRy9mZmhubkZ2ZFJrQit2?=
 =?utf-8?B?SG9jOTE3TWdEeVhTZTd5NGU1WW0weUpqRUlmV2UzRWZLMHViZlRFRkhJQzUr?=
 =?utf-8?B?dVVNbE9PWitNUy9tdlRzY2ROZ0F6SGZodVRYWjA4STE4dDUwK0FMc1VDNlRo?=
 =?utf-8?B?SzdjRDZKT2x0MlNBZmFrdk5tMFh6YllnZFRvaTltUE1VTDlHQ1M3U1B1TlZI?=
 =?utf-8?B?enFlNDJ1cHFNMjlocXgwRkZ0ZGtaVGxoWEN6L1AwZ3FZWGJvcjZPSldKdVRp?=
 =?utf-8?B?Mm0zN2dhMHV5T1lwU2VvakFoSFBPdnovc3hYYk1nWGRoNTF2ZGhqYWpIU0tB?=
 =?utf-8?B?MmR3MUlJMEEvdytLTCtDU2RkS3VwUFJiMXlZdnJKUStrQ0pESlRoTXJjclh0?=
 =?utf-8?B?UG9DTm83Y3Uxa0lNVzgyLzFtMjg0L3ExYzJPVmNnMlZTazFsTy9OamhQemhI?=
 =?utf-8?B?anpGbHN5OVQwSmxSc3dwaHAvN0FBcFRxRHVmOGNWbmgydFY4Yk5ZdGwyY1NS?=
 =?utf-8?B?VGpOT1g4NlNSdnNrbUtrQWhZdTBrSXc0T0xDRXJCTFROWmJkN0JCYloycDZl?=
 =?utf-8?B?ZHlOVmJjOEVDU1RZUGZFS3g2RnJMWUxPOTAwSmViaURWUXM5SVRHSGtXQTFG?=
 =?utf-8?B?NGlKb3VBcmp4MldOVGhJaGJKTVE2UjZBeERIT2V3cUt2UHpwemJuS2UyRXBp?=
 =?utf-8?B?djRKTkdQTDF0S3dHdlRVN2Z1WGk4anlkb1lGOXA4djZ2cFEwTksyS3MveWUz?=
 =?utf-8?B?dTRBd2VBb1J4RGRnTXJsYkdBVEdKemc3RFlSa25XNmJOMjlnV203ZzNmY0JU?=
 =?utf-8?B?RUlsWVl0Nm1VU1Z0NGxxcjV3VnRReTE2aUd5YkVKVUdVR0t0bHpsZElOdlR0?=
 =?utf-8?B?cnprQ3YzcWp5UXE4TTZXaUIxd0QwaGs1Wk8rNkhUZTcyQUNwVk9vYy9xcDVF?=
 =?utf-8?B?M3FJQkpXbTBYQ0tqWUxmUjlCNDBEMUhqZkI5Qk9MSDBYMnNtTHl4eHJGOEZM?=
 =?utf-8?B?dytNSVYwSW95b21FdWlwYVRSblcrZWdCK0JlZll2WkJnMmVvZC9GL1BVZm50?=
 =?utf-8?B?YzZ3b1ZSbWNtQXJtQ0RvRXFXc1Vja2cvUHVvUmRKKzRFQUJkd21Na0pqL1ll?=
 =?utf-8?B?eEE3MDBSb1QxZk11Z3VnVEs3ajlrSkhqN0VDR2hYNWVENGF6ZVVnUXErQVVu?=
 =?utf-8?B?NStMdndSWURudUhGYy92d21BRDNwZWd0RjBkK3dubG5QWmh2MEFLZmdRMUJV?=
 =?utf-8?B?LzdrLzB2R2JlVnFjc1Rac1pjVTBuem8wcUtnSTcwVmxReXQrVTVvMjNtbkdH?=
 =?utf-8?B?WUxjVGVZd2t1S1A4QVBIQ00xRlZlMytFTGhUa2xDeW9WSmdVbTlGWEhSUEo5?=
 =?utf-8?B?Z3B0RXR5V1V1YlN5QWJGZ3B5RWJyaGZJeEM5cGRlVy84WXAwYk9OVU12ZlJS?=
 =?utf-8?B?cmRLRWNZdFJJYld0bTJyVUtzZ3pYNkJ2eVlZbFJycjRhTUR3S2NCb1ozOFhU?=
 =?utf-8?B?RFlrMGJ6Y05LTzI1czlwUWdXM2czZTVtLzc2czcvRERXaDhLUDlsQ2hZR01p?=
 =?utf-8?B?U0dDVmkycDR0TEdUZXplTEtnV1FOSjdPempWL2k4cm1ibFVSditEL1JRN3Qv?=
 =?utf-8?B?Yk1nSUVjcjA5RDRoQkgyUUovS09QWTQyQmNtQkpHNE9WaERHZDFteFFNV0J3?=
 =?utf-8?B?NUVHL21Jd3ZNZFlCMGdmQ083Q3FEQWd3SXR4a1g1bGNBM3JSNFlvY0xxZmFs?=
 =?utf-8?B?ejRiSkhpckx0eEFUSDRhNk1GZjBNNm9xb3pyK1VSdFM4ak44aXJTZGFzYllR?=
 =?utf-8?B?M2RkY3RyUlU3Nnpob2tKYTUrem9oYURCTlM3YTEyVkduYnFBeVlRUG9ibXRY?=
 =?utf-8?B?WlBhVFljOWplcllIOWxnQ2hLdDBXOGtVWXJ3MVU1K0MyK0xpT3FORVBVQzVk?=
 =?utf-8?B?YlFTckc0SlJMaWd2MG9pOG1uaHgzU2tJeUVCakVoT0k3Wko2RDZqMjRpaUx2?=
 =?utf-8?Q?36DgfjlSNaY46KOL9lPJ6RcIh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1827a5-d907-41b8-4370-08db9ac6da0e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 23:58:25.6923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQur5p9rMxWPTVY2s3RvYkpQigR1rDBHzpf2mIN0tLFIXFDFoezVBiqwwwUmlE+SBGk6ezFD+GYpWc/3qvKbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6044
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2023 4:42 PM, Dave Hansen wrote:
> On 8/11/23 16:27, Jo Van Bulck wrote:

>> Not sure which option would best match kernel coding guidelines?
> 
> This sound like it's getting a bit out of hand and reaching far beyond
> cleaning up some (mostly) harmless warnings.
> 

I agree this doesn't have to be this complex. PTI_FORCE_AUTO is unnecessary.

> pti=auto does *not* need to override mitigations=off.

I think only pti=on needs to override mitigations=off i.e. the User is
saying turn off mitigations but keep PTI enabled. This should be fairly
easy to achieve with the current enum. If it is not then it's not worth
the hassle.

