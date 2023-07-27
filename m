Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F9765900
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjG0QmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjG0QmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:42:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5157F2D70;
        Thu, 27 Jul 2023 09:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LArgynSR7cYfUfZLGxrfhZ+hO4Usxp/kaJhDSxrIwjly77ZKNDMy1KPVVqZbNtFrzC5cVbhcnYwsNnQFU/RLxJqFCNDVIeGrcYV28w502ERUqtvGlGLrJ5v7AwDg3B5bJBMXTIQLT/GQqyJWYjqcN0YZeQim+LmSZ1sYYT7TEPHSq4+5PdgUckLjgHRUpqZNmazLGJimStKmDSTEMbeeygnz/OD5vFzbgEq39N4n10Fp2As6qK3OipxctU8LEAelezRMkhKC05MB7iRaiTTOaAe9eHyQTWvmGPklEhnVRPy1puHT7/Pmb+e1okOsAp8yFd/Tms7f4ZAodAPUtT9SVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkVn3iTdbetr7CLWSCI1KBev25clBbzRojs/mpv+KJE=;
 b=X+K/fmdCWdro4Qe1Ol5gJKktBxPNMxY8q3bCtSKFFhqhN9JnqV+dEWppDfKDt6nRE5LEwhjt0qAYq9MM2w12RoslfQKRBu7w+6bEZii1GAXy/XUj9Z88WgfkXuaJtFDaLv6MMRwIgpCOIhuiRp0+Aa3KoOYYIMdLkGvhpL8Yl19gwsPWMPMOhxCKsh3isG50ddDx//BTNoSDN5y5q0Vd8xpb4xmycxy+I8wUD9IHyQSffo08WmJRyaE4FwoaG9XfBz0dm4cFnzE4LgGa7B6j76MyY/iSL4uDLhiHv6fnoahhWicXgu5Zty89Fs5B/zrS9VD5uaKpVC4sDRycteT7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkVn3iTdbetr7CLWSCI1KBev25clBbzRojs/mpv+KJE=;
 b=BYzgUardrQumsC8BTbFAK4tZJLRkpa3DYAvKFY+4lnAKrlSn4h8mIQ5S2VUekK4dN1levs8ht2qdI8YKYSeVFEuvxFDWFSm6RAK7Hi+7977D1RmTVz2/P3axPsn3V3gz33fE2dE8oERubMVPeThloeH42jxVd8eyHb5EdVCubmw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 16:41:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 16:41:58 +0000
Message-ID: <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
Date:   Thu, 27 Jul 2023 11:41:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
Content-Language: en-US
To:     Daniil Stas <daniil.stas@posteo.net>
Cc:     James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org, torvalds@linux-foundation.org
References: <20230727183805.69c36d6e@g14>
 <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com> <20230727193949.55c18805@g14>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230727193949.55c18805@g14>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0127.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 036c6725-4f72-4edf-e1d5-08db8ec06502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdZQqVGPJKy+FjGa2MnpG0fufrZJ8tQpSRI/ngClVxZ2Wrisn6ohXJP9nwrYocVxr5N690Am7ucujuEjPLNVlJtZtusSAKBUgVazeNxswk9+JeHk6GLWKNaYEaemTFtk9fl8Fy2+3bvFTBUJRObU7IgbhIDkXvRwqS9B+rOICU9/MfF66J5x51fT7aq1qc+UJVcK3vGwTmJDiNyOUnJolsm+m+Ok253zSPKiI7eUPWHZvOA2SaqzBAkXN/0vm6DVB05WR4OuArS97669TO/cQfqi40yKQQYaYhauHJRf47Wc/7NrYSjiPmZiT3pOAVHsf0zqH6OHom77qlaFEl7NZbXWs4NQ7AU0wC0tVMGBfR7sq+bIjmKJ8Ze5c9L34x4NULU3h7W3mMZTqYmqY7i6ZZIm2QZ0azPND0tCzJIjvDFycACBfVNQtN6PSp8BqtGkSQ/SHc6xJH6qA/u5fmScp3igJIsqQNrA5UZnkaL7iMfjHHfGlG6pk1Zu8EdZKVOVWiSxUYjClZH9JSAyq4FuyQGq/qYhX6NVy9yXLhonhHVQ6Euo24HSf6TfmGcY2nWwgJLFCNGMb2Yxzeg5JY8/dNqUuNVWSQJ8RnUDN3ASbwwaP40ItZT3mPq747kv8hEGh23qKLnluFd/2eUBEqRKJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(6666004)(6486002)(478600001)(83380400001)(53546011)(6506007)(26005)(6512007)(4326008)(6916009)(66476007)(66556008)(66946007)(186003)(38100700002)(2616005)(31686004)(44832011)(5660300002)(316002)(8676002)(8936002)(41300700001)(2906002)(4744005)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWI4Q0JKVXBzMDU1MkNsQkhrb3gvWjBmYk1hMEhlMUFlczA4c1VmTlI5TGwx?=
 =?utf-8?B?R1duV0V2TURGcGpiMWRQcFNDaWZzWTdHMXVjNGo3TUIyQklEZlgzeFp5VnhH?=
 =?utf-8?B?R3U0d0RlWHY1eU9HZ245NURLTy9qamZFM3BXano0WkpHR2pFbE1tZGgxcnhs?=
 =?utf-8?B?bzVtVTE2cm9IS2FIVjZHaittUGMwVFFjWXYyRmJGb3htN0ltb1o0WXhJbU1W?=
 =?utf-8?B?cUhWaEVuQWY1M1BBUDlTYTlWLzhFa3E5QjRTc1hibDRjSlYxckJrWUl1V2Yr?=
 =?utf-8?B?d0FBVkNscUZIcE04MmVXcmhhT0dma092WHZycDBqaWZvaTJjaHVVcnh1ZzhY?=
 =?utf-8?B?YytyZlBrMENUY0djYjMrZm8xbTM0L0RmdlFvVlhETmVrSEpnYytQcnhwYVdp?=
 =?utf-8?B?VlIwaHZuVk53RUR4TFNKNXVINTBKK241TWV0WlJZWEswQWpYSkFIZ25TVTlG?=
 =?utf-8?B?SFlsUmN2WFJWMUcxSUo5MkRpUzMydWwyaXJhWnlZbDJxcVJQdGl2ZjFhaS9U?=
 =?utf-8?B?ZmlvUktZcFhvRHJFQUZra0RiM1FPbEE1bTlPa3N2RHZjVEpHVFNiZmhTMjBs?=
 =?utf-8?B?dk5MNDc1aXl6d1NITjAxT3ErY1hVemNDUFVDcjlVUlZXTy9GdU1XOVlTMENi?=
 =?utf-8?B?Wkw5U29DYzVOSmp2VFJBVWVsZENIODBnc0Y1NmpYY3ZVUlZtYTNpVU1NQ3px?=
 =?utf-8?B?VWhveGI2TXVjTzViNHd0OE5YUkYvVnYrQUx1MHZVWFVUSFA3eHA4TjNsWnUr?=
 =?utf-8?B?WC90QjlwQnRtdzdkbTNoM0k0enBhcWRBZyt1T0VPdU5VVjRtdEV4RmpWRGxB?=
 =?utf-8?B?S2djUS9TaGg1UVZpT1FsQmpBL2ZwK1RrZGlkRFI2cGJLOHZzLzd6ZDM3dDhG?=
 =?utf-8?B?VVVpV09PZXRCL2JrKzFzcWhVVG5hOUNZb25IN2FLT3hzdW0zSmcrZ1VpRG9u?=
 =?utf-8?B?R0dwNEsySlB5N3dTc01RSnZXaXZuK2Q1ZUZNbmYrM0hLQml3Y1E5ZVB1VzRB?=
 =?utf-8?B?ZzRIVEU3Z3pXS21QUGREZ0c4NEsyZkw3V3BkbWlEcVhTZWkvMDFpU0s0WHQv?=
 =?utf-8?B?MmxEanpKREpYWG1sbHArSml3a0hSVlBOUktvMnJaTERCbDdnSWpueU9nOEdK?=
 =?utf-8?B?ZzhnRlVNMlcwOEhPS1lJQkt4VThDd0YyUEdVV3N0bEZXbFZCV1NteGF1UjBk?=
 =?utf-8?B?WUxRU2tIUjNrTjE0UmZ2SUdIQTBrTHlKc3Rsa2NiaUZUdkR6TUpoZ241Mmoz?=
 =?utf-8?B?YlhaanhxS1IxWjNMUWJWc05Wc2Robzk0U2ZTZEhYRXIxZ0NWYVRGa04yOUs2?=
 =?utf-8?B?elR3eVJ4UVNnczI4UmpJN0I2cHBPU2tLRWJSTWtTQ3VVRFBtWGJPaHVrOVhu?=
 =?utf-8?B?QXNlOU9pSCtaRkVFOHMxZzlIWkFTVHU1NFFRVSsvbklmVnE0RHp3VTVyQytI?=
 =?utf-8?B?NndDNXBKVlV1cFlrUTlwcW1HRm00Zy9Bc3c5ZTBJS3FBU2dyQXg3T1FxdTF4?=
 =?utf-8?B?VENXY2haK0ZYdEZTUDNOWGx2MjF2cmJWYlJZcTQ5bHc1TzJyZVRrRnJqVjNH?=
 =?utf-8?B?cDNoR3dvSHhLWWNRaTdGNk1XTnZmU0xscktpb0p0dnZmNFFEQjUyem5qeEZP?=
 =?utf-8?B?Y1EwNDg5ZTEvTTltMVkrNjFOVXp5ZTlpNzNBeEpYbjBmN3BncGdUMHBVNnJW?=
 =?utf-8?B?TDhVRkpXRUJ2N0FTbTZJb2pGaFJaYU9NRlhaZWR1T2Jud1F1R0EyaWt1VTk5?=
 =?utf-8?B?cmMwSnNGNTFOMWdzc3c1MmxVOExUNEttQ1FsOEQwTitscjdabzVXNmZoZlp3?=
 =?utf-8?B?VUExTEliR082elB3V05obUFMaTBXV1Y4RVVGY3JwdGduOHFzcTVCUzR1SFVl?=
 =?utf-8?B?Z0dEd1U3Y3J4VVhBL2VOOG9FeUtMZ0pFZWluWmd4VnQ4SURUY0x5Z2RNdkR0?=
 =?utf-8?B?cDlYVDRpekd5UWM1T0xHN3UxVmdRR3ltcERtUk8rV0dGZnVrYUpNb0JHQjY0?=
 =?utf-8?B?ZkxyOTBtUnBTNytXR0ZLUUN5ZksrSDB3VGRhditXWmZlTjBiNUR6Z1Q4Wmxv?=
 =?utf-8?B?Q0tVUzZuclVUNkpCRlBpa1d0Zyt6bWFvVWhJRFNIWGwzanllUk5vTmxuUmQ0?=
 =?utf-8?Q?iqEYdYPFKV3uIARlfKKbpah75?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036c6725-4f72-4edf-e1d5-08db8ec06502
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 16:41:58.5007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oDkRgOP15ODZ1xTi8yYiVuM0x2rCgGIJ7cbX8PFox0/4J2iIMHbqXdRTHZ8FPZQH/EOdLhx1nD9dVoNZBS7dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/2023 11:39, Daniil Stas wrote:
> On Thu, 27 Jul 2023 10:42:33 -0500
> Mario Limonciello <mario.limonciello@amd.com> wrote:
> 
>> On 7/27/2023 10:38, Daniil Stas wrote:
>>> Hi,
>>> I am still getting fTPM stutters with 6.4.3 kernel on Asus GA402RJ
>>> laptop.
>>> Compiling kernel without TPM support makes the stutters go away.
>>> The fTPM firmware version is 0x3005700020005 on my machine.
>>
>> Can you please open up a kernel bugzilla and attach your dmesg to it
>> both with TPM enabled and disabled?
>>
>> You can CC me on it directly.
> 
> There are several bug categories to choose in the bugzilla. Which one
> should I use?
> I never used bugzilla before...

drivers/other is fine.  If there is a better category we can move it later.
