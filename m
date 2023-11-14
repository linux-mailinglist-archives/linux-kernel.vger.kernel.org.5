Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09557EB01D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjKNMpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjKNMpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:45:23 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27C2130
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:45:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBg6zBvIuilaSTpHdptIKIMxVgsM7cdkhnK2dvR6UHEskqewJkVUxApBy1cd3+n9ixZBxpDz9GC0XqjbTSzGw8WXg59PFzRCnH2PySDJ0JHCeF5o2ccgHyaZhyeadZotAQ3b9t9MY5P0RH7en4YmOfQQ9NV+yYblrJfqOS5u5nw/mTdZ2gAkIH+G8PDgcG4SVxlRVRvUJJxv7bK40zYOio6n9b404I1sjV+jyPnOwomNmnXrK3M84fSteC762Y++85r1rVEYJSZbyKcNiXRld6EE0aoiwhsxnJj42ezaVYLXeuXxjxRwzDRuiO8x+iTorsvpvHlr9vJPWpjv2LBRIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGQMd6FJSFz0IgF+CAnQAfMSbcHqH8Jvv++zCZmx3cY=;
 b=hq1VfPNAFfCxz02Lf6U08phJkgFcYQn2RUsI+b4mwmwcvel7Sgr57/PPBcZ0a3Qq1yH5csxLi35aMmUkDYgJ2x+b/FFjD83mNTB2Yoy6mroM/BbYNVRJYl47ZJ6FclbEIxbyaMw0HYeq+98y3EBuSM8pyE5Pc2wTXfoyKaUABbCEh+1nVljdgV/aUfhj9+4fa3XSaal3lNQfuGkLEJxOsD289Hd4C8MUePjnvT3hT4ENjlz8Olpi9qsYFE9oyyTtUcQyEl288vyWqjXIpB25qN5uxmz+2PP3DRxsTxVrAJsJ3qHkmiaxfKWTbFEu2+e2alN1z2sm2V6sT4mKodoGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGQMd6FJSFz0IgF+CAnQAfMSbcHqH8Jvv++zCZmx3cY=;
 b=weme4cGu5c4sPuUImjFmtfBsxxL88FucVk7VLyBny1JPS1xt81fqDSG0jTZCxpPdv98YaogMMKyg0STJ7Csouo1nudUjSkgPJtThKOXtq7hUqawHsySHBKz0MdbN/HX/1vXqy5ro5Tkls5GtNnQ1qFCvwPstuN/Fi4URfoVtuRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3661.namprd12.prod.outlook.com (2603:10b6:208:169::31)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 12:45:16 +0000
Received: from MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb]) by MN2PR12MB3661.namprd12.prod.outlook.com
 ([fe80::6d62:cc7:cf1d:86eb%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 12:45:15 +0000
Message-ID: <79e8a5b1-c4d7-4489-83fc-b86ba6ac7549@amd.com>
Date:   Tue, 14 Nov 2023 18:15:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/2] ASoC: amd: acp: add Kconfig options for acp7.0
 based platform driver
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, richgong@amd.com, posteuca@mutex.one,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20231113123345.2196504-1-Syed.SabaKareem@amd.com>
 <b7ad6ca3-f706-409c-9f99-af05b2b63535@amd.com>
From:   syed saba kareem <ssabakar@amd.com>
In-Reply-To: <b7ad6ca3-f706-409c-9f99-af05b2b63535@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0148.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::18) To MN2PR12MB3661.namprd12.prod.outlook.com
 (2603:10b6:208:169::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3661:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffd818c-be80-4501-07e4-08dbe50f8ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kkCF3FlYNwwSzo7W813g1aMeeGC4WRDcZa4bOTSYTaySwXHEpbDhIH5GAmHYB9nqK3x/Fe8Az5QXhv9qFe1SP4ZuT8Awmrl5F1zc/qXiLWkUpj9rip6h3D8WbygGrN3257kADe0OvH+5HDHyLxvwTt5SE2GkDgBpZ5A1/X6U+9tSBWfc6SiYtEQeEZSrAbhtnVTdF/KcO19FALDiYWeRLJ2V2fSEeEbdFpawQjzpukoxq+Qj8chniy37Z1d1y556YyqLnvMiW/5GxtPTVkzo+JiNb7ImyYgUzwqzr4O0mkSBZuZoIrqhNxzeGLziX1wGRwDGVNLSg/X4H7m+izo00x/ZKIE5k+gdqyptWc8g7Odn1jNh/iKXRf3TP1ImYIfNlhmtixsY6QySBS7Z9lIo+G0n2oBAvS+k3G5BnMjmRfjpprxJwFfldpGcEmzoaTd5N2NhCDtWoYMVi7dCHN1G3Eb0DCuRI4Hl2Xb7qPTnONhDUtOoyfADAZKuzbczwpwOkjHOL1n4FWpxAxvsgqM+ADG0i7BIm9vFyUmMfX4sKKnK3/BEAI39TrzA0/XivZAYcZdRLsXnmJU0tb99E72YKc+5tR9mkCwr0O7DcO0g4LroUrUSJPXJ2oNiu0PTtFKL8AcAuy2LaugIrJN6kbvsVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(4326008)(8936002)(8676002)(2906002)(41300700001)(110136005)(66946007)(66476007)(66556008)(316002)(54906003)(31686004)(5660300002)(31696002)(6486002)(83380400001)(38100700002)(478600001)(53546011)(26005)(2616005)(6506007)(36756003)(6512007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWl0cGJqVDhJU2pKYjNMRVZYS0tyZWhlZm5nRlFUS0loS1hiRkNzek1VR0ll?=
 =?utf-8?B?NWJXdTNPbUVSanhBSmV5aW94eEI3RnVKNFo4MUw2ck85NmZWcUs0ZHc0cVlV?=
 =?utf-8?B?ZlgwL254VGFaVWthYkNxZlNycjN4MmQ1aDFzTU1KNjdROXNzTUtGSlEwQ2Fa?=
 =?utf-8?B?RVR0amxVdUt1QXFBNENvSFdEZ29MdkpEeEhzZ05UZ0MwZ1dBTDhKeXUwaUk1?=
 =?utf-8?B?dmlZT0w1amFVSWlidWdWeUJrTlZDeWU0WHVwNE5JSEF4M0NYT3NVUjFDejY4?=
 =?utf-8?B?c21KeE5NK28wbzYzZVYrdEl2cDBEVGZCVFNJWEFBcVVBTmdyK1NSenpxWExK?=
 =?utf-8?B?NTlxRlpxU1kxYm9heHRSakRyOC9yTUpiUVhHL1FodnloQmJkQnJQSktnNXhi?=
 =?utf-8?B?ckRLMTVKTHFnUFJIT1Q2NzJxWHEyN01vRHJVanFqb1RYZmUxWVlLenBsNkpH?=
 =?utf-8?B?a3RMbjlkc1dmRDFzNWJWSDFTT0pqTXV5TG00d0RuTDBoa2J3OGwwYmNpMDZu?=
 =?utf-8?B?K1ljVDd5SGQrOGR3QzF5YURKSXR2eVdQQVVFdFJXeWxsUkFZVWJjQ3hpNGJh?=
 =?utf-8?B?dFhnZmN6RWhSWG1ycmQ4ZUl3MEM4T1lLSC9ld25wbVNKWWVhZm15MUVtQkZX?=
 =?utf-8?B?TUdRaEhLKzhVTEVJcWduTmJIanhRdTBVa0RRQW1XWVNzRDFvMnJXZUIzWkho?=
 =?utf-8?B?aEZ0MnRjc1lNazNYM0NGNS8ySFhGcTA5WnVDeXp4Sk9TNVdZOGNPNE5GR3Fx?=
 =?utf-8?B?TVNVV1RxN1RGbkQveDZvU3M2Qk5VRHFnZkdkS3F3Uk84TTVzRkxvZE1oclJi?=
 =?utf-8?B?YXJhZExiZkdVeHBPeUpjU0lTTUhPU085QnFjTERFZFBvbDRYcUJkbHcyWVVC?=
 =?utf-8?B?bkZLUCtHSnJNb25wencrNlFZTHNtWGs2K0Q0Z3dQaHB2UnpDWWlOZzBqSnRF?=
 =?utf-8?B?ZDdYV0JGd2REZ29kb1lyWVJyNzRqMkJVTVpzc2lDY1JvVEVlcXlBQ3E5NXZy?=
 =?utf-8?B?N2l2SVZWTTdNVDRrWm4yTFVrd0F5bGVyNjZ6L2p1SzZ6ME5XbUF4RW50NGQv?=
 =?utf-8?B?MUVQYlRVVCtaVVpqVU9pTHRNUXVwcXNWRUJ1WXJ4NkFFT25nYzlNc2w2dTdR?=
 =?utf-8?B?amt5M3YzME5JdnFoNzA2N3JOYTI4azBOTnVseTVGWFU3cGtTSUw4UHVuSnov?=
 =?utf-8?B?WG1LQWtnWlFxZEdpZjc5NnJ4L3hMaWhsUUoxVWpRL2VVd2pjWFl5bHJKMnBP?=
 =?utf-8?B?dWNxYk9KTkkvdTcvUjFoSTY0NjAxVHNXTWFFVWczWEdsYjNpS2JNbmtlKytX?=
 =?utf-8?B?ckxqUHN5V2tQallPdFNRR3lZcllVRGJpM2hHNDl1bmNielFJZVpxbTNBdm5x?=
 =?utf-8?B?REJQcGFoNkFUVGdNMEJTOWxxaHN0ci96eDk5cUUydmZQMUJ0TkV6cDJYcWs5?=
 =?utf-8?B?L29Kb0F6NW5rQnhSZVUySEViaDN2UVd2eDFyVnJkQ2FEVTg4OERNaHVUdno0?=
 =?utf-8?B?Ymc4d2FaM0R2WDFpYzVGQ2M5a1pmNFo5cGFRejBoYWw2SjBvRVBqcnJCL0Vl?=
 =?utf-8?B?TkdGK0d0S3lYYWcwQklzNHpTTmJncVZSbmRDdUJUVU4rMEZOSFNMTWpVcmtC?=
 =?utf-8?B?Qkt5emJvWnJJMzhCd3BheE1HS2UwelNxbmVXeTJYN0V1SktOTXpsUjNmbXJs?=
 =?utf-8?B?VXRiUG1UamV0WTBNa1ZPbGR2Wm5iRkFBSlk5SUNRc0dPdTZRM2NwQTRZK3I4?=
 =?utf-8?B?aUtsMFQ0T0JpUTNnQkM0b2hPWVhiUGh2QjJ2c2VpYVdMZldVRWxHYmZhcGlt?=
 =?utf-8?B?ZklDRUZnc01HU0RmbUR5K1RrM2I3YVZYUGQycVM1MWVObmhXV3Y5L3prWkRl?=
 =?utf-8?B?Y3V4VlpZbkRxOUR0MVA3NmhadGVjaXgwTlFMZUJlbmJTTDJPOUxrYzZxd0Jw?=
 =?utf-8?B?bFgxYUlGUjI2OUttbXBmbGFOWDFrMmlhSmg1OVhrYUlCc0R0OURGVVRaaVdO?=
 =?utf-8?B?NG5ab2VqR3pIbzRrdGRSVkFlalBiUk5Lc0xNb29vOUVVNjdXbVp3K2tKUzVi?=
 =?utf-8?B?ajNnVjRXaFVoOU41VmdrUzdTN3JidEVWYTFkZTlDZkVYekV5Ykh5TjhiQzdx?=
 =?utf-8?Q?5r1IaVO3cfh1N33FRincUCihm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffd818c-be80-4501-07e4-08dbe50f8ce6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:45:15.8014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SYspI5DLrDljtKcUOn2pyN2XIx0GFHrLxv12HxMKoHChSB05zpVq/oYYmbnNWsdQugtexF7E6LfupC1NDnwQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/13/23 21:49, Mario Limonciello wrote:
> On 11/13/2023 06:33, Syed Saba Kareem wrote:
>> ACP7.0 based platform legacy drivers can be built by selecting
>> necessary kernel config option. This patch enables build support
>> of the same.
>>
>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>> ---
>> changes since v1:
>>       - added missing commit message.
>>
>>   sound/soc/amd/acp/Kconfig  | 12 ++++++++++++
>>   sound/soc/amd/acp/Makefile |  2 ++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
>> index 5fb322212938..c8ac0027f741 100644
>> --- a/sound/soc/amd/acp/Kconfig
>> +++ b/sound/soc/amd/acp/Kconfig
>> @@ -73,6 +73,18 @@ config SND_AMD_ASOC_ACP63
>>         Say Y if you want to enable AUDIO on ACP6.3
>>         If unsure select "N".
>>   +config SND_AMD_ASOC_ACP70
>> +    tristate "AMD ACP ASOC Acp7.0 Support"
>> +    depends on X86 && PCI
>> +    depends on ACPI
>> +    select SND_SOC_AMD_ACP_PCM
>> +    select SND_SOC_AMD_ACP_I2S
>> +    select SND_SOC_AMD_ACP_PDM
>
> Do you not need:
>
>     select SND_SOC_AMD_ACP_LEGACY_COMMON
>
> Like how ACP63, Rembrandt, and Renoir all select?
>
Yes, this flag is missing will upstream the fix as an incremental patch.
>> +    help
>> +    This option enables Acp7.0 PDM support on AMD platform.
>> +    Say Y if you want to enable AUDIO on ACP7.0
>> +          If unsure select "N".
>> +
>>   config SND_SOC_AMD_MACH_COMMON
>>       tristate
>>       depends on X86 && PCI && I2C
>> diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
>> index dd85700f1c5f..ff5f7893b81e 100644
>> --- a/sound/soc/amd/acp/Makefile
>> +++ b/sound/soc/amd/acp/Makefile
>> @@ -15,6 +15,7 @@ snd-acp-pci-objs     := acp-pci.o
>>   snd-acp-renoir-objs     := acp-renoir.o
>>   snd-acp-rembrandt-objs  := acp-rembrandt.o
>>   snd-acp63-objs := acp63.o
>> +snd-acp70-objs := acp70.o
>>     #machine specific driver
>>   snd-acp-mach-objs     := acp-mach-common.o
>> @@ -30,6 +31,7 @@ obj-$(CONFIG_SND_SOC_AMD_ACP_PCI) += snd-acp-pci.o
>>   obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
>>   obj-$(CONFIG_SND_AMD_ASOC_REMBRANDT) += snd-acp-rembrandt.o
>>   obj-$(CONFIG_SND_AMD_ASOC_ACP63) += snd-acp63.o
>> +obj-$(CONFIG_SND_AMD_ASOC_ACP70) += snd-acp70.o
>>     obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
>>   obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
>
