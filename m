Return-Path: <linux-kernel+bounces-29784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3183135D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189131C22776
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F85BE7F;
	Thu, 18 Jan 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OXIjAMjd"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2061.outbound.protection.outlook.com [40.92.23.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152F0125A2;
	Thu, 18 Jan 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564385; cv=fail; b=ntDv5EgJRp0mwFywai3LJoigA1O4bUEOjSZDLsogTKjYOLiEpl9rRrQEJWIrJ/viUikkNAzKkQFkzEqbo0rZFfbZfyuzm0bd3EChdR0MMD/+omrTUxliJiZxIDlSxn8GwqZLMUoB1F+4daVCMgLwWjkeAZ/dCOffRtEdiYWzbYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564385; c=relaxed/simple;
	bh=mPc9NxDUQlxuccu4OPgfovHOqeqc2+rUzE0YEckhENU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 Content-Transfer-Encoding:Content-Type:X-TMN:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=jbabItuzzmBbUGyPbixLyEN6Wwhs2n7G1rClKa05cvB6hIKotI/5A729Y3MVo+dUhP7SfiPLvyii7L9r8sjO5JVZWnON54Q02s16VNbV/GRx4PAh7q3ZMSIBfcjTKkzB2NH0MW0d7a3pBzcWCzYcZC39AxrBzSvZVvPbsp7Zp64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OXIjAMjd; arc=fail smtp.client-ip=40.92.23.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTJnv+D9WCd4pjaI2ZD5LNLIH8cazpoKJRGGTn+GxBTFIbW9sUqX1VV8e+RJxUmgGsKBnZg3SIM3qGAYoes8fd63lSwYD7LG/brmVRIrDdxrUHu9kOiUjHQvHvFF8hNLzFKxSwDWQ+owlDjKca2gV7wipMg97EeKJ7xmYd0iMJDs+DwPW3LDpIdgVt2AKSicUZDsNX4T6Xji8LlCKJfQEI0M4py/dsFEv2KVu6cTrqL0auBa3oWKc9PKtGvpgMWKaFmvv9tGw9LqR6KhjRctQ0g+I+2cN9RnTCctoxqqnrL0yp9J2sHGoPvd9aA/HV9xlBU8BOS2FSdvVagG8MGoUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7jroQRImK7HJFPSXtra+iWq0DC3T47qYc/FsxKvRNI=;
 b=Rq5elhm1r0Ir+s/6euySTimSKU9Vv+nffai4Wacrby591ilxizrGmb5IvcyBt/YJHPNHTb07EZ0hazV2EdxIwLdX1layPeoJqtZtTxgAtj3RIdQUn04kZyp0jyBp+OvGiJGFvBZFkf40Xg8dZMXQ6FywoqfOgcDWua/4Pc92YPjwGYdQOPOoik0U68LjBAzicsj2sUYiEwxXNVexpQ20B5guQi0NVNLDiwimlchP87ibYF4Se3JXVUyaAx+MyVnrNW7RsXXFCOqV+NBupETMtkAKI8yl/JTE4yU0U5ujP6+xEuoxwc6QRDE5kwLq2fCnxMCQFqaBdHLv4xhnfkdBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7jroQRImK7HJFPSXtra+iWq0DC3T47qYc/FsxKvRNI=;
 b=OXIjAMjdL7+cOwTD5jyaoXkg3iZfyzuWKKcDmsj544QJ0DvAoyCarSqtMqXAyrQtrtdRfJlxppL3nXsemSWvMGUt8f6ji5fVK6WyAkJRx3uQudfCWxycMiiQc7OyUHtrweojmBNLMiYdnJHtiT+ep8AQqPbOW90kXJN5/yDegT03hkKI3NmyqYGRPySKlsd2GbrOxUjZMgVZFJIi/WqWtQoJ4sFXItZZc4Fv9GBECa0M76E+eZ3fNL3dkL5ooQDL3l/Cw9OYM3VuOwzBJoTU2AjTQVEvS8eArYy9hVclAW7kqJ7+Dv2C9mLVlrMQvuKuvsmk6vgkjA5J5fv8W1Vrww==
Received: from PH7PR20MB5925.namprd20.prod.outlook.com (2603:10b6:510:27f::21)
 by CY8PR20MB6252.namprd20.prod.outlook.com (2603:10b6:930:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Thu, 18 Jan
 2024 07:53:02 +0000
Received: from PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b]) by PH7PR20MB5925.namprd20.prod.outlook.com
 ([fe80::e1de:29a8:e090:5b7b%4]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 07:53:02 +0000
From: Fullway Wang <fullwaywang@outlook.com>
To: broonie@kernel.org,
	srinivas.kandagatla@linaro.org,
	bgoswami@quicinc.com,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fullwaywang@tencent.com,
	Fullway Wang <fullwaywang@outlook.com>
Subject: [PATCH] sound: soc: wcd934x: fix an incorrect use of kstrndup()
Date: Thu, 18 Jan 2024 15:52:49 +0800
Message-ID:
 <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4ggwWj3tVpKr5hS1hH76ve6+VfRaLWA4ZdRS5Bf0UzQ=]
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To PH7PR20MB5925.namprd20.prod.outlook.com
 (2603:10b6:510:27f::21)
X-Microsoft-Original-Message-ID:
 <20240118075249.45253-1-fullwaywang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB5925:EE_|CY8PR20MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: f530b032-d596-4c61-df7c-08dc17fa7f00
X-MS-Exchange-SLBlob-MailProps:
	9IecXKUgicApid5D7hNqGP6ceDGc17NycHlmEnra58VNrD1PmhQnCdkJdQNoS7CDUvfEF2wHLOuYEMJSyI4wlaVAKsAe0gnlLE1jnKaGeRyDleQZV9rvtx5vfBVVrGq/NbRfiQsX3nulv4qUDfAhFgu9N3F5Kp6Lonf/7nI0Onj0A6iWZiMlQSLYKuiVhollok8P+XmlmSdCgOFvHCu6erLuCAfDJ4CBdlS1tk6+VUpb2F1AZEY5cgvXFf0sc+AwrXAjkwTdk/f6djUskvXGSOdiGzY+PEArB4y6pWVoqBCq8lfId4zYWxi44znkOP7v7am9r191qUQP7Ay0MrqxZKvbGyNRCLV0+upQRw7cbxY9Y0kcgbui8US4gJCfe4N0ERQsCQZI+L3fykuvF2kg0SuH72kjqNUXo7d7z+uZ/ic6XGfeenuGRMSfhlVnKZ/JopoACPBc5O99r9UIqkkeFwVR1gpqmmOF8imkiNNkEYAvUS7d7dKflWOkOXMXBUYj+OKFdDJObdC9LgtmB5hz+j0r01qh74KDNN+CPX0kbEoWEyfLq9AciS/AThDXAgYLhIN4PFRL6Jc7tUXzRBauLe/cgVJcCdwcbawdAby/keDl8p0ZfCBPh3Vld/0y+eDqjaFhvZp06q1A0yvsDS/GkvBSAOfTIb96I0IvQORNY2Jm/OrEzozshZy86gVFw4RpPSELtlcMTcK1U/tSyUqI2r6jZHwBKZS3qLI/xqEtcltP8YDi2kL7dQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	apE3Necutk+5K+hlOpzsSO7j1TNARBJ+zGpvDl3D0pJt08v2hfEG9/n2jUoqqtpJwVx1PdT4kjhVGkA5HQZEM/hva3D+3yPESTxU+NUIlVXx/624MJTtpZT9FLIDfbXT0mL7yyJSTboeGQFu736gfOC9/1VU2daxynyXRHabvps0DsfMKKiPqgFwdcSchbT+/y7R2Evu2GIVwl1vu6RQuqotHSlb2VhpwJ1wDcYA3HbrvVbfgxfoRdkrQkO9E7Kh0AN7NjX+St+bRc8llZJvbANLVuon77XeAQ8wy8wafui/fqFtZaQIywQClRh/x6Kywppv3MhozJSohnpl9kH+ZXrfskOFE4dCy6iGXb030aGQ2JcPbhvNSkyupD+47+u9p86kCt80gnl76uk4YINEMAVtCWPqAYMlaDInA81yFfrgpuyMBm8EtFBVcW42PUax+Z3fRH2CbSBOArYM3jlgofXFWymwGPI9ic/cGHT+YdfR7m6lJnIA08FuiZ3s+5lfyk9GuqVndeTYrNJR9wQtomVuVkpMs2l2ldx96X1IVv2mPYMmIs91rpvn/CEIZoG0Slgx3CWqiblV1sDtiwHfNk35XB0iAv6tahLnXAMMF5dHMcjibahAPreMsg2aoiab
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dZImLqd//U3B8jjPPDUjKdEaqxIauUqfY1RoHYor0rEjydUP3oiV62bfwXyE?=
 =?us-ascii?Q?JfUydOHS7+YtQTi52kI33v/bsQWALZ8cqzAeSSozkzW0HvUwnYDNFLpd/mwI?=
 =?us-ascii?Q?jYCvL08ihS+xlwJFR1WsrCtNY4SwE/8joBY4Fxt8g3rhG4Ui7R4puedjXP8+?=
 =?us-ascii?Q?XR4h4txjmTwJCp8LQimKcGkpZ/gD/c0u5izVmNDmsu+88cFplIuimKa7mEs9?=
 =?us-ascii?Q?6Oc4PzOC9l1bum+Z2oQ6X7tW4YsKk2GKpcoVE6T9gLbpCPG1dfZmiyj1W8Ox?=
 =?us-ascii?Q?38mQ25hCioHAKam3zdePmohiYWc2Pxog4gH5Nm0zF3K33FG6kwiMZcD2B6/n?=
 =?us-ascii?Q?X4c9SfFEnWm18M25yWpdZ3BDzUsHb/T0E4/2wdHJ59yi7Z47TBBCEsDzq3qV?=
 =?us-ascii?Q?l8WPIjdZmQ6e+9RFtvm5q/fwpOcE0/0FyjLtOARng2oTo/+xaOj31xB/KKlZ?=
 =?us-ascii?Q?+xCWgJgNYj1vQQx19PMTmCw6vz/RQhaZg6iECj92oi4r6nxrdyQ1IOwpOoYE?=
 =?us-ascii?Q?yPjqHeANRf3dYeiDZKjRSyz6mEhKCOr3yIsy5UKfsYvtnuMTsfJgFtSbaknx?=
 =?us-ascii?Q?S0rw03/boF+JMywpeGveikdd9xG0+iFcR9uOFKTNY7lm8hUXLZqFPKqMddgL?=
 =?us-ascii?Q?ajPcE+9Pg6el7YMpu1xJI6HeEY5ksYRI2dtALswlPHi8Zglc9oJBN357zQkD?=
 =?us-ascii?Q?MQVxEXXePudCugRJMCUbkaNpqanD3w/Ikytj8K6Uuipwt4VbslhzTNWCRWO8?=
 =?us-ascii?Q?t/RMMpTfLi8dy61Xj5jNRAHF+U+q3dWS+gYXJGYep8+bAJmE08F5gXE92Fid?=
 =?us-ascii?Q?d6146Hz/OkUXT5gucpQwqkzgPbPAPxrF3T/OoLBZr4uJjDvBFsdAq7hfg9oe?=
 =?us-ascii?Q?e8v89AIfXfa+pHLbz66/GOvDiG1nnGIaluLPgRhOXvlBPPTAtq1agI0KsV7q?=
 =?us-ascii?Q?gj7unNu1tGIfiv9r9QfxRjkC9n2KwbS/vm+uSSnwMxlhnziMbYPx6dsixy4Z?=
 =?us-ascii?Q?UEqjIBofalLvuIomIo6v9SOcQFraCPXdXO4/g6nnPb5dCHCJQ/QDOl9fdLet?=
 =?us-ascii?Q?ADgIiGT3006EWROEL1ebwDpfSURNRQNweJONccqExJum9gsXSE4A/NUvKiD1?=
 =?us-ascii?Q?fSVLfKf0PZ5UwmKCI5GExb5jLiVD3s3eskb5indXXWWNmbDWZyenugn73Nmp?=
 =?us-ascii?Q?voSAZhMwSq/h9eofQKowxNILWGtyaMos3ZzCaE+CHTOunVipXhYUDTdO8Mw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f530b032-d596-4c61-df7c-08dc17fa7f00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB5925.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:53:02.4130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB6252

In wcd934x_codec_enable_dec(), kstrndup() is used to alloc memory.
However, kmemdup_nul() should be used instead with the size known.

This is similar to CVE-2019-12454 which was fixed in commit
a549881.

Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 1b6e376f3833..4565a0e1877f 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -4990,7 +4990,7 @@ static int wcd934x_codec_enable_dec(struct snd_soc_dapm_widget *w,
 	char *dec;
 	u8 hpf_coff_freq;
 
-	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
+	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
 	if (!widget_name)
 		return -ENOMEM;
 
-- 
2.39.3 (Apple Git-145)


