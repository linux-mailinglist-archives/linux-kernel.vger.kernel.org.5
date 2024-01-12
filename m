Return-Path: <linux-kernel+bounces-24916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD1182C4A0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04441F24B36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A3C2261C;
	Fri, 12 Jan 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OR0GINHd"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD917C87;
	Fri, 12 Jan 2024 17:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C6eAW6010272;
	Fri, 12 Jan 2024 11:21:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=J3TCSGRnd9DnWnfS+rOSPwl8wXTlbWxJiNR59khbceE=; b=
	OR0GINHd39SEt59Nux2WoWKhWSASQ9jvB27t7sO+ysdwQJu7DsyFMP0HPdaNmyDF
	X1WEaldKQSjgjTR1VB2oklM1bG2GrxD7zhSZxuSRQP+8u/4ie4HIIxuvWq/+BhF8
	C+kARahk1gR0x0ygxaChAhfeY5pLnf22bcMNVqmHsiBqidUbYKzQYPe8YXuGsNz3
	CJwjhcghGzE/xR2hc1zR0aBf15J+9ba1IZsof94jtOPTvZ0MgnkAw6PuV3jm8Ddu
	n4pF/t2lii8P2HdHIvdDzkjgX1plFVGpAkSvHZJE079Nnt3TWh35NqWZRhcpYMG0
	kgGN6tlxlQaJurPTRgOx7g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vf45prnsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 11:21:58 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 17:21:57 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 12 Jan 2024 17:21:57 +0000
Received: from LONN2DGDQ73 (LONN2DGDQ73.ad.cirrus.com [198.61.65.232])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D3E2515A0;
	Fri, 12 Jan 2024 17:21:56 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: 'Kenzo Gomez' <kenzo.sgomez@gmail.com>
CC: 'James Schulman' <james.schulman@cirrus.com>,
        'David Rhodes'
	<david.rhodes@cirrus.com>,
        'Richard Fitzgerald' <rf@opensource.cirrus.com>,
        'Jaroslav Kysela' <perex@perex.cz>, 'Takashi Iwai' <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240112163239.59743-1-kenzo.sgomez@gmail.com>
In-Reply-To: <20240112163239.59743-1-kenzo.sgomez@gmail.com>
Subject: RE: [PATCH] ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA
Date: Fri, 12 Jan 2024 17:21:56 +0000
Message-ID: <000f01da457b$d8268cf0$8873a6d0$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNavMYHpNy3oxQTxP/3AG71Wvly+63VfWQQ
Content-Language: en-gb
X-Proofpoint-GUID: dVLmaUESpk4yggWR00XD8W0QL271qo47
X-Proofpoint-ORIG-GUID: dVLmaUESpk4yggWR00XD8W0QL271qo47
X-Proofpoint-Spam-Reason: safe

Hi,

> -----Original Message-----
> From: Kenzo Gomez <kenzo.sgomez@gmail.com>
> Sent: Friday, January 12, 2024 4:32 PM
> To: sbinding@opensource.cirrus.com
> Cc: Kenzo Gomez <kenzo.sgomez@gmail.com>; James Schulman
> <james.schulman@cirrus.com>; David Rhodes
> <david.rhodes@cirrus.com>; Richard Fitzgerald
> <rf@opensource.cirrus.com>; Jaroslav Kysela <perex@perex.cz>;
Takashi
> Iwai <tiwai@suse.com>; alsa-devel@alsa-project.org;
> patches@opensource.cirrus.com; linux-sound@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] ALSA: hda: cs35l41: Support additional ASUS Zenbook
> UX3402VA
> 
> Add new model entry into configuration table.
> 
> Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>
> ---
>  sound/pci/hda/cs35l41_hda_property.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/cs35l41_hda_property.c
> b/sound/pci/hda/cs35l41_hda_property.c
> index c1afb721b4c6..adfb31a6bf1e 100644
> --- a/sound/pci/hda/cs35l41_hda_property.c
> +++ b/sound/pci/hda/cs35l41_hda_property.c
> @@ -67,6 +67,7 @@ static const struct cs35l41_config
> cs35l41_config_table[] = {
>  	{ "10431D1F", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT,
> 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431DA2", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT,
> 0, 0 }, 1, 2, 0, 0, 0, 0 },
>  	{ "10431E02", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT,
> 0, 0 }, 1, 2, 0, 0, 0, 0 },
> +	{ "104316A3", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT,
> 0, 0 }, 1, 2, 0, 0, 0, 0 },

This entry looks correct, but this table is supposed to be sorted by
SSID,
can you move the entry to its correct location?

>  	{ "10431EE2", I2C, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT,
> 0, 0 }, 0, -1, -1, 0, 0, 0 },
>  	{ "10431F12", I2C, 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT,
> 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
>  	{ "10431F1F", SPI, 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT,
> 0, 0 }, 1, -1, 0, 0, 0, 0 },
> @@ -371,6 +372,7 @@ static const struct cs35l41_prop_model
> cs35l41_prop_model_table[] = {
>  	{ "CSC3551", "10431D1F", generic_dsd_config },
>  	{ "CSC3551", "10431DA2", generic_dsd_config },
>  	{ "CSC3551", "10431E02", generic_dsd_config },
> +	{ "CSC3551", "104316A3", generic_dsd_config },

Same with this table, it should be sorted by SSID.

>  	{ "CSC3551", "10431EE2", generic_dsd_config },
>  	{ "CSC3551", "10431F12", generic_dsd_config },
>  	{ "CSC3551", "10431F1F", generic_dsd_config },
> --
> 2.43.0
> 

Thanks,
Stefan


