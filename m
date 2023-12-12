Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21F080FB06
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbjLLXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378075AbjLLXHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:07:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE46F124;
        Tue, 12 Dec 2023 15:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422457; x=1733958457;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pyg5kh8uY6D1FOMgBqT/5xYqOf5wnJkDA1/bRWPiZVw=;
  b=W6dvhzwvSKVjkdbgPGc0OAGdjvHM6FwWqr88t6RIxEMa2VdcWjgevV0F
   devTBQ5NrRFv5+0kSjT2LSm3sUAFVvnSUQyhsv9I6zuv5SdvGs5JjSNVs
   QSoABm/gCrrZqQMfAUzzQ+/21HOChz4dkHtDcpllhRcYf3T35w6nMaC4s
   heTyh71OO4Kz3wuVTJtBbq6pyQCfOGtQE+h6Op4HAJfZOKMFnJ02sCGV0
   5n4rPlckidhPUU2f062E7pOsN6N1qtiNeFl64nKhKZ7XzH6kDfYL3SL66
   kA7UumoSfrIM2WDtQxIX0Nx8UVZxvnOr1TM6GM9Hw4jKqxPkD4hwTQbSi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="426006516"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="426006516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:05:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="749877953"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="749877953"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2023 15:05:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 15:05:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 15:05:24 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Dec 2023 15:05:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Dec 2023 15:05:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mb9gz/G9T4CDWXAMNk9Orxn5mI62lrkJfZGfjKz4PT6+WWBKYVNOnbyK+S9aXV9V/1n/YUpBVlvSNwtamh5cZk7b6CK58sc7Z/ETm7SAl15vwhKKsPy9sFCeqwYbGYgL68Ic5QL7vQaWVRvtFMxUnmd3A6d0DHB3OAXhInITNtiB4ZyHAYpsb2cUAxvCnw8nQ0krPmPY6NwFWUNUVs3FgBD2IDTX0hbLYeE6/a93nDd71QipgY8Obshg1wpwd5flQnNON2BJVr/QZyBZezjejaxzrwuo0GTm6nYRc7AnxErzPOz87jhL261i1rtxtMULJl/qiKwSUcfUjbytQyp34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCRBOYMgOh2KHS7yK1eP1lrVYuR8uQUmrNhKGgjM0dQ=;
 b=DzFQrvhS18kuHmyvFQ0ONGJZVrKKwTPSFMEcSq/CIywCkQbtxmymHLSKFuLbJu/C6dQ5un7pxgKr5Pk0vLP0iG//nbdprUJMAC/XXIjzMGUTpjy8yq05UFSiCDm/OF0D5MFeGTIFN88KUF8aZbgP7T9/m7Zo+LBuv7nF29sKNU4rE+ISqg7srrDaw9jjyxXCZSEw0TdJVpcNAAcGrYAu/Rj61oFRkvRktmzQ1QbXU2MocnAF6N8JaSPO/IG5pV56BkOsjL3Ev3HapLkRe72GKwSXkODOeu6AnHAvwpGZ8irSUBQ8IK0dObocrG4o8cVTHSQ3bkWUtX99A/pgcY+qjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SA3PR11MB7533.namprd11.prod.outlook.com (2603:10b6:806:306::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 23:05:21 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::7706:285b:27d0:2c5d]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::7706:285b:27d0:2c5d%6]) with mapi id 15.20.7091.022; Tue, 12 Dec 2023
 23:05:21 +0000
Message-ID: <6ba1e424-9903-43db-b567-32a864b896c9@intel.com>
Date:   Tue, 12 Dec 2023 15:05:19 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iavf: Fix null pointer dereference in
 iavf_print_link_message
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>, Kunwu Chan <chentao@kylinos.cn>
CC:     <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <jacob.e.keller@intel.com>, <przemyslaw.kitszel@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kunwu Chan <kunwu.chan@hotmail.com>
References: <20231211025927.233449-1-chentao@kylinos.cn>
 <20231212132851.59054654@kernel.org>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
Autocrypt: addr=jesse.brandeburg@intel.com; keydata=
 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
 /fnLfll98Nhx
In-Reply-To: <20231212132851.59054654@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SA3PR11MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffd40e6-eab3-4bb1-53bf-08dbfb66d095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmPgd1Q7XEIkq8dSpc2CPDhQlxz9hxBfB39ocCo+P92PAl+CGWtqpE23YZOvWLWXP8WhwO98oN1IFikmNzVnoPdCwbsGFsiJXgm4tKqRGK4B9rZbqu4uSxPAdN2s1OlpyM0mfMcthAcEkHi0b/G+6qIeUpsA2lcMbC7le154rz+vH6nNbnpSgbEZxcI13noqG7ptHtim1lDcOgpFJlfqDLUTdqebjTNcp+/KsoIAByVf49TgHhtAyXC6BzQ/APvAeBcT6FEqQQP9gC9EiC5KdrI2xbQniR8JtTMGTEkFlxKHX3DJhSgcQL2h7c4oVCRVM7BF44V9ndnRNXMU4svcBVfFjihglJjOnUt4WPTluBXfj+CdTqBrFBNvqVuZ7y3fVE3OGBl+h0mh1/lGMx6XpnsHuFIOkE7IQcUcXCinXWghkLnUUiG263dygrSEI/sGpqB6RJQNBmYMwMEF0idJ7/cidohAiQ5tScvCb7nZikS0qEyBRBdpq4s6J5PUgIfxJW76NW98eii+lwVU4ps5Qdqa8DXLJsrTu56EuVkgkNsA+AJ4n+uSXwS5mIF0D4nioIETjpJpi5UhvEAHzctJ00DaOJ/mcQe40/oxNQJcKQaDl9clIXoPfzNvb23fEjQSpMdIIqwfYxEzthxwJGC/TMJ0HHa6v5vJddxUVNCBK6XuFfE/4wASx9slG+yjeIca
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(53546011)(6506007)(6512007)(5660300002)(44832011)(4326008)(478600001)(2906002)(41300700001)(83380400001)(6486002)(8676002)(8936002)(110136005)(66946007)(316002)(66476007)(66556008)(31696002)(82960400001)(86362001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRYVzFZbWxJT1QxcTJGWnJqQkVZb0hRd1NsdThPZ3ZyeTR6d2oxdWQ4Z0tI?=
 =?utf-8?B?a25TelZ5NGZ1c20vU3prWkRac3k0MDd5Z3FxWUVCcVIyc1ZJSkNRUmxnRVZt?=
 =?utf-8?B?Z08xanFtelF5NVNZOW1JOE1QQzhvdHpGTDJ3SnE4ZHZoUWQzUEFaSU8rZ1Y2?=
 =?utf-8?B?aFJybC90Tkp5N2wzNHN1V3BvVm5vVWV3OFVZZmFzTXpNV25uYmdNM2JyZ1Bh?=
 =?utf-8?B?L2ZRcHpnRXN5V0ZrMU9zWGRabFEwNTdNK1psSFZHZ1plb0IxNDZXbWJIRlZU?=
 =?utf-8?B?R0hxYnFrdG1sRWdRaHVOOS9ob1ltT2ZKR1FMd2xpb05QSkVYc1pkRlBaRmhV?=
 =?utf-8?B?OEFFMlZzL01RTzBKU2hXdSt1eUlOWlZBc1ZmTFVJSnpGeW9COUUyMWJoak9n?=
 =?utf-8?B?QlZMTWlMUUxkZE1pb2pFUExVSkRhdmhYQUpYQ2xkUUw5NW9xRm9jRmFUa2lM?=
 =?utf-8?B?Um1FSXord20xbTFHUFlGbWNOWVdMTTlQSDNUSXVtMFJRMjhKbXRPZGM4eFpu?=
 =?utf-8?B?STJFUUdXNGczOC9LRmxKcHdZUHlJNlo3KzFmVXowaFdWSUpxSkZSeVIyOTJD?=
 =?utf-8?B?SVo1VDN5dXE1SzU0UWZRNmVZTW9BUi9mdTFsa0w0RG0zSndoazBUZVgzZENm?=
 =?utf-8?B?S2NpYWhpVEV1dG1LeFRVUzBSMkZEbm82VDU5OGRIYjVVSEorSVRqNnAxeHBI?=
 =?utf-8?B?MkxjSXgzakl1dUUzd0FTK2cyOE9PN3kwNUpEVWtqMlV2Nk8xRVBHVHRrNTJx?=
 =?utf-8?B?MGNscHhQWldnb2cxY0pEc2QzQWZTVXhUaVQ3VVU4aS94YjVsVUtrUjRGR0Yy?=
 =?utf-8?B?V3FnYjBuZDlrOXJha0pnNlk4S25CRkpoaEYyQzF0NlBSdTJHcjBGRk1CbWhl?=
 =?utf-8?B?M21ub2ptV0M2UEZVY1pLamo3R3NMK21TWFVJMUVNQjZhdUh0TlBLWHU0NnZZ?=
 =?utf-8?B?dDc2LzR5ajQwQXdjeTBwU1VWT01maHcwektZVVp3NklNMTJlendqellKT0J2?=
 =?utf-8?B?aWpxSG9kWnVNMmw0K2N6bFRUVDBOYTQrOFIwWkkyZ3JBQWZnZjgvMXN6UFBL?=
 =?utf-8?B?eHp2bUZlVkQ5YVl0UHdiTlBmbnQ5bCtWYjVPR3NHcUxmQjFvcEZTenlGZGR2?=
 =?utf-8?B?NXlLQUdiOENTN1AzY1RWcGpsNlhjREh1Y2pKaVVIZ1NrZ21OanpqWVZDRy8y?=
 =?utf-8?B?Rjh5eGpSdXE5Y0RSV2x5eHBFRVpwMGpTNzdTWGdHNzdlN2V2NGNITFQrUXBN?=
 =?utf-8?B?SGcyZDBuWWJ6VUlCaHlFNCt0eE52ejQ5ZHNYUXZDbDl0L0MxTzdkOTdDb0tw?=
 =?utf-8?B?VXVaVVVSL0RqaG9qYm9FZFgwcnRMSjdsMmlFN3o0aHJ5T3hiY3pVUUJqQytB?=
 =?utf-8?B?a1Y5Z1R1aGZqT3ptK2xsY09SdmhmZjdxcjF4M1lXWlZiWWQ1Nk5zNVpFUHVD?=
 =?utf-8?B?SzF6bk9wVzBGVmh0dllvTmxLekFUeklsZW51TnE3Z3cwVHpqdW0xSk9zN0Fn?=
 =?utf-8?B?Vzc4NUtES25LOWE5YXZqbC9wOE8vUVJMUEtFSXMxeE9MSUxDSUhORzVxbytm?=
 =?utf-8?B?Y2Q4Z0o4T0FmakhCOTQxYXNkK3hXdmRKQmlkVEJENi9LdHZ3UHZqS056Uzh4?=
 =?utf-8?B?eDZ5Y1RNVVp2aUgzRHdBMmJ0NGVTcXFSUTRLbFpWV2cyakErRVh6ajlqSS9I?=
 =?utf-8?B?MW5meWVyTFJsamtuemloT2xlc2V5TngyRjQ4QW1LMU52RmhjVjlBRnBPZ01V?=
 =?utf-8?B?ZlY4czloeC9vNktIMHlLNTcvcFIyN2RQTjdIODVINUxaVTJjRXYxVWtPTnhM?=
 =?utf-8?B?SU9tRGJ1Vi8vcFR0NUdhL0w3Sk9LREFOU2hPS0xXM2dxOEtWNTVOc01VTzBR?=
 =?utf-8?B?TURPakxJeWp6RE5SM2lFUTd5KzJ5VjNlQ0duVHZRZ0JpcENHSVdtNzhpY0c2?=
 =?utf-8?B?elQ1bjNFMDlVQ1B1WEZocUtzSGs1SEIyOFZLUmJzRU83QkdXTnNERytHUXZm?=
 =?utf-8?B?S2F1QWhzcXJUN21JQzBsZ2xJb3gyTkJFb1RqWHVlMFJXS1hZMXBocUcxNlVE?=
 =?utf-8?B?eTJ2WWVmS2Y3WW16QmhLaThTZmlxYm1WbTRHRnBkUm5zQ1ZOMHpqQmdtTUdK?=
 =?utf-8?B?MjdtWUdBeVMrMzNrZUhKMCtKVVM2NUIrN3IydVN5OHkrRUF3dmQ4aHJoT3Mv?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffd40e6-eab3-4bb1-53bf-08dbfb66d095
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 23:05:21.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQpHa3RuVV+ZY1RSyfU9vMRFUD90u6JvKW4wc6fiTllk8t7vvSkvulu30YAJOhMUvvYAqBavmihRApw684UmMrbzoeRnQdsMA5tSwImeVJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7533
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2023 1:28 PM, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 10:59:27 +0800 Kunwu Chan wrote:
>> kasprintf() returns a pointer to dynamically allocated memory
>> which can be NULL upon failure.
>>
>> Fixes: 1978d3ead82c ("intel: fix string truncation warnings")
> 
> No need for the allocation here, print to a buffer on the stack.

Sure, but I think that just takes us full circle back to where we
started. reverting this to the previous code will add back W=1 warnings.

The whole point of the commit mentioned above was to get a reasonable
implementation that won't cause string truncation warnings. Is there
some trick I don't know about to get an allocation which will not
trigger snprintf and friends to print warnings from -Wformat-truncation

> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1425:60: warning: ‘%s’ directive output may be truncated writing 4 bytes into a region of size between 1 and 11 [-Wformat-truncation=]
> drivers/net/ethernet/intel/iavf/iavf_virtchnl.c:1425:17: note: ‘snprintf’ output between 7 and 17 bytes into a destination of size 13

However the original warnings were for "%s" in strings. There should be
a good way, but I don't know it so could use some help.

-Jesse

