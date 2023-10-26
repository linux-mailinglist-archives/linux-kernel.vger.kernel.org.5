Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085FB7D7FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344648AbjJZJmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjJZJmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:42:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC0193;
        Thu, 26 Oct 2023 02:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LywyxE01fiEJkGDqjVNR92GmUbkgtkIe3FuER3jCbo1sn6MkJxPNzPLT3Aflb3XOEXZKp9JHpfiZqukmOnQMnl8t5Pv68J00gVc0s5V51CSDARyP6aNCAf7IHpXtLdEv7Vs+nnZubQ5dnK4Rzs9fAN3ZPc3iyKFxqCoQg6EmCTl5npU4k92+LK0P5fgv2u79SUcFWcv+YoFBHqS5ShiwkOaNjXLzOtRdiYINC8Jo3LKwLPWOdQTxknXk1JU8YxHJId62qkMemycCjv8Ad1+TfK6uyujjEX/O3F8Sx7Am9M32wiBWlG/mUX+DjqTdYPizbnGNFqmXJzO9YIeiFReJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx339yV9VKTNlA4VWh4k7ZTgLvfzrqCVENvZBBSgiRo=;
 b=imswy8TmPqGIVE+jeecxbS0krsmiI2TIw9gUSpS6447ek3gKDXuYI4f5HC2Wy/hDEz3m0TR4uGdkMpXyVSEdigshobyHMYQ4PxurMU8gVv05L+8ldH9zacuLdNNWN5oww1QmecA4D0Il2prBmR6iRlz9mNIrsdAVO/2eGLLaet4C9EdWZpqvIeWaojWI1Ecf7qKzTrgne3ewJe96WIYNT2YIL01Gy8IZ1A5vwCK8acQw0i1B8BN1+Xtzw+0HbFSQJLsV9ST6wmQJHWoR2LpS3MdAF0GGLLCVarLz9lA15sp760I9purknfx+QtrfqUmzrlD8Ks/KKqVTLHJBAd9TNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx339yV9VKTNlA4VWh4k7ZTgLvfzrqCVENvZBBSgiRo=;
 b=jcvcUECWAekoQiPGdCiCOLRG3nAYVqZeeeeUMs/69AB1M420J5ZnN3+u2e52+7xwM4JiTc7DZ/EOfiKEDOC7R/vFIWhGrwE+zY4mnEjqsVxUn/xpAOl1aiuyFMzK0r3RrMMFJJofyOYWB43dTXrjpNATrmg0O1pSHc9y4j2c83w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 by PH7PR12MB9204.namprd12.prod.outlook.com (2603:10b6:510:2e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 09:42:32 +0000
Received: from PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48]) by PH8PR12MB7325.namprd12.prod.outlook.com
 ([fe80::bd00:6f1a:9bd5:3b48%6]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:42:31 +0000
Message-ID: <b3b21eaa-226f-e78f-14e3-09e2e02e38d6@amd.com>
Date:   Thu, 26 Oct 2023 15:12:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
 <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
From:   "M K, Muralidhara" <muralimk@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
In-Reply-To: <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To PH8PR12MB7325.namprd12.prod.outlook.com
 (2603:10b6:510:217::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7325:EE_|PH7PR12MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ac6d17-c39e-4ee9-f2e9-08dbd607dfca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OncLR0zOVsDTwBe3SqbWTqh9HJiKbqGSU9E/Wo4LkqsQsL15GPX0bRektgHg8eQ/YzwwtP1HFvhFMu17ZHoi/+TB8CFnl0JRLV/l7BJf0Ou4BlOY+GRtS8fnm3FbMUrKNvgFIIA85qAtNEg/sNdqv+nXFklP5TJaVbEDkBnOY8koJOu2eAdC6A3gE7uvCV86/lY7mvnWuLYV9fRov0DB2yvXppLCpPjxK6Qjh8M+mv6b13dbYDXV+e+wF6t6LfbxSRK+XB/+V+OjhPV3NpGH3Nnanm8xL3hVqE3su+Z5Bp/16O+6nHUkvYFFhWS5KXq0I5ZfijV3gld9lS23jvQqyINjapKoMLIQsBhBIoLj/ddWmiHoUzABBqFwsblL7HmfOrCAag3Ugfbu/oh5K0jitsrM7jAIV4YIPpc+mytDcw6uji1H/qJX99YtGYAFUj1lIObix/fiWl51cwqnKiLlZHebRrfZ1GFGwjSxqjFsuR0uPyO9sj0Kfn/G68PUBoetX8uMj3rrzdJ+lYHAwZjVD5l9i6avs+6ucu0wPWvc7ye5A9tRyGXCUr0IL6/Bwm77oDabXD+46WtFvXLy4PuK94LQ6HH9uwLBVlEy7ud6Pdus+pgEmZPtsPcmyted2v/3eYAzpPErhaC0idc7q9oZ7IoUeixvH+JcCLp+5TMD4dT8r6sx5EeHCE7xq256Xhyi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7325.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(54906003)(6512007)(2616005)(41300700001)(26005)(6506007)(6666004)(53546011)(83380400001)(8676002)(4326008)(966005)(6486002)(4001150100001)(2906002)(8936002)(478600001)(5660300002)(316002)(66556008)(38100700002)(66476007)(66946007)(6916009)(31696002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elArUkFiRElGbWt5dGRxRkVHUWFBSkt3RWdYZUQ4TG9UYkNWWElnNDdwRnpu?=
 =?utf-8?B?cm9sZHZURjBGY3lCVDdXK3EvTDA5dmYwYkt5ZGUyRTdjbU1MNDVIQWVpZGtz?=
 =?utf-8?B?SU1VaU9SZmFQVDBSMEZLR25aUzRJOUcrb1VPZHNZTGxVNXhVU2liV244dG5m?=
 =?utf-8?B?YStIZkl5MzRqZ2s5cTNjQUZvbHVyM1FONktkZFNqaHRnbUExZlNqbjk5Q3RJ?=
 =?utf-8?B?R090elVwbnc0emI5OWhpT2dBODhuaUhiRHBaOCsvanBGL2liaW5PTXZuVmJ4?=
 =?utf-8?B?S2puYUt0dm52bnM5UmlHNEhxL29vcVl0Z1E4ZDlNRk5adU52bmQzaHZmQ2h4?=
 =?utf-8?B?aGR3Ym1HTkNydDZlS0Fnc2RnWndXa3UzOGNNbUdBMDMyTzdLYkZ5bC84dWlN?=
 =?utf-8?B?QjFKcGFhRk9oUENaRVZRS05CbFlhRzlWaVdJRmxjLzV2L0ZudUFLeHZobGdw?=
 =?utf-8?B?VEhIRGptNVlZWjlCN0tBZStveUtrY3huRnp0ajF2eHVCakNuSFpoTTA5MUta?=
 =?utf-8?B?dzkrTjRhanloRFNnNE9mYy9jbHBZSktnb0c1cVJ6RUxRR0xNOFBYbnhIaEdt?=
 =?utf-8?B?RFVKS0FLTGVyNXlwYUJWeWl6Q2FHY3Z3aTMzTkk2ZzI2OHhMcGNiRmpVR3Nr?=
 =?utf-8?B?Zy9WK29DZlhOZXV5V3ZrNDZHc0VSb0FveFFxR2daVHZHbUtoaXBNakJnMThG?=
 =?utf-8?B?dXRQR09WTFZjcXk1YksrSCtmRnk1bUxYdTQ4U2VGdUREMVZpbHRONGVybE9w?=
 =?utf-8?B?N1doekpwaGovZGlSR3pvRW5NYXJmWDl1WWdWK0dTM2NjMU5FNmRlRTAwWnZw?=
 =?utf-8?B?Zm1WTmcydnZENTV3bjRIY0xTd0w2NUVtd1BpRGJ2VjhFOUFYVDhlR0lQUGc4?=
 =?utf-8?B?cmZTc0NGY0JmN3R2enU4TU5ZelNkeWl4di80ZFhZNmdyVFp6NlppL0s0SVdO?=
 =?utf-8?B?cHBUdWN5cFpoNjlKbW1IRTJhaFAwK2RCUmMwalVhczJEZmJkbHdpZE5qOE9z?=
 =?utf-8?B?cE9Bajd6dUNicFNkNEhoZ3YrY2xPMlFYYXZkUVk0NUNnbW4zWGJJcTJTRzVq?=
 =?utf-8?B?NlE0MUhpOGdaY3R0THZRcVZmNFhZS3phT3F5c3dwOXZSc2RnaGRpUlVIcEpF?=
 =?utf-8?B?T0tDVnA5clJHSnBZd3hIbml0Y1FHTG1qOSt0WGt4ZUQ3bEY1N2Iwb0R3SW5K?=
 =?utf-8?B?Q2RlSTI3SWp0OWRLUEJqZFFKQ2hrUHZnc3picWprMXd4QmljdjBiVmhWbmda?=
 =?utf-8?B?V25mQzNldkVmZC9EMlRVUGkvOVhNc2QzZHk2Y3U1ZTRIMnVETHhtallTK3Vz?=
 =?utf-8?B?VzFYNzR6MHNZU1Y0TVoxQ0NFZnBvREF2WStidU80cXNabDR3dlBsekp3Ymxo?=
 =?utf-8?B?eEo0MHFiOGZwTCttZ1NKVHJzZU5Gb2ZKMUhxOUZYTGpleERSZDVhb2VpbzFl?=
 =?utf-8?B?SlRpQm9KNzVLQkV3WjhSU0JEWWtQTGNWQ3FYQ280SlhGOVZ1RkV1VmdrSlln?=
 =?utf-8?B?NnlZUHFDbDZURUhMVGtmRHhGM2RaWDNuek5COVJ6VFlaSkJrZzJDY2ZDWDd5?=
 =?utf-8?B?NE0vRmZVSDkrbXBaNllXRWJTMk1Xa2Z4WTBHTjZ6bSt6eXRxQkxYMTNBUWpn?=
 =?utf-8?B?L1Jmang1WGhLQSt1TTZSL3ovSnYvNElZeTNzbTNFbk8waVFLL2h6TUkxTk1M?=
 =?utf-8?B?UE52QmFZQk9zdHJEMDRuaW14YnBSWHNPeWJHSlJhdVZLQ2h6b3U4L1RXM0JP?=
 =?utf-8?B?U1F4R2JVZEF4SlNFMzg4aU5FejNkL0FpSU41RXdBMEllNVlPTDFzL3UwUkls?=
 =?utf-8?B?V1AySHo0MXhXajZpSng0MCtmN3hiTmpWTUt4c3pkcy82bzY0RURwd0V6VGNw?=
 =?utf-8?B?VXdNTGtpclBJWHU1UnZBN1V0WnErUExNUW1SS3VLUW9xcStyUEpKbXQyWVEy?=
 =?utf-8?B?a2lCRUZ6TDdHeWVFOFNEbG9WMWZVYkdqSVYzbUw5dVEwSUJrWVR6UXAraHJH?=
 =?utf-8?B?ZjdFSWFtS3lXK3MxaURZZk1qTjBRSHhGNGVIQVFBUko5SFIrZFpKRUVVbE95?=
 =?utf-8?B?ZjZ0QWRHemZUdU00Vk1tdjR2THBxVFpyVDR0M0thUVcyM08xQ2pZVTBseWVW?=
 =?utf-8?Q?JkuhAtwbYJtFPU84ntdECGw+n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ac6d17-c39e-4ee9-f2e9-08dbd607dfca
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7325.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:42:31.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEfSdFHrqYXaw+koxEisajMX/nezefl8z6SNY1rAmOcqNQOI1GRg+XkRPMYiMfmewLTSUS+RT1pjYNf1/XM/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9204
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 10/26/2023 12:38 AM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Wed, Oct 25, 2023 at 05:14:52AM +0000, Muralidhara M K wrote:
>> The SMCA error decoding already exists in rasdaemon and future bank decoding
>> is supported from below patches merged in rasdaemon.
>> https://github.com/mchehab/rasdaemon/commit/1f74a59ee33b7448b00d7ba13d5ecd4918b9853c rasdaemon: Add new MA_LLC, USR_DP, and USR_CP bank types
>> https://github.com/mchehab/rasdaemon/commit/2d15882a0cbfce0b905039bebc811ac8311cd739 rasdaemon: Handle reassigned bit definitions for UMC bank
>>
> 
> I'm still missing here the exact steps a user needs to do in order to
> decode such an error.
> 
> Please inject an error, catch the error message and show me how one is
> supposed to decode it with rasdaemon in case the daemon is not running
> while the error happens or the error is fatal and the machine doesn't
> even get to run userspace.
> 
> If that is not possible with rasdaemon yet, then this patch should not
> remove the error descriptions but limit them only to the families for
> which they're valid.
> 
> Bottom line is, I don't want to have the situation mcelog is in where
> decoding errors with it is a total disaster.
> 
> IOW, I'd like error decoding on AMD to always work and be trivially easy
> to do.
> 

I have injected error, dmesg log below

[ 3991.560180] mce: [Hardware Error]: Machine check events logged
[ 3991.560195] [Hardware Error]: Corrected error, no action required.
[ 3991.567119] [Hardware Error]: CPU:2 (19:90:0) 
MC25_STATUS[Over|CE|MiscV|AddrV|-|-|SyndV|CECC|-|-|-]: 0xdc2040000000011b
[ 3991.579205] [Hardware Error]: Error Addr: 0x0000000000000040
[ 3991.585546] [Hardware Error]: PPIN: 0xabcdef0000000000
[ 3991.591302] [Hardware Error]: IPID: 0x0000009600792f00, Syndrome: 
0x000000000a000000
[ 3991.599977] [Hardware Error]: Unified Memory Controller Ext. Error 
Code: 0
[ 3991.599985] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD

 From above logs, "Ext. Error Code: 0"  here we are printing only the 
error code and from this patch error strings have been removed.
User can refer the PPR to check what the error code refers to.
or rasdaemon tool can print the respective error string for particular 
error code.



Executed rasdaemon:

rasdaemon: Listening to events for cpus 0 to 191
            <...>-1420  [002] ....     0.000399 mce_record 2023-10-26 
04:28:37 -0500 Unified Memory Controller (bank=25), status= 
dc2040000000011b, Corrected error, no action required., 
mci=Error_overflow CECC, mca=DRAM On Die ECC error. Ext Err Code: 0 
Memory Error 'mem-tx: generic read, tx: generic, level: L3/generic', 
memory_die_id=0, cpu_type= AMD Scalable MCA, cpu= 2, socketid= 0, misc= 
d01a000201000000, addr= 40, synd= a000000, ipid= 9600792f00, 
mcgstatus=0, mcgcap= 140, apicid= 4

 From logs,  We can see "DRAM On Die ECC error" which is for Ext Err Code: 0
So, in rasdaemon Error strings are maintained.


> Thx.
> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
