Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C047FC219
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbjK1OO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbjK1OO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:14:57 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B40B5;
        Tue, 28 Nov 2023 06:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GglWggy5WIyLpM3vFYJEjszT0TtNESrtjQYU9qEAXpIGLN4jg/MtK8keUqNl248pVgQeA7OyNXfQnsuWG/wB9jnUBEY5XscQ4iOuozLeNKty8FbKEq/m9CWcEjS4NUlpau42k8dQaSQkgePhxy2fFSAW9r3AhF2ZDzX3AyEottyH1B/N9j00rFXUO0XxLADSKJim7UwBC69a5zzdRcEsucBCGedWvlKgZiZgKQnOsk8PANIwGzoPMqOZCiiZ3ILhSc77FdvN9/uLcn0BsDNAzYmlzqmtqB7eyq3aUQUhZRMoZhdWzZy+Jf5hd6AJFQcovBOimF1WdQw1o2M5WF5KwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgavUGB4+L0awiHBGFpIEIPXpijPPaIuu7IZXaJK8lc=;
 b=UQnMC9qtqyhWOWGf6PXcSG9zuIYbrXPCxr3ZWJA/orqq0J0rTrqJk36JyUPHE1aPP7xlDvj5AWDiE8CeRpRKnrvfTkClSTvRMW3cGL6y+AOEwFccvD8jfialQFV7gTowbpx1Zt1bR1hLXpNadpvcPQx5tIOujM9+0dE/RDs+Vwev0I+o1SWga+WLNBaYG2z20hkrvfBHQaPCtQzPwTCft0n8dJHcSmBodW+VLgNi7PHc9u9FyQOgpuOmWx4wd1Qoq+NakKyOgobopg7a+OPRzOf0dP+oolgYo8Swz7iMfF9kCE6OXQdzntT0Hbf/WvNWaHSeKdVCda4nTdo0u2dG8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgavUGB4+L0awiHBGFpIEIPXpijPPaIuu7IZXaJK8lc=;
 b=FEfjL9DFebDckKeVHRClWHZ7AyMQHIaTf00ueEWpcdq2Y4VU/eRHOFhJt/a+41xFr8kYmU0pw8UsGmCVF6pvyUjey2zx1nx1hi9lj/C9QqjM4JYT/BFDz3D5cKvqys/V0NB9Y/qs+PUZlWBtC6EX1oz1McnKHjjcOeHGrHzpq38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB7823.namprd12.prod.outlook.com (2603:10b6:a03:4c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 14:14:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 14:14:59 +0000
Message-ID: <28799328-a70c-40ff-ae4a-cf1933c8dbc5@amd.com>
Date:   Tue, 28 Nov 2023 08:14:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: usb hotplug broken on v6.5.12
Content-Language: en-US
To:     Sebastian Ott <sebott@redhat.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Sasha Levin <sashal@kernel.org>
References: <2c978ede-5e2f-b630-e126-4c19bd6278dc@redhat.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2c978ede-5e2f-b630-e126-4c19bd6278dc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0153.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 297050d6-c635-43fc-3c76-08dbf01c67b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhwtMBAA+bDsNIW1qFM8WbsjzVayW9yL9cF5VX7B5EGkoKk1sEhDwLw9uCG59YhMdhojpoxXwov757dl4NaN/yt0ODICGN5wE6QqSJq/i0RS8FFgGQ5Anw7w/aNbs5c2O7bb+sHukDFMckFUS4dTS0uY0aeU3k774Duq/YGPJzaZCpqHE9JmYrqCfcotD8tCj2OQkF0ZnOhDLZW2zcJKE5CU1eUCcl1BS9237ZD+zz4N11Pnm72z8yLmWtTJs0Cb19eUeDJpvWp7i5SKXxtVOhSUeZsCd6IRd3++uZ0s8V1Nqmq9hMGiKBMpi4SxYZKSvYA16BMM5hYyL8xl1WNSSWN2Ib9zOnGlIAMoBM2heJCCm0koW2caZ9jlhTU0hEg05aCZdcEsnxMBRltU7bvOLgZKqu/vGa+1UgiNejQ9wzko0hTy5TDTn+OfoExkmWxOmE38x6K2cVs9UtIuWZP4mf/mqqgsm7arjdIkfbwluhkut2PGAoexTBPjgQigKkhuHa+yP9lp6VxB16pLy65obFzpxunoJ4yUvZ4JMWfXhxGtcAwHo1PH5QtnzkFjsO8lPoTxhbmXwU7X66n1TNNDtmo+hB8uqbFyChfypXUYwfMLtV64t/UFaQ54dA0+cJ2Cm8SRZPdlWhY7QGoZQhEZKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2616005)(6512007)(26005)(478600001)(6506007)(53546011)(2906002)(4744005)(44832011)(5660300002)(41300700001)(6486002)(966005)(66946007)(66556008)(8936002)(8676002)(4326008)(316002)(66476007)(54906003)(38100700002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1ld1gwazRUcUpMdW1tSnlGQzJYZ1VHOGlneVJkbmZUcjF3Qk54ZWhrcDZh?=
 =?utf-8?B?YkUyMUEydHZuY2R1bDN5UE1STGpUWVhpV1NLcTFFTFFxLzJBQTlxMjY3TWZl?=
 =?utf-8?B?WnNVRlRqcjBaMW1oTzhBRE9EeVhFdlVaVkZobEg1N0xtNkVLMTlTSWFJM2VL?=
 =?utf-8?B?d1BsT1pRNWtnQUNMTE1OdS9uTCtvR0gyWXl2aklnTzVOWjJzeUM1R2JTdjFT?=
 =?utf-8?B?d2xFY09uZWNjbCs5MU9oeWR5VXpYTzhxZGx2RTRzOXEzVnlSK2p2K1NRa2NU?=
 =?utf-8?B?ZHIxMW5uSVlrVk1nOXZyanV1RTJsbHZVcklvL3NyM0RKa3I3YTloNGZycUdq?=
 =?utf-8?B?K1M0K1lnck5EM1UzdGQrQStTeU1sSWx1SzhUc2RsNnpoMk1UYTR3VEFueCtD?=
 =?utf-8?B?REFRcXMyZ2ZKYXZuNmcyZTNGZ1YxZ2dXN2NUOXYyWHBpaUxTZTUxc2plWTQx?=
 =?utf-8?B?UllmZ0tlbEpRalRoUWloNDcwVll0bUdFRjFOYWoxSUQxaHpTM2pGMXhtNGJt?=
 =?utf-8?B?RlJ6bTN3NmJtajlIQlVsOGJSNEdYTnZzMEViT3VobmNRWklCNlhWQVRPWGhK?=
 =?utf-8?B?Snd3WllCYUtjVDZDbHR5WTBVNHVoVTdLOW9tMk1uRnpFaWtPalJxcm5iM2cv?=
 =?utf-8?B?Y0VXakl4MGlsdlhXeFF6bnlRSnZ5aUZrMng2WWxOOE5VUHRxZUhoZ2Q1RUpZ?=
 =?utf-8?B?VDk1ZUVKZDB3bzRMNWwraTVDcmR2L0V4U3lKdTNqYUlYMXdncWY1d3VjRWVQ?=
 =?utf-8?B?UXZkRG5nNDFCbXl1QXlwYzJYMDgrVndQcHlHSlNGdVIzZHcrUEtVL2VoYlQz?=
 =?utf-8?B?MllkRlNoNFZPZlgwVHErc2toRHYzRmN3S1U4b25nd1pjSy9QWm0yaC96NUgy?=
 =?utf-8?B?a0JlTFhCKzh2RnpKVE5JWkZqYjh1cjdZdVRTL2ZQYU1zcEsrRi84UWErZW1X?=
 =?utf-8?B?MG5EZjQxWlorTjVrU2UzWTFmWkkyUFZOQnJYNmhKNnkyNVlRQ0wzaERYTVIv?=
 =?utf-8?B?UGtNMVFod3B0RzljTjdCN0N1anU2QTQ2cEpQWE02cU9UTWxNTDIwa2FmRngw?=
 =?utf-8?B?c0VSZEFPeU95Vmc2ZnBTUGxSWFYzc2dlUnByWXhqaWdraHgwTmdFaGQzYVg0?=
 =?utf-8?B?MWpFeVRZdGJ6a1F6S1A4Uk1CNmltWlZlTkRiSDZEWUhXc2MyU0swTzNxT2Nr?=
 =?utf-8?B?cTVuWnB3MmpDMjZFSExzOE52WkhaMjg3VlJqb3FWc0h2WldzQzZsSS9mb29K?=
 =?utf-8?B?ejJuZEV4WVVhT0ZSYUJuNmRFYmhEcnJBM1ZsMzU4TTErQkRFMjRvMS9uVk9i?=
 =?utf-8?B?c0MvbXJBdnhOWE1zbWptZUpqTFlseWx6OVB4VktrS2tXdis0TnJDOGY1QWR1?=
 =?utf-8?B?SVJRU2F2cjN0VWNtVDJJY3M2bUVuRXRzL29SQ1lKTTNHWnlGeW11a3NvTUtz?=
 =?utf-8?B?dkxhOTFkVk5HTTFDbUdXdGx1d002TEErb3ZrR0Uxcm0rT2xGWTFsV3cwOWpQ?=
 =?utf-8?B?QUw2alFkVTBpUUJYdGoxQ2p2WEhEYjJRb0tlRnhCaW1JS3JVWDNsZjM3S1U3?=
 =?utf-8?B?R1J5Nkp3WlVNZU05L1kzSExGK01COEd2TDZnZkdoeE10NjRVYm9CVGdibWR2?=
 =?utf-8?B?aDlBTWQ3UW54TkdFSWYvbi9NYi9MOWFwa0VVY2QxbmYrVDRFN3VkcXZWcCtx?=
 =?utf-8?B?Uml2NStTbXVvZGNsWFlYbWZwTS9xQkxvUkQwR281Wm54dWk0RytsYXYxK05D?=
 =?utf-8?B?N3hnOU9LOUh0Y21RQk5GTkpWM1JpdkNVaGhZeXZXR05oMlpEL2JmbW56MFo0?=
 =?utf-8?B?T0JoS3p1ekRPVmwvejhBczFkdUJqOE8wNks3b2o4Z1JuK3VPbVNCTXJGK3pj?=
 =?utf-8?B?TEtwdkY1dCtTSFFSK0lrVmcvcGlBWXAxb3dUZm9mZ203R3dzbEdDOVdpUmZK?=
 =?utf-8?B?bnRublRZcGdleFQ5MUczTkxOc3gzbFBvdVNJeFdQaFFZRkNlRVBpSEZGODlV?=
 =?utf-8?B?NU5uWkpUQ0ViYTlWc2YzMWdUOFdON3FzaHhmNFJrNHFFdmxndVNxY3Jqbzd0?=
 =?utf-8?B?dEJBRE1KaHoxUm43YUl1YzFMMzB0eHRSK3JGYTBjM2IrbkdCdlBQZk0yQzJB?=
 =?utf-8?Q?/kXOZkBFf1iwnyDGBMrVd127Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297050d6-c635-43fc-3c76-08dbf01c67b4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:14:59.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1E/0IYXncB0rfvZfUG1BURuJCZq4Nqnups5eUwV01FwH6quETijKft+9z8VkXHfwhhpRmxGXdp2mNfAuPcfkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7823
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/2023 07:12, Sebastian Ott wrote:
> Hej,
> 
> usb hotplug doesn't work for me running stable kernel v6.5.12 on an AMD
> based Thinkpad t495s. Bisect pointed to 7b8ae3c24ef ("xhci: Loosen RPM as
> default policy to cover for AMD xHC 1.1") - which is 4baf1218150 upstream.
> 
> Reverting that from 6.5.12 fixes the issue for me.
> Current upstream rc kernel contains this patch but doesn't show the issue.
> 
> Regards,
> Sebastian
> 

I believe it's the same discussion as 
https://lore.kernel.org/stable/5993222.lOV4Wx5bFT@natalenko.name/#t

The outcome was that another missing patch is in the stable queue for 
various kernels and will be part of the next stable release for various 
kernels.
