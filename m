Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC83F752851
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjGMQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjGMQac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:30:32 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2142.outbound.protection.outlook.com [40.92.62.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A882D48
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:30:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyCZ5Gl8c90W6Ti0BMCHw0nCCbAwUw3jMqzgZ96NChZ5jyptAQG1tGwFSXY6Eqm3EK7lA7rJXn5yL+CVyLOR4gSl0sHJdn5BF7e/qdRlTLjPCL2dPkVCnh4U1j8iUAf/MpxA+YLdu16q03n8Bs51xRjhDh5DzSxuSWwjQeZt3xmxaD0PTeZNMM4dxAMp5WNDBmhH3HhYkGT4HdhpnHvGgVcdGq2pBh210L+wEmEx/S4pzcj4DzXOrrBDE0hmjF18D9Ak8dabXBYS8cN3MNlk1z2EFAIdI85rmAiD8frtt0kmALFBxyUPJl1AU82NlcUc+klqOqE/f+Ig/jGWWjvolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiM5ACtRKWyqpRJouSb0PfBWJyX5BGcnRrnlOufDi78=;
 b=fdLJVYjzZLjUiHUguAxDc3P6RI9Rdf/kwJBmFrAVYHvWJoE06gmeAIDWXhQ7v8bDnE/5qNkBUI6EtL3BdyLFQoZRitkNk7Hchu72mc69S4Ij+lgdaLEDKwAMtqWpv94bD0Gvsj8qUuHVx7sRh7hOSDmxiW/hmvNiLAlUX6jPCRvWA0IzKn8mVTnOYGybZB6plvCH+WeHlZqpGqbklULIZZ29Hpfkr66dnwFLdnq16cyHeQSDqcmw+5+pU6c87NpjIAFSsmA4UvCH0DOTOLJjZkBRTiaABYmBzq/Ihp104IDxoloauWce9/Hp5dvV5IGMMtQ3RFglGN+Aw/l7G59IWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiM5ACtRKWyqpRJouSb0PfBWJyX5BGcnRrnlOufDi78=;
 b=N2yZ8FQzj5U5u9H5Bg/DMkEJ4VJB0tXASoZkT1zoF7t2/vk9g6NX5OIXHiG1JbBVwkt6TqRpKA8Hp3e1P2JvP+eACls4p7nQCM2Xj3p6Ju3h18IQJU/fdKm9/3nUcBKdfbvXnQ04zazNCi1NVP0K/EtzOhHyOATkEpHf1AzsNfO+YYcJsetYgoeIZTVlUVO9whA99Ghi57r9XohamIM6P4MfGufqqAvkpNl5utUJkzAH2/nRCvaBqUCXq/jaRaM1VH2jfDKsJA9LmqhZrZ6kcJyJyaMuys7fYh3JwFnmdFOyfp5KYKXnZ25kQ4Ci6ZafwvKGLUQTKmx8jYyv2mqwgQ==
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:c2::7) by
 SY6P282MB3254.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:165::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.26; Thu, 13 Jul 2023 16:30:22 +0000
Received: from SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45]) by SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 ([fe80::8302:9e75:933d:b45%6]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 16:30:22 +0000
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
Subject: [PATCH 1/2] ALSA: hda: cs35l41: Add fixups for machines without a valid ACPI _DSD
Date:   Fri, 14 Jul 2023 00:29:54 +0800
Message-ID: <SY4P282MB183539E5A91B351249A2F8F1E037A@SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713162955.34842-1-xuwd1@hotmail.com>
References: <20230713162955.34842-1-xuwd1@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [hbySzE1Zt0HvzUIL2UX2tmwwydk0chI6]
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:c2::7)
X-Microsoft-Original-Message-ID: <20230713162955.34842-2-xuwd1@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY4P282MB1835:EE_|SY6P282MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: 887fdd23-6430-4030-d2a2-08db83be746e
X-MS-Exchange-SLBlob-MailProps: ZILSnhm0P3nN7ksDdJHhaEOcm48SSgzZjv94jAYU0fOIaN55HYBXz8rNf4ql+HrcD7unreFICMNmCvkFHDmrIaPQyTFWpoJDISvWK0uV5lRXh1AuwJG+0vvgT+CvxX619X4TMOU+RwffVwmLPVqZ3tUsk6txqPl5+X8QDlFS/+yX+3IZhDw/zVSGa1RLG5ue+n7DB+vIBfBx6Uv5hsLjrLO7iE1a7oMesKIoxPEk/OpBn5GHRJzlOc446Z3cPFqwLJ8hZDfNA93wk4SNSlk7WxGTMlphbwKJtq0uiBKUGuIuX5D5FqWodWTJMNHP76BR6/qN339J0NCtt6bWdcNtI7ab9a3JIMaOedZOycXf5SbdkOEG6ZfC09M8++7SV278uixGHFRdB1tpVfoDKhn1YGNuTTvdSaKglxUWEA/+5WmZKFrG6aX4KRORPCSPVeyhbzRcs+nc8rtZi+jcDF5XA1dy/yT9aptkphvw8FRxktyjy4D85tsKpn0DNnQlpQT3MKFixQ2Kz0Uaw1zif/XJPMf72luJq1f3xzfLKL+lrYwxeAax6sOZXVFBU9ZeGrXi2rm98S18rQ/aU+wxkJVb+zFyX2SqulwbgzGB/28j0JeoV60hem4XI2SAZA8xsmQuPx3NqeNJoZCbG3ROc6Nhu98Chs+W89tpFAAy9mO6v2qPpIMzsSomX4i06J54B9xvNpmYkOaHrVwB7PQWDJOKi1RkzDCuNv+8eKw6Tev57xT/L7+tNCEKmYqFbwNNIsBk1yDnVY6xLWMCr9D7BvgeQ0Skc9Zbte9+
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TV+kPGuLB4+gW1Nsgcangk6IBtUg/84KxLEF/yf24mL4U+KV8XcHDaWlEtlMDzCYdgL+oJiy+m4qhvA2yXbd43NTD+YbhdWA6SzumYvTUpeXUpfrLasoVuDovkRCqLn/OlZ9UORy8fX+kdCRWKCt0VcP1q8t2LSnNlcLX5zJEIF8Lrttg0vvojfacgtSbQpSWwEs9gsXoq9dZVqCEVMt+2FxKhyMder93f4SI9xX1MP1K61lLzgsjg25AKoTJzwd94GhkGwYQj2ZYvmTDD/US2huBI6Xh3nweD2qqnEX7CGoIKMqZl28sf4akVTn3T1PYE19qlA1KZpL3vcW55Y9t2uicX2+rtldbz4rtL3jtvQIk6a+dLFvT9Z010tv1VWxArZ+ScA1idrnvFNKzICISfwz4YLbFLv8pZEQP6r5HWjLO71dTAombK2/oDDnkvMWey4JS05vL662EWzVxZWvLCFS37yqrx1CKl816me37BWTbciFYXhc0WY1dRzVCF0ZmzD9PSrVirGFVUdTisJDaC6ay2grE2RIke04FC/3FaGPNz6CBjBODXOxTpMYNXd9v6zKS0eVEhFYJFR0gsP7P8a6NmMAGzSuFAr20FuH9l+kVWAxuO9AF65v4ILqZwIK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2KqSFnjrEJXY/B9mzgCa4ORUI6jrq6XsB3i00y+MMJUuJtmYsfyhSMGOida?=
 =?us-ascii?Q?DmJIqZLu9k9+9BfsQbdgt5ad+DCV8qLNoAXP0Nyc8mvDUsTU80xXs0EZ1oTq?=
 =?us-ascii?Q?lrodIljviHmm3tEJD31hZYvPABqvbTRSv7rY8QQIOxMMFK26MsrZMg3RKT+I?=
 =?us-ascii?Q?Yaq7X49QlpgrfRPaOMIp2bFtt6kDYLkiIyd24QamJIYaTbHghF9Lj7irMAGL?=
 =?us-ascii?Q?3iA5jzHVHroczJHoTLotmVJSmIjzZ4QVGKMu1absMRwq7bAjFkFs80PGtrwa?=
 =?us-ascii?Q?9G8XMncG7RAF9WjLJ+3lK3r3VtE8s32ploYnq2egIfWQPjp2tRRQYOeNlhIn?=
 =?us-ascii?Q?OOfpcWUIYbKmqclK+DHlkN0snwo2EyRaXFDDUpTYMse2aIO4FrcmMW+x0D52?=
 =?us-ascii?Q?gf4ToHVSg3cNgNKATP1Iylqpr/kbJoXOFUcU5KyKWPRSdIYtIJJdyXZ3L6Ue?=
 =?us-ascii?Q?f1MeY0S5ayrzIN2q0ag03/SPZQhy6i2F4Pv3HDQgaXn+NvcKfpyLAv55HE8w?=
 =?us-ascii?Q?U2gXG4bEulbdQDUKOB2X5jh8sATrHrZTHG4+4AqaYN5WAvH29FovE9DCstS8?=
 =?us-ascii?Q?eUbTSu8vDap8MvRkBqXX8u2tmV29uPZq4mOoo+980/qIHbEgb9/o04g9znNh?=
 =?us-ascii?Q?A0h6JjVJpHLMwNQN9Qlf+vM5M4ibanvCOPSSA4PX86uie7xG9gH/Hy+/H42t?=
 =?us-ascii?Q?Htg9JFExkO3RvNLoeEKXa227Ap92ck3WCpnF/tMKPo1uuFXYvJxZnwQVjcdN?=
 =?us-ascii?Q?LhX1SYhKFxg8TmKvoQmRRQXs/wfOcKeuI9/rsIlxuOLvVZ8QLss6OERR5eJV?=
 =?us-ascii?Q?8n8VNHPPl9vAXqBexJ9J+h7NABt3tPCeK9vdJLbzInA6An//jLXFyYWAKF+6?=
 =?us-ascii?Q?iMxZgj86k0lq3/yvEySUesuBRQ9rt4GRcI0ftuoXIzKYrJb4/3mYflLa3lwo?=
 =?us-ascii?Q?fUfVFrZevBbYLf7tyeFZJAibXm8CIGlNivzUQ+QYPSh2aLnvSlmfs6t6hDFg?=
 =?us-ascii?Q?cYSBEy4U7bE1RodZfgDVvdkSt+zLpI6nsDW4d3aYFdExCqMTEm2ZQohLiYec?=
 =?us-ascii?Q?/3KaSr7nZdqFMLUnB+WLHJ6nowsujL+S0oNgtGJSkHuhbsL3Sr1gAuwjLWQ3?=
 =?us-ascii?Q?cuY7BjqqplXYi8Z35aILHEWdZBqPFwSVA8Ad7IQNZfv4yIS7JNwDb6/oj3kQ?=
 =?us-ascii?Q?7ydHgheDY+kAfWOgu7wVKIRzqXMoVHC4Dbvtxg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 887fdd23-6430-4030-d2a2-08db83be746e
X-MS-Exchange-CrossTenant-AuthSource: SY4P282MB1835.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 16:30:22.6508
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

As the comments added in commit 4d4c4bff4f8ed79d95e05 ("ALSA: hda:
cs35l41: Clarify support for CSC3551 without _DSD Properties"), CSC3551
requires a valid _DSD to work and the current implementation just
fails when no _DSD can be found for CSC3551. However it is a fact
that many OEMs hardcoded the configurations needed by CSC3551 into their
proprietary software for various 2022 and later laptop models,
and this makes the Linux installations on these models cannot make
any speaker sound. Meanwhile, at this point of time, we see no hope
that these OEMs would ever fix this problem via a BIOS update. So
to fix this bothering problem it might be worthwhile to add some
model-specific fixups to apply some proper configurations
to the cs35l41.

To address the above problem, a configuration fixup function
apply_cs35l41_fixup_cfg that would be called in cs35l41_no_acpi_dsd,
along with a fixup table cs35l41_fixup_cfgtbl which is a array of
fixup entry struct cs35l41_fixup_cfg are introduced. Each fixup entry
records the ACPI _SUB(vender and device ID) to be matched, and a
configuration to be applied to each of the cs35l41 device in CSC3551.

More specifically for the design of this fixup mechanism,
the maximum number of cs35l41 configurations inside a fixup entry
is defined as a macro CS35L41_FIXUP_CFG_MAX_DEVICES, and the actual
number of cs35l41 devices in a CSC3551 system is recorded in the
num_device field in the fixup entry. The apply_cs35l41_fixup_cfg
function is responsible for finding and applying a fixup for a
specific model according to the model's ACPI _SUB. If no valid fixup
can be applied, the fixup function fails and returns to the normal
cs35l41_no_acpi_dsd execution flow.

This patch now contains only several fixups for three Lenovo laptop
models, namely 16IAH7, 16IAX7, and 16ARHA7 and this fixup mechanism
has been verified to work on 16IAH7. As far as is known, several other
laptop models from ASUS and HP also suffer from this no valid _DSD
problem and could have it addressed with this fixup mechanism when
proper fixup entries are inserted.

Signed-off-by: David Xu <xuwd1@hotmail.com>
---
 sound/pci/hda/cs35l41_hda.c | 160 ++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index ce5faa620517..d957458dd4e6 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -1211,6 +1211,159 @@ static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
 	return speaker_id;
 }
 
+#define CS35L41_FIXUP_CFG_MAX_DEVICES 4
+
+struct cs35l41_fixup_cfg {
+	unsigned short vender;
+	unsigned short device;
+	unsigned int num_device;  /* The num of cs35l41 instances */
+	/* cs35l41 instance ids, can be i2c index or spi index */
+	int ids[CS35L41_FIXUP_CFG_MAX_DEVICES];
+	unsigned int reset_gpio_idx[CS35L41_FIXUP_CFG_MAX_DEVICES];
+	enum gpiod_flags reset_gpio_flags[CS35L41_FIXUP_CFG_MAX_DEVICES];
+	int spkid_gpio_idx[CS35L41_FIXUP_CFG_MAX_DEVICES];
+	unsigned int spk_pos[CS35L41_FIXUP_CFG_MAX_DEVICES];
+	enum cs35l41_hda_gpio_function gpio1_func[CS35L41_FIXUP_CFG_MAX_DEVICES];
+	enum cs35l41_hda_gpio_function gpio2_func[CS35L41_FIXUP_CFG_MAX_DEVICES];
+	enum cs35l41_boost_type bst_type[CS35L41_FIXUP_CFG_MAX_DEVICES];
+};
+
+static const struct cs35l41_fixup_cfg cs35l41_fixup_cfgtbl[] = {
+	{ // Lenovo Legion Slim 7i 16IAH7
+	.vender = 0x17aa,
+	.device = 0x386e,
+	.num_device = 2,
+	.ids = {0x40, 0x41},
+	.reset_gpio_idx = {0, 0},
+	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
+	.spkid_gpio_idx = {1, 1},
+	.spk_pos = {0, 1},
+	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
+	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_NOT_USED},
+	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
+	},
+	{ // Lenovo Legion Slim 7i 16IAH7 type2
+	.vender = 0x17aa,
+	.device = 0x3803,
+	.num_device = 2,
+	.ids = {0x40, 0x41},
+	.reset_gpio_idx = {0, 0},
+	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
+	.spkid_gpio_idx = {1, 1},
+	.spk_pos = {0, 1},
+	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
+	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_NOT_USED},
+	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
+	},
+	{ // Lenovo Legion 7i 16IAX7
+	.vender = 0x17aa,
+	.device = 0x3874,
+	.num_device = 2,
+	.ids = {0x40, 0x41},
+	.reset_gpio_idx = {0, 0},
+	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
+	.spkid_gpio_idx = {1, 1},
+	.spk_pos = {0, 1},
+	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
+	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_INTERRUPT},
+	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
+	},
+	{ // Lenovo Legion 7i 16IAX7 type 2
+	.vender = 0x17aa,
+	.device = 0x386f,
+	.num_device = 2,
+	.ids = {0x40, 0x41},
+	.reset_gpio_idx = {0, 0},
+	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
+	.spkid_gpio_idx = {1, 1},
+	.spk_pos = {0, 1},
+	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
+	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_INTERRUPT},
+	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
+	},
+	{ // Lenovo Legion Slim 7 16ARHA7
+	.vender = 0x17aa,
+	.device = 0x3877,
+	.num_device = 2,
+	.ids = {0x40, 0x41},
+	.reset_gpio_idx = {0, 0},
+	.reset_gpio_flags = {GPIOD_OUT_LOW, GPIOD_OUT_LOW},
+	.spkid_gpio_idx = {1, 1},
+	.spk_pos = {0, 1},
+	.gpio1_func = {CS35l41_VSPK_SWITCH, CS35l41_VSPK_SWITCH},
+	.gpio2_func = {CS35L41_INTERRUPT, CS35L41_INTERRUPT},
+	.bst_type = {CS35L41_EXT_BOOST, CS35L41_EXT_BOOST}
+	},
+	{} // terminator
+};
+
+static inline int cs35l41_fixup_get_index(const struct cs35l41_fixup_cfg *fixup, int cs35l41_addr)
+{
+	int i;
+
+	for (i = 0; i < fixup->num_device; i++) {
+		if (fixup->ids[i] == cs35l41_addr)
+			return i;
+	}
+	return -ENODEV;
+}
+
+static int apply_cs35l41_fixup_cfg(struct cs35l41_hda *cs35l41,
+				struct device *physdev,
+				int cs35l41_addr,
+				const struct cs35l41_fixup_cfg *fixup_tbl)
+{
+	const char *ssid;
+	unsigned int vendid;
+	unsigned int devid;
+	const struct cs35l41_fixup_cfg *cur_fixup;
+	struct cs35l41_hw_cfg *hw_cfg;
+	int cs35l41_index;
+	int ret;
+	int i;
+
+	ssid = cs35l41->acpi_subsystem_id;
+	ret = sscanf(ssid, "%04x%04x", &vendid, &devid);
+	if (ret != 2)
+		return -EINVAL;
+
+	hw_cfg = &cs35l41->hw_cfg;
+	for (cur_fixup = fixup_tbl; cur_fixup->vender; cur_fixup++) {
+		if (cur_fixup->vender == vendid && cur_fixup->device == devid) {
+			cs35l41_index = cs35l41_fixup_get_index(cur_fixup, cs35l41_addr);
+			if (cs35l41_index == -ENODEV)
+				return -ENODEV;
+			cs35l41->index = cs35l41_index;
+			cs35l41->reset_gpio = gpiod_get_index(
+				physdev,
+				NULL,
+				cur_fixup->reset_gpio_idx[cs35l41_index],
+				cur_fixup->reset_gpio_flags[cs35l41_index]
+				);
+			cs35l41->speaker_id = cs35l41_get_speaker_id(physdev,
+				cs35l41_index,
+				cur_fixup->num_device,
+				cur_fixup->spkid_gpio_idx[cs35l41_index]
+				);
+			hw_cfg->spk_pos = cur_fixup->spk_pos[cs35l41_index];
+			cs35l41->channel_index = 0;
+			for (i = 0; i < cs35l41->index; i++)
+				if (cur_fixup->spk_pos[i] == hw_cfg->spk_pos)
+					cs35l41->channel_index++;
+
+			hw_cfg->gpio1.func = cur_fixup->gpio1_func[cs35l41_index];
+			hw_cfg->gpio1.valid = true;
+			hw_cfg->gpio2.func = cur_fixup->gpio2_func[cs35l41_index];
+			hw_cfg->gpio2.valid = true;
+			hw_cfg->bst_type = cur_fixup->bst_type[cs35l41_index];
+			dev_dbg(physdev, "Fixup applied.\n");
+			break;
+		}
+	}
+	return 0;
+
+}
+
 /*
  * Device CLSA010(0/1) doesn't have _DSD so a gpiod_get by the label reset won't work.
  * And devices created by serial-multi-instantiate don't have their device struct
@@ -1221,6 +1374,7 @@ static int cs35l41_get_speaker_id(struct device *dev, int amp_index,
 static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
 			       const char *hid)
 {
+	int ret;
 	struct cs35l41_hw_cfg *hw_cfg = &cs35l41->hw_cfg;
 
 	/* check I2C address to assign the index */
@@ -1243,7 +1397,13 @@ static int cs35l41_no_acpi_dsd(struct cs35l41_hda *cs35l41, struct device *physd
 		/*
 		 * Note: CLSA010(0/1) are special cases which use a slightly different design.
 		 * All other HIDs e.g. CSC3551 require valid ACPI _DSD properties to be supported.
+		 * However many OEMs hardcoded the configurations into their proprietary software
+		 * thus leaving our Linux installation with no speaker sound at all while we see
+		 * no hope those OEMs would fix it. So we apply a ssid specific fixup to fix it.
 		 */
+		if (apply_cs35l41_fixup_cfg(cs35l41, physdev, id, cs35l41_fixup_cfgtbl) == 0)
+			return 0;
+
 		dev_err(cs35l41->dev, "Error: ACPI _DSD Properties are missing for HID %s.\n", hid);
 		hw_cfg->valid = false;
 		hw_cfg->gpio1.valid = false;
-- 
2.41.0

