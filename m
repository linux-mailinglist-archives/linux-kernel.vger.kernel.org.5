Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BFA7EC301
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343830AbjKOMxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbjKOMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:53:50 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAE811F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:53:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7OIM5959aSG1NU/ppmFjUCljKpVl66J2Qn8r67W2p7R53BYaKtemEVZRKILyhicWuP6x0PqIroGTN/YfPW4O5PjWflaKN0UGAEY1MA+wiEbzCtryF/ifcMetKg07xi94cGZ5ITEKklpvRcSUc/fNbf+PSVBXbT5HG0DYOTez3wI8TyxhG8o9aW+2nq/0IWjznjJ/x88s77KGB+RQ8YRMJjc7Y9rwJxAF9JrOvEPNG1IXKvXymsJaFYMNv9qrcgks+F5w4UOMNhrLcErZI0t1Vsri2Dx5RWOgUe0x8R+e9sHPyOZrHxKO7plkD7hG+47KMtREEDGpoS28cvVQrPBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FIgcmFj2UZToBIKBSHDrIpccdSUwtUGl4v6mwa6gGY=;
 b=B/kU6Lh0mkXeM3ZtxDajK2pkFJlKkcNvVxFCUlY0cMzzh2zf0L7tHAUvAH7iMZ87qqscS3iFmXzfv1C1+9VOY0mxcEfE4wrba402rB8Fq7b4hjuYM3jkvxatybw6bACf54H4rYWLepVCDZ1StD2CuLWhGjjGMFaaadE4FkpKWpIpYI4mjPO/8uy1VEF8ECZ0md972b+r8QGV+oF9X8tL6SD9tLPsqzwAmBufdYq2OJOS/2ajGt1gkftm7mjJ/8EPx1SaMDW7o0PcQxjeBAyRI4i+yuQg1PykcYBrHyYRycqxyHpbtAwUWMcG7d1S0+rcn4jn/TFtYsL9F3K30EonWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FIgcmFj2UZToBIKBSHDrIpccdSUwtUGl4v6mwa6gGY=;
 b=sDr8AFdNqCeD+MN2YVfnoQrW4WXpr9cClABLatWz4vEFlU7dy8eZL/Jl4NgHaBgCjRtuG5cw7VqwPRp+qQy8Tp43LYtBdJP69PxUQNBRCXodLE92MC5HGx0vPc7N8K/2Ol41IS9CruDfQZ2dO7/lemfk7kWy5md4uvtpHOp3hGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by IA1PR12MB6284.namprd12.prod.outlook.com (2603:10b6:208:3e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Wed, 15 Nov
 2023 12:53:43 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 12:53:43 +0000
Message-ID: <3eea894a-f8c4-4f9a-9d11-3ed41bed3ee6@amd.com>
Date:   Wed, 15 Nov 2023 13:53:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] microblaze: Defconfig updates
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Raju Kumar Pothuraju <rajukumar.pothuraju@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>
References: <cover.1698155190.git.michal.simek@amd.com>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <cover.1698155190.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0026.eurprd09.prod.outlook.com
 (2603:10a6:802:1::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|IA1PR12MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb4e8c3-1768-417b-0274-08dbe5d9e5bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ldi5S9vWUz5D5jMy9wkBss9ryULsinjsVRwPdKvAJXLKpFuf3dr5aL6UougvUhNc7hcTLwkQIa1/xW2bsT0ccuWiptbj6qGWuxLZ1xVuI/NxQn3glw8oG1md4QQo5rffkvf7D4jeEumc4Z2lKJARLOv7K9NGgpsUwkgRACA/fgu+UBEJ1dfWJdH9kFuSgRp7BF0D584/eOc+M4J/6jWZX0Sic5EaGf1UScYnagv7OrQk4RRfVD/plL37ZVsuGq85ZQzwKpU3rUSlAi0lDbrUh6KjTblYVpv1OMQQ2uucCFWyFCJd88HOXcEKTQEP5MwdW5bjvMFkdmFuwoAOmvZ97X/83S89JhcpJt1Q3g2pe+Wdzq9dp3fhjRe4MjRZdeubwOA9ZQ/7sxUjDSHdDIqWw+croOWLGzdH8jiZzEpT4BjyLOprM+S2IDveYxQxk/4RZnfs/R37/TOYFyWTvAz/HuOcyX2YSHYw0lSyMWHtFJrmxm54WDwvcD32cmZQaAMhvGXUtk0CzMpGJWFij/ioXgujh3308NY/bxCIHbpHHhYCGcBe2VoUotfuyYKdZLatpGqABU5J7si9DwiO605Q3XfHQKLYHn4cBl2UiWxJZj8awgMuK/plT+rFucnQ6YNZuIdcOFW3uMg0UuqynEGmYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(39860400002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(36756003)(38100700002)(2906002)(4744005)(7416002)(5660300002)(41300700001)(83380400001)(478600001)(6486002)(6506007)(53546011)(8936002)(8676002)(31696002)(4326008)(86362001)(6666004)(66556008)(66946007)(66476007)(316002)(54906003)(2616005)(44832011)(26005)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1VVT1A0UkFhM3hIL2tvRFpBZWt4ckdGaVN6YlBydHhDRFpHZWpYOWpoeWpF?=
 =?utf-8?B?ZE1EYU42ZXpFWUN1ZEZiRFptU25SZWJUcEsyREdyUm1WbEhCN1phNy9LTWt0?=
 =?utf-8?B?eUs5VktycXM1a09ESHJFekVTbCtEYnNQOXhkQUlNOTk2RGQ2enJob2F1RDEw?=
 =?utf-8?B?SE5zNzFEdld0UlNQd1dhdzduZ1VWU3BZVnVYOHFXTERma1ppRFZIeE12MGw0?=
 =?utf-8?B?aWRBc3l0RWxsU0xteklhNHE0MDliWjNhSjBYaTdtamRYZzdGUjJ4RkY4NGg4?=
 =?utf-8?B?ckJONXdJZzNXRG1sNmdxVDl3QSthRFFhT0xGTVgwaGxKM1ZLUDdaQVFhWFNr?=
 =?utf-8?B?YzhJOHBCUzVVU2s4bFMrdzUxUGZ0Y2hJdisxRTZMMkFQeGcvakdWQkxMUEl1?=
 =?utf-8?B?d0JiQUVZQjVzU1NoazkvbytHSHk4R3lib1M0Qlh1MjRjL1dzZlRIdHVvR0dM?=
 =?utf-8?B?RHJjWGk1UHozVUNzdE1aZ2RMcUU3cmhnUUZUdit1K1A5bThzMGJadno5K2ZZ?=
 =?utf-8?B?ZzV1MVU1SlNncWxyd0EreW9YZHNQNGVnaDhUMjY2WWhmMjB5dUxrcEowc2pt?=
 =?utf-8?B?OVRhSXBROVZFQ21aNmVnTExvT2pNeDRuNzJHMjNxUDdVWHBLR2FIaDVnRTlF?=
 =?utf-8?B?bG5IYjA2cjBCSEttZzMzWXJ2aVZrWldxZUhuZnhLZnVhd20xOURyYUZGLzEy?=
 =?utf-8?B?dW9jZnRFNEFFRFJQYjhGR3N4UW43eFoxeTEzYXVDTGcyaFRibGd0YkZ6ZHVU?=
 =?utf-8?B?NE1oYXRscW5UUHVEbWRQbGVDYjVJUFBERGVLbnVzMldOdkJWMGxIdjJUSjZI?=
 =?utf-8?B?aGxNSk0yTGcwUEQvUUFrb2p5RnM1ODNZSWJ4WnVUUnhxUkFQZ0NIUHhydSsr?=
 =?utf-8?B?WnBvZHRJNGdEVGg5YTRSWDhBM1JHa3NMUWx3MnV5Uy9yQjFFOU5CNFQxWHNj?=
 =?utf-8?B?S0FJaERwbnhQdUg3NkFBVGhVcG5RYmdDZUFYbDBOaVJ2WnZ2L1V1QUdGNlJX?=
 =?utf-8?B?L1RtbWJkUnowdHE2clZEdTNQbzUyaWNIS08rVTJuNitmSjlRNkNuL1ZjYXQ3?=
 =?utf-8?B?WWVqMnVzSitQS1NtTEc3ckZiQXNYelFOblZhMEROeHh5V2c3eXZWaytXU0pr?=
 =?utf-8?B?aGp4cnA4TTNqNGJ5b2cxVjZVTEFQSnRXYmJZdDh2aWNuRFF3c0RBRzlCUDVF?=
 =?utf-8?B?YW1ibzRqdFk2VWVJd1JreG1jWktucEJ0UTRjbFBITW8rc1hDa1dhQ3VqN2to?=
 =?utf-8?B?cFdXaU9qaU5UM0QzMmVQNml4Sk5jMFFNNnA2MituS0tOalNBbDNPNGhaZEcx?=
 =?utf-8?B?RWRaanVoc1RQd2psaVJubUluTEkrQnk0dVhpMm5RWGYwK2JSeExCa3BoMWIx?=
 =?utf-8?B?cTBUaU9xMHNQMElkNVFUZXdvMzlNVU5BNmhmaXFlNnRpTTd0NG13R1czdE1G?=
 =?utf-8?B?dThTVEVnM1ZyUWEzVHhaamd5eUQvQ3d0YSsxUTluYWZYdHpCeWRwREFzb29p?=
 =?utf-8?B?Mnk1ZHpEVEcxMk1seGYrZTRoTnI2WEtEZ1lLZmtscWF4Vkh4L2ZhbWJoZ1Nx?=
 =?utf-8?B?UWN4OU9JVjFPYVlYZEI2OGdzWGZvZUdMdjBIVnNEMzdNMUY5dTdrU2tUNmVX?=
 =?utf-8?B?QUFWZGRHZEgzTnp2QnY3eHZrY2NVQ3RNM2F6UmJmVEtVcWkwN09HMEIyREcv?=
 =?utf-8?B?ak9EUEJ0Z2RoOStEVXN6NzlRdzRvcVljckdhaTAvM3lDay9xMVp4S3hvUVQy?=
 =?utf-8?B?VjZuS2I3QUJDRjdIdjFSbWFXenJMNXNFeGJaV0VKYzVSS1hsYVM0eGJ6M2ZM?=
 =?utf-8?B?Uzg5Wm1XVGJTSFdzMzYvR3Z4MkJPQjMzUFhRNE5rRXJZdDFQSTU3RVVreHUv?=
 =?utf-8?B?QmhNbVVUdFF5NEZ3djdKSzBXMVlZVWZ2UUR0Mmtkdm9GeEVCSmRQamVSalFL?=
 =?utf-8?B?RkpCZ1pTWUVnSWQyMlV5aDhQY1FQS2FPSmRUOUlvcldGcUpnY0ZmUEUwRHRJ?=
 =?utf-8?B?YW9PV3MvMmNPdlhFOFBEY1QzSUtCRkYxV1ovTmdOK1pNbjdTWWg1QWVRWmxL?=
 =?utf-8?B?MjZJSUhLL1pzeSs4WEpDRlNSeGVQMm9Md0pzNVlXODQyMkFYL0lxY1k0V3J4?=
 =?utf-8?Q?2mEd5T8G7ZUHA/ctNFVeTieZR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb4e8c3-1768-417b-0274-08dbe5d9e5bb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 12:53:43.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r3f2sbUxcF+yiERlprH4SbmHVe2f1U7MkzN38mYhbOGBHMiWWkX1S5Fsy5zwRyU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6284
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/24/23 15:46, Michal Simek wrote:
> Hi,
> 
> I have put together small series based on patches I found in Xilinx/AMD
> Linux tree which will be good to send out.
> The first patch is just synchronization to match the latest Kconfig layout.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (1):
>    microblaze: Align defconfig with latest Kconfig layout
> 
> Radhey Shyam Pandey (1):
>    microblaze: defconfig: Enable the Marvell phy driver
> 
> Raju Kumar Pothuraju (1):
>    microblaze: Enable options to mount a rootfs via NFS
> 
>   arch/microblaze/configs/mmu_defconfig | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 

Applied.
M
