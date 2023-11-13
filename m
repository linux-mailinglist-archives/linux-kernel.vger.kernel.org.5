Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397CB7EA12A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjKMQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKMQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:20:06 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E1210FB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:20:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3eCLvSappk4acC0ZyG8F4cVxOX3m11MlIDhOELKRbrmDUkfXYiE9bE2aZ74gM3VTs1RQsBTG4ezHxf1SVpJKL4ylNfzEYWx3eIaE8w4cNz3CZpruhMpV795I1l6rvv76SlM7fFDhN5MRP66wDkQFzlUNQ2qcwZ8Fn0Y8UZgB4cnro/0easTNIOfRccp8kB/RZoOT1ikaa2C+Yj7fzt34UM+sfY4obgsWjkVASfKidHCFdcVWkUadffC8hgMvGRbF5xZOo1q2P8FykJyBwsXYa1D6nIlOK5cIHUm1O3mpMsig2Ojrfsd5KCb27zn7hd/ZiSyG2BOSHVtgJELFaVBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdhqCLcYZowqrk1t0RTyMfExIbtbJMa79TnPoyBKk84=;
 b=gSO9I5CMr7s276w4YmFmpBSBN/wU5nxb6h05S+e8LzolQC1TiW6R/iDRCRf0Jdxdap3gwgqXJ4tSy4zcghH51vAm1s/O96pN56NQVlrRz3yFf5mBoXW0D9PXrXS1UFmES6Bh+QIUYqBfMyGw7UBOEg0JoHcI1IhtC1X+mXm2bg7ZnKAF5sWwzC61hcM7S05e/TRO9QWZhzpw9U3u+Jg3808vO/u/bKR9Sh8lT1090Z9XXGILOSSFMuEq9bZTTPqB+RSkA6RbiigLVAURJCttpC2yqsdSs3sPnhtyWTiXxjdCn2TIlTINz2jkikC9nxwN4QS0BPxi+qHzL1Xyc3dHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdhqCLcYZowqrk1t0RTyMfExIbtbJMa79TnPoyBKk84=;
 b=Hyn22r4IkGqpChUfFZAXcx8xl18iFoDORicBPTLjWBUmrywNG6Xg9qp2vmDMO+yCQdQj1v1AcE55zJ0f6NpblwMKNHtkUBH1UPnZ7ABNIALg+VfCzZNfTgj+mj29eAgibo1WsPG8gY284EwfB22w6vmNYvPc8T/FbJ+obeKapvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 16:19:59 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 16:19:59 +0000
Message-ID: <b7ad6ca3-f706-409c-9f99-af05b2b63535@amd.com>
Date:   Mon, 13 Nov 2023 10:19:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] ASoC: amd: acp: add Kconfig options for acp7.0
 based platform driver
To:     Syed Saba Kareem <Syed.SabaKareem@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, richgong@amd.com, posteuca@mutex.one,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
Content-Language: en-US
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:806:a7::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: b297ccef-fc5a-404b-8bc6-08dbe46461e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V0IccjT0+jwJxQAS81ZPPOda+EfqPcWqKV2Y/qfADQLjZMeZZnjpa1X3ggsRTzY7fs01NUvE106tT68Qb+N04168ndX3dHJgjz/A6f5CUeUKFH2j/AxRecBKNhpHtYjYCPHUPPtXQoqV0xgYbkIYL2qQvxB9iCux3uafJY/ZTeWtv1n/j5foGD7Bog3W0cJfY7lXsz0RVuI1qkqyYSpwpPRC/PyAdpmV7g9H1wPAKGMDZNzrAbc9aQlAjKmAIzx/6WfWJcpHC1+D6gnkrEAsHmpvo6rdrVfKK7nIsvjl6GM3SCDvesebR+sbur+DiuHhQZ5aQj2laiQ7nyST4xPWyAcTh74x8ofQ8nzIT3srnqFMnDfMNlzhrB0nxbr9ZVsdnmELl8JcClsEsoitEczi3BcyYAoUhpg5L+l7Wn0pLLyrK4lmmx6Xk+94ZU4TPnngObI2m2x9/z4kZD5efL6shTS65VHdZoUutpKSLJFbgtLN7xCT6Hh/pJJAZW3zkmRhGMpCymj6ika8eOA5V24JPExDB2nozMytlxEAEdW8glj0d4oH0pdcFuHMeclDzDP2Px423ohbnNUGKRA7XE7Iz4YhQbuZk07X2V0KM/Fugcic7df/x1DiCSTZU28FxWYtxFZfwT0AduAs3in1G5tppg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(44832011)(31696002)(4326008)(8676002)(8936002)(26005)(2906002)(5660300002)(2616005)(86362001)(6506007)(53546011)(6486002)(36756003)(478600001)(41300700001)(31686004)(38100700002)(83380400001)(316002)(6512007)(66946007)(66556008)(66476007)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXBMSU4yc2drWTRwU3o4YWdKVHZzeHFDYUhqU2xDeVdra291bXJaWFN2L3FD?=
 =?utf-8?B?ZTVPcmMxRkU4WHhCZnJpUWdWK1FMLzlYUXZnemdGTmcwVUJ4c0RVUmpFdXlU?=
 =?utf-8?B?L0Ixd1lUNHRwMTRJei9KZWN1aTZ0M0JYYTBrSXMvYVJCc05HVjFXTktGZzR4?=
 =?utf-8?B?azhkSFF0aHhxaDUzMlZNRXRadERTTitHMmZNa1VwbXRyWkNQdDBZcG85RGdQ?=
 =?utf-8?B?U1VwZ1lSMWM5UDF5U20rNnNFU3FrL1IxUFN4NmNvNnlmTHVZK1VHT3ZBU05q?=
 =?utf-8?B?b3NEUXJhUHlwZkJmNmdYNU8yVGFsRTkwWTM0aHZxQlBzUW9vYnpjdnFzdEdY?=
 =?utf-8?B?RXF5RUpJYWlRUnB2OFp2bnZlL2p6WUlncTFMb3d4L2JNK2VtSnVlV3J5TGNG?=
 =?utf-8?B?WE90VXhzRnRDTzdzYmNlL3dJTis4RlR4SXQ4cTFKdGxrVHhsSFptYllFN0g5?=
 =?utf-8?B?cHhYeTY2MVVJek5DYnlSRktuZUJBMjR3bi9HTndza0dPczIxRUhXQXNxQzJk?=
 =?utf-8?B?M1UyenR3TFp6RlYvZTBYaHQvSmplenRGSWhwUmV4OFp0WTRmNkJnZ1lIVW5t?=
 =?utf-8?B?UEd1WVQ3ZkpmOHVkNjllaUJnSlFPTm5NK3lsS1RNcE53aklQcXFuOElFMHc1?=
 =?utf-8?B?d244WnlhZXdnbFJLRjZobEErVlgzQlRMUU5LS2ZHMk5oR1Y3d3pEWmdINVdx?=
 =?utf-8?B?ZGFad0ZMNmlrdml3OVdCei9ham02bVptb2o4YndxSFJ5T2c5YVdTbmRybUhF?=
 =?utf-8?B?TDFhZDlPeVBsWVZCRGhmeTJBWjYreWxCTEVnNFdjSGgrNGRjUk9ydFJ1ak53?=
 =?utf-8?B?VmtvWFRXaVU1VGt1ZHVwT2hVRFE1UUE0clNDandSU1FCN1dlSlozdEJicjNz?=
 =?utf-8?B?T2FNTmxiQkhsTG5PaUQxNG54S2tGeWZTTXJUUnd0MFZMVzRISmxHU0ZIQUtH?=
 =?utf-8?B?Rm1TYVFTVHJicGNmUmZ3Um9NdVVndkRwcTVYOEtVenVxZWJ5OGw3cEQzUkFK?=
 =?utf-8?B?dENVYVZHRGJyZHhuZjFwdGx1azJnSndnUHFPdUtFSUlKL0w3eG9rV0RJUVJZ?=
 =?utf-8?B?WnNZMUs1anhkTjF1U3VaMlBxWFNMaVNxRFFzU284ZzBOK3JnRXVOTmhkTUJG?=
 =?utf-8?B?TTBzYVI4dm1XWm96WlpGNmptMjRURkNoSitVUXRJUDlaeXFhYktxalJrMnJu?=
 =?utf-8?B?UHM0aG45RTdKalFnQ0JVVGxST0QzSElhUHBvcFFtaGh2UmZZR09sNStyRWor?=
 =?utf-8?B?alZ5TElaMVZNWHczcjVpT2QvYi9hMTBhNW5xaDZLTEd2OGg1L25HUzNhbzNK?=
 =?utf-8?B?OGtyOWdqZnBOT21hTmNQdFM2KzVSMFpWUTA5akJZaHk3c0p5bjQrRlZXOURL?=
 =?utf-8?B?K1pWUlZUb2kyVEFONTh0T2hrOGFkNDFQbTdxM0dIU3RmTTluN3dKYjJaN0w2?=
 =?utf-8?B?RkpDUW9EKzFuU096QnlIMExWMzdJRHdOSmVIeW1tNnkxQWlBMG5wTDNtbFBQ?=
 =?utf-8?B?eXF6QVhmMkhyRThLSk54dlBRVGN5TWczUHVhUTlYU0VVakFtclErb0tNd2pD?=
 =?utf-8?B?K29ubkcvT0ZtbU1ncTlNcUVYRWQzQU5jeXh6bDZKZkpScjE4QmlFbmZVMzZJ?=
 =?utf-8?B?YWtDeS9ydVBMU1RYSTdTSGhidDFGZnp2ZU9JMmpnbldMSFFaRkZYWEpRZDZS?=
 =?utf-8?B?ZHVyK1IrbTFFbzVLS1lqRFA2WUMvbGYzRzd2MHlRbUhFR0dYRFdQaTJibUZX?=
 =?utf-8?B?ZmxQdWlPVlowYlhCTEpEWm5La015MzFSTW1ia1c0TG03MlV0VjRYSkxZc0NO?=
 =?utf-8?B?YXgwcFh2UVlaSWEvSXZaME1WcnpaQm1LZ3NGeGt4ZDI2OHQ1d0QrM0RRVzI2?=
 =?utf-8?B?RzJ4L3NjQjF6RDc4YnBYNmhtR1ZMLytHMXU1VVl3NUJxQnFXY2NmUlhGTG9o?=
 =?utf-8?B?ZUk3dGF5U1Y2WFpBVTIwVy9adzFTSWR5TjVQTE1qYkNESWd6UG9nRFNnVDRt?=
 =?utf-8?B?VnErdXRqM3NISFlvV2FTVURSSHIvZmtoYTMwOVVvd2t0MUh3Z3IyMkJZaVVW?=
 =?utf-8?B?NkRoY1JSUTFMVU4rdTZBS0dZRHREdFo4d1F3SnAzaGUycHNPWGd2TVVBeER5?=
 =?utf-8?Q?0FT56yr5/iimTiwdZXFQ5G/7n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b297ccef-fc5a-404b-8bc6-08dbe46461e6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 16:19:59.5205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yD4bjCV7BTCvi3AJw1aPSXYMh4hpJgbc1NMdPe8MMm1mdkHZ/wgDuCJJARaJeYzyBCTRmZFazUolza5MJzHuAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/2023 06:33, Syed Saba Kareem wrote:
> ACP7.0 based platform legacy drivers can be built by selecting
> necessary kernel config option. This patch enables build support
> of the same.
> 
> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> ---
> changes since v1:
>       - added missing commit message.
> 
>   sound/soc/amd/acp/Kconfig  | 12 ++++++++++++
>   sound/soc/amd/acp/Makefile |  2 ++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
> index 5fb322212938..c8ac0027f741 100644
> --- a/sound/soc/amd/acp/Kconfig
> +++ b/sound/soc/amd/acp/Kconfig
> @@ -73,6 +73,18 @@ config SND_AMD_ASOC_ACP63
>   	  Say Y if you want to enable AUDIO on ACP6.3
>   	  If unsure select "N".
>   
> +config SND_AMD_ASOC_ACP70
> +	tristate "AMD ACP ASOC Acp7.0 Support"
> +	depends on X86 && PCI
> +	depends on ACPI
> +	select SND_SOC_AMD_ACP_PCM
> +	select SND_SOC_AMD_ACP_I2S
> +	select SND_SOC_AMD_ACP_PDM

Do you not need:

	select SND_SOC_AMD_ACP_LEGACY_COMMON

Like how ACP63, Rembrandt, and Renoir all select?

> +	help
> +	This option enables Acp7.0 PDM support on AMD platform.
> +	Say Y if you want to enable AUDIO on ACP7.0
> +          If unsure select "N".
> +
>   config SND_SOC_AMD_MACH_COMMON
>   	tristate
>   	depends on X86 && PCI && I2C
> diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
> index dd85700f1c5f..ff5f7893b81e 100644
> --- a/sound/soc/amd/acp/Makefile
> +++ b/sound/soc/amd/acp/Makefile
> @@ -15,6 +15,7 @@ snd-acp-pci-objs     := acp-pci.o
>   snd-acp-renoir-objs     := acp-renoir.o
>   snd-acp-rembrandt-objs  := acp-rembrandt.o
>   snd-acp63-objs := acp63.o
> +snd-acp70-objs := acp70.o
>   
>   #machine specific driver
>   snd-acp-mach-objs     := acp-mach-common.o
> @@ -30,6 +31,7 @@ obj-$(CONFIG_SND_SOC_AMD_ACP_PCI) += snd-acp-pci.o
>   obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
>   obj-$(CONFIG_SND_AMD_ASOC_REMBRANDT) += snd-acp-rembrandt.o
>   obj-$(CONFIG_SND_AMD_ASOC_ACP63) += snd-acp63.o
> +obj-$(CONFIG_SND_AMD_ASOC_ACP70) += snd-acp70.o
>   
>   obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
>   obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o

