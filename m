Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42567F41B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjKVJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjKVJc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:32:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB02D45
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GY3ZMrAShyah1gAKn4pNZfCnhLTPDUbCdh1jeICHwBThOLGQnmpFEiH8h9cmijw0zvgFiLUgcp3X5yeYS1YJC5tEnFNVuLOCsK7InEPxHIzwHxsJ40W2p0tfaqZHn+nD51aW8yJgFMUls5WPWzNu223xEWhxuM8JpB9SKfribNbA00RN/NgKR68SF3dgt19aY/jooovZ06eJGgPf4nt9nISqCAbu9S+XjY3g8JXUfBBMWYnINHy6gxaXrLpWJOjB8O06uwAEse2UuaOcJj7HtHbxsdErmqPcNS2/OzWWsMf31iTTmj75H6REmSvp41LRjxPsA/fMD4UJytmfrMH9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n7QNbAZSZ0p8wkXs+C/CiMSCIqSiCT4KvWl7wKKR3Y=;
 b=T9BO97B0P7KPz4AMrnPbuCV+kwqHhFPe/QUMMGpW6W1hm0GV20kDizRq/PXBOYy2TGbIlg3m97UwihJDmUgBpgGE+vNR7oz+oXSBl63Q/AZk9Bh7mWwsDjgj3lSnaoMnd8/ffNUkK6cR7pfNNrC5xqLpQiTArpfjCGQ4tWOHd8WBPIDkZkWHl5odMMkfOq0cH+SfFCI++Jnv/dd6rSrIQWPlBcKrI9493biA0feYb2f8ktXz8M57mKNwJglfPwxfmSFbQ61oUsgfodh13kytml9Kambz4UxuzIOC7Dq+2H5rWwIdmP+o1iacQ0gzcqS9TVFBHRLGVd1sA3KFOty8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n7QNbAZSZ0p8wkXs+C/CiMSCIqSiCT4KvWl7wKKR3Y=;
 b=kgta9LKhmoZvdvp2B3t3VmTh7BL7VPK+cRcwNGlj+w9ePgQKl8UU7zSdSF570s9m8iHl/GMaFDauzRhUAJNKDegm7gkbZkD6nD+XwIL7lpF4Lb4r0zr6nzz9dNRjpEWfmqxlqFzohi3eU5ciBi+6BWQ6fzHtzFoccQiVlbCtNSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by PH8PR12MB7349.namprd12.prod.outlook.com (2603:10b6:510:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 09:32:16 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 09:32:16 +0000
Message-ID: <6085d2e3-f28e-4d1d-9863-8275931430e6@amd.com>
Date:   Wed, 22 Nov 2023 15:02:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops support
 for acp pci driver"
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Marian Postevca <posteuca@mutex.one>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87a5v8szhc.fsf@mutex.one> <ZUQssoD2rUHSYQ2v@debian.me>
 <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
 <d002ad6f-d908-4cf6-afcf-bf0989418e72@leemhuis.info>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <d002ad6f-d908-4cf6-afcf-bf0989418e72@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::14) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|PH8PR12MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bacdad1-bacd-4d0b-a861-08dbeb3dea25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BrDZO9syV2pJe7LzlDYWutDDXyF7Kc/AHn6puLaHgFkOBcYYjOQANw3XZ4IDtCKzDE/u5aolINRFFv7PanG6BFzESfzlcANoJZ5nKBoNIx15P0AhW0vi0Li0KSrqbYRe/j6HygNTe1HXcCCfFCP6oxgt8Jx7J6n7LSBh4zqzfReG6yYwWfyyaP0JM5KYiadR8OW6w/SW16eX51I33xoiEleTpFbs42dgdP1vD5Gx7K6OLwDlv2r/k9bGEQnel7Iq9poIBdhWvxSd9nAYec6N54uuup7C1QTPdI8ruqsn0sAGq3599AgFthdKeGgw8QFmV2azExqs1ARwjuBv5ooUb9CLGTNomXDk+RlHTBfDX4sMdnk+hQjrzmtVj0xxhyn1KaAF0FlyT8smmIi/hvwVZOxf45Yb6DzP3IW8heCw4zl050MOz/2uTpy0ltRLYnXe6m9vd6sNVL3XdDkaiL3PON9jlXaHqn6m3nCGiWt9gGY9juObSiV2rBa2LkVwHTV1o9Xrho/8JDPBUWnIgJI1V3FYwSGPiJS498YyLSjr48abxUukXpvuvNX1iwV2Q3AkHowAAFu45e6OyTtfs4ttP3DA0aEheYT+51JW2PHq/fjVseKx9GKFR0FAwRIeQRihDv47b77ugGZM6SXPG0k2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(478600001)(36756003)(66946007)(66556008)(110136005)(66476007)(2616005)(38100700002)(6512007)(66899024)(6636002)(54906003)(316002)(966005)(6486002)(4326008)(53546011)(8676002)(8936002)(5660300002)(6506007)(6666004)(7416002)(31696002)(26005)(31686004)(2906002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXdVaC9hZ3lUZ1dDOS9UeVNNSUxlODBZaXVZTHFIOW5SM0NTNFUvcjBkaFRO?=
 =?utf-8?B?VFlLUWpPR3N1ZERqQkRwUVJHWXJtMjQrdUZGbFdsaCtUOUY0dGdyMldwRjJX?=
 =?utf-8?B?QnRaMWEyVG9pbTAvbFg0T1Vsd0dNMGVFdkJ4SlJ6OWFra0tJUzFRc3FtL29t?=
 =?utf-8?B?ckhYbVVRQmpvbjNUbVVFR05UaWVSSkxaYnhTaXd6QUVSMERzbEF0THhiMGcw?=
 =?utf-8?B?NnczSWc4SHo3NWpaQVVVWElSUkQyV2k5N3dvejcwbzd3dFhQTXJiVHBYME1i?=
 =?utf-8?B?Uy9NNFlQald2Z09uQjNoeTJSWjkwb20vMzRuWXZEMTIrWHlUZVFzaUpwUDRt?=
 =?utf-8?B?dXQvUWxKNGExb3pzOHVYOXp0ZHVpR2JsSzVrT2NIWU9QV0krbmtGQnpUZHcx?=
 =?utf-8?B?T0NWMnJ2ajZtN0s1MUJCekpaeURtSzVGSDltWVAzU3lOR1RuM1lzME1KVWNH?=
 =?utf-8?B?bkE4S1Z0djgyenBUc2pHYWhEamNRNjFjRW0xaVgzN0hsa2puaXBsNnBadGov?=
 =?utf-8?B?UHQ5QTl6dzBBVjdXa0ZEaE1INVFiaTBFL0JqcVlRSWNSM0hJQVg2K0RVUm9m?=
 =?utf-8?B?dHhWektSdXB3MEN0ZHRhcm84RkhwbEYweUQ2QUtiVmNxc1pHRWUreUIyWUV5?=
 =?utf-8?B?Z2xXN3hpaWZ6NDBmR1lzbTVoNitMSk14blhoWHJhakZ6WHZrNU84TmNjTVYw?=
 =?utf-8?B?dDR4NHpoZGRSVGx1MkxTQUgxUlE5QjR0aGV0eEpMV3FUTld4M2FTeHJWcHdO?=
 =?utf-8?B?TGY5V2FOM1hOZDhZRHprcjRHM25mR0dCbGFzdG9wM0NqWG1SMTZsYUFGcjBs?=
 =?utf-8?B?MXNHWkxFR0tzUkNNR1lQS2xTVXVwcDF2RW1Sc2xYalpRbE9Vdm1BVlM3ektx?=
 =?utf-8?B?T2xCZTk3QkxyMlgrbSs4MFpnZExBZ2VmQjVlWENIY3RWMDc3d2xkWjFPYmxJ?=
 =?utf-8?B?YWhoQXl4VDRISlN0NHFSYm9XaUZpTzdLNEtySkxsdUdKZWhOYkxmRVZqa1k2?=
 =?utf-8?B?MzF6VHRxN2Zic3N3ZlA0VlRZbGozejZzLzJuUmNQREdrQnlnQzZ6OUlWVVQ4?=
 =?utf-8?B?by8rY1BZVFBmUUh4T3AwbzJKWjZBWkVsRm95ZDJrQ1dQaFpPYW5LZUgwUGQ4?=
 =?utf-8?B?aG9tenYwZ2thbnYxWU8xQmFGWU5ZMHVLa2daTXo5OHdHSmxUdGsvMDdlRUlO?=
 =?utf-8?B?MTFZQU1ydGNvcE4xWEVEVkl5ZWZUSG5INjlzZHRkcXN3a200UXVKd2FvTFBy?=
 =?utf-8?B?OEdIVk50enQ4d3BlUi9nT2h4eUtLa1YzaCsvMEYyUm5GeFBuQWU1eWF6SUFG?=
 =?utf-8?B?S21NRXZ0OXM4RnNwdXBrVWtpWUpGR1loVHl3N2dKSVhXTUxYQWRQTEM2MWdS?=
 =?utf-8?B?MnlCTFd5bWhOQlhGR1Y3Z2c1WFFCSkY3S1FyNVB1K2daeVpnOGROQ2RUMW1M?=
 =?utf-8?B?MzNnL1J1bERVVnFnUHVPVXI2MFh6WWk2ZW5aMEVPYyt1YVgyeXQwK2gwV3Jy?=
 =?utf-8?B?NW85bWlSNXRLWXlVQ0haMVc2ZzloaGd0dTBMNkd2WmhPL1FUcjNDbHl1cVlZ?=
 =?utf-8?B?b1NxV2RzUGxWQXE2MkdRSUR6VVZBa2ZHWDZEcFd1UVBMeFdyRU4yR1lwWXZ1?=
 =?utf-8?B?WmtZQk55cUlzV1Z0RkNrdDVHV1dEVjZEQUxHMXhvdU9abDRUZHdSbzJORE9r?=
 =?utf-8?B?NlJFQUtOMUgvQ0FlN2VWMmNaQ0g0b2hydUZXeE4xOWcyV1g3a0xWRjBRWFdo?=
 =?utf-8?B?MVF3Tk9ybzdBZ21CcjBkVks5SUpFUlpiNkJZcTc0Q0grRHJKK0NGTm1zT0Ns?=
 =?utf-8?B?R0NBUE9Sanllb0F3dE5ETCswQnN2VTJuWjE1VmQvQkJXOUVCY1V2TndkVHZR?=
 =?utf-8?B?ai84NURleFlQSFdKdG80Rk9VZHh2R2EyTi92UDcxL0hUS0V0Tk1Md1A2VmVk?=
 =?utf-8?B?SlB0K1Jhb2V1TUU1ajJvNHJ5U2VRS2x6eDR4RUphUXkyR3VJK0RJRm42Zm1Q?=
 =?utf-8?B?NFF6S1hkV0RKQkdNc21aUmZsWHA1bi9rbDkybVJodmR5TE0yZkgzUHdEYVBq?=
 =?utf-8?B?aVFNZ1JjWjRCU20vbzg1WHlxMkIrZmliOExXSnlLQk54NlJ3ekJtTU1oWmxj?=
 =?utf-8?Q?jwehtV/xen3WTND/HuVdnzixs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bacdad1-bacd-4d0b-a861-08dbeb3dea25
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 09:32:16.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZyyZ09UkIjlNbNkoMikeidwbS5Ua7KWiWR/62VdkqvcGy1XIZAm+C/l3USCE9iVDSN6NWBPumBvvtKTr936Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7349
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/23 14:25, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 03.11.23 14:30, syed saba kareem wrote:
>> On 11/3/23 04:41, Bagas Sanjaya wrote:
>>> On Thu, Aug 03, 2023 at 10:22:07PM +0300, Marian Postevca wrote:
>> [...]
>>>> Some help here would be welcome. Is there something missing in my
>>>> machine driver code, or
>>>> is the runtime pm handling in acp pci driver wrong?
>> We were working on some other priority tasks, will upstream the changes
>>
>> by next week.
> Hi syed saba kareem! Did that happen? From here it looks like it did
> not, so I assume the regression was not yet addressed. But it's easy to
> miss something, hence this mail.

Hi , We have up streamed the patch it is in review.

Please find the below link for the patch details.

https://patchwork.kernel.org/project/alsa-devel/patch/20231113123345.2196504-2-Syed.SabaKareem@amd.com/

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
> #regzbot poke
