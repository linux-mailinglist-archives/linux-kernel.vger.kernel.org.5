Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8028E7C843A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjJMLSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJMLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:18:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4CDBE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:18:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f00ltHpK5mkfmlvRqIrwNCRiZXVI9kAEq9h2K2zDhRgwE9ZWiHWFR1UJtlwcgVXMeV95qP91wwxMxhXm9ehd2ar+/LciHHg+Ty20mskCz6IloZ+ZYHdv2xuHEqvQzEho3IrmCWfj95WxysgZO5eogEJXCJJvxiwsX8vGNo1Sq2uSb00CO1dMDd1ClmmbkpLE/xBbbSok6hdAXb8YKInGRIWX/wIMajeQeJuOZOTlQjwWtTT1zA+HAvLNl7h6hghFSHU8j6uwMDoT0MLR3DRb0HrhWNX1pjh4QDY+Ea1ItelBvVBK5x4+n599ZQ5ALa+b1iMzZaKmNyi4TtCW3BYWew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kvm1hyxdoB3DbZuhf1yEsYb6FhCr6Auy5Em4jjdubc=;
 b=PtoZKnPE0xoRqDnyPPgl86miBKK/XQCARvMvNvN22SkAsNEGCwDWDkZxfU07j1aDGgFBe6V4IuDi1R9FkwJJf733KS4BGPBAeuZfNdBvaYpL/GG+D0ukk4QxO4aLfDKL/78k5ox9woUdZaY6WQODfxu5WyBt2mmkHk4wCAUmCuXdAlhU+2S5djJB63LzOoxK6d0ZObAS7X1jZfef/NYwhXYGr7rj48ukZOH1NGSXsc03rup7wg56LKlGxzIno2LIifcIRWjTJmkk2Wv6rKfKSwZEUwWxvbCdSEKqyiO3TaSew052c3xPDFZdCHMn1rzdUmEBmHoXynmMWKLcXZY5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kvm1hyxdoB3DbZuhf1yEsYb6FhCr6Auy5Em4jjdubc=;
 b=KHO+FTfT1nCURXPYTPLfciFegG43f8Bwy8Q+ZOkXI+1eOUgE+IW9zh52GRAZSqBM80MG9IwRVHpi1TZjd/2OlLrjjU903Gh4iLkkPU1leH95oAYSXjch6ihBPYMIaQKm+XYZ6r4t37l8ss2Qh5sObJtdDcUqTVteIlB5JhMKfDGybvJEKPDMHgR+jhLSfmOhaiJOw5c/L/2GcA4qxAtLkdWx4axcqOZGQXpwC/6qagjxkVXbbLQ7Pi2K4/bCl2kj7Ises6YZKMutUQ+NBAZwYu5aLKFFIIf16sHBHuR9RF9phz2+o7C6wlPaNPWXGkpmlQwF/a+aSvctzizm8ognNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Fri, 13 Oct
 2023 11:18:14 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::edd3:f00:3088:6e61%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 11:18:13 +0000
Message-ID: <840dab8f-f255-42b0-948b-cd740fb7d154@suse.com>
Date:   Fri, 13 Oct 2023 14:18:11 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] x86/tdx: Dump TDX version During the TD Bootup
Content-Language: en-US
To:     Yi Sun <yi.sun@intel.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, peterz@infradead.org,
        x86@kernel.org
Cc:     kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, kai.huang@intel.com,
        linux-kernel@vger.kernel.org, heng.su@intel.com,
        yi.sun@linux.intel.com, Dongcheng Yan <dongcheng.yan@intel.com>
References: <20231012134136.1310650-1-yi.sun@intel.com>
From:   Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20231012134136.1310650-1-yi.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0172.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::6) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AS5PR04MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: ff806780-c3c1-4609-026d-08dbcbde1743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pw9PLmlG+4zC/+a8UPgFqpHfR0gpOVCXHT8vOHWBd5wO83+yof+dOmtdlXs9zdwIFHTF2dypY9a9e6Lr7HI52wB1A5qdnUKoHHS6HH35LdsJoNECIO/3l3HNCz4sw0aNJ4FA9Gez7EHwqr050dL33+f4HaE8s/WdR4dUdCFdygFZFRvb4/V/BZCzqLlVuL+yB4cUDNJDew4N+6uqGeeGtnk3EgfUpCbhwh1uTpuijUdhsarIJyPvGDk494MGEVW3vNhijpmunhQfS6la32KYU/6Ik6Az35mIgelsAExDKmphxFJz2yxX+tQ285JCXmCCFSsyH+DzyfkDapoYY230pxqE7LBX4nJRc6FzAyc1rUgpr2ZcFVKosWF9j0VwhV4IG+As9BdlnOQ73FSVMIAb5ckrT5uFlAhNFJNXaPq7OANDIyrxtL/7COJE+DL0P/bXpG3PHaTaG2yCkv5ZMVvZ1FYGtgNSY7iC2m4ewuMV6CVimz3GdEnv3s7del1XRvcIjo+ZpnIoXpVK6PPxAXom2saPH31xvX7GgiPH35p21WrCujFwm9Uh/IKhvOjEEzgYcFAatgLh1S94mFOTZPmf2grj3saLaCA6QW1oWskAJIC9ejefFNxcDtwiTyo4TCOJHtPIKlz38BGQMW+S2iqKAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(7416002)(2906002)(86362001)(31696002)(38100700002)(2616005)(6486002)(6512007)(36756003)(6506007)(316002)(31686004)(83380400001)(66476007)(41300700001)(66946007)(5660300002)(478600001)(4326008)(66556008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2dsK3NnV1pQd1ZqV2VkQmpabE1yeTd6MHpGc1M1MW1JanR4YjF4aXJZQmI5?=
 =?utf-8?B?R1ZLTW1GeXIrRnJGMXZOWUM4MUMra1pYRitSU2NKTlFoaVBMTDBoa25XeGhO?=
 =?utf-8?B?OGJpdU5Qd2JidURtSXgvNTA1dTE3bWl2S3EzNEpXa3g0TWIrTzRkZ3U3Y3dV?=
 =?utf-8?B?akRkS3cxUzRpR2RVMFlkOWd0UTFKQ2tFb3BwdDVYOThRbk12d21hSjJudDhn?=
 =?utf-8?B?WFlYbVRaWVFZdVR0R0NaK0c2K2lRSDFlRHlMV1ZXcjkrazU0YW5WT0hOdlBG?=
 =?utf-8?B?TzQ5V05ETTBIVHRMcy96N1gyTW9LMW1kTWxwbG9wcDNQNnRrVHFDTjlGRFVF?=
 =?utf-8?B?SXU0ZVMxdkk3a1NLVUYvM0VkSmhoNUxZakh3QUVNMkRGb25TQVFESUU2Y3FX?=
 =?utf-8?B?TnpWRjY5c3JLdm9TVllFVWhQT0tCdlFzVi9yTlZWa2lFYXZ2dHJUbnVSelZv?=
 =?utf-8?B?QlpyM3JmbjBTNFEzbmVTV0Z6bTdtVklKRmp2ZXR0ZElCN1hRSWN5a0FlYjg3?=
 =?utf-8?B?ZlY0K0tSbEhaNmJHVDJEMytGVHNIN3FEVVBnWWhBUEd5ME9DdWVZRXlxWnVq?=
 =?utf-8?B?SWNZVVVHUFB6MjBzMTd6cjBmSTRhWit3bXZMczJyVWZDMXBqcnJYNUFoYzJm?=
 =?utf-8?B?cE1pcVJaOW9Wb1EyZ3BwT24rVkl4cGFnaHdpQ0VKOWVRbStQVDdMTXlWa0Y2?=
 =?utf-8?B?djJ2QW9FYjNxbktTalRpR0ZPNGRmeFRaaUdxZnZZSFp5VFZSdHFiOU1qM29F?=
 =?utf-8?B?YmFKcm93MUkyMGJnUmJxWUtKdlVlU2RFSm0vaGttY1RBZmgzZWw5UE42U3o0?=
 =?utf-8?B?Mk9OcWxaN0s5QnByWXc4YUdMK2NkaE1ucUtXREpLR2JkaCtkRU1rRVBzRmJh?=
 =?utf-8?B?VndXMnBYKzExUDNvWnJobmE5cjc0a1grbW9pQmx3T3ZtT0Nleno4WDh4Mi9u?=
 =?utf-8?B?K0w3Y0pOWXp1bkRyazNTeGVodG5MeGFKbE1NajMxYTQwNDRvRGdmdWN2SmlK?=
 =?utf-8?B?eitXOG1GYndmNnk5eGZlVEVYNkN3ZjFWSE5OOWpHTXpjN2NGMDVsQUthaUIw?=
 =?utf-8?B?VFhlT0ptQlhBWGJpY3V4S1VhNlNjUmxSQnh5dE9GK0pzYlRMbm1wSTVOYjhQ?=
 =?utf-8?B?ekxPemdxcFBUVkZJVU9Mb2FveWF3dzR6YTNwWVkybVAvQ0NHS0RITTVFeC9R?=
 =?utf-8?B?dXdhNXhaVkRGUlJ6aHpwa2dPekJpdUg0KzExSnZBb3hrcnhuQzJtT1pydzFs?=
 =?utf-8?B?NkNWa3dPdnlVdVZOWk1QalplSTJLeStheGo0eU9JT0xuK3BvVUQzeGN0Nncx?=
 =?utf-8?B?ZytianFUQVFWd3l2ZjhFdnhCeVRJUlJ3NkFnc2VmaUJNN3BvdUhzQklYajJF?=
 =?utf-8?B?ajhsdFBQbERGSk13ejA4NTZQRHVucXdySVFsU0xvdTVOZnhvNTRuQ0NZSVVF?=
 =?utf-8?B?VFZidDhZODdIODNBeEV6R2ZVOFJNeHNuempiM0xwR2REaFlqbWZGeE8zM0t3?=
 =?utf-8?B?NW5hWHd0TGtUa3FFTW5OVE8yS2Fyay84ckEwOENIN1E2alJpWXZSZW90V0Mx?=
 =?utf-8?B?cFhOelc4dk5vVmk4MTdXRFA4dDVvTm1EQjdWb3BzM0EyMEdFUndubVhnUUxE?=
 =?utf-8?B?YkJxWkhZYnlGekErZmNNcG1mR2h2ekUvemxrTjBoL1djQVdBSzdZR0NGQmd3?=
 =?utf-8?B?TXdFSEVtN0Y4cFMyN2pucVRhOHVUcmFraVNDN2xOQmswUVFoSFRjb0x1a0k4?=
 =?utf-8?B?bk1aeER5K0d3TEloRmVNb0JTWlJrb2hYOUdTQVhGYjlCYlpydXhYWDRnV3M1?=
 =?utf-8?B?ckFoNUk1U2xlQVljLzVtcmVEV2lzZE9nTVZYeHV1WHJhMmZEeUpLajMrRldQ?=
 =?utf-8?B?d1NBS1FzTC82KzdjeEdqZkUwWkxhbGZVL3VVOXBlclMvc2JmaFB3bkNWUHVF?=
 =?utf-8?B?SkZpdEZLb2dpczdFWUlVYXozWW9QdVRCTllnMlJXRlIrWXNjSDZwclczMGlW?=
 =?utf-8?B?Zk96VVoybGZka08yN1VNelI2eTRLZFM1bnZtSE9raWVnblgvODZFY0RjcUNC?=
 =?utf-8?B?ZkR2b3FRQWJ4N05XdDV3V3k5VUJJU0V1ZHJ3K3dvUU9NZkw2NWI2OG02MTdk?=
 =?utf-8?B?WGMvVWNkUWMvY2ovMzUydEcwK0dvWkZXaCtXOFp2Yi9ld3hWSmkrbDA4Y3NC?=
 =?utf-8?Q?x6zYTWM1up2EnoK5JEkb6UbInVUZuG6Up3OmD5N5dgCv?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff806780-c3c1-4609-026d-08dbcbde1743
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 11:18:13.8822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KYXF+PpRdV5rEAnEK7f53RM7wfQyW1BFwnt8jjPUjqO7pvL8qpXHQ2YKwnAL/r45i6CrR/YRFSwcDF9U3ZwcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.10.23 г. 16:41 ч., Yi Sun wrote:
> It is essential for TD users to be aware of the vendor and version of
> the current TDX. Additionally, they can reference the TDX version when
> reporting bugs or issues.
> 
> Furthermore, the applications or device drivers running in TD can achieve
> enhanced reliability and flexibility by following the TDX Module ABI
> specification, because there are significant differences between different
> versions of TDX, as mentioned in the "Intel® TDX Module Incompatibilities
> between v1.0 and v1.5" reference.
> 
> Add function detect_tdx_version to fetch and dump the version of the
> TDX, which is called during TD initialization. Obtain the info by calling
> TDG.SYS.RD, including the major and minor version numbers and vendor ID.
> 
> The TDCALL TDG.SYS.RD originates from TDX version 1.5. If the error
> TDCALL_INVALID_OPERAND occurs, it should be treated as TDX version 1.0.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Co-developed-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Dongcheng Yan <dongcheng.yan@intel.com>
> Signed-off-by: Yi Sun <yi.sun@intel.com>

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>


<rant>

Intel really outdid themselves in creating the most horrendous document 
to read/comprehend aka tdx's 1.5 ABI ...

</rant>
