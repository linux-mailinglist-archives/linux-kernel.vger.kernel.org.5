Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84797CD49E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 08:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjJRGp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 02:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJRGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 02:45:24 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2124.outbound.protection.outlook.com [40.107.113.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B249493
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9TCgNV08nJN/6hOAjPO5cItguWEJqdnLgXlD0n9uIAQLxMRus6uCP0S7xFROk1rbLsqT8yqhn3zkCa0K53VfolxJYcs/nk+dlIYOOz0tA7qVvR4ykZpaIR8OCUTDL0xcWE3+lg8Qwd4A28ixX+oXC2xK/t+nFCFPEf0wi7tO9RqtgilQQ8oVl1lIFv0guHmFr7618YYNjcs5vVck0PLul3fjQY9qmIjufSQjOQBS2l4KyU7IFiCFj5X0XZVByhp8ScQWW4QypnrSpdDihMX9hNwPAr2D4kegRl6UtKR3H+jmjTyi7L+wvchqvWqQifPi9lQu6Ur/xY5vvhfgMTY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T//IsHu/57tcI9MH3jc8qWB2+0BddAf7dVlWNJGqnTY=;
 b=TiHngVtWFzsuzBTAy5zLkIxdePVTQRI2t6gklKMq9tSW1Xx5LQLN0HC81YA9yVuUVudk9MqHO/GtHpzZdg/NH6d+YvvPjyhAeDFbwTHhE5yRxhs4QCizSpKyXP7+8zJeG2d7STmjqZQkA50URW5NmPjtVEHJZZg49phbIdfqaO80LE0+wBNggoZp4OXXD1dxfIq1ErJKcWjh5If79ppTyuURD+srzyPLI/FWXjDnPsjFRWOwHRVy9MDilGORl8Nh3eSmaUX7dFAhDlM9c1fKEErTNIaiVR9BOnlBAvcJfgGSp8gydZ1mgiPwAfXhskw6gd4vsZ4Duq8eoCbypVdGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T//IsHu/57tcI9MH3jc8qWB2+0BddAf7dVlWNJGqnTY=;
 b=MGnj30xUQ2iWXcV11/SsL5F9WE/B8jYtD2z/gzwfxgLuPszDfVbvgdiE9Jt7A/u/Hcz2s/ZNc6TqZJ6gGBYPRoTwwKPjoSi6Jev6rYknmCq93KB1TpEHYsImm3XARQ5ISbKrRKcCWENsiKRMnbp0toK+0lBxznF8+DsBlE0+1zQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 06:45:14 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::fb92:32d0:d0f6:a589]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::fb92:32d0:d0f6:a589%7]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 06:45:14 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: da7213: Add new kcontrol for tonegen
Date:   Wed, 18 Oct 2023 14:44:44 +0800
Message-Id: <20231018064444.23186-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0030.apcprd06.prod.outlook.com
 (2603:1096:404:2e::18) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8919d0ef-0261-4b07-9f33-08dbcfa5c7b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBF614U4NM49zw/0865zuLUfvfSxT/VsbPiTxXFvg68iBTILb6uPVOdwqC5kgyE+jVWPxgDZsCi6D/dfvYi8W3uwgS572L9d+5Vyw3IgChITdawNpdvNn5sM1uCYCZCNpKnaiRU03iu+v2kqbxmgBPgFDZ9hPpMmQrL27KJhrKX7TF+fooaT7ue79Cl9r5BaZB7UjONujaQGYnYWK+I3ITM1gAfEK1GE2WnGPYsTbwYa8tM+D/QruodcROOoJBNlmAKWUyxthMOKeite0oRawutjTh7q383vRmYeXoH7GhynG9GPy2fMqS7nFXVnD/PLua8awYQqtcfJssYlGeXtR0UqWsE2ZXVbt0eTEdYD21+w2xFmhjQgPt8zrcWp0GnLEdISRBiSXj2NF3NcO5s744flyOYs9rB8ZfeBCP0fAvqWEwPUK6p23rjWKbWpNWCZ+7YYFTcC0WYoEmfsZFBRe1dqRa4UR+KNFGi1Lcb9T20WuIzYJ8cfiqojYnbDmUcCZF8/fv6SMkmC5/Ja9HMA7U0FSj3oIgHIJTnl69ykwBsKW6lI1EY17r8V1PAAnONj/UM+6qfyjs7u4d/0mS1TVisAP3bpcWIVefO+/0TrITHanDqucqEs+UizaQ+WCMUd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(2616005)(107886003)(26005)(6506007)(6512007)(52116002)(83380400001)(4326008)(478600001)(41300700001)(5660300002)(6486002)(316002)(8936002)(2906002)(8676002)(30864003)(6916009)(66946007)(66476007)(66556008)(38100700002)(6666004)(86362001)(103116003)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7lOCZpYKr9ShSkyNFAjddqk5jIoc5yU7ZSYyCvwGajOgcH4bRPPCs3sEWLgh?=
 =?us-ascii?Q?vHsuUn2tj3EeBUwBFNleucJV7vLHKUm7K9vOvPBfcflLqlXPol/7YpRDVqU6?=
 =?us-ascii?Q?GJuqzgnQ9MGLSNMx+ifcUAA9RFG0n9vGJ57LlLD44Wziet3BeULVDVznRz3A?=
 =?us-ascii?Q?NL9pg62tOIZZ3jSUK9C63Ygg9mE66295rY2aWtr4cS6pCUMDD5QWLIWEpg2X?=
 =?us-ascii?Q?l10hrukuVkR3v9g93ZalXY4VAIw+Nvj2XAxjmH6BoCz/4CYD8BfVJXGRK1LE?=
 =?us-ascii?Q?NRObAKmNt/tWyCMB/7POcnMADVX+yvmlKVToEsip0ggs1wZ7h8GHQkVmqk9R?=
 =?us-ascii?Q?yk196A1VvF7xi228smFZ9oR7x5Kuv+UgEn0INDdEWFxIxEifMU4yfMlI12+8?=
 =?us-ascii?Q?4Tr625azBJ85anoDah+59Tfw4Q4TVyluQmbqlxEPmsX9O2liihn4ODAtuc0k?=
 =?us-ascii?Q?PFpnYZQdATtioEEMiZR9wKL5+9xKmSEuCMYrt7qZExwv/8/l4IsDMcs5vnz7?=
 =?us-ascii?Q?AcUruf5JVQPraivQ5UYRISFYkIehyW8eZxMO1cKQzIJsPkpXtnC5c8pwFtvI?=
 =?us-ascii?Q?dKzOtmlXAaIm/iBbA8qhXN8GYafuDT4CaCC72XJoJl14kJaUCrhZgtXrheKZ?=
 =?us-ascii?Q?DEWEHQ+lxwlb4K2q/5wPSkne/TfqJfXwVf9szGi2HqKpUT3P4S0UfCLP5AqH?=
 =?us-ascii?Q?ylHd/Bf//1w8sndLet7UnWT8jLHsSF424yAzopyqUmwwKoNIT+oTEZc+yg73?=
 =?us-ascii?Q?UuXEEM7O6awOMuCRXMjhDDBSvUbOfR4Mpr2V2eXMT7ragoYdLsKHXVDIiNf2?=
 =?us-ascii?Q?mWkf+OlSd3ZsumKNsq2ebsGM1rS6bvii76fSbrzD072zRFlo6B2q8qRPVITc?=
 =?us-ascii?Q?FJkS5K6YIX8k6ugeQohfeGvJ6Hojx6Oc1oxnZjChaC6VkNEzmVzNzxkVYdM6?=
 =?us-ascii?Q?oKhCO5/FtT2Eu/x2iCeAcc+r+SoU4cUoKf4GkqHK//08WDTZUWoP7DEK5Xha?=
 =?us-ascii?Q?YtE5EdvXiBWxyukJrvkK/Q7WkuprhPuELZW7QbcHHBDPb9fN22olrAzbRmby?=
 =?us-ascii?Q?lP1S3m3XJuYhLGqn78VaWfV3U3NH/hTIULrCqEVTSQrybMu3Bp4O+LReaqXw?=
 =?us-ascii?Q?pKlVnx9Lxx3qng1MYaZnZAOEmwtldptS7XzhAk7KOtIc2V6OL4shGdflx04l?=
 =?us-ascii?Q?F7fOhpGR5Tzn6mM/07AHc7nC+NbJHfbli8OdwVQUH2X87dcniwUgiP0NLAyG?=
 =?us-ascii?Q?qZU94WUOoM6NsTyyttoUZaie+ZtxzocbzzeelEGzHsSaPljXKuYvwujgdshu?=
 =?us-ascii?Q?+uj/wrkQZp0mw3WH/k1jsqSNXnFqWfp1tNF/1PPBuM4/GFvToFoSG+qOFOkd?=
 =?us-ascii?Q?VnP0kxONf6mK3zdbeo1UTru6wS5x4p5GGoPtTYhjNzRFqJhncZKHJr0WMPwM?=
 =?us-ascii?Q?kqvu3MN26Zswcginf93R7j0w8HSwZFZ2qcllhPDndlbB97CWkxK13xICv+L4?=
 =?us-ascii?Q?NMwuAULqtH/aknsNyjqLQyVtnIxASNZKqi5b6LkYDbJGnbAY4wMijGQLVZUF?=
 =?us-ascii?Q?Umjnn3nIBwcSVpDWrYv+WFv9ZrIXSfxEDz6e74TTOA7SfJvdxDcbFH+wJFZb?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8919d0ef-0261-4b07-9f33-08dbcfa5c7b0
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 06:45:14.1530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0s/mPsVRkICoVaDC6wcZJVD1osfzo+abirNeVUCV0bojmzEQL9TXKbuijHjXgfeJY5S1Wqqw294Di8olqDLtt6vGGYrXH0nkFYFdmwxYJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new kcontrol for tone generator

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 sound/soc/codecs/da7213.c | 171 +++++++++++++++++++++++++++++++++++++-
 sound/soc/codecs/da7213.h |  64 +++++++++++++-
 2 files changed, 233 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 3a6449c44b23..31f32de0e1ed 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -55,6 +55,7 @@ static const DECLARE_TLV_DB_SCALE(hp_vol_tlv, -5700, 100, 0);
 static const DECLARE_TLV_DB_SCALE(lineout_vol_tlv, -4800, 100, 0);
 static const DECLARE_TLV_DB_SCALE(alc_threshold_tlv, -9450, 150, 0);
 static const DECLARE_TLV_DB_SCALE(alc_gain_tlv, 0, 600, 0);
+static const DECLARE_TLV_DB_SCALE(da7213_tonegen_gain_tlv, -4500, 300, 0);
 
 /* ADC and DAC voice mode (8kHz) high pass cutoff value */
 static const char * const da7213_voice_hpf_corner_txt[] = {
@@ -86,6 +87,23 @@ static SOC_ENUM_SINGLE_DECL(da7213_adc_audio_hpf_corner,
 			    DA7213_AUDIO_HPF_CORNER_SHIFT,
 			    da7213_audio_hpf_corner_txt);
 
+static const char * const da7213_tonegen_dtmf_key_txt[] = {
+	"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D",
+	"*", "#"
+};
+
+static const struct soc_enum da7213_tonegen_dtmf_key =
+	SOC_ENUM_SINGLE(DA7213_TONE_GEN_CFG1, DA7213_DTMF_REG_SHIFT,
+			DA7213_DTMF_REG_MAX, da7213_tonegen_dtmf_key_txt);
+
+static const char * const da7213_tonegen_swg_sel_txt[] = {
+	"Sum", "SWG1", "SWG2", "Sum"
+};
+
+static const struct soc_enum da7213_tonegen_swg_sel =
+	SOC_ENUM_SINGLE(DA7213_TONE_GEN_CFG2, DA7213_SWG_SEL_SHIFT,
+			DA7213_SWG_SEL_MAX, da7213_tonegen_swg_sel_txt);
+
 /* Gain ramping rate value */
 static const char * const da7213_gain_ramp_rate_txt[] = {
 	"nominal rate * 8", "nominal rate * 16", "nominal rate / 16",
@@ -191,6 +209,64 @@ static SOC_ENUM_SINGLE_DECL(da7213_alc_integ_release_rate,
  * Control Functions
  */
 
+/* Locked Kcontrol calls */
+static int da7213_volsw_locked_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_get_volsw(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+static int da7213_volsw_locked_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+static int da7213_enum_locked_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_get_enum_double(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+static int da7213_enum_locked_put(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = snd_soc_put_enum_double(kcontrol, ucontrol);
+	mutex_unlock(&da7213->ctrl_lock);
+
+	return ret;
+}
+
+/* ALC */
 static int da7213_get_alc_data(struct snd_soc_component *component, u8 reg_val)
 {
 	int mid_data, top_data;
@@ -376,6 +452,64 @@ static int da7213_put_alc_sw(struct snd_kcontrol *kcontrol,
 	return snd_soc_put_volsw(kcontrol, ucontrol);
 }
 
+/* ToneGen */
+static int da7213_tonegen_freq_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mixer_ctrl =
+		(struct soc_mixer_control *) kcontrol->private_value;
+	unsigned int reg = mixer_ctrl->reg;
+	__le16 val;
+	int ret;
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = regmap_raw_read(da7213->regmap, reg, &val, sizeof(val));
+	mutex_unlock(&da7213->ctrl_lock);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Frequency value spans two 8-bit registers, lower then upper byte.
+	 * Therefore we need to convert to host endianness here.
+	 */
+	ucontrol->value.integer.value[0] = le16_to_cpu(val);
+
+	return 0;
+}
+
+static int da7213_tonegen_freq_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mixer_ctrl =
+		(struct soc_mixer_control *) kcontrol->private_value;
+	unsigned int reg = mixer_ctrl->reg;
+	__le16 val_new, val_old;
+	int ret;
+
+	/*
+	 * Frequency value spans two 8-bit registers, lower then upper byte.
+	 * Therefore we need to convert to little endian here to align with
+	 * HW registers.
+	 */
+	val_new = cpu_to_le16(ucontrol->value.integer.value[0]);
+
+	mutex_lock(&da7213->ctrl_lock);
+	ret = regmap_raw_read(da7213->regmap, reg, &val_old, sizeof(val_old));
+	if (ret == 0 && (val_old != val_new))
+		ret = regmap_raw_write(da7213->regmap, reg,
+				&val_new, sizeof(val_new));
+	mutex_unlock(&da7213->ctrl_lock);
+
+	if (ret < 0)
+		return ret;
+
+	return val_old != val_new;
+}
 
 /*
  * KControls
@@ -477,6 +611,37 @@ static const struct snd_kcontrol_new da7213_snd_controls[] = {
 	SOC_DOUBLE_R("Headphone ZC Switch", DA7213_HP_L_CTRL, DA7213_HP_R_CTRL,
 		     DA7213_ZC_EN_SHIFT, DA7213_ZC_EN_MAX, DA7213_NO_INVERT),
 
+	/* Tone Generator */
+	SOC_SINGLE_EXT_TLV("ToneGen Volume", DA7213_TONE_GEN_CFG2,
+			   DA7213_TONE_GEN_GAIN_SHIFT, DA7213_TONE_GEN_GAIN_MAX,
+			   DA7213_NO_INVERT, da7213_volsw_locked_get,
+			   da7213_volsw_locked_put, da7213_tonegen_gain_tlv),
+	SOC_ENUM_EXT("ToneGen DTMF Key", da7213_tonegen_dtmf_key,
+		     da7213_enum_locked_get, da7213_enum_locked_put),
+	SOC_SINGLE_EXT("ToneGen DTMF Switch", DA7213_TONE_GEN_CFG1,
+		       DA7213_DTMF_EN_SHIFT, DA7213_SWITCH_EN_MAX,
+		       DA7213_NO_INVERT, da7213_volsw_locked_get,
+		       da7213_volsw_locked_put),
+	SOC_SINGLE_EXT("ToneGen Start", DA7213_TONE_GEN_CFG1,
+		       DA7213_START_STOPN_SHIFT, DA7213_SWITCH_EN_MAX,
+		       DA7213_NO_INVERT, da7213_volsw_locked_get,
+		       da7213_volsw_locked_put),
+	SOC_ENUM_EXT("ToneGen Sinewave Gen Type", da7213_tonegen_swg_sel,
+		     da7213_enum_locked_get, da7213_enum_locked_put),
+	SOC_SINGLE_EXT("ToneGen Sinewave1 Freq", DA7213_TONE_GEN_FREQ1_L,
+		       DA7213_FREQ1_L_SHIFT, DA7213_FREQ_MAX, DA7213_NO_INVERT,
+		       da7213_tonegen_freq_get, da7213_tonegen_freq_put),
+	SOC_SINGLE_EXT("ToneGen Sinewave2 Freq", DA7213_TONE_GEN_FREQ2_L,
+		       DA7213_FREQ2_L_SHIFT, DA7213_FREQ_MAX, DA7213_NO_INVERT,
+		       da7213_tonegen_freq_get, da7213_tonegen_freq_put),
+	SOC_SINGLE_EXT("ToneGen On Time", DA7213_TONE_GEN_ON_PER,
+		       DA7213_BEEP_ON_PER_SHIFT, DA7213_BEEP_ON_OFF_MAX,
+		       DA7213_NO_INVERT, da7213_volsw_locked_get,
+		       da7213_volsw_locked_put),
+	SOC_SINGLE("ToneGen Off Time", DA7213_TONE_GEN_OFF_PER,
+		   DA7213_BEEP_OFF_PER_SHIFT, DA7213_BEEP_ON_OFF_MAX,
+		   DA7213_NO_INVERT),
+
 	/* Gain Ramping controls */
 	SOC_DOUBLE_R("Aux Gain Ramping Switch", DA7213_AUX_L_CTRL,
 		     DA7213_AUX_R_CTRL, DA7213_GAIN_RAMP_EN_SHIFT,
@@ -765,7 +930,7 @@ static int da7213_dai_event(struct snd_soc_dapm_widget *w,
 		/* Check SRM has locked */
 		do {
 			pll_status = snd_soc_component_read(component, DA7213_PLL_STATUS);
-			if (pll_status & DA7219_PLL_SRM_LOCK) {
+			if (pll_status & DA7213_PLL_SRM_LOCK) {
 				srm_lock = true;
 			} else {
 				++i;
@@ -1931,6 +2096,9 @@ static int da7213_probe(struct snd_soc_component *component)
 		da7213->fixed_clk_auto_pll = true;
 	}
 
+	/* Default infinite tone gen, start/stop by Kcontrol */
+	snd_soc_component_write(component, DA7213_TONE_GEN_CYCLES, DA7213_BEEP_CYCLES_MASK);
+
 	return 0;
 }
 
@@ -2078,4 +2246,5 @@ module_i2c_driver(da7213_i2c_driver);
 
 MODULE_DESCRIPTION("ASoC DA7213 Codec driver");
 MODULE_AUTHOR("Adam Thomson <Adam.Thomson.Opensource@diasemi.com>");
+MODULE_AUTHOR("David Rau <David.Rau.opensource@dm.renesas.com>");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 4ca9cfdea06d..505b731c0adb 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -5,6 +5,7 @@
  * Copyright (c) 2013 Dialog Semiconductor
  *
  * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+ * Author: David Rau <David.Rau.opensource@dm.renesas.com>
  */
 
 #ifndef _DA7213_H
@@ -135,13 +136,24 @@
 #define DA7213_DAC_NG_ON_THRESHOLD	0xB1
 #define DA7213_DAC_NG_CTRL		0xB2
 
+#define DA7213_TONE_GEN_CFG1		0xB4
+#define DA7213_TONE_GEN_CFG2		0xB5
+#define DA7213_TONE_GEN_CYCLES		0xB6
+#define DA7213_TONE_GEN_FREQ1_L		0xB7
+#define DA7213_TONE_GEN_FREQ1_U		0xB8
+#define DA7213_TONE_GEN_FREQ2_L		0xB9
+#define DA7213_TONE_GEN_FREQ2_U		0xBA
+#define DA7213_TONE_GEN_ON_PER		0xBB
+#define DA7213_TONE_GEN_OFF_PER		0xBC
 
 /*
  * Bit fields
  */
 
+#define DA7213_SWITCH_EN_MAX		0x1
+
 /* DA7213_PLL_STATUS = 0x03 */
-#define DA7219_PLL_SRM_LOCK					(0x1 << 1)
+#define DA7213_PLL_SRM_LOCK					(0x1 << 1)
 
 /* DA7213_SR = 0x22 */
 #define DA7213_SR_8000						(0x1 << 0)
@@ -484,6 +496,55 @@
 #define DA7213_DAC_NG_EN_SHIFT					7
 #define DA7213_DAC_NG_EN_MAX					0x1
 
+/* DA7213_TONE_GEN_CFG1 = 0xB4 */
+#define DA7213_DTMF_REG_SHIFT		0
+#define DA7213_DTMF_REG_MASK		(0xF << 0)
+#define DA7213_DTMF_REG_MAX		16
+#define DA7213_DTMF_EN_SHIFT		4
+#define DA7213_DTMF_EN_MASK		(0x1 << 4)
+#define DA7213_START_STOPN_SHIFT	7
+#define DA7213_START_STOPN_MASK		(0x1 << 7)
+
+/* DA7213_TONE_GEN_CFG2 = 0xB5 */
+#define DA7213_SWG_SEL_SHIFT		0
+#define DA7213_SWG_SEL_MASK		(0x3 << 0)
+#define DA7213_SWG_SEL_MAX		4
+#define DA7213_SWG_SEL_SRAMP		(0x3 << 0)
+#define DA7213_TONE_GEN_GAIN_SHIFT	4
+#define DA7213_TONE_GEN_GAIN_MASK	(0xF << 4)
+#define DA7213_TONE_GEN_GAIN_MAX	0xF
+#define DA7213_TONE_GEN_GAIN_MINUS_9DB	(0x3 << 4)
+#define DA7213_TONE_GEN_GAIN_MINUS_15DB	(0x5 << 4)
+
+/* DA7213_TONE_GEN_CYCLES = 0xB6 */
+#define DA7213_BEEP_CYCLES_SHIFT	0
+#define DA7213_BEEP_CYCLES_MASK		(0x7 << 0)
+
+/* DA7213_TONE_GEN_FREQ1_L = 0xB7 */
+#define DA7213_FREQ1_L_SHIFT	0
+#define DA7213_FREQ1_L_MASK	(0xFF << 0)
+#define DA7213_FREQ_MAX		0xFFFF
+
+/* DA7213_TONE_GEN_FREQ1_U = 0xB8 */
+#define DA7213_FREQ1_U_SHIFT	0
+#define DA7213_FREQ1_U_MASK	(0xFF << 0)
+
+/* DA7213_TONE_GEN_FREQ2_L = 0xB9 */
+#define DA7213_FREQ2_L_SHIFT	0
+#define DA7213_FREQ2_L_MASK	(0xFF << 0)
+
+/* DA7213_TONE_GEN_FREQ2_U = 0xBA */
+#define DA7213_FREQ2_U_SHIFT	0
+#define DA7213_FREQ2_U_MASK	(0xFF << 0)
+
+/* DA7213_TONE_GEN_ON_PER = 0xBB */
+#define DA7213_BEEP_ON_PER_SHIFT	0
+#define DA7213_BEEP_ON_PER_MASK		(0x3F << 0)
+#define DA7213_BEEP_ON_OFF_MAX		0x3F
+
+/* DA7213_TONE_GEN_OFF_PER = 0xBC */
+#define DA7213_BEEP_OFF_PER_SHIFT	0
+#define DA7213_BEEP_OFF_PER_MASK	(0x3F << 0)
 
 /*
  * General defines
@@ -534,6 +595,7 @@ enum da7213_supplies {
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct mutex ctrl_lock;
 	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
 	unsigned int mclk_rate;
-- 
2.17.1

