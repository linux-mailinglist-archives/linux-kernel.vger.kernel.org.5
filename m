Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40DB75660A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 16:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGQOOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjGQOOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 10:14:46 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2180.outbound.protection.outlook.com [40.92.62.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDACC98
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 07:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArLK4pZjiXCCjTrMF2qVZftrLqgrWzBiE5tev3r2nQW2+JmtbDwj9cN8M/jfKKVBmfgrHR8vTfsXJ0dUfu5C958Kxo0+E1gxwgEePfuKhNUloYSyYqE7trMenSjUcrmfIylpq30zi3kouVuKy5LaqzGUbmnBEeVCn/LMA5QXXSjQ2T8iV3DuQATAdtlUsU0tStAKS6urcF/507EkT5pUuq0Pk1y8Ro/CDpvjGm82KmF98KQmhHuGNPgSub96PijzSXMxJNvUZ9yLzvb5/+aDmLkgPeMJBa6CAQbzmj99zeviSQ7qtRfc7cPlhEs9W1z+CJBzkucGYDe87xmu5EZmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5Ua9q0vJVjyvsdJ5XbWStiiNEWQXyUO+jkHU9D95SQ=;
 b=FaThyPozuDqeDgDYfv5RaotlrfUlZB7ZVIaxSHmE9X8tixMbUsOEa15qSVI+/GB2nT8rE3b6bXmEZSqvAjdaITVGWej7GMOsKUyHyffIBbhrKa/XfBoKn+52OD1R30pp3A0KDYx6sesUBqtwT/hZi9zX+z92orL7CXCCbOnfivZbbb+t4Gtjt+9FBr4F2tQVzzWAcS3EoLDZjJ9lNPGwooub6T4M8AL9b9a5b06vQHPMALdkUxwxEdLfKOBI8L5LlLl25T5lAyYtV2qEidErWB2/BMTCyLTtqTVXsgvnouWZ8zNTlrvvdf59AxaKNuWaCRiWuapumXHbSt5LRpFbOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5Ua9q0vJVjyvsdJ5XbWStiiNEWQXyUO+jkHU9D95SQ=;
 b=iAOsLJpazsRC3eP3hHgTfQzyBqtpXZgDsIS8H/k1Shdg9Pj0cdrub47GCuMfN2NsF+YAbYDdpDiGfYTior6OL9ClSjZfdb7Du2HLCwv2ogt+L1ukSyAlkp9Q/sen5zYcfR1tpK+h7mZ5+afcX/9VNutYbyOCHmhZ8+3tzW72S5eam5LDZSZllnbgsXQYmQNGhPAcgPOzsngI5GjymaoYSpk94KipV79vwGxFa1nE1J4gfJ2TL5HHcil2yf9QZbUaoGka0ZBDyDOGVgjF+8pvCSo26CVAhPm2snwti4rNiAAlwS1tWWa+fUSFDHumrjYCE0e9hKzK8A1FL6FYlwM4Yw==
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c2::7) by
 SYBP282MB4213.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1a8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 14:14:37 +0000
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::42d9:eaab:e6bf:1f81]) by SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::42d9:eaab:e6bf:1f81%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 14:14:37 +0000
From:   David Xu <xuwd1@hotmail.com>
To:     tiwai@suse.de
Cc:     alsa-devel@alsa-project.org, andy.chi@canonical.com,
        david.rhodes@cirrus.com, james.schulman@cirrus.com,
        kasper93@gmail.com, linux-kernel@vger.kernel.org, luke@ljones.dev,
        p.jungkamp@gmx.net, patches@opensource.cirrus.com, perex@perex.cz,
        rf@opensource.cirrus.com, ruinairas1992@gmail.com,
        sbinding@opensource.cirrus.com, tcrawford@system76.com,
        tiwai@suse.com, xuwd1@hotmail.com, yangyingliang@huawei.com,
        yangyuchi66@gmail.com
Subject: Re: [PATCH 0/2] Fix CSC3551 speaker sound problem for machines without a valid ACPI _DSD
Date:   Mon, 17 Jul 2023 22:14:17 +0800
Message-ID: <SY4P282MB18354B658F2FFE36E6FED411E03BA@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <87zg3waunl.wl-tiwai@suse.de>
References: <87zg3waunl.wl-tiwai@suse.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [9kA2XvV4uynHXP9PdnK2UftfNQCpv61e]
X-ClientProxiedBy: SG2PR02CA0104.apcprd02.prod.outlook.com
 (2603:1096:4:92::20) To SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:c2::7)
X-Microsoft-Original-Message-ID: <20230717141417.163591-1-xuwd1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1835:EE_|SYBP282MB4213:EE_
X-MS-Office365-Filtering-Correlation-Id: ce582c4f-d861-4e1d-c60d-08db86d02719
X-MS-Exchange-SLBlob-MailProps: YfhX3sd/0TWYnBBcTvvGLleK17hkRWRifCYsPdzpOrPNGQYP/ETw19XfNJlnKZ/uQYX/JpesW9FtnlDeNsgJpQc9yfQYRp1Hd//Q0kq6YhtidQ25C4ooUGHxCfs3MIKqNNk0XcHTeJlR3mJC67f77z2T0ZEiLUZIBZypOFilKYbnjOuEphPeNuRVsATitW4xqebMPQglAp5MS6jxwr9AGZecct74OSvswWEuuhuh/gDaW1tEWr0YqzS+SvHGFHwEi3jXwa/04H6OEdEwjLi3xpWz7JCQkFyiIf8Bsk0SZAAlrUGHaQWqf101uvcbs7OVZfS5888HZZtdY5TVnvhgSPprWTSINp1fGetdUNbZmKUyQsOYUs0t78zax/Z/3+VRLjG8l+nEprlFMMA96NiRZBHd681uguXsDZVlz2wuGW5OmNu6r5ZM5T7T5b7zmHn59V9g9zmTV/fNs3rAqVFZXCVUJ3CV0sbIwaxbJ2KT+tWz/4Ci5C/dLJ1ksVMXfuMHBX7tYCKhv/Tootks0/BB0s+Ndwx+wgm8Yoo2jsx+A7RPVE/aOJMJ6nuBp8SS5Kt1DUPiF/fDQ/knIeyHpXbS7vb9bRxhMSYr4SHC5KHXDQvl3kZu0pKbCmG2BbDnMLm6dTpja4PDNk57t5VXwEyfal5t/GflhJUMzta27ltXbu5X4JZWVlPF/TXZ2lLctRibT0g8w803RCzlExwtgC/HPb7Kk/PNNeQz9Y9Oub7b4hfJ8rRc1geOZLya0yL2M9Rw/pr3B5AOoJLks/qu/55oYWtr4ICUIK+G7gDjNWn/9R0=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+UISZR1lKdMxp6UqqwnZzq2UyYHubRNwRbXnfBO8gOc8iMTxaEHOIeEYx7zq6kDpFCrndvnSX/ElIC25Mwg+1fOzcFWt8CiGkFQaMjNQf7ij0pFnszYJXpcIQgpMRh7Hd2BMR8bWPmPbmlf9IIcvhpcnh4K26s128l6WIT1QMUfQebu7Qhus1bd5oj5PSLsr8IhDgl2dVdrzEzBZ2NaG2xbuyKhmuMp8M1mfkHOKHIBhkt2jWi977c7GiGr/23F+ZZqaeSrCxLZSMSXIthoXaU9wQj927/zw4Rrsl3+3G5BzNCKmfoO4ce28ZkA2rOPgCfL3x48kFKE1XKeDy3zt3/jyRjoxC9E3qBtKQc8fAjoJyxiwpKNvBNjNOwae72NuvHGCoPfr+vS+fJqGYbyQdDtXv7EEGTQkuNHOQinvUNBtAaecTdHtLAiKLtPdvQtKWqrQcHTnNuOrpVbzAp3KzGcvPJuWxJKBuKukw0DkbQgVTWbfSY/0DqCZaGKEhrXOf6GA/+4JzuYo6eO9f+VpNc2wVeLvXNJneFYdMD23JyPJowCESyud4Gy4xo8mBOQtf7sROie02OFUvYTOw5VNk4Vqyw5hMTHPgAygrm7Og2OHWL8QQgDmdY+KY0/pXjq
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Zvt0NhIGRHmnXqQw+SMOugcKwP+i76kF/x/kkkt3fOkfkdb6PWK8NlIcrTXl?=
 =?us-ascii?Q?FduDGA6Z8I7Gsknk/gOiG7AR9v1+qHbWYwmGS83/kik56FijtEIBN6C3JLRP?=
 =?us-ascii?Q?hvdxAyFbdNIPxba4unshSAqwFYjUXdSoW8JBkJS1KlTbJsHi19270wUwkRGi?=
 =?us-ascii?Q?sOUjpznFSPcGQE8CEszjnbErBIE1Zs43Di9Ir8MK0aLXfKTHCas+f8qleEBG?=
 =?us-ascii?Q?vJjGP1p0z7TA2ma6qd12p24lJ4GJaMpxjxFi2Mp0uKEV9tRjQzVqne0HC8a6?=
 =?us-ascii?Q?8/lQSrkSZvebumQdeeEyZf+AzmMWJvFWE7gVmV3Zvl6pSj0JYbIje9RnWTaU?=
 =?us-ascii?Q?aAMolaXwr8I3R+0mzIkuQZIHiib2lNTK/a0xpq+tKlmqLeRRVM7KL5fb5zWf?=
 =?us-ascii?Q?7j9pEZ0F9HAP5F9FxFdRU5qJm390CpeteTuC0IPjtWqEwpaVjsBa8JiRZAVA?=
 =?us-ascii?Q?eH1LmpI7J+5v8RLN1F+ZEaJXnLxC7Gc5eyOv1+NML0MsKT2+FIliC+RaPdBU?=
 =?us-ascii?Q?lC7u7blstr7Nkcpd7ajHVVgnGxZcCTnxRC5BGNSFxnzAZTMm06SOspEQsTBH?=
 =?us-ascii?Q?de37oSjSzcPZU1yqw+2UA/vh6nQiTzICt3tZRw/ITx8rgZa7qfQfkNrvOTT0?=
 =?us-ascii?Q?PdrmkAo6703sUy0iI0+LXdGY3B5CRMxzpkrmfKumvYMnCNuVich+eA93kERT?=
 =?us-ascii?Q?fl7W9g5p2/k997W2gQDS1DXU1+h3MwHoz3qfMMvEEDB2hEK4suur6XJ2wplH?=
 =?us-ascii?Q?kX3Y7FCH8+k+LsNhToFE/kIMabE1H/sEjCSrFgePYyeianCEI8MohqcjZ2Z6?=
 =?us-ascii?Q?b1MBhO41sZnmXSK27QkCXyuZR/pK1qXR3km+Mh7/8VLuLISnNvBMDlJHi727?=
 =?us-ascii?Q?x4w7/g2k0HVvyPAYTAWvQ9r8oMEU0nkQaJsEsvDuRKa3pXwfRVwXUyxshG8A?=
 =?us-ascii?Q?WaUF2YTHDTRxZjwnCe4wK/2uodLzK0duRdrbkhyXij6r3upqlF/HQd7DjU4W?=
 =?us-ascii?Q?JflklIxBvHQqYzgSfGuB6oWFcyCn5MwOgTZ2DAYFi19nsdOnYPjXprT/8U+P?=
 =?us-ascii?Q?3pXVQaWBivTVkSwXD4MTEBOs5G5mDkDWaCcO51hDKwLBB4aIaO47ch66hyn/?=
 =?us-ascii?Q?SjXBZKs9WHcnTUqsJSoZGYqFuBPufkJqQTlTbmT5iXDDB4X8lZK6WlL+GglZ?=
 =?us-ascii?Q?XqqdJwmGh2nr94GadhQPbWx0KRWH88XC3pu8ZA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce582c4f-d861-4e1d-c60d-08db86d02719
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 14:14:37.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYBP282MB4213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

On Sun, 16 Jul 2023 14:49:18 +0200 you wrote:

> Thanks for the patches.
> 
> I've seen the lots of pains with CS35L41 codec stuff on the recent
> machines.  But, first of all, it still needs to be agreed by Cirrus
> people whether this approach is acceptable.  Judging from the current 
> situation, such workaround appears inevitable, but we need a
> consensus.
> 
> So, Cirrus people, please check this.

Agreed.
 
> Also, some ideas about the current patch set:
> 
> - Do we need yet another listing and check of each ID in another
>   place?  The existing entry in the SSID quirk table is already unique
>   enough to identify which configuration is taken, I suppose.
>
> - The quirk entries can be gathered in patch_realtek.c, and the hw_cfg
>   and other items are overwritten in cs35l41_no_acpi_dsd() when no
>   _DSD is found.  In that way, we can avoid fixing two places for each
>   update.

I do have noticed that the existing entries in patch_realtek.c are enough
for locating the right quirk. However I'm unsure if these entries can 
be moved to that file since the cs35l41 i2c/spi devices are instantiated
by the serial-multi-instantiate driver, and if no proper _DSD is found 
the cs35l41 driver would just fail with no corresponding i2c/spi devices.
I don't know if it is possible for the hda driver to intervene this 
probing process.


> - The workaround is a workaround, and it's fundamentally dangerous.
>   We should warn it in a kernel message.

Agreed. I will update my patches to emit a warning message, however as
Stuart has replied, a patch series which is cleaner is on its way in few 
weeks and I would not submit a new version for now. I am looking forward 
to Cirrus's work. 

Regards,

David.
