Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB27BEA81
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378378AbjJITWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378353AbjJITWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:22:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F66FA4;
        Mon,  9 Oct 2023 12:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TydONan9Vs9MJzZ53KOHVu91KMrb8wI+eYoRcOBTJALpt+LLlmYfcacove1LLcSv6ajWtXdiFAyta7UKfRRX6JiclCLud1DnCmghdg0HIqPUwjJVL+mfHOQ5TifLAUfVRnMqR+imU7eOCvTt4+KvO0wUve/gbGillIXFckgMcwqpKsp//TwWFMjO3U9UpQxE8dqalQf3pay0R5l1lq0Q59Pyv3a3FdZ0mcSuMS9kfq2TV9EhPzpP3tF9k3FSI7CnWusLmJlrb7bxaN8RyTX/LBpTpKdgx5H27cYtGoiO4JmAR0+YksRvvATcrc8u1iqbC/GZZU8ULBmaL79ognJ1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IljLGt5CaoHTYbHaiJLnjhIonxIfNtcyqIHgYlyyTBA=;
 b=m08t6a06YbtpuQUL5c5FvPV2c7WvFdUT3EI4W23/ZeexNp4yyGp+ir1dQtnQkcORozsO0W3iFDrBU7hxktX23LX15U7KqC0Fzn0qQlvCldfiFuAWW/37Tb6tZhm9oee2XLgtvan5gp8+1Pt1c5Hg9taqakDk7sYjMC19h7XKu1YmZ71PAJn6ODTXm9OBNKXZKjKHVo43fz5bohIUakMEMMrmoa0FfM2vU0Qh32lFD04+grFqBJhTY+hAyptMDk3v8DAmYIIqXDdw71Ov2R67vAR0MIiQYkKFrXyZfREhau80hllnf4aLeBDk5VGBw8/SMVBYRVdXYodLFWHmBKddaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IljLGt5CaoHTYbHaiJLnjhIonxIfNtcyqIHgYlyyTBA=;
 b=wRNe5AZ71Igqyt0zbNX4L4jQQrfcvc0Y3Klkc5vNBqkCEUP5I77FcfUTXeHQVidLXLN1icf1hvJfZJoF4eBoZq6/sZGjNGySXWce+hcnJ3bKLxKcgoTOYC4k4Ye/7h0ChtdriBI1KVOdVtvsZUSCvH5I5l3IcJfhHdHfk23vbRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CH0PR12MB5170.namprd12.prod.outlook.com (2603:10b6:610:b9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 19:22:42 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 19:22:42 +0000
Message-ID: <82ff6a11-fe71-4be8-a088-88d10e7e5a61@amd.com>
Date:   Mon, 9 Oct 2023 14:22:38 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 03/10] x86/resctrl: Rename rftype flags for
 consistency
To:     Borislav Petkov <bp@alien8.de>
Cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231003235430.1231238-1-babu.moger@amd.com>
 <20231003235430.1231238-4-babu.moger@amd.com>
 <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20231009171918.GPZSQ2Frs/qp129wsP@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0121.namprd13.prod.outlook.com
 (2603:10b6:806:27::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|CH0PR12MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 01e58e1a-fc09-49bc-822f-08dbc8fd1be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kqPAOflkwErLhLUaKTn+Xn0Ey6fsOqIniiS9BIHePQyBk5KxyFQhAiNuaSD3YowTHwCzXEG+1HWI9Frvd2hKzyNbBmtZWpsshSDZBdaQKiS4NiK5thyD0wYxyIcRfr3VBP9vdBV4DMU6KqLgN4+uO6RZfXhhH40CZsBZhnktKVrP9VMxX1W40sPzL6yKUbA5iwXcYb0d9iJJpA3Tl3KKA4aeXcJB8WznC6yNgc98Ev+fUz6MQSdyACGo4HUGFXsU4riNxH4Y8GIYlQuRWuZAf3O0C80KpAc4BD4UbDx5HQ7TXvAbrW49H/LUE8phVxSLk9sTE/wADu+P2HopONNX9Kg0MQrCauaym/FNQVT2k5l4vm5yQeim7zmZr/T0D9yLpM32ay0FpP+e17lTJv6/jqZbto2GVPS+XGWqJWGxKo7LLaKKzWDpooCP9VBplE7hZ4Dm9gUfiWHpEflCjoJSlFFrjA9Kss6hAA5gFS7qVYqr4/ZvJvOgqCCU9x2Wcf9PZi2864wc2oQvM84L4SFvzJRhJ146ph44cG0kN8UBgMaoJ3KyTJ5Yhelg7tvYM5hBsGjx3NPa/ODg51UTBvOaKDJkyQh8aU7GP+7HutBqTi7nHJN2/dKk0ULNWrGP90TUzTtGc/RuhHstWQV/qwzlgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2616005)(53546011)(26005)(478600001)(41300700001)(6666004)(66556008)(6512007)(7406005)(4744005)(8676002)(83380400001)(8936002)(3450700001)(7416002)(4326008)(2906002)(6506007)(66946007)(66476007)(6486002)(5660300002)(316002)(6916009)(38100700002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJ6TnM3RzNlbW1qQmQya1dQVlVJV3pFS2ZXNkdpNlp6Slc4L2FxdU9mdjBu?=
 =?utf-8?B?czhLWHhURlg2S1FmMkhvQ2Z2TnlHY1JCOXpGdEdBTzdZWG1RU09HUU4wSzFD?=
 =?utf-8?B?WkUvVHcrM1hqQlphVDl4QzZSLzdRWUVmWC93M1RMZThRd2s3TGxqdWpMRlBI?=
 =?utf-8?B?b1NMalErbFd4ZFUzeC9zcUhoMVVua21TbGVFcDZGdktDSEsvMlZ0M1hYbWVs?=
 =?utf-8?B?SjlrSzdIK3hsckh5UVpZZ05MbHlqcllpSDlLTDQ3dXp2SGgwZDIyUkU5Qm9W?=
 =?utf-8?B?aHNReHgrTzlOK1QrbG85MU4rZVIzTzVDVG9SQmVTRzNUTDZlS2J6ZDkrUlMv?=
 =?utf-8?B?Qy93RUYyajErdHJSWjVlbVpwdzRuU0xqeGVaTW81aEpYNkxVNUtVeFNDRmFY?=
 =?utf-8?B?MFExRUZuNXlENDdERXRCcDQ5UUkzSU5TdVFQZGo3VTlYWkFTeUlPNytYaVZB?=
 =?utf-8?B?L3QvSWFJMTJQMnBMVTlJUU1mWjVjOHpybGpmNnJjeFBoMC93TCtFeGpIZ3VB?=
 =?utf-8?B?VDAzZGdDclBGellFcGFybUgwUk83MDFBZ1FkOEY4S1ZaMUZKVXBpclZtekgw?=
 =?utf-8?B?U0NmSTlWSS9STDVFUjBhTnRRSWEydEsxeEthUjhGc0VCcmJRL2hOVFlRSklj?=
 =?utf-8?B?b0lFUHFNSm1MYU5Yc1RmandOeDJRS2ZJZDFwS0o4bDkrdlBIU25NU25ucCtr?=
 =?utf-8?B?QmFQOHM2OFN2eEpnZTRZd0VwSVFVN1RKejBnL0VFMHpHdWhMSGd2QWd4bTJN?=
 =?utf-8?B?TDA2WmRFWndVNE4yV1RUSExsVmg1SHJRc1lQN0phdmpiK3hCMlg4dWFsWlZY?=
 =?utf-8?B?OGprRE1nR24wdUF0eGU2MTlMdE95ZWNpYklmeVpZU09pY3IweG4vZG05THFZ?=
 =?utf-8?B?cjdHTFVUMzEvaXQyZ2RwR0dISXpXMm5zNDA4NjBaRTJVeUo5T3doZFQvSmxE?=
 =?utf-8?B?dU1oazB3c3FUNHJDdkY0RExOd3NGM0haU3ZRMDZSRVNCZTQzNDlpWFJWK1FF?=
 =?utf-8?B?eXlMNnZrRDJSQ05WZVgyelRGZllFaXRVejFUUTNQOWxmZDZkaVU0Q0VDQlBm?=
 =?utf-8?B?QkVsVjlZT252eHVaM2N3UTFKc3cwUFlZQnkzclViNVh1dXE3L3o4SWloZExP?=
 =?utf-8?B?czR0QWZVNC8yQzhPbWNrbFdzOHZ3WWl3S0JpWi9GTll2UytzbWhTdTJQZUVh?=
 =?utf-8?B?eUszMDNrNTJVR3BDTnpEOHFWRENtWUpxdy9vUG1zb2xkNW4yUzJNZGQvcWlB?=
 =?utf-8?B?TWhxeTRJODFFdm5yYnZuU0xjRlpFa2pEbHVVbnA4Y3M5M2xGQ3FCV2hScTNz?=
 =?utf-8?B?bVJxN2xkL2xTSzNpYmx2SWJRME1mdVFzL2ZoaHVpT3pqM3p6RW4vdVFnZmov?=
 =?utf-8?B?SHI1VElYcVk3aG0zODRUUTdlNkFnYXBSdzhab1VQMlZOYndRZzZhd1JSd0d1?=
 =?utf-8?B?MWFDdEdYVWF5eEtSaVFxdWIyTkE4TXFlVVBGMTdIZ2kvck1GVFhXNTZkbEFm?=
 =?utf-8?B?a0tGRnBMaUlqUUh2MEE0NkFsd0JLd0VGT084M3NSaU0reHkzcjVrTVlCVU9W?=
 =?utf-8?B?MER1SlEvUURwM0JDYUhEWXZGVitiNXN1a3JrTHp4L1psbGk1OWp2c0F6eDdv?=
 =?utf-8?B?eVdIUHVBQ3h0aWV5cURGQXIzbE1HZmhjbWIwTDNodzZFbFZQbUtBNGNYTkJn?=
 =?utf-8?B?TGNOY0FKSjJTUXFWNk9SV2kwaVpldy82Z0VZOWFCajZIU1BTOGJYVzhaVm5W?=
 =?utf-8?B?SHNHMFpBOE1zZktMWXNqcElCZndFVWlQN0RjbGlPaTZnaUZCQ2IyRXBoZG91?=
 =?utf-8?B?ZEYwM3VZdms1dFVPdXVQMTlvZlI4TnNqQkpRVy9YakFab25DejEzOUdRVjhn?=
 =?utf-8?B?MEtVc2FoTG5idjdGdTNmdmRWdVQyRjhub0lXQ29odXM5TmQ5WnpTcG5jcUpu?=
 =?utf-8?B?TlN1WDluQjVTNEY0ekVScXFwM3NiM0dqeVp3TmI1QTRjNzZ4K1czNWF0cXEr?=
 =?utf-8?B?Y2dIUVNOSjFJSWtWMjRSRnpNdVF5NU9oeUUxNGJSKzdKUVc2NS93WE5oQTVN?=
 =?utf-8?B?V2prL1YvTGU3MDEwWFdqZGs0R1I2R29PdDFxMzVxYW11RnBiNXNNb1FVZnAw?=
 =?utf-8?Q?xwgc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e58e1a-fc09-49bc-822f-08dbc8fd1be0
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 19:22:42.4688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PulKwonXbPBoeedrDj4+ZbZGwKeXpNTH7Ih0vwnz6gq/OM2rfarFNifAQKMc2nEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5170
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/9/23 12:19, Borislav Petkov wrote:
> On Tue, Oct 03, 2023 at 06:54:23PM -0500, Babu Moger wrote:
>> resctrl associates rftype flags with its files so that files can be chosen
>> based on the resource, whether it is info or base, and if it is control
>> or monitor type file. These flags use the RF_ as well as RFTYPE_ prefixes.
>>
>> Change the prefix to RFTYPE_ for all these flags to be consistent.
>>
>> Add RFTYPE_MON_BASE that will be used in a later patch. RFTYPE_MON_BASE
>> complements existing RFTYPE_CTRL_BASE and represents files
>> belonging to monitoring groups.
> 
> First of all, the concept of "later patch" has no meaning when the
> patches go into git, depending on the listing order.
> 
> Second, why isn't this define added in the patch that's using it?

Ok. Will move RFTYPE_MON_BASE patch 10. Will update the text accordingly.

> 
> A patch needs to be a logically separate, possibly self-contained
> change - remember that.
> 
> Thx.
> 

-- 
Thanks
Babu Moger
