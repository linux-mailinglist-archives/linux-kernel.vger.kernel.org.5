Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C27EF7D0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjKQTZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjKQTZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:25:12 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2059.outbound.protection.outlook.com [40.92.23.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7533BB6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 11:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAN1vZXSIDHJ9tnWppmLpbnlgm/OkaYwCBl39lOH2bKQM1LYcBsAYp448t57mg6lGv9KXNg6oJJkkVE6bRJ4LGZ0PX+dfLIolWvowzrfdYMXAR6pGoB2yUZrd6fIFstcQ0wPAfs6jojvO+4+ymvNilFg0Fx9m3EyalCoRRlVy6UH0rbPn+5kO7T78g4kgQRUm8ZtUJXDmAgeT0zVUDpTIEoe3oku885QTXRtV2fo62qHe1WrGblNHvcUcIwII98WztEQnBETBYvoASOeHv2+h9qPvcuuM8fAtYYiik5reZgbJd+OQp87lqErLK+wScAN+fmz0A3317Xz5IFHm+A89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTx4M0VL29/0jWGJ+OItKRCs5kICvPs/wUZn0TmRC/0=;
 b=iCPYm7eGpz3uaUNlkKNQr/22aAEn5MVvLYhDAleQuvOy0Z6fl6fSD+bmpzDmGviajqsJRCw2pSRurykK07O31iydtZ13kQg4YyskDglOGjW+2L2oWhJx9gfEAzT1QuMkLHz1iVrXcGxOLWuLxZSUDdLWal/CxwehCo1IVvYYbuCd7ZDi2Z3KhiofCPckqY440ojoVRNPmKQraDConRO9v6Sm80aY61P2XE/nQSuOsodnRbXCWSsHDCwZRjk0qvdl6qmqwYX3qEf3sSk779qcEGZWMhvWEu3/3SUvj9/QEm5bIvPQ/nGBmcFiZAOSJmLp8zg/u2w2zXJ6J9S89QhtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xTx4M0VL29/0jWGJ+OItKRCs5kICvPs/wUZn0TmRC/0=;
 b=SQQ7f20sxjW7uHRyxKXy4py/ByOyRb28UaqBIIl+cp11nGIv3lpuMxnB0/NHd/RvYRvzf7SaGzi3f92K8C/pOxVAgHSOZqonDItLQfubuSkT/UA5U8TthTgQJvi0YN1HbREBL3hjKEJzpZSBj9B2KU1sNpzqfrzvNtgpJ2ne21HQl5gMDOrWyyYP9iV1wybN/a4Rg7bXRCAnVnjbdpVvS1ma+HNkqgCzyKdrOuFkStdr9Z2kJi+kn/vLd/lVNV8nYdj1e2R8PLFkPGfiC0IyTiL3zh5Cko1gEnG/AJdDp2VP+KS/8zoGrFmu1PsahqRn2a0Ty6066bOdFnbvmSEPwg==
Received: from CH0P221MB0505.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:10a::8)
 by PH7P221MB1055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:1ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 19:25:05 +0000
Received: from CH0P221MB0505.NAMP221.PROD.OUTLOOK.COM
 ([fe80::3622:f845:51d:46b4]) by CH0P221MB0505.NAMP221.PROD.OUTLOOK.COM
 ([fe80::3622:f845:51d:46b4%6]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 19:25:05 +0000
Message-ID: <CH0P221MB050571AF779EFDE97B7E780AA9B7A@CH0P221MB0505.NAMP221.PROD.OUTLOOK.COM>
Date:   Fri, 17 Nov 2023 14:25:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/mm: add option to prefer IOMMU ops for DMA on Xen
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Chuck Zmudzinski <brchuckz@aol.com>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Julien Grall <julien@xen.org>,
        Mario Marietto <marietto2008@gmail.com>,
        Bertrand Marquis <bertrand.marquis@arm.com>
References: <20231111184538.2371-1-brchuckz.ref@aol.com>
 <20231111184538.2371-1-brchuckz@aol.com>
 <e5ebfde9-7a74-4908-b0b9-db47c4e76315@arm.com>
 <alpine.DEB.2.22.394.2311141407140.160649@ubuntu-linux-20-04-desktop>
Content-Language: en-US
From:   "Fr. Chuck Zmudzinski, C.P.M." <brchuck@hotmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2311141407140.160649@ubuntu-linux-20-04-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [4oeaQyw9qUhcxwyWuan8X0UUW8mnwMBEqCn+EqbouySuRkf3IQL/fMlr0AOhikaM]
X-ClientProxiedBy: CH5P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:1f3::25) To CH0P221MB0505.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:10a::8)
X-Microsoft-Original-Message-ID: <9870f267-90f1-4c7b-b041-b2116be94a0f@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0P221MB0505:EE_|PH7P221MB1055:EE_
X-MS-Office365-Filtering-Correlation-Id: 18f38435-22ff-4fbe-a307-08dbe7a2e6c4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qMkoKSkBzZKotnEoxq1FVk6qsm+I1O3YpZRT+zldS19eH795riXI95SsbdxJ4qNn95zMDbxwwBJ0HFNcoP+KHmBNN+OAU9qeTdlqTr6X69yQbTZ2YBIkRntl2VAfoAHjGrsym88zhd+z8HhRuekCBHNDURo/zMjkHj1Ocpp+C7iTUk2E192xbY6uQva2SUd39BpztwDIP9Ox6a07k5LiVP2LMyyrUMKHDfVZTRL4kAMqjoPj6gv1nc9XNMYNzAWEWyFBRtGYzmcmvRMyhj2X8+rAAYkHgma1LiRVXNq7ueZfxnvgNsw1jZMV7CmDMcMxkSsJ5sxnb5cWgYhlekMkUGXgPIJAOg20JKA74jZjaILhWDiPaomellFd/s6iAGGjW2MiFPUeSkOCIPCIfk2CDj+Nl7iZl5PF1vie7wQT4sHjhwE/s3uj7xHfT27cGD9BYVk7xz6axHJmu8ten85zyZ5rJgvQiZsi7tTSB6CV9uZcDhXFwdtECQ0ycT0Ac0DZ7m1wOadonCa7/K7RrD7lCqKZBisR4ChmG36lzuhODxc=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFRpS1M2WkZsaCs5TzhKeG9xSlRiNytUNTBZUWp0eTFORVBlWEh1WUtpbE5K?=
 =?utf-8?B?M21MclIxRm9heGp0Z25vRjN2Tjc4d2t5UkErait5WUdRQjBBVkt3S3ZYSTlS?=
 =?utf-8?B?S3Iyc2RFVXRBQzgrZWtFSjF5WE5SaUxja2hoUGE4MmIrZDBjKzlYemFlRncx?=
 =?utf-8?B?c1dVRktVSGJ5aU1saEdGWTlkWW16YUhvVmpZWDgzZW5keGoxRlVpeUl0eUNX?=
 =?utf-8?B?a25GeU9rNWREMUJqenpVWkZ2YkV3NWRldWRNamxEYzZOMDhWWXN6Wkh0bXZa?=
 =?utf-8?B?NGRFWCtVQUMzYTRLZncvQ2s4Q0poS1FJVG8xd0N5ZWlROUlqRWFPblZYZVg3?=
 =?utf-8?B?SlhRS0k4VTY3aEZBL29yNXNNRVIreFNKMEFxZzJSeUc5RWYwa0xrcWc2c1dh?=
 =?utf-8?B?WjV5QXVXWFVZUmRuRk5KWktsUWNEVkMrY05SWnI5MHBOWlVrYk53U0tuN2gv?=
 =?utf-8?B?Y05nOXpOeXlOTVRjYzloTmVYVkx2YVd5SSs1TTFkTzkwenBMdUxGZWJlZDQr?=
 =?utf-8?B?QXpEcnlCN1Y0QkR1bGZvQTdZZ3k4OFZVT2trV2t6RFhOVmV2NHdlUE8yT0lP?=
 =?utf-8?B?RmhHZkFURnVwczY3KzRJQnlEY3crNStlam9yWWgxRzZ4Z0tnVzF4ZkZ4QlA4?=
 =?utf-8?B?NXNtTW5sNkw5ZjZRZHJQOFI1bGhnVTR3a1pPellERVVmM0tHazdHekJhb09N?=
 =?utf-8?B?QnZ6ZTV6eldwTXNRNTM5U1Y0THFINVMzTUdGZ2JjSVNPd0IzbzZlUnNnK3Vk?=
 =?utf-8?B?Um5CMHlHRUlLVHJQRmhoL0NHZXhqV3VKTnNNaVNQVFk1QVZPN3piNEJGem1Z?=
 =?utf-8?B?UFRaT1E2dUp3US9ySTZxQW1lbEJXZ0lIVlBTOGI1bXh0MUYxSTlKUlpZT0lr?=
 =?utf-8?B?ZXRjWXM5QUIxTXRYei8rU0EyNis3UlFWRFUxQ21GMTFNM3dBSStVcWFxSkZ4?=
 =?utf-8?B?QnB1QUlGUVJNcDdwN2F2cVRhMXBvTVhVT1VCNFpnanRDUnQ0ejRDSGpJUldN?=
 =?utf-8?B?eGNhS24yNkFqOGRJUWkyK25UYlBUc291YUhzekRRekVrenlUdld2NXdUUitS?=
 =?utf-8?B?RThZZ0EyZUtPb0NiQlg1QUhLZlZhTGsrSnZDTjg1Y3RhR0labmtqekZBa2Q1?=
 =?utf-8?B?NXJYU3EwdGNORzhlQmZvUXlseHkyUzd4NmpoUFpWaTFrWG54bzU2cUNXVHFR?=
 =?utf-8?B?bTNSYWlZV3A4MFg3Y3Z0TDVsMWM3RHdHQ1F6QW44WGNBUlRmbTZDVHdJSVhG?=
 =?utf-8?B?Tzg4Yzh3bzBoM1oxcnErMG1qTEllQWlTK1M2TVAzY20xNElqdVRramQ0enNY?=
 =?utf-8?B?MFlzN0t3UC9sZGNWRnBzQlRNdXhiVGhKSVlpeWRoWG1weXhSTnJQK2pKd3E2?=
 =?utf-8?B?NFJFUjFYTWhTTm56RThXakZTMjZtWGNwWThLTzh3UVQ0RkdkWUNSM0tJZXNz?=
 =?utf-8?B?M2FQS29uQzFBdHQwdG9lSmdFQkx0Z1VVVUdaT3NoUWRlR2JJYTNjeG1ISTV4?=
 =?utf-8?B?dlI3cUo1ZXRqa2ZSVEJUS0FzcFlodW1JTlFhS0p6a2h6Y1Zpcys3SXBTSXBk?=
 =?utf-8?B?c1hMMzBJak9sRlhlU1o1THdDeXdOejNXczJzWjRuMnRUMXhsMTJMRGZ0d1Mv?=
 =?utf-8?B?ZHY0ZlRHUmJkYjJqZ2Q1dVlGV1diSFVsMTNmTFBZaFhvWDh5ZDA4VTNJTVJL?=
 =?utf-8?B?S3hxdDRCZDR5OXhvRjl4MzR2cXNSZjUwV2xHQTI5SStqdmc3U29rYmhBPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-f5d03.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f38435-22ff-4fbe-a307-08dbe7a2e6c4
X-MS-Exchange-CrossTenant-AuthSource: CH0P221MB0505.NAMP221.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 19:25:05.1849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P221MB1055
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2023 5:20 PM, Stefano Stabellini wrote:
> On Tue, 14 Nov 2023, Robin Murphy wrote:
>> On 11/11/2023 6:45 pm, Chuck Zmudzinski wrote:
>> > Enabling the new option, ARM_DMA_USE_IOMMU_XEN, fixes this error when
>> > attaching the Exynos mixer in Linux dom0 on Xen on the Chromebook Snow
>> > (and probably on other devices that use the Exynos mixer):
>> > 
>> > [drm] Exynos DRM: using 14400000.fimd device for DMA mapping operations
>> > exynos-drm exynos-drm: bound 14400000.fimd (ops 0xc0d96354)
>> > exynos-mixer 14450000.mixer: [drm:exynos_drm_register_dma] *ERROR* Device
>> >                               14450000.mixer lacks support for IOMMU
>> > exynos-drm exynos-drm: failed to bind 14450000.mixer (ops 0xc0d97554): -22
>> > exynos-drm exynos-drm: adev bind failed: -22
>> > exynos-dp: probe of 145b0000.dp-controller failed with error -22
>> > 
>> > Linux normally uses xen_swiotlb_dma_ops for DMA for all devices when
>> > xen_swiotlb is detected even when Xen exposes an IOMMU to Linux. Enabling
>> > the new config option allows devices such as the Exynos mixer to use the
>> > IOMMU instead of xen_swiotlb_dma_ops for DMA and this fixes the error.
>> > 
>> > The new config option is not set by default because it is likely some
>> > devices that use IOMMU for DMA on Xen will cause DMA errors and memory
>> > corruption when Xen PV block and network drivers are in use on the system.
>> > 
>> > Link:
>> > https://lore.kernel.org/xen-devel/acfab1c5-eed1-4930-8c70-8681e256c820@netscape.net/
>> > 
>> > Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
>> > ---
>> > The reported error with the Exynos mixer is not fixed by default by adding
>> > a second patch to select the new option in the Kconfig definition for the
>> > Exynos mixer if EXYNOS_IOMMU and SWIOTLB_XEN are enabled because it is
>> > not certain setting the config option is suitable for all cases. So it is
>> > necessary to explicitly select the new config option during the config
>> > stage of the Linux kernel build to fix the reported error or similar
>> > errors that have the same cause of lack of support for IOMMU on Xen. This
>> > is necessary to avoid any regressions that might be caused by enabling the
>> > new option by default for the Exynos mixer.
>> >   arch/arm/mm/dma-mapping.c |  6 ++++++
>> >   drivers/xen/Kconfig       | 16 ++++++++++++++++
>> >   2 files changed, 22 insertions(+)
>> > 
>> > diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> > index 5409225b4abc..ca04fdf01be3 100644
>> > --- a/arch/arm/mm/dma-mapping.c
>> > +++ b/arch/arm/mm/dma-mapping.c
>> > @@ -1779,6 +1779,12 @@ void arch_setup_dma_ops(struct device *dev, u64
>> > dma_base, u64 size,
>> >   	if (iommu)
>> >   		arm_setup_iommu_dma_ops(dev, dma_base, size, iommu, coherent);
>> >   +#ifdef CONFIG_ARM_DMA_USE_IOMMU_XEN
>> 
>> FWIW I don't think this really needs a config option - if Xen *has* made an
>> IOMMU available, then there isn't really much reason not to use it, and if for
>> some reason someone really didn't want to then they could simply disable the
>> IOMMU driver anyway.
> 
> The fact that the Exynos IOMMU is exposed to Linux is a mistake. Xen
> doesn't recognize the Exynos IOMMU (it is not one of the IOMMUs Xen has
> a driver for) so it assigns the IOMMU to Dom0. It doesn't happen on
> purpose, it happens by accident. Certain things are going to break,
> specifically I am fairly certain PV drivers are going to break.
> 
> If Xen recognized the Exynos IOMMU as an IOMMU it would probably hide it
> from Dom0. (Today Xen doesn't have a list of IOMMUs Xen recognizes but
> doesn't have a driver for.)
> 
> I think it is OK for Chuck and others to play around with this
> configuration but I wouldn't add a new kconfig option to Linux to
> support it.
> 
> If we do want a kconfig option, I would add a kconfig option or Linux
> command line option to enable/disable swiotlb-xen. Basically a way to
> force-enable or force-disable xen_swiotlb_detect().That could be

I am trying to understand what you are proposing.

I tried disabling the CONFIG_SWIOTLB_XEN option that already
exists and it does not seem possible to disable that option without
also totally removing Xen dom0 support from Linux on arm. So do you
suggest keeping that option as is and adding a Linux command line
switch or new Linux Kconfig option that is ignored unless
CONFIG_SWIOTLB_XEN is enabled and would make xen_swiotlb_detect()
always return false or always return true, depending on the setting
of the new option?

Thanks,

Chuck

> generally useful for debugging and would also solve the problem here as
> it could be used to force-disable swiotlb-xen. I would imagine that the
> end result is the same: the default ops (iommu_ops) are used.
> 

