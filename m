Return-Path: <linux-kernel+bounces-149937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D419B8A9809
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F571F224CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0315E20B;
	Thu, 18 Apr 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EsgIvVEN"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2358E15E1EE;
	Thu, 18 Apr 2024 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437966; cv=none; b=uUDNdTm13uvkiZqSRw4iUjBJh9424iy8zWJ7Hmd5SwBDAskIwQivG0MJx4Y/oZUq+FDR+E9VWWWA/6UPZ1j9TDkCAsd/Xz49YZFCJpRgxmVef5hmKutnoLFzkkyDy8yHcxKT+jsnTsuP8KwxBGjF7eXC0doTUaRCQ8Zo95wWYTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437966; c=relaxed/simple;
	bh=Dmw2mzRePDDaTlpv0cyxsROjXNG2sIARTqcRZ94iPag=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHZLlOArs3KxIbn2k/PGtKPDfJPI4Yoa7Q77XSv6J0neVOACiC7kykpvNC8JWJPAIHj/7A/KF43VYaK/hHT20vxV3GznNV7Y9FTLzbIuzMYI7WaGWzDRmpliy80hxT1yjWc2gjoLiu074FNe5beGZ1r9TVFL1fzCkuUw/POwbNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EsgIvVEN; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43I7MKuD021498;
	Thu, 18 Apr 2024 05:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=RlY3ymPRlrecGeYIf3u9yTqQFB6fZZei6Z2kUrb0t0k=; b=
	EsgIvVENbI5fwPQNQDDWrnF2zv15un8Qa81c955laK2qpLYdYRZ8kzMxEQDbZ+m0
	BAy9kUU5T0YG7H+qEUeHz1ook4QeXsx+5Cx9zBYM/4EG9tHTfV7l6jdX995SMIGr
	E5x53e4HfGn2uPHjz47E7BGllRK+pFsZmTBKwWo51Itj2Piqlv+EKD99b2kGmq7K
	Ekkts8qKHUvDuhnK6OElr4sLEQKV0L6bG7k7ouFBuQ3emRlIhhRECEt7PbJtqTxV
	0Q2GoVt5S23lCE4Qsw5B9j90rsxuy52W2BfhQVvHvOjSBKgFVD3AEm5VC7CalgkJ
	sJUnN9fIkpaQccBJyfNg7A==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xfpfhvnad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 05:59:21 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 18 Apr
 2024 11:59:19 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 18 Apr 2024 11:59:19 +0100
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.64.201])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 36044820245;
	Thu, 18 Apr 2024 10:59:19 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'ArcticLampyrid' <ArcticLampyrid@outlook.com>, <james.schulman@cirrus.com>,
        <david.rhodes@cirrus.com>, <rf@opensource.cirrus.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM> <TYCP286MB25358BF2246DE04CE8D12BE8C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYCP286MB25358BF2246DE04CE8D12BE8C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Subject: RE: [PATCH v2 2/2] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 11:59:19 +0100
Message-ID: <002201da917f$766278d0$63276a70$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQJzUjqa4IlF22ZsXxMyjNS9IQLhdQGIbEcssDAWyjA=
X-Proofpoint-ORIG-GUID: 6cGaL1IhxL8DSA0rTQRDX4c1sl7LL6Q3
X-Proofpoint-GUID: 6cGaL1IhxL8DSA0rTQRDX4c1sl7LL6Q3
X-Proofpoint-Spam-Reason: safe

Hi,

> -----Original Message-----
> From: ArcticLampyrid <ArcticLampyrid@outlook.com>
> Sent: Thursday, April 18, 2024 7:46 AM
> To: james.schulman@cirrus.com; david.rhodes@cirrus.com;
> rf@opensource.cirrus.com
> Cc: patches@opensource.cirrus.com; linux-sound@vger.kernel.org;
linux-
> kernel@vger.kernel.org; ArcticLampyrid <ArcticLampyrid@outlook.com>;
> stable@vger.kernel.org
> Subject: [PATCH v2 2/2] ALSA: hda/realtek: Fix internal speakers for
Legion
> Y9000X 2022 IAH7
> 
> This fixes the sound not working from internal speakers on
> Lenovo Legion Y9000X 2022 IAH7 models.
> 
> Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
> Cc: <stable@vger.kernel.org>
> ---
>  sound/pci/hda/cs35l41_hda_property.c | 2 ++
>  sound/pci/hda/patch_realtek.c        | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c
> b/sound/pci/hda/cs35l41_hda_property.c
> index 8fb688e41414..60ad2344488b 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -109,6 +109,7 @@ static const struct cs35l41_config
> cs35l41_config_table[] = {
>  	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 1, -1, 0, 0, 0, 0 },
>  	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 1, 2, 0, 0, 0, 0 },
>  	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 1, 2, 0, 1000, 4500, 24 },
> +	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, 1, -1, 0, 0, 0 },

Looking at your ACPI, its clear that the Speaker ID is at index 2 not
index 1.
Thus, this should be:

	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
}, 0, 2, -1, 0, 0, 0 },

Thanks,
Stefan

>  	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, -1, -1, 0, 0, 0 },
>  	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, 1, -1, 0, 0, 0 },
>  	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0
> }, 0, 1, -1, 0, 0, 0 },
> @@ -500,6 +501,7 @@ static const struct cs35l41_prop_model
> cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "10431F1F", generic_dsd_config },
>  	{ "CSC3551", "10431F62", generic_dsd_config },
>  	{ "CSC3551", "10433A60", generic_dsd_config },
> +	{ "CSC3551", "17AA386E", generic_dsd_config },
>  	{ "CSC3551", "17AA386F", generic_dsd_config },
>  	{ "CSC3551", "17AA3877", generic_dsd_config },
>  	{ "CSC3551", "17AA3878", generic_dsd_config },
> diff --git a/sound/pci/hda/patch_realtek.c
> b/sound/pci/hda/patch_realtek.c
> index cdcb28aa9d7b..ac729187f6a7 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -10382,6 +10382,7 @@ static const struct snd_pci_quirk
> alc269_fixup_tbl[] = {
>  	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5",
> ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
>  	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6",
> ALC287_FIXUP_LEGION_16ITHG6),
>  	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7",
> ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
> +	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7",
> ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7",
> ALC287_FIXUP_CS35L41_I2C_2),
>  	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7",
> ALC287_FIXUP_YOGA7_14ARB7_I2C),
>  	SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim
> 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
> --
> 2.44.0
> 



