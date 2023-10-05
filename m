Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4607BA286
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbjJEPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjJEPjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:39:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B2B18B84;
        Thu,  5 Oct 2023 07:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696517682; x=1728053682;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ciS2waSTqfP+6kmO0mFgAXS7oOoqFoefKmKGEKTneEI=;
  b=QakWkibFvj7fLmRt03OXJIxYvG/pfPs6Qh68Jfmtt9Wk795f5athRuN0
   iaz5w8ZvSBN+ZfQ6MjE8tZxbKUQR/nHeI/OnUrXy/aqj58vFQwoLQThs1
   /9//j1A4VozbjinNPbisQF0QjVnyVdkmN40t9UsAI+nAQjIRI8dcnkC8q
   dxb1jUtFk+X+kUZhlFSGG0C3MspTUCkSwJ76TNkFyc8DFvAgRzSpKsMpw
   K+JAX9tlg94YiEM2RSIRBYYe9bCvmx8lbzoVqXVgrhwOyigNpst6+cZC1
   2soWIJsfxhdMDFmYvbwfHOdPuDJvT837ol+aJZ9ctsVqGxj7FiYZVvrqp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="383420118"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="383420118"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 07:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="1083061743"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="1083061743"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 07:54:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 07:54:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 07:54:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 07:54:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KgAmXd3OorcIF5DNcXKg5s8vleW0FO59uK5EhHYRAjRzvbEYAouWYSRSyvJji9FxC9EpUguX3df9L0xmHm+7gJMlx6dkgcu8Zk7GsQD0ajPlWkMpkir5J/Kcd2REA3Zk9ApEoyFpJBykuR2o6MfXM8D6dfLo8tvOaeUemxd38EJK7UEKAtvmjBKswP+Zms0GoQwUH1G2s3ljGaxdY9rnp9ZPAxQ0SiE+aumPRSAlcaC0dbJwuTXjGsSaEC4K9oVEaED3OhfvkRYcXnUl/L/5NtymCSoo0sETeZ/0Q1sJrsD70uIK0PBNlSy5nILkYymtR2LNDP3O6OH86oFB9r5TEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrN28j2y711/q1Otf31VgzInls4SRBl5NJGN6hoqizY=;
 b=A839zl82dh0/L2TfHQvD2X7vBJMpKLKMQSe0CU0akmfw07UJVVEIgdZr+DGTkLR93U2BSuKk2LOyL3fN0zSLC6h5wjRF2sUS74tQ/gKsscgqhRw8D8jmmdL9QZMeSBOeTQQEaWRmwysz3JW+9jGUtOt4NEYeETmjil9vFNotqBXKeC1lCQ1FkedXVxKCLypCRnhrfwlHINiyftOFGLVgcwrhRLTiXWyT57K7tcos/pmE3CVGQ+fh6ZXsjXFSk2il8TA8B1KfGYnt5POuF4zVBdSMSxJh4+8EttYJJOLelIXEvtMivBDgF3TigxrdIbddTX15/z6Kq7gkOx17jgZ6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Thu, 5 Oct
 2023 14:54:36 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 5 Oct 2023
 14:54:35 +0000
Message-ID: <984bcd4d-627e-7d26-2a50-73607ea0eecd@intel.com>
Date:   Thu, 5 Oct 2023 16:53:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] net: dsa: lan9303: replace deprecated strncpy with memcpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <20231005-strncpy-drivers-net-dsa-lan9303-core-c-v1-1-5a66c538147e@google.com>
 <202310041959.727EB5ED@keescook> <202310042201.7B14CA59@keescook>
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <202310042201.7B14CA59@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0272.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::12) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c86b7ee-0720-4706-7f70-08dbc5b2fdad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrmFIsawdQujU/Ra3bUn0P6I5/erN3s6DHs0ZN8D4QAccwtLeIQdwNL6qGRyxkH+0NJlcE0F/4YlHxcDLTtQJYPrWPnXLNjejmTiWA8PVaXCriXrslcGjBt87OROHzGh+yTuU3StsS6Tk1r8WtJNjw6OqcjJuTOg1x5ezWbIswrtAigfZkLm2gvhqjhZbnrMx4oot5P0DvDUvP7Q35jcFH/cn4CoVrdwjiOUCytku7H6P3ErIpfp/ED0xGu92ZK7WZIsYNWQHW1nmHG5jjarAiwkAQOstiBI3qlk4Y2LtsvZlKQRA7i9nOW4Su5OJnyKglagHbDrZgVNvL6Iqf51NzTwNiw84qLSvzvCluLLcV298Z/zYJNFTfjjBI3H28IScczff9qNbt/Ah+6CqtiDjmJTk9rK1kNGLniWvNdAqibo0yTcRuf4VDuxtrUK+jQbxlP4qZwYEg7mrI0rtMW1xXDTeewcVfotP/rpNei4XAMnFldVvSDgHzxWZBtFPsxsXAn9iVTs4DyrV410sKCEgFA72QZ1pgbvn5gN9X92VUUpB28vweiIF0XgaflyW1lvP8qcP4hhyrJhvmBcfpM0kAd2+ddoEO24e+MUb5xv64Un6dzO1AHpF74/+UYtdiyBRrtI0WU0r/XOCDU6pxl24TnU5wiiy3HEDk4cNywP17k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(7416002)(5660300002)(8676002)(31686004)(2906002)(4326008)(8936002)(41300700001)(54906003)(316002)(66946007)(66476007)(66556008)(110136005)(26005)(6666004)(6506007)(36756003)(2616005)(6512007)(82960400001)(83380400001)(38100700002)(86362001)(31696002)(478600001)(966005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amF3cGc0bDJxbXRxaGs2eUlLVUl0cGlSbDI2N0hWSHRzU3BWenkxMFR5Wnkx?=
 =?utf-8?B?TXNVRW1Eb2cwZHJGNngyN3J4WDMwbDFZWk9TaVFOVy9Pak5SVkRXMkxJRFJV?=
 =?utf-8?B?dnNDTEg0OWU4V3BRb1pkRnRzcDZLWkJqLzJ0UVFuRlVscHlhamw5RG1JczZE?=
 =?utf-8?B?RXNOMGhQTmdNRC9ORENDQ0R4T2k2N0VqS3dBU0JYQzduS2FuckJnMFBZS2s5?=
 =?utf-8?B?TGNiYy9UeGdnWlMyZDVvUVdEVWZML1ltcjlUNmdVL1ZndGMzbzFpL1lqcVNS?=
 =?utf-8?B?cGhJVzFjLzUvY1BIdHV5WGNNdDFEbnNpbkJZeXkrbzZZYzN3Zm0xUkN4VUwy?=
 =?utf-8?B?cmk2SXNxTUJoN1FhNkg2bElISkFDTm14ZkEySjY0UGdtUEtvSzkyOExUbFBx?=
 =?utf-8?B?Z1BXcGdZUHE1WDdjOS9raEQ3UnFDd3hOOWFuOW54dlBKTk0zbDNhczBSdGdF?=
 =?utf-8?B?d1J1eVZLU0xJb3pCbmJydDN6TUFVK2hhWkVEVktiZm9wcWQrOWhOUnVzT1ZE?=
 =?utf-8?B?UkV4WTZBRU9SVHhEL0FlYndOMmZxYXl1ME9BWExlRXIwN2x4T3NCbVlqUmhZ?=
 =?utf-8?B?V01NUzJMRTh1M09LNk5aL0dnSGJJbUhpT2dnZ2pkM3pwdCsxSGRFSjVaWU1y?=
 =?utf-8?B?SzBoQ2ptY3JLendMbEJhQTduVEVPUWJBd1dOZVN1U1dKWkRJQVpCMVpSQjFF?=
 =?utf-8?B?eWUvWGdnSmNVTGRXZStYMmplMjY1a2pIaHBWN0IrSE9RMG4wUEN5LzVwVjhq?=
 =?utf-8?B?RWhGWjh5OVNVaTlNN0xXV1BOdm5na0FNaHpETVR2a01MY1R5VlphRWZsWXlB?=
 =?utf-8?B?dWJodGdJeElDbzRFNit5QXQ0djhQSGNSdk5iRmxXalFEZ3VBNWJCS1VWMXhS?=
 =?utf-8?B?b1hoVndSN3JZMlQ5VWR5SGdMMWhiYWNhenJBS0FSdThDeWQzQWNKcmhadU8y?=
 =?utf-8?B?UFpYR1p3TkNYcmUrK2dBeDVZc2tJUEdmc0JGMjMrOHorYzJ3ZXREOVJ2M1N0?=
 =?utf-8?B?T0crejBoU1ZYdWgyOXpldFNBZTJJekdRMEdSVStVcEZwNDBwOVNKd285NWRh?=
 =?utf-8?B?Q1JLMTduaVV1NS81R1hlbzdQRkd4QlB1NzY3aHRpakdBU25hTGNvYlFzQzgw?=
 =?utf-8?B?WHBicUs3cUduWWNZamF5OHVWYmlSNG1udGhGclRlVUFBSjd6dVlJK2NGcEFQ?=
 =?utf-8?B?QXBXTzZXMEQyUStwSWJ6bFRxQm9oN2NyOTdMM3IzT3BuNWg5LzFPQmU0L0tC?=
 =?utf-8?B?ZFdoTmhWTEIzNGtIanhpaUd3d2pid2ozVnlXZ2tBcE1ReXorRkVucnJYY1lB?=
 =?utf-8?B?TXFjOWtPam1ialF4NzBNZVZTU0w0cFJ0RG41dXEyVjBqK1RQdlMveUZaaUlT?=
 =?utf-8?B?TThKb2hUK2FBN093cC9MY0JVNWhSVHJJZWVHYnJyM0p3QVY1UWpjM1NnNjJL?=
 =?utf-8?B?cVhENnFraUhGdUo2VVpoNXdmSk9kTGZTRExjMm02MG15QXJlbkl2UlB4U1Bh?=
 =?utf-8?B?NVZsYjlKV3hFdTZVVkdqTDU3NUdJZS82WHJhdnhIVEIxZk5mSmdsSkdDd3FD?=
 =?utf-8?B?Vi9lMU95dXZQaStSa3JaKzg0ZTluVnNBL2p5aUZWVmtEMnRyWGpna2dpdkRB?=
 =?utf-8?B?dkpGS2FkR285YXYyQWRYTUdzcUhKTW9oZGRwMEN6V1l2MThDZ1hod2Q3ZVlH?=
 =?utf-8?B?b1dqeStqWHBUazFnVkVHVE9Fb3pMcTZiM3hpczlNU0Z2bTJPbThicldpUkRG?=
 =?utf-8?B?OWRjRzdMOGtucXB4c2dYYTd5R0dvTG5mMUR5d1pQRHNBSlI0SGF0R3R1ckZH?=
 =?utf-8?B?ZGxaWWN3UVowcFAvV0N0a251V09pdkYvT2VjU0JvUUg4OU5rdS9YL3ZXYlpt?=
 =?utf-8?B?b1U5UEhpUW5mcEFOdGJIZ2ljUUp3UFpxMi9KSTlXVTBjaUVyMHhJVUliT2tk?=
 =?utf-8?B?NG9zVVEvMlRVc1RrcmdDWk5XZTQzOGo4dVFmckJYNU9lUlh0c3ZRaXFVbm9N?=
 =?utf-8?B?Y3ozdnh3S2JBUEY0MHpOSGhERHQ4OWFBNHh6dU53NTQyNWEzeHZBbzB6SC8z?=
 =?utf-8?B?V3o5UlJWYmJ1LzZVTUgvTW9UcTA3a2NLS2J6R2RVaVFSSGlENFhuWWxGOGVz?=
 =?utf-8?B?TkwzQXg0YkovdTNmYTk3dTgrSHl3aDlDOCtJNFdqdlMxYjQwaFFVYURmS2NQ?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c86b7ee-0720-4706-7f70-08dbc5b2fdad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 14:54:35.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vhOQxKjSxbHNc5BFpzRLzJ68nBT98vfBdz+ww//1CGJkIp8W8BSIAGaUkR5qgyjQqu7VuWIizr4WOPYkX7C8NcBw5AH0pY7k9Zg1sruQEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Oct 2023 22:02:00 -0700

> On Wed, Oct 04, 2023 at 08:07:55PM -0700, Kees Cook wrote:
>> On Thu, Oct 05, 2023 at 12:30:18AM +0000, Justin Stitt wrote:
>>> `strncpy` is deprecated for use on NUL-terminated destination strings
>>> [1] and as such we should prefer more robust and less ambiguous
>>> interfaces.
>>>
>>> Let's opt for memcpy as we are copying strings into slices of length
>>> `ETH_GSTRING_LEN` within the `data` buffer. Other similar get_strings()
>>> implementations [2] [3] use memcpy().
>>>
>>> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
>>> Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.c#L167 [2]
>>> Link: https://elixir.bootlin.com/linux/v6.3/source/drivers/infiniband/ulp/ipoib/ipoib_ethtool.c#L137 [3]
>>> Link: https://github.com/KSPP/linux/issues/90
>>> Cc: linux-hardening@vger.kernel.org
>>> Signed-off-by: Justin Stitt <justinstitt@google.com>
>>> ---
>>> Note: build-tested only.
>>> ---
>>>  drivers/net/dsa/lan9303-core.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/net/dsa/lan9303-core.c b/drivers/net/dsa/lan9303-core.c
>>> index ee67adeb2cdb..665d69384b62 100644
>>> --- a/drivers/net/dsa/lan9303-core.c
>>> +++ b/drivers/net/dsa/lan9303-core.c
>>> @@ -1013,8 +1013,8 @@ static void lan9303_get_strings(struct dsa_switch *ds, int port,
>>>  		return;
>>>  
>>>  	for (u = 0; u < ARRAY_SIZE(lan9303_mib); u++) {
>>> -		strncpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
>>> -			ETH_GSTRING_LEN);
>>> +		memcpy(data + u * ETH_GSTRING_LEN, lan9303_mib[u].name,
>>> +		       ETH_GSTRING_LEN);
>>
>> This won't work because lan9303_mib entries aren't ETH_GSTRING_LEN-long
>> strings; they're string pointers:
>>
>> static const struct lan9303_mib_desc lan9303_mib[] = {
>>         { .offset = LAN9303_MAC_RX_BRDCST_CNT_0, .name = "RxBroad", },
>>
>> So this really does need a strcpy-family function.
>>
>> And, I think the vnic_gstrings_stats and ipoib_gstrings_stats examples
>> are actually buggy -- they're copying junk into userspace...
>>
>> I am reminded of this patch, which correctly uses strscpy_pad():
>> https://lore.kernel.org/lkml/20230718-net-dsa-strncpy-v1-1-e84664747713@google.com/
>>
>> I think you want to do the same here, and use strscpy_pad(). And perhaps
>> send some fixes for the other memcpy() users?
> 
> Meh, I think it's not worth fixing the memcpy() users of this. This
> buggy pattern is very common, it seems:
> 
> $ git grep 'data.*ETH_GSTRING_LEN' | grep memcpy | wc -l
> 47

We have ethtool_sprintf() precisely for the sake of filling the Ethtool
statistics names.

BTW this weird pattern "let's make the array of our stats names of fixed
width (ETH_GSTRING_LEN), so that we could use memcpy() instead of
strcpy()" was pretty common some time ago, no idea why, as it wastes
memory for tons of \0 padding and provokes issues like the one you
noticed here.

> 

Thanks,
Olek
