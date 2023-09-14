Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC379F7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 04:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjINCKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 22:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbjINCJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 22:09:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0C91FDE;
        Wed, 13 Sep 2023 19:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvbwcnUhH0wBN/Mdr0dWs+WpQS838mRTESSCViDgg9MLAbEvJ/7jj6BUUO8LrRyzZBYQWX2UcHdHXQupQXeez5Qpdklx49MRV9siO0MBSTeCMcUDv/ZDX7f9PXUWHHXjM8qUdz+TzDUiuIiJDvAMdZ4lBa4UNET4EdqGkmqbxw3KtI6kX991l6gmEZZAZw/GVsRmdtGeHFjMm6068cFlFgupgxuBgOEqDOrXlsVwHQB4ZeXl7DrSGWmuSIuOYd8NDZ3xfRjtye2hqZ6J9QChp8NZiMy6660Js4ObjGw1/DbGDBn/Mapz0zY3wKYRBpPr1IA8B+eTOA/2Re2n1JfQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfMeQ0MG7xW43r/srcEMzFhYs5/pwTqwZMBfhs5GBMs=;
 b=g6jtIL/UWIvbYMfpViG1WSEvmt5FjwUQZ0+YVV7lAMLZEWeADwKLrF2jVsHMl+Hb+FRxC5rr5ECCAPxzf4tsGFjBHx8HBmMpa7gJ8AFOveyfq9sK35U6fXP3iUSL5oJtM9BW9p5SxRY0Vlu1/urY7pXty+Jj51xVAZa7Np8X+ib+nIwFymuRGlJ+aT67/PSQ1OhOaxI0boMRU2pVlH21vqa8phgPvVt15Ut9nslpbFxg7lWRGrlS1DBvblnsrxmzSU6ABeqhuiAblcsrL05TkXlLGE3QLD9WS8d6mRPNiRRE9O/p3ATtgnmsv+Ox81lcYZ8wwQBRyaipQf+/OQxNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfMeQ0MG7xW43r/srcEMzFhYs5/pwTqwZMBfhs5GBMs=;
 b=SkQ1dOqSdcymeM3MroJykmQdLiwePYG/xkZwLYGsbIi3p/bSEGfONbcNtIxaB+KDI75Q2/b46WEw1Ug7T3IO3Y2F+10yu9qFSzxi/QiKhUG1ZKchjZ/O6x9SbYH1pSumq59td48RulnAL9Iwq0op1GsWXS3Eh3WajdVGvya4JTB4MwTKuz6VeQI2qe+g74jcG5b3MRJ3txiKvEhAr5kfdGHB4CsXZQv9UPd6RS5EBa4q3GU2r9gNDC12RGw4D3ZsntFUISQ2rPFU/5gFpsNe7lSYvvVJ3xSn8VY6RrUtFy+A/izaiZn7BUbi4UmSz3Ai/oQOmYKdyltozJOoCoYvPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 02:09:18 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::5cc1:1ea3:4ec5:72af%5]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 02:09:18 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: nvidia-shield: add LEDS_CLASS dependency
References: <20230914000517.16252-1-rdunlap@infradead.org>
Date:   Wed, 13 Sep 2023 19:09:08 -0700
In-Reply-To: <20230914000517.16252-1-rdunlap@infradead.org> (Randy Dunlap's
        message of "Wed, 13 Sep 2023 17:05:17 -0700")
Message-ID: <87r0n14ibf.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::16) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ed9abc-2240-48e3-8f62-08dbb4c799f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m0Odg9bpeg38IukQ8AbVo4PQiKfrA5yhpkfF4ZFeo/zuhnVAmfIu2XP9dPCzdjnoPsmdIyIee5lIYY6Yk2rONtcG6hJ/bRDRiy/FZc4e//UB7tVHqjlGWOXMLPhpRg4EAzGY+stX8bYrXs2KqTlQiN9A8sgC7VNIRfAwpxnbhxmZBXEvE5+OhqCI5rMFI6Vdc0yQYSemnWiYKN/Ch+UKaF3PXmKyX38xnHl4W7TjnmV1ASTKE0PeKKY/a5sV/X7NcBPEa6QV70htX7ORQQED8eMKQ8YIn04webQ/lRsISHmHkj/JrVC1c7l4gAcFk8aikYsn4NbFu588qaRMJqadUZkce0BWtZmMX3WtJ7fw6J+dB5gfUVH2w4UEKQGO/uRp7PPk/Z7EbslNukvx6K4JRayUc3rfXvLTPgPnAEaiXBpaLhUvcTyXfKPF6tojLQk2iZvSFO4NADWK56++JUAcPu/HcjogkpI+oTyQ0EN5f1TyWqk68djcUmV9nhTh7KnK5DoIi/+NUGQllRB62uOCLmOzdGdGm0GqpfHmjQtPk8wXsXZVrMhlwiIWuOgAF8Pl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199024)(186009)(1800799009)(41300700001)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007)(5660300002)(316002)(6916009)(54906003)(2906002)(38100700002)(83380400001)(6512007)(26005)(2616005)(86362001)(36756003)(478600001)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rAsj1cHXLxoA5YHQ4xqbYbTcVqmkDit3fYtwVBkIRh67b7HwToOhMvl0oezc?=
 =?us-ascii?Q?jaCt+h+Q9IDolWk/4zVsVrLyPMNsueZ6Uk2DIjZc2JNTh5VhXyQ/boWCKcpO?=
 =?us-ascii?Q?/adxVvMOF+J0pOVJAFEDElvZVVs0yAk0+3/NcJ+hEHCilDHVEHKtSINte+8y?=
 =?us-ascii?Q?Jkg85F8C0zuNh61Rkz1gDqA49sIvk+/xqm62evKPhS5PaY5B1mWA4MDYYz/B?=
 =?us-ascii?Q?/spy7aDVzPX3qXVjPVz2ZpDf3huEUg7FxbvK2Cow0KE1T4WERxuksW6yVwe4?=
 =?us-ascii?Q?QV0fyTs+sXFC5krftItydBYLzSs5omjFKTkj8jd3mrD1xe58LiU1mD735Xdd?=
 =?us-ascii?Q?hyZ33zFYEE6xbm8WdlJpYAfIXN3Wfi5O7qcWIT/OzEXISv7MxmUvzXnaENbV?=
 =?us-ascii?Q?gSc6we3E4QMA4okKF01tx5P95oCQFdoEqGYT1Iw4+pkM97RpGltO5qfIlRtu?=
 =?us-ascii?Q?WV0yIBIjiLhDM0tV5VHrZwWU12iS8yVlOQRKScyR9m+XK/XuTWlvty8FLJll?=
 =?us-ascii?Q?lczcB/hzNhbMdRczO89kdD5WKhoZXX0ZHyHEyKA075Tk0KemvUZYAfzsVYmU?=
 =?us-ascii?Q?AOtwlPKf2/nOyAMKGBtndVowk+mebzKCnywhmYTsCnwacuDYiFeT2ISwcBgU?=
 =?us-ascii?Q?TWwEgr5Kl+/fB9IfPSgByMsD5/BMgWK70KbE5kWuylWWdBtVFfasyMHA7WTF?=
 =?us-ascii?Q?OEJryACq9a+52v5Rfrzgm1jRiuwtc5jzgQCWxOx/aKHNioVaNbBL8maoNQFf?=
 =?us-ascii?Q?icbqM7PKG14EdEW7NKgxD0Rr7pNuOSgblt2ujPksN0zBa2L6iZJzB1TQ8E/a?=
 =?us-ascii?Q?rmvHO/LSZM9hksQgUFqS+emi79nesQXOH17GsHJ109ArjLmXMgvj9U60K+vv?=
 =?us-ascii?Q?hcI84NA58Fwp7IjU/nMxi7fJhHI6ZjtWlRwl4znkhRf9kI4tjmPnR/uSnYh/?=
 =?us-ascii?Q?USF52z1G7zB0JOHZ2YAnQhwv4lKj6RvZFwcjHr4fMdMnvQLtr9nMfvhHcX2V?=
 =?us-ascii?Q?QwuC3c2IrWFilcY+vDkysFUfCMf7Wi43brQVRmqbziwOvAP7Wq87/OW1JQTt?=
 =?us-ascii?Q?xIIITeIIrZWJFxTfkhpI3BfdlOKqdFUvP7YuwY7nT5ldIgUUMJw4V2Fb3JXl?=
 =?us-ascii?Q?OJ8oGPqOdNhz6vZHCnu4pr6flbO/zo8hkV0ojxHHwEoRqGTZmIPL46YDflzL?=
 =?us-ascii?Q?W511POeX4qHPWVc6DctXes2bMVOovFGZLNWGbqTI2QQTzK+I8do5Ir7LA8Zt?=
 =?us-ascii?Q?g4eMHl+rktS4kIWzrpcJGKWuGieNDQGhBVeZt5I2JCucOZBrFZD4BJsdkgRH?=
 =?us-ascii?Q?qHeyx4A9UaHTDOmz0v2mmLCiZbY9N26r8hAyzrR4ab833ASpiMAAxiJ0x56T?=
 =?us-ascii?Q?Zaj/AVgZWx5GBH0it805QcKJDZLvyEDuf1fr46xTPvlmLqsqQtPY5WUyNEzf?=
 =?us-ascii?Q?jHycXXQemeDVIcUfnGuxk7LrZSGz86YSL5yOnev0eQLgYFosjl8pjPN7eNUd?=
 =?us-ascii?Q?7Q8tXu9J7+tSFd1+dcxuMXljB9gAavzzZJRR9JjLcuhMxyO68w2/EgBqMFHv?=
 =?us-ascii?Q?xDjG6GK8wXgHE3gJbQ2K7FYE8+rKLLvWx+iaBnyH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ed9abc-2240-48e3-8f62-08dbb4c799f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:09:17.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 200xd/wbY8yqD/CH9h+lIiCJzRgxLp1kUeW4/NFRUMU7hTtNz5R9N1ZAI2F/V2brB8vmVeZCTcoAUgDFmIjckw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep, 2023 17:05:17 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> The hid-nvidia-shield driver uses functions that are built
> only when LEDS_CLASS is set, so make the driver depend on that
> symbol to prevent build errors.
>
> riscv32-linux-ld: drivers/hid/hid-nvidia-shield.o: in function `.L11':
> hid-nvidia-shield.c:(.text+0x192): undefined reference to `led_classdev_unregister'
> riscv32-linux-ld: drivers/hid/hid-nvidia-shield.o: in function `.L113':
> hid-nvidia-shield.c:(.text+0xfa4): undefined reference to `led_classdev_register_ext'
>
> Fixes: 09308562d4af ("HID: nvidia-shield: Initial driver implementation with Thunderstrike support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> ---
>  drivers/hid/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -799,6 +799,7 @@ config HID_NVIDIA_SHIELD
>  	tristate "NVIDIA SHIELD devices"
>  	depends on USB_HID
>  	depends on BT_HIDP
> +	depends on LEDS_CLASS
>  	help
>  	  Support for NVIDIA SHIELD accessories.

Thanks for the patch. This also reminds me that the same needs to be
done for POWER_SUPPLY since support was added for the controller's
battery. I will send out a patch for that soon.

Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
