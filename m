Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F412752852
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjGMQap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjGMQak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:30:40 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2169.outbound.protection.outlook.com [40.92.62.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DD2D4B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0V5cnpn7Yx/wxOsxsKjfvLyhpCx+FU0BucstTdhVLvMgha2l4Ua7VZoYEIp5Lm2f6GDhKIBDOzqbstHRCh4Cd71HB8dLUr8wDoRx55Sdagz2cinFmKWhvfz5Mggut3RzyLdyhw8gMxNxxA05KNFdfYUs6qXX6s/PvbHQxSTUfNxQBudrt7LVrxG174UIPfroXqA54LAx6MG50cCdIwtFd+A33Te1zWpM9lsTB9qAkQfU9Cwc88pHXidJZ6YUZ7J/Pa0JEK/zEcnEol16Gmg1JZkFVL9i6s1+3IqNasYYD1IwsmVCAdc+3UKzCqwpoFoAfVLpQj+KxJazMlqJGXgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQdNsbOGTZM22GthjPokb6fIXvhlSUu4SdntYZsqhNE=;
 b=AXB+OQTU+drbodaRsA6GLRXeFpAckwW8BQo33k/GTncvGdnu7o0ChzEGMoPtHpXEqNAnINCw/UGtMVoK0FE0i85Kg+LYzB3D5Lg6Kj/nv5W/2z+lS4GnFbqPMnz9RelUY4hm1t3yXEm1SWftMkRwlMtSuBsin/7pTTXYf7GQl2vtkJfIy35KMkIFXiF5C2s8UB3+w3eGIUhTf1eDc9mmi2y8p/h07FklUMqmoGs/gyjg+d6gFOKH4lMHyhCvwx30hQ5nchmKDqTb+pT0L9M4xssh73Qzt+6/NT/PspexGDeHgpV9HDeS+sgl21Qm3jRRIQG7pR6VeWMViXHiqDJAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQdNsbOGTZM22GthjPokb6fIXvhlSUu4SdntYZsqhNE=;
 b=en+4vNE7wfT43Xx+g4PVv1kgQD30gERDJ0XqdHI+X1sVBYmNYkhWke3NrrsbR9ohq5gJ4tygf+iFikeO5BvExVDB5xN6aSRjzOhfBc/CmG/A53SPKPVtbmDcmiqCOCr2j2uhtaswTiDevPyuSAlPzzojUjFrNrLIXKoWPdpRxJLl5YyNqeaiOnjl5/116+/G+XfrEgIEDI3ctsSgNLINNOfanNskHaNN0Vld17U0XtBVQ/CMEj0/ydbTMmhkVyTWFUic2sA7Tsg1SALxwDF2vz3A0vpvUSJtF7fZKDkssJ7Tc8rll8g2NXZ0GPmHO8m4ZisAdKYXf920C4/z5pitkQ==
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c2::7) by
 SY6P282MB3254.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:165::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26; Thu, 13 Jul 2023 16:30:29 +0000
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45]) by SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 16:30:29 +0000
From:   David Xu <xuwd1@hotmail.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Andy Chi <andy.chi@canonical.com>,
        Tim Crawford <tcrawford@system76.com>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        =?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
        Matthew Anderson <ruinairas1992@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, David Xu <xuwd1@hotmail.com>
Subject: [PATCH 2/2] ALSA: hda/realtek: Add quirks for Lenovo 16IAH7, 16IAX7 and 16ARHA7
Date:   Fri, 14 Jul 2023 00:29:55 +0800
Message-ID: <SY4P282MB18359DB2390AEFED26AC53A0E037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713162955.34842-1-xuwd1@hotmail.com>
References: <20230713162955.34842-1-xuwd1@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [fs06H3BeN0QhvwCjWzUObJafeZb21865]
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:c2::7)
X-Microsoft-Original-Message-ID: <20230713162955.34842-3-xuwd1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1835:EE_|SY6P282MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: a82c8a00-d375-4dbd-3780-08db83be7891
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nN7ksDdJHhaEOcm48SSgzZgL6F/YuI9gmDi06p/1nukHZHE6nO4AGcmdlQY/DGuRoeLrjaXGQox4eV7oLAgiy53MyOGe4ITqKmEBRCtduKs68ytc3D3XTYUNbjfomsc0AcQWnyF0bGDeU8Mf1QKE23AGgtJv5oSZjFjDScz7MrN9K+I9zU+mmkakoLvA1xuQwHJ4mru15wCOqjUlzbnlwW3OKhv1BwWnIBtkWgFL3p93MEhTTnptmgvuAK91yhs8P6stXJTaSjUTsAiJXEIqabxRSF+ex+FE+Nsi+GfSAY6H9Sge4bCupauyptTrqQkMv3kXlG5XEiup4pbQVFmr/36yKUDFSxFjbKdRg6AvdcxVgFHmhO780cIBL6flH9WxZcetJ4jAyKI2gNrxU0LdIM6OYU7ovnLoj7BnjsFLnsSqtRq+otRvCas9qek9NL3udO8r273lATequ3TiGJDDFpxLaWV5Qs9hIe0YSC0qgwRk9Lvvm2mLu+584UBGPoKUamZ0AZkkyuy31NgR2VN6lsM8Z4q7HHkZca4dYaUlxJBj0OOEvAMSqf809FtENfG1ny6aCDXPIrdo4Y33Sr715+LXvy4dsBrhcjjuDM7JQ+U3aS6LReo8GCTgHdpFmQYzssNWnWPZ+r/fJqHRNrnxvt6lK81B8fXeK8ywu+9I9O5X/bNWRFGr9pHcdG6rg+3BV5Nwq0HaVYV96owNJlqStc7XDWj0JBE6lIOqFWkh/P+aPMdDwZuqAX/J1JlhL2f10T1em+OkVN6XagHXsaSDwP
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V+NQtccZQi1wDKQLtcMT/SJtHEb72MWgEwaGeJ71KfdrfRQQMV+JPb2OlqYu+qa8D9KTSXvjeji00BHsLgw2q+nLMtMXOMMmDgRUKaRJOzuD/bPknIiXDPJTNwDI3NAgYu+Uo+jnEEJ59tMgjJeAqe2CKwKVMJV4g2CmDfpBnlvqnMTezl838hN6/gjLY7pb1e2y0G/68pEjgPvwD34cls/mKZVuH6DmHF5LKzZYafun0SDAoc5lt52YXPVWh+NgIzpc1w8PBDvjCqKWW9QT6PwBryWjzk8bBTiXJLJyDkyfc01pGE7MgcIO3wqsILg+s7LuNqg7SaqPthqIFUGHhazxQ+Zvely5ltK7mG+OXdeCMv//aSjnBRD/7xY2plGVw5YokB2yYC5mkJm7AMGxRcOfjUUReT23213M2/5TC2QqQB9eHtXm8gYKPhnls1b3MfwyvJdy/YasdXE56gZEhN3ODCw/ntRhw8tGnyC9PZEHZFld9IbCuO47LgYSmXJe4eXme1APK5jZPnpGg2JD6s+ccA0hmIMEqciFogaMe0Yz2xbcj7vDPi/XVtYSArrQLMIjFJP6Jr1A0/NMRjNm9Fl4EiJH0VbYEhiaRJj04+I=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O6tURigrd6yLj5RqLTx5IZg2qK0XszsGFe6XWCkCqxaq7z3SV4a1htx+6kQF?=
 =?us-ascii?Q?CDltjBcgDnU84bXbW0zpa7QqRKLqdMmrFE6pNUpXwjBEWjZBWmVsVOwRTLfD?=
 =?us-ascii?Q?N9NyW83/P4gFO3TIT23on+Osh2bNTkGQN7wUZW2DoRe8Ds+Qj//y4Ufa7k0U?=
 =?us-ascii?Q?+5ddRxRS1cDJYfeQRHXVkEE53wOkDYWHtqxjWGYrHcUmz6RDiN+c0Lx3+iNS?=
 =?us-ascii?Q?RbrvWH7dzTPscuqfJefVhku1Lmmxn7Bovdb2E8kBuqQpR0JkyU7ndoXGVm1p?=
 =?us-ascii?Q?Eg5SXB+sTqrY5P6g/OEP2BR7WizSZIDSjR9R7qS/F0zmMj0GzBtRRxlcMYZz?=
 =?us-ascii?Q?KbEjHW54Y4J3cJxSNGh4UtrSRQusoBUUbLylytYmj1nE16+/XmSMkZvZQxHu?=
 =?us-ascii?Q?RGu6pIdCwj+7vaDunaMkVBG+wffSYx/wbUv8X8VYjlXpUVg/uBgotFWf23Sy?=
 =?us-ascii?Q?V6VKbdzsoF3Z7/VrmmG6d6pQv1cEp9v0mzU4miftqtLnjl3T4Ayz3zvRNv9y?=
 =?us-ascii?Q?nM3RKDB2Y5Psdwg4nnWRoTW9H726P0VhNSgnbJ4VxCtYanCis1u4tcoj8go7?=
 =?us-ascii?Q?mfnneXbAcYYRCnvovDbwN1bfR7aWqrvEZDySPFIpeRVKsmk7mHSvEKMCbD6W?=
 =?us-ascii?Q?tuv8fzNpEPK0obQuWLm/uKkWMB8RBaCCZOZz0WrRerh95xVX4Xh0zkYXKjrB?=
 =?us-ascii?Q?y5egHrn0JOGH9C9AVBQUbCGOJNYyUu4mlZ9U/0o3O3qn1CF5aT3Br3qMHkUG?=
 =?us-ascii?Q?GgZu5KiO+AMvSxyQgeTv5dvYuYblgVEyvRLyLah0xxXahdTshWHl+697OfvQ?=
 =?us-ascii?Q?2W6bcK7f0dhJzLdw/IVklk5rVpicgD3YGkV+2H6y5K78Wm71ZQpuLsNg7t8i?=
 =?us-ascii?Q?N2EXYkbGDOSvud1cbm+TVHXg/ULY0ZLnFDtUi2d6AmcmN+BZ21+5i8G/G50L?=
 =?us-ascii?Q?i5wdPiyRJQnhk76wv9L5Ys62OqpR4VXeUHi19jaobQ8halNwgS0BoqWardU5?=
 =?us-ascii?Q?6j+kInhN4IBuHSonKcQEH1paNe1hRdiZxqAPl32txSqWr4YdeI3/sR6IGbuR?=
 =?us-ascii?Q?xDTf022ZLWHxxyGhsPeJcZX7i27BOAKT8o+aOS6OqW/B9XDFHqrzU4Ui/aPn?=
 =?us-ascii?Q?zgavq+3SXaMFkQWLwtaE5iHki73si6nJlVS+rdZ8370+6M4yVFIG7whd+Di/?=
 =?us-ascii?Q?0FbHHpfFRIaVVr1gMCAUHrYixMdZ0BT5P78Hwg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a82c8a00-d375-4dbd-3780-08db83be7891
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:30:29.4738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY6P282MB3254
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add quirks for Lenovo 16IAH7, 16IAX7 and 16ARHA7 that have dual
cs35l41 amplifiers that drives their speakers.

Please note that this patch depends on patch 1, for the added quirks
to work for the specified models, proper CSC3551 configurtion fixups
have to be applied.

Signed-off-by: David Xu <xuwd1@hotmail.com>
---
 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e2f8b608de82..cc10bb8b75d1 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9831,6 +9831,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x3803, "Legion Slim 7i 16IAH7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3818, "Lenovo C940 / Yoga Duet 7", ALC298_FIXUP_LENOVO_C940_DUET7),
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
@@ -9846,6 +9847,10 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Slim 7i 16IAH7", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x3874, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x3877, "Legion 7 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
-- 
2.41.0

